Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB472A77FD
	for <lists+cgroups@lfdr.de>; Thu,  5 Nov 2020 08:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729584AbgKEH0z (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Nov 2020 02:26:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:47630 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729676AbgKEH0z (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 5 Nov 2020 02:26:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604561213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7u8WU2glLXwmDXGmWhq8HEE0VcTO5euQA0K+KFX8imM=;
        b=CKGlAZyPZ4aTYZUlXLHpQXRt2TISR1HhHVdLGTH0ns+IR/vvZeP4nXAmF7xQs8Gcm3mcAT
        364yvAObtYTkvBCbY5jTa9rz2u287WqQHDXs7j6mvVgx2r6trkHfmAr8j8LmivMGE5LPb/
        lN+iKojPT5oJ3DBCBVRt+vpDOFUb9eU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 40690AB95;
        Thu,  5 Nov 2020 07:26:53 +0000 (UTC)
Date:   Thu, 5 Nov 2020 08:26:52 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Hui Su <sh_def@163.com>, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, akpm@linux-foundation.org,
        shakeelb@google.com, laoar.shao@gmail.com, chris@chrisdown.name,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm/memcontrol:rewrite mem_cgroup_page_lruvec()
Message-ID: <20201105072652.GA21348@dhcp22.suse.cz>
References: <20201104142516.GA106571@rlk>
 <20201104223800.GD1938922@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104223800.GD1938922@carbon.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 04-11-20 14:38:00, Roman Gushchin wrote:
> On Wed, Nov 04, 2020 at 10:25:16PM +0800, Hui Su wrote:
> > mem_cgroup_page_lruvec() in memcontrol.c and
> > mem_cgroup_lruvec() in memcontrol.h is very similar
> > except for the param(page and memcg) which also can be
> > convert to each other.
> > 
> > So rewrite mem_cgroup_page_lruvec() with mem_cgroup_lruvec().
> > 
> > Signed-off-by: Hui Su <sh_def@163.com>
> > ---
> >  include/linux/memcontrol.h | 18 +++++++++++++++--
> >  mm/memcontrol.c            | 40 --------------------------------------
> >  2 files changed, 16 insertions(+), 42 deletions(-)
> > 
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index e391e3c56de5..a586363fb766 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -457,9 +457,10 @@ mem_cgroup_nodeinfo(struct mem_cgroup *memcg, int nid)
> >  /**
> >   * mem_cgroup_lruvec - get the lru list vector for a memcg & node
> >   * @memcg: memcg of the wanted lruvec
> > + * @pgdat: pglist_data
> >   *
> >   * Returns the lru list vector holding pages for a given @memcg &
> > - * @node combination. This can be the node lruvec, if the memory
> > + * @pgdat combination. This can be the node lruvec, if the memory
> >   * controller is disabled.
> >   */
> >  static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
> > @@ -489,7 +490,20 @@ static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
> >  	return lruvec;
> >  }
> 
> Hi Hui,
> 
> >  
> > -struct lruvec *mem_cgroup_page_lruvec(struct page *, struct pglist_data *);
> > +/**
> > + * mem_cgroup_page_lruvec - return lruvec for isolating/putting an LRU page
> > + * @page: the page
> > + * @pgdat: pgdat of the page
> > + *
> > + * This function relies on page->mem_cgroup being stable.
> > + */
> > +static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page,
> > +						struct pglist_data *pgdat)
> 
> Hm, do we need to pass page and pgdat?

Not really because page already knows its node so pgdat can be easily
taken from there. I suspect the only reason for having pgdat here is
that many callers already know it and we optimize for memcg disable
case. Hard to tell whether this actually matters because most of those
paths are not really hot but something that would require a deeper
investigation. Hint hint...

Anyway, this looks like a nice simplification already. There were some
attempts to do similar thing recently but they were adding nodeid as an
additional argument and I really disliked those.

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

-- 
Michal Hocko
SUSE Labs
