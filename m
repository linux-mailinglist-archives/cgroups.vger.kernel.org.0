Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F4E4087FB
	for <lists+cgroups@lfdr.de>; Mon, 13 Sep 2021 11:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238162AbhIMJRM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Sep 2021 05:17:12 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47750 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238002AbhIMJRM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Sep 2021 05:17:12 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C689021EF8;
        Mon, 13 Sep 2021 09:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631524555; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7j2IQeXEFHSo/X0Y8lW6RryJXyvGXf9ANntxTqON5Dg=;
        b=b6zIAugpmst/ZUrISLQASo52Ng8Pi4YNbo3izXgtBwdqxGOzSFVfuFv1mhaYWTWPzJpgpU
        +0K+7rdGPEORimg8BHy951hf5ctYkkKLkvYfgk1bPwO3AfjYRMds7F9uy1dH+l8Rd/wsw/
        6ZYpSG1OBNwsw7OfF3WgEpirnaaLRqs=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D7863A3B9E;
        Mon, 13 Sep 2021 09:15:54 +0000 (UTC)
Date:   Mon, 13 Sep 2021 11:15:54 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/page_alloc: detect allocation forbidden by cpuset
 and bail out early
Message-ID: <YT8WygPhuORJC6Pn@dhcp22.suse.cz>
References: <1631518709-42881-1-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1631518709-42881-1-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 13-09-21 15:38:29, Feng Tang wrote:
> There was report that starting an Ubuntu in docker while using cpuset
> to bind it to movable nodes (a node only has movable zone, like a node
> for hotplug or a Persistent Memory  node in normal usage) will fail
> due to memory allocation failure, and then OOM is involved and many
> other innocent processes got killed. It can be reproduced with command:
> $docker run -it --rm  --cpuset-mems 4 ubuntu:latest bash -c
> "grep Mems_allowed /proc/self/status" (node 4 is a movable node)
> 
>   
>   runc:[2:INIT] invoked oom-killer: gfp_mask=0x500cc2(GFP_HIGHUSER|__GFP_ACCOUNT), order=0, oom_score_adj=0
>   CPU: 8 PID: 8291 Comm: runc:[2:INIT] Tainted: G        W I E     5.8.2-0.g71b519a-default #1 openSUSE Tumbleweed (unreleased)
>   Hardware name: Dell Inc. PowerEdge R640/0PHYDR, BIOS 2.6.4 04/09/2020
>   Call Trace:
>    dump_stack+0x6b/0x88
>    dump_header+0x4a/0x1e2
>    oom_kill_process.cold+0xb/0x10
>    out_of_memory.part.0+0xaf/0x230
>    out_of_memory+0x3d/0x80
>    __alloc_pages_slowpath.constprop.0+0x954/0xa20
>    __alloc_pages_nodemask+0x2d3/0x300
>    pipe_write+0x322/0x590
>    new_sync_write+0x196/0x1b0
>    vfs_write+0x1c3/0x1f0
>    ksys_write+0xa7/0xe0
>    do_syscall_64+0x52/0xd0
>    entry_SYSCALL_64_after_hwframe+0x44/0xa9
>   
>   Mem-Info:
>   active_anon:392832 inactive_anon:182 isolated_anon:0
>    active_file:68130 inactive_file:151527 isolated_file:0
>    unevictable:2701 dirty:0 writeback:7
>    slab_reclaimable:51418 slab_unreclaimable:116300
>    mapped:45825 shmem:735 pagetables:2540 bounce:0
>    free:159849484 free_pcp:73 free_cma:0
>   Node 4 active_anon:1448kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:0kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB all_unreclaimable? no
>   Node 4 Movable free:130021408kB min:9140kB low:139160kB high:269180kB reserved_highatomic:0KB active_anon:1448kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:130023424kB managed:130023424kB mlocked:0kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:292kB local_pcp:84kB free_cma:0kB
>   lowmem_reserve[]: 0 0 0 0 0
>   Node 4 Movable: 1*4kB (M) 0*8kB 0*16kB 1*32kB (M) 0*64kB 0*128kB 1*256kB (M) 1*512kB (M) 1*1024kB (M) 0*2048kB 31743*4096kB (M) = 130021156kB
>   
>   oom-kill:constraint=CONSTRAINT_CPUSET,nodemask=(null),cpuset=docker-9976a269caec812c134fa317f27487ee36e1129beba7278a463dd53e5fb9997b.scope,mems_allowed=4,global_oom,task_memcg=/system.slice/containerd.service,task=containerd,pid=4100,uid=0
>   Out of memory: Killed process 4100 (containerd) total-vm:4077036kB, anon-rss:51184kB, file-rss:26016kB, shmem-rss:0kB, UID:0 pgtables:676kB oom_score_adj:0
>   oom_reaper: reaped process 8248 (docker), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
>   oom_reaper: reaped process 2054 (node_exporter), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
>   oom_reaper: reaped process 1452 (systemd-journal), now anon-rss:0kB, file-rss:8564kB, shmem-rss:4kB
>   oom_reaper: reaped process 2146 (munin-node), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
>   oom_reaper: reaped process 8291 (runc:[2:INIT]), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
> 
> 
> The reason is, in the case, the target cpuset nodes only have movable
> zone, while the creation of an OS in docker sometimes needs to allocate
> memory in non-movable zones (dma/dma32/normal) like GFP_HIGHUSER, and
> the cpuset limit forbids the allocation, then out-of-memory killing is
> involved even when normal nodes and movable nodes both have many free
> memory.
> 
> The OOM killer cannot help to resolve the situation as there is no
> usable memory for the request in the cpuset scope. The only reasonable
> measure to take is to fail the allocation right away and have the caller
> to deal with it. 
> 
> So add a check for cases like this in the slowpath of allocation, and
> bail out early returning NULL for the allocation.
> 
> As page allocation is one of the hottest path in kernel, this check
> will hurt all users with sane cpuset configuration, add a static branch
> check and detect the abnormal config in cpuset memory binding setup so
> that the extra check in page allocation is not paid by everyone.  
> 
> [thanks to Micho Hocko and David Rientjes for suggesting not handle
>  it inside OOM code, adding cpuset check, refining comments]
> 
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
> Changelog:
>  
>   v2:
>   * add a static branch detection in cpuset code to reduce
>     the overhead in allocation hotpath (Michal Hocko)
> 
>   v1 (since RFC):
>   * move the handling from oom code to page allocation 
>     path (Michal/David)
> 
>  include/linux/cpuset.h | 15 +++++++++++++++
>  include/linux/mmzone.h | 12 ++++++++++++
>  kernel/cgroup/cpuset.c | 14 ++++++++++++++
>  mm/page_alloc.c        | 13 +++++++++++++
>  4 files changed, 54 insertions(+)
> 
> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> index d2b9c41..403ccf9 100644
> --- a/include/linux/cpuset.h
> +++ b/include/linux/cpuset.h
> @@ -34,6 +34,8 @@
>   */
>  extern struct static_key_false cpusets_pre_enable_key;
>  extern struct static_key_false cpusets_enabled_key;
> +extern struct static_key_false cpusets_insane_config_key;
> +
>  static inline bool cpusets_enabled(void)
>  {
>  	return static_branch_unlikely(&cpusets_enabled_key);
> @@ -51,6 +53,19 @@ static inline void cpuset_dec(void)
>  	static_branch_dec_cpuslocked(&cpusets_pre_enable_key);
>  }
>  
> +/*
> + * This will get enabled whenever a cpuset configuration is considered
> + * unsupportable in general. E.g. movable only node which cannot satisfy
> + * any non movable allocations (see update_nodemask). Page allocator
> + * needs to make additional checks for those configurations and this
> + * check is meant to guard those checks without any overhead for sane
> + * configurations.
> + */
> +static inline bool cpusets_insane_config(void)
> +{
> +	return static_branch_unlikely(&cpusets_insane_config_key);
> +}
> +
>  extern int cpuset_init(void);
>  extern void cpuset_init_smp(void);
>  extern void cpuset_force_rebuild(void);
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 6a1d79d..b69b871 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1220,6 +1220,18 @@ static inline struct zoneref *first_zones_zonelist(struct zonelist *zonelist,
>  #define for_each_zone_zonelist(zone, z, zlist, highidx) \
>  	for_each_zone_zonelist_nodemask(zone, z, zlist, highidx, NULL)
>  
> +/* Whether the 'nodes' are all movable nodes */
> +static inline bool movable_only_nodes(nodemask_t *nodes)
> +{
> +	struct zonelist *zonelist;
> +	struct zoneref *z;
> +
> +	zonelist = &(first_online_pgdat())->node_zonelists[ZONELIST_FALLBACK];

This will work but it just begs a question why you haven't chosen a node
from the given nodemask. So I believe it would be easier to read if you
did
	zonelist = NODE_DATA(first_node(nodes))->node_zonelists[ZONELIST_FALLBACK]

> +	z = first_zones_zonelist(zonelist, ZONE_NORMAL,	nodes);
> +	return (!z->zone) ? true : false;
> +}
> +
> +
>  #ifdef CONFIG_SPARSEMEM
>  #include <asm/sparsemem.h>
>  #endif
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index df1ccf4..03eb40c 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -69,6 +69,13 @@
>  DEFINE_STATIC_KEY_FALSE(cpusets_pre_enable_key);
>  DEFINE_STATIC_KEY_FALSE(cpusets_enabled_key);
>  
> +/*
> + * There could be abnormal cpuset configurations for cpu or memory
> + * node binding, add this key to provide a quick low-cost judgement
> + * of the situation.
> + */
> +DEFINE_STATIC_KEY_FALSE(cpusets_insane_config_key);
> +
>  /* See "Frequency meter" comments, below. */
>  
>  struct fmeter {
> @@ -1868,6 +1875,13 @@ static int update_nodemask(struct cpuset *cs, struct cpuset *trialcs,
>  	if (retval < 0)
>  		goto done;
>  
> +	if (movable_only_nodes(&trialcs->mems_allowed)) {

You can skip the check if cpusets_insane_config(). The question is
whether you want to report all potential users or only the first one.

> +		static_branch_enable(&cpusets_insane_config_key);
> +		pr_info("Unsupported (movable nodes only) cpuset configuration detected (nmask=%*pbl)! "
> +			"Cpuset allocations might fail even with a lot of memory available.\n",
> +			nodemask_pr_args(&trialcs->mems_allowed));
> +	}
> +
>  	spin_lock_irq(&callback_lock);
>  	cs->mems_allowed = trialcs->mems_allowed;
>  	spin_unlock_irq(&callback_lock);
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index b37435c..a7e0854 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4914,6 +4914,19 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  	if (!ac->preferred_zoneref->zone)
>  		goto nopage;
>  
> +	/*
> +	 * Check for insane configurations where the cpuset doesn't contain
> +	 * any suitable zone to satisfy the request - e.g. non-movable
> +	 * GFP_HIGHUSER allocations from MOVABLE nodes only.
> +	 */
> +	if (cpusets_insane_config() && (gfp_mask & __GFP_HARDWALL)) {
> +		struct zoneref *z = first_zones_zonelist(ac->zonelist,
> +					ac->highest_zoneidx,
> +					&cpuset_current_mems_allowed);
> +		if (!z->zone)
> +			goto nopage;
> +	}
> +
>  	if (alloc_flags & ALLOC_KSWAPD)
>  		wake_all_kswapds(order, gfp_mask, ac);

The rest looks sensible to me.
-- 
Michal Hocko
SUSE Labs
