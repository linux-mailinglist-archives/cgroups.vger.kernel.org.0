Return-Path: <cgroups+bounces-5824-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 676CA9ED725
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 21:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 482C81674D1
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 20:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC671DE3B3;
	Wed, 11 Dec 2024 20:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="htCtK7J5"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3E31DD866;
	Wed, 11 Dec 2024 20:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733948444; cv=none; b=muI/BhOIWOANupfIcWH9UA8QD5ztN6N+uBta5N3u7QRBGTnuqF4UeY+7+AOeMWc0cMO5rBdtwQHH4tKWYApiysCAYc8cY5lV6BbR49WpcTJ0nmTt8gQ6rhU7TTYuREYEQUt8pMnTM7ymYUcx+Xz6nou8RuoyRGZUfhQMMqpOaLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733948444; c=relaxed/simple;
	bh=lhQ/otwxrpWe4K/yMoHNTqlA8T1qx+cBbQBsRJKCSxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/ZXtV+NRFWvlwnEEBl4vsuji8yRtUBhk7CyVNThdyvgKjv+LEtRIMgQw1JOMl8NBmuhq+MBTfPVk31zaw4+SZxspXwhrSEeANbJKn0jJLuk/E+EgfA/+G3LRGanQPC2IcZ9zLpwxcTJCuZW+meLDldAzuf0u/ImBPfTxmh89Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=htCtK7J5; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=t1WFEmjVsxcDNS6E0UsJx7pO3Iuf1D+O0LkgcXU/hok=; b=htCtK7J52uvo/vXzjM3f68XAAR
	ggYQAta8fi9ApWQIqGQHqdxViphK3BuJ0BmUZf3/oLLg355tTecNomnDGwFbZGL61PC4YME5QYl35
	UXj3YqAMd3Ok3jIebDZT7b0V+w5yqSEQRFJ/eqXc6sMhhXZeXpZkhwC9ye6GhHbuLBy/9Hma5QoKA
	eDYqsQlyxPXaBYdujLstccmeO4QBhQnSKClgqooGEhEwnPKU9RFDpMfmJfX3ZizL2td6/I882uMAk
	NuZMShxOUo+DJT2LAejbmjBhWp5xTlTXDf0gNG0yoFvdrzXo5wDLZ4l5GZ9Bd7Cei6taEEZIfrHSv
	iEG5RGzg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tLTCH-00000000g8e-0szL;
	Wed, 11 Dec 2024 20:20:37 +0000
Date: Wed, 11 Dec 2024 20:20:36 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] vmalloc: Account memcg per vmalloc
Message-ID: <Z1n0FFZ_oMYKcUiP@casper.infradead.org>
References: <20241211043252.3295947-1-willy@infradead.org>
 <20241211043252.3295947-2-willy@infradead.org>
 <20241211160956.GB3136251@cmpxchg.org>
 <Z1nC3138biX0J1DJ@casper.infradead.org>
 <keho5no2wg666yjtkb5lflxwezgbzavue5ytydqm7pm7w62ctt@q6zg7t56gf4b>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <keho5no2wg666yjtkb5lflxwezgbzavue5ytydqm7pm7w62ctt@q6zg7t56gf4b>

On Wed, Dec 11, 2024 at 11:32:13AM -0800, Shakeel Butt wrote:
> On Wed, Dec 11, 2024 at 04:50:39PM +0000, Matthew Wilcox wrote:
> > Perhaps you'd be more persuaded by:
> > 
> > (a) If we clear __GFP_ACCOUNT then alloc_pages_bulk() will work, and
> > that's a pretty significant performance win over calling alloc_pages()
> > in a loop.
> > 
> > (b) Once we get to memdescs, calling alloc_pages() with __GFP_ACCOUNT
> > set is going to require allocating a memdesc to store the obj_cgroup
> > in, so in the future we'll save an allocation.
> > 
> > Your proposed alternative will work and is way less churn.  But it's
> > not preparing us for memdescs ;-)
> 
> We can make alloc_pages_bulk() work with __GFP_ACCOUNT but your second
> argument is more compelling.
> 
> I am trying to think of what will we miss if we remove this per-page
> memcg metadata. One thing I can think of is debugging a live system
> or kdump where I need to track where a given page came from. I think

Umm, I don't think you know which vmalloc allocation a page came from
today?  I've sent patches to add that information before, but they were
rejected.  In fact, I don't think we know even _that_ a page belongs to
vmalloc today, do we?  Yes, we know that the page is accounted, and
which memcg it belongs to ... but nothing more.

I actually want to improve this, without adding additional overhead.
What I'm working on right now (before I got waylaid by this bug) is:

+struct choir {
+       struct kref refcount;
+       unsigned int nr;
+       struct page *pages[] __counted_by(nr);
+};

and rewriting vmalloc to be based on choirs instead of its own pages.
One thing I've come to realise today is that the obj_cgroup pointer
needs to be in the choir and not in the vm_struct so that we uncharge the
allocation when the choir refcount drops to 0, not when the allocation
is unmapped.

A regular choir allocation will (today) mark the pages in it as being
allocated to a choir (and thus not having their own refcount / mapcount),
but I'll give vmalloc a way to mark the pages as specifically being
from vmalloc.

There's a lot of moving parts to this ... it's proving quite tricky!

> I think we can go with Johannes' solution for stable and discuss the
> future direction more separately.

OK, I'll send a patch to do that.

