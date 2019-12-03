Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8728210FC90
	for <lists+cgroups@lfdr.de>; Tue,  3 Dec 2019 12:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbfLCLjg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Dec 2019 06:39:36 -0500
Received: from relay.sw.ru ([185.231.240.75]:56058 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbfLCLjg (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 3 Dec 2019 06:39:36 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1ic6W4-0006fj-Kd; Tue, 03 Dec 2019 14:38:52 +0300
Subject: Re: [PATCH] mm: fix hanging shrinker management on long
 do_shrink_slab
To:     Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
References: <20191129214541.3110-1-ptikhomirov@virtuozzo.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <8717b035-e082-992b-d9b1-4b4887ef596b@virtuozzo.com>
Date:   Tue, 3 Dec 2019 14:38:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191129214541.3110-1-ptikhomirov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 30.11.2019 00:45, Pavel Tikhomirov wrote:
> We have a problem that shrinker_rwsem can be held for a long time for
> read in shrink_slab, at the same time any process which is trying to
> manage shrinkers hangs.
> 
> The shrinker_rwsem is taken in shrink_slab while traversing shrinker_list.
> It tries to shrink something on nfs (hard) but nfs server is dead at
> these moment already and rpc will never succeed. Generally any shrinker
> can take significant time to do_shrink_slab, so it's a bad idea to hold
> the list lock here.
> 
> We have a similar problem in shrink_slab_memcg, except that we are
> traversing shrinker_map+shrinker_idr there.
> 
> The idea of the patch is to inc a refcount to the chosen shrinker so it
> won't disappear and release shrinker_rwsem while we are in
> do_shrink_slab, after that we will reacquire shrinker_rwsem, dec
> the refcount and continue the traversal.
> 
> We also need a wait_queue so that unregister_shrinker can wait for the
> refcnt to become zero. Only after these we can safely remove the
> shrinker from list and idr, and free the shrinker.
> 
> I've reproduced the nfs hang in do_shrink_slab with the patch applied on
> ms kernel, all other mount/unmount pass fine without any hang.
> 
> Here is a reproduction on kernel without patch:
> 
> 1) Setup nfs on server node with some files in it (e.g. 200)
> 
> [server]# cat /etc/exports
> /vz/nfs2 *(ro,no_root_squash,no_subtree_check,async)
> 
> 2) Hard mount it on client node
> 
> [client]# mount -ohard 10.94.3.40:/vz/nfs2 /mnt
> 
> 3) Open some (e.g. 200) files on the mount
> 
> [client]# for i in $(find /mnt/ -type f | head -n 200); \
>   do setsid sleep 1000 &>/dev/null <$i & done
> 
> 4) Kill all openers
> 
> [client]# killall sleep -9
> 
> 5) Put your network cable out on client node
> 
> 6) Drop caches on the client, it will hang on nfs while holding
>   shrinker_rwsem lock for read
> 
> [client]# echo 3 > /proc/sys/vm/drop_caches
> 
>   crash> bt ...
>   PID: 18739  TASK: ...  CPU: 3   COMMAND: "bash"
>    #0 [...] __schedule at ...
>    #1 [...] schedule at ...
>    #2 [...] rpc_wait_bit_killable at ... [sunrpc]
>    #3 [...] __wait_on_bit at ...
>    #4 [...] out_of_line_wait_on_bit at ...
>    #5 [...] _nfs4_proc_delegreturn at ... [nfsv4]
>    #6 [...] nfs4_proc_delegreturn at ... [nfsv4]
>    #7 [...] nfs_do_return_delegation at ... [nfsv4]
>    #8 [...] nfs4_evict_inode at ... [nfsv4]
>    #9 [...] evict at ...
>   #10 [...] dispose_list at ...
>   #11 [...] prune_icache_sb at ...
>   #12 [...] super_cache_scan at ...
>   #13 [...] do_shrink_slab at ...
>   #14 [...] shrink_slab at ...
>   #15 [...] drop_slab_node at ...
>   #16 [...] drop_slab at ...
>   #17 [...] drop_caches_sysctl_handler at ...
>   #18 [...] proc_sys_call_handler at ...
>   #19 [...] vfs_write at ...
>   #20 [...] ksys_write at ...
>   #21 [...] do_syscall_64 at ...
>   #22 [...] entry_SYSCALL_64_after_hwframe at ...
> 
> 7) All other mount/umount activity now hangs with no luck to take
>   shrinker_rwsem for write.
> 
> [client]# mount -t tmpfs tmpfs /tmp
> 
>   crash> bt ...
>   PID: 5464   TASK: ...  CPU: 3   COMMAND: "mount"
>    #0 [...] __schedule at ...
>    #1 [...] schedule at ...
>    #2 [...] rwsem_down_write_slowpath at ...
>    #3 [...] prealloc_shrinker at ...
>    #4 [...] alloc_super at ...
>    #5 [...] sget at ...
>    #6 [...] mount_nodev at ...
>    #7 [...] legacy_get_tree at ...
>    #8 [...] vfs_get_tree at ...
>    #9 [...] do_mount at ...
>   #10 [...] ksys_mount at ...
>   #11 [...] __x64_sys_mount at ...
>   #12 [...] do_syscall_64 at ...
>   #13 [...] entry_SYSCALL_64_after_hwframe at ...
> 
> That is on almost clean and almost mainstream Fedora kernel:
> 
> [client]# uname -a
> Linux snorch 5.3.8-200.snorch.fc30.x86_64 #1 SMP Mon Nov 11 16:01:15 MSK
>   2019 x86_64 x86_64 x86_64 GNU/Linux
> 
> Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>

The approach looks OK for me, and despite it does not solve the problem
completely, it improves the isolation. Also, we may use this to finally
make shrink_slab() iterations lockless (or you may just send couple of
patches on top of that :).

Small cosmetic note. I'd removed comments in prealloc_shrinker() and
free_preallocated_shrinker() since they just describe obvious actions,
and we do not need to comment every line we do. But a small comment
is needed about that synchronize_rcu() is to make wake_up on stable
memory.

> ---
>  include/linux/memcontrol.h |   6 +++
>  include/linux/shrinker.h   |   6 +++
>  mm/memcontrol.c            |  16 ++++++
>  mm/vmscan.c                | 107 ++++++++++++++++++++++++++++++++++++-
>  4 files changed, 134 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index ae703ea3ef48..3717b94b6aa5 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1348,6 +1348,8 @@ extern int memcg_expand_shrinker_maps(int new_id);
>  
>  extern void memcg_set_shrinker_bit(struct mem_cgroup *memcg,
>  				   int nid, int shrinker_id);
> +extern void memcg_clear_shrinker_bit(struct mem_cgroup *memcg,
> +				     int nid, int shrinker_id);
>  #else
>  #define mem_cgroup_sockets_enabled 0
>  static inline void mem_cgroup_sk_alloc(struct sock *sk) { };
> @@ -1361,6 +1363,10 @@ static inline void memcg_set_shrinker_bit(struct mem_cgroup *memcg,
>  					  int nid, int shrinker_id)
>  {
>  }
> +static inline void memcg_clear_shrinker_bit(struct mem_cgroup *memcg,
> +					    int nid, int shrinker_id)
> +{
> +}
>  #endif
>  
>  struct kmem_cache *memcg_kmem_get_cache(struct kmem_cache *cachep);
> diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
> index 0f80123650e2..dd3bb43ed58d 100644
> --- a/include/linux/shrinker.h
> +++ b/include/linux/shrinker.h
> @@ -2,6 +2,9 @@
>  #ifndef _LINUX_SHRINKER_H
>  #define _LINUX_SHRINKER_H
>  
> +#include <linux/refcount.h>
> +#include <linux/wait.h>
> +
>  /*
>   * This struct is used to pass information from page reclaim to the shrinkers.
>   * We consolidate the values for easier extention later.
> @@ -75,6 +78,9 @@ struct shrinker {
>  #endif
>  	/* objs pending delete, per node */
>  	atomic_long_t *nr_deferred;
> +
> +	refcount_t refcnt;
> +	wait_queue_head_t wq;
>  };
>  #define DEFAULT_SEEKS 2 /* A good number if you don't know better. */
>  
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 01f3f8b665e9..81f45124feb7 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -442,6 +442,22 @@ void memcg_set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
>  	}
>  }
>  
> +void memcg_clear_shrinker_bit(struct mem_cgroup *memcg,
> +			      int nid, int shrinker_id)
> +{
> +	struct memcg_shrinker_map *map;
> +
> +	/*
> +	 * The map for refcounted memcg can only be freed in
> +	 * memcg_free_shrinker_map_rcu so we can safely protect
> +	 * map with rcu_read_lock.
> +	 */
> +	rcu_read_lock();
> +	map = rcu_dereference(memcg->nodeinfo[nid]->shrinker_map);
> +	clear_bit(shrinker_id, map->map);
> +	rcu_read_unlock();
> +}
> +
>  /**
>   * mem_cgroup_css_from_page - css of the memcg associated with a page
>   * @page: page of interest
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index ee4eecc7e1c2..59e46d65e902 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -393,6 +393,13 @@ int prealloc_shrinker(struct shrinker *shrinker)
>  	if (!shrinker->nr_deferred)
>  		return -ENOMEM;
>  
> +	/*
> +	 * Shrinker is not yet visible through shrinker_idr or shrinker_list,
> +	 * so no locks required for initialization.
> +	 */
> +	refcount_set(&shrinker->refcnt, 1);
> +	init_waitqueue_head(&shrinker->wq);
> +
>  	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
>  		if (prealloc_memcg_shrinker(shrinker))
>  			goto free_deferred;
> @@ -411,6 +418,9 @@ void free_prealloced_shrinker(struct shrinker *shrinker)
>  	if (!shrinker->nr_deferred)
>  		return;
>  
> +	/* The shrinker shouldn't be used at these point. */
> +	WARN_ON(!refcount_dec_and_test(&shrinker->refcnt));
> +
>  	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
>  		unregister_memcg_shrinker(shrinker);
>  
> @@ -447,6 +457,15 @@ void unregister_shrinker(struct shrinker *shrinker)
>  {
>  	if (!shrinker->nr_deferred)
>  		return;
> +
> +	/*
> +	 * If refcnt is not zero we need to wait these shrinker to finish all
> +	 * it's do_shrink_slab() calls.
> +	 */
> +	if (!refcount_dec_and_test(&shrinker->refcnt))
> +		wait_event(shrinker->wq,
> +			   (refcount_read(&shrinker->refcnt) == 0));
> +
>  	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
>  		unregister_memcg_shrinker(shrinker);
>  	down_write(&shrinker_rwsem);
> @@ -454,6 +473,9 @@ void unregister_shrinker(struct shrinker *shrinker)
>  	up_write(&shrinker_rwsem);
>  	kfree(shrinker->nr_deferred);
>  	shrinker->nr_deferred = NULL;
> +
> +	/* Pairs with rcu_read_lock in put_shrinker() */
> +	synchronize_rcu();
>  }
>  EXPORT_SYMBOL(unregister_shrinker);
>  
> @@ -589,6 +611,42 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
>  	return freed;
>  }
>  
> +struct shrinker *get_shrinker(struct shrinker *shrinker)
> +{
> +	/*
> +	 * Pairs with refcnt dec in unregister_shrinker(), if refcnt is zero
> +	 * these shrinker is already in the middle of unregister_shrinker() and
> +	 * we can't use it.
> +	 */
> +	if (!refcount_inc_not_zero(&shrinker->refcnt))
> +		shrinker = NULL;
> +	return shrinker;
> +}
> +
> +void put_shrinker(struct shrinker *shrinker)
> +{
> +	/*
> +	 * The rcu_read_lock pairs with synchronize_rcu() in
> +	 * unregister_shrinker(), so that the shrinker is not freed
> +	 * before the wake_up.
> +	 */
> +	rcu_read_lock();
> +	if (!refcount_dec_and_test(&shrinker->refcnt)) {
> +		/*
> +		 * Pairs with smp_mb in
> +		 * wait_event()->prepare_to_wait()
> +		 */
> +		smp_mb();
> +		/*
> +		 * If refcnt becomes zero, we already have an
> +		 * unregister_shrinker() waiting for us to finish.
> +		 */
> +		if (waitqueue_active(&shrinker->wq))
> +			wake_up(&shrinker->wq);
> +	}
> +	rcu_read_unlock();
> +}
> +
>  #ifdef CONFIG_MEMCG
>  static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>  			struct mem_cgroup *memcg, int priority)
> @@ -628,9 +686,23 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>  		    !(shrinker->flags & SHRINKER_NONSLAB))
>  			continue;
>  
> +		/*
> +		 * Take a refcnt on a shrinker so that it can't be freed or
> +		 * removed from shrinker_idr (and shrinker_list). These way we
> +		 * can safely release shrinker_rwsem.
> +		 *
> +		 * We need to release shrinker_rwsem here as do_shrink_slab can
> +		 * take too much time to finish (e.g. on nfs). And holding
> +		 * global shrinker_rwsem can block registring and unregistring
> +		 * of shrinkers.
> +		 */
> +		if (!get_shrinker(shrinker))
> +			continue;
> +		up_read(&shrinker_rwsem);
> +
>  		ret = do_shrink_slab(&sc, shrinker, priority);
>  		if (ret == SHRINK_EMPTY) {
> -			clear_bit(i, map->map);
> +			memcg_clear_shrinker_bit(memcg, nid, i);
>  			/*
>  			 * After the shrinker reported that it had no objects to
>  			 * free, but before we cleared the corresponding bit in
> @@ -655,6 +727,22 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>  		}
>  		freed += ret;
>  
> +		/*
> +		 * Re-aquire shrinker_rwsem, put refcount and reload
> +		 * shrinker_map as it can be modified in
> +		 * memcg_expand_one_shrinker_map if new shrinkers
> +		 * were registred in the meanwhile.
> +		 */
> +		if (!down_read_trylock(&shrinker_rwsem)) {
> +			freed = freed ? : 1;
> +			put_shrinker(shrinker);
> +			return freed;
> +		}
> +		put_shrinker(shrinker);
> +		map = rcu_dereference_protected(
> +				memcg->nodeinfo[nid]->shrinker_map,
> +				true);
> +
>  		if (rwsem_is_contended(&shrinker_rwsem)) {
>  			freed = freed ? : 1;
>  			break;
> @@ -719,10 +807,27 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>  			.memcg = memcg,
>  		};
>  
> +		/* See comment in shrink_slab_memcg. */
> +		if (!get_shrinker(shrinker))
> +			continue;
> +		up_read(&shrinker_rwsem);
> +
>  		ret = do_shrink_slab(&sc, shrinker, priority);
>  		if (ret == SHRINK_EMPTY)
>  			ret = 0;
>  		freed += ret;
> +
> +		/*
> +		 * We can safely continue traverse of the shrinker_list as
> +		 * our shrinker is still on the list due to refcount.
> +		 */
> +		if (!down_read_trylock(&shrinker_rwsem)) {
> +			freed = freed ? : 1;
> +			put_shrinker(shrinker);
> +			goto out;
> +		}
> +		put_shrinker(shrinker);
> +
>  		/*
>  		 * Bail out if someone want to register a new shrinker to
>  		 * prevent the regsitration from being stalled for long periods
> 

