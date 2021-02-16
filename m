Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C970731CEE2
	for <lists+cgroups@lfdr.de>; Tue, 16 Feb 2021 18:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhBPRU2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 16 Feb 2021 12:20:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:56502 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229628AbhBPRU0 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 16 Feb 2021 12:20:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613495980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rOgv2eEZRaweG7NJSebRdSvYOOr4gqJRXTJSspBSCOc=;
        b=h74MeufS56pS+vSQUpiTiDJslgiawZx4tJtn7aauwv7pBJhcNTfCnkvkZcET1ccH9wgS0S
        uSIXIOcmQcAWyo9lIedoNUMHCxP1lJvUJ71ea01Qe4mg3wVOss7YoIzXmifMbWipNTDnwz
        bmUSS78TXUvirG7wUzA62/J22oR4h+8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 12DE6B7A4;
        Tue, 16 Feb 2021 17:19:40 +0000 (UTC)
Date:   Tue, 16 Feb 2021 18:19:39 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Muchun Song <songmuchun@bytedance.com>, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] mm: memcontrol: fix swap uncharge on cgroup v2
Message-ID: <YCv+q749iP4J/pWC@dhcp22.suse.cz>
References: <20210212170159.32153-1-songmuchun@bytedance.com>
 <20210212170159.32153-4-songmuchun@bytedance.com>
 <YCv51LgGIWxVjLHT@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCv51LgGIWxVjLHT@cmpxchg.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 16-02-21 11:59:00, Johannes Weiner wrote:
> Hello Muchun,
> 
> On Sat, Feb 13, 2021 at 01:01:59AM +0800, Muchun Song wrote:
> > The swap charges the actual number of swap entries on cgroup v2.
> > If a swap cache page is charged successful, and then we uncharge
> > the swap counter. It is wrong on cgroup v2. Because the swap
> > entry is not freed.
> 
> The patch makes sense to me. But this code is a bit tricky, we should
> add more documentation to how it works and what the problem is.
> 
> How about this for the changelog?
> 
> ---
> mm: memcontrol: fix swap undercounting for shared pages in cgroup2
> 
> When shared pages are swapped in partially, we can have some page
> tables referencing the in-memory page and some referencing the swap
> slot. Cgroup1 and cgroup2 handle these overlapping lifetimes slightly
> differently due to the nature of how they account memory and swap:
> 
> Cgroup1 has a unified memory+swap counter that tracks a data page
> regardless whether it's in-core or swapped out. On swapin, we transfer
> the charge from the swap entry to the newly allocated swapcache page,
> even though the swap entry might stick around for a while. That's why
> we have a mem_cgroup_uncharge_swap() call inside mem_cgroup_charge().
> 
> Cgroup2 tracks memory and swap as separate, independent resources and
> thus has split memory and swap counters. On swapin, we charge the
> newly allocated swapcache page as memory, while the swap slot in turn
> must remain charged to the swap counter as long as its allocated too.
> 
> The cgroup2 logic was broken by commit 2d1c498072de ("mm: memcontrol:
> make swap tracking an integral part of memory control"), because it
> accidentally removed the do_memsw_account() check in the branch inside
> mem_cgroup_uncharge() that was supposed to tell the difference between
> the charge transfer in cgroup1 and the separate counters in cgroup2.
> 
> As a result, cgroup2 currently undercounts consumed swap when shared
> pages are partially swapped back in. This in turn allows a cgroup to
> consume more swap than its configured limit intends.
> 
> Add the do_memsw_account() check back to fix this problem.

Yes this clarfies both the issue and the subtlety of the accounting.
Thanks a lot Johannes! This is a great example of how changelogs should
really look.

> ---
> 
> > Fixes: 2d1c498072de ("mm: memcontrol: make swap tracking an integral part of memory control")
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> 
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> > ---
> >  mm/memcontrol.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index c737c8f05992..be6bc5044150 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -6753,7 +6753,7 @@ int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask)
> >  	memcg_check_events(memcg, page);
> >  	local_irq_enable();
> >  
> > -	if (PageSwapCache(page)) {
> > +	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && PageSwapCache(page)) {
> 
> It's more descriptive to use do_memsw_account() here, IMO.
> 
> We should also add a comment. How about this above the branch?
> 
> 	/*
> 	 * Cgroup1's unified memory+swap counter has been charged with the
> 	 * new swapcache page, finish the transfer by uncharging the swap
> 	 * slot. The swap slot would also get uncharged when it dies, but
> 	 * for shared pages it can stick around indefinitely and we'd count
> 	 * the page twice the entire time.
> 	 *
> 	 * Cgroup2 has separate resource counters for memory and swap,
> 	 * so this is a non-issue here. Memory and swap charge lifetimes
> 	 * correspond 1:1 to page and swap slot lifetimes: we charge the
> 	 * page to memory here, and uncharge swap when the slot is freed.
> 	 */

Yes very helpful.

With the changelog update and the comment
Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

-- 
Michal Hocko
SUSE Labs
