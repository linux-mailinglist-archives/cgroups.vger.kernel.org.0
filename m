Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D53FD26FB66
	for <lists+cgroups@lfdr.de>; Fri, 18 Sep 2020 13:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgIRLYZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 18 Sep 2020 07:24:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:39838 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726241AbgIRLYY (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 18 Sep 2020 07:24:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600428262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d9PDsqIPyVPgLukahRA3ETtD+nKIvQ1Ol6YmX3nuefQ=;
        b=FN30aRJ+ozUNW8fiN2FsyLCLrqgxgpM8NlMau1poGqllAwZcl0sFk4WIV0FXGuQOCDsHaB
        xt5dtdhGhw0LG9dsXVvBh0Eww6TzCSGW9Zmd4Zj+jJlGBwh4qNgpD+nmqrKsHRxQpwpjT5
        fs8B3XBQGbuNi3wHzkHLM0Y0N7GQDXc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 95D51B195;
        Fri, 18 Sep 2020 11:24:56 +0000 (UTC)
Date:   Fri, 18 Sep 2020 13:24:21 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yu Zhao <yuzhao@google.com>
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
Subject: Re: [PATCH 02/13] mm: use page_off_lru()
Message-ID: <20200918112421.GL28827@dhcp22.suse.cz>
References: <20200918030051.650890-1-yuzhao@google.com>
 <20200918030051.650890-3-yuzhao@google.com>
 <20200918073700.GE28827@dhcp22.suse.cz>
 <20200918102713.GB1004594@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918102713.GB1004594@google.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 18-09-20 04:27:13, Yu Zhao wrote:
> On Fri, Sep 18, 2020 at 09:37:00AM +0200, Michal Hocko wrote:
[...]
> And I have asked this before: why does 'the compound page situation'
> even matter here? Perhaps if you could give a concrete example related
> to the code change and help me understand your concern?

Forgot to answer this part. The compound page concern is a misreading of
the patch on my end. I have missed you are using page_off_lru in this
(move_pages_to_lru) path and that you rely on release_pages to do the
clean up on you. I still find it rather awkward that page_off_lru has
such side effects but I am not deeply familiar with the reasoning
behind so I will rather shut up now.

[...]
> > > @@ -1860,14 +1859,11 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
> > >  		lruvec = mem_cgroup_page_lruvec(page, pgdat);
> > >  
> > >  		SetPageLRU(page);
> > > -		lru = page_lru(page);
> > > -
> > >  		add_page_to_lru_list(page, lruvec, lru);
> > >  
> > >  		if (put_page_testzero(page)) {
> > >  			__ClearPageLRU(page);
> > > -			__ClearPageActive(page);
> > > -			del_page_from_lru_list(page, lruvec, lru);
> > > +			del_page_from_lru_list(page, lruvec, page_off_lru(page));
> > >  
> > >  			if (unlikely(PageCompound(page))) {
> > >  				spin_unlock_irq(&pgdat->lru_lock);
> > > -- 
> > > 2.28.0.681.g6f77f65b4e-goog
> > 
> > -- 
> > Michal Hocko
> > SUSE Labs

-- 
Michal Hocko
SUSE Labs
