Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553C56CFCE0
	for <lists+cgroups@lfdr.de>; Thu, 30 Mar 2023 09:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjC3HgB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 Mar 2023 03:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjC3HgA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 30 Mar 2023 03:36:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2232BE3;
        Thu, 30 Mar 2023 00:35:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D36811FE91;
        Thu, 30 Mar 2023 07:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680161757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fU7z0yHw4Ry/tQw4NzU0o63bQ+V0Qd8kX2CYBZv5RXc=;
        b=uykLa5wl1jleLVQ6elC+H2skYegC2uaQgOrhniRTyo0oiHO0cLN1xo67HvgCsAMt2/5tYw
        y0woZkDkwHmuuvVJteGxd8GCR06LvcbfoPMX3TYaH3/LEK6zekWk9zhX9MHemGQoYyeukU
        rG7ABcMf7DqojiNhm1Q+5nikcDzGNNg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B1BBA1348E;
        Thu, 30 Mar 2023 07:35:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UFEnKd07JWTFegAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 30 Mar 2023 07:35:57 +0000
Date:   Thu, 30 Mar 2023 09:35:56 +0200
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
Subject: Re: [PATCH v2 6/9] memcg: sleep during flushing stats in safe
 contexts
Message-ID: <ZCU73Ghje96Q0X7A@dhcp22.suse.cz>
References: <20230328221644.803272-1-yosryahmed@google.com>
 <20230328221644.803272-7-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328221644.803272-7-yosryahmed@google.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 28-03-23 22:16:41, Yosry Ahmed wrote:
> Currently, all contexts that flush memcg stats do so with sleeping not
> allowed. Some of these contexts are perfectly safe to sleep in, such as
> reading cgroup files from userspace or the background periodic flusher.
> 
> Refactor the code to make mem_cgroup_flush_stats() non-atomic (aka
> sleepable), and provide a separate atomic version. The atomic version is
> used in reclaim, refault, writeback, and in mem_cgroup_usage(). All
> other code paths are left to use the non-atomic version. This includes
> callbacks for userspace reads and the periodic flusher.
> 
> Since refault is the only caller of mem_cgroup_flush_stats_ratelimited(),
> change it to mem_cgroup_flush_stats_atomic_ratelimited(). Reclaim and
> refault code paths are modified to do non-atomic flushing in separate
> later patches -- so it will eventually be changed back to
> mem_cgroup_flush_stats_ratelimited().
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> Acked-by: Shakeel Butt <shakeelb@google.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/memcontrol.h |  9 ++++++--
>  mm/memcontrol.c            | 45 ++++++++++++++++++++++++++++++--------
>  mm/vmscan.c                |  2 +-
>  mm/workingset.c            |  2 +-
>  4 files changed, 45 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index ac3f3b3a45e2..b424ba3ebd09 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1037,7 +1037,8 @@ static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
>  }
>  
>  void mem_cgroup_flush_stats(void);
> -void mem_cgroup_flush_stats_ratelimited(void);
> +void mem_cgroup_flush_stats_atomic(void);
> +void mem_cgroup_flush_stats_atomic_ratelimited(void);
>  
>  void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
>  			      int val);
> @@ -1535,7 +1536,11 @@ static inline void mem_cgroup_flush_stats(void)
>  {
>  }
>  
> -static inline void mem_cgroup_flush_stats_ratelimited(void)
> +static inline void mem_cgroup_flush_stats_atomic(void)
> +{
> +}
> +
> +static inline void mem_cgroup_flush_stats_atomic_ratelimited(void)
>  {
>  }
>  
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 65750f8b8259..a2ce3aa10d94 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -634,7 +634,7 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
>  	}
>  }
>  
> -static void __mem_cgroup_flush_stats(void)
> +static void do_flush_stats(bool atomic)
>  {
>  	/*
>  	 * We always flush the entire tree, so concurrent flushers can just
> @@ -646,26 +646,46 @@ static void __mem_cgroup_flush_stats(void)
>  		return;
>  
>  	WRITE_ONCE(flush_next_time, jiffies_64 + 2*FLUSH_TIME);
> -	cgroup_rstat_flush_atomic(root_mem_cgroup->css.cgroup);
> +
> +	if (atomic)
> +		cgroup_rstat_flush_atomic(root_mem_cgroup->css.cgroup);
> +	else
> +		cgroup_rstat_flush(root_mem_cgroup->css.cgroup);
> +
>  	atomic_set(&stats_flush_threshold, 0);
>  	atomic_set(&stats_flush_ongoing, 0);
>  }
>  
> +static bool should_flush_stats(void)
> +{
> +	return atomic_read(&stats_flush_threshold) > num_online_cpus();
> +}
> +
>  void mem_cgroup_flush_stats(void)
>  {
> -	if (atomic_read(&stats_flush_threshold) > num_online_cpus())
> -		__mem_cgroup_flush_stats();
> +	if (should_flush_stats())
> +		do_flush_stats(false);
>  }
>  
> -void mem_cgroup_flush_stats_ratelimited(void)
> +void mem_cgroup_flush_stats_atomic(void)
> +{
> +	if (should_flush_stats())
> +		do_flush_stats(true);
> +}
> +
> +void mem_cgroup_flush_stats_atomic_ratelimited(void)
>  {
>  	if (time_after64(jiffies_64, READ_ONCE(flush_next_time)))
> -		mem_cgroup_flush_stats();
> +		mem_cgroup_flush_stats_atomic();
>  }
>  
>  static void flush_memcg_stats_dwork(struct work_struct *w)
>  {
> -	__mem_cgroup_flush_stats();
> +	/*
> +	 * Always flush here so that flushing in latency-sensitive paths is
> +	 * as cheap as possible.
> +	 */
> +	do_flush_stats(false);
>  	queue_delayed_work(system_unbound_wq, &stats_flush_dwork, FLUSH_TIME);
>  }
>  
> @@ -3685,9 +3705,12 @@ static unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap)
>  		 * done from irq context; use stale stats in this case.
>  		 * Arguably, usage threshold events are not reliable on the root
>  		 * memcg anyway since its usage is ill-defined.
> +		 *
> +		 * Additionally, other call paths through memcg_check_events()
> +		 * disable irqs, so make sure we are flushing stats atomically.
>  		 */
>  		if (in_task())
> -			mem_cgroup_flush_stats();
> +			mem_cgroup_flush_stats_atomic();
>  		val = memcg_page_state(memcg, NR_FILE_PAGES) +
>  			memcg_page_state(memcg, NR_ANON_MAPPED);
>  		if (swap)
> @@ -4610,7 +4633,11 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
>  	struct mem_cgroup *memcg = mem_cgroup_from_css(wb->memcg_css);
>  	struct mem_cgroup *parent;
>  
> -	mem_cgroup_flush_stats();
> +	/*
> +	 * wb_writeback() takes a spinlock and calls
> +	 * wb_over_bg_thresh()->mem_cgroup_wb_stats(). Do not sleep.
> +	 */
> +	mem_cgroup_flush_stats_atomic();
>  
>  	*pdirty = memcg_page_state(memcg, NR_FILE_DIRTY);
>  	*pwriteback = memcg_page_state(memcg, NR_WRITEBACK);
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 9c1c5e8b24b8..a9511ccb936f 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2845,7 +2845,7 @@ static void prepare_scan_count(pg_data_t *pgdat, struct scan_control *sc)
>  	 * Flush the memory cgroup stats, so that we read accurate per-memcg
>  	 * lruvec stats for heuristics.
>  	 */
> -	mem_cgroup_flush_stats();
> +	mem_cgroup_flush_stats_atomic();
>  
>  	/*
>  	 * Determine the scan balance between anon and file LRUs.
> diff --git a/mm/workingset.c b/mm/workingset.c
> index af862c6738c3..dab0c362b9e3 100644
> --- a/mm/workingset.c
> +++ b/mm/workingset.c
> @@ -462,7 +462,7 @@ void workingset_refault(struct folio *folio, void *shadow)
>  
>  	mod_lruvec_state(lruvec, WORKINGSET_REFAULT_BASE + file, nr);
>  
> -	mem_cgroup_flush_stats_ratelimited();
> +	mem_cgroup_flush_stats_atomic_ratelimited();
>  	/*
>  	 * Compare the distance to the existing workingset size. We
>  	 * don't activate pages that couldn't stay resident even if
> -- 
> 2.40.0.348.gf938b09366-goog

-- 
Michal Hocko
SUSE Labs
