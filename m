Return-Path: <cgroups+bounces-7338-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3117BA7A938
	for <lists+cgroups@lfdr.de>; Thu,  3 Apr 2025 20:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CE94177214
	for <lists+cgroups@lfdr.de>; Thu,  3 Apr 2025 18:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095DF252909;
	Thu,  3 Apr 2025 18:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cY/nynQM"
X-Original-To: cgroups@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D222500C9
	for <cgroups@vger.kernel.org>; Thu,  3 Apr 2025 18:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743704428; cv=none; b=U3bYXdPOq4i4ACTa9bv94AFqLfvDV+ebxKojCjm7tqd9CTeYO50QW5m6nVoEBetIULLyZ5bCGP4ouBbwWkHZvMSxTqDLSCzRAgzHDkC/u+yqXYlGfLFZ/LvIuq8/Wx+UF1a906g091nL8vjONJg8ea0B+QP+44nwMAgC6IRVOFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743704428; c=relaxed/simple;
	bh=rETUugx0qk63YmrZQnigcsObBgNs+xhlPW3YUhVFRBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9oX47sPq1q6AYV8duM7U7+noqVI7caQnnvWkQ0+IwOGC64oP3kWGDy1TlEy3fjUKDiohcQR6bHkqiSKn9EJUwLF7fXkrVlnH5rozCC7xoUMZvaJrnOpiXDQf//W0KydpWCbLw2fhzPMNeLLYYtkTPPsAniq0awmfWha85FXFes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cY/nynQM; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 3 Apr 2025 11:20:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743704425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BCvOFpDPF7Loyqy9O0Y/KS9yPUnm7FsGL8ysTofncHs=;
	b=cY/nynQMqor5N57jXvu1pQZt45yFHQ1iwKrt0t/Amvj5kdNetOEtR0bZv513ewqW88henj
	3e+cwiqrA7OnI6UBE28BPgdS+6Lm77syi4QqFdysTqwm/K6jUWXh30iV2Wm/TpSm9i1Sks
	JKTv1S0k6gR2L7vaYr0ESq6zsU5bSy0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: vmalloc: simplify MEMCG_VMALLOC updates
Message-ID: <gl5u2fkxaqe4todqwzsfktvnlghb7vnan2n3bpxum7ibwaznpd@xomzodg47qwe>
References: <20250403053326.26860-1-shakeel.butt@linux.dev>
 <Z-5uQlaPjZtB61C4@pc636>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-5uQlaPjZtB61C4@pc636>
X-Migadu-Flow: FLOW_OUT

On Thu, Apr 03, 2025 at 01:17:22PM +0200, Uladzislau Rezki wrote:
> On Wed, Apr 02, 2025 at 10:33:26PM -0700, Shakeel Butt wrote:
> > The vmalloc region can either be charged to a single memcg or none. At
> > the moment kernel traverses all the pages backing the vmalloc region to
> > update the MEMCG_VMALLOC stat. However there is no need to look at all
> > the pages as all those pages will be charged to a single memcg or none.
> > Simplify the MEMCG_VMALLOC update by just looking at the first page of
> > the vmalloc region.
> > 
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > ---
> >  mm/vmalloc.c | 13 +++++--------
> >  1 file changed, 5 insertions(+), 8 deletions(-)
> > 
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 3ed720a787ec..cdae76994488 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -3370,12 +3370,12 @@ void vfree(const void *addr)
> >  
> >  	if (unlikely(vm->flags & VM_FLUSH_RESET_PERMS))
> >  		vm_reset_perms(vm);
> > +	if (vm->nr_pages && !(vm->flags & VM_MAP_PUT_PAGES))
> > +		mod_memcg_page_state(vm->pages[0], MEMCG_VMALLOC, -vm->nr_pages);
> >
> Could you please add a comment stating that the first page should be
> modified?
> 

Sorry, what do you mean by first page should be modified?
mod_memcg_page_state() will not modify the page but extract memcg from
it and modify its vmalloc stat.


> Yes, the comment is clear, but git blame/log takes time.
> 
> Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Thanks.

> 
> --
> Uladzislau Rezki

