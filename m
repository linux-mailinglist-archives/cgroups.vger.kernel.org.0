Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78E7D48CA60
	for <lists+cgroups@lfdr.de>; Wed, 12 Jan 2022 18:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344297AbiALRtO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Jan 2022 12:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344268AbiALRtN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Jan 2022 12:49:13 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8499C061751
        for <cgroups@vger.kernel.org>; Wed, 12 Jan 2022 09:49:12 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id t24so4028714qkg.11
        for <cgroups@vger.kernel.org>; Wed, 12 Jan 2022 09:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FGEfHWlf9UMI6v4enCzCD7r7seKvBt4wr+xOvzAydtg=;
        b=WbGG70yB5ix1xJm1WZIdyIccnKWNDVsMGBobYnUvRJtVGwRDFABrhR3HRodaO2H2gT
         o+mvzdaj9LW0ogQ/fZRLZ/G14ELweRvxby5HD2yygkGanrwyi0saa1PLA/b2HANEP9wP
         uVBQAarQx5wX6tUlOrtGMc8zeFxL6B2vOiWjnaC9BUVZle/bRqhOpgFK7qozPGiliRpF
         KQaDAmpG3GhdrpqiN7KljC2pW8M/Z/6NhEvocoQhtnW+0wIJ3qYItndrv8QOCrbR/Jxa
         UB+N+Y+r+k/dW13lG7nxHXxFVvAgkFh1FoS5a/O9Z9S/tPGYbuQ9WwEOG5hY/jGGrlg2
         U5EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FGEfHWlf9UMI6v4enCzCD7r7seKvBt4wr+xOvzAydtg=;
        b=XNPKejcjqPOHL95WOeM4vDeFCgpj0T8Ypaivqj9bOEeUm0DYTQ4G3tKRHq0qUy4EFE
         LcMEy0xZsy4/2Uhji8o9hpt/L2nPAC15Gnk4mXbxqPnQBWiUJT0JTexfy4I65B3kspeT
         8tfEkBgDW6CM5krMKaJ7mIHXwOxMlInNk6u2lV9iqKg9GXMjeJs9muc3VrvHg1OJ7FGj
         piLWj9hymCC9CsKk0gpulEUwpLsD7eaVHqCUHmjRUMs4dMdq765o9nv+RkciHMnS+IPJ
         aZb7gHqJphayhVh6gXsXKJFOnD2oRPqOMZpDnPPZl1Q1WuKUQLkKmMJ19INuk8Fh8aBM
         RJ+g==
X-Gm-Message-State: AOAM531p2iCAUhjviGA5V7qXtCnJxN5fcJo8yZgi9fLJx4At4IWT1BXi
        zzt6h7r6D8C9IkXkABJwFMWV4v+HXM8alGNQr9B1HQ==
X-Google-Smtp-Source: ABdhPJxfN2XJ4LOiyU4hogddx6yOZvk/BIWqCAvRPuDRWYY6wyEn2p4yI9Sa7X55t3Lg1CYmOJU4b8GfjXSbXBZJY5g=
X-Received: by 2002:a25:7807:: with SMTP id t7mr1066672ybc.488.1642009751595;
 Wed, 12 Jan 2022 09:49:11 -0800 (PST)
MIME-Version: 1.0
References: <20220111232309.1786347-1-surenb@google.com> <Yd7oPlxCpnzNmFzc@cmpxchg.org>
 <CAJuCfpGHLXDvMU1GLMcgK_K72_ErPhbcFh1ZvEeHg025yinNuw@mail.gmail.com>
In-Reply-To: <CAJuCfpGHLXDvMU1GLMcgK_K72_ErPhbcFh1ZvEeHg025yinNuw@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 12 Jan 2022 09:49:00 -0800
Message-ID: <CAJuCfpEaM3KoPy3MUG7HW2yzcT6oJ5gdceyHPNpHrqTErq27eQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] psi: Fix uaf issue when psi trigger is destroyed
 while being polled
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Biggers <ebiggers@kernel.org>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
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

On Wed, Jan 12, 2022 at 9:43 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> )
>
> On Wed, Jan 12, 2022 at 6:40 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Tue, Jan 11, 2022 at 03:23:09PM -0800, Suren Baghdasaryan wrote:
> > > With write operation on psi files replacing old trigger with a new one,
> > > the lifetime of its waitqueue is totally arbitrary. Overwriting an
> > > existing trigger causes its waitqueue to be freed and pending poll()
> > > will stumble on trigger->event_wait which was destroyed.
> > > Fix this by disallowing to redefine an existing psi trigger. If a write
> > > operation is used on a file descriptor with an already existing psi
> > > trigger, the operation will fail with EBUSY error.
> > > Also bypass a check for psi_disabled in the psi_trigger_destroy as the
> > > flag can be flipped after the trigger is created, leading to a memory
> > > leak.
> > >
> > > Fixes: 0e94682b73bf ("psi: introduce psi monitor")
> > > Cc: stable@vger.kernel.org
> > > Reported-by: syzbot+cdb5dd11c97cc532efad@syzkaller.appspotmail.com
> > > Analyzed-by: Eric Biggers <ebiggers@kernel.org>
> > > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> >
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>
> Hmm. kernel test robot notified me of new (which are not really new)
> warnings but I don't think this patch specifically introduced them:
>
> kernel/sched/psi.c:1112:21: warning: no previous prototype for
> function 'psi_trigger_create' [-Wmissing-prototypes]
>    struct psi_trigger *psi_trigger_create(struct psi_group *group,
>                        ^
>    kernel/sched/psi.c:1112:1: note: declare 'static' if the function
> is not intended to be used outside of this translation unit
>    struct psi_trigger *psi_trigger_create(struct psi_group *group,
>    ^
>    static
> >> kernel/sched/psi.c:1182:6: warning: no previous prototype for function 'psi_trigger_destroy' [-Wmissing-prototypes]
>    void psi_trigger_destroy(struct psi_trigger *t)
>         ^
>    kernel/sched/psi.c:1182:1: note: declare 'static' if the function
> is not intended to be used outside of this translation unit
>    void psi_trigger_destroy(struct psi_trigger *t)
>    ^
>    static
>    kernel/sched/psi.c:1249:10: warning: no previous prototype for
> function 'psi_trigger_poll' [-Wmissing-prototypes]
>    __poll_t psi_trigger_poll(void **trigger_ptr,
>             ^
>    kernel/sched/psi.c:1249:1: note: declare 'static' if the function
> is not intended to be used outside of this translation unit
>    __poll_t psi_trigger_poll(void **trigger_ptr,
>    ^
>
> This happens with the following config:
>
> CONFIG_CGROUPS=n
> CONFIG_PSI=y
>
> With cgroups disabled these functions are defined as non-static but
> are not defined in the header
> (https://elixir.bootlin.com/linux/latest/source/include/linux/psi.h#L28)
> since the only external user cgroup.c is disabled. The cleanest way to
> fix these I think is by doing smth like this in psi.c:
>
> struct psi_trigger *_psi_trigger_create(struct psi_group *group, char
> *buf, size_t nbytes, enum psi_res res)
> {
>   // original psi_trigger_create code
> }
>
> #ifdef CONFIG_CGROUPS
>
> struct psi_trigger *psi_trigger_create(struct psi_group *group, char
> *buf, size_t nbytes, enum psi_res res)
> {
>     return _psi_trigger_create(group, buf, nbytes, res);
> }
>
> #else
>
> static struct psi_trigger *psi_trigger_create(struct psi_group *group,
> char *buf, size_t nbytes, enum psi_res res)
> {
>     return _psi_trigger_create(group, buf, nbytes, res);
> }
>
> #endif

Actually this would be enough:

static struct psi_trigger *_psi_trigger_create(struct psi_group
*group, char *buf, size_t nbytes, enum psi_res res)
{
   // original psi_trigger_create code
}

#ifdef CONFIG_CGROUPS
 struct psi_trigger *psi_trigger_create(struct psi_group *group, char
*buf, size_t nbytes, enum psi_res res)
 {
     return _psi_trigger_create(group, buf, nbytes, res);
 }
#endif

and locally we use _psi_trigger_create().

>
> Two questions:
> 1. Is this even worth fixing?
> 2. If so, I would like to do that as a separate patch (these warnings
> are unrelated to the changes in this patch). Would that be ok?
> Thanks,
> Suren.
