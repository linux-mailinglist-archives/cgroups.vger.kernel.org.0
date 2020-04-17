Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1251AE3DF
	for <lists+cgroups@lfdr.de>; Fri, 17 Apr 2020 19:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbgDQRgH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 Apr 2020 13:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728458AbgDQRgH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 17 Apr 2020 13:36:07 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAD4C061A0C
        for <cgroups@vger.kernel.org>; Fri, 17 Apr 2020 10:36:06 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id k21so2901582ljh.2
        for <cgroups@vger.kernel.org>; Fri, 17 Apr 2020 10:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hg6IIRdiW7K53TeUTBkQvnSYbhXlq293hVwvftTtBpY=;
        b=Vwy15InWoEv70r74M82Y4LbZS+npes2VXDKaQjvNzJCyqXXde6NHxQmepyDO1vO1Ed
         QDNopRM8cYIGGVlIEjKd+dGyO5LuF1d+Q2N/vxATnmmxvpcx+M0krPVJ1FqlJ7cqNwKo
         abPmzqwu2buigwodzTtOZwOtMqDaU+rl6ytqqrGgQCavM2QpTg5jlHsA4MT8wIDgkznQ
         JW2QXCTMfMZAsl8/CeoVzsVwyLAzmmoN1DUqVnO9Xr2rEQjGt+dDHagHVSfVGsFNJCTC
         n2/DA4IBZ9iunwXNNtnrGUlBMZeYdzqgKOc97c2kAxzVrGkAkc9ui2UYAmYpuHqRWJpF
         UdGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hg6IIRdiW7K53TeUTBkQvnSYbhXlq293hVwvftTtBpY=;
        b=jZcR8V7zWgbl7+T+QTkoFAR4hbhBfd0E614+hFElJVAyR3zn49tEM9/26Gxp9yzdbC
         8581gOttjGUx/K1RMpoyb9+EmRtRk+iuzO3NT6G4NP5v4K5/EUjOeINlea80vKAlDbmg
         c/s1IzZ9ZebusdcWuszgqPdqlSZ+6cKInOumYQty6vnCRi+RJYi73m5xMe0usayD80qt
         lQgCLBsp2oaWBJBDc8YQfmc+Cpoa+imKB9vRdrOYtkpRP1E3nyUtU17bl09FYbnv3Nn7
         edmFasWVqlNgo5qqsRjFlZSFTmuNse7lQFIB134ocNxyNjD99uXxbDFSGEcb3fR43Xjx
         GpBg==
X-Gm-Message-State: AGi0Pua1uj0Y8Aceip22hplrwfLZ5O2/t8IIhywum/dcatZX9fS+9Ci7
        3oQ9B25uMmgLzQOOSqVIJTxUATa1elBled+NeK6GUabyA8s1MQ==
X-Google-Smtp-Source: APiQypIr3P5caRZIgT/06laKGzVvRHT8utRwdQ/qnb1JlACKzpb0/PCRDtuT64YI3+taEpCR28vdyYl1i7/WEFf3KvE=
X-Received: by 2002:a05:651c:1209:: with SMTP id i9mr2596479lja.250.1587144964706;
 Fri, 17 Apr 2020 10:36:04 -0700 (PDT)
MIME-Version: 1.0
References: <1587134624-184860-1-git-send-email-alex.shi@linux.alibaba.com>
 <20200417155317.GS26707@dhcp22.suse.cz> <CALvZod7Xa4Xs=7zC8OZ7GOfvfDBv+yNbGCzBxeoMgAeRGRtw0A@mail.gmail.com>
 <20200417165442.GT26707@dhcp22.suse.cz>
In-Reply-To: <20200417165442.GT26707@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 17 Apr 2020 10:35:53 -0700
Message-ID: <CALvZod5DT-2TB-6KFZshmSt=wq+jg5+b5aAsWequP8zxs+tMpQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] memcg: folding CONFIG_MEMCG_SWAP as default
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Apr 17, 2020 at 9:54 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Fri 17-04-20 09:41:04, Shakeel Butt wrote:
> > On Fri, Apr 17, 2020 at 9:03 AM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > On Fri 17-04-20 22:43:43, Alex Shi wrote:
> > > > This patch fold MEMCG_SWAP feature into kernel as default function. That
> > > > required a short size memcg id for each of page. As Johannes mentioned
> > > >
> > > > "the overhead of tracking is tiny - 512k per G of swap (0.04%).'
> > > >
> > > > So all swapout page could be tracked for its memcg id.
> > >
> > > I am perfectly OK with dropping the CONFIG_MEMCG_SWAP. The code that is
> > > guarded by it is negligible and the resulting code is much easier to
> > > read so no objection on that front. I just do not really see any real
> > > reason to flip the default for cgroup v1. Why do we want/need that?
> > >
> >
> > Yes, the changelog is lacking the motivation of this change. This is
> > proposed by Johannes and I was actually expecting the patch from him.
> > The motivation is to make the things simpler for per-memcg LRU locking
> > and workingset for anon memory (Johannes has described these really
> > well, lemme find the email). If we keep the differentiation between
> > cgroup v1 and v2, then there is actually no point of this cleanup as
> > per-memcg LRU locking and anon workingset still has to handle the
> > !do_swap_account case.
>
> All those details really have to go into the changelog. I have to say
> that I still do not understand why the actual accounting swap or not
> makes any difference for per per-memcg LRU.

Here is Johannes explanation:
https://lore.kernel.org/linux-mm/20200413180725.GA99267@cmpxchg.org/

> Especially when your patch

You mean Alex's patch.

> keeps the kernel command line parameter still in place.
>
> Anyway, it would be much more simpler to have a patch that drops the
> CONFIG_MEMCG_SWAP and a separate one which switches the default
> beahvior. I am not saying I am ok with the later but if the
> justification is convincing then I might change my mind.
> --
> Michal Hocko
> SUSE Labs
