Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81D7742DDC8
	for <lists+cgroups@lfdr.de>; Thu, 14 Oct 2021 17:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbhJNPPp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 Oct 2021 11:15:45 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55968 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbhJNPPp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 14 Oct 2021 11:15:45 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7E4441FD39;
        Thu, 14 Oct 2021 15:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634224419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QE4+A40zXiKCiQ946QCo1/U24aTkHA32OG4HCqemGgQ=;
        b=LfxkknrhXNsBI23uUnynPj0T/3sYGaQU2Lce7KpdjjlqDHbi0zRgYT482Jr3NdviS1kNEp
        1xCNxU7X/Ju96xFEeWLSc7xxqT0GcZfsgXXmYRMUlYP4fxM1AGKMwwqRi27BlG9r0tKFoO
        1DHxQDZ7OE11EN1lz+znIwQp4FnTWVE=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 59965A3B81;
        Thu, 14 Oct 2021 15:13:39 +0000 (UTC)
Date:   Thu, 14 Oct 2021 17:13:39 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memcg: page_alloc: skip bulk allocator for __GFP_ACCOUNT
Message-ID: <YWhJI4JbOkUVprfn@dhcp22.suse.cz>
References: <20211013194338.1804247-1-shakeelb@google.com>
 <YWfZNF7T7Fm69sik@dhcp22.suse.cz>
 <CALvZod4Br9iwq-qfdwj6dzgW2g1vEr2YL4=w_mQjOeWWDQzFjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod4Br9iwq-qfdwj6dzgW2g1vEr2YL4=w_mQjOeWWDQzFjw@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 14-10-21 08:01:16, Shakeel Butt wrote:
> On Thu, Oct 14, 2021 at 12:16 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Wed 13-10-21 12:43:38, Shakeel Butt wrote:
> > [...]
> > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > index 668edb16446a..b3acad4615d3 100644
> > > --- a/mm/page_alloc.c
> > > +++ b/mm/page_alloc.c
> > > @@ -5215,6 +5215,10 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
> > >       unsigned int alloc_flags = ALLOC_WMARK_LOW;
> > >       int nr_populated = 0, nr_account = 0;
> > >
> > > +     /* Bulk allocator does not support memcg accounting. */
> > > +     if (unlikely(gfp & __GFP_ACCOUNT))
> > > +             goto out;
> >
> > Did you mean goto failed here? This would break some which do not
> > have any fallback. E.g. xfs_buf_alloc_pages but likely more.
> >
> > Sorry I could have been more specific when talking about bypassing the
> > bulk allocator. It is quite confusing because the bulk allocator
> > interface consists of the bulk allocator and the fallback to the normal
> > page allocator.
> >
> 
> I did consider 'goto failed' here but for that I have to move
> __GFP_ACCOUNT check after the "Already populated array" check in the
> function. Basically what's the point of doing other operations
> (incrementing nr_populated) if we are gonna skip bulk anyways.

I have to say I do not follow why that is a problem.

> Regarding xfs_buf_alloc_pages(), it is not using __GFP_ACCOUNT and
> vmalloc() is the only __GFP_ACCOUNT user at this point. So, not an
> issue for now but I suppose it is better to be future-proof and do the
> 'goto failed'.

Why do we want to have that silent trap?
-- 
Michal Hocko
SUSE Labs
