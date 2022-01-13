Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4473548DAAB
	for <lists+cgroups@lfdr.de>; Thu, 13 Jan 2022 16:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234082AbiAMP06 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 Jan 2022 10:26:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234077AbiAMP05 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 13 Jan 2022 10:26:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF15C06161C
        for <cgroups@vger.kernel.org>; Thu, 13 Jan 2022 07:26:57 -0800 (PST)
Date:   Thu, 13 Jan 2022 16:26:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1642087615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3PME2FpL39l8UfdTGdt/K8iiXCT0iRe1U4l/qKjasvE=;
        b=xyYobnza+rb0w299CIUfcT/8YSuAWX8YPSXQp3auduyovbXL8q+0gDqfU0egc539YdIIHN
        HmZ9rSmXHTfbSOIxtojfout368SBx8GEiR8LW7reD6QgcjqgppdzEW0yktcI6b7PN/S6y7
        ibrSA9eIvw3uCkFMJtbRQ0JTh/cDBUijsGjTSbVbsHqVi31OmOcF4+PmJVUv22RTZ69Vnp
        A9HplElzCOx0in20rwUsz9AQdyNW0JekuI+c556EQJWy+H92Qaib8jYN7i4lWoPQDp3IU7
        REOvCYncjQjCw0y36eo77a24hUYomATr0n6eH2f4cKsvfzbXlIYxMCYkGUowEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1642087615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3PME2FpL39l8UfdTGdt/K8iiXCT0iRe1U4l/qKjasvE=;
        b=cEVxRwtThmIYCDbZjpCk1IC2I9dmoi9VxWBYoVhlo0M0NRHU0M/iRll8vIGuk+mYBn4TKd
        BYyqMdwuwJxavUCQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Waiman Long <longman@redhat.com>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 3/3] mm/memcg: Allow the task_obj optimization only
 on non-PREEMPTIBLE kernels.
Message-ID: <YeBEvaggZ7/6y5ij@linutronix.de>
References: <20211222114111.2206248-1-bigeasy@linutronix.de>
 <20211222114111.2206248-4-bigeasy@linutronix.de>
 <f6bb93c8-3940-6141-d0e0-50144549a4f5@redhat.com>
 <YdML2zaU17clEZgt@linutronix.de>
 <df637005-6c72-a1c6-c6b9-70f81f74884d@redhat.com>
 <YdX+INO9gQje6d0S@linutronix.de>
 <29457251-cf4f-4c7d-b36d-c2a0af4da707@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <29457251-cf4f-4c7d-b36d-c2a0af4da707@redhat.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2022-01-05 22:28:10 [-0500], Waiman Long wrote:
> Thanks for the extensive testing. I usually perform my performance test on
> Intel hardware. I don't realize that Zen2 and arm64 perform better with i=
rq
> on/off.

Maybe you have access to more recent =C2=B5Arch from Intel which could beha=
ve
different.

> My own testing when tracking the number of times in_task() is true or fal=
se
> indicated most of the kmalloc() call is done by tasks. Only a few percents
> of the time is in_task() false. That is the reason why I optimize the case
> that in_task() is true.

Right. This relies on the fact that changing preemption is cheaper which
is not always true. The ultimate benefit is of course when the
preemption changes can be removed/ optimized away.

> > Based on that, I don't see any added value by the optimisation once
> > PREEMPT_DYNAMIC is enabled.
>=20
> The PREEMPT_DYNAMIC result is a bit surprising to me. Given the data poin=
ts,
> I am not going to object to this patch then. I will try to look further i=
nto
> why this is the case when I have time.

Okay, thank you.
In the SERVER case we keep the preemption counter so this has obviously
an impact. I am a little surprised that the DYN-FULL and DYN-NONE
differ a little since the code runs with disabled interrupts. But then
this might be the extra jump to preempt_schedule() which is patched-out
in the SERVER case.

> Cheers,
> Longman

Sebastian
