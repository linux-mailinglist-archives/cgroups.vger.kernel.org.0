Return-Path: <cgroups+bounces-5546-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 905ED9C7C2B
	for <lists+cgroups@lfdr.de>; Wed, 13 Nov 2024 20:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7723EB26E6B
	for <lists+cgroups@lfdr.de>; Wed, 13 Nov 2024 19:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB949203712;
	Wed, 13 Nov 2024 19:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nsZ3C5Xj"
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA341FF7BD
	for <cgroups@vger.kernel.org>; Wed, 13 Nov 2024 19:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731525523; cv=none; b=e9KQHDl7L0QnngsnHo0fA69U/xn1XHinIQ9un18DVBz0lYucyQanKuW30XrjB7jfpxIcGW4GLQkNpQSLWMXwRsFMf1ego5ffJ1R/256o7pVwj4UofOkNk1ClThdbNFz1GzMFlgdVjPBfmfu4D34WgcXYKCDzzwzvlBNnHC3apvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731525523; c=relaxed/simple;
	bh=cl48UEXjbsnFfZCp8OqkLCcLDcDbf68SMHRoxCqbqZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XX7/3LjKCz6XZaxur7QEf2iOsCLUKHACtlVJjsf3PYNMDNbCvmBErZN4UQwWRI00nt3j5v1Ykrryhji1ML7vJpN3k1aTXc8UTA0UIOMf2tV1q0Q64Jp/MdYq8mf7xNPnIiD/EPexlb/KwIbQONew6k3X432d5EA4dS/a7PB0TZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nsZ3C5Xj; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 13 Nov 2024 19:18:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731525519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i9Dr4PPzgMybXoYmK3wfTXND+6Gc0LfaAn22+IErLaA=;
	b=nsZ3C5Xjhtcf+/WPJJWQgf5ujRoQ/1TPonCA6O8ly4bDKEXgvQMDNQ9y6xxlXeS5H8jXHm
	gvTeGq2aFuK3AwRhdTaYzgOWnaDkQj39nBB4295oAAo7H0y6ItiFLKtfmEZx3cPDYU+P/1
	hNhm3YqqwrvAy3o77IIBOYn3FsnVnbs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kinsey Ho <kinseyho@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Rientjes <rientjes@google.com>, willy@infradead.org,
	Vlastimil Babka <vbabka@suse.cz>,
	David Hildenbrand <david@redhat.com>,
	Joel Granados <joel.granados@kernel.org>,
	Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
	Sourav Panda <souravpanda@google.com>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH mm-unstable v1 0/2] Track pages allocated for struct
Message-ID: <ZzT7iL_2G1ftdlzZ@google.com>
References: <20241031224551.1736113-1-kinseyho@google.com>
 <20241031160604.bcd5740390f05a01409b64f3@linux-foundation.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031160604.bcd5740390f05a01409b64f3@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Oct 31, 2024 at 04:06:04PM -0700, Andrew Morton wrote:
> hm.
> 
> On Thu, 31 Oct 2024 22:45:49 +0000 Kinsey Ho <kinseyho@google.com> wrote:
> 
> > We noticed high overhead for pages allocated for struct swap_cgroup in
> > our fleet.
> 
> This is scanty.  Please describe the problem further.
> 
> > This patchset adds the number of pages allocated for struct
> > swap_cgroup to vmstat. This can be a useful metric for identifying
> > unneeded overhead on systems which configure swap.
> 
> Possibly dumb question: can we switch swap_cgroup_prepare to kmalloc()
> (or kmem-cache_alloc()) and use slab's accounting to satisfy this
> requirement?

Or vzalloc/kvmalloc(), which are used for allocating the rest of swap-related
meta-data.

