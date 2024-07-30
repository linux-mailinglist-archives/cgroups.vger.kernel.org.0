Return-Path: <cgroups+bounces-4004-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0C994201B
	for <lists+cgroups@lfdr.de>; Tue, 30 Jul 2024 20:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F0CD1C236B7
	for <lists+cgroups@lfdr.de>; Tue, 30 Jul 2024 18:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21D918C938;
	Tue, 30 Jul 2024 18:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ifUrBHax"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9E518C921
	for <cgroups@vger.kernel.org>; Tue, 30 Jul 2024 18:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722365684; cv=none; b=E6D9pG0bEP8oyBII2ac3p4RoiIzU2zBgo4M3OAYHzhVdpmu6KHoysJBJs70WGpvtBv+qH9R++GQK3nxzSDq0u80wpul/XEUik0Vs7p5J7Wx3EJvHTnp/+1NdwEQAwECwWM01S5Jji4NIore1kQQLc3xLjPbuXFptBMwsmHsDqMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722365684; c=relaxed/simple;
	bh=R+HZ2qhBwwDcRT2H1HHrYWuZkq79fE6W1A37S3ndvQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UZRoWaz2W0QuIzcHUCdTmKwVQhHcW4MsMQBjJXNEYxxzH2GSmj3NjB4KVdks3O5K7Zgm3y9uYvzUNmwUfGyX+bWx+VF2we3CRTo1e7S1jOPtiI984M/9fl9AJPXLCvMJ/k7+Q9IBhiwHiZ0WLUd7FEU4KTYemRqtZU2P2gq2t3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ifUrBHax; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52f01ec08d6so7511563e87.2
        for <cgroups@vger.kernel.org>; Tue, 30 Jul 2024 11:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722365681; x=1722970481; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/1GE3IrS8NiIL30sftPH4qk7dd8iILO7+WJcRg0JuA=;
        b=ifUrBHaxkgqk3swasG57luMUSS8ibHeLxL74FobVNlTOG2hSfez9opzJ8MrcOFdnYD
         tOWBy9G4hf1IZxtzb/D/koDyrEd4hqdCQLjS7mW297YPPAQdvKcrBD4AQZdyH9EmP+PV
         xv77vhLACAzWAK0vhbtxsp287ajG2b3DuW9M7KtrTcOyZuhDLxbYcD/5JUUXlfcWhHD6
         kWxD+93NszCJxz1oPdtuhHgq0qvyKEW7UTcT8y+HkTskYkaJNHhv7v+pbeguJG3UfwBy
         2yyuO5LT226Bjap2VWzVK/KGb1V8f3Ow8guxxaYEMUuzQMSHWB3bqZyzXRCZEGcOPPEl
         841A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722365681; x=1722970481;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z/1GE3IrS8NiIL30sftPH4qk7dd8iILO7+WJcRg0JuA=;
        b=a3tbhnGQH0EprqH9HRfBBvZhoPfU9Zdua3DiNHagEis0ZYD0IO6hFvi+JJ/0756c+r
         CKy93zknt7lkckYfTNDApqPT2lDLGGaW2eVoa5cZuXgb3WraRwxD4ZyUHuhJYWbxN2md
         baXqbSDD2VePg2XBviQ6XjrK8vd91cyBCXhEaS3GjvcpYUGkB6rqfW+gMW1wlHqaL3px
         1p3s9/5C0dHPPCSnG8f30Cnsrq2qOd7jDbYiMRRnxJr+8mYeHq/DVXoK4/3Dh1O4DvpL
         GXDxhToUftXR5ym70Wpk2g+pMFbWyTK2mJe1hQrvRU1LtMWy4KPX9e3XNqazuZYVTTzF
         SO/A==
X-Forwarded-Encrypted: i=1; AJvYcCUIILfNPycqfQ95BMB7tm/vbBzX8gbWqzt2yslJBmId32phPZJXXjlbGD6iDgEFM5ufGvhM2+lVPrRsVzxqLXsec5d4WlKPqg==
X-Gm-Message-State: AOJu0YyX1Sl/vHgmpibAuU4CpzgceNMCGVNFSHnz06rudLq45ByJC7bX
	4aXxkpRdEHwmRUlk3P0w6G502HJu7kPdBO9LvPUao4MEWGn5UNUs6TjPf0+09Tilwxl8WxLCP7L
	sG9QXsRQL8X3dxKaal0Z0lSLDPNvovU3APIYJX9Qy430ugeOjZuVJ
X-Google-Smtp-Source: AGHT+IE/GCdWKR8yt8pDQ9ks7L5eK7ye0WxDPTIGgAQOFMUunS3XFIOR7/+yZQ/aJrpIfhJUMP8/iVjDMItj0X2ayBk=
X-Received: by 2002:ac2:5210:0:b0:52e:767a:ada3 with SMTP id
 2adb3069b0e04-5309b2ca86amr7130273e87.47.1722365680166; Tue, 30 Jul 2024
 11:54:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <172139415725.3084888.13770938453137383953.stgit@firesoul>
 <CAJD7tkaVwpYWu_c+vgr7mJiWzFofq9jmx-hyOx1i5kkHWc62dg@mail.gmail.com> <c55f852b-39b7-4bf9-a054-0e7933912730@kernel.org>
In-Reply-To: <c55f852b-39b7-4bf9-a054-0e7933912730@kernel.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 30 Jul 2024 11:54:04 -0700
Message-ID: <CAJD7tkaZuiSCj4RZ2v6jOCtwiv++YNQxA0x6MEp-HrHaYO6_9g@mail.gmail.com>
Subject: Re: [PATCH V8 1/2] cgroup/rstat: Avoid flushing if there is an
 ongoing overlapping flush
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: tj@kernel.org, cgroups@vger.kernel.org, shakeel.butt@linux.dev, 
	hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com, 
	kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

[..]
> >> +static inline void __cgroup_rstat_lock(struct cgroup *cgrp, int cpu_in_loop,
> >> +                                      bool already_contended)
> >>          __acquires(&cgroup_rstat_lock)
> >>   {
> >> -       bool contended;
> >> +       bool locked = false;
> >>
> >> -       contended = !spin_trylock_irq(&cgroup_rstat_lock);
> >> -       if (contended) {
> >> -               trace_cgroup_rstat_lock_contended(cgrp, cpu_in_loop, contended);
> >> +       if (already_contended) /* Skip trylock if already contended */
> >> +               locked = __cgroup_rstat_trylock(cgrp, cpu_in_loop);
> >
> > Should this be the other way around?
> >
>
> I think it is correct, but I used it wrong in once place, in
> cgroup_rstat_flush_hold(), as cgroup_rstat_trylock_flusher() returning
> false doesn't mean it was already_contended, but that ongoing flusher
> "skipped" (and waited for) a flush.  I need to correct this.

Something isn't adding up here as well. The comment says skip trylock
if already contended, then if already_contended is true we do a
trylock. Am I confusing myself here? :)

>
>
> >> +
> >> +       if (!locked) {
> >>                  spin_lock_irq(&cgroup_rstat_lock);
> >> +               trace_cgroup_rstat_locked(cgrp, cpu_in_loop, true);
> >>          }
> >> -       trace_cgroup_rstat_locked(cgrp, cpu_in_loop, contended);
> >>   }
> >>
> >>   static inline void __cgroup_rstat_unlock(struct cgroup *cgrp, int cpu_in_loop)
> >> @@ -299,6 +316,72 @@ static inline void __cgroup_rstat_unlock(struct cgroup *cgrp, int cpu_in_loop)
> >>          spin_unlock_irq(&cgroup_rstat_lock);
> >>   }
> >>
> >> +#define MAX_WAIT       msecs_to_jiffies(100)
> >> +/**
> >> + * cgroup_rstat_trylock_flusher - Trylock that checks for on ongoing flusher
> >> + * @cgrp: target cgroup
> >> + *
> >> + * Function return value follow trylock semantics. Returning true when lock is
> >> + * obtained. Returning false when not locked and it detected flushing can be
> >> + * skipped as another ongoing flusher took care of the flush.
> >> + */
> >> +static bool cgroup_rstat_trylock_flusher(struct cgroup *cgrp)
> >> +{
> >> +       struct cgroup *ongoing;
> >> +       bool locked;
> >> +
> >> +       /*
> >> +        * Check if ongoing flusher is already taking care of this, if
> >> +        * we are a descendant skip work, but wait for ongoing flusher
> >> +        * to complete work.
> >> +        */
> >> +retry:
> >> +       ongoing = READ_ONCE(cgrp_rstat_ongoing_flusher);
> >> +       if (ongoing && cgroup_is_descendant(cgrp, ongoing)) {
> >
> > The discussion about cgrp_rstat_ongoing_flusher possibly going away in
> > parallel never reached a conclusion AFAICT. Should we use
> > cgroup_tryget() here to get a ref on 'ongoing' until wait completes?
>
> I like the cgroup_tryget() idea, but I though we needed to do this on
> the 'cgrp' that will be waiting in the completion queue on 'ongoing'?

I think we need to protect the 'ongoing' cgroup because it could go
away between reading cgrp_rstat_ongoing_flusher and using it to check
if we are a descendant and wait for its completion.

The lifetime of 'cgrp' should be handled by the caller, right?

>
> > This shouldn't add much complexity AFAICT.
>
> >
> > I think just using RCU here wouldn't be enough as we can flush rstat
> > after the RCU grace period when a cgroup is being freed.
> >
> >> +               wait_for_completion_interruptible_timeout(
> >> +                       &ongoing->flush_done, MAX_WAIT);
> >> +               /* TODO: Add tracepoint here */
> >> +               return false;
> >> +       }
> >> +
> >> +       locked = __cgroup_rstat_trylock(cgrp, -1);
> >> +       if (!locked) {
> >> +               /* Contended: Handle losing race for ongoing flusher */
> >> +               if (!ongoing && READ_ONCE(cgrp_rstat_ongoing_flusher))
> >> +                       goto retry;
> >> +
> >> +               __cgroup_rstat_lock(cgrp, -1, true);
> >> +       }
> >> +       /*
> >> +        * Obtained lock, record this cgrp as the ongoing flusher.
> >> +        * Due to lock yielding, we might obtain lock while another
> >> +        * ongoing flusher (that isn't a parent) owns ongoing_flusher.
> >> +        */
> >> +       ongoing = READ_ONCE(cgrp_rstat_ongoing_flusher);
> >> +       if (!ongoing) {
> >
> > I think we don't need protection here since we never dereference
> > 'cgrp_rstat_ongoing_flusher', but I think it may be clearer to
> > directly check it to make this obvious:
> >
> > if (!READ_ONCE(cgrp_rstat_ongoing_flusher)) {
> >
>
> Makes sense, but I use the 'ongoing' variable in the next patch in a
> tracepoint to diagnose this happening.
>
> > Perhaps we can also explicitly mention in the comment why we do not
> > need any protection here, but I am not sure how helpful that will be.
> >
> >> +               /*
> >> +                * Limit to top-level as lock yielding allows others to obtain
> >> +                * lock without being ongoing_flusher. Leading to cgroup that
> >> +                * isn't descendant to obtain lock via yielding. So, prefer
> >> +                * ongoing_flusher with many descendants.
> >> +                */
> >> +               if (cgrp->level < 2) {
> >
> > This covers roots and top-level cgroups under them, right? Did them
> > improve the numbers you were observing?
> >
>
> The numbers from prod improved significantly, then cadvisor and kswapd
> collide.

Do you mean that the numbers improved compared to without this patch,
or compared with allowing all cgroups to be the ongoing flusher?

The latter was my question. For the former, I definitely agree this
patch improves things based on the data.

> But cadvisor still flush a couple of level 1 cgroups, and can still
> cause lock contention for level 0 and other non-decendent cgroups.
>
> 11:30:08 @ongoing_flusher_yield[0]: 68
> @ongoing_flusher_cnt[kswapd11]: 4
> @ongoing_flusher_cnt[kswapd2]: 4
> @ongoing_flusher_cnt[kswapd5]: 4
> @ongoing_flusher_cnt[handled_race]: 4
> @ongoing_flusher_cnt[kswapd9]: 5
> @ongoing_flusher_cnt[kswapd7]: 5
> @ongoing_flusher_cnt[kswapd4]: 5
> @ongoing_flusher_cnt[kswapd6]: 5
> @ongoing_flusher_cnt[kswapd1]: 5
> @ongoing_flusher_cnt[kswapd8]: 6
> @ongoing_flusher_cnt[kswapd10]: 6
> @ongoing_flusher_cnt[kswapd3]: 6
> @ongoing_flusher_cnt[kswapd0]: 6
> @ongoing_flusher_cnt[cadvisor]: 8
> @ongoing_flusher_cnt[all]: 65
> @cnt[tracepoint:cgroup:cgroup_ongoing_flusher_yield]: 4
> @cnt[tracepoint:cgroup:cgroup_rstat_lock_contended]: 26
> @cnt[tracepoint:cgroup:cgroup_ongoing_flusher_wait]: 60
> @cnt[kfunc:vmlinux:cgroup_rstat_flush_locked]: 475
> @cnt[tracepoint:cgroup:cgroup_rstat_locked]: 1953
> @lock_contended[normal, 1]: 2
> @lock_contended[normal, 3]: 8
> @lock_contended[normal, 0]: 16
>
> We see that level 0 observe lock_contended 16 times, but we should
> subtract 4 as that was "handled_race" cases. So 12 times, the root-cgrp
> was spinning on the lock. In total (26-4) 22 times flushers contented on
> the lock.  Given 475 flushes happen within this 1 sec period, every 2.1
> ms, then I do call it it a significant reduction for lock contention.

Agreed :)

>
>
> > AFAICT, we can remove this restriction completely if/when we use a
> > mutex and support a single ongoing flusher. If so, let's explicitly
> > mention this, perhaps:
> >
>
> Well... I'm still not convinced that it makes sense to have level >= 2
> be the ongoing flusher.
>
> E.g. if a level 2 cgroup becomes ongoing flusher, and kswapd starts 12
> NUMA flushes at the same time, then the code will have these 12 kswapd
> threads spin on the lock, until ongoing flusher finishes. That is likely
> what happened above (for a level 1).  These 12 spinning (root) flushers
> will not recheck ongoing_flusher and will all flush the root
> (unnecessarily 11 times).

Hmm regardless of whether or not the level-2 cgroup becomes the
ongoing flusher, the kswapd threads will all spin on the lock anyway
since none of them can be the ongoing flusher until the level-2 cgroup
finishes. Right?

Is the scenario you have in mind that the level-2 cgroup starts
flushing at the same time as kswapd, so there is a race on who gets to
be the ongoing flusher? In this case as well, whoever gets the lock
will be the ongoing flusher anyway.

Not allowing whoever is holding the lock to be the ongoing flusher
based on level is only useful when we can have multiple ongoing
flushers (with lock yielding). Right?

Perhaps I am missing something here.

>
> So, I don't think it is a good idea to have anything else that the root
> as the ongoing flusher.
>
> Can you explain/convince me why having sub-cgroups as ongoing flusher is
> an advantage?

I just don't see the benefit of the special casing here as I mentioned
above. If I missed something please let me know.

>
> --Jesper
>
> > XXX: Remove this restriction if/when lock yielding is removed
> >
[..]

