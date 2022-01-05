Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0684859F7
	for <lists+cgroups@lfdr.de>; Wed,  5 Jan 2022 21:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243997AbiAEUXC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Jan 2022 15:23:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44542 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243981AbiAEUXA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 Jan 2022 15:23:00 -0500
Date:   Wed, 5 Jan 2022 21:22:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1641414178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LOao1x3rW80whTHJj9FXyOwdSWmkeKxabYbL4+VTmxU=;
        b=sojvPSlnwE8W6VvnR2r0MnpVcPcXKz6S7RelmeHp+obUcGSxPP/VuzffajxloTyDcsn+xA
        d2IoAurx5vH925toPbaEGBdk2rFiFcfTw2rJcoHE8XrqWHNohzRMboAuCPqq/9K5RB9fQN
        zIYbRC0zkq79mdgrPKJl1pkes5dMhaTA2qws8sTxhw73YxdgNU/lqxpkBi7TyaEuq2amGv
        UVm58X6wGIGDvTPipYBUDb9VH6/Hi4YfiBQpXYDOw7+3VJM/UW2X8vUmvem1fl1GZKLPQ0
        soJFdzVhY7MWotqm4V4ut6UbfhUvhpLhS1qPgwnBEgEWej/AZtmtxx7vetD+Zg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1641414178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LOao1x3rW80whTHJj9FXyOwdSWmkeKxabYbL4+VTmxU=;
        b=mfyAOJuI0VzFe6AlQ2wvdHkZce8HVra6z0Rl1NqzWKZ3ViUaz2W7G6eSJE+J6Af3mu4F25
        9Wmb0VqnLb3ZjQDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Waiman Long <longman@redhat.com>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 3/3] mm/memcg: Allow the task_obj optimization only
 on non-PREEMPTIBLE kernels.
Message-ID: <YdX+INO9gQje6d0S@linutronix.de>
References: <20211222114111.2206248-1-bigeasy@linutronix.de>
 <20211222114111.2206248-4-bigeasy@linutronix.de>
 <f6bb93c8-3940-6141-d0e0-50144549a4f5@redhat.com>
 <YdML2zaU17clEZgt@linutronix.de>
 <df637005-6c72-a1c6-c6b9-70f81f74884d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <df637005-6c72-a1c6-c6b9-70f81f74884d@redhat.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2022-01-03 10:04:29 [-0500], Waiman Long wrote:
> On 1/3/22 09:44, Sebastian Andrzej Siewior wrote:
> > Is there something you recommend as a benchmark where I could get some
> > numbers?
>=20
> In the case of PREEMPT_DYNAMIC, it depends on the default setting which is
> used by most users. I will support disabling the optimization if
> defined(CONFIG_PREEMPT_RT) || defined(CONFIG_PREEMPT), just not by
> CONFIG_)PREEMPTION alone.
>=20
> As for microbenchmark, something that makes a lot of calls to malloc() or
> related allocations can be used.

Numbers I made:

        Sandy Bridge   Haswell        Skylake         AMD-A8 7100    Zen2  =
         ARM64
PREEMPT 5,123,896,822  5,215,055,226   5,077,611,590  6,012,287,874  6,234,=
674,489  20,000,000,100
IRQ     7,494,119,638  6,810,367,629  10,620,130,377  4,178,546,086  4,898,=
076,012  13,538,461,925

For micro benchmarking I did 1.000.000.000 iterations of
preempt_disable()/enable() [PREEMPT] and local_irq_save()/restore()
[IRQ].
On a Sandy Bridge the PREEMPT loop took 5,123,896,822ns while the IRQ
loop took 7,494,119,638ns. The absolute numbers are not important, it is
worth noting that preemption off/on is less expensive than IRQ off/on.
Except for AMD and ARM64 where IRQ off/on was less expensive. The whole
loop was performed with disabled interrupts so I don't expect much
interference - but then I don't know much the =C2=B5Arch optimized away on
local_irq_restore() given that the interrupts were already disabled.
I don't have any recent Intel HW (I think) so I don't know if this is an
Intel only thing (IRQ off/on cheaper than preemption off/on) but I guess
that the recent uArch would behave similar to AMD.

Moving on: For the test I run 100,000,000 iterations of
     kfree(kmalloc(128, GFP_ATOMIC | __GFP_ACCOUNT));

The BH suffix means that in_task() reported false during the allocation,
otherwise it reported true.
SD is the standard deviation.
SERVER means PREEMPT_NONE while PREEMPT means CONFIG_PREEMPT.
OPT means the optimisation (in_task() + task_obj) is active, NO-OPT
means no optimisation (irq_obj is always used).
The numbers are the time in ns needed for 100,000,000 iteration (alloc +
free). I run 5 tests and used the median value here. If the standard
deviation exceeded 10^9 then I repeated the test. The values remained in
the same range since usually only one value was off and the other
remained in the same range.

Sandy Bridge
                 SERVER OPT   SERVER NO-OPT    PREEMPT OPT     PREEMPT NO-O=
PT
ALLOC/FREE    8,519,295,176   9,051,200,652    10,627,431,395  11,198,189,8=
43
SD                5,309,768      29,253,976       129,102,317      40,681,9=
09
ALLOC/FREE BH 9,996,704,330   8,927,026,031    11,680,149,900  11,139,356,4=
65
SD               38,237,534      72,913,120        23,626,932     116,413,3=
31

The optimisation is visible in the SERVER-OPT case (~1.5s difference in
the runtime (or 14.7ns per iteration)). There is hardly any difference
between BH and !BH in the SERVER-NO-OPT case.
For the SERVER case, the optimisation improves ~0.5s in runtime for the
!BH case.
For the PREEMPT case it also looks like ~0.5s improvement in the BH case
while in the BH case it looks the other way around.

                 DYN-SRV-OPT   DYN-SRV-NO-OPT    DYN-FULL-OPT   DYN-FULL-NO=
-OPT
ALLOC/FREE     11,069,180,584  10,773,407,543  10,963,581,285    10,826,207=
,969
SD                 23,195,912     112,763,104      13,145,589        33,543=
,625
ALLOC/FREE BH  11,443,342,069  10,720,094,700  11,064,914,727    10,955,883=
,521
SD                 81,150,074     171,299,554      58,603,778        84,131=
,143

DYN is CONFIG_PREEMPT_DYNAMIC enabled and CONFIG_PREEMPT_NONE is
default.  I don't see any difference vs CONFIG_PREEMPT except the
default preemption state (so I didn't test that). The preemption counter
is always forced-in so preempt_enable()/disable() is not optimized away.
SRV is the default value (PREEMPT_NONE) and FULL is the overriden
(preempt=3Dfull) state.

Based on that, I don't see any added value by the optimisation once
PREEMPT_DYNAMIC is enabled.

----
Zen2:
                 SERVER OPT   SERVER NO-OPT   PREEMPT OPT      PREEMPT NO-O=
PT
ALLOC/FREE    8,126,735,313   8,751,307,383    9,822,927,142   10,045,105,4=
25
SD              100,806,471      87,234,047       55,170,179       25,832,3=
86
ALLOC/FREE BH 9,197,455,885   8,394,337,053   10,671,227,095    9,904,954,9=
34
SD              155,223,919      57,800,997       47,529,496      105,260,5=
66

On Zen2, the IRQ off/on was less expensive than preempt-off/on. So it
looks like I mixed up the numbers in for PREEMPT OPT and NO-OPT but I
re-run it twice and nothing significant changed=E2=80=A6 However the differ=
ence
on PREEMPT for the !BH case is not as significant as on Sandy Bridge
(~200ms here vs ~500ms there).

                 DYN-SRV-OPT   DYN-SRV-NO-OPT    DYN-FULL-OPT  DYN-FULL-NO-=
OPT
ALLOC/FREE      9,680,498,929  10,180,973,847   9,644,453,405  10,224,416,8=
54
SD                 73,944,156      61,850,527      13,277,203     107,145,2=
12
ALLOC/FREE BH  10,680,074,634   9,956,695,323  10,704,442,515   9,942,155,9=
10
SD                 75,535,172      34,524,493      54,625,678      87,163,9=
20

For double testing and checking, the full git tree is available at [0]
and the script to parse the results is at [1].

[0] git://git.kernel.org/pub/scm/linux/kernel/git/bigeasy/staging memcg
[1] https://breakpoint.cc/parse-memcg.py

> Cheers,
> Longman

Sebastian
