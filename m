Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD2542CF6D
	for <lists+cgroups@lfdr.de>; Thu, 14 Oct 2021 02:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhJNAMw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Oct 2021 20:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbhJNAMv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Oct 2021 20:12:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7233C061570;
        Wed, 13 Oct 2021 17:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hwqhlhPOT3W8YxWprAXqKn5R1vpF1HMQTFeRCeyMhDw=; b=FoKN+/qrHz5uAO/YI3Jw7+DfcS
        wey8+yMn4jVTVdQoGQuytIvGWdeySGGmeXw6g9Cgzuo5y39x//Bf9qZFSnjr7kpg7ByYCy+gSATky
        682oPpANaPCttnbqHXfhwTYUHCodIC0TpKPuasCtPIbPzsYUecJz6k54iC6qXbUTt3Q+eSxyRyXE4
        LF/4GcKiTPXlxiOSIWf0UtbgyI+K84SVRgiAzeuPHJdW8/DMbLp/ul8hfUnODBK4CJIHXwIFAIgy+
        P0NEXXPdWRqWAdTnveAGZjFyh5yjv3miio+kzwuf4DIOFrjSUiw/Ey8u5DS35slALKBx3vT3XtGtW
        OshMlsug==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maoIW-007uS2-Qc; Thu, 14 Oct 2021 00:08:54 +0000
Date:   Thu, 14 Oct 2021 01:08:36 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memcg: page_alloc: skip bulk allocator for __GFP_ACCOUNT
Message-ID: <YWd1BDuTinjTYXpH@casper.infradead.org>
References: <20211013194338.1804247-1-shakeelb@google.com>
 <YWdXv+RBjXvdmsK+@carbon.DHCP.thefacebook.com>
 <CALvZod6ZppPNk2XfvKFfdPhrsSF6NbSBKrOOOc6UyJMfDEfKoQ@mail.gmail.com>
 <YWdoj9FZy2B4oLj8@carbon.DHCP.thefacebook.com>
 <CALvZod7oYyGvHAQVO5fg5eCJefeU1J70iUS6-9k0gQ2S8-y7NQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod7oYyGvHAQVO5fg5eCJefeU1J70iUS6-9k0gQ2S8-y7NQ@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Oct 13, 2021 at 04:45:35PM -0700, Shakeel Butt wrote:
> On Wed, Oct 13, 2021 at 4:15 PM Roman Gushchin <guro@fb.com> wrote:
> >
> [...]
> > > >
> > > > Isn't it a bit too aggressive?
> > > >
> > > > How about
> > > >     if (WARN_ON_ONCE(gfp & __GFP_ACCOUNT))
> > >
> > > We actually know that kvmalloc(__GFP_ACCOUNT) users exist and can
> > > trigger bulk page allocator through vmalloc, so I don't think the
> > > warning would be any helpful.
> > >
> > > >        gfp &= ~__GFP_ACCOUNT;
> > >
> > > Bulk allocator is best effort, so callers have adequate fallbacks.
> > > Transparently disabling accounting would be unexpected.
> >
> > I see...
> >
> > Shouldn't we then move this check to an upper level?
> >
> > E.g.:
> >
> > if (!(gfp & __GFP_ACCOUNT))
> >    call_into_bulk_allocator();
> > else
> >    call_into_per_page_allocator();
> >
> 
> If we add this check in the upper level (e.g. in vm_area_alloc_pages()
> ) then I think we would need WARN_ON_ONCE(gfp & __GFP_ACCOUNT) in the
> bulk allocator to detect future users.
> 
> At the moment I am more inclined towards this patch's approach. Let's
> say in future we find there is a __GFP_ACCOUNT allocation which can
> benefit from bulk allocator and we decide to add such support in bulk
> allocator then we would not need to change the bulk allocator callers
> at that time just the bulk allocator.

I agree with you.  Let's apply the patch as-is.
