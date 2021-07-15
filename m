Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8EFD3C94C5
	for <lists+cgroups@lfdr.de>; Thu, 15 Jul 2021 02:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbhGOAKB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 14 Jul 2021 20:10:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:49582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229535AbhGOAKB (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 14 Jul 2021 20:10:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E5D3461377;
        Thu, 15 Jul 2021 00:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626307629;
        bh=sQiUghkEbe9wGspdd7HcqAwfIHqM9cHT4CiACu2qHWQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iuiPo90pIDHpl1iiP7GksND+AF0jAueEosqdRUNoPz4VM8xl7y0PhRE+Az7kU86+p
         o+4YY3Ks0RBOenHoacnVY1tPKJV9GwV0tzPFJEvYIoK742NEw8m4eyRJ5GRWiJRfkP
         R2Kx0ETZd0VkCX/v/P7LzFS558Xn3iItzKrNXp1ygzA8Elr5k0Df6bkmZCsob2YvK9
         VkRyQkHNUIGcNOXPe/TNj7UiAwV8s3jqmf1g3wUxz1F5HZx47nH8Az6+t5edbahg8L
         u4+4p2Xy9E79ZToB+lr8LvGrp9eu6NNvR6dUa/GtHe0E+lKt6bXRcGfpsrxe+JsUja
         YiQZIqFh+PjjA==
Date:   Thu, 15 Jul 2021 02:07:06 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Nitesh Lal <nilal@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Saenz <nsaenzju@redhat.com>,
        Christoph Lameter <cl@gentwo.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org
Subject: Re: [RFC PATCH 6/6] cpuset: Add cpuset.isolation_mask file
Message-ID: <20210715000706.GA75036@lothringen>
References: <20210714135420.69624-1-frederic@kernel.org>
 <20210714135420.69624-7-frederic@kernel.org>
 <YO8WWxWBmNuI0iUW@hirez.programming.kicks-ass.net>
 <20210714231338.GA65963@lothringen>
 <87o8b4mpfb.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o8b4mpfb.mognet@arm.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jul 15, 2021 at 12:44:08AM +0100, Valentin Schneider wrote:
> On 15/07/21 01:13, Frederic Weisbecker wrote:
> > On Wed, Jul 14, 2021 at 06:52:43PM +0200, Peter Zijlstra wrote:
> >>
> >> cpusets already has means to create paritions; why are you creating
> >> something else?
> >
> > I was about to answer that the semantics of isolcpus, which reference
> > a NULL domain, are different from SD_LOAD_BALANCE implied by
> > cpuset.sched_load_balance. But then I realize that SD_LOAD_BALANCE has
> > been removed.
> >
> > How cpuset.sched_load_balance is implemented then? Commit
> > e669ac8ab952df2f07dee1e1efbf40647d6de332 ("sched: Remove checks against
> > SD_LOAD_BALANCE") advertize that setting cpuset.sched_load_balance to 0
> > ends up creating NULL domain but that's not what I get. For example if I
> > mount a single cpuset root (no other cpuset mountpoints):
> >
> > $ mount -t cgroup none ./cpuset -o cpuset
> > $ cd cpuset
> > $ cat cpuset.cpus
> > 0-7
> > $ cat cpuset.sched_load_balance
> > 1
> > $ echo 0 > cpuset.sched_load_balance
> > $ ls /sys/kernel/debug/domains/cpu1/
> > domain0  domain1
> >
> > I still get the domains on all CPUs...
> 
> Huh. That's on v5.14-rc1 with an automounted cpuset:
> 
> $ cat /sys/fs/cgroup/cpuset/cpuset.cpus
> 0-5
> $ cat /sys/fs/cgroup/cpuset/cpuset.sched_load_balance
> 1
> 
> $ ls /sys/kernel/debug/sched/domains/cpu*
> /sys/kernel/debug/sched/domains/cpu0:
> domain0  domain1
> 
> /sys/kernel/debug/sched/domains/cpu1:
> domain0  domain1
> 
> /sys/kernel/debug/sched/domains/cpu2:
> domain0  domain1
> 
> /sys/kernel/debug/sched/domains/cpu3:
> domain0  domain1
> 
> /sys/kernel/debug/sched/domains/cpu4:
> domain0  domain1
> 
> /sys/kernel/debug/sched/domains/cpu5:
> domain0  domain1
> 
> $ echo 0 > /sys/fs/cgroup/cpuset/cpuset.sched_load_balance
> $ ls /sys/kernel/debug/sched/domains/cpu*
> /sys/kernel/debug/sched/domains/cpu0:
> 
> /sys/kernel/debug/sched/domains/cpu1:
> 
> /sys/kernel/debug/sched/domains/cpu2:
> 
> /sys/kernel/debug/sched/domains/cpu3:
> 
> /sys/kernel/debug/sched/domains/cpu4:
> 
> /sys/kernel/debug/sched/domains/cpu5:
> 
> 
> I also checked that you can keep cpuset.sched_load_balance=0 at the root
> and create exclusive child cpusets with different values of
> sched_load_balance, giving you some CPUs attached to the NULL domain and
> some others with a sched_domain hierarchy that stays within the cpuset span.

Ok I must have done something wrong somewhere, I'll check further tomorrow.

Thanks!
