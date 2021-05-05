Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C82373390
	for <lists+cgroups@lfdr.de>; Wed,  5 May 2021 03:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbhEEB1k (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 May 2021 21:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbhEEB1j (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 4 May 2021 21:27:39 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF3BC06174A
        for <cgroups@vger.kernel.org>; Tue,  4 May 2021 18:26:43 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id g38so551250ybi.12
        for <cgroups@vger.kernel.org>; Tue, 04 May 2021 18:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VwkFVGeygfPPOOzWFv0DYtzQ6yrWI2H0fQZB1AzPEM0=;
        b=dYUEpvTtcC/zgvuWMLUHqfh+FSH/C0VurBbahqhGRd7mtNCdElZiv25gRL44Iw79+S
         hP/vLRzLkzKCiTwfo2An3vgfDX/zKwdcrIBaAS/0z3mD49nou8AzB4Bm8Pt+qx9Z9a8q
         UEmF29J6Ygs9BJD/1ekctTMc2cFptqEm6WGNsXEDhOQ8h7+e74n0m1m7AsweZkRRwH+s
         fEnXJiLjo04MzFahr387l2EFB5WF/Fcsy2kSY7pCLdSj0V5HimTC43xBEpAbEm6Q2og7
         7Hyq/nCGkgWsKYWBLoW7POCxrwV4Qzrh3c7IujMQhnUPAh0FIvllbAR9mNZIi0AKczv7
         BRcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VwkFVGeygfPPOOzWFv0DYtzQ6yrWI2H0fQZB1AzPEM0=;
        b=CU2GxrcAiUa7FBjET6eJ4HcfuOZScb6kHMEtUwwem1YHc1CHbZhECVas4VX03HQgjJ
         femSrDZ86aqVlUNNhQild49xgDqyOkd2WH1XijPkmgvmtoMTkNIAc5KH8Vs3HSKRb8Bp
         OqBmk/djTNF7AAERoQXyzquGYnN1jUWkeQNkVaID6JLTbtbtZGDUqRv8+1LmuvaBHiNP
         garumBvlNsM6urf4MY34YiPi0sN7/b+PNU7tstr4ZTOPIVs0NlX7X9MR3BILzP/VIASu
         lPCG/mv6W85RXurX16PXWpnFbao2quwLB83q8r/19p94dik0JW+G++9E3v7Yp4aoC42a
         pfLg==
X-Gm-Message-State: AOAM531u3MckphfIAoR5sgxR6q9KDKjUwXtJrTiTEoezMpUKqrm3j9Y/
        NavXm6ECROuD68KaAiJXdTYdlziEZsIm6ywdhwN4eQ==
X-Google-Smtp-Source: ABdhPJwpz5V8xuoroIlXbMblu6FsI3wrXZvSHPldR8YeTpoz6D8T1Nb6osHDgPpvHOlp934YhH9maWDv6KofvuczY1w=
X-Received: by 2002:a25:b049:: with SMTP id e9mr38030700ybj.111.1620178001694;
 Tue, 04 May 2021 18:26:41 -0700 (PDT)
MIME-Version: 1.0
References: <CALvZod7vtDxJZtNhn81V=oE-EPOf=4KZB2Bv6Giz+u3bFFyOLg@mail.gmail.com>
 <YH54pyRWSi1zLMw4@dhcp22.suse.cz> <CALvZod4kjdgMU=8T_bx6zFufA1cGtt2p1Jg8jOgi=+g=bs-Evw@mail.gmail.com>
 <YH/RPydqhwXdyG80@dhcp22.suse.cz> <CALvZod4kRWDQuZZQ5F+z6WMcUWLwgYd-Kb0mY8UAEK4MbSOZaA@mail.gmail.com>
 <YIA2rB0wgqKzfUfi@dhcp22.suse.cz> <CALvZod4_L7GSHnivQTSdDzo=fb4i3z=katjzVCHfLz9WWGK8uQ@mail.gmail.com>
In-Reply-To: <CALvZod4_L7GSHnivQTSdDzo=fb4i3z=katjzVCHfLz9WWGK8uQ@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 4 May 2021 18:26:30 -0700
Message-ID: <CAJuCfpEXyG9x1nUsg+6yVWTP+-A4OwuCg9XHLAciu39=JNY7DQ@mail.gmail.com>
Subject: Re: [RFC] memory reserve for userspace oom-killer
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        David Rientjes <rientjes@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Thelen <gthelen@google.com>,
        Dragos Sbirlea <dragoss@google.com>,
        Priya Duraisamy <padmapriyad@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 4, 2021 at 5:37 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Wed, Apr 21, 2021 at 7:29 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> [...]
> > > > What if the pool is depleted?
> > >
> > > This would mean that either the estimate of mempool size is bad or
> > > oom-killer is buggy and leaking memory.
> > >
> > > I am open to any design directions for mempool or some other way where
> > > we can provide a notion of memory guarantee to oom-killer.
> >
> > OK, thanks for clarification. There will certainly be hard problems to
> > sort out[1] but the overall idea makes sense to me and it sounds like a
> > much better approach than a OOM specific solution.
> >
> >
> > [1] - how the pool is going to be replenished without hitting all
> > potential reclaim problems (thus dependencies on other all tasks
> > directly/indirectly) yet to not rely on any background workers to do
> > that on the task behalf without a proper accounting etc...
> > --
>
> I am currently contemplating between two paths here:
>
> First, the mempool, exposed through either prctl or a new syscall.
> Users would need to trace their userspace oom-killer (or whatever
> their use case is) to find an appropriate mempool size they would need
> and periodically refill the mempools if allowed by the state of the
> machine. The challenge here is to find a good value for the mempool
> size and coordinating the refilling of mempools.
>
> Second is a mix of Roman and Peter's suggestions but much more
> simplified. A very simple watchdog with a kill-list of processes and
> if userspace didn't pet the watchdog within a specified time, it will
> kill all the processes in the kill-list. The challenge here is to
> maintain/update the kill-list.

IIUC this solution is designed to identify cases when oomd/lmkd got
stuck while allocating memory due to memory shortages and therefore
can't feed the watchdog. In such a case the kernel goes ahead and
kills some processes to free up memory and unblock the blocked
process. Effectively this would limit the time such a process gets
stuck by the duration of the watchdog timeout. If my understanding of
this proposal is correct, then I see the following downsides:
1. oomd/lmkd are still not prevented from being stuck, it just limits
the duration of this blocked state. Delaying kills when memory
pressure is high even for short duration is very undesirable. I think
having mempool reserves could address this issue better if it can
always guarantee memory availability (not sure if it's possible in
practice).
2. What would be performance overhead of this watchdog? To limit the
duration of a process being blocked to a small enough value we would
have to have quite a small timeout, which means oomd/lmkd would have
to wake up quite often to feed the watchdog. Frequent wakeups on a
battery-powered system is not a good idea.
3. What if oomd/lmkd gets stuck for some memory-unrelated reason and
can't feed the watchdog? In such a scenario the kernel would assume
that it is stuck due to memory shortages and would go on a killing
spree. If there is a sure way to identify when a process gets stuck
due to memory shortages then this could work better.
4. Additional complexity of keeping the list of potential victims in
the kernel. Maybe we can simply reuse oom_score to choose the best
victims?
Thanks,
Suren.

>
> I would prefer the direction which oomd and lmkd are open to adopt.
>
> Any suggestions?
