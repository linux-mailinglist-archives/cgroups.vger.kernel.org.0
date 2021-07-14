Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7333C943D
	for <lists+cgroups@lfdr.de>; Thu, 15 Jul 2021 01:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhGNXQd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 14 Jul 2021 19:16:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:35562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229928AbhGNXQc (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 14 Jul 2021 19:16:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D618613B5;
        Wed, 14 Jul 2021 23:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626304420;
        bh=o0mDIUs1526mrpRK4KxArL/CQBdeSIY/Gl5t2TV+hs8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mI9LO31I1isUyOjRP0Uk812+LdZPasqkB9mc/RUEj4g+IVLbDsOQDtEwKCBsqdzqP
         ZXYdOCyQcXl7WvtXborY+saEmD23YoWuxOegpLFEdKLMOWWovNO0oR/zwcLWjT6KPC
         uc6fMjTOaRxR4//aJe0/j9Q16Mmn+zz4SVO9fkbpbTc3UkDcad88qr2E8p3+EVetmF
         9Wrxrr7o9EqX5N+KUYwmIgj025VbH3kbVaXj8Caxm73YyzVifQhVWvYWXEMcbuL7R0
         17j5WIlscgJa+aUdJenZiThkLDVXcK3eiHqKtJD/DXJEb0Pi2pkaEU0GCRyb68RxoL
         tC9LGmlUlHSUA==
Date:   Thu, 15 Jul 2021 01:13:38 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>
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
Message-ID: <20210714231338.GA65963@lothringen>
References: <20210714135420.69624-1-frederic@kernel.org>
 <20210714135420.69624-7-frederic@kernel.org>
 <YO8WWxWBmNuI0iUW@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YO8WWxWBmNuI0iUW@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jul 14, 2021 at 06:52:43PM +0200, Peter Zijlstra wrote:
> On Wed, Jul 14, 2021 at 03:54:20PM +0200, Frederic Weisbecker wrote:
> > Add a new cpuset.isolation_mask file in order to be able to modify the
> > housekeeping cpumask for each individual isolation feature on runtime.
> > In the future this will include nohz_full, unbound timers,
> > unbound workqueues, unbound kthreads, managed irqs, etc...
> > 
> > Start with supporting domain exclusion and CPUs passed through
> > "isolcpus=".
> > 
> > The cpuset.isolation_mask defaults to 0. Setting it to 1 will exclude
> > the given cpuset from the domains (they will be attached to NULL domain).
> > As long as a CPU is part of any cpuset with cpuset.isolation_mask set to
> > 1, it will remain isolated even if it overlaps with another cpuset that
> > has cpuset.isolation_mask  set to 0. The same applies to parent and
> > subdirectories.
> > 
> > If a cpuset is a subset of "isolcpus=", it automatically maps it and
> > cpuset.isolation_mask will be set to 1. This subset is then cleared from
> > the initial "isolcpus=" mask. The user is then free to override
> > cpuset.isolation_mask to 0 in order to revert the effect of "isolcpus=".
> > 
> > Here is an example of use where the CPU 7 has been isolated on boot and
> > get re-attached to domains later from cpuset:
> > 
> > 	$ cat /proc/cmdline
> > 		isolcpus=7
> > 	$ cd /sys/fs/cgroup/cpuset
> > 	$ mkdir cpu7
> > 	$ cd cpu7
> > 	$ cat cpuset.cpus
> > 		0-7
> > 	$ cat cpuset.isolation_mask
> > 		0
> > 	$ ls /sys/kernel/debug/domains/cpu7	# empty because isolcpus=7
> > 	$ echo 7 > cpuset.cpus
> > 	$ cat cpuset.isolation_mask	# isolcpus subset automatically mapped
> > 		1
> > 	$ echo 0 > cpuset.isolation_mask
> > 	$ ls /sys/kernel/debug/domains/cpu7/
> > 		domain0  domain1
> > 
> 
> cpusets already has means to create paritions; why are you creating
> something else?

I was about to answer that the semantics of isolcpus, which reference
a NULL domain, are different from SD_LOAD_BALANCE implied by
cpuset.sched_load_balance. But then I realize that SD_LOAD_BALANCE has
been removed.

How cpuset.sched_load_balance is implemented then? Commit
e669ac8ab952df2f07dee1e1efbf40647d6de332 ("sched: Remove checks against
SD_LOAD_BALANCE") advertize that setting cpuset.sched_load_balance to 0
ends up creating NULL domain but that's not what I get. For example if I
mount a single cpuset root (no other cpuset mountpoints):

$ mount -t cgroup none ./cpuset -o cpuset
$ cd cpuset
$ cat cpuset.cpus
0-7
$ cat cpuset.sched_load_balance
1
$ echo 0 > cpuset.sched_load_balance
$ ls /sys/kernel/debug/domains/cpu1/
domain0  domain1

I still get the domains on all CPUs...
