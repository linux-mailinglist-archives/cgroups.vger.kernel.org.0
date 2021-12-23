Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6A7E47DFA4
	for <lists+cgroups@lfdr.de>; Thu, 23 Dec 2021 08:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239103AbhLWHeW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Dec 2021 02:34:22 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37456 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbhLWHeW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Dec 2021 02:34:22 -0500
Date:   Thu, 23 Dec 2021 08:34:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1640244860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2tROn/paYAmSCszbEQd9FE7LVsYuR0niFVGpk5kB1Vc=;
        b=JDOnNXQOT4ssAGisSFSsvY9e1Q6YTYi00Qq+6vYuW3ThqePBOgTrEOH/fgxFwSKT29vt/D
        0g9chxDZWq3m9FXHLX4B/ESKKdSbtZtRZlX31FPg++h9xk5k+5HFx2LibP0NpLUJO/FzBr
        45eJAym2zSABM7IpHTCqWSzwDATiJjor/xMYDB5jd7pGpuwGVYh7WAqpopSYc+G7bZn66i
        IVs/PS1cqdn0cLxFiWbOXoL+lWwTUyTep1px+ObysoBksu4U9e5bgq1v/Pna82NGIuDFGn
        ApacJM6IPUb49H22HezjtWUkvSroB/kTOWlsJihyxWuAhn9NeSfW2/sQoPnRjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1640244860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2tROn/paYAmSCszbEQd9FE7LVsYuR0niFVGpk5kB1Vc=;
        b=Mm3d+/SVvo6rhIseKTHwy0x8jQJq3e4gfeY6H9DKufJ8hvp9D7R5wQcESugYMjceGu47U1
        G4HcFy1ma4KE+pCA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Waiman Long <longman@redhat.com>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 1/3] mm/memcg: Protect per-CPU counter by disabling
 preemption on PREEMPT_RT
Message-ID: <YcQme8BPFl7P9T02@linutronix.de>
References: <20211222114111.2206248-1-bigeasy@linutronix.de>
 <20211222114111.2206248-2-bigeasy@linutronix.de>
 <bdfc9791-4af2-f4fb-9ef5-dab1e2e3ff89@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bdfc9791-4af2-f4fb-9ef5-dab1e2e3ff89@redhat.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2021-12-22 21:31:36 [-0500], Waiman Long wrote:
> On 12/22/21 06:41, Sebastian Andrzej Siewior wrote:
> > The per-CPU counter are modified with the non-atomic modifier. The
> > consistency is ensure by disabling interrupts for the update.
> > This breaks on PREEMPT_RT because some sections additionally
> > acquire a spinlock_t lock (which becomes sleeping and must not be
> > acquired with disabled interrupts). Another problem is that
> > mem_cgroup_swapout() expects to be invoked with disabled interrupts
> > because the caller has to acquire a spinlock_t which is acquired with
> > disabled interrupts. Since spinlock_t never disables interrupts on
> > PREEMPT_RT the interrupts are never disabled at this point.
> > 
> > The code is never called from in_irq() context on PREEMPT_RT therefore
> 
> How do you guarantee that these percpu update functions won't be called in
> in_irq() context for PREEMPT_RT? Do you think we should add a
> WARN_ON_ONCE(in_irq()) just to be sure?

There are no invocations to the memory allocator (neither malloc() nor
free()) on RT and the memory allocator itself (SLUB and the
page-allocator so both) has sleeping locks. That means invocations
in_atomic() are bad. All interrupt handler are force-threaded. Those
which are not (like timer, per-CPU interrupts or those which explicitly
asked not to be force threaded) are limited in their doing as they can't
invoke anything that has a sleeping lock. Lockdep or
CONFIG_DEBUG_ATOMIC_SLEEP will yell here.
The other counter are protected the same way, see
  c68ed7945701a ("mm/vmstat: protect per cpu variables with preempt disable on RT")

> Cheers,
> Longman

Sebastian
