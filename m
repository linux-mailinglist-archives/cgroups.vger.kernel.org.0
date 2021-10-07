Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71FDE42550A
	for <lists+cgroups@lfdr.de>; Thu,  7 Oct 2021 16:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241971AbhJGOL1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 7 Oct 2021 10:11:27 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:49740 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241969AbhJGOL1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 7 Oct 2021 10:11:27 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C7E031FE69;
        Thu,  7 Oct 2021 14:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633615772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WmZKoam4uBlUDsnpZKT/JNi5wCzxXcwmvOZK6uuOEFg=;
        b=DX00fro/nO0M6nMJsbLq5A59Q930GGbaG5RXcV0COZ9djL12NCiWBy9iyVEHyrkJTosAO7
        BpsNiM1nZ0wyW/3b0NgE9FcTgVDxjhXBMmG2Ix6e0OkQ5wAppcTI0pHu/sAzfpG8K0vGJN
        +BZQY9ZHD0bSulDNGigFjQ4WZ8sZHL0=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 95E38A3B87;
        Thu,  7 Oct 2021 14:09:32 +0000 (UTC)
Date:   Thu, 7 Oct 2021 16:09:29 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Vasily Averin <vvs@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel@openvz.org, Mel Gorman <mgorman@suse.de>,
        Uladzislau Rezki <urezki@gmail.com>
Subject: Re: memcg memory accounting in vmalloc is broken
Message-ID: <YV7/mS8oIL4E5nmS@dhcp22.suse.cz>
References: <b3c232ff-d9dc-4304-629f-22cc95df1e2e@virtuozzo.com>
 <YV6sIz5UjfbhRyHN@dhcp22.suse.cz>
 <YV6s+ze8LzuxfvOM@dhcp22.suse.cz>
 <953ef8e2-1221-a12c-8f71-e34e477a52e8@virtuozzo.com>
 <0668b6d8-6f8c-07c7-75e0-5448ea87cb54@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0668b6d8-6f8c-07c7-75e0-5448ea87cb54@suse.cz>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 07-10-21 16:00:21, Vlastimil Babka wrote:
> On 10/7/21 10:50, Vasily Averin wrote:
> > On 10/7/21 11:16 AM, Michal Hocko wrote:
> >> Cc Mel and Uladzislau
> >> 
> >> On Thu 07-10-21 10:13:23, Michal Hocko wrote:
> >>> On Thu 07-10-21 11:04:40, Vasily Averin wrote:
> >>>> vmalloc was switched to __alloc_pages_bulk but it does not account the memory to memcg.
> >>>>
> >>>> Is it known issue perhaps?
> >>>
> >>> No, I think this was just overlooked. Definitely doesn't look
> >>> intentional to me.
> > 
> > I use following patch as a quick fix,
> > it helps though it is far from ideal and can be optimized.
> > 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index b37435c274cf..e6abe2cac159 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -5290,6 +5290,12 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
> >  
> >  		page = __rmqueue_pcplist(zone, 0, ac.migratetype, alloc_flags,
> >  								pcp, pcp_list);
> > +
> > +		if (memcg_kmem_enabled() && (gfp & __GFP_ACCOUNT) && page &&
> > +		    unlikely(__memcg_kmem_charge_page(page, gfp, 0) != 0)) {
> > +			__free_pages(page, 0);
> 
> It's too early for this here, we didn't go through prep_new_page() yet,
> minimally the post_alloc_hook() -> set_page_refcounted() part, required for
> put_page_testzero() in __free_pages() to work properly, and probably other
> stuff.
> Either do the full prep+free or a minimal reversion of  __rmqueue_pcplist -
> something to just put the page back to pcplist. Probably the former so we
> don't introduce subtle errors.

Very well spotted!
-- 
Michal Hocko
SUSE Labs
