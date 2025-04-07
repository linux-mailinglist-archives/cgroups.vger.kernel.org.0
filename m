Return-Path: <cgroups+bounces-7385-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFD5A7DA91
	for <lists+cgroups@lfdr.de>; Mon,  7 Apr 2025 12:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8708C188AEF4
	for <lists+cgroups@lfdr.de>; Mon,  7 Apr 2025 10:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88CC2309AA;
	Mon,  7 Apr 2025 09:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8gFFgT0"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A0B225765;
	Mon,  7 Apr 2025 09:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744019981; cv=none; b=CFFjAYO40yBC+vQoDORTdH3bRdq7Gig6NZAd+sj/aqCbpgKsDrb9uZwcOu5HkeTAxu2XDx/+l0wQEKKR/qJbByPZQ6MecSjzxPydaIa3MHnE8EK7xcMFMIHxiF42wNccQEyiHh082BcUy7TEsXhHZW7MJOrXBHNSuPYUtdlhL/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744019981; c=relaxed/simple;
	bh=yGxHBajZRJJfoIDp2B2DhtkLQigSG2dL4W9OC7W+C2o=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOMIOvvx4TlXlSUahxIROstqYlpNKFLmbA2nyYHg2hsBWB4YO9emISiegU8vx42BgiPOV938x1KCphvXMC8+Ky5U7KExUWAFDe+81nZpA5UpwvZEX5BiGgizm/PwK6W8u5shxk5HeY8ucwLECyNCDJpmOrjLO/HFmV/Vg8avHlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8gFFgT0; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-549b116321aso4865100e87.3;
        Mon, 07 Apr 2025 02:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744019978; x=1744624778; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K0eh0BHVtlD2UrTL4wqCP90wqrYXSEQ6XXq15GauWzY=;
        b=k8gFFgT0OXtclny54luUXEZGK1jjvyD9Hw/a7K5mpqz02SHwUjp+8g8BpA1Q4K+8Y7
         S4I9EPdXDTq/PoMZj+0VoT7U2rI6nrgXz+XG0Wog5Hm5q+xuiaqEPwnvlUqgYZiDHrPB
         fGdDRaH5vjN/FXYsCopGek1nwiuJqLPY4oKqwNqH63uBJFNnojx+ZWRhYbfjSHWM3EBi
         u+WNl8zj8ZASlCFG1h0iLaJiGJDgY3EdHtoUqTex6Rr/sqIICIp57jevetPrhi4UGJ/w
         rvcWa7y8fTgsnRNHSF3ejIWOoN3Gazbe6PzJQDOXIp3qH56MxfR22Dv1bHwIXCBahLSs
         HxSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744019978; x=1744624778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K0eh0BHVtlD2UrTL4wqCP90wqrYXSEQ6XXq15GauWzY=;
        b=XA8pdUET+6gzTDG7WvGqTYa2O4tOsB/njKCxHTDSITp5n8YPDsaraUu9N3kOMChakF
         wvjKlg57yui8nJ4PVHZ3Slj/TYfl1UUMsDyswV86n9V6KF2CV1toetzcDUYozCakh8Nl
         T2Ubb0eujoGUfRk6MvnmRTY5DLqV091/VuB8L/Swf1IIPNx7u6ewNRBGkBNs30kJlnEz
         MToaV688XZtJD96EYuM9eWHkU3OPGqpYHBWt/4CYk0uGrQCgsJloxuh1dMcBiuGdU4hC
         wEt0hIVn3eJ+b+xJ5EjHm0Dr67X3xLbY1xucprpn2O+A4e5cnQ3iN7HlaWXqCgWSM1CP
         cKYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVN/+pOEZ435Mwbomj6pQ3FRjByBnhUXHeO1UoaeC0Zw4kH/cROIyfzZzGTO9bX6SHCi7bjFsX4@vger.kernel.org, AJvYcCWmFry9p6sXokEhavgu89FQNqbB1x+F3bSOA0KA25uaqFUGlrbupWOKhMcOH4l5qwFtST6FWuqakriFfMuo@vger.kernel.org
X-Gm-Message-State: AOJu0YyRFfsZ7N5NHhWEGCVk2xsRR9w3pq/N0dn9Y4eG3gatMI7tIEB7
	d/W3Dg25ZpSgLnjW8GY+jIyUTMSsxSI4guZwChjttgT8x8WbFoo2
X-Gm-Gg: ASbGnctuCIftKddUQWXeKx/a0ArBf1p14l5L9vTK8HTJZa7rA28FNoCraTTdzBEN2GC
	WhapJ93Q8Qcl82Fe5N9V15g6nsOvqtB4UZn+vJYKpa1kgsodhR46ZncUqCzY+Cqs8+7BfwkxiBA
	amFz94EMTnnfpV8H114Lrxex0nxG/6KOedcyfgfmjPMeUgG/Enjb4s0cYo/7OizGFV8ChExgZlg
	SzJRlnwF9Gz0FmK19sO+5TllIRGug6bYxtK3xk8sNgjV6IbFRwJHuIP6kvO/Yr0xJ1qj25Hoaik
	widN5cVtsTxBs0rGvGcICcNq2So3U9NgSawG6qwzEIkd1jRqRLYnggsIWk7l54R7oSydYsfO9GQ
	=
X-Google-Smtp-Source: AGHT+IHwkDMThQQsrmXdRg0APF3tkewDcz6lzlSW9TC46yLQkFuh71o2NqPbu+7kx0PyB9DUuy8YOQ==
X-Received: by 2002:a05:6512:68f:b0:549:8f15:db36 with SMTP id 2adb3069b0e04-54c227ff86dmr3141200e87.51.1744019977324;
        Mon, 07 Apr 2025 02:59:37 -0700 (PDT)
Received: from pc636 (host-90-233-203-182.mobileonline.telia.com. [90.233.203.182])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54c1e635c7dsm1182580e87.144.2025.04.07.02.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 02:59:36 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 7 Apr 2025 11:59:33 +0200
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: vmalloc: simplify MEMCG_VMALLOC updates
Message-ID: <Z_OiBUdeRRWrUtL-@pc636>
References: <20250403053326.26860-1-shakeel.butt@linux.dev>
 <Z-5uQlaPjZtB61C4@pc636>
 <gl5u2fkxaqe4todqwzsfktvnlghb7vnan2n3bpxum7ibwaznpd@xomzodg47qwe>
 <Z--1uXnfqfQthYvh@pc636>
 <bmlkdbqgwboyqrnxyom7n52fjmo76ux77jhqw5odc6c6dfon3h@zdylwtmlywbt>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bmlkdbqgwboyqrnxyom7n52fjmo76ux77jhqw5odc6c6dfon3h@zdylwtmlywbt>

On Fri, Apr 04, 2025 at 10:44:05AM -0700, Shakeel Butt wrote:
> On Fri, Apr 04, 2025 at 12:34:33PM +0200, Uladzislau Rezki wrote:
> > On Thu, Apr 03, 2025 at 11:20:18AM -0700, Shakeel Butt wrote:
> > > On Thu, Apr 03, 2025 at 01:17:22PM +0200, Uladzislau Rezki wrote:
> > > > On Wed, Apr 02, 2025 at 10:33:26PM -0700, Shakeel Butt wrote:
> > > > > The vmalloc region can either be charged to a single memcg or none. At
> > > > > the moment kernel traverses all the pages backing the vmalloc region to
> > > > > update the MEMCG_VMALLOC stat. However there is no need to look at all
> > > > > the pages as all those pages will be charged to a single memcg or none.
> > > > > Simplify the MEMCG_VMALLOC update by just looking at the first page of
> > > > > the vmalloc region.
> > > > > 
> > > > > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > > > > ---
> > > > >  mm/vmalloc.c | 13 +++++--------
> > > > >  1 file changed, 5 insertions(+), 8 deletions(-)
> > > > > 
> > > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > > index 3ed720a787ec..cdae76994488 100644
> > > > > --- a/mm/vmalloc.c
> > > > > +++ b/mm/vmalloc.c
> > > > > @@ -3370,12 +3370,12 @@ void vfree(const void *addr)
> > > > >  
> > > > >  	if (unlikely(vm->flags & VM_FLUSH_RESET_PERMS))
> > > > >  		vm_reset_perms(vm);
> > > > > +	if (vm->nr_pages && !(vm->flags & VM_MAP_PUT_PAGES))
> > > > > +		mod_memcg_page_state(vm->pages[0], MEMCG_VMALLOC, -vm->nr_pages);
> > > > >
> > > > Could you please add a comment stating that the first page should be
> > > > modified?
> > > > 
> > > 
> > > Sorry, what do you mean by first page should be modified?
> > > mod_memcg_page_state() will not modify the page but extract memcg from
> > > it and modify its vmalloc stat.
> > > 
> > I meant what you wrote in the commit message. A mod_memcg_page_state() can
> > be invoked only on a first page within a mapped range, because the rest is
> > anyway is associated with the same mem_cgroup struct.
> > 
> > Just add a comment that we do not need to check all pages. Can you add it?
> 
> Ack. Andrew, please squash the following into the patch.
> 
> 
> From 982971062e6bd04feabf4f6a745469cb9bddef03 Mon Sep 17 00:00:00 2001
> From: Shakeel Butt <shakeel.butt@linux.dev>
> Date: Fri, 4 Apr 2025 10:41:52 -0700
> Subject: [PATCH] memcg : simplify MEMCG_VMALLOC updates - fix
> 
> Add comment
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
>  mm/vmalloc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index cdae76994488..bcc90d4357e4 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3370,6 +3370,7 @@ void vfree(const void *addr)
>  
>  	if (unlikely(vm->flags & VM_FLUSH_RESET_PERMS))
>  		vm_reset_perms(vm);
> +	/* All pages of vm should be charged to same memcg, so use first one. */
>  	if (vm->nr_pages && !(vm->flags & VM_MAP_PUT_PAGES))
>  		mod_memcg_page_state(vm->pages[0], MEMCG_VMALLOC, -vm->nr_pages);
>  	for (i = 0; i < vm->nr_pages; i++) {
> @@ -3671,6 +3672,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  		node, page_order, nr_small_pages, area->pages);
>  
>  	atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
> +	/* All pages of vm should be charged to same memcg, so use first one. */
>  	if (gfp_mask & __GFP_ACCOUNT && area->nr_pages)
>  		mod_memcg_page_state(area->pages[0], MEMCG_VMALLOC,
>  				     area->nr_pages);
> -- 
> 2.47.1
> 
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Thank you!

--
Uladzislau Rezki

