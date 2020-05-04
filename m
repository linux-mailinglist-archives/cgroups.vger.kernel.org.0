Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A871C3D9B
	for <lists+cgroups@lfdr.de>; Mon,  4 May 2020 16:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbgEDOxP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 May 2020 10:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgEDOxO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 May 2020 10:53:14 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50073C061A0E
        for <cgroups@vger.kernel.org>; Mon,  4 May 2020 07:53:14 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id a9so4601907lfb.8
        for <cgroups@vger.kernel.org>; Mon, 04 May 2020 07:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PWZ26t9Z32MlW5UKTGmfXwCpHufQN5g8ypGnGhMoTV4=;
        b=QVr6XQdCtnmAtOuVNcvlC8Q1NmED36YsFG+qbvUri4BnTHMhK1Vs1D87apQIG3FCOW
         QOrtlGCTNDtbWPZopaxb0X/P/XDjsTPZYshG4GDHuQRJq2oELxlYiSQNonoapjawLKHI
         k4zgc06E0LPchPMixyKmgFmuR7lufFcUr2XeSWpcn3TUNyEDjMO217tthRxiept1lNWN
         IwTLEODOGj1uNTUGZkJM9r+Ch3yOv2M5whFChG1zwovMr5qbJoVor+OVfpaAhX64v34I
         Bl6XQFAQWRBet5kGBbSGtoyRG52+whbAV+8X4TeiQxgoow5TnXNzG2UL4E6IlyvEnHyu
         7K1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PWZ26t9Z32MlW5UKTGmfXwCpHufQN5g8ypGnGhMoTV4=;
        b=b7inMYQeMw18oGt9kOxypovGgRmo7ALMvZBeCZooJOqGFNBx/VGJfWJKzNnImIRbfp
         1/hKcdaRrrpDtLgmmOyX1hmphpwqZaJvfu729rUC6MwirTvmYoZKvOYbmtgJHhCOsH1n
         F7P80bXfsuyLuBT/vrGmiiJuRLoQS6/Hy9QBEz0LTVpwVE1awsB8RqR0MYRGFo/qW8qG
         QClXo8R2GsX1E3FaoQv2oLExmlv3mbxndYmxUcPZ4KHepRXZyiejVUmK6ZRxsffYJBbP
         Gh8DPhxX1TqbYQLWBLnHCk7N+x49w8rYU/ntU4lu+OX8zEv8SWjwq26/X5SimwvIs19q
         iaMg==
X-Gm-Message-State: AGi0PubhKFJ6yIwFyr1mm3ORlLWNDdiMrxpx/aCcAzte8s0RyYPOnqIQ
        WhtRQo6o5WPOQm7zMkB2rzhvjr6mlJ4OOesyqrLumw==
X-Google-Smtp-Source: APiQypIhrhGrNgrw3phbw7oshVoOFP13vW6aP5Kr4CW7NqXozPGxi60oaOXj6CS4/G7IL7lprTdlDDydkK2ahudmrIc=
X-Received: by 2002:ac2:5e65:: with SMTP id a5mr11921180lfr.189.1588603992481;
 Mon, 04 May 2020 07:53:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200430182712.237526-1-shakeelb@google.com> <20200504065600.GA22838@dhcp22.suse.cz>
 <CALvZod5Ao2PEFPEOckW6URBfxisp9nNpNeon1GuctuHehqk_6Q@mail.gmail.com> <20200504141136.GR22838@dhcp22.suse.cz>
In-Reply-To: <20200504141136.GR22838@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 4 May 2020 07:53:01 -0700
Message-ID: <CALvZod7Ls7rTDOr5vXwEiPneLqbq3JoxfFBxZZ71YWgvLkNr5A@mail.gmail.com>
Subject: Re: [PATCH] memcg: oom: ignore oom warnings from memory.max
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, May 4, 2020 at 7:11 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Mon 04-05-20 06:54:40, Shakeel Butt wrote:
> > On Sun, May 3, 2020 at 11:56 PM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > On Thu 30-04-20 11:27:12, Shakeel Butt wrote:
> > > > Lowering memory.max can trigger an oom-kill if the reclaim does not
> > > > succeed. However if oom-killer does not find a process for killing, it
> > > > dumps a lot of warnings.
> > >
> > > It shouldn't dump much more than the regular OOM report AFAICS. Sure
> > > there is "Out of memory and no killable processes..." message printed as
> > > well but is that a real problem?
> > >
> > > > Deleting a memcg does not reclaim memory from it and the memory can
> > > > linger till there is a memory pressure. One normal way to proactively
> > > > reclaim such memory is to set memory.max to 0 just before deleting the
> > > > memcg. However if some of the memcg's memory is pinned by others, this
> > > > operation can trigger an oom-kill without any process and thus can log a
> > > > lot un-needed warnings. So, ignore all such warnings from memory.max.
> > >
> > > OK, I can see why you might want to use memory.max for that purpose but
> > > I do not really understand why the oom report is a problem here.
> >
> > It may not be a problem for an individual or small scale deployment
> > but when "sweep before tear down" is the part of the workflow for
> > thousands of machines cycling through hundreds of thousands of cgroups
> > then we can potentially flood the logs with not useful dumps and may
> > hide (or overflow) any useful information in the logs.
>
> If you are doing this in a large scale and the oom report is really a
> problem then you shouldn't be resetting hard limit to 0 in the first
> place.
>

I think I have pretty clearly described why we want to reset the hard
limit to 0, so, unless there is an alternative I don't see why we
should not be doing this.

> > > memory.max can trigger the oom kill and user should be expecting the oom
> > > report under that condition. Why is "no eligible task" so special? Is it
> > > because you know that there won't be any tasks for your particular case?
> > > What about other use cases where memory.max is not used as a "sweep
> > > before tear down"?
> >
> > What other such use-cases would be? The only use-case I can envision
> > of adjusting limits dynamically of a live cgroup are resource
> > managers. However for cgroup v2, memory.high is the recommended way to
> > limit the usage, so, why would resource managers be changing
> > memory.max instead of memory.high? I am not sure. What do you think?
>
> There are different reasons to use the hard limit. Mostly to contain
> potential runaways. While high limit might be a sufficient measure to
> achieve that as well the hard limit is the last resort. And it clearly
> has the oom killer semantic so I am not really sure why you are
> comparing the two.
>

I am trying to see if "no eligible task" is really an issue and should
be warned for the "other use cases". The only real use-case I can
think of are resource managers adjusting the limit dynamically. I
don't see "no eligible task" a concerning reason for such use-case. If
you have some other use-case please do tell.

Shakeel
