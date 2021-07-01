Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B193B8E11
	for <lists+cgroups@lfdr.de>; Thu,  1 Jul 2021 09:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbhGAHPM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Jul 2021 03:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234489AbhGAHPM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 1 Jul 2021 03:15:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533DDC061756
        for <cgroups@vger.kernel.org>; Thu,  1 Jul 2021 00:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KLerUe42f8SIbn+h7BpkYDx+8xVVkF65bnO7cZo5M0w=; b=qAdccjqTF8wSj5lwxkt1ZAi/7q
        a24GeI4IPJwQtIKf8M1z/pzIVJpp5UcMjPqePzGt/XNPjgXGx+5e5kjGkm7pU+3LlcAnwppR+BGyh
        C+/65nAJjca25YyaV2ix/DOO36KVTq06O2Nvl4LXZjtHOZoY4f+iEv7B5wQDE/Olnnm/FCG+VUvNf
        ObO2cEgI3Fy0jTL3wOuwVardK9vNyA/2obUNvXt/zJTAe9Y8kqrElV4+PTD2+M3T7BTba6OPV6LPd
        EzfCFelYYK7PNKpxyQY8DSM6hsmL9Q30hS8HL7QYITxGnAvwoPJLqdxUYgr7Y5BUIjBwTnc/8PXPN
        j1kEhMpA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lyqs3-006HY9-Ct; Thu, 01 Jul 2021 07:12:26 +0000
Date:   Thu, 1 Jul 2021 08:12:23 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH v3 06/18] mm/memcg: Add folio_memcg() and related
 functions
Message-ID: <YN1q10YCM74PmQp3@infradead.org>
References: <20210630040034.1155892-1-willy@infradead.org>
 <20210630040034.1155892-7-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630040034.1155892-7-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jun 30, 2021 at 05:00:22AM +0100, Matthew Wilcox (Oracle) wrote:
> memcg information is only stored in the head page, so the memcg
> subsystem needs to assure that all accesses are to the head page.
> The first step is converting page_memcg() to folio_memcg().
> 
> Retain page_memcg() as a wrapper around folio_memcg() and PageMemcgKmem()
> as a wrapper around folio_memcg_kmem() but convert __page_memcg() to
> __folio_memcg() and __page_objcg() to __folio_objcg().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/memcontrol.h | 105 +++++++++++++++++++++----------------
>  mm/memcontrol.c            |  21 ++++----
>  2 files changed, 73 insertions(+), 53 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 6d66037be646..92689fb2dab4 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -372,6 +372,7 @@ enum page_memcg_data_flags {
>  #define MEMCG_DATA_FLAGS_MASK (__NR_MEMCG_DATA_FLAGS - 1)
>  
>  static inline bool PageMemcgKmem(struct page *page);
> +static inline bool folio_memcg_kmem(struct folio *folio);
>  
>  /*
>   * After the initialization objcg->memcg is always pointing at
> @@ -386,73 +387,78 @@ static inline struct mem_cgroup *obj_cgroup_memcg(struct obj_cgroup *objcg)
>  }
>  
>  /*
> - * __page_memcg - get the memory cgroup associated with a non-kmem page
> - * @page: a pointer to the page struct
> + * __folio_memcg - Get the memory cgroup associated with a non-kmem folio
> + * @folio: Pointer to the folio.
>   *
> - * Returns a pointer to the memory cgroup associated with the page,
> - * or NULL. This function assumes that the page is known to have a
> + * Returns a pointer to the memory cgroup associated with the folio,
> + * or NULL. This function assumes that the folio is known to have a
>   * proper memory cgroup pointer. It's not safe to call this function
> - * against some type of pages, e.g. slab pages or ex-slab pages or
> - * kmem pages.
> + * against some type of folios, e.g. slab folios or ex-slab folios or
> + * kmem folios.
>   */
> -static inline struct mem_cgroup *__page_memcg(struct page *page)
> +static inline struct mem_cgroup *__folio_memcg(struct folio *folio)
>  {
> -	unsigned long memcg_data = page->memcg_data;
> +	unsigned long memcg_data = folio->memcg_data;
>  
> -	VM_BUG_ON_PAGE(PageSlab(page), page);
> -	VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_OBJCGS, page);
> -	VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_KMEM, page);
> +	VM_BUG_ON_FOLIO(folio_slab(folio), folio);
> +	VM_BUG_ON_FOLIO(memcg_data & MEMCG_DATA_OBJCGS, folio);
> +	VM_BUG_ON_FOLIO(memcg_data & MEMCG_DATA_KMEM, folio);
>  
>  	return (struct mem_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
>  }
>  
>  /*
> - * __page_objcg - get the object cgroup associated with a kmem page
> - * @page: a pointer to the page struct
> + * __folio_objcg - get the object cgroup associated with a kmem folio.
> + * @folio: Pointer to the folio.
>   *
> - * Returns a pointer to the object cgroup associated with the page,
> - * or NULL. This function assumes that the page is known to have a
> + * Returns a pointer to the object cgroup associated with the folio,
> + * or NULL. This function assumes that the folio is known to have a
>   * proper object cgroup pointer. It's not safe to call this function
> - * against some type of pages, e.g. slab pages or ex-slab pages or
> - * LRU pages.
> + * against some type of folios, e.g. slab folios or ex-slab folios or
> + * LRU folios.
>   */
> -static inline struct obj_cgroup *__page_objcg(struct page *page)
> +static inline struct obj_cgroup *__folio_objcg(struct folio *folio)
>  {
> -	unsigned long memcg_data = page->memcg_data;
> +	unsigned long memcg_data = folio->memcg_data;
>  
> -	VM_BUG_ON_PAGE(PageSlab(page), page);
> -	VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_OBJCGS, page);
> -	VM_BUG_ON_PAGE(!(memcg_data & MEMCG_DATA_KMEM), page);
> +	VM_BUG_ON_FOLIO(folio_slab(folio), folio);
> +	VM_BUG_ON_FOLIO(memcg_data & MEMCG_DATA_OBJCGS, folio);
> +	VM_BUG_ON_FOLIO(!(memcg_data & MEMCG_DATA_KMEM), folio);
>  
>  	return (struct obj_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
>  }
>  
>  /*
> - * page_memcg - get the memory cgroup associated with a page
> - * @page: a pointer to the page struct
> + * folio_memcg - Get the memory cgroup associated with a folio.
> + * @folio: Pointer to the folio.
>   *
> - * Returns a pointer to the memory cgroup associated with the page,
> - * or NULL. This function assumes that the page is known to have a
> + * Returns a pointer to the memory cgroup associated with the folio,
> + * or NULL. This function assumes that the folio is known to have a
>   * proper memory cgroup pointer. It's not safe to call this function
> - * against some type of pages, e.g. slab pages or ex-slab pages.
> + * against some type of folios, e.g. slab folios or ex-slab folios.
>   *
> - * For a non-kmem page any of the following ensures page and memcg binding
> + * For a non-kmem folio any of the following ensures folio and memcg binding
>   * stability:
>   *
> - * - the page lock
> + * - the folio lock
>   * - LRU isolation
>   * - lock_page_memcg()
>   * - exclusive reference
>   *
> - * For a kmem page a caller should hold an rcu read lock to protect memcg
> - * associated with a kmem page from being released.
> + * For a kmem folio a caller should hold an rcu read lock to protect memcg
> + * associated with a kmem folio from being released.
>   */
> -static inline struct mem_cgroup *page_memcg(struct page *page)
> +static inline struct mem_cgroup *folio_memcg(struct folio *folio)
>  {
> -	if (PageMemcgKmem(page))
> -		return obj_cgroup_memcg(__page_objcg(page));
> +	if (folio_memcg_kmem(folio))
> +		return obj_cgroup_memcg(__folio_objcg(folio));
>  	else
> +		return __folio_memcg(folio);

Nit: it might be worth to drop the pointless else while you're at it.
therwise looks good:


Reviewed-by: Christoph Hellwig <hch@lst.de>

