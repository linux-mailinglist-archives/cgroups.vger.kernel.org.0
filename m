Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E039544008E
	for <lists+cgroups@lfdr.de>; Fri, 29 Oct 2021 18:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhJ2Qun (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 29 Oct 2021 12:50:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56220 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbhJ2Qum (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 29 Oct 2021 12:50:42 -0400
Date:   Fri, 29 Oct 2021 18:48:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635526092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FidfvpGxCpEED7Y8roiCwv6c14v5UAUT6Pgou9ogbrs=;
        b=fYbGpxrOCut5U6uufJaSYtOeJJHB54X/Uoo74/kiY+ZRaKn1GukfYhrPZjsauVK+v9A9Ly
        HUoVWF4nmbUQF0WVT+sHjIkpGSf6xfK9qlo2IpGlko/Hgcv1cktVO06GgByiU7DU7147qy
        nOS0ky+89c9btDkRsRO9nwqIpPeMys9j3DpxD0ZSLvsYz79ewqfKnqrf3HQo8ctkfs/j5c
        UaCJkRiCy3OLPRrwEf4wna6HyADGbv/KfFg/caqjTfpDSdnb5H0o4gdyO8yBWZHCoL8i/H
        ssZIgRhJ+xSerFt9UkV6Oy/eHL0Fc/U5W5+9dOzHMdZV+KSAUM+B0RbT1mHzVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635526092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FidfvpGxCpEED7Y8roiCwv6c14v5UAUT6Pgou9ogbrs=;
        b=w0rrlt39fq2XBzQN+BTx1h0qKyEVZk5XSWt/z/cR56I00Uyb3kKSBWUBITJZCsSMfX2a7e
        spA4FX8OO4RqMpDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Ronny Meeus <ronny.meeus@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: Unbounded priority inversion while assigning tasks into cgroups.
Message-ID: <20211029164810.gfv6t2ml6oea3dd2@linutronix.de>
References: <CAMJ=MEd9WuGA0MN+n0rGD6T+sgd=yciTmeEW9TjRjNXt+cF=qQ@mail.gmail.com>
 <20211027165800.md2gxbsku4avqjgt@linutronix.de>
 <CAMJ=MEfkQ9VaphaNS_qbWMOANo7P6h2Ln6iYg4JLWbWzxp85mA@mail.gmail.com>
 <20211028084654.bgtvnibvqnz2o5rh@linutronix.de>
 <CAMJ=MEez-+0mj2N0rz79eE5gJG2k99Yh+x8vdEG3YK1apiOuzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMJ=MEez-+0mj2N0rz79eE5gJG2k99Yh+x8vdEG3YK1apiOuzg@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2021-10-29 11:42:25 [+0200], Ronny Meeus wrote:
> Op do 28 okt. 2021 om 10:46 schreef Sebastian Andrzej Siewior
> <bigeasy@linutronix.de>:
> >
> > On 2021-10-27 22:54:33 [+0200], Ronny Meeus wrote:
> > > > From a looking at percpu_rw_semaphore implementation, no new readers are
> > > > allowed as long as there is a writer pending. The writer has
> > > > (unfortunately) to wait until all readers are out. But then I doubt that
> > > > this takes up to two minutes for all existing readers to leave the
> > > > critical section.
> > > >
> > >
> > > The readers can be running at low priority while there can be other threads
> > > with a medium priority will consume the complete cpu. So the low prio
> > > readers are just waiting to be scheduled and by that also block the high
> > > prio thread.
> >
> > Hmm. So you have say, 5 reads stuck in the RW semaphore while preempted
> > be medium tasks and high-prio writer is then stuck on semaphore, waiting
> > for the MED tasks to finish so the low-prio threads can leave the
> > criticial section?
> 
> Correct. Note that 1 thread stuck in the read is already sufficient to
> get into this.
> Most of the heavy processing is done at medium priority and the
> background tasks are running at the low priority.
> Since the background tasks are implemented by scripts, a lot of
> accesses to the read part are done at low prio.

Yeah, one is enough. My guess would be that it is more visible on the
small ones because on the bigger ones it is more likely that the thread
gets migrated to another core.

> > > Looking at v4.9.84, at least the RT implementation of rw_semaphore
> > > > allows new readers if a writer is pending. So this could be culprit as
> > > > you would have to wait until all reader are gone and the writer needs to
> > > > grab the lock before another reader shows up. But then this shouldn't be
> > > > the case for the generic implementation and new reader should wait until
> > > > the writer got its chance.
> > > >
> > >
> > > So what do you suggest for the v4.9 kernel as a solution? Move to the RT
> > > version of the rw_semaphore and hope for the best?
> >
> > I don't think it will help. Based on what you wrote above it appears
> > that the problem is that the readers are preempted and are not leaving
> > the critical section soon enough.
> >
> > How many CPUs do you have? Maybe using a rtmutex here and allowing only
> > one reader at a time isn't that bad in your case. With one CPU for
> > instance, there isn't much space for multiple readers I guess.
> >
> 
> The current system has 1 CPU with 2 cores but we have also devices
> with 14 cores on which the impact will be bigger of course.
> Note that with the rtmutex solution all accesses (read + write) will
> be serialized.

So for the 1/2 core it should make no difference if you use an RTmutex
instead. For the bigger ones it might not be optimal.

> I wonder why other people do not see this issue since it is present in
> all kernel versions.
> And, especially in systems with strict deadlines, I consider this a
> serious issue.

My guess here is that most people don't use RT priorities and don't see
this problem _or_ they have enough cores. Or they simply don't use that
way.

From PREEMPT_RT perspective, rwsem/rwlock used to be single-reader until
late 3.x or early 4.x series (I don't remember exactly when it changed).
Boosting multiple readers was tried once but didn't really work. 
PREEMPT_RT has also this problem where multiple low-prio reader can
block the high-prio writer but fortunately most critical rwsem users
moved to RCU so it is not much of problem.

> Ronny
 
Sebastian
