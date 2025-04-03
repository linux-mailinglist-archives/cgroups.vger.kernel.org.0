Return-Path: <cgroups+bounces-7320-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C61A79D51
	for <lists+cgroups@lfdr.de>; Thu,  3 Apr 2025 09:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FAC118823E0
	for <lists+cgroups@lfdr.de>; Thu,  3 Apr 2025 07:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE66241684;
	Thu,  3 Apr 2025 07:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ET4z4w0P"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2079924167B
	for <cgroups@vger.kernel.org>; Thu,  3 Apr 2025 07:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743666344; cv=none; b=Vgk46c0iRchJ9Ugor46yt1hS0PJ3yECfpDc9f7LYZ0EzdmcLsMu58DdNZr2ND5X8vdagEme+4iAzYufz2ZAsXRCrHMSdAjzEXWIKYpyStTpjyi0RZfTHjU3OGnSmpA20besjFd42nBtgEw6Tn87+82LujLCtEhW2tHP3XTJa7YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743666344; c=relaxed/simple;
	bh=hymi5Qn+fhcA2FOy03MhSS9012ysRlJkBS7t2tuXSxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p5BHcFeRk6NUXeoB4BV3TRElRf9SMMfbrCL4f0gi6HKhHPCy24bjmFR+reBU9hBlOE0QtapijLykttCwnENBkMlMxLKJ7ExjBtT2q9t+qVEamJWH4sM04mTobdd4iAO0eBlNp+qIr4KvBzq7Raj2kqBTaZI/Pwz616aBSg5KgUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ET4z4w0P; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3914aba1ce4so503521f8f.2
        for <cgroups@vger.kernel.org>; Thu, 03 Apr 2025 00:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743666340; x=1744271140; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5VAk2UK6ZWJVQD+p+NwG0TWAjSp74Ywmjjho6zwF9q0=;
        b=ET4z4w0PfYhS2Rvf/83e5Bbitm6mewBmMkETa2bIJFS38QcYekeoBswrWemSk4cJeM
         4CsXIRg7ilN19cjXwDwziFGshVfbjRIkfZdLp/4HPfODhaj7I9EsEvkHJaTMdaPXdupM
         0ZLxT/xBwe2MVkqmHJFSwqLFmUL3I1+veFdQxJqwSyFPkhlJZ0f1HdqygQ8bDqKRygQN
         WRPGJFq07742vzswTgNeFSuXFyjhx/DH+w7WPjGh2Sn9+3nOO5cxqPsPe5XgqhGNXAFF
         AmuD8bzThCKeAtRhTStCpgJYqf834TkVzKcfUvfP6MnSNC+o1zKrHr6e6YY6yqhk5cnd
         pOzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743666340; x=1744271140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5VAk2UK6ZWJVQD+p+NwG0TWAjSp74Ywmjjho6zwF9q0=;
        b=Rfd82r8KKm8/U0ys0D0bcED4yNC5bBpSBOdVlnjr6JlfMCgUZSIi5w8RHRbH/otIZ+
         jtOQ+NikV3dQvn1XiSWk43BbrDcIoeASSKAG97glO1HOhig91kEp2BfndDhCPTTbyuH6
         KTs8Cp1GMnNXMBwWYQfvI4hvFGhq0y5vPOlp2bdz61Ub8AJMxT9DDoaYmSQ3eQi7cAZy
         S/WuKWAjZOhBic61GXD8alR0+rrIk0F7AsfFUAtMglCHUnB0tnzRWQY23yKgCIQqEjTy
         O8DL4mRHluHC192EKwouz9qX1Id1kq9KX8aoBMbPjyquGVXQB6F71KVI/B5nLBE8uDId
         uUuA==
X-Forwarded-Encrypted: i=1; AJvYcCUudyTpI3MGc5CMMWJ1qj2lrGXbs46UY7GM7pyQ495+pCH2QesUH9hUfYMRo6ibCrKQke6fRUX0@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd2QpB31rCRe53Zd2nbOstz7104tz3VWA5eGNsTSNQlGYz8BlO
	V+v5+/obcdCdtECftdCQUun2BEDn/DW+fOXY5ISyHXafX73Sk6y7y6b4lb4hz4E=
X-Gm-Gg: ASbGncuJH3fVW42398j9DPA3dN1WqEzswjnEglCQ1ybXncx1EN2h21DzAeXGw2ZiZje
	7ZTQFWywTMuRNwMdDpDvWJFWfB2ymL2IDTDpa0IuEF5Y7iK4BBnjiyTPPcCnoU29kSfJY8kb8W4
	O7a+S+H/s361JMQt7ShWRVKCbvtD8JXweMe3uSsTyW3zBV4xEhG5zkBWqmmt4jIDRfOU0AiDUE2
	3PN2hHEYUI7OWDveFfVNqmoULlmenb/HrklmKpWJUYeyHlOKZ+xExlYVyzYNGE6NV5tJzxAj8rw
	aXXDuOQdQhrX6/aCBAh9Jn+EBnXScJTjjaRGaGM22l8x+KrwZi06YQY=
X-Google-Smtp-Source: AGHT+IFVtsVP5aa9ArTL0eTRZ7z7nYosq4DIG82dzzri9OCIBx4/ZOUO1Sez8TySKMOSMj7BQjQj8A==
X-Received: by 2002:a05:6000:1789:b0:39c:cc7:3c62 with SMTP id ffacd0b85a97d-39c1211b6edmr16117808f8f.51.1743666340279;
        Thu, 03 Apr 2025 00:45:40 -0700 (PDT)
Received: from localhost (109-81-82-69.rct.o2.cz. [109.81.82.69])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-39c301a79aasm1048844f8f.35.2025.04.03.00.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 00:45:39 -0700 (PDT)
Date: Thu, 3 Apr 2025 09:45:38 +0200
From: Michal Hocko <mhocko@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: vmalloc: simplify MEMCG_VMALLOC updates
Message-ID: <Z-48ortj_IhiPxHg@tiehlicka>
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

On Wed 02-04-25 22:33:26, Shakeel Butt wrote:
> The vmalloc region can either be charged to a single memcg or none. At
> the moment kernel traverses all the pages backing the vmalloc region to
> update the MEMCG_VMALLOC stat. However there is no need to look at all
> the pages as all those pages will be charged to a single memcg or none.
> Simplify the MEMCG_VMALLOC update by just looking at the first page of
> the vmalloc region.

I do not rememeber why this was done on page by page but I suspect
originally we could have mixed more memcgs on one vm.

The patch makes sense.

> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

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

-- 
Michal Hocko
SUSE Labs

