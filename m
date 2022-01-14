Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98BA48E726
	for <lists+cgroups@lfdr.de>; Fri, 14 Jan 2022 10:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239703AbiANJJq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Jan 2022 04:09:46 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41308 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239697AbiANJJj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 14 Jan 2022 04:09:39 -0500
Date:   Fri, 14 Jan 2022 10:09:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1642151377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U+Si0XJr5oFNQer8Hglx3KPVt6lkZ6RKg12n+qYdLpI=;
        b=RwooFruNFLsHCSO275wabcot+DSjrha0x1w6ecguFCmXlQS5QH0oflEEeC27XOUPg1dtFP
        8zT+z2T5dWLQovWP1HeMd00xl42HvA77sUiJ0/pOhrVAHQfuvj+N56H4t+mwlmvA1dj8xM
        pXzMhSuCJ2KcnCNetFZmntp2dq628DEKaht9B63045pMNGhKVZp55cIm5SH+9DFDf5LaiG
        IjHILvL1KmzRF7adK4BLpU3h7CHlBVKcot8one6JEowWVP8sHg5mwFxo6TWoSkDI8TjeG8
        zVOfSbxSys8l9ucexNadniaKja6ruv9kPb8B88koLXYyLOlCoUEIcJFNhVmjSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1642151377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U+Si0XJr5oFNQer8Hglx3KPVt6lkZ6RKg12n+qYdLpI=;
        b=I4ZS6gpi10OqmERf2Vkqp4ZPPFgo7Q5w72tXKKeEBLVRzK6yVYnVlkkD+ONCVkREMg8FuJ
        k5BrrTjoPTaXxVBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 1/3] mm/memcg: Protect per-CPU counter by disabling
 preemption on PREEMPT_RT
Message-ID: <YeE9zyUokSY9L2ZI@linutronix.de>
References: <20211222114111.2206248-1-bigeasy@linutronix.de>
 <20211222114111.2206248-2-bigeasy@linutronix.de>
 <20220105141653.GA6464@blackbody.suse.cz>
 <YeAkOm0YsAe5jFRb@linutronix.de>
 <20220113144803.GB28468@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220113144803.GB28468@blackbody.suse.cz>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2022-01-13 15:48:03 [+0100], Michal Koutn=C3=BD wrote:
> On Thu, Jan 13, 2022 at 02:08:10PM +0100, Sebastian Andrzej Siewior <bige=
asy@linutronix.de> wrote:
> > I added a preempt-disable() section restricted to RT to
> > mem_cgroup_event_ratelimit().
>=20
> Oh, I missed that one.
>=20
> (Than the decoupling of such mem_cgroup_event_ratelimit() also makes
> some more sense.)
> > That would mean that mem_cgroup_event_ratelimit() needs a
> > local_irq_save(). If that is okay then sure I can move it that way.
>=20
> Whatever avoids the twisted code :-)

Okay. So let me do that.

> ---
>=20
> > I remember Michal (Hocko) suggested excluding/ rejecting soft limit but
> > I didn't know where exactly and its implications. In this block here I
> > just followed the replacement of irq-off with preempt-off for RT.
>=20
> Both soft limit and (these) event notifications are v1 features. Soft
> limit itself is rather considered even misfeature. I guess the
> implications would not be many since PREEMPT_RT+memcg users would be
> new(?) so should rather start with v2 anyway.

People often migrate to RT so they take whatever they have. In general I
would like to keep RT & !RT in sync unless there are reasons to do it
differently.

> One way to disable it would be to reject writes into
> memory.soft_limit_in_bytes or cgroup.event_control + documentation of
> that.

So avoiding these two also avoids memcg_check_events()?
Right now it does not look like a big obstacle. It is the same pattern
I'm following for the per-CPU RMW. If it is, I could avoid the writes
and if0 the other function for RT.
If I remove memcg_check_events() from the equation then we could keep
the explicit irq-off regions (plus add a few). The only that would look
odd then is that we disable interrupts for the RMW operation and
preemption in other places (__count_memcg_events() invocations in swap.c
and vmscan.c).=20

Are there plans to remove v1 or is this part of "we must not break
userland"?

> Michal

Sebastian
