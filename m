Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9507E3CD5A0
	for <lists+cgroups@lfdr.de>; Mon, 19 Jul 2021 15:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237216AbhGSMg2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 19 Jul 2021 08:36:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:60758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237271AbhGSMg0 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 19 Jul 2021 08:36:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5185A610A5;
        Mon, 19 Jul 2021 13:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626700626;
        bh=mNX83eIS2g05s9c9QnvJuS5+XyJQcbNL2BxYEIAFG0s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F9A/Q5smYmjuQAy1aDH4g5YIn755qVr2mQiHtfOUV7c8AMx0jyiX3tXLmSPhjtEAY
         3kQ/6BuMJ6AYy6tFq6tWDieOy1qdL2Eg/EN2lqJ+zuerXQyIeVRPyiOmc3zOKfNyyr
         rOpScydKnA5BCj+XkQZWhg2sQvmVE7b1Ihu+C5akwuH8TRtG60N8/zzEMvRiPt8JFU
         QrLvz3sGawj0+L2zC7ppVmE4KQmDulCVYqW7vrbFc+cN3cONMwzHmChhpDgvPp596M
         SXKdnQStzGqVti/mOQ1woOUr0eG4PMUE8U9OH3eatVGFlVgb4TGo2utnPrISDmpUIq
         3Iw7qFIypkJZg==
Date:   Mon, 19 Jul 2021 15:17:04 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
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
Message-ID: <20210719131704.GA116346@lothringen>
References: <20210714135420.69624-1-frederic@kernel.org>
 <20210714135420.69624-7-frederic@kernel.org>
 <YO8WWxWBmNuI0iUW@hirez.programming.kicks-ass.net>
 <20210714231338.GA65963@lothringen>
 <20210715090419.GH2725@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715090419.GH2725@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jul 15, 2021 at 11:04:19AM +0200, Peter Zijlstra wrote:
> On Thu, Jul 15, 2021 at 01:13:38AM +0200, Frederic Weisbecker wrote:
> > On Wed, Jul 14, 2021 at 06:52:43PM +0200, Peter Zijlstra wrote:
> 
> > > cpusets already has means to create paritions; why are you creating
> > > something else?
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
> 
> SD_LOAD_BALANCE was only for when you wanted to stop balancing inside a
> domain tree. That no longer happens (and hasn't for a *long* time).
> Cpusets simply creates multiple domain trees (or the empty one if its
> just one CPU).

Ok.

> 
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
> (note, that's the cgroup-v1 interface, the cgroup-v2 interface is
> significantly different)
> 
> I'd suggest doing: echo 1 > /debug/sched/verbose, if I do the above I
> get:
> 
> [1290784.889705] CPU0 attaching NULL sched-domain.
> [1290784.894830] CPU1 attaching NULL sched-domain.

Thanks!

Eventually I uninstalled cgmanager and things seem to work now. I have
no idea why and I'm not sure I'm willing to investigate further :o)
