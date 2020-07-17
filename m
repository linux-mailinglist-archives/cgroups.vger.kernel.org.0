Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D296223087
	for <lists+cgroups@lfdr.de>; Fri, 17 Jul 2020 03:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgGQBh0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 Jul 2020 21:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgGQBh0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 16 Jul 2020 21:37:26 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB952C061755
        for <cgroups@vger.kernel.org>; Thu, 16 Jul 2020 18:37:25 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id e4so10729295ljn.4
        for <cgroups@vger.kernel.org>; Thu, 16 Jul 2020 18:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4fwyecrqDo3xAzbltI8V1YX+FnW4zOMOFhcPK3N30M4=;
        b=PqXDgyEfEfNOXnWkDOIuH1UvNlOdmlNHdOcwFeIs0TRFLODS2F4x31VrzG+XnVzJa2
         0gcmglp41ZGXXORmw9HPVM8Inf3MWsJb1zyrilKA7A6984hcjxm9VoDbsn7uF5UuAnf6
         g6Tz7lI6M6DhWhNiOz0MaBdM32nQiFUzNtmXmXIKHZWgJt8OZNG6CTlGLwdeg+2CCHkG
         DLyUZeml9wlTTx7pSCfWrc9Kv/vfUlB13w1bwnzVDxJpBfLKdl27pwUOJaLpCHkwPFFq
         V8M17JsKOKGeRitE0UGsQRhMSoP5uVk752fbTY4a/4hHVCDP48BOUUywFB6fUgzl5inl
         lDwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4fwyecrqDo3xAzbltI8V1YX+FnW4zOMOFhcPK3N30M4=;
        b=As65Bnqjg95/4d+A9yDse/icR3PVQHsPZ/muua05tANFjrfNybLKtzshOyPeX0QBqc
         POo3+Sxif1hQBRYu9zCycL931qpTy3XiwYlOO8kxkFHLIFXJidfS2HZk8G/R8lHtwQyx
         uakF1cRj/mmxjEGiExCMU8pM4hqgmnGo4yrTR1cEazF4jdOtqYoqkcWzJ81WEggiZKQo
         AuE1oaxmz8kCVorwaYXt/qqBSrSqAiS2TDu1iZrWYJgZLJRs8L8+RoOLKEt2tL2AO4Zo
         HismLio8aqLaFaV84Xjej9WlN0xYiTYVKFpBFWmY8/LIshgJFmOSYkG/GaNLfhE8C4S2
         qIaw==
X-Gm-Message-State: AOAM5309rlM69THbFDxxwRNWG81xtivbXvOos9j+E5y5DMVbda3WwXjP
        h6FnjXRBCIU3cW701sLTc8gz5T8S8qKJHIZWchUNkA==
X-Google-Smtp-Source: ABdhPJywPNKwcReDncD+Y3Bra8NgMUVwK6PVaktNdLTZgvPMo2hBPWGXBz1DQAnnQ/OryTfZgHjpNLXLY4w6sZ5zxsw=
X-Received: by 2002:a2e:9585:: with SMTP id w5mr2972062ljh.58.1594949844035;
 Thu, 16 Jul 2020 18:37:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200715071522.19663-1-sjpark@amazon.com> <alpine.DEB.2.23.453.2007151031020.2788464@chino.kir.corp.google.com>
 <alpine.DEB.2.23.453.2007161357490.3209847@chino.kir.corp.google.com>
 <CALvZod6DbAUA-M9VXJW4RumeUD8qGf+BHM+9TUNeAr92JVkxsA@mail.gmail.com> <alpine.DEB.2.23.453.2007161427360.3213701@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.23.453.2007161427360.3213701@chino.kir.corp.google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 16 Jul 2020 18:37:12 -0700
Message-ID: <CALvZod65Ja8xc2QBPSOZpwzqL_JudO9e4A1qvXCMCxRoD1_52A@mail.gmail.com>
Subject: Re: [patch] mm, memcg: provide an anon_reclaimable stat
To:     David Rientjes <rientjes@google.com>
Cc:     SeongJae Park <sjpark@amazon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Roman Gushchin <guro@fb.com>, Greg Thelen <gthelen@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jul 16, 2020 at 2:28 PM David Rientjes <rientjes@google.com> wrote:
>
> On Thu, 16 Jul 2020, Shakeel Butt wrote:
>
> > > Userspace can lack insight into the amount of memory that can be reclaimed
> > > from a memcg based on values from memory.stat.  Two specific examples:
> > >
> > >  - Lazy freeable memory (MADV_FREE) that are clean anonymous pages on the
> > >    inactive file LRU that can be quickly reclaimed under memory pressure
> > >    but otherwise shows up as mapped anon in memory.stat, and
> > >
> > >  - Memory on deferred split queues (thp) that are compound pages that can
> > >    be split and uncharged from the memcg under memory pressure, but
> > >    otherwise shows up as charged anon LRU memory in memory.stat.
> > >
> > > Both of this anonymous usage is also charged to memory.current.
> > >
> > > Userspace can currently derive this information but it depends on kernel
> > > implementation details for how this memory is handled for the purposes of
> > > reclaim (anon on inactive file LRU or unmapped anon on the LRU).
> > >
> > > For the purposes of writing portable userspace code that does not need to
> > > have insight into the kernel implementation for reclaimable memory, this
> > > exports a stat that reveals the amount of anonymous memory that can be
> > > reclaimed and uncharged from the memcg to start new applications.
> > >
> > > As the kernel implementation evolves for memory that can be reclaimed
> > > under memory pressure, this stat can be kept consistent.
> > >
> > > Signed-off-by: David Rientjes <rientjes@google.com>
> > > ---
> > >  Documentation/admin-guide/cgroup-v2.rst |  6 +++++
> > >  mm/memcontrol.c                         | 31 +++++++++++++++++++++++++
> > >  2 files changed, 37 insertions(+)
> > >
> > > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> > > --- a/Documentation/admin-guide/cgroup-v2.rst
> > > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > > @@ -1296,6 +1296,12 @@ PAGE_SIZE multiple when read back.
> > >                 Amount of memory used in anonymous mappings backed by
> > >                 transparent hugepages
> > >
> > > +         anon_reclaimable
> > > +               The amount of charged anonymous memory that can be reclaimed
> > > +               under memory pressure without swap.  This currently includes
> > > +               lazy freeable memory (MADV_FREE) and compound pages that can be
> > > +               split and uncharged.
> > > +
> > >           inactive_anon, active_anon, inactive_file, active_file, unevictable
> > >                 Amount of memory, swap-backed and filesystem-backed,
> > >                 on the internal memory management lists used by the
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -1350,6 +1350,32 @@ static bool mem_cgroup_wait_acct_move(struct mem_cgroup *memcg)
> > >         return false;
> > >  }
> > >
> > > +/*
> > > + * Returns the amount of anon memory that is charged to the memcg that is
> > > + * reclaimable under memory pressure without swap, in pages.
> > > + */
> > > +static unsigned long memcg_anon_reclaimable(struct mem_cgroup *memcg)
> > > +{
> > > +       long deferred, lazyfree;
> > > +
> > > +       /*
> > > +        * Deferred pages are charged anonymous pages that are on the LRU but
> > > +        * are unmapped.  These compound pages are split under memory pressure.
> > > +        */
> > > +       deferred = max_t(long, memcg_page_state(memcg, NR_ACTIVE_ANON) +
> > > +                              memcg_page_state(memcg, NR_INACTIVE_ANON) -
> > > +                              memcg_page_state(memcg, NR_ANON_MAPPED), 0);
> >
> > Please note that the NR_ANON_MAPPED does not include tmpfs memory but
> > NR_[IN]ACTIVE_ANON does include the tmpfs.
> >
> > > +       /*
> > > +        * Lazyfree pages are charged clean anonymous pages that are on the file
> > > +        * LRU and can be reclaimed under memory pressure.
> > > +        */
> > > +       lazyfree = max_t(long, memcg_page_state(memcg, NR_ACTIVE_FILE) +
> > > +                              memcg_page_state(memcg, NR_INACTIVE_FILE) -
> > > +                              memcg_page_state(memcg, NR_FILE_PAGES), 0);
> >
> > Similarly NR_FILE_PAGES includes tmpfs memory but NR_[IN]ACTIVE_FILE does not.
> >
>
> Ah, so this adds to the motivation of providing the anon_reclaimable stat
> because the calculation becomes even more convoluted and completely based
> on the kernel implementation details for both lazyfree memory and deferred
> split queues.

Yes, I agree.

> Did you have a calculation in mind for
> memcg_anon_reclaimable()?

 For deferred, "memcg->deferred_split_queue.split_queue_len" should be usable.

For lazyfree, NR_ACTIVE_FILE + NR_INACTIVE_FILE + NR_SHMEM -
NR_FILE_PAGES seems like the right formula.
