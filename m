Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C49791A5E
	for <lists+cgroups@lfdr.de>; Mon,  4 Sep 2023 17:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239683AbjIDPPg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 Sep 2023 11:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjIDPPf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 Sep 2023 11:15:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19910AF;
        Mon,  4 Sep 2023 08:15:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B47181F74B;
        Mon,  4 Sep 2023 15:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1693840529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vEHfNTrFDIvveWwLAge8I94yVYAf11G0ez80Gn/sAIo=;
        b=K5HN6oieyg4dnpZYlEDXFpTdfBj5Lr1bunWUt8XGoux9xDLmTrSRB5c3k3HLwNfINGCB/Y
        wwiBm3du/EYziqElZ07Rovo83WNnXaKsQqIXpImNBQxLtxIMRiLVvunE98h2wCUWXFFQT2
        WdfW2pstfR7KHV5YcUuY1gONJyPNWtQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9788313585;
        Mon,  4 Sep 2023 15:15:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id beTVIZH09WSeRwAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 04 Sep 2023 15:15:29 +0000
Date:   Mon, 4 Sep 2023 17:15:28 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] mm: memcg: use non-unified stats flushing for
 userspace reads
Message-ID: <ZPX0kCKd4TaVLJY7@dhcp22.suse.cz>
References: <20230831165611.2610118-1-yosryahmed@google.com>
 <20230831165611.2610118-5-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831165611.2610118-5-yosryahmed@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 31-08-23 16:56:11, Yosry Ahmed wrote:
> Unified flushing allows for great concurrency for paths that attempt to
> flush the stats, at the expense of potential staleness and a single
> flusher paying the extra cost of flushing the full tree.
> 
> This tradeoff makes sense for in-kernel flushers that may observe high
> concurrency (e.g. reclaim, refault). For userspace readers, stale stats
> may be unexpected and problematic, especially when such stats are used
> for critical paths such as userspace OOM handling. Additionally, a
> userspace reader will occasionally pay the cost of flushing the entire
> hierarchy, which also causes problems in some cases [1].
> 
> Opt userspace reads out of unified flushing. This makes the cost of
> reading the stats more predictable (proportional to the size of the
> subtree), as well as the freshness of the stats. Userspace readers are
> not expected to have similar concurrency to in-kernel flushers,
> serializing them among themselves and among in-kernel flushers should be
> okay. Nonetheless, for extra safety, introduce a mutex when flushing for
> userspace readers to make sure only a single userspace reader can compete
> with in-kernel flushers at a time. This takes away userspace ability to
> directly influence or hurt in-kernel lock contention.

I think it would be helpful to note that the primary reason this is a
concern is that the spinlock is dropped during flushing under
contention.

> An alternative is to remove flushing from the stats reading path
> completely, and rely on the periodic flusher. This should be accompanied
> by making the periodic flushing period tunable, and providing an
> interface for userspace to force a flush, following a similar model to
> /proc/vmstat. However, such a change will be hard to reverse if the
> implementation needs to be changed because:
> - The cost of reading stats will be very cheap and we won't be able to
>   take that back easily.
> - There are user-visible interfaces involved.
> 
> Hence, let's go with the change that's most reversible first and revisit
> as needed.
> 
> This was tested on a machine with 256 cpus by running a synthetic test
> script [2] that creates 50 top-level cgroups, each with 5 children (250
> leaf cgroups). Each leaf cgroup has 10 processes running that allocate
> memory beyond the cgroup limit, invoking reclaim (which is an in-kernel
> unified flusher). Concurrently, one thread is spawned per-cgroup to read
> the stats every second (including root, top-level, and leaf cgroups --
> so total 251 threads). No significant regressions were observed in the
> total run time, which means that userspace readers are not significantly
> affecting in-kernel flushers:
> 
> Base (mm-unstable):
> 
> real	0m22.500s
> user	0m9.399s
> sys	73m41.381s
> 
> real	0m22.749s
> user	0m15.648s
> sys	73m13.113s
> 
> real	0m22.466s
> user	0m10.000s
> sys	73m11.933s
> 
> With this patch:
> 
> real	0m23.092s
> user	0m10.110s
> sys	75m42.774s
> 
> real	0m22.277s
> user	0m10.443s
> sys	72m7.182s
> 
> real	0m24.127s
> user	0m12.617s
> sys	78m52.765s
> 
> [1]https://lore.kernel.org/lkml/CABWYdi0c6__rh-K7dcM_pkf9BJdTRtAU08M43KO9ME4-dsgfoQ@mail.gmail.com/
> [2]https://lore.kernel.org/lkml/CAJD7tka13M-zVZTyQJYL1iUAYvuQ1fcHbCjcOBZcz6POYTV-4g@mail.gmail.com/
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

OK, I can live with that but I still believe that locking involved in
the user interface only begs for issues later on as there is no control
over that lock contention other than the number of processes involved.
As it seems that we cannot make a consensus on this concern now and this
should be already helping existing workloads then let's just buy some
more time ;)

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  mm/memcontrol.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 94d5a6751a9e..46a7abf71c73 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -588,6 +588,7 @@ mem_cgroup_largest_soft_limit_node(struct mem_cgroup_tree_per_node *mctz)
>  static void flush_memcg_stats_dwork(struct work_struct *w);
>  static DECLARE_DEFERRABLE_WORK(stats_flush_dwork, flush_memcg_stats_dwork);
>  static DEFINE_PER_CPU(unsigned int, stats_updates);
> +static DEFINE_MUTEX(stats_user_flush_mutex);
>  static atomic_t stats_unified_flush_ongoing = ATOMIC_INIT(0);
>  static atomic_t stats_flush_threshold = ATOMIC_INIT(0);
>  static u64 flush_next_time;
> @@ -655,6 +656,21 @@ static void do_stats_flush(struct mem_cgroup *memcg)
>  	cgroup_rstat_flush(memcg->css.cgroup);
>  }
>  
> +/*
> + * mem_cgroup_user_flush_stats - do a stats flush for a user read
> + * @memcg: memory cgroup to flush
> + *
> + * Flush the subtree of @memcg. A mutex is used for userspace readers to gate
> + * the global rstat spinlock. This protects in-kernel flushers from userspace
> + * readers hogging the lock.

readers hogging the lock as do_stats_flush drops the spinlock under
contention.

> + */
> +static void mem_cgroup_user_flush_stats(struct mem_cgroup *memcg)
> +{
> +	mutex_lock(&stats_user_flush_mutex);
> +	do_stats_flush(memcg);
> +	mutex_unlock(&stats_user_flush_mutex);
> +}
> +
>  /*
>   * do_unified_stats_flush - do a unified flush of memory cgroup statistics
>   *
-- 
Michal Hocko
SUSE Labs
