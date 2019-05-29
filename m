Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB4192E54C
	for <lists+cgroups@lfdr.de>; Wed, 29 May 2019 21:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbfE2T2u (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 29 May 2019 15:28:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54883 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbfE2T2u (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 29 May 2019 15:28:50 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A2586300414E;
        Wed, 29 May 2019 19:28:39 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B35960C4E;
        Wed, 29 May 2019 19:28:35 +0000 (UTC)
Date:   Wed, 29 May 2019 15:28:33 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Dave Chiluk <chiluk+linux@indeed.com>
Cc:     Ben Segall <bsegall@google.com>, Peter Oskolkov <posk@posk.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Brendan Gregg <bgregg@netflix.com>,
        Kyle Anderson <kwa@yelp.com>,
        Gabriel Munos <gmunoz@netflix.com>,
        John Hammond <jhammond@indeed.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 1/1] sched/fair: Fix low cpu usage with high
 throttling by removing expiration of cpu-local slices
Message-ID: <20190529192833.GF26206@pauld.bos.csb>
References: <1558121424-2914-1-git-send-email-chiluk+linux@indeed.com>
 <1559156926-31336-1-git-send-email-chiluk+linux@indeed.com>
 <1559156926-31336-2-git-send-email-chiluk+linux@indeed.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559156926-31336-2-git-send-email-chiluk+linux@indeed.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 29 May 2019 19:28:49 +0000 (UTC)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 29, 2019 at 02:08:46PM -0500 Dave Chiluk wrote:
> It has been observed, that highly-threaded, non-cpu-bound applications
> running under cpu.cfs_quota_us constraints can hit a high percentage of
> periods throttled while simultaneously not consuming the allocated
> amount of quota.  This use case is typical of user-interactive non-cpu
> bound applications, such as those running in kubernetes or mesos when
> run on multiple cpu cores.
> 
> This has been root caused to threads being allocated per cpu bandwidth
> slices, and then not fully using that slice within the period. At which
> point the slice and quota expires.  This expiration of unused slice
> results in applications not being able to utilize the quota for which
> they are allocated.
> 
> The expiration of per-cpu slices was recently fixed by
> 'commit 512ac999d275 ("sched/fair: Fix bandwidth timer clock drift
> condition")'.  Prior to that it appears that this has been broken since
> at least 'commit 51f2176d74ac ("sched/fair: Fix unlocked reads of some
> cfs_b->quota/period")' which was introduced in v3.16-rc1 in 2014.  That
> added the following conditional which resulted in slices never being
> expired.
> 
> if (cfs_rq->runtime_expires != cfs_b->runtime_expires) {
> 	/* extend local deadline, drift is bounded above by 2 ticks */
> 	cfs_rq->runtime_expires += TICK_NSEC;
> 
> Because this was broken for nearly 5 years, and has recently been fixed
> and is now being noticed by many users running kubernetes
> (https://github.com/kubernetes/kubernetes/issues/67577) it is my opinion
> that the mechanisms around expiring runtime should be removed
> altogether.
> 
> This allows only per-cpu slices to live longer than the period boundary.
> This allows threads on runqueues that do not use much CPU to continue to
> use their remaining slice over a longer period of time than
> cpu.cfs_period_us. However, this helps prevents the above condition of
> hitting throttling while also not fully utilizing your cpu quota.
> 
> This theoretically allows a machine to use slightly more than it's
> allotted quota in some periods.  This overflow would be bounded by the
> remaining per-cpu slice that was left un-used in the previous period.
> For CPU bound tasks this will change nothing, as they should
> theoretically fully utilize all of their quota and slices in each
> period. For user-interactive tasks as described above this provides a
> much better user/application experience as their cpu utilization will
> more closely match the amount they requested when they hit throttling.
> 
> This greatly improves performance of high-thread-count, non-cpu bound
> applications with low cfs_quota_us allocation on high-core-count
> machines. In the case of an artificial testcase, this performance
> discrepancy has been observed to be almost 30x performance improvement,
> while still maintaining correct cpu quota restrictions albeit over
> longer time intervals than cpu.cfs_period_us.  That testcase is
> available at https://github.com/indeedeng/fibtest.
> 
> Fixes: 512ac999d275 ("sched/fair: Fix bandwidth timer clock drift condition")
> Signed-off-by: Dave Chiluk <chiluk+linux@indeed.com>
> ---
>  Documentation/scheduler/sched-bwc.txt | 56 ++++++++++++++++++++++-----
>  kernel/sched/fair.c                   | 71 +++--------------------------------
>  kernel/sched/sched.h                  |  4 --
>  3 files changed, 53 insertions(+), 78 deletions(-)
> 
> diff --git a/Documentation/scheduler/sched-bwc.txt b/Documentation/scheduler/sched-bwc.txt
> index f6b1873..260fd65 100644
> --- a/Documentation/scheduler/sched-bwc.txt
> +++ b/Documentation/scheduler/sched-bwc.txt
> @@ -8,15 +8,16 @@ CFS bandwidth control is a CONFIG_FAIR_GROUP_SCHED extension which allows the
>  specification of the maximum CPU bandwidth available to a group or hierarchy.
>  
>  The bandwidth allowed for a group is specified using a quota and period. Within
> -each given "period" (microseconds), a group is allowed to consume only up to
> -"quota" microseconds of CPU time.  When the CPU bandwidth consumption of a
> -group exceeds this limit (for that period), the tasks belonging to its
> -hierarchy will be throttled and are not allowed to run again until the next
> -period.
> -
> -A group's unused runtime is globally tracked, being refreshed with quota units
> -above at each period boundary.  As threads consume this bandwidth it is
> -transferred to cpu-local "silos" on a demand basis.  The amount transferred
> +each given "period" (microseconds), a task group is allocated up to "quota"
> +microseconds of CPU time.  That quota is assigned to per cpu run queues in
> +slices as threads in the cgroup become runnable.  Once all quota has been
> +assigned any additional requests for quota will result in those threads being
> +throttled.  Throttled threads will not be able to run again until the next
> +period when the quota is replenished.
> +
> +A group's unassigned quota is globally tracked, being refreshed back to
> +cfs_quota units at each period boundary.  As threads consume this bandwidth it
> +is transferred to cpu-local "silos" on a demand basis.  The amount transferred
>  within each of these updates is tunable and described as the "slice".
>  
>  Management
> @@ -90,6 +91,43 @@ There are two ways in which a group may become throttled:
>  In case b) above, even though the child may have runtime remaining it will not
>  be allowed to until the parent's runtime is refreshed.
>  
> +Real-world behavior of slice non-expiration
> +-------------------------------------------
> +The fact that cpu-local slices do not expire results in some interesting corner
> +cases that should be understood.
> +
> +For cgroup cpu constrained applications that are cpu limited this is a
> +relatively moot point because they will naturally consume the entirety of their
> +quota as well as the entirety of each cpu-local slice in each period.  As a
> +result it is expected that nr_periods roughly equal nr_throttled, and that
> +cpuacct.usage will increase roughly equal to cfs_quota_us in each period.
> +
> +However in a worst-case scenario, highly-threaded, interactive/non-cpu bound
> +applications this non-expiration nuance allows applications to briefly burst
> +past their quota limits by the amount of unused slice on each cpu that the task
> +group is running on.  This slight burst requires that quota had been assigned
> +and then not fully used in previous periods.  This burst amount will not be
> +transferred between cores.  As a result, this mechanism still strictly limits
> +the task group to quota average usage, albeit over a longer time window than
> +period.  This provides better more predictable user experience for highly
> +threaded applications with small quota limits on high core count machines.  It
> +also eliminates the propensity to throttle these applications while
> +simultanously using less than quota amounts of cpu.  Another way to say this,
> +is that by allowing the unused portion of a slice to remain valid across
> +periods we have decreased the possibility of wasting quota on cpu-local silos
> +that don't need a full slice's amount of cpu time.
> +
> +The interaction between cpu-bound and non-cpu-bound-interactive applications
> +should also be considered, especially when single core usage hits 100%.  If you
> +gave each of these applications half of a cpu-core and they both got scheduled
> +on the same CPU it is theoretically possible that the non-cpu bound application
> +will use up to sched_cfs_bandwidth_slice_us additional quota in some periods,
> +thereby preventing the cpu-bound application from fully using it's quota by


"its quota"


> +that same amount.  In these instances it will be up to the CFS algorithm (see
> +sched-design-CFS.txt) to decide which application is chosen to run, as they
> +will both be runnable and have remaining quota.  This runtime discrepancy will
> +should made up in the following periods when the interactive application idles.
> +


"discrepancy will be made"  or "descrepancy should be made"  but not both :)



Otherwise, fwiw, 

Acked-by:  Phil Auld <pauld@redhat.com>



Cheers,
Phil


-- 
