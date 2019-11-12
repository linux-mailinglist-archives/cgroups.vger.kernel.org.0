Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC4B2F9904
	for <lists+cgroups@lfdr.de>; Tue, 12 Nov 2019 19:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfKLSp6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 12 Nov 2019 13:45:58 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37324 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfKLSp6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 12 Nov 2019 13:45:58 -0500
Received: by mail-wr1-f68.google.com with SMTP id t1so19726715wrv.4
        for <cgroups@vger.kernel.org>; Tue, 12 Nov 2019 10:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hxMhnNTPNMqUl9aYg/+q9b2xf6WaAQRl4vSfzI/n7p4=;
        b=eLwd7Iy5L1mI4E21IClk5SY41lrRU+CDtVSYFCoaOR/KUjfehCrHpcwrUvhp5HmTAT
         uhs0ezHEN43/gLsummGlDTM/iWi7hu/cK+YLg7/dcWasjaAw10a2+vjz46+e6Ll6PbEd
         kk7UC9to+igCpH1Qy7B86f84kz2U9b0jeR7oGoeHgPuti9b6KYvUj9VoslJCfooG0qk/
         72DcEX4NgQ9jNxxJ7WebVvv6PsNmtNSc3uYsBxmg6jwEtpuvxGLrflrVyJzoCJk2ByKe
         9QVYH8BACYdUA2k9t12xq9WwexnMZMO5giUKpafTjobHbHZ3dpi4zK2f6QHCXUkyDnMY
         G88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hxMhnNTPNMqUl9aYg/+q9b2xf6WaAQRl4vSfzI/n7p4=;
        b=rPc5kNkn0KjMZvJz9J6r5tUxtyT14L0xPnZRQfvLFPtaQjodhLImUPJD4MiPpNfC2b
         pX+NGxWb2hejcuSF35L93en9g5GNhqUt9B+J0/FWGCNWMiyKRLDmoSwsmfd+Q9yxDRBT
         UjmdA05E8KgJ6zVCWI0CVOtg/pexEub/FvRvvLQ4PROSsIE9LdZ98ijn6JtO52EvcoBy
         H9JmEjOoeyq6r6EG1K0+1kEzEhnIXJ126/1Pr+CPwn3kyv1tr/MC4gdcEaN+Y1R3aS4L
         7T+xfJM0jgjYjgOuN7S7dDnvtD+OP+UG4iVuZqxSmu+5y0GnlyEhMH15UomR2QqkRIE+
         WC4A==
X-Gm-Message-State: APjAAAWp4yxGEKEprDJ9kHUaHhvmdK9s8gIvLeUovMR3wErxrrdwr+3a
        3jqNe0u2fpm//2z780V9yvtntAVMH1K013AxXdWhuQ==
X-Google-Smtp-Source: APXvYqwQYYci7I67aRBonFwOTDDHZvisnT9MPd62fmUFGWvgmGL1eI7K9On3FwQg9b+v550fPLGLr8uzThpKIIMkhe0=
X-Received: by 2002:a5d:678c:: with SMTP id v12mr2383882wru.116.1573584355560;
 Tue, 12 Nov 2019 10:45:55 -0800 (PST)
MIME-Version: 1.0
References: <20191107205334.158354-1-hannes@cmpxchg.org> <20191107205334.158354-3-hannes@cmpxchg.org>
 <CAJuCfpFtr9ODyOEJWt+=z=fnR0j8CJPSfhN+50N=d4SjLO-Z7A@mail.gmail.com> <20191112174533.GA178331@cmpxchg.org>
In-Reply-To: <20191112174533.GA178331@cmpxchg.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 12 Nov 2019 10:45:44 -0800
Message-ID: <CAJuCfpHSMcXOZ4zF7X3FVbnyOL_HNgepNYCYsVdcs_gT3Gtm3Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm: vmscan: detect file thrashing at the reclaim root
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Shakeel Butt <shakeelb@google.com>,
        Rik van Riel <riel@surriel.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm <linux-mm@kvack.org>,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Nov 12, 2019 at 9:45 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Sun, Nov 10, 2019 at 06:01:18PM -0800, Suren Baghdasaryan wrote:
> > On Thu, Nov 7, 2019 at 12:53 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > >
> > > We use refault information to determine whether the cache workingset
> > > is stable or transitioning, and dynamically adjust the inactive:active
> > > file LRU ratio so as to maximize protection from one-off cache during
> > > stable periods, and minimize IO during transitions.
> > >
> > > With cgroups and their nested LRU lists, we currently don't do this
> > > correctly. While recursive cgroup reclaim establishes a relative LRU
> > > order among the pages of all involved cgroups, refaults only affect
> > > the local LRU order in the cgroup in which they are occuring. As a
> > > result, cache transitions can take longer in a cgrouped system as the
> > > active pages of sibling cgroups aren't challenged when they should be.
> > >
> > > [ Right now, this is somewhat theoretical, because the siblings, under
> > >   continued regular reclaim pressure, should eventually run out of
> > >   inactive pages - and since inactive:active *size* balancing is also
> > >   done on a cgroup-local level, we will challenge the active pages
> > >   eventually in most cases. But the next patch will move that relative
> > >   size enforcement to the reclaim root as well, and then this patch
> > >   here will be necessary to propagate refault pressure to siblings. ]
> > >
> > > This patch moves refault detection to the root of reclaim. Instead of
> > > remembering the cgroup owner of an evicted page, remember the cgroup
> > > that caused the reclaim to happen. When refaults later occur, they'll
> > > correctly influence the cross-cgroup LRU order that reclaim follows.
> >
> > I spent some time thinking about the idea of calculating refault
> > distance using target_memcg's inactive_age and then activating
> > refaulted page in (possibly) another memcg and I am still having
> > trouble convincing myself that this should work correctly. However I
> > also was unable to convince myself otherwise... We use refault
> > distance to calculate the deficit in inactive LRU space and then
> > activate the refaulted page if that distance is less that
> > active+inactive LRU size. However making that decision based on LRU
> > sizes of one memcg and then activating the page in another one seems
> > very counterintuitive to me. Maybe that's just me though...
>
> It's not activating in a random, unrelated memcg - it's the parental
> relationship that makes it work.
>
> If you have a cgroup tree
>
>         root
>          |
>          A
>         / \
>        B1 B2
>
> and reclaim is driven by a limit in A, we are reclaiming the pages in
> B1 and B2 as if they were on a single LRU list A (it's approximated by
> the round-robin reclaim and has some caveats, but that's the idea).
>
> So when a page that belongs to B2 gets evicted, it gets evicted from
> virtual LRU list A. When it refaults later, we make the (in)active
> size and distance comparisons against virtual LRU list A as well.
>
> The pages on the physical LRU list B2 are not just ordered relative to
> its B2 peers, they are also ordered relative to the pages in B1. And
> that of course is necessary if we want fair competition between them
> under shared reclaim pressure from A.

Thanks for clarification. The testcase in your description when group
B has a large inactive cache which does not get reclaimed while its
sibling group A has to drop its active cache got me under the
impression that sibling cgroups (in your reply above B1 and B2) can
cause memory pressure in each other. Maybe that's not a legit case and
B1 would not cause pressure in B2 without causing pressure in their
shared parent A? It now makes more sense to me and I want to confirm
that is the case.
