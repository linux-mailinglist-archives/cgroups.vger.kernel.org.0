Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3244A81FB
	for <lists+cgroups@lfdr.de>; Thu,  3 Feb 2022 10:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234483AbiBCJyM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 3 Feb 2022 04:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiBCJyL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 3 Feb 2022 04:54:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9774DC061714
        for <cgroups@vger.kernel.org>; Thu,  3 Feb 2022 01:54:11 -0800 (PST)
Date:   Thu, 3 Feb 2022 10:54:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643882048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zdELBxlfBs+RZUwmCEVQd1bUq7O2YyUtK61hoTYBgqg=;
        b=IfJmhtbwX2obrfSDNgct9EwtFtBmqz0EJ887+lW17EFlNEbw+vhQfGZE7FhV6/SGy7QM5y
        jN8X1B1nSRWlFl2F1nl/m7JV+oHwNJN3XJPKTBiMK9GHPNck1ClVPtujVKIE4kG6nkDNc5
        iR9T1SAXjdHCJs00P4hnfqzN3HM+B8KpAcRxcvEjSUpvTiElVCMbjf+Zkeeg1VoHITV23o
        k4v+9jexPWzxbfh0stdGq5DJ08xhxlYJImY+ynQ8FqSjXXZ/JQNGDm027hjl9uvDSo6Dnc
        tNTU4mt+wi1dZhUDMPhkMbP9VoRBVmt+0iRyyXRBf8zTjWvZHzQrKkFYxjjzVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643882048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zdELBxlfBs+RZUwmCEVQd1bUq7O2YyUtK61hoTYBgqg=;
        b=n+xCuimFf8XggWNU87WmjzdNQ0+gYt/+hK2eC85G0DeT2CAyAiati4G2XEbobv1EQ061DI
        LmAFwAbmAOjC6SAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Waiman Long <longman@redhat.com>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH 3/4] mm/memcg: Add a local_lock_t for IRQ and TASK object.
Message-ID: <YfumP3u1VCjKHE3b@linutronix.de>
References: <20220125164337.2071854-1-bigeasy@linutronix.de>
 <20220125164337.2071854-4-bigeasy@linutronix.de>
 <YfFmxH1IXeegNOa9@dhcp22.suse.cz>
 <YfKHxKda7bGJmrLJ@linutronix.de>
 <YfkhsiWHzsyQSBfl@dhcp22.suse.cz>
 <Yfkjjamj09lZn4sA@linutronix.de>
 <YflR3/RuGjYuQZPH@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YflR3/RuGjYuQZPH@dhcp22.suse.cz>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2022-02-01 16:29:35 [+0100], Michal Hocko wrote:
> > > Sorry, I know that this all is not really related to your work but if
> > > the original optimization is solely based on artificial benchmarks then
> > > I would rather drop it and also make your RT patchset easier.
> > 
> > Do you have any real-world benchmark in mind? Like something that is
> > already used for testing/ benchmarking and would fit here?
> 
> Anything that even remotely resembles a real allocation heavy workload.

So I figured out that build the kernel as user triggers the allocation
path in_task() and in_interrupt(). I booted a PREEMPT_NONE kernel and
run "perf stat -r 5 b.sh" where b.sh unpacks a kernel and runs a
allmodconfig build on /dev/shm. The slow disk should not be a problem.

With the optimisation:
|  Performance counter stats for './b.sh' (5 runs):
| 
|       43.367.405,59 msec task-clock                #   30,901 CPUs utilized            ( +-  0,01% )
|           7.393.238      context-switches          #  170,499 /sec                     ( +-  0,13% )
|             832.364      cpu-migrations            #   19,196 /sec                     ( +-  0,15% )
|         625.235.644      page-faults               #   14,419 K/sec                    ( +-  0,00% )
| 103.822.081.026.160      cycles                    #    2,394 GHz                      ( +-  0,01% )
|  75.392.684.840.822      stalled-cycles-frontend   #   72,63% frontend cycles idle     ( +-  0,02% )
|  54.971.177.787.990      stalled-cycles-backend    #   52,95% backend cycles idle      ( +-  0,02% )
|  69.543.893.308.966      instructions              #    0,67  insn per cycle
|                                                    #    1,08  stalled cycles per insn  ( +-  0,00% )
|  14.585.269.354.314      branches                  #  336,357 M/sec                    ( +-  0,00% )
|     558.029.270.966      branch-misses             #    3,83% of all branches          ( +-  0,01% )
|  
|            1403,441 +- 0,466 seconds time elapsed  ( +-  0,03% )


With the optimisation disabled:
|  Performance counter stats for './b.sh' (5 runs):
| 
|       43.354.742,31 msec task-clock                #   30,869 CPUs utilized            ( +-  0,01% )
|           7.394.210      context-switches          #  170,601 /sec                     ( +-  0,06% )
|             842.835      cpu-migrations            #   19,446 /sec                     ( +-  0,63% )
|         625.242.341      page-faults               #   14,426 K/sec                    ( +-  0,00% )
| 103.791.714.272.978      cycles                    #    2,395 GHz                      ( +-  0,01% )
|  75.369.652.256.425      stalled-cycles-frontend   #   72,64% frontend cycles idle     ( +-  0,01% )
|  54.947.610.706.450      stalled-cycles-backend    #   52,96% backend cycles idle      ( +-  0,01% )
|  69.529.388.440.691      instructions              #    0,67  insn per cycle
|                                                    #    1,08  stalled cycles per insn  ( +-  0,01% )
|  14.584.515.016.870      branches                  #  336,497 M/sec                    ( +-  0,00% )
|     557.716.885.609      branch-misses             #    3,82% of all branches          ( +-  0,02% )
|  
|             1404,47 +- 1,05 seconds time elapsed  ( +-  0,08% )

I'm still open to a more specific test ;)

Sebastian
