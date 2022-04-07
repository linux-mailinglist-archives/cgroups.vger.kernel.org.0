Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D314F7AE1
	for <lists+cgroups@lfdr.de>; Thu,  7 Apr 2022 11:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243557AbiDGJCb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 7 Apr 2022 05:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243533AbiDGJCS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 7 Apr 2022 05:02:18 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70A11F519B;
        Thu,  7 Apr 2022 02:00:18 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id s11so7597589qtc.3;
        Thu, 07 Apr 2022 02:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OH445ysdzmR/6X4//W4FphZ3nFgmJO7HaScUHltGfzw=;
        b=A2BZMU75Gg9tMr3xOhA9ZXdTsJVp+kREzAIB13tKhOdgL+04uX1xdkg9fVTnFs674p
         /fHfbxKgZ61ztlad8Ira/55MLMfPEcdrjUEE5foKxKd8fmuMGv8bdE3QVx7o8ia3fDlR
         s8/yOt1GIWAXGX2d3zLoV2l1EuKXIJXClGdFtfd+EGgaGkka6eXuqe7LtBX4QpAnE/tf
         LkjpH4Cno05i1FFICzv8oLxTiK6aYn7Xu4ZccRb4eN645Hfl6W/0Jg+zAuq5zYt9fyvz
         qQE0t/lDgkJ0J8wk4cyswe0HONJxKNy0t3ElEdvrf6f08wIiu/rOVMVZ5ylHcH6kGFER
         3bfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OH445ysdzmR/6X4//W4FphZ3nFgmJO7HaScUHltGfzw=;
        b=xbxaqUVcuWbshDXo8i3fdmNzx7Qccsu92bcYCjNBIsbR/ARqzrbQkkpuoMgKSia6gm
         zsXTBal7V5qSdBKhWNX6Hs8/ND1dXjPcW7L3STj+XI6EAaJYWRlxL5c1tfjYBDgpjO1j
         FD2g6tSkmWlRbKJ4qwrHTdM8wp0/WwycsbkZYIBsG1xH/GADrWNtcJNOja0RTxMi65eJ
         /A7B4d8LZ9hTxeWmBnSlR0uzb25JvFWfxFQPwnAZNryjO/XAEywU7du9MsT95k4xUj7S
         S6zuXi9fsSchqhAdAEt0GZis4lolJUkdoh6aNhAoqjIFEuG6f8sgp4vqiS4vAIwIVF88
         bgdQ==
X-Gm-Message-State: AOAM532hUIISSdbC6p0Hjv2NgB43XKa/vvVpt23afs6UWEDw7Hrw9QQ0
        XTrVskHMB5AcbU+1HWtFTvIG4TFkBiLO9yEKzzo=
X-Google-Smtp-Source: ABdhPJxkJcaz/OQCc+qvAyLt1HwRQ64uhkf6n9dqvP50oc4eIHNr8Q3rR3052T537/f3WHSshWmFYgHuaFNt7O3iipA=
X-Received: by 2002:a05:622a:1013:b0:2e1:c9c0:9831 with SMTP id
 d19-20020a05622a101300b002e1c9c09831mr10806922qte.245.1649322017903; Thu, 07
 Apr 2022 02:00:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAGWkznFTQCm0cusVxA_55fu2WfT-w2coVHrT=JA1D_9_2728mQ@mail.gmail.com>
 <YkqxpEW4m6iU3zMq@dhcp22.suse.cz> <CAGWkznG4L3w=9bpZp8TjyWHmqFyZQk-3m4xCZ96zhHCLPawBgQ@mail.gmail.com>
 <CAGWkznGMRohE2_at4Qh8KbwSqNmNqOAG2N1EM+7uE9wKqzRm0A@mail.gmail.com>
 <Ykq7KUleuAg5QnNU@dhcp22.suse.cz> <CAGWkznGbd5TOTHZE8uUhak3SnHqEWx_9QCJVtUFUSg9rk3xYEQ@mail.gmail.com>
 <Ykrkx4JML4c81gBV@dhcp22.suse.cz> <CAGWkznEaEavCz9GeiYuTqsox2qZK43iQKevt8njkzaHv6KiW-A@mail.gmail.com>
 <YkwxNaJIg6ptJOYT@dhcp22.suse.cz> <CAGWkznG=QH3HRSzgum0sQBkyQAahqgiWf8nXCv1qXstxrn7e8w@mail.gmail.com>
 <Yk6VZlGnB48RqnYW@dhcp22.suse.cz>
In-Reply-To: <Yk6VZlGnB48RqnYW@dhcp22.suse.cz>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Thu, 7 Apr 2022 16:59:50 +0800
Message-ID: <CAGWkznG+V88f_DjtJAe4_Nr=32Q7Z4b1CaBCB0FVqhAAsuNsWA@mail.gmail.com>
Subject: Re: [RFC PATCH] cgroup: introduce dynamic protection for memcg
To:     Michal Hocko <mhocko@suse.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        Ke Wang <ke.wang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 7, 2022 at 3:40 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 06-04-22 10:11:19, Zhaoyang Huang wrote:
> > On Tue, Apr 5, 2022 at 8:08 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Mon 04-04-22 21:14:40, Zhaoyang Huang wrote:
> > > [...]
> > > > Please be noticed that this patch DOES protect the memcg when external
> > > > pressure is 1GB as fixed low does.
> > >
> > > This is getting more and more confusing (at least to me). Could you
> > > describe the behavior of the reclaim for the following setups/situations?
> > >
> > > a) mostly reclaiming a clean page cache - via kswapd
> > > b) same as above but the direct reclaim is necessary but very
> > >    lightweight
> > > c) direct reclaim makes fwd progress but not enough to satisfy the
> > >    allocation request (so the reclaim has to be retried)
> > > d) direct reclaim not making progress and low limit protection is
> > >    ignored.
> > >
> > > Say we have several memcgs and only some have low memory protection
> > > configured. What is the user observable state of the protected group and
> > > when and how much the protection can be updated?
> > I am not sure if I understand you right. Do you have suspicions on the
> > test result as you think protected memcg has no chance to update the
> > protection or the global reclaim should have been satisfied with the
> > reclaiming(step d is hard to reach?). Let me try to answer it under my
> > understanding, please give me feedback if you need more info. The
> > protection is updated while mem_cgroup_calculate_protection is called
> > during either kswapd or direct reclaim for each round of the priority
> > reclaiming and then the memcg's lruvec will be reached in step d.
>
> This means that limits are altered even if there is memory to be
> reclaimed from other memcgs. Why? How does this line up with the
> basic property of the low limit to act as a protection from the reclaim?
ok, partially understand. I would like to say that low's original
definition under this patch has changed, says the calculated low just
provide protection when the psi value is lower than the setting and
will introduce reclaiming if it exceed. It also can be seen from the
bellowing latest test result(same as previous test but without mlock),
which says that the memcg with fixed low will push back the reclaim to
global LRU while keeping psi to be high. Please be noticed that the
low will be updated when usage raise up over it which means resume the
protection again when the memcg become active.

                          psi(global=1GB)        max      stable
  psi(global=2GB)     max      stable
Low=400MB      some=18 full=11       700MB 600MB       some=20 full=16
    400MB 400MB
Low=500MB      some=18 full=13       680MB 540MB       some=27 full=17
    500MB 500MB
patch setting1    some=19 full=13       863MB 740MB       some=15
full=10     500MB 500MB
patch setting1    some=14 full=11       640MB 470MB       some=20
full=12     360MB 320MB

>
> > > I think it would be also helpful to describe the high level semantic of
> > > this feature.
>
> Please focus on this part. Without a high level semantic explained we
> will not move forward.
> --
> Michal Hocko
> SUSE Labs
