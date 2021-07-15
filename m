Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80AE73C9AF5
	for <lists+cgroups@lfdr.de>; Thu, 15 Jul 2021 11:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235749AbhGOJHb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 15 Jul 2021 05:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbhGOJHa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 15 Jul 2021 05:07:30 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBC1C06175F;
        Thu, 15 Jul 2021 02:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YXhmaFe3CRPX9WF+r+FgIAgegXjAeJeUfdmdJwL81/I=; b=bqya5XKMcJVGm3ZMaBVDVpRRaY
        EBfcpjtG0+lNfWQ03HrPVSyZI3a7Nkrevl9+zAkl/UAKBpAfPXRQxNQT9cY5BWCps9Sq0NcuW572Y
        3ICi67u8qitRFzUp4HZ3vsYLMIB5V2c1KA/PeHDV/L/edec1YjAG5pem1cGmYLRLVSW/GYLhXsVQ8
        1/Z4564w28Jax/rKWbKzltlL28ntHtFvleH34zfFerhrC+myR3GFEJGq+x3cOTbXb8ka4PdyKpnCA
        rjmJ+EtiShC+GkF9nIv3lC+1R9ch9KT+gigCmYxPaaDquoe+HTskqVB4wtvhZ/Bj/VVlOR1eVJ/NO
        jJk8RAlA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3xI5-0006WI-42; Thu, 15 Jul 2021 09:04:21 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 12D1A9867B3; Thu, 15 Jul 2021 11:04:20 +0200 (CEST)
Date:   Thu, 15 Jul 2021 11:04:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
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
Message-ID: <20210715090419.GH2725@worktop.programming.kicks-ass.net>
References: <20210714135420.69624-1-frederic@kernel.org>
 <20210714135420.69624-7-frederic@kernel.org>
 <YO8WWxWBmNuI0iUW@hirez.programming.kicks-ass.net>
 <20210714231338.GA65963@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714231338.GA65963@lothringen>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jul 15, 2021 at 01:13:38AM +0200, Frederic Weisbecker wrote:
> On Wed, Jul 14, 2021 at 06:52:43PM +0200, Peter Zijlstra wrote:

> > cpusets already has means to create paritions; why are you creating
> > something else?
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

SD_LOAD_BALANCE was only for when you wanted to stop balancing inside a
domain tree. That no longer happens (and hasn't for a *long* time).
Cpusets simply creates multiple domain trees (or the empty one if its
just one CPU).

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

(note, that's the cgroup-v1 interface, the cgroup-v2 interface is
significantly different)

I'd suggest doing: echo 1 > /debug/sched/verbose, if I do the above I
get:

[1290784.889705] CPU0 attaching NULL sched-domain.
[1290784.894830] CPU1 attaching NULL sched-domain.
[1290784.899947] CPU2 attaching NULL sched-domain.
[1290784.905056] CPU3 attaching NULL sched-domain.
[1290784.910153] CPU4 attaching NULL sched-domain.
[1290784.915252] CPU5 attaching NULL sched-domain.
[1290784.920338] CPU6 attaching NULL sched-domain.
[1290784.925439] CPU7 attaching NULL sched-domain.
[1290784.930535] CPU8 attaching NULL sched-domain.
[1290784.935660] CPU9 attaching NULL sched-domain.
[1290784.940911] CPU10 attaching NULL sched-domain.
[1290784.946117] CPU11 attaching NULL sched-domain.
[1290784.951317] CPU12 attaching NULL sched-domain.
[1290784.956507] CPU13 attaching NULL sched-domain.
[1290784.961688] CPU14 attaching NULL sched-domain.
[1290784.966876] CPU15 attaching NULL sched-domain.
[1290784.972047] CPU16 attaching NULL sched-domain.
[1290784.977218] CPU17 attaching NULL sched-domain.
[1290784.982383] CPU18 attaching NULL sched-domain.
[1290784.987552] CPU19 attaching NULL sched-domain.
[1290784.992724] CPU20 attaching NULL sched-domain.
[1290784.997893] CPU21 attaching NULL sched-domain.
[1290785.003063] CPU22 attaching NULL sched-domain.
[1290785.008230] CPU23 attaching NULL sched-domain.
[1290785.013400] CPU24 attaching NULL sched-domain.
[1290785.018568] CPU25 attaching NULL sched-domain.
[1290785.023736] CPU26 attaching NULL sched-domain.
[1290785.028905] CPU27 attaching NULL sched-domain.
[1290785.034074] CPU28 attaching NULL sched-domain.
[1290785.039241] CPU29 attaching NULL sched-domain.
[1290785.044409] CPU30 attaching NULL sched-domain.
[1290785.049579] CPU31 attaching NULL sched-domain.
[1290785.054816] CPU32 attaching NULL sched-domain.
[1290785.059986] CPU33 attaching NULL sched-domain.
[1290785.065154] CPU34 attaching NULL sched-domain.
[1290785.070323] CPU35 attaching NULL sched-domain.
[1290785.075492] CPU36 attaching NULL sched-domain.
[1290785.080662] CPU37 attaching NULL sched-domain.
[1290785.085832] CPU38 attaching NULL sched-domain.
[1290785.091001] CPU39 attaching NULL sched-domain.

Then when I do:

# mkdir /cgroup/A
# echo 0,20 > /cgroup/A/cpuset.cpus

I get:

[1291020.749036] CPU0 attaching sched-domain(s):
[1291020.754251]  domain-0: span=0,20 level=SMT
[1291020.759061]   groups: 0:{ span=0 }, 20:{ span=20 }
[1291020.765386] CPU20 attaching sched-domain(s):
[1291020.770399]  domain-0: span=0,20 level=SMT
[1291020.775210]   groups: 20:{ span=20 }, 0:{ span=0 }
[1291020.780831] root domain span: 0,20 (max cpu_capacity = 1024)

IOW, I've created a load-balance domain on just the first core of the
system.

# echo 0-1,20-21 > /cgroup/A/cpuset.cpus

Extends it to the first two cores:

[1291340.260699] CPU0 attaching NULL sched-domain.
[1291340.265820] CPU20 attaching NULL sched-domain.
[1291340.271403] CPU0 attaching sched-domain(s):
[1291340.276315]  domain-0: span=0,20 level=SMT
[1291340.281122]   groups: 0:{ span=0 }, 20:{ span=20 }
[1291340.286719]   domain-1: span=0-1,20-21 level=MC
[1291340.292011]    groups: 0:{ span=0,20 cap=2048 }, 1:{ span=1,21 cap=2048 }
[1291340.299855] CPU1 attaching sched-domain(s):
[1291340.304757]  domain-0: span=1,21 level=SMT
[1291340.309564]   groups: 1:{ span=1 }, 21:{ span=21 }
[1291340.315190]   domain-1: span=0-1,20-21 level=MC
[1291340.320474]    groups: 1:{ span=1,21 cap=2048 }, 0:{ span=0,20 cap=2048 }
[1291340.328307] CPU20 attaching sched-domain(s):
[1291340.333344]  domain-0: span=0,20 level=SMT
[1291340.338136]   groups: 20:{ span=20 }, 0:{ span=0 }
[1291340.343721]   domain-1: span=0-1,20-21 level=MC
[1291340.348980]    groups: 0:{ span=0,20 cap=2048 }, 1:{ span=1,21 cap=2048 }
[1291340.356783] CPU21 attaching sched-domain(s):
[1291340.361755]  domain-0: span=1,21 level=SMT
[1291340.366534]   groups: 21:{ span=21 }, 1:{ span=1 }
[1291340.372099]   domain-1: span=0-1,20-21 level=MC
[1291340.377364]    groups: 1:{ span=1,21 cap=2048 }, 0:{ span=0,20 cap=2048 }
[1291340.385216] root domain span: 0-1,20-21 (max cpu_capacity = 1024)

