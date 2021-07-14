Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E4D3C949B
	for <lists+cgroups@lfdr.de>; Thu, 15 Jul 2021 01:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbhGNXrF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 14 Jul 2021 19:47:05 -0400
Received: from foss.arm.com ([217.140.110.172]:44118 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229535AbhGNXrF (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 14 Jul 2021 19:47:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B578F31B;
        Wed, 14 Jul 2021 16:44:12 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E5C43F7D8;
        Wed, 14 Jul 2021 16:44:10 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Nitesh Lal <nilal@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Saenz <nsaenzju@redhat.com>,
        Christoph Lameter <cl@gentwo.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org
Subject: Re: [RFC PATCH 6/6] cpuset: Add cpuset.isolation_mask file
In-Reply-To: <20210714231338.GA65963@lothringen>
References: <20210714135420.69624-1-frederic@kernel.org> <20210714135420.69624-7-frederic@kernel.org> <YO8WWxWBmNuI0iUW@hirez.programming.kicks-ass.net> <20210714231338.GA65963@lothringen>
Date:   Thu, 15 Jul 2021 00:44:08 +0100
Message-ID: <87o8b4mpfb.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 15/07/21 01:13, Frederic Weisbecker wrote:
> On Wed, Jul 14, 2021 at 06:52:43PM +0200, Peter Zijlstra wrote:
>>
>> cpusets already has means to create paritions; why are you creating
>> something else?
>
> I was about to answer that the semantics of isolcpus, which reference
> a NULL domain, are different from SD_LOAD_BALANCE implied by
> cpuset.sched_load_balance. But then I realize that SD_LOAD_BALANCE has
> been removed.
>
> How cpuset.sched_load_balance is implemented then? Commit
> e669ac8ab952df2f07dee1e1efbf40647d6de332 ("sched: Remove checks against
> SD_LOAD_BALANCE") advertize that setting cpuset.sched_load_balance to 0
> ends up creating NULL domain but that's not what I get. For example if I
> mount a single cpuset root (no other cpuset mountpoints):
>
> $ mount -t cgroup none ./cpuset -o cpuset
> $ cd cpuset
> $ cat cpuset.cpus
> 0-7
> $ cat cpuset.sched_load_balance
> 1
> $ echo 0 > cpuset.sched_load_balance
> $ ls /sys/kernel/debug/domains/cpu1/
> domain0  domain1
>
> I still get the domains on all CPUs...

Huh. That's on v5.14-rc1 with an automounted cpuset:

$ cat /sys/fs/cgroup/cpuset/cpuset.cpus
0-5
$ cat /sys/fs/cgroup/cpuset/cpuset.sched_load_balance
1

$ ls /sys/kernel/debug/sched/domains/cpu*
/sys/kernel/debug/sched/domains/cpu0:
domain0  domain1

/sys/kernel/debug/sched/domains/cpu1:
domain0  domain1

/sys/kernel/debug/sched/domains/cpu2:
domain0  domain1

/sys/kernel/debug/sched/domains/cpu3:
domain0  domain1

/sys/kernel/debug/sched/domains/cpu4:
domain0  domain1

/sys/kernel/debug/sched/domains/cpu5:
domain0  domain1

$ echo 0 > /sys/fs/cgroup/cpuset/cpuset.sched_load_balance
$ ls /sys/kernel/debug/sched/domains/cpu*
/sys/kernel/debug/sched/domains/cpu0:

/sys/kernel/debug/sched/domains/cpu1:

/sys/kernel/debug/sched/domains/cpu2:

/sys/kernel/debug/sched/domains/cpu3:

/sys/kernel/debug/sched/domains/cpu4:

/sys/kernel/debug/sched/domains/cpu5:


I also checked that you can keep cpuset.sched_load_balance=0 at the root
and create exclusive child cpusets with different values of
sched_load_balance, giving you some CPUs attached to the NULL domain and
some others with a sched_domain hierarchy that stays within the cpuset span.
