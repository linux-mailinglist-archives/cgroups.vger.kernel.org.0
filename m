Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F18C248CAF3
	for <lists+cgroups@lfdr.de>; Wed, 12 Jan 2022 19:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356217AbiALS0z (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Jan 2022 13:26:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356170AbiALS0U (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Jan 2022 13:26:20 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1960C061763
        for <cgroups@vger.kernel.org>; Wed, 12 Jan 2022 10:26:19 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id c10so8120494ybb.2
        for <cgroups@vger.kernel.org>; Wed, 12 Jan 2022 10:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9LE2efsBVXAfXjqsEdDYP0Mfkpoh09EyMvpU84oPcm4=;
        b=eD8nqMWPOZMVr4i01lSMjD3ZEVppLM7WWNooLGJ15JiNQNz3Ozy3IY0yA8P28aXOCJ
         GzJbjf5wMabZpTb7HCrCkc0Lcic2vXDLAD0It7Rhlo2HrV4BwLm4vCEqdc05tPdpUCF7
         oC6dsfVU+Coj2qdJSBIcsG3Vkf+SbiHv3SyDMqJbme8odBXFYftp3qGlxT0mWPHGyoYP
         V61CSw8/Kf9avrE0zANxM2pdI4xHNuAv+/Wlw6mSZX19xPxlwpewCQloWs7xzND/Yu0B
         59gl6aj+Z2DcnonCIVEUSHSMt6ohSypBfTzeTN6UrgH7RNyTPrMEm1GAxxPAEvoW+R86
         Q+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9LE2efsBVXAfXjqsEdDYP0Mfkpoh09EyMvpU84oPcm4=;
        b=ddM9cqWChlw71WRuCItx1gG6sy5hmaiG5mkqhOp2T4Y7pvIHLQxwmee0X2giBEZXDJ
         XJwiUDvrOkdpjUqrzOe7l0Ix0lPvOX8PtNVj/jvoRZ0N9sY/hYOYBCMncEINvetvhiJg
         KLwpnVp+JrIYmoFU7ESfyH+qyZZQ8S+0GjvXmAU9jdSVf5TksfQNQMz7VIzYlmv7VReo
         vQgiW16q7mmx0rF75vJgbgLpmRi6ZJm02gnWAC7WJDScyaGp6asK5YcNNfJLIwjDBHZm
         ypGkFC9Y6HN+HUVTVrPyGXt9V4Rmf9gLCJHa+Q7N2jNden1lhaIWPSl9ijwT014HGBAz
         y+PQ==
X-Gm-Message-State: AOAM530V6zVvMIltyROv3W5oRSmcpsOOzhf/lvEuTBnB7fDImj1fC1Q8
        JRUCzfuDJ7TsU8qPCOS5yC5HXK+QEnAOHa0H07UWxg==
X-Google-Smtp-Source: ABdhPJyrV9Hp2Rq7wI4MWmEgI6SSKJSFwbM0tYa3+PFJSIYvNSikG39S6PKLncPRt+/SeaQxBIAXYwbfERMaviCDCpg=
X-Received: by 2002:a25:a4e9:: with SMTP id g96mr1178281ybi.318.1642011978920;
 Wed, 12 Jan 2022 10:26:18 -0800 (PST)
MIME-Version: 1.0
References: <20220111232309.1786347-1-surenb@google.com> <Yd7oPlxCpnzNmFzc@cmpxchg.org>
 <CAJuCfpGHLXDvMU1GLMcgK_K72_ErPhbcFh1ZvEeHg025yinNuw@mail.gmail.com>
 <CAJuCfpEaM3KoPy3MUG7HW2yzcT6oJ5gdceyHPNpHrqTErq27eQ@mail.gmail.com> <Yd8a8TdThrGHsf2o@casper.infradead.org>
In-Reply-To: <Yd8a8TdThrGHsf2o@casper.infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 12 Jan 2022 10:26:08 -0800
Message-ID: <CAJuCfpF45VY_7esx7p2yEK+eK-ufSMsBETEdJPF=Mzxj+BTnLA@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] psi: Fix uaf issue when psi trigger is destroyed
 while being polled
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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

On Wed, Jan 12, 2022 at 10:16 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Jan 12, 2022 at 09:49:00AM -0800, Suren Baghdasaryan wrote:
> > > This happens with the following config:
> > >
> > > CONFIG_CGROUPS=n
> > > CONFIG_PSI=y
> > >
> > > With cgroups disabled these functions are defined as non-static but
> > > are not defined in the header
> > > (https://elixir.bootlin.com/linux/latest/source/include/linux/psi.h#L28)
> > > since the only external user cgroup.c is disabled. The cleanest way to
> > > fix these I think is by doing smth like this in psi.c:
>
> A cleaner way to solve these is simply:
>
> #ifndef CONFIG_CGROUPS
> static struct psi_trigger *psi_trigger_create(...);
> ...
> #endif
>
> I tested this works:
>
> $ cat foo5.c
> static int psi(void *);
>
> int psi(void *x)
> {
>         return (int)(long)x;
> }
>
> int bar(void *x)
> {
>         return psi(x);
> }
> $ gcc -W -Wall -O2 -c -o foo5.o foo5.c
> $ readelf -s foo5.o
>
> Symbol table '.symtab' contains 4 entries:
>    Num:    Value          Size Type    Bind   Vis      Ndx Name
>      0: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT  UND
>      1: 0000000000000000     0 FILE    LOCAL  DEFAULT  ABS foo5.c
>      2: 0000000000000000     0 SECTION LOCAL  DEFAULT    1 .text
>      3: 0000000000000000     3 FUNC    GLOBAL DEFAULT    1 bar
>

Thanks Matthew!
That looks much cleaner. I'll post a separate patch to fix these. My
main concern was whether it's worth adding more code to satisfy this
warning but with this approach the code changes are minimal, so I'll
go ahead and post it shortly.
