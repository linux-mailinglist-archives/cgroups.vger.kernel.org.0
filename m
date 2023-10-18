Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2737B7CD893
	for <lists+cgroups@lfdr.de>; Wed, 18 Oct 2023 11:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjJRJwd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 Oct 2023 05:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjJRJwc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 Oct 2023 05:52:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F25B0;
        Wed, 18 Oct 2023 02:52:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7611221855;
        Wed, 18 Oct 2023 09:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1697622748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MP/5D96ZpJ3W3396Dnkowli5D0mm+jI2fuulfFVaRH4=;
        b=HWdnzJipDJW47U8wwqs1mO8VBtEZtLc2FZuVAvu5q3/M6Xrf/fZiffvPfVNezbOD61rzB0
        WPV5KXVtanD8ggDDL1GqeL3D+8dOa4idhgQROPeguBYugRGJ3cU/VfiBv3SqwN7f/hPLv0
        PmITPPW5VcJhEOcLN5a8CGb9clGIo4Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1697622748;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MP/5D96ZpJ3W3396Dnkowli5D0mm+jI2fuulfFVaRH4=;
        b=jO5ls5UPDrSlQqt/aZlxP9bj0hL9rzQ5gpUAOJuumBwpibl2zQfZxkskTonAAmco5uHeFo
        uL4h5WTgkS3uA9BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 482E913915;
        Wed, 18 Oct 2023 09:52:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VxjJENyqL2W/OQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 18 Oct 2023 09:52:28 +0000
Message-ID: <d698b8d0-1697-e336-bccb-592e633e8b98@suse.cz>
Date:   Wed, 18 Oct 2023 11:52:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 2/5] mm: kmem: add direct objcg pointer to task_struct
To:     Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, shakeelb@google.com,
        Muchun Song <muchun.song@linux.dev>,
        Dennis Zhou <dennis@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
References: <20231016221900.4031141-1-roman.gushchin@linux.dev>
 <20231016221900.4031141-3-roman.gushchin@linux.dev>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20231016221900.4031141-3-roman.gushchin@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -7.10
X-Spamd-Result: default: False [-7.10 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_SEVEN(0.00)[11];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 10/17/23 00:18, Roman Gushchin wrote:
> To charge a freshly allocated kernel object to a memory cgroup, the
> kernel needs to obtain an objcg pointer. Currently it does it
> indirectly by obtaining the memcg pointer first and then calling to
> __get_obj_cgroup_from_memcg().
> 
> Usually tasks spend their entire life belonging to the same object
> cgroup. So it makes sense to save the objcg pointer on task_struct
> directly, so it can be obtained faster. It requires some work on fork,
> exit and cgroup migrate paths, but these paths are way colder.
> 
> To avoid any costly synchronization the following rules are applied:
> 1) A task sets it's objcg pointer itself.
> 
> 2) If a task is being migrated to another cgroup, the least
>    significant bit of the objcg pointer is set atomically.
> 
> 3) On the allocation path the objcg pointer is obtained locklessly
>    using the READ_ONCE() macro and the least significant bit is
>    checked. If it's set, the following procedure is used to update
>    it locklessly:
>        - task->objcg is zeroed using cmpxcg
>        - new objcg pointer is obtained
>        - task->objcg is updated using try_cmpxchg
>        - operation is repeated if try_cmpxcg fails
>    It guarantees that no updates will be lost if task migration
>    is racing against objcg pointer update. It also allows to keep
>    both read and write paths fully lockless.
> 
> Because the task is keeping a reference to the objcg, it can't go away
> while the task is alive.
> 
> This commit doesn't change the way the remote memcg charging works.
> 
> Signed-off-by: Roman Gushchin (Cruise) <roman.gushchin@linux.dev>
> Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  include/linux/sched.h |   4 ++
>  mm/memcontrol.c       | 130 +++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 125 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 77f01ac385f7..60de42715b56 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1443,6 +1443,10 @@ struct task_struct {
>  	struct mem_cgroup		*active_memcg;
>  #endif
>  
> +#ifdef CONFIG_MEMCG_KMEM
> +	struct obj_cgroup		*objcg;
> +#endif
> +
>  #ifdef CONFIG_BLK_CGROUP
>  	struct gendisk			*throttle_disk;
>  #endif
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 16ac2a5838fb..0605e45bd4a2 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -249,6 +249,8 @@ struct mem_cgroup *vmpressure_to_memcg(struct vmpressure *vmpr)
>  	return container_of(vmpr, struct mem_cgroup, vmpressure);
>  }
>  
> +#define CURRENT_OBJCG_UPDATE_FLAG 0x1UL

There's a silent relation between this and set_bit(0, ...) in
mem_cgroup_kmem_attach(), maybe worth a comment at least, or defining the
bit number first and from that the flag?

> +
>  #ifdef CONFIG_MEMCG_KMEM
>  static DEFINE_SPINLOCK(objcg_lock);
>  
> @@ -3001,6 +3003,50 @@ static struct obj_cgroup *__get_obj_cgroup_from_memcg(struct mem_cgroup *memcg)
>  	return objcg;
>  }
>  
> +static struct obj_cgroup *current_objcg_update(void)
> +{
> +	struct mem_cgroup *memcg;
> +	struct obj_cgroup *old, *objcg = NULL;
> +
> +	do {
> +		/* Atomically drop the update bit. */
> +		old = xchg(&current->objcg, NULL);
> +		if (old) {
> +			old = (struct obj_cgroup *)
> +				((unsigned long)old & ~CURRENT_OBJCG_UPDATE_FLAG);
> +			if (old)
> +				obj_cgroup_put(old);
> +
> +			old = NULL;
> +		}
> +
> +		/* Obtain the new objcg pointer. */
> +		rcu_read_lock();
> +		memcg = mem_cgroup_from_task(current);
> +		/*
> +		 * The current task can be asynchronously moved to another
> +		 * memcg and the previous memcg can be offlined. So let's
> +		 * get the memcg pointer and try get a reference to objcg
> +		 * under a rcu read lock.
> +		 */
> +		for (; memcg != root_mem_cgroup; memcg = parent_mem_cgroup(memcg)) {
> +			objcg = rcu_dereference(memcg->objcg);
> +			if (likely(objcg && obj_cgroup_tryget(objcg)))

So IIUC here we increase objcg refcount.

> +				break;
> +			objcg = NULL;
> +		}
> +		rcu_read_unlock();
> +
> +		/*
> +		 * Try set up a new objcg pointer atomically. If it
> +		 * fails, it means the update flag was set concurrently, so
> +		 * the whole procedure should be repeated.
> +		 */
> +	} while (!try_cmpxchg(&current->objcg, &old, objcg));

And if this fails we throw objcg away and try again, but we should do
obj_cgroup_put(objcg) first, as otherwise it would cause a leak?

> +
> +	return objcg;
> +}
> +
>  __always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
>  {
>  	struct mem_cgroup *memcg;
> @@ -3008,19 +3054,26 @@ __always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
>  
>  	if (in_task()) {
>  		memcg = current->active_memcg;
> +		if (unlikely(memcg))
> +			goto from_memcg;
>  
> -		/* Memcg to charge can't be determined. */
> -		if (likely(!memcg) && (!current->mm || (current->flags & PF_KTHREAD)))

The checks for current->mm and PF_KTHREAD seem to be gone completely after
the patch, was that intended and why?

> -			return NULL;
> +		objcg = READ_ONCE(current->objcg);
> +		if (unlikely((unsigned long)objcg & CURRENT_OBJCG_UPDATE_FLAG))
> +			objcg = current_objcg_update();
> +
> +		if (objcg) {
> +			obj_cgroup_get(objcg);
> +			return objcg;
> +		}
>  	} else {
>  		memcg = this_cpu_read(int_active_memcg);
> -		if (likely(!memcg))
> -			return NULL;
> +		if (unlikely(memcg))
> +			goto from_memcg;
>  	}
> +	return NULL;
>  
> +from_memcg:
>  	rcu_read_lock();
> -	if (!memcg)
> -		memcg = mem_cgroup_from_task(current);
>  	objcg = __get_obj_cgroup_from_memcg(memcg);
>  	rcu_read_unlock();
>  	return objcg;
> @@ -6345,6 +6398,7 @@ static void mem_cgroup_move_task(void)
>  		mem_cgroup_clear_mc();
>  	}
>  }
> +

