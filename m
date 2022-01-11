Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C82548BB82
	for <lists+cgroups@lfdr.de>; Wed, 12 Jan 2022 00:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346868AbiAKXhw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Jan 2022 18:37:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233873AbiAKXht (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Jan 2022 18:37:49 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C40C06173F
        for <cgroups@vger.kernel.org>; Tue, 11 Jan 2022 15:37:49 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id z22so1034642ybi.11
        for <cgroups@vger.kernel.org>; Tue, 11 Jan 2022 15:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y4s8SWu6oC0jBwQaJEtDME4KEjn8XnX1dHweILOZNLw=;
        b=tSyF53acF27OqNgvWqbVMB4rrrAYr/G3ysoCmjIQ/DaL271SFRSP9RaoVkMOYsWjkG
         ZAh/G8g1ZVadBZsGFH5qPak4LK4vm+smNDxvyfLbi93tZ18mFzO1F2hDPQMHLX5dBIsr
         5d1kMzt3sJdE7pgOingjfcwZ+mEVWyW1qXaowK0H4IRT5I4jBEhjI3+h7nt/bjknrGED
         gqlZPxyPkgn1taVWcOXcDy1aihgFYTIfS9B5uiZln7zNU/5M1LElC18H5MoMQC1Z6Jfb
         serIeUcjt6cll+oqIu7J1g6Uh0ILigdyCTsbA81cViGAUm+Yvdjjz6KDrxShdp6XzC1I
         hODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y4s8SWu6oC0jBwQaJEtDME4KEjn8XnX1dHweILOZNLw=;
        b=Ce2YdVUI5TykYkbPK3Hh/rKt/ZDYzHdjZmEagRtl8aNAHoKyPfRFXAa+ipCf4QdQkF
         eeMKeJVdh1nlSYxlhdZX3kN3Z6E47bEgEW+bFGpwGodLCtYbl+3Fc5rtMjwjJR0mUuJC
         X24SCulVq2+jECPsPjB91wXvZfEG9QJ+wMadWg54l8kpN9mOeNJQFK6pmgoQV0QcG+dc
         5x4HtWBLYtbtpxbebpCG/uQ57ePaq9jaBy9vBredL7usu7VRGAP+js/iSRITp+bZ016T
         kORLN+QCambEjwC4yYBUN/H01zSoy5sIc8W6Rq6rxUXBzsaF4bTHjXzcCVvt3M4AsrRI
         V/VQ==
X-Gm-Message-State: AOAM5335vLT80ekQPPEsvt8OIMZMPgByIXM6ZhIjC6nBomId2CFETkd2
        acqZcjcfh32ioIYWW43GWt0ggsyg6ZMz3NgLnBz1fg==
X-Google-Smtp-Source: ABdhPJyqLXKJ6gdjLMc9e2tpdFFZizV6Y14c+znv0Z5ZDaav7clivseLS2LsVXah/dHpL9Qrebnu61t1tKCpI8Oex8w=
X-Received: by 2002:a25:c3c4:: with SMTP id t187mr8315382ybf.634.1641944268131;
 Tue, 11 Jan 2022 15:37:48 -0800 (PST)
MIME-Version: 1.0
References: <20220111071212.1210124-1-surenb@google.com> <Yd3RClhoz24rrU04@sol.localdomain>
 <CAHk-=wgwb6pJjvHYmOMT-yp5RYvw0pbv810Wcxdm5S7dWc-s0g@mail.gmail.com>
 <Yd3dZklleDnJCQ46@gmail.com> <CAHk-=wiQ-qzKU8vyhgm8xsWE8DG6rR4jmbvOfBvbjVYq4SKQMA@mail.gmail.com>
In-Reply-To: <CAHk-=wiQ-qzKU8vyhgm8xsWE8DG6rR4jmbvOfBvbjVYq4SKQMA@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 11 Jan 2022 15:37:37 -0800
Message-ID: <CAJuCfpGHgkgUVQY=FRGfpKDg1QbR2mMaYKbsF2RDiDkratwL_w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] psi: Fix uaf issue when psi trigger is destroyed
 while being polled
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        syzbot <syzbot+cdb5dd11c97cc532efad@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 11, 2022 at 12:15 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Jan 11, 2022 at 11:41 AM Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > This is yet another case of "one time init".
>
> Ehh. It's somewhat debatable.
>
> For a flag that sets a value once, the rules are somewhat different.
> In that case, people may simply not care about memory ordering at all,
> because all they care about is the actual flag value, and - thanks to
> the one-time behavior - basically whether some transition had happened
> or not. That's not all that unusual.
>
> But when you fetch a pointer, things are at least conceptually
> slightly different.
>
> Of course, you may use the existence of the pointer itself as a flag
> (ie just a "NULL or not"), in which case it's the same as any other
> one-time flag thing.
>
> But if you use it to dereference something, then _by_definition_
> you're not just fetching a one-time flag - even if the pointer is only
> set once. At that point, at a minimum, you require that that thing has
> been initialized.
>
> Now, it's then absolutely true that the stuff behind the pointer may
> then have other reasons not to care about memory ordering again, and
> you may be able to avoid memory ordering even then. If you're just
> switching the pointer around between different objects that has been
> statically allocated and initialized, then there is no memory ordering
> required, for example. You might be back to the "I just want one or
> the other of these two pointers".
>
> But if you have something that was initialized before the pointer was
> assigned, you really do hit the problem we had on alpha, where even if
> you order the pointer write side accesses, the dereferencing of the
> pointer may not be ordered on the read side.
>
> Now, alpha is basically dead, and we probably don't really care. Even
> on alpha, the whole "data dependency isn't a memory ordering" is
> almost impossible to trigger.
>
> And in fact, to avoid too much pain we ended up saying "screw alpha"
> and added a memory barrier to READ_ONCE(), so it turns out that
> smp_store_release -> READ_ONCE() does work because we just couldn't be
> bothered to try something more proper.
>
> So yeah, READ_ONCE() ends up making the "access through a pointer"
> thing safe, but that's less of a "it should be safe" and more of a "we
> can't waste time dealing with braindamage on platforms that don't
> matter".
>
> In general, I think the rule should be that READ_ONCE() is for things
> that simply don't care about memory ordering at all (or do whatever
> ordering they want explicitly). And yes, one such very common case is
> the "one-way flag" where once a certain state has been reached, it's
> idempotent.
>
> Of course, then we have the fact that READ_ONCE() can be more
> efficient than "smp_load_acquire()" on some platforms, so if something
> is *hugely* performance-critical, you might use READ_ONCE() even if
> it's not really technically the right thing.
>
> So it's complicated.
>
> A lot of READ_ONCE() users exist just for historical reasons because
> they predated smp_store_release/smp_load_acquire. They may well have
> been using ACCESS_ONCE() long ago.
>
> And some are there because it's a very critical piece of code, and
> it's very intentional.
>
> But if you don't have some huge reasons, I really would prefer people
> use "smp_store_release -> smp_load_acquire" as a very clear "handoff"
> event.

Posted v3 with smp_store_release/smp_load_acquire:
https://lore.kernel.org/all/20220111232309.1786347-1-surenb@google.com
Thanks!

>
>               Linus
