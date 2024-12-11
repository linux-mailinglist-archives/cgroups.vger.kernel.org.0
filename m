Return-Path: <cgroups+bounces-5821-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AE99ED689
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 20:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B30F164E20
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 19:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9FD1C3022;
	Wed, 11 Dec 2024 19:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FgZs5Odf"
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983762594A5
	for <cgroups@vger.kernel.org>; Wed, 11 Dec 2024 19:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733945543; cv=none; b=GKhIJ7MfBdYC0oEJzULOHfthtsBwb4Uis65FwewSfNp+PK9eEesHOJEjllG7A4k8Y+vq8e/wtJpv8dOgRZ89T22i7GifcV4ZIogyz3CN1NTHoyNel58dToFZXlzRcgkGgw1nVnRdRQQNkzjId4RR8HKL0sZmXo5CPaXupncF6XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733945543; c=relaxed/simple;
	bh=KcBQsjwz/IUHkE4Zz2lrGKV+2p4KLQ1DMYvlJAaCXMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYURciCa4WlzUlg0dQMR4YP46Cd3DFemiy26B/rG+eGHtjkteu2CWvvFUaeSKi/u1J6KiTlNXbixyrv/9FDZORyMF7i/wu4ulzno9ebbz/TaqblA5AlHNBF2P7DbYkAZbS2IHJL+hlmU2jwZgYU4LtYlysa8U3iUfn+qTc3XA/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FgZs5Odf; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 11 Dec 2024 11:32:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733945539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d6OKcSu+YVbuCISkjoli9i0TNQdc3Qjeu3F6E9XWl5w=;
	b=FgZs5OdfWb6afsj7/smsy7sJVQABpKNv7zAwZeHzPS3rUpNZFOyrrr5I6xB60xY1IWmtcE
	MQIqtXpxW0q2ZPiQFH4dzjArfWHI0N1VfA7Jckurbg3LsoXDoFU75LE1MICsfWjKydVqP3
	/HuIa0o/v1YFR+RZSQM4ODeoEn+jd/0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] vmalloc: Account memcg per vmalloc
Message-ID: <keho5no2wg666yjtkb5lflxwezgbzavue5ytydqm7pm7w62ctt@q6zg7t56gf4b>
References: <20241211043252.3295947-1-willy@infradead.org>
 <20241211043252.3295947-2-willy@infradead.org>
 <20241211160956.GB3136251@cmpxchg.org>
 <Z1nC3138biX0J1DJ@casper.infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1nC3138biX0J1DJ@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Dec 11, 2024 at 04:50:39PM +0000, Matthew Wilcox wrote:
> On Wed, Dec 11, 2024 at 11:09:56AM -0500, Johannes Weiner wrote:
> > This would work, but it seems somewhat complicated. The atomics in
> > memcg charging and the vmstat updates are batched, and the per-page
> > overhead is for the most part cheap per-cpu ops. Not an issue per se.
> 
> OK, fair enough, I hadn't realised it was a percpu-refcount.  Still,
> we might consume several batches (batch size of 64) when we could do it
> all in one shot.
> 
> Perhaps you'd be more persuaded by:
> 
> (a) If we clear __GFP_ACCOUNT then alloc_pages_bulk() will work, and
> that's a pretty significant performance win over calling alloc_pages()
> in a loop.
> 
> (b) Once we get to memdescs, calling alloc_pages() with __GFP_ACCOUNT
> set is going to require allocating a memdesc to store the obj_cgroup
> in, so in the future we'll save an allocation.
> 
> Your proposed alternative will work and is way less churn.  But it's
> not preparing us for memdescs ;-)

We can make alloc_pages_bulk() work with __GFP_ACCOUNT but your second
argument is more compelling.

I am trying to think of what will we miss if we remove this per-page
memcg metadata. One thing I can think of is debugging a live system
or kdump where I need to track where a given page came from. I think
memory profiling will still be useful in combination with going through
all vmalloc regions where this page is mapped (is there an easy way to
tell if a page is from a vmalloc region?). So, for now I think we will
have alternative way to extract the useful information.

I think we can go with Johannes' solution for stable and discuss the
future direction more separately.

