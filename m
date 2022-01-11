Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3EAB48B753
	for <lists+cgroups@lfdr.de>; Tue, 11 Jan 2022 20:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235665AbiAKT1L (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Jan 2022 14:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235561AbiAKT1L (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Jan 2022 14:27:11 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09260C061748
        for <cgroups@vger.kernel.org>; Tue, 11 Jan 2022 11:27:11 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id n68so4686108ybg.6
        for <cgroups@vger.kernel.org>; Tue, 11 Jan 2022 11:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3SD2cpfSGkAK1w66aKc7m2NiJafQlutBqzxhSCCaOqc=;
        b=TzjUw/oUevlONYTmUZCO+vFz1L3zQ1+crDuIuYltIcAJtHMwFDChmeLSs2gDl7mh06
         Hlra3FtwWGyUTsMDlDaLAb8posIm2eML95P1zVTYG5i0Kwc3a/eguhrpIVIpgePSXbC5
         PtDQuvSxp36wV1baRDzETqB6hGUFKD3dprwj+NaaVmpCpW9jt6m0heI/03r25028rGdp
         /c9Ggm3fJnJpjw5fXgmXPM2SCNL04voZhaM2lMPF+HalxNmYzZgtyZndJ8kDRgq/FzGn
         t7XhJTqNz9rg+46Z7gPIyNYoM/asGldtAU6O7WJizUqNjQtuq5OwTb/J8Pwz5dVoEPz1
         hS+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3SD2cpfSGkAK1w66aKc7m2NiJafQlutBqzxhSCCaOqc=;
        b=YdY6sEfkorefzGSdo5V39vGAPzUaCZKvxfqsoQO6qrhIHDFE0tYl1UbCJ05B4BxuJ+
         vJW1tlcErRg7XfXKtOMQCYpsQkranQhG1TPCQ6D0M2NRQeaYFpiSAtIQ5YWLVQXFzzxG
         n6SagWSpXC/BJSjl869IqjWUvUfpuPhbfrwGdqsfHyfpw3rX/dTxb3+C8K2tw01onUGH
         VwcHAXrL1s9TYRYZ7hNtf7183Tnx06YETHuR24c7v2k4LjaehO9KUCryQrBAzoWIl4hj
         rHljxTq5G5aDBQboZehaMtdQKqWfqa+ZOgHEFFe8lVNQLgeBG5OOrKbnl5OPUSyf+76b
         ecsg==
X-Gm-Message-State: AOAM530NlnuubkEpfubLJSUaZPMQKhqLN4S8Y5Tk6Hoft1iENFd5t6Xf
        BGDjqAjHTJjSIK8uZV0tOiLX7c8jsQ6hzVTYxBpLUg==
X-Google-Smtp-Source: ABdhPJzR10Lg59Rz3flnpSia+CuIS/sH/4KpKCWh6qV8L1k+909YdvTQ5IKNHKetfLMVJ+C2jyxmakngKkA/sslk15E=
X-Received: by 2002:a25:c245:: with SMTP id s66mr8868519ybf.243.1641929230000;
 Tue, 11 Jan 2022 11:27:10 -0800 (PST)
MIME-Version: 1.0
References: <20220111071212.1210124-1-surenb@google.com> <Yd3RClhoz24rrU04@sol.localdomain>
 <CAHk-=wgwb6pJjvHYmOMT-yp5RYvw0pbv810Wcxdm5S7dWc-s0g@mail.gmail.com>
In-Reply-To: <CAHk-=wgwb6pJjvHYmOMT-yp5RYvw0pbv810Wcxdm5S7dWc-s0g@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 11 Jan 2022 11:26:59 -0800
Message-ID: <CAJuCfpE3feNU=36qRUdCJsk41rxQBv1gRYy5R1dB1djMd0NLjg@mail.gmail.com>
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

On Tue, Jan 11, 2022 at 11:11 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Jan 11, 2022 at 10:48 AM Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > The write here needs to use smp_store_release(), since it is paired with the
> > concurrent READ_ONCE() in psi_trigger_poll().
>
> A smp_store_release() doesn't make sense pairing with a READ_ONCE().
>
> Any memory ordering that the smp_store_release() does on the writing
> side is entirely irrelevant, since the READ_ONCE() doesn't imply any
> ordering on the reading side. Ordering one but not the other is
> nonsensical.
>
> So the proper pattern is to use a WRITE_ONCE() to pair with a
> READ_ONCE() (when you don't care about memory ordering, or you handle
> it explicitly), or a smp_load_acquire() with a smp_store_release() (in
> which case writes before the smp_store_release() on the writing side
> will be ordered wrt accesses after smp_load_acquire() on the reading
> side).
>
> Of course, in practice, for pointers, the whole "dereference off a
> pointer" on the read side *does* imply a barrier in all relevant
> situations. So yes, a smp_store_release() -> READ_ONCE() does work in
> practice, although it's technically wrong (in particular, it's wrong
> on alpha, because of the completely broken memory ordering that alpha
> has that doesn't even honor data dependencies as read-side orderings)
>
> But in this case, I do think that since there's some setup involved
> with the trigger pointer, the proper serialization is to use
> smp_store_release() to set the pointer, and then smp_load_acquire() on
> the reading side.
>
> Or just use the RCU primitives - they are even better optimized, and
> handle exactly that case, and can be more efficient on some
> architectures if release->acquire isn't already cheap.
>
> That said, we've pretty much always accepted that normal word writes
> are not going to tear, so we *have* also accepted just
>
>  - do any normal store of a value on the write side
>
>  - do a READ_ONCE() on the reading side
>
> where the reading side doesn't actually care *what* value it gets, it
> only cares that the value it gets is *stable* (ie no compiler reloads
> that might show up as two different values on the reading side).
>
> Of course, that has the same issue as WRITE_ONCE/READ_ONCE - you need
> to worry about memory ordering separately.
>
> > > +     seq->private = new;
> >
> > Likewise here.
>
> Yeah, same deal, except here you can't even use the RCU ones, because
> 'seq->private' isn't annotated for RCU.
>
> Or you'd do the casting, of course.

Thanks for the explanation!
So, it sounds like the best (semantically correct) option I have here
is smp_store_release() to set the pointer, and then smp_load_acquire()
to read it. Is my understanding correct?

>
>               Linus
