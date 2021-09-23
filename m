Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1FF7415BE2
	for <lists+cgroups@lfdr.de>; Thu, 23 Sep 2021 12:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240383AbhIWKWh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Sep 2021 06:22:37 -0400
Received: from rome.phoronix.com ([192.211.48.82]:46276 "EHLO
        rome.phoronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235605AbhIWKWg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Sep 2021 06:22:36 -0400
X-Greylist: delayed 1125 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Sep 2021 06:22:36 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=michaellarabel.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/UMe8p7BLUCwEGQxHb9t/FCJBJvfDEtMn+TwcXnhsDE=; b=LxijJVqEYdBgo8K/gzXTo0zewS
        HloxbFfbqmsv45WNwQ8bEgReF32r1WsGzQvhk8HqbtCQCM+dr/QRt96AiXbsR7+DkkBlKZYPVacnt
        en52b6xKXQdCsoR0SeE60IrhjJVZ7Lwi2/kF5K6aynsTu1Q+tmTsoxB0uob9T6VELpqcoQYH2zf/R
        P4YB/bINr0TR1yALtWsUuN5xUxM/4vEeOFw0mJJzC95vMmnJAkQglnYhtTjGlS8OOF7GbnG+TXtg/
        vBVxWmDd1e0C+Gfs+VZOwrI8LhTaVoYeJQ6AH4fW45LYevcpZ6r6ugZ9QRvCFUfU4ruY6ZiaYhR0t
        9li1abuw==;
Received: from c-73-176-63-28.hsd1.il.comcast.net ([73.176.63.28]:49134 helo=[192.168.86.57])
        by rome.phoronix.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <Michael@MichaelLarabel.com>)
        id 1mTLYX-0005TT-Go; Thu, 23 Sep 2021 06:02:15 -0400
Subject: Re: [PATCH] memcg: flush lruvec stats in the refault
To:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Roman Gushchin <guro@fb.com>, Feng Tang <feng.tang@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210922224906.676151-1-shakeelb@google.com>
From:   Michael Larabel <Michael@MichaelLarabel.com>
Message-ID: <89476e46-d57c-48fa-54f5-ab2e8cf6e61e@MichaelLarabel.com>
Date:   Thu, 23 Sep 2021 05:02:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210922224906.676151-1-shakeelb@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - rome.phoronix.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - MichaelLarabel.com
X-Get-Message-Sender-Via: rome.phoronix.com: authenticated_id: michael@michaellarabel.com
X-Authenticated-Sender: rome.phoronix.com: michael@michaellarabel.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 9/22/21 5:49 PM, Shakeel Butt wrote:
> Prior to the commit 7e1c0d6f5820 ("memcg: switch lruvec stats to rstat")
> and the commit aa48e47e3906 ("memcg: infrastructure to flush memcg
> stats"), each lruvec memcg stats can be off by (nr_cgroups * nr_cpus *
> 32) at worst and for unbounded amount of time. The commit aa48e47e3906
> moved the lruvec stats to rstat infrastructure and the commit
> 7e1c0d6f5820 bounded the error for all the lruvec stats to (nr_cpus *
> 32) at worst for at most 2 seconds. More specifically it decoupled the
> number of stats and the number of cgroups from the error rate.
>
> However this reduction in error comes with the cost of triggering the
> slowpath of stats update more frequently. Previously in the slowpath the
> kernel adds the stats up the memcg tree. After aa48e47e3906, the kernel
> triggers the asyn lruvec stats flush through queue_work(). This causes
> regression reports from 0day kernel bot [1] as well as from phoronix
> test suite [2].
>
> We tried two options to fix the regression:
>
> 1) Increase the threshold to trigger the slowpath in lruvec stats update
> codepath from 32 to 512.
>
> 2) Remove the slowpath from lruvec stats update codepath and instead
> flush the stats in the page refault codepath. The assumption is that the
> kernel timely flush the stats, so, the update tree would be small in the
> refault codepath to not cause the preformance impact.
>
> Following are the results of will-it-scale/page_fault[1|2|3] benchmark
> on four settings i.e. (1) 5.15-rc1 as baseline (2) 5.15-rc1 with
> aa48e47e3906 and 7e1c0d6f5820 reverted (3) 5.15-rc1 with option-1
> (4) 5.15-rc1 with option-2.
>
> test	(1)	(2)		(3)		(4)
> pg_f1	368563	406277 (10.23%)	399693 (8.44%)	416398 (12.97%)
> pg_f2	338399	372133 (9.96%)	369180 (9.09%)	381024 (12.59%)
> pg_f3	500853	575399 (14.88%)	570388 (13.88%)	576083 (15.02%)
>
>  From the above result, it seems like the option-2 not only solves the
> regression but also improves the performance for at least these
> benchmarks.
>
> Feng Tang (intel) ran the aim7 benchmark with these two options and
> confirms that option-1 reduces the regression but option-2 removes the
> regression.
>
> Michael Larabel (phoronix) ran multiple benchmarks with these options
> and reported the results at [3] and it shows for most benchmarks
> option-2 removes the regression introduced by the commit aa48e47e3906
> ("memcg: infrastructure to flush memcg stats").
>
> Based on the experiment results, this patch proposed the option-2 as the
> solution to resolve the regression.
>
> [1] https://lore.kernel.org/all/20210726022421.GB21872@xsang-OptiPlex-9020
> [2] https://www.phoronix.com/scan.php?page=article&item=linux515-compile-regress
> [3] https://openbenchmarking.org/result/2109226-DEBU-LINUX5104
>
> Fixes: aa48e47e3906 ("memcg: infrastructure to flush memcg stats")
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> ---
>   mm/memcontrol.c | 10 ----------
>   mm/workingset.c |  1 +
>   2 files changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index b762215d73eb..6da5020a8656 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -106,9 +106,6 @@ static bool do_memsw_account(void)
>   /* memcg and lruvec stats flushing */
>   static void flush_memcg_stats_dwork(struct work_struct *w);
>   static DECLARE_DEFERRABLE_WORK(stats_flush_dwork, flush_memcg_stats_dwork);
> -static void flush_memcg_stats_work(struct work_struct *w);
> -static DECLARE_WORK(stats_flush_work, flush_memcg_stats_work);
> -static DEFINE_PER_CPU(unsigned int, stats_flush_threshold);
>   static DEFINE_SPINLOCK(stats_flush_lock);
>   
>   #define THRESHOLDS_EVENTS_TARGET 128
> @@ -682,8 +679,6 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
>   
>   	/* Update lruvec */
>   	__this_cpu_add(pn->lruvec_stats_percpu->state[idx], val);
> -	if (!(__this_cpu_inc_return(stats_flush_threshold) % MEMCG_CHARGE_BATCH))
> -		queue_work(system_unbound_wq, &stats_flush_work);
>   }
>   
>   /**
> @@ -5361,11 +5356,6 @@ static void flush_memcg_stats_dwork(struct work_struct *w)
>   	queue_delayed_work(system_unbound_wq, &stats_flush_dwork, 2UL*HZ);
>   }
>   
> -static void flush_memcg_stats_work(struct work_struct *w)
> -{
> -	mem_cgroup_flush_stats();
> -}
> -
>   static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
>   {
>   	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
> diff --git a/mm/workingset.c b/mm/workingset.c
> index d4268d8e9a82..d5b81e4f4cbe 100644
> --- a/mm/workingset.c
> +++ b/mm/workingset.c
> @@ -352,6 +352,7 @@ void workingset_refault(struct page *page, void *shadow)
>   
>   	inc_lruvec_state(lruvec, WORKINGSET_REFAULT_BASE + file);
>   
> +	mem_cgroup_flush_stats();
>   	/*
>   	 * Compare the distance to the existing workingset size. We
>   	 * don't activate pages that couldn't stay resident even if


This patch is still looking good in my additional testing so far.

With an Intel Core i9 11900K system where it was quite noticeably 
regressing in various workloads, things now seem to be under control[1] 
with this patch and inline with v5.14 / 5.15 with the memcg patches 
reverted.

If desired:

Tested-by: Michael Larabel <Michael@phoronix.com>

Michael

[1] 
https://openbenchmarking.org/result/2109221-DEBU-LINUX5143&sgm=1&hgv=flush-in-the-ref&sor

