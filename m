Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDA13B7F06
	for <lists+cgroups@lfdr.de>; Wed, 30 Jun 2021 10:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbhF3IdK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Jun 2021 04:33:10 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48608 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233168AbhF3IdJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Jun 2021 04:33:09 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CD1E51FE48;
        Wed, 30 Jun 2021 08:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625041839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hy9SMJKljau3xo3CbYGL/3mx9qmeFAeMDpxjJFGvvs0=;
        b=BhOWSG/lPlXCd3i93v2gs3c8SbvLrJQESrM9QfMyEr42n8vpzQAsfFgL3IceJ0n2Ny4onN
        4H8gmS8Dlu6caoDnSoIZvCIqyfvKLs8/W4ERpQpo7ktwBTRvOhBAhNFDvC0sg+gnUsVWRO
        cFXSCpqPGEjlt/L4rkV9HM3aRWaTYSM=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9F976A3B9D;
        Wed, 30 Jun 2021 08:30:39 +0000 (UTC)
Date:   Wed, 30 Jun 2021 10:30:38 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH v3 14/18] mm/memcg: Convert mem_cgroup_move_account() to
 use a folio
Message-ID: <YNwrrl6cn48t6w5B@dhcp22.suse.cz>
References: <20210630040034.1155892-1-willy@infradead.org>
 <20210630040034.1155892-15-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630040034.1155892-15-willy@infradead.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 30-06-21 05:00:30, Matthew Wilcox wrote:
> This saves dozens of bytes of text by eliminating a lot of calls to
> compound_head().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/memcontrol.c | 37 +++++++++++++++++++------------------
>  1 file changed, 19 insertions(+), 18 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index b94a6122f27d..95795b65ae3e 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5585,38 +5585,39 @@ static int mem_cgroup_move_account(struct page *page,
>  				   struct mem_cgroup *from,
>  				   struct mem_cgroup *to)
>  {
> +	struct folio *folio = page_folio(page);
>  	struct lruvec *from_vec, *to_vec;
>  	struct pglist_data *pgdat;
> -	unsigned int nr_pages = compound ? thp_nr_pages(page) : 1;
> +	unsigned int nr_pages = compound ? folio_nr_pages(folio) : 1;
>  	int nid, ret;
>  
>  	VM_BUG_ON(from == to);
> -	VM_BUG_ON_PAGE(PageLRU(page), page);
> -	VM_BUG_ON(compound && !PageTransHuge(page));
> +	VM_BUG_ON_FOLIO(folio_lru(folio), folio);
> +	VM_BUG_ON(compound && !folio_multi(folio));
>  
>  	/*
>  	 * Prevent mem_cgroup_migrate() from looking at
>  	 * page's memory cgroup of its source page while we change it.
>  	 */
>  	ret = -EBUSY;
> -	if (!trylock_page(page))
> +	if (!folio_trylock(folio))
>  		goto out;
>  
>  	ret = -EINVAL;
> -	if (page_memcg(page) != from)
> +	if (folio_memcg(folio) != from)
>  		goto out_unlock;
>  
> -	pgdat = page_pgdat(page);
> +	pgdat = folio_pgdat(folio);
>  	from_vec = mem_cgroup_lruvec(from, pgdat);
>  	to_vec = mem_cgroup_lruvec(to, pgdat);
>  
> -	lock_page_memcg(page);
> +	folio_memcg_lock(folio);
>  
> -	if (PageAnon(page)) {
> -		if (page_mapped(page)) {
> +	if (folio_anon(folio)) {
> +		if (folio_mapped(folio)) {
>  			__mod_lruvec_state(from_vec, NR_ANON_MAPPED, -nr_pages);
>  			__mod_lruvec_state(to_vec, NR_ANON_MAPPED, nr_pages);
> -			if (PageTransHuge(page)) {
> +			if (folio_multi(folio)) {

Shouldn't be folio_transhuge? The resulting code is the same but
folio_transhuge is more explicit and matches the THP aspect.

-- 
Michal Hocko
SUSE Labs
