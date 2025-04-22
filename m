Return-Path: <cgroups+bounces-7724-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB3DA9704B
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 17:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7E92189DCA6
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 15:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5DD28F532;
	Tue, 22 Apr 2025 15:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kuUyWOsx"
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A421B28CF50
	for <cgroups@vger.kernel.org>; Tue, 22 Apr 2025 15:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745335071; cv=none; b=uCF2Fkiixy6PTXgyFvTODw4EAPQcu1JE4AbHKJ3yQ5YB9eSzxqfkD2byu4yZrU6wZR2SCMINDdk4bVvkNM+C9SAlWW4yBlgaM4UaxoIEXkNYzSpidlm+PIfR5VRtSZU752ODQwari5wX3monwLr1fUORAA8lLh136FCfzQJlSpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745335071; c=relaxed/simple;
	bh=tZCRT3KRKbtaH5Y6xHCCiOdmQpzRItyz9G99gZqg9bA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cxBWliKI2SnY/2yBuMr5S43JJl+NsY7xXy0lNsBYbAL9JI70H0BphhOijG4eT1TG2xNdiV57zRD/u70RTRSAXpjdgdcaH5Cf2iQPwQidSeOfkMVeYhvVhx4gBdiXqODPcMWB+Xg2lKz7h9wyjUnAaTVbhPFJ0IlTEQ4Wz2nzARU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kuUyWOsx; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 22 Apr 2025 08:17:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745335066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LchZarW2A6kUutnNIDJO9ma1ViD3dQsg63NWCnCpkd8=;
	b=kuUyWOsxd9hRF8MHPY8MLslDN6+7hW2eUdsBAjNgySpPbSVsXoIbvMv3CGm7HxPtOjCB1v
	l48IzD8TD4q98Ksu7wnkVSgHQ9x2I+hFRwSQfc6ywONjTIGNaaHScZlAlsqrYsu1F4UuL2
	jyb3bWBH0kLn+H5xF3nkBH4ZmTOO/u4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: vmalloc: simplify MEMCG_VMALLOC updates
Message-ID: <aAezFEm9FY3RZISI@Asmaa.>
References: <20250403053326.26860-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403053326.26860-1-shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Wed, Apr 02, 2025 at 10:33:26PM -0700, Shakeel Butt wrote:
> The vmalloc region can either be charged to a single memcg or none. At
> the moment kernel traverses all the pages backing the vmalloc region to
> update the MEMCG_VMALLOC stat. However there is no need to look at all
> the pages as all those pages will be charged to a single memcg or none.
> Simplify the MEMCG_VMALLOC update by just looking at the first page of
> the vmalloc region.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
>  mm/vmalloc.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 3ed720a787ec..cdae76994488 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3370,12 +3370,12 @@ void vfree(const void *addr)
>  
>  	if (unlikely(vm->flags & VM_FLUSH_RESET_PERMS))
>  		vm_reset_perms(vm);
> +	if (vm->nr_pages && !(vm->flags & VM_MAP_PUT_PAGES))
> +		mod_memcg_page_state(vm->pages[0], MEMCG_VMALLOC, -vm->nr_pages);
>  	for (i = 0; i < vm->nr_pages; i++) {
>  		struct page *page = vm->pages[i];
>  
>  		BUG_ON(!page);
> -		if (!(vm->flags & VM_MAP_PUT_PAGES))
> -			mod_memcg_page_state(page, MEMCG_VMALLOC, -1);

We can add a debug check here (and/or in the vmalloc path) to check that
all pages are indeed charged to the same memcg.

Regardless, this change makes sense:
Reviewed-by: Yosry Ahmed <yosry.ahmed@linux.dev>


>  		/*
>  		 * High-order allocs for huge vmallocs are split, so
>  		 * can be freed as an array of order-0 allocations
> @@ -3671,12 +3671,9 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  		node, page_order, nr_small_pages, area->pages);
>  
>  	atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
> -	if (gfp_mask & __GFP_ACCOUNT) {
> -		int i;
> -
> -		for (i = 0; i < area->nr_pages; i++)
> -			mod_memcg_page_state(area->pages[i], MEMCG_VMALLOC, 1);
> -	}
> +	if (gfp_mask & __GFP_ACCOUNT && area->nr_pages)
> +		mod_memcg_page_state(area->pages[0], MEMCG_VMALLOC,
> +				     area->nr_pages);
>  
>  	/*
>  	 * If not enough pages were obtained to accomplish an
> -- 
> 2.47.1
> 
> 

