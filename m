Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F40B815FA2
	for <lists+cgroups@lfdr.de>; Tue,  7 May 2019 10:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbfEGIoX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 7 May 2019 04:44:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:41552 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726085AbfEGIoW (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 7 May 2019 04:44:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5903AACFA;
        Tue,  7 May 2019 08:44:20 +0000 (UTC)
Date:   Tue, 7 May 2019 10:44:19 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH v3] mm: Throttle allocators when failing reclaim over
 memory.high
Message-ID: <20190507084419.GM31017@dhcp22.suse.cz>
References: <20190410153449.GA14915@chrisdown.name>
 <20190501184104.GA30293@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190501184104.GA30293@chrisdown.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Sorry I was traveling last week and will be off for a large part of
this week.

On Wed 01-05-19 14:41:04, Chris Down wrote:
> We're trying to use memory.high to limit workloads, but have found that
> containment can frequently fail completely and cause OOM situations
> outside of the cgroup. This happens especially with swap space -- either
> when none is configured, or swap is full. These failures often also
> don't have enough warning to allow one to react, whether for a human or
> for a daemon monitoring PSI.
> 
> Here is output from a simple program showing how long it takes in μsec
> (column 2) to allocate a megabyte of anonymous memory (column 1) when a
> cgroup is already beyond its memory high setting, and no swap is
> available:
> 
>     [root@ktst ~]# systemd-run -p MemoryHigh=100M -p MemorySwapMax=1 \
>     > --wait -t timeout 300 /root/mdf
>     [...]
>     95  1035
>     96  1038
>     97  1000
>     98  1036
>     99  1048
>     100 1590
>     101 1968
>     102 1776
>     103 1863
>     104 1757
>     105 1921
>     106 1893
>     107 1760
>     108 1748
>     109 1843
>     110 1716
>     111 1924
>     112 1776
>     113 1831
>     114 1766
>     115 1836
>     116 1588
>     117 1912
>     118 1802
>     119 1857
>     120 1731
>     [...]
>     [System OOM in 2-3 seconds]
> 
> The delay does go up extremely marginally past the 100MB memory.high
> threshold, as now we spend time scanning before returning to usermode,
> but it's nowhere near enough to contain growth. It also doesn't get
> worse the more pages you have, since it only considers nr_pages.
> 
> The current situation goes against both the expectations of users of
> memory.high, and our intentions as cgroup v2 developers. In
> cgroup-v2.txt, we claim that we will throttle and only under "extreme
> conditions" will memory.high protection be breached. Likewise, cgroup v2
> users generally also expect that memory.high should throttle workloads
> as they exceed their high threshold. However, as seen above, this isn't
> always how it works in practice -- even on banal setups like those with
> no swap, or where swap has become exhausted, we can end up with
> memory.high being breached and us having no weapons left in our arsenal
> to combat runaway growth with, since reclaim is futile.

Well, having only a non-reclaimable memory essentially means the
workload termination to resolve the situation. Be it an in kernel oom
killer or any other pro-active measure doing the same. On the other hand
I do understand that we shouldn't run into the system oom situation prematurely
because the userspace doesn't have enough time to react. In your example
above it takes 1M/1ms and that indeed doesn't give much room to
a potential userspace intervention. The global case already tries to
throttle on no progress (albeit only for pending writers). I do not see
a fundamental reason to not throttle on no progress here as well.

> It's also hard for system monitoring software or users to tell how bad
> the situation is, as "high" events for the memcg may in some cases be
> benign, and in others be catastrophic. The current status quo is that we
> fail containment in a way that doesn't provide any advance warning that
> things are about to go horribly wrong (for example, we are about to
> invoke the kernel OOM killer).
> 
> This patch introduces explicit throttling when reclaim is failing to
> keep memcg size contained at the memory.high setting. It does so by
> applying an exponential delay curve derived from the memcg's overage
> compared to memory.high.  In the normal case where the memcg is either
> below or only marginally over its memory.high setting, no throttling
> will be performed.
> 
> This composes well with system health monitoring and remediation, as
> these allocator delays are factored into PSI's memory pressure
> calculations. This both creates a mechanism system administrators or
> applications consuming the PSI interface to trivially see that the memcg
> in question is struggling and use that to make more reasonable
> decisions, and permits them enough time to act. Either of these can act
> with significantly more nuance than that we can provide using the system
> OOM killer.
> 
> This is a similar idea to memory.oom_control in cgroup v1 which would
> put the cgroup to sleep if the threshold was violated, but it's also
> significantly improved as it results in visible memory pressure, and
> also doesn't schedule indefinitely, which previously made tracing and
> other introspection difficult (ie. it's clamped at 2*HZ per allocation
> through MEMCG_MAX_HIGH_DELAY_JIFFIES).

OK, fair enough. One thing that I really do not want to see is to have
this explicitly documented in the user documentation because this is an
implementation detail, userspace shouldn't depend on.

> Contrast the previous results with a kernel with this patch:
> 
>     [root@ktst ~]# systemd-run -p MemoryHigh=100M -p MemorySwapMax=1 \
>     > --wait -t timeout 300 /root/mdf
>     [...]
>     95  1002
>     96  1000
>     97  1002
>     98  1003
>     99  1000
>     100 1043
>     101 84724
>     102 330628
>     103 610511
>     104 1016265
>     105 1503969
>     106 2391692
>     107 2872061
>     108 3248003
>     109 4791904
>     110 5759832
>     111 6912509
>     112 8127818
>     113 9472203
>     114 12287622
>     115 12480079
>     116 14144008
>     117 15808029
>     118 16384500
>     119 16383242
>     120 16384979
>     [...]
> 
> As you can see, in the normal case, memory allocation takes around 1000
> μsec. However, as we exceed our memory.high, things start to increase
> exponentially, but fairly leniently at first. Our first megabyte over
> memory.high takes us 0.16 seconds, then the next is 0.46 seconds, then
> the next is almost an entire second. This gets worse until we reach our
> eventual 2*HZ clamp per batch, resulting in 16 seconds per megabyte.
> However, this is still making forward progress, so permits tracing or
> further analysis with programs like GDB.
> 
> We use an exponential curve for our delay penalty for a few reasons:
> 
> 1. We run mem_cgroup_handle_over_high to potentially do reclaim after
>    we've already performed allocations, which means that temporarily
>    going over memory.high by a small amount may be perfectly legitimate,
>    even for compliant workloads. We don't want to unduly penalise such
>    cases.
> 2. An exponential curve (as opposed to a static or linear delay) allows
>    ramping up memory pressure stats more gradually, which can be useful
>    to work out that you have set memory.high too low, without destroying
>    application performance entirely.

Thanks for extending the changelog!

> This patch expands on earlier work by Johannes Weiner. Thanks!
> 
> Signed-off-by: Chris Down <chris@chrisdown.name>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: cgroups@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: kernel-team@fb.com


I didn't get to read the code carefully so I cannot really give my ack
but the idea seems plausible and if the current parameters turn out to
hurt some workloads we can tune from there. The important part is that
throttling doesn't push hard limit triggering to infinity because we
need the OOM killer to trigger and resolve the situation eventually as
not everybody is doing userspace oom killing.

The other important thing is that this throttling is completely
transparent to the userspace and it is a subject of the current
implementation rather than any form of contract (unlike the oom_control
example or any tunable to control the decay/max timeout etc). No
userspace should depend on it.

Thanks

> ---
>  mm/memcontrol.c | 118 +++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 117 insertions(+), 1 deletion(-)
> 
> [v3: updated the changelog post discussion in person with Michal.]
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 2535e54e7989..e12fec0d4b58 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -66,6 +66,7 @@
>  #include <linux/lockdep.h>
>  #include <linux/file.h>
>  #include <linux/tracehook.h>
> +#include <linux/psi.h>
>  #include "internal.h"
>  #include <net/sock.h>
>  #include <net/ip.h>
> @@ -2263,12 +2264,68 @@ static void high_work_func(struct work_struct *work)
>  	reclaim_high(memcg, MEMCG_CHARGE_BATCH, GFP_KERNEL);
>  }
>  
> +/*
> + * Clamp the maximum sleep time per allocation batch to 2 seconds. This is
> + * enough to still cause a significant slowdown in most cases, while still
> + * allowing diagnostics and tracing to proceed without becoming stuck.
> + */
> +#define MEMCG_MAX_HIGH_DELAY_JIFFIES (2UL*HZ)
> +
> +/*
> + * When calculating the delay, we use these either side of the exponentiation to
> + * maintain precision and scale to a reasonable number of jiffies (see the table
> + * below.
> + *
> + * - MEMCG_DELAY_PRECISION_SHIFT: Extra precision bits while translating the
> + *   overage ratio to a delay.
> + * - MEMCG_DELAY_SCALING_SHIFT: The number of bits to scale down down the
> + *   proposed penalty in order to reduce to a reasonable number of jiffies, and
> + *   to produce a reasonable delay curve.
> + *
> + * MEMCG_DELAY_SCALING_SHIFT just happens to be a number that produces a
> + * reasonable delay curve compared to precision-adjusted overage, not
> + * penalising heavily at first, but still making sure that growth beyond the
> + * limit penalises misbehaviour cgroups by slowing them down exponentially. For
> + * example, with a high of 100 megabytes:
> + *
> + *  +-------+------------------------+
> + *  | usage | time to allocate in ms |
> + *  +-------+------------------------+
> + *  | 100M  |                      0 |
> + *  | 101M  |                      6 |
> + *  | 102M  |                     25 |
> + *  | 103M  |                     57 |
> + *  | 104M  |                    102 |
> + *  | 105M  |                    159 |
> + *  | 106M  |                    230 |
> + *  | 107M  |                    313 |
> + *  | 108M  |                    409 |
> + *  | 109M  |                    518 |
> + *  | 110M  |                    639 |
> + *  | 111M  |                    774 |
> + *  | 112M  |                    921 |
> + *  | 113M  |                   1081 |
> + *  | 114M  |                   1254 |
> + *  | 115M  |                   1439 |
> + *  | 116M  |                   1638 |
> + *  | 117M  |                   1849 |
> + *  | 118M  |                   2000 |
> + *  | 119M  |                   2000 |
> + *  | 120M  |                   2000 |
> + *  +-------+------------------------+
> + */
> + #define MEMCG_DELAY_PRECISION_SHIFT 20
> + #define MEMCG_DELAY_SCALING_SHIFT 14
> +
>  /*
>   * Scheduled by try_charge() to be executed from the userland return path
>   * and reclaims memory over the high limit.
>   */
>  void mem_cgroup_handle_over_high(void)
>  {
> +	unsigned long usage, high;
> +	unsigned long pflags;
> +	unsigned long penalty_jiffies, overage;
>  	unsigned int nr_pages = current->memcg_nr_pages_over_high;
>  	struct mem_cgroup *memcg = current->memcg_high_reclaim;
>  
> @@ -2279,9 +2336,68 @@ void mem_cgroup_handle_over_high(void)
>  		memcg = get_mem_cgroup_from_mm(current->mm);
>  
>  	reclaim_high(memcg, nr_pages, GFP_KERNEL);
> -	css_put(&memcg->css);
>  	current->memcg_high_reclaim = NULL;
>  	current->memcg_nr_pages_over_high = 0;
> +
> +	/*
> +	 * memory.high is breached and reclaim is unable to keep up. Throttle
> +	 * allocators proactively to slow down excessive growth.
> +	 *
> +	 * We use overage compared to memory.high to calculate the number of
> +	 * jiffies to sleep (penalty_jiffies). Ideally this value should be
> +	 * fairly lenient on small overages, and increasingly harsh when the
> +	 * memcg in question makes it clear that it has no intention of stopping
> +	 * its crazy behaviour, so we exponentially increase the delay based on
> +	 * overage amount.
> +	 */
> +
> +	usage = page_counter_read(&memcg->memory);
> +	high = READ_ONCE(memcg->high);
> +
> +	if (usage <= high)
> +		goto out;
> +
> +	overage = ((u64)(usage - high) << MEMCG_DELAY_PRECISION_SHIFT) / high;
> +	penalty_jiffies = ((u64)overage * overage * HZ)
> +		>> (MEMCG_DELAY_PRECISION_SHIFT + MEMCG_DELAY_SCALING_SHIFT);
> +
> +	/*
> +	 * Factor in the task's own contribution to the overage, such that four
> +	 * N-sized allocations are throttled approximately the same as one
> +	 * 4N-sized allocation.
> +	 *
> +	 * MEMCG_CHARGE_BATCH pages is nominal, so work out how much smaller or
> +	 * larger the current charge patch is than that.
> +	 */
> +	penalty_jiffies = penalty_jiffies * nr_pages / MEMCG_CHARGE_BATCH;
> +
> +	/*
> +	 * Clamp the max delay per usermode return so as to still keep the
> +	 * application moving forwards and also permit diagnostics, albeit
> +	 * extremely slowly.
> +	 */
> +	penalty_jiffies = min(penalty_jiffies, MEMCG_MAX_HIGH_DELAY_JIFFIES);
> +
> +	/*
> +	 * Don't sleep if the amount of jiffies this memcg owes us is so low
> +	 * that it's not even worth doing, in an attempt to be nice to those who
> +	 * go only a small amount over their memory.high value and maybe haven't
> +	 * been aggressively reclaimed enough yet.
> +	 */
> +	if (penalty_jiffies <= HZ / 100)
> +		goto out;
> +
> +	/*
> +	 * If we exit early, we're guaranteed to die (since
> +	 * schedule_timeout_killable sets TASK_KILLABLE). This means we don't
> +	 * need to account for any ill-begotten jiffies to pay them off later.
> +	 */
> +	psi_memstall_enter(&pflags);
> +	schedule_timeout_killable(penalty_jiffies);
> +	psi_memstall_leave(&pflags);
> +
> +out:
> +	css_put(&memcg->css);
>  }
>  
>  static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
> -- 
> 2.21.0

-- 
Michal Hocko
SUSE Labs
