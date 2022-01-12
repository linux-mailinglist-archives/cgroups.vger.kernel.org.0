Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB4248CB54
	for <lists+cgroups@lfdr.de>; Wed, 12 Jan 2022 19:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356519AbiALSyD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Jan 2022 13:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344374AbiALSyA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Jan 2022 13:54:00 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D052C061751
        for <cgroups@vger.kernel.org>; Wed, 12 Jan 2022 10:54:00 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id z22so7787494ybi.11
        for <cgroups@vger.kernel.org>; Wed, 12 Jan 2022 10:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VDiXGGcZpLradskpTdR9ZfOJwP4eXSYg53Oie0mB7Q4=;
        b=Qxf1SgnRdrjcbKSGPORBSlu/NlfikRSVgwDC/sREwNuW+qlqcnkuVRK4JncUyoMmnF
         yefFKpAkzoRpR6EPbHIfV7d/X8Q6tKpF897Avv3Y5eicSfXdv/Bm2/aKXvxXx8Lwl3aN
         mlGlwqSkq01X0KsN55z8NyFpPHjTC7VTmmYz1e5eqDxLhvwizP9sFVgjZoKaFSPgqhvW
         /YSztR5SNlkcO95cplDvykW+ssjg0IChaCRk/W8tanlDy/E/HgdT135HZqctP8vXXLWR
         2L88qi/53PGgVv3X32SpXtMxI8TwmrqqTzlA/fCcotD1MggEdo75Auzaq8InQAOrRfrQ
         wOXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VDiXGGcZpLradskpTdR9ZfOJwP4eXSYg53Oie0mB7Q4=;
        b=HV7Qr/vGwBGJqmyJu3Jtf+ndEmkH2UvLnhRnc1U6aM6lMgmd/PehQuIvYgYwUZlbFO
         PZEVYpkry0GSh/w9UebeKQNEHY9X/Z3CbX1h0puppRfjinKuuGw+Vni6M9ZfJ7mXxmTF
         1bxx782c/NyDU6Hk8PS/fmmlEIiKGs7odxKmh/hBl4FzVlBB8KNg/Yg+sg/R3Zbo8xvu
         p5VpGs13bM6qhdvcBKs1oUn6J70rVPIO0e9cby/f2gUxE3lX06sw+GYPVSW3yqJYaptK
         Ma06vX7VAsIVwYdJJXsDN1et9WT+f71JIwH4H7X62Eu2mW/E88NIz+DUWngyVuIFP7EX
         X6Iw==
X-Gm-Message-State: AOAM533ud9U+X2yeH3d0w7zsigH0zbKQPLiqnI/FxTbr2Nw0EnMD2QC/
        ftttoOMDUB/2wHr2FPAt7WuG2eBz1h/zhN+G72OIFQ==
X-Google-Smtp-Source: ABdhPJyyqercS1kDAJ5mzYiC+yjPw41Z6Wd2bHa81ktBvON+ZCzsZy7m7UgTlE4ao53RyEGV7vACgzNato8hCl8vO2k=
X-Received: by 2002:a25:a4e9:: with SMTP id g96mr1315310ybi.318.1642013639110;
 Wed, 12 Jan 2022 10:53:59 -0800 (PST)
MIME-Version: 1.0
References: <20220111232309.1786347-1-surenb@google.com> <Yd7oPlxCpnzNmFzc@cmpxchg.org>
 <CAJuCfpGHLXDvMU1GLMcgK_K72_ErPhbcFh1ZvEeHg025yinNuw@mail.gmail.com>
 <CAJuCfpEaM3KoPy3MUG7HW2yzcT6oJ5gdceyHPNpHrqTErq27eQ@mail.gmail.com>
 <Yd8a8TdThrGHsf2o@casper.infradead.org> <CAJuCfpF45VY_7esx7p2yEK+eK-ufSMsBETEdJPF=Mzxj+BTnLA@mail.gmail.com>
 <Yd8hpPwsIT2pbKUN@gmail.com>
In-Reply-To: <Yd8hpPwsIT2pbKUN@gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 12 Jan 2022 10:53:48 -0800
Message-ID: <CAJuCfpF_aZ7OnDRYr2MNa-x=ctO-daw-U=k+-GCYkJR1_yTHQg@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] psi: Fix uaf issue when psi trigger is destroyed
 while being polled
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        syzbot <syzbot+cdb5dd11c97cc532efad@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jan 12, 2022 at 10:44 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Wed, Jan 12, 2022 at 10:26:08AM -0800, Suren Baghdasaryan wrote:
> > On Wed, Jan 12, 2022 at 10:16 AM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Wed, Jan 12, 2022 at 09:49:00AM -0800, Suren Baghdasaryan wrote:
> > > > > This happens with the following config:
> > > > >
> > > > > CONFIG_CGROUPS=n
> > > > > CONFIG_PSI=y
> > > > >
> > > > > With cgroups disabled these functions are defined as non-static but
> > > > > are not defined in the header
> > > > > (https://elixir.bootlin.com/linux/latest/source/include/linux/psi.h#L28)
> > > > > since the only external user cgroup.c is disabled. The cleanest way to
> > > > > fix these I think is by doing smth like this in psi.c:
> > >
> > > A cleaner way to solve these is simply:
> > >
> > > #ifndef CONFIG_CGROUPS
> > > static struct psi_trigger *psi_trigger_create(...);
> > > ...
> > > #endif
> > >
> > > I tested this works:
> > >
> > > $ cat foo5.c
> > > static int psi(void *);
> > >
> > > int psi(void *x)
> > > {
> > >         return (int)(long)x;
> > > }
> > >
> > > int bar(void *x)
> > > {
> > >         return psi(x);
> > > }
> > > $ gcc -W -Wall -O2 -c -o foo5.o foo5.c
> > > $ readelf -s foo5.o
> > >
> > > Symbol table '.symtab' contains 4 entries:
> > >    Num:    Value          Size Type    Bind   Vis      Ndx Name
> > >      0: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT  UND
> > >      1: 0000000000000000     0 FILE    LOCAL  DEFAULT  ABS foo5.c
> > >      2: 0000000000000000     0 SECTION LOCAL  DEFAULT    1 .text
> > >      3: 0000000000000000     3 FUNC    GLOBAL DEFAULT    1 bar
> > >
> >
> > Thanks Matthew!
> > That looks much cleaner. I'll post a separate patch to fix these. My
> > main concern was whether it's worth adding more code to satisfy this
> > warning but with this approach the code changes are minimal, so I'll
> > go ahead and post it shortly.
>
> Why not simply move the declarations of psi_trigger_create() and
> psi_trigger_destroy() in include/linux/psi.h outside of the
> '#ifdef CONFIG_CGROUPS' block, to match the .c file?

IIRC this was done to avoid another warning that these functions are
not used outside of psi.c when CONFIG_CGROUPS=n

>
> They *could* be static when !CONFIG_CGROUPS, but IMO it's not worth bothering.
>
> - Eric
