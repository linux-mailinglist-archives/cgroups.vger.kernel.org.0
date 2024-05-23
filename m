Return-Path: <cgroups+bounces-2986-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CACB18CD4C2
	for <lists+cgroups@lfdr.de>; Thu, 23 May 2024 15:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08C171C219C9
	for <lists+cgroups@lfdr.de>; Thu, 23 May 2024 13:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D7914A09C;
	Thu, 23 May 2024 13:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JtPZNgss"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E3F224FA
	for <cgroups@vger.kernel.org>; Thu, 23 May 2024 13:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716471081; cv=none; b=VYRJnr9oK2SWjNAp4Q30U4ZPegynMkJuInRm1h5twgTFIS2AGjr5QH1PDL9TM7A4oVEAoaUUCuc0xVX+fFBj4v560AKMGU0nqFW5bRhodBjQ6PkcXJOTNZPwzosUY8V1hKYE5cRsqeeJF4vNhjcT/YahE+xX/zAJVOwpp3kZ5gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716471081; c=relaxed/simple;
	bh=ByiGAygmr6/6XK0RGkKKbR/BGPXdSqzfzE/xj8EAYlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PRDA/hfuwFeaPqXUHf4LLVLGbtvF0txSNvoKBTu873QZbu3I1qmUnvFTwR8K9CRh9MU7kXRqe7nVlPXggFzJSwwKwTu8uCdKU+p1dbkAPaiu9pyhhuy6sQJwDNxDGUKrtwRdaXyauD8q46hkBlHQS73oprMDZW36FvAsAa/o0pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JtPZNgss; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RavCK3aELYMPsJIZvxV9QXWeZcnPAfhzKUr04jHfAQ8=; b=JtPZNgssDNmkdTSOyPP9pwBoMa
	Q+QeoCORv14VePhnAMG52TyTqEn+QqBA9cfz31ClmKV2U+SYsGZXFiSfltIVh16FEA92dryGsn9CZ
	GEDAnLdCD2rdXJh+DFt/aXjM0LOKFUv4Tg2/bgKZ5AyYVzoN1CE0VWKz6FFLQkpdImUmcoTYf7fdy
	89sr0xlYkgDdnVtorIytUG0FskvZ4kz1g0NSX+PzNiY9yZ+D3TglS+rFzLwwtg7EMaaJyKvktFOou
	+7n0/K8ase7yEvC0STG7Qgi6HeMdcPDg7RgqYYBHWcHEe0fPc9/ude0xKvxt7N9y/wHEtoIN1pWqR
	L94fW0SA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA8XB-00000001mtV-2yTD;
	Thu, 23 May 2024 13:31:05 +0000
Date: Thu, 23 May 2024 14:31:05 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>
Subject: Re: [PATCH] mm: memcontrol: remove page_memcg()
Message-ID: <Zk9FGQUdcs8tqCbi@casper.infradead.org>
References: <20240521131556.142176-1-wangkefeng.wang@huawei.com>
 <ZkyzRVe31WLaepSt@casper.infradead.org>
 <tcdr5cm3djarfeiwar6q7qvxjdgkb7r5pcb7j6pzqejnbslsgz@2pnnlbwmfzdu>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tcdr5cm3djarfeiwar6q7qvxjdgkb7r5pcb7j6pzqejnbslsgz@2pnnlbwmfzdu>

On Tue, May 21, 2024 at 12:29:39PM -0700, Shakeel Butt wrote:
> On Tue, May 21, 2024 at 03:44:21PM +0100, Matthew Wilcox wrote:
> > The memcg should not be attached to the individual pages that make up a
> > vmalloc allocation.  Rather, it should be managed by the vmalloc
> > allocation itself.  I don't have the knowledge to poke around inside
> > vmalloc right now, but maybe somebody else could take that on.
> 
> Are you concerned about accessing just memcg or any field of the
> sub-page? There are drivers accessing fields of pages allocated through
> vmalloc. Some details at 3b8000ae185c ("mm/vmalloc: huge vmalloc backing
> pages should be split rather than compound").

Thanks for the pointer, and fb_deferred_io_fault() is already on my
hitlist for abusing struct page.

My primary concern is that we should track the entire allocation as a
single object rather than tracking each page individually.  That means
assigning the vmalloc allocation to a memcg rather than assigning each
page to a memcg.  It's a lot less overhead to increment the counter once
per allocation rather than once per page in the allocation!

But secondarily, yes, pages allocated by vmalloc probably don't need
any per-page state, other than tracking the vmalloc allocation they're
assigned to.  We'll see how that theory turns out.

