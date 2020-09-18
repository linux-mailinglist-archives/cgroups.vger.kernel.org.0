Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E21226F9D6
	for <lists+cgroups@lfdr.de>; Fri, 18 Sep 2020 12:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgIRKF0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 18 Sep 2020 06:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgIRKF0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 18 Sep 2020 06:05:26 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453F6C061756
        for <cgroups@vger.kernel.org>; Fri, 18 Sep 2020 03:05:26 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id r9so6230581ioa.2
        for <cgroups@vger.kernel.org>; Fri, 18 Sep 2020 03:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tKpKlwFxE/39Tq6tMnMvMGGEoIVDpx+E7ENkqZZboZE=;
        b=EAU6yIwWUP700pYltAkLeyv/EJ4jmGkC/6uulyxvIfmnno2fXnw28EXyO638X6p30F
         6QKg74XAhnxGVYZlqWaJ2W7PbmLZXps8C6NWFTdzbkiHwOxxXJ2xmLGx8R6zERCjsUtk
         Z6dR5T9iUuzOocQpJ2QMHotpJxxLyHkqBbMaoCSzyPGlnAy47QlDpEblv9Xmcae3yuXO
         hHT4gvOAI/onUM4v3bVAFIn6Tv7m4foLxK8hn/Ji7xkrRn4JQMD90F2cd1c5VjtVGkph
         iG6OQl8UUmy94pHEJdBtqPmXvrQ5wsVv/T6ioY9o+LkUqjoDCVVWkUXJNJDviefbIzkM
         0Uaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tKpKlwFxE/39Tq6tMnMvMGGEoIVDpx+E7ENkqZZboZE=;
        b=Dkk7t33Sl+0wvqS+hEK7I33V847E1cfei8JK/IrcsapFBVVlxRIl7RfJLlRSpsyggA
         UZIkRQsROIbJQl8QQQPFl49UexySaEHOB2lNuy/r8FlIfrBEfzG1iWLIQIIPyLpnMCSu
         kmmvdQ8X90V0XQ7SUzBXCvcRY5NNZdo5zrYrPkSjEJK6Ecp5Syw+aEWhtSJTuHpQwafn
         wbskZv1bpyywLDcuGUz6VOvy1BitQpPZzQNRN2IQxvubyidBt+1c20C+2iYzG0OL0Oep
         uCN2Kl4kKRYzkN8SOAVO+FU0v1ayJUuBmQPev8JEw7b9LneOLHG7CEavWKrLEp6b/12o
         BDUQ==
X-Gm-Message-State: AOAM532MYBuTAhqG7ToeQtXT9VfwdmWSils8vuUPZ5hswJZKMWCvBW+r
        EBySOwhupqoRbEWXHjozdVvONA==
X-Google-Smtp-Source: ABdhPJxgZENA+h9K/7zkxW9KxPd/YwwYwHqRsRfNb5vxQ4YE+laNn+R6v9cnVKRUAT70anyE5CAM5Q==
X-Received: by 2002:a6b:db1a:: with SMTP id t26mr27699803ioc.152.1600423525339;
        Fri, 18 Sep 2020 03:05:25 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:7220:84ff:fe09:2d90])
        by smtp.gmail.com with ESMTPSA id f21sm1291361ioh.1.2020.09.18.03.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 03:05:24 -0700 (PDT)
Date:   Fri, 18 Sep 2020 04:05:19 -0600
From:   Yu Zhao <yuzhao@google.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Huang Ying <ying.huang@intel.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Jaewon Kim <jaewon31.kim@samsung.com>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/13] mm: use add_page_to_lru_list()
Message-ID: <20200918100519.GA1004594@google.com>
References: <20200918030051.650890-1-yuzhao@google.com>
 <20200918030051.650890-2-yuzhao@google.com>
 <20200918073240.GD28827@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918073240.GD28827@dhcp22.suse.cz>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Sep 18, 2020 at 09:32:40AM +0200, Michal Hocko wrote:
> On Thu 17-09-20 21:00:39, Yu Zhao wrote:
> > This patch replaces the only open-coded lru list addition with
> > add_page_to_lru_list().
> > 
> > Before this patch, we have:
> > 	update_lru_size()
> > 	list_move()
> > 
> > After this patch, we have:
> > 	list_del()
> > 	add_page_to_lru_list()
> > 		update_lru_size()
> > 		list_add()
> > 
> > The only side effect is that page->lru is temporarily poisoned
> > after a page is deleted from its old list, which shouldn't be a
> > problem.
> 
> "because the lru lock is held" right?
> 
> Please always be explicit about your reasoning. "It shouldn't be a
> problem" without further justification is just pointless for anybody
> reading the code later on.

It's not my reasoning. We are simply assuming different contexts this
discussion is under. In the context I'm assuming, we all know we are
under lru lock, which is rule 101 of lru list operations. But I'd be
happy to remove such assumption and update the commit message.

Any concern with the code change?

>  
> > Signed-off-by: Yu Zhao <yuzhao@google.com>
> > ---
> >  mm/vmscan.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 9727dd8e2581..503fc5e1fe32 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -1850,8 +1850,8 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
> >  	while (!list_empty(list)) {
> >  		page = lru_to_page(list);
> >  		VM_BUG_ON_PAGE(PageLRU(page), page);
> > +		list_del(&page->lru);
> >  		if (unlikely(!page_evictable(page))) {
> > -			list_del(&page->lru);
> >  			spin_unlock_irq(&pgdat->lru_lock);
> >  			putback_lru_page(page);
> >  			spin_lock_irq(&pgdat->lru_lock);
> > @@ -1862,9 +1862,7 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
> >  		SetPageLRU(page);
> >  		lru = page_lru(page);
> >  
> > -		nr_pages = thp_nr_pages(page);
> > -		update_lru_size(lruvec, lru, page_zonenum(page), nr_pages);
> > -		list_move(&page->lru, &lruvec->lists[lru]);
> > +		add_page_to_lru_list(page, lruvec, lru);
> >  
> >  		if (put_page_testzero(page)) {
> >  			__ClearPageLRU(page);
> > @@ -1878,6 +1876,7 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
> >  			} else
> >  				list_add(&page->lru, &pages_to_free);
> >  		} else {
> > +			nr_pages = thp_nr_pages(page);
> >  			nr_moved += nr_pages;
> >  			if (PageActive(page))
> >  				workingset_age_nonresident(lruvec, nr_pages);
> > -- 
> > 2.28.0.681.g6f77f65b4e-goog
> 
> -- 
> Michal Hocko
> SUSE Labs
