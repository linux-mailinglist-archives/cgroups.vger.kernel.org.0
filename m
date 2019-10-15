Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9043D7369
	for <lists+cgroups@lfdr.de>; Tue, 15 Oct 2019 12:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730279AbfJOKg0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 15 Oct 2019 06:36:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:33850 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726441AbfJOKg0 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 15 Oct 2019 06:36:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 725E6AE39;
        Tue, 15 Oct 2019 10:36:24 +0000 (UTC)
Date:   Tue, 15 Oct 2019 12:36:23 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] mm/memcontrol: update lruvec counters in
 mem_cgroup_move_account
Message-ID: <20191015103623.GX317@dhcp22.suse.cz>
References: <157112699975.7360.1062614888388489788.stgit@buzz>
 <20191015082048.GU317@dhcp22.suse.cz>
 <3b73e301-ea4a-5edb-9360-2ae9b4ad9f69@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b73e301-ea4a-5edb-9360-2ae9b4ad9f69@yandex-team.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 15-10-19 11:44:22, Konstantin Khlebnikov wrote:
> On 15/10/2019 11.20, Michal Hocko wrote:
> > On Tue 15-10-19 11:09:59, Konstantin Khlebnikov wrote:
> > > Mapped, dirty and writeback pages are also counted in per-lruvec stats.
> > > These counters needs update when page is moved between cgroups.
> > 
> > Please describe the user visible effect.
> 
> Surprisingly I don't see any users at this moment.
> So, there is no effect in mainline kernel.

Those counters are exported right? Or do we exclude them for v1?

> > > Fixes: 00f3ca2c2d66 ("mm: memcontrol: per-lruvec stats infrastructure")
> > > Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> > 
> > We want Cc: stable I suspect because broken stats might be really
> > misleading.
> > 
> > The patch looks ok to me otherwise
> > Acked-by: Michal Hocko <mhocko@suse.com>
> > 
> > > ---
> > >   mm/memcontrol.c |   18 ++++++++++++------
> > >   1 file changed, 12 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index bdac56009a38..363106578876 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -5420,6 +5420,8 @@ static int mem_cgroup_move_account(struct page *page,
> > >   				   struct mem_cgroup *from,
> > >   				   struct mem_cgroup *to)
> > >   {
> > > +	struct lruvec *from_vec, *to_vec;
> > > +	struct pglist_data *pgdat;
> > >   	unsigned long flags;
> > >   	unsigned int nr_pages = compound ? hpage_nr_pages(page) : 1;
> > >   	int ret;
> > > @@ -5443,11 +5445,15 @@ static int mem_cgroup_move_account(struct page *page,
> > >   	anon = PageAnon(page);
> > > +	pgdat = page_pgdat(page);
> > > +	from_vec = mem_cgroup_lruvec(pgdat, from);
> > > +	to_vec = mem_cgroup_lruvec(pgdat, to);
> > > +
> > >   	spin_lock_irqsave(&from->move_lock, flags);
> > >   	if (!anon && page_mapped(page)) {
> > > -		__mod_memcg_state(from, NR_FILE_MAPPED, -nr_pages);
> > > -		__mod_memcg_state(to, NR_FILE_MAPPED, nr_pages);
> > > +		__mod_lruvec_state(from_vec, NR_FILE_MAPPED, -nr_pages);
> > > +		__mod_lruvec_state(to_vec, NR_FILE_MAPPED, nr_pages);
> > >   	}
> > >   	/*
> > > @@ -5459,14 +5465,14 @@ static int mem_cgroup_move_account(struct page *page,
> > >   		struct address_space *mapping = page_mapping(page);
> > >   		if (mapping_cap_account_dirty(mapping)) {
> > > -			__mod_memcg_state(from, NR_FILE_DIRTY, -nr_pages);
> > > -			__mod_memcg_state(to, NR_FILE_DIRTY, nr_pages);
> > > +			__mod_lruvec_state(from_vec, NR_FILE_DIRTY, -nr_pages);
> > > +			__mod_lruvec_state(to_vec, NR_FILE_DIRTY, nr_pages);
> > >   		}
> > >   	}
> > >   	if (PageWriteback(page)) {
> > > -		__mod_memcg_state(from, NR_WRITEBACK, -nr_pages);
> > > -		__mod_memcg_state(to, NR_WRITEBACK, nr_pages);
> > > +		__mod_lruvec_state(from_vec, NR_WRITEBACK, -nr_pages);
> > > +		__mod_lruvec_state(to_vec, NR_WRITEBACK, nr_pages);
> > >   	}
> > >   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > 

-- 
Michal Hocko
SUSE Labs
