Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2C3F9781
	for <lists+cgroups@lfdr.de>; Tue, 12 Nov 2019 18:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfKLRpg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 12 Nov 2019 12:45:36 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:42430 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfKLRpf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 12 Nov 2019 12:45:35 -0500
Received: by mail-qv1-f68.google.com with SMTP id c9so6715096qvz.9
        for <cgroups@vger.kernel.org>; Tue, 12 Nov 2019 09:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SKH1z3odsh0dOqBa6+gRpBBgGUSs+RoaA3vn9y35Y60=;
        b=ub/z2usVbtFPjwv5NwXjzZOGEt0DMd+Iqld9+xj+Yl6kgLI5sbPVNMFYOb8FphZv/b
         BOH6/CImQShh5zf1106fe38oXqHRiOImx+m4x4mvAz4Qiv++Jict33McH/GHVy/Em7Cm
         rxBENqSGDHcpOZgHBAKZTNDa9Kp7QPzrahLz2q2Siu7mCw4UbnAsPy6VJYwsQ8hizkIz
         X2XmaOmYD5vh7g0N+ByQiR749Kio6CNFkkJXHceQLzfJNGFB3s3HYpC0QUXfvxl/yL//
         kFFf8yaTa6YP9NebtFV7KnpIECtsJ3ZV+J0KSn7s/bPmFMlcMf3Zi99mkvW7tnZv2/Th
         NXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SKH1z3odsh0dOqBa6+gRpBBgGUSs+RoaA3vn9y35Y60=;
        b=CeiJexkeaYeq9uTH/aw7fUqFDpaRGsulEZ4t+jCtbzW8LcDLUaVuBM16IwJcJ6fQSC
         fTGalfd6xYsiXPoGhi/UuFVC040/5YyHTXmi+cp2XnRIJzYV7ZSBz9Yz8PxFViHhsjnw
         rIUOdFeJS/bs8mZEvHcaiQ1ggQOz+ohzctwVz7xGuDLISzL7iGYERvFBd4R+wN7aST9E
         fjekw5mg5jJ2RRAWE9BJwygp5DsyMXVei6MQDcArPGQECyuqa91ZNrrlDybwWHUJdXPX
         QlyRzrZjrgh7phfjj34IENvfpaqB9meR10djEhiTXXEGmSez+tLJcf8qNnqHFvTCn9xy
         SlIQ==
X-Gm-Message-State: APjAAAXkdUk+uYsgRu7nLQBuDiKN1kBVhpTrwnk3MxzONU+wLPWuBaV8
        WkyPwwICpTtZse9PfmiD/e1Zcw==
X-Google-Smtp-Source: APXvYqx1IVJr4fbG3VE4xzwfF+4/eGG9CfF0SUyfwLgcuYPB9sFtW/qdTwELYrUt14O8oOUOEMMvHQ==
X-Received: by 2002:ad4:5441:: with SMTP id h1mr17265157qvt.120.1573580734695;
        Tue, 12 Nov 2019 09:45:34 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::aa8c])
        by smtp.gmail.com with ESMTPSA id z5sm10649218qtm.9.2019.11.12.09.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 09:45:33 -0800 (PST)
Date:   Tue, 12 Nov 2019 12:45:33 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Shakeel Butt <shakeelb@google.com>,
        Rik van Riel <riel@surriel.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm <linux-mm@kvack.org>,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@fb.com
Subject: Re: [PATCH 2/3] mm: vmscan: detect file thrashing at the reclaim root
Message-ID: <20191112174533.GA178331@cmpxchg.org>
References: <20191107205334.158354-1-hannes@cmpxchg.org>
 <20191107205334.158354-3-hannes@cmpxchg.org>
 <CAJuCfpFtr9ODyOEJWt+=z=fnR0j8CJPSfhN+50N=d4SjLO-Z7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpFtr9ODyOEJWt+=z=fnR0j8CJPSfhN+50N=d4SjLO-Z7A@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Nov 10, 2019 at 06:01:18PM -0800, Suren Baghdasaryan wrote:
> On Thu, Nov 7, 2019 at 12:53 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > We use refault information to determine whether the cache workingset
> > is stable or transitioning, and dynamically adjust the inactive:active
> > file LRU ratio so as to maximize protection from one-off cache during
> > stable periods, and minimize IO during transitions.
> >
> > With cgroups and their nested LRU lists, we currently don't do this
> > correctly. While recursive cgroup reclaim establishes a relative LRU
> > order among the pages of all involved cgroups, refaults only affect
> > the local LRU order in the cgroup in which they are occuring. As a
> > result, cache transitions can take longer in a cgrouped system as the
> > active pages of sibling cgroups aren't challenged when they should be.
> >
> > [ Right now, this is somewhat theoretical, because the siblings, under
> >   continued regular reclaim pressure, should eventually run out of
> >   inactive pages - and since inactive:active *size* balancing is also
> >   done on a cgroup-local level, we will challenge the active pages
> >   eventually in most cases. But the next patch will move that relative
> >   size enforcement to the reclaim root as well, and then this patch
> >   here will be necessary to propagate refault pressure to siblings. ]
> >
> > This patch moves refault detection to the root of reclaim. Instead of
> > remembering the cgroup owner of an evicted page, remember the cgroup
> > that caused the reclaim to happen. When refaults later occur, they'll
> > correctly influence the cross-cgroup LRU order that reclaim follows.
> 
> I spent some time thinking about the idea of calculating refault
> distance using target_memcg's inactive_age and then activating
> refaulted page in (possibly) another memcg and I am still having
> trouble convincing myself that this should work correctly. However I
> also was unable to convince myself otherwise... We use refault
> distance to calculate the deficit in inactive LRU space and then
> activate the refaulted page if that distance is less that
> active+inactive LRU size. However making that decision based on LRU
> sizes of one memcg and then activating the page in another one seems
> very counterintuitive to me. Maybe that's just me though...

It's not activating in a random, unrelated memcg - it's the parental
relationship that makes it work.

If you have a cgroup tree

	root
         |
         A
        / \
       B1 B2

and reclaim is driven by a limit in A, we are reclaiming the pages in
B1 and B2 as if they were on a single LRU list A (it's approximated by
the round-robin reclaim and has some caveats, but that's the idea).

So when a page that belongs to B2 gets evicted, it gets evicted from
virtual LRU list A. When it refaults later, we make the (in)active
size and distance comparisons against virtual LRU list A as well.

The pages on the physical LRU list B2 are not just ordered relative to
its B2 peers, they are also ordered relative to the pages in B1. And
that of course is necessary if we want fair competition between them
under shared reclaim pressure from A.
