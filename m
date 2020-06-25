Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E05209A1B
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2020 08:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390066AbgFYGud (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Jun 2020 02:50:33 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60974 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389406AbgFYGub (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 Jun 2020 02:50:31 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id 3AC352A07BE
Subject: Re: stable-rc/linux-5.6.y bisection: baseline.dmesg.crit on
 bcm2837-rpi-3-b
To:     Tejun Heo <tj@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Sasha Levin <sashal@kernel.org>
Cc:     Li Zefan <lizefan@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org
References: <5ef43529.1c69fb81.eac8c.85c7@mx.google.com>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <dd967873-e7ef-43da-26b5-d7def1ed7abc@collabora.com>
Date:   Thu, 25 Jun 2020 07:50:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <5ef43529.1c69fb81.eac8c.85c7@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 25/06/2020 06:24, kernelci.org bot wrote:
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> * This automated bisection report was sent to you on the basis  *
> * that you may be involved with the breaking commit it has      *
> * found.  No manual investigation has been done to verify it,   *
> * and the root cause of the problem may be somewhere else.      *
> *                                                               *
> * If you do send a fix, please include this trailer:            *
> *   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
> *                                                               *
> * Hope this helps!                                              *
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> 
> stable-rc/linux-5.6.y bisection: baseline.dmesg.crit on bcm2837-rpi-3-b
> 
> Summary:
>   Start:      61aba373f570 Linux 5.6.19
>   Plain log:  https://storage.kernelci.org/stable-rc/linux-5.6.y/v5.6.19/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.txt
>   HTML log:   https://storage.kernelci.org/stable-rc/linux-5.6.y/v5.6.19/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.html
>   Result:     9cf5d5444c78 Revert "cgroup: Add memory barriers to plug cgroup_rstat_updated() race window"
> 
> Checks:
>   revert:     PASS
>   verify:     PASS
> 
> Parameters:
>   Tree:       stable-rc
>   URL:        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
>   Branch:     linux-5.6.y
>   Target:     bcm2837-rpi-3-b
>   CPU arch:   arm64
>   Lab:        lab-baylibre
>   Compiler:   gcc-8
>   Config:     defconfig
>   Test case:  baseline.dmesg.crit

The "crit" kernel message is:

[   17.536674] hwmon hwmon1: Undervoltage detected!

which is a known intermittent issue on rpi-3-b that is most
likely to be unrelated to the patch found by this bisection.

Maybe the bisection landed on this patch because it makes the
undervoltage more likely by a side effect, if it affects timing
or the binary size or addresses in very subtle ways.  But even
then it wouldn't be a regression.

We should stop running bisections on rpi-3-b, at least for this
kernel error message, until it has been fixed to avoid future
false positives.

Sorry for the noise.

Guillaume


> Breaking commit found:
> 
> -------------------------------------------------------------------------------
> commit 9cf5d5444c78c14bb9f90dd21cef361ee14ba64b
> Author: Tejun Heo <tj@kernel.org>
> Date:   Thu Apr 9 14:55:35 2020 -0400
> 
>     Revert "cgroup: Add memory barriers to plug cgroup_rstat_updated() race window"
>     
>     [ Upstream commit d8ef4b38cb69d907f9b0e889c44d05fc0f890977 ]
>     
>     This reverts commit 9a9e97b2f1f2 ("cgroup: Add memory barriers to plug
>     cgroup_rstat_updated() race window").
>     
>     The commit was added in anticipation of memcg rstat conversion which needed
>     synchronous accounting for the event counters (e.g. oom kill count). However,
>     the conversion didn't get merged due to percpu memory overhead concern which
>     couldn't be addressed at the time.
>     
>     Unfortunately, the patch's addition of smp_mb() to cgroup_rstat_updated()
>     meant that every scheduling event now had to go through an additional full
>     barrier and Mel Gorman noticed it as 1% regression in netperf UDP_STREAM test.
>     
>     There's no need to have this barrier in tree now and even if we need
>     synchronous accounting in the future, the right thing to do is separating that
>     out to a separate function so that hot paths which don't care about
>     synchronous behavior don't have to pay the overhead of the full barrier. Let's
>     revert.
>     
>     Signed-off-by: Tejun Heo <tj@kernel.org>
>     Reported-by: Mel Gorman <mgorman@techsingularity.net>
>     Link: http://lkml.kernel.org/r/20200409154413.GK3818@techsingularity.net
>     Cc: v4.18+
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> index 6f87352f8219..41ca996568df 100644
> --- a/kernel/cgroup/rstat.c
> +++ b/kernel/cgroup/rstat.c
> @@ -33,12 +33,9 @@ void cgroup_rstat_updated(struct cgroup *cgrp, int cpu)
>  		return;
>  
>  	/*
> -	 * Paired with the one in cgroup_rstat_cpu_pop_updated().  Either we
> -	 * see NULL updated_next or they see our updated stat.
> -	 */
> -	smp_mb();
> -
> -	/*
> +	 * Speculative already-on-list test. This may race leading to
> +	 * temporary inaccuracies, which is fine.
> +	 *
>  	 * Because @parent's updated_children is terminated with @parent
>  	 * instead of NULL, we can tell whether @cgrp is on the list by
>  	 * testing the next pointer for NULL.
> @@ -134,13 +131,6 @@ static struct cgroup *cgroup_rstat_cpu_pop_updated(struct cgroup *pos,
>  		*nextp = rstatc->updated_next;
>  		rstatc->updated_next = NULL;
>  
> -		/*
> -		 * Paired with the one in cgroup_rstat_cpu_updated().
> -		 * Either they see NULL updated_next or we see their
> -		 * updated stat.
> -		 */
> -		smp_mb();
> -
>  		return pos;
>  	}
> -------------------------------------------------------------------------------
> 
> 
> Git bisection log:
> 
> -------------------------------------------------------------------------------
> git bisect start
> # good: [7111951b8d4973bda27ff663f2cf18b663d15b48] Linux 5.6
> git bisect good 7111951b8d4973bda27ff663f2cf18b663d15b48
> # bad: [61aba373f5708f2aebc3f72078e51949a068aa6f] Linux 5.6.19
> git bisect bad 61aba373f5708f2aebc3f72078e51949a068aa6f
> # good: [0bc4d081e87ef8fd43baeed7141267e558896f86] RDMA/cm: Fix an error check in cm_alloc_id_priv()
> git bisect good 0bc4d081e87ef8fd43baeed7141267e558896f86
> # good: [0deceb85de592b89f6476e2bfcb5321a95d23126] dmaengine: owl: Use correct lock in owl_dma_get_pchan()
> git bisect good 0deceb85de592b89f6476e2bfcb5321a95d23126
> # bad: [566f16e2d62fb3817529a05147ef46046ecffe6a] io_uring: initialize ctx->sqo_wait earlier
> git bisect bad 566f16e2d62fb3817529a05147ef46046ecffe6a
> # good: [23952755bc2f839844b5a60c29620cce98c9b09d] riscv: stacktrace: Fix undefined reference to `walk_stackframe'
> git bisect good 23952755bc2f839844b5a60c29620cce98c9b09d
> # good: [be31933db49c8e3d81b96ee6bc9933d2adafe13d] drm/amd/display: Fix potential integer wraparound resulting in a hang
> git bisect good be31933db49c8e3d81b96ee6bc9933d2adafe13d
> # good: [ee899046f79db390650e546446a7a0196788d39d] esp6: get the right proto for transport mode in esp6_gso_encap
> git bisect good ee899046f79db390650e546446a7a0196788d39d
> # good: [bdd07c33a3be1896ec1982fab1a2baf986fbe4dc] netfilter: conntrack: comparison of unsigned in cthelper confirmation
> git bisect good bdd07c33a3be1896ec1982fab1a2baf986fbe4dc
> # bad: [46f4a75fb5034c8d80a5388fe3bb46a8ed05df5b] ARC: [plat-eznps]: Restrict to CONFIG_ISA_ARCOMPACT
> git bisect bad 46f4a75fb5034c8d80a5388fe3bb46a8ed05df5b
> # good: [960a4cc3ec49f8292d0f837f0a6b28b03c54f042] Linux 5.6.16
> git bisect good 960a4cc3ec49f8292d0f837f0a6b28b03c54f042
> # bad: [9cf5d5444c78c14bb9f90dd21cef361ee14ba64b] Revert "cgroup: Add memory barriers to plug cgroup_rstat_updated() race window"
> git bisect bad 9cf5d5444c78c14bb9f90dd21cef361ee14ba64b
> # good: [2df9b670ad1a2120f54982e1b1dfd17a6ce3cc0c] x86/syscalls: Revert "x86/syscalls: Make __X32_SYSCALL_BIT be unsigned long"
> git bisect good 2df9b670ad1a2120f54982e1b1dfd17a6ce3cc0c
> # first bad commit: [9cf5d5444c78c14bb9f90dd21cef361ee14ba64b] Revert "cgroup: Add memory barriers to plug cgroup_rstat_updated() race window"
> -------------------------------------------------------------------------------
> 

