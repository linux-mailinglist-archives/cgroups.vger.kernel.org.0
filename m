Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB0182589
	for <lists+cgroups@lfdr.de>; Mon,  5 Aug 2019 21:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730155AbfHETZL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 5 Aug 2019 15:25:11 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:44923 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbfHETZK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 5 Aug 2019 15:25:10 -0400
Received: by mail-yw1-f67.google.com with SMTP id l79so29980268ywe.11
        for <cgroups@vger.kernel.org>; Mon, 05 Aug 2019 12:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jBhZHZxcR0OIAcxY7/57CQdVnxqW0BKtiYJig9O330A=;
        b=OWoEZJcfzeB9SYxPFawo056U4q1al2l7k+0gU3JECGIOX5fJ9AIdUCnznZLyUznYRF
         Tt203xpJn7adxpO28UHjqgDOoQm2q85rp40ZFW+XF8uvBcrlSXeStp3k0U3tihqqdSZG
         HqAu/l+qBcDLyzGHEVoJraaaC6fsenAwxprN829u8nILdwy08WqWvqliXoPBXr2Y/7JM
         b7Nf9zKAJdeZoKdGBMxeicWw3wXpN10PUPyvRrn6Hzdwvuh0Ss0RCTr5DRAAeRPt0GnF
         uzYpyuws4/j/4HUokCCBpgk9/3CI8BxdwHhbi3hJWUq/6jl9NtTOOd8QPD+zqw5w5f6u
         nx+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jBhZHZxcR0OIAcxY7/57CQdVnxqW0BKtiYJig9O330A=;
        b=GtYgpWYkcmha1KPG1JPQEcjpZrjLx5WrsykMvROsFQPulaEE4OUhC9LrnMYzTsmriK
         KllNMT+W6Q6luKqiDgRAW/bUNnNvJYsQVEFnRAkIZC9TZQM+mN0G/rxc/DMUuixV7T/w
         YuFZ6LHfWi9ecemjRw01aHnnvA5gpKTjsVgeAXT20qVIDVGpl1YzLQF5gc1Y3yyhPaKt
         kNFQ7jfqFB56jGi9gyXgIv7CIzkG5CFPH3Oz8Ts+NQ8ngUHMuXTSsURbC1SLnmDkM4Rd
         fbmJiF4NAKYrx9gXt02QP6n3bLxWhGep1dOc1gid7VCpAnDIp2wF58uI1tRrt09Ejpo1
         ++6Q==
X-Gm-Message-State: APjAAAWsBRhlwvI9zHuMIdXdooR2/+d+rkN8/SccHSOxzB7usGlrToQK
        a6+wmxFuvBEhP9eGePiiYlTZKu0oWLnSnUIqNjXdcg==
X-Google-Smtp-Source: APXvYqxbDkA1SdB4BSUlDwh2X+zCd0WZTNLSo8tmRckemDIdGtE48knQ4mlRNXjwS7YqcsgBexfZZdY7HIiqIwx86rc=
X-Received: by 2002:a0d:cb42:: with SMTP id n63mr37267027ywd.205.1565033109503;
 Mon, 05 Aug 2019 12:25:09 -0700 (PDT)
MIME-Version: 1.0
References: <156431697805.3170.6377599347542228221.stgit@buzz>
 <20190729091738.GF9330@dhcp22.suse.cz> <3d6fc779-2081-ba4b-22cf-be701d617bb4@yandex-team.ru>
 <20190729103307.GG9330@dhcp22.suse.cz> <CAHbLzkrdj-O2uXwM8ujm90OcgjyR4nAiEbFtRGe7SOoY_fs=BA@mail.gmail.com>
 <20190729184850.GH9330@dhcp22.suse.cz> <CAHbLzkp9xFV2sE0TdKfWNRVcAwaYNKwDugRiBBoEKx6A_Hr3Jw@mail.gmail.com>
 <20190802093507.GF6461@dhcp22.suse.cz> <CAHbLzkrjh7KEvdfXackaVy8oW5CU=UaBucERffxcUorgq1vdoA@mail.gmail.com>
 <20190805143239.GS7597@dhcp22.suse.cz>
In-Reply-To: <20190805143239.GS7597@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 5 Aug 2019 12:24:58 -0700
Message-ID: <CALvZod5upYA2UgUSWJjrL7K=zifhwwvK5M_gUakPhf2fP-3HxA@mail.gmail.com>
Subject: Re: [PATCH RFC] mm/memcontrol: reclaim severe usage over high limit
 in get_user_pages loop
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Yang Shi <shy828301@gmail.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Aug 5, 2019 at 7:32 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Fri 02-08-19 11:56:28, Yang Shi wrote:
> > On Fri, Aug 2, 2019 at 2:35 AM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > On Thu 01-08-19 14:00:51, Yang Shi wrote:
> > > > On Mon, Jul 29, 2019 at 11:48 AM Michal Hocko <mhocko@kernel.org> wrote:
> > > > >
> > > > > On Mon 29-07-19 10:28:43, Yang Shi wrote:
> > > > > [...]
> > > > > > I don't worry too much about scale since the scale issue is not unique
> > > > > > to background reclaim, direct reclaim may run into the same problem.
> > > > >
> > > > > Just to clarify. By scaling problem I mean 1:1 kswapd thread to memcg.
> > > > > You can have thousands of memcgs and I do not think we really do want
> > > > > to create one kswapd for each. Once we have a kswapd thread pool then we
> > > > > get into a tricky land where a determinism/fairness would be non trivial
> > > > > to achieve. Direct reclaim, on the other hand is bound by the workload
> > > > > itself.
> > > >
> > > > Yes, I agree thread pool would introduce more latency than dedicated
> > > > kswapd thread. But, it looks not that bad in our test. When memory
> > > > allocation is fast, even though dedicated kswapd thread can't catch
> > > > up. So, such background reclaim is best effort, not guaranteed.
> > > >
> > > > I don't quite get what you mean about fairness. Do you mean they may
> > > > spend excessive cpu time then cause other processes starvation? I
> > > > think this could be mitigated by properly organizing and setting
> > > > groups. But, I agree this is tricky.
> > >
> > > No, I meant that the cost of reclaiming a unit of charges (e.g.
> > > SWAP_CLUSTER_MAX) is not constant and depends on the state of the memory
> > > on LRUs. Therefore any thread pool mechanism would lead to unfair
> > > reclaim and non-deterministic behavior.
> >
> > Yes, the cost depends on the state of pages, but I still don't quite
> > understand what does "unfair" refer to in this context. Do you mean
> > some cgroups may reclaim much more than others?
>
> > Or the work may take too long so it can't not serve other cgroups in time?
>
> exactly.
>

How about allowing the users to implement their own user space kswapd?
A memcg interface similar to MADV_PAGEOUT. Users can register for
MEMCG_HIGH notification (it needs some modification) and on receiving
the notification, the uswapd (User's kswapd) will trigger reclaim
through memory.pageout (or memory.try_to_free_pages). One can argue
why not just use MADV_PAGEOUT? In real workload, a job can be a
combination of different sub-jobs and most probably may not know the
importance of the memory layout of the tasks of the sub-jobs. So, a
memcg level interface makes more sense there.

Shakeel
