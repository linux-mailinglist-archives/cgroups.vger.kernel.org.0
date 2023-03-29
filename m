Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66AAC6CEE55
	for <lists+cgroups@lfdr.de>; Wed, 29 Mar 2023 18:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjC2QAJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 29 Mar 2023 12:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjC2P7b (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 29 Mar 2023 11:59:31 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D066585;
        Wed, 29 Mar 2023 08:58:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2CBDA219FB;
        Wed, 29 Mar 2023 15:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680105537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=laCTMVv10tir+5LCK7bZIg6RxS0xYCgupvb50S/b4XY=;
        b=Vl2TDvex2fX+V/qOfl0Xk9vDM3ikifOzUk6sEr0WIzpohvYYkvFLW+6qBu+RlI035Az2QO
        Bg4vs8RqNGMdJ7g7ivHKAcgIhtsY1zKezQDQyUbKkOeL8fq/lKChGvk9VCPFR40TGr8YMU
        k0NaJphuGjbyfnmWQTPsdyb4/FmBbbU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 00BBA138FF;
        Wed, 29 Mar 2023 15:58:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qZMgAEFgJGQEaAAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 29 Mar 2023 15:58:56 +0000
Date:   Wed, 29 Mar 2023 17:58:56 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH v2 5/9] memcg: replace stats_flush_lock with an atomic
Message-ID: <ZCRgQHtDuWN6xp7z@dhcp22.suse.cz>
References: <20230328221644.803272-1-yosryahmed@google.com>
 <20230328221644.803272-6-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328221644.803272-6-yosryahmed@google.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 28-03-23 22:16:40, Yosry Ahmed wrote:
> As Johannes notes in [1], stats_flush_lock is currently used to:
> (a) Protect updated to stats_flush_threshold.
> (b) Protect updates to flush_next_time.
> (c) Serializes calls to cgroup_rstat_flush() based on those ratelimits.
> 
> However:
> 
> 1. stats_flush_threshold is already an atomic
> 
> 2. flush_next_time is not atomic. The writer is locked, but the reader
>    is lockless. If the reader races with a flush, you could see this:
> 
>                                         if (time_after(jiffies, flush_next_time))
>         spin_trylock()
>         flush_next_time = now + delay
>         flush()
>         spin_unlock()
>                                         spin_trylock()
>                                         flush_next_time = now + delay
>                                         flush()
>                                         spin_unlock()
> 
>    which means we already can get flushes at a higher frequency than
>    FLUSH_TIME during races. But it isn't really a problem.
> 
>    The reader could also see garbled partial updates, so it needs at
>    least READ_ONCE and WRITE_ONCE protection.

Just a nit. Sounds more serious than it is actually. This would only
happen if compiler decides to split the write.

> 3. Serializing cgroup_rstat_flush() calls against the ratelimit
>    factors is currently broken because of the race in 2. But the race
>    is actually harmless, all we might get is the occasional earlier
>    flush. If there is no delta, the flush won't do much. And if there
>    is, the flush is justified.
> 
> So the lock can be removed all together. However, the lock also served
> the purpose of preventing a thundering herd problem for concurrent
> flushers, see [2]. Use an atomic instead to serve the purpose of
> unifying concurrent flushers.
> 
> [1]https://lore.kernel.org/lkml/20230323172732.GE739026@cmpxchg.org/
> [2]https://lore.kernel.org/lkml/20210716212137.1391164-2-shakeelb@google.com/
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memcontrol.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index ff39f78f962e..65750f8b8259 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -585,8 +585,8 @@ mem_cgroup_largest_soft_limit_node(struct mem_cgroup_tree_per_node *mctz)
>   */
>  static void flush_memcg_stats_dwork(struct work_struct *w);
>  static DECLARE_DEFERRABLE_WORK(stats_flush_dwork, flush_memcg_stats_dwork);
> -static DEFINE_SPINLOCK(stats_flush_lock);
>  static DEFINE_PER_CPU(unsigned int, stats_updates);
> +static atomic_t stats_flush_ongoing = ATOMIC_INIT(0);
>  static atomic_t stats_flush_threshold = ATOMIC_INIT(0);
>  static u64 flush_next_time;
>  
> @@ -636,15 +636,19 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
>  
>  static void __mem_cgroup_flush_stats(void)
>  {
> -	unsigned long flag;
> -
> -	if (!spin_trylock_irqsave(&stats_flush_lock, flag))
> +	/*
> +	 * We always flush the entire tree, so concurrent flushers can just
> +	 * skip. This avoids a thundering herd problem on the rstat global lock
> +	 * from memcg flushers (e.g. reclaim, refault, etc).
> +	 */
> +	if (atomic_read(&stats_flush_ongoing) ||
> +	    atomic_xchg(&stats_flush_ongoing, 1))
>  		return;
>  
> -	flush_next_time = jiffies_64 + 2*FLUSH_TIME;
> +	WRITE_ONCE(flush_next_time, jiffies_64 + 2*FLUSH_TIME);
>  	cgroup_rstat_flush_atomic(root_mem_cgroup->css.cgroup);
>  	atomic_set(&stats_flush_threshold, 0);
> -	spin_unlock_irqrestore(&stats_flush_lock, flag);
> +	atomic_set(&stats_flush_ongoing, 0);
>  }
>  
>  void mem_cgroup_flush_stats(void)
> @@ -655,7 +659,7 @@ void mem_cgroup_flush_stats(void)
>  
>  void mem_cgroup_flush_stats_ratelimited(void)
>  {
> -	if (time_after64(jiffies_64, flush_next_time))
> +	if (time_after64(jiffies_64, READ_ONCE(flush_next_time)))
>  		mem_cgroup_flush_stats();
>  }
>  
> -- 
> 2.40.0.348.gf938b09366-goog

-- 
Michal Hocko
SUSE Labs
