Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82DF342ABD3
	for <lists+cgroups@lfdr.de>; Tue, 12 Oct 2021 20:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbhJLS0Y (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 12 Oct 2021 14:26:24 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45874 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbhJLS0Y (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 12 Oct 2021 14:26:24 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 92F9221BA8;
        Tue, 12 Oct 2021 18:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634063060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fjxo7ii/mbPa3USk5V6FhOCT1VqaVSL52gmPrnpbKlI=;
        b=FozIsPYNCR9P2yDMD66GyDAPw3qM4v6sJUFevXej8FqVv24e7RMuQ6uoa1qRS6SSvH8GLs
        GrHa1jSGOxGWz2Axwy1lLlzSQdnpY6d2aouFDEJYsMbewpxqyGbXM5OvKpbwBpZOIKDGqY
        eq2RfV1MskQccy/QruqLGoWdo/HTjXE=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id F4036A3B83;
        Tue, 12 Oct 2021 18:24:19 +0000 (UTC)
Date:   Tue, 12 Oct 2021 20:24:19 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Vasily Averin <vvs@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Roman Gushchin <guro@fb.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel@openvz.org
Subject: Re: [PATCH mm v3] memcg: enable memory accounting in
 __alloc_pages_bulk
Message-ID: <YWXS09ZBhZSy6FQQ@dhcp22.suse.cz>
References: <0baa2b26-a41b-acab-b75d-72ec241f5151@virtuozzo.com>
 <60df0efd-f458-a13c-7c89-749bdab21d1d@virtuozzo.com>
 <YWWrai/ChIgycgCo@dhcp22.suse.cz>
 <CALvZod7LpEY98r=pD-k=WbOT-z=Ux16Mfmv3s7PDtJg6=ZStgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod7LpEY98r=pD-k=WbOT-z=Ux16Mfmv3s7PDtJg6=ZStgw@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 12-10-21 09:08:38, Shakeel Butt wrote:
> On Tue, Oct 12, 2021 at 8:36 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Tue 12-10-21 17:58:21, Vasily Averin wrote:
> > > Enable memory accounting for bulk page allocator.
> >
> > ENOCHANGELOG
> >
> > And I have to say I am not very happy about the solution. It adds a very
> > tricky code where it splits different charging steps apart.
> >
> > Would it be just too inefficient to charge page-by-page once all pages
> > are already taken away from the pcp lists? This bulk should be small so
> > this shouldn't really cause massive problems. I mean something like
> >
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index b37435c274cf..8bcd69195ef5 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -5308,6 +5308,10 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
> >
> >         local_unlock_irqrestore(&pagesets.lock, flags);
> >
> > +       if (memcg_kmem_enabled() && (gfp & __GFP_ACCOUNT)) {
> > +               /* charge pages here */
> > +       }
> 
> It is not that simple because __alloc_pages_bulk only allocate pages
> for empty slots in the page_array provided by the caller.
> 
> The failure handling for post charging would be more complicated.

If this is really that complicated (I haven't tried) then it would be
much more simple to completely skip the bulk allocator for __GFP_ACCOUNT
rather than add a tricky code. The bulk allocator is meant to be used
for ultra hot paths and memcg charging along with the reclaim doesn't
really fit into that model anyway. Or are there any actual users who
really need bulk allocator optimization and also need memcg accounting?
-- 
Michal Hocko
SUSE Labs
