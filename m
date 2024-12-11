Return-Path: <cgroups+bounces-5815-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 458A29ED2AC
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 17:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69509280DC1
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 16:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AD81DDC36;
	Wed, 11 Dec 2024 16:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ksqYy2i0"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD45C1DDC13;
	Wed, 11 Dec 2024 16:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733935850; cv=none; b=t95Vs94wDPZN92vP4x2fNk0XxjBZliBbBTcOndM/gLd8LsbT6QANFYk9g5L4pDYs1aXuimwgxLT/Fc/r58+kuSadBIlzeLGV/OukrWJvQJNt7W3pQIBytbkiQgR90s4Tmh8/EDKNyoQdvf5ZG0H+LvzB+L8wXWSoBD1jMgNEWXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733935850; c=relaxed/simple;
	bh=FaRcA430zpaPEZ3WcdbY6aLj4jstjn5BEDHm8kU3zvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogVAn4njUj397l/W5HFAotEVLSfj9cG8Qbqbqvg4Sl+i9fdq5pKezYXDvjQwnR/LBsTIUt1Rna5QH1GLz+0wMdv6FZTs+4d/Sgxs2KI4oPcaMFN19l5GiJnaL9qWgTdKN5QSyFq3Q8np8lLN6URqsqhKYhMVbYdHcfaxYSsMBdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ksqYy2i0; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ICuyLC0N1PfoUnP1uyXTx2TzhXrxz7AoS2m8cXy25EM=; b=ksqYy2i0AI9hb5G2U7wZtdtBix
	zvF3ABZCd9fRJyw+3zbAaQGChE6id7+DHipte9hiphQ1DNGVPY9tAAs4F87AabenXqEW7v+sn0r+5
	IzocDLw2rNMAMxwe0PM7Khs9s0O2mDL/ARsYalvp/WH3kIYZ96D16rNqo/ftE4tNDYjoX37fUBSpf
	t/uj8qQlqVOoZW82RgYBoQghftna0YQcIsGEZGbyuXfNB+nnFRQyKbNhINPthW1yGPb7DvaUbievo
	BJUr6HZYNkNzi+2QxztNCA2nsJyaPpCaUcibcD9UEt0rnxsZ6APOtVau7RGhOnHOCr9AliCfYQM9Y
	yRi1lecQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tLPv6-0000000HDbC-0OZy;
	Wed, 11 Dec 2024 16:50:40 +0000
Date: Wed, 11 Dec 2024 16:50:39 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] vmalloc: Account memcg per vmalloc
Message-ID: <Z1nC3138biX0J1DJ@casper.infradead.org>
References: <20241211043252.3295947-1-willy@infradead.org>
 <20241211043252.3295947-2-willy@infradead.org>
 <20241211160956.GB3136251@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211160956.GB3136251@cmpxchg.org>

On Wed, Dec 11, 2024 at 11:09:56AM -0500, Johannes Weiner wrote:
> This would work, but it seems somewhat complicated. The atomics in
> memcg charging and the vmstat updates are batched, and the per-page
> overhead is for the most part cheap per-cpu ops. Not an issue per se.

OK, fair enough, I hadn't realised it was a percpu-refcount.  Still,
we might consume several batches (batch size of 64) when we could do it
all in one shot.

Perhaps you'd be more persuaded by:

(a) If we clear __GFP_ACCOUNT then alloc_pages_bulk() will work, and
that's a pretty significant performance win over calling alloc_pages()
in a loop.

(b) Once we get to memdescs, calling alloc_pages() with __GFP_ACCOUNT
set is going to require allocating a memdesc to store the obj_cgroup
in, so in the future we'll save an allocation.

Your proposed alternative will work and is way less churn.  But it's
not preparing us for memdescs ;-)

