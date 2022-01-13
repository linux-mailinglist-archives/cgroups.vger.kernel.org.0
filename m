Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1B9D48D87C
	for <lists+cgroups@lfdr.de>; Thu, 13 Jan 2022 14:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbiAMNIP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 Jan 2022 08:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbiAMNIO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 13 Jan 2022 08:08:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CB9C06173F
        for <cgroups@vger.kernel.org>; Thu, 13 Jan 2022 05:08:14 -0800 (PST)
Date:   Thu, 13 Jan 2022 14:08:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1642079291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fYgLEwvs5VRdvN1sFaMXFPXbTNezugG6bv5lyd4Ctj4=;
        b=v1uyQhmEmw9G5cmDCunfbkUxXr32EpMeccAD1gd6U6W+73VwRBiba9y14BQAX1/ZTUmJ1a
        d/3HnbGf2cgsuUnoe/WY2GSOkznC3Sn6RDV1PxEAXJHFTAZOzew+4s5qDV/qHlRoHq5T6I
        rwX/+EC6H/DVSeD2ut/PazZ8EHI2P3r5tIG4CumOj/9RKKsPVano8a0FSrWBDd1GPxsbp8
        w6OKtu1+Bumi+4qS6RNrBRzhGSQanBDP2ue4KBTrewUcQcHL6f0uNLj0oIT0WTpgL6AzAs
        jkHTvMTUS+pvGd9s8D5lPHD6OsTaVXhe/fWrWopfUnGCcUgji65PAI5rUWWd8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1642079291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fYgLEwvs5VRdvN1sFaMXFPXbTNezugG6bv5lyd4Ctj4=;
        b=e8hxGV5XP7MuUwHHDk4O9a9OrESgBC00df0u70Hyf7ZMiqhZbPf1spzi+CdMAKxlt8sfKo
        jOqH5hlwCstqJcAw==
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
Message-ID: <YeAkOm0YsAe5jFRb@linutronix.de>
References: <20211222114111.2206248-1-bigeasy@linutronix.de>
 <20211222114111.2206248-2-bigeasy@linutronix.de>
 <20220105141653.GA6464@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220105141653.GA6464@blackbody.suse.cz>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2022-01-05 15:16:53 [+0100], Michal Koutn=C3=BD wrote:
> On Wed, Dec 22, 2021 at 12:41:09PM +0100, Sebastian Andrzej Siewior <bige=
asy@linutronix.de> wrote:
> > The sections with disabled preemption must exclude
> > memcg_check_events() so that spinlock_t locks can still be acquired
> > (for instance in eventfd_signal()).
>=20
> The resulting construct in uncharge_batch() raises eybrows. If you can de=
couple
> per-cpu updates from memcg_check_events() on PREEMPT_RT, why not tackle
> it the same way on !PREEMPT_RT too (and have just one variant of the
> block)?

That would mean that mem_cgroup_event_ratelimit() needs a
local_irq_save(). If that is okay then sure I can move it that way.

> (Actually, it doesn't seem to me that memcg_check_events() can be
> extracted like this from the preempt disabled block since
> mem_cgroup_event_ratelimit() relies on similar RMW pattern.
> Things would be simpler if PREEMPT_RT didn't allow the threshold event
> handlers (akin to Michal Hocko's suggestion of rejecting soft limit).)

I added a preempt-disable() section restricted to RT to
mem_cgroup_event_ratelimit(). I had to exclude memcg_check_events() from
the block because of the spinlock_t locks involved down the road
(eventfd_signal() for instance).

I remember Michal (Hocko) suggested excluding/ rejecting soft limit but
I didn't know where exactly and its implications. In this block here I
just followed the replacement of irq-off with preempt-off for RT.

> Thanks,
> Michal

Sebastian
