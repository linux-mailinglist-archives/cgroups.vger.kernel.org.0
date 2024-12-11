Return-Path: <cgroups+bounces-5834-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 291759ED809
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 22:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACEB9169268
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 21:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8826723A19B;
	Wed, 11 Dec 2024 20:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Tcu5nZPO"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC7E2288C1
	for <cgroups@vger.kernel.org>; Wed, 11 Dec 2024 20:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733950728; cv=none; b=h5coSb5iE4ZE5LoSJByw+UgDszyYKBB3gp1OP/DZZ/ZkyjGlRJRxrTHKHQ46fWaRnF8NsQ9Voj/vkRLUq7Jg7K+0CKQunPs3ZhKpYUty4EnrrMD/7hVEdhl242VgmD03ZqHj79gqarNbpxAD2DCvD1zfJp+UVCHUwxwyTCvHqGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733950728; c=relaxed/simple;
	bh=rlqXCMPzBxPZUt6pbeibdVcjpDX9gvPTld1bIv9KFqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j9M+ynDxdSueyrKV+ORFB0zJUHo9QIb82HS5IU43xW45envDzCWhLEvbwZE8R/NC84D5JxwwWW6wQS4/AOYbVeOJ4jNSVopiLs5Ogt2qIOjPzZwCJt2MBQIWN3KgOjOdNvO/jAFtErz/RBmbMbIoRGeHyV+3YvQWZ8eiSs8oLe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Tcu5nZPO; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 11 Dec 2024 12:58:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733950723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X3GGTf6dgkL1tJW6zmOq7QwK5jX2MweOMytieQX+f8g=;
	b=Tcu5nZPO5AXCk9DyAjdioFnIUDL9uFmG5p4w/XtlLc4Lr1Se/sVNFLI8/cpsMd7w3rSpBC
	V6+SudxpuIl3zzdB7LB0c18Zy0cudfYdFXcSf6eGBUMgnl8VLzixJ3Yg8QQA30sNk009sz
	/x4qFJT7EKcxf3ew2VchqO2CM3gKkrE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] vmalloc: Account memcg per vmalloc
Message-ID: <3bgedgrbu73dovgcy2keqjud6jafqxenceihtyre2hkego7oyb@opc5u53jef5a>
References: <20241211043252.3295947-1-willy@infradead.org>
 <20241211043252.3295947-2-willy@infradead.org>
 <20241211160956.GB3136251@cmpxchg.org>
 <Z1nC3138biX0J1DJ@casper.infradead.org>
 <keho5no2wg666yjtkb5lflxwezgbzavue5ytydqm7pm7w62ctt@q6zg7t56gf4b>
 <Z1n0FFZ_oMYKcUiP@casper.infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1n0FFZ_oMYKcUiP@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Dec 11, 2024 at 08:20:36PM +0000, Matthew Wilcox wrote:
> On Wed, Dec 11, 2024 at 11:32:13AM -0800, Shakeel Butt wrote:
> > On Wed, Dec 11, 2024 at 04:50:39PM +0000, Matthew Wilcox wrote:
> > > Perhaps you'd be more persuaded by:
> > > 
> > > (a) If we clear __GFP_ACCOUNT then alloc_pages_bulk() will work, and
> > > that's a pretty significant performance win over calling alloc_pages()
> > > in a loop.
> > > 
> > > (b) Once we get to memdescs, calling alloc_pages() with __GFP_ACCOUNT
> > > set is going to require allocating a memdesc to store the obj_cgroup
> > > in, so in the future we'll save an allocation.
> > > 
> > > Your proposed alternative will work and is way less churn.  But it's
> > > not preparing us for memdescs ;-)
> > 
> > We can make alloc_pages_bulk() work with __GFP_ACCOUNT but your second
> > argument is more compelling.
> > 
> > I am trying to think of what will we miss if we remove this per-page
> > memcg metadata. One thing I can think of is debugging a live system
> > or kdump where I need to track where a given page came from. I think
> 
> Umm, I don't think you know which vmalloc allocation a page came from
> today?  I've sent patches to add that information before, but they were
> rejected. 

Do you have a link handy for that discussion?

> In fact, I don't think we know even _that_ a page belongs to
> vmalloc today, do we?  Yes, we know that the page is accounted, and
> which memcg it belongs to ... but nothing more.

Yes you are correct. At the moment it is a guesswork and exhaustive
search into multiple sources.

> 
> I actually want to improve this, without adding additional overhead.
> What I'm working on right now (before I got waylaid by this bug) is:
> 
> +struct choir {
> +       struct kref refcount;
> +       unsigned int nr;
> +       struct page *pages[] __counted_by(nr);
> +};
> 
> and rewriting vmalloc to be based on choirs instead of its own pages.
> One thing I've come to realise today is that the obj_cgroup pointer
> needs to be in the choir and not in the vm_struct so that we uncharge the
> allocation when the choir refcount drops to 0, not when the allocation
> is unmapped.

What/who else can take a reference on a choir?

> 
> A regular choir allocation will (today) mark the pages in it as being
> allocated to a choir (and thus not having their own refcount / mapcount),
> but I'll give vmalloc a way to mark the pages as specifically being
> from vmalloc.

This sounds good. Thanks for the awesome work.

