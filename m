Return-Path: <cgroups+bounces-7832-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2D2A9BDA8
	for <lists+cgroups@lfdr.de>; Fri, 25 Apr 2025 06:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 430DB16DD92
	for <lists+cgroups@lfdr.de>; Fri, 25 Apr 2025 04:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE41E19DF98;
	Fri, 25 Apr 2025 04:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qCmKPfQV"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31C3215F52;
	Fri, 25 Apr 2025 04:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745555734; cv=none; b=r6SRQP4BXUSbidT7avxv6cy/uUcoWVrZDz79ZqDEAFNV1zHou4qkmR4cBeAQwd4gCbxAcLxlcRabD7lcCYhoGC5+etAiy0RPLN47GhHZO5ERO5QKPxhutppEFVa4BQxPn+84bkhthvi6KScsS/U7YLzqAVpuot1NkzioKq/XrME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745555734; c=relaxed/simple;
	bh=ttzySczgm8ypQHZzev8w8YPjMjW+EnWk7s5O2mrag3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DNc1PgRXGK1E74AMqmP7HxhnRGVUIKMUyEAZEgC8fY6YFGHgQx5UM4onXRIWrbhhz+b6dpkyE1du5jy7NiiUWgGNYI76TovOorDn8e7kItYn7vhgzc7Uy77VksWnIGHoBsVj8tYbCmDA2sjnW5D6M6q1Vxk91yqVtbKif7I1mPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qCmKPfQV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OpLvPEgMNJelRwjlOYq5KIQsfCtG8tk9z9qOlmY49hE=; b=qCmKPfQVdojQvLhSagwK14y4Lz
	o/szmMWhAtG2hMB8e1aBc7Lg7ZVc2Mw+O8dB7ZIdxrUVHWqgmZr2/Q/aLiSwN/qtk3CjOiPuppM73
	Kj00vhsc06zY8hpb1TqoQm2OPldcHEOrf6zIlvKTBEAfy684Ea6OAUw3SgkQG3RwgPo7+nDrGVnkH
	VUsO9RZWaPs1cMetrxGAwQ89MgukfkVkFltvaA+/OBzMCcl24qg8fkW7apk5gi1XEQAsRSDLeED+S
	i828G4oZWNbftE1RSMms4SvJGYhcjyl8pkWfO7DdymJfxKm/YjQ+yvkGX3oRKRWrC24y39n52RWNF
	kwVSZBog==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8AmY-0000000Dkxs-12xD;
	Fri, 25 Apr 2025 04:35:22 +0000
Date: Fri, 25 Apr 2025 05:35:22 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Huan Yang <link@vivo.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Francesco Valla <francesco@valla.it>,
	Raul E Rangel <rrangel@chromium.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Huang Shijie <shijie@os.amperecomputing.com>,
	Guo Weikang <guoweikang.kernel@gmail.com>,
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	KP Singh <kpsingh@kernel.org>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com
Subject: Re: [PATCH v3 0/3] Use kmem_cache for memcg alloc
Message-ID: <aAsRCj-niMMTtmK8@casper.infradead.org>
References: <20250425031935.76411-1-link@vivo.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425031935.76411-1-link@vivo.com>

On Fri, Apr 25, 2025 at 11:19:22AM +0800, Huan Yang wrote:
> Key Observations:
>   1. Both structures use kmalloc with requested sizes between 2KB-4KB
>   2. Allocation alignment forces 4KB slab usage due to pre-defined sizes
>      (64B, 128B,..., 2KB, 4KB, 8KB)
>   3. Memory waste per memcg instance:
>       Base struct: 4096 - 2312 = 1784 bytes
>       Per-node struct: 4096 - 2896 = 1200 bytes
>       Total waste: 2984 bytes (1-node system)
>       NUMA scaling: (1200 + 8) * nr_node_ids bytes
> So, it's a little waste.

[...]

> This indicates that the `mem_cgroup` struct now requests 2312 bytes
> and is allocated 2368 bytes, while `mem_cgroup_per_node` requests 2896 bytes
> and is allocated 2944 bytes.
> The slight increase in allocated size is due to `SLAB_HWCACHE_ALIGN` in the
> `kmem_cache`.
> 
> Without `SLAB_HWCACHE_ALIGN`, the allocation might appear as:
> 
>   # mem_cgroup struct allocation
>   sh-9269     [003] .....    80.396366: kmem_cache_alloc:
>     call_site=mem_cgroup_css_alloc+0xbc/0x5d4 ptr=000000005b12b475
>     bytes_req=2312 bytes_alloc=2312 gfp_flags=GFP_KERNEL|__GFP_ZERO node=-1
>     accounted=false
> 
>   # mem_cgroup_per_node allocation
>   sh-9269     [003] .....    80.396411: kmem_cache_alloc:
>     call_site=mem_cgroup_css_alloc+0x1b8/0x5d4 ptr=00000000f347adc6
>     bytes_req=2896 bytes_alloc=2896 gfp_flags=GFP_KERNEL|__GFP_ZERO node=0
>     accounted=false
> 
> While the `bytes_alloc` now matches the `bytes_req`, this patchset defaults
> to using `SLAB_HWCACHE_ALIGN` as it is generally considered more beneficial
> for performance. Please let me know if there are any issues or if I've
> misunderstood anything.

This isn't really the right way to think about this.  Memory is ultimately
allocated from the page allocator.  So what you want to know is how many
objects you get per page.  Before, it's one per page (since both objects
are between 2k and 4k and rounded up to 4k).  After, slab will create
slabs of a certain order to minimise waste, but also not inflate the
allocation order too high.  Let's assume it goes all the way to order 3
(like kmalloc-4k does), so you want to know how many objects fit in a
32KiB allocation.

With HWCACHE_ALIGN, you get floor(32768/2368) = 13 and
floor(32768/2944) = 11.

Without HWCACHE_ALIGN( you get floor(32768/2312) = 14 and
floor(32768/2896) = 11.

So there is a packing advantage to turning off HWCACHE_ALIGN (for the
first slab; no difference for the second).  BUT!  Now you have cacheline
aliasing between two objects, and that's probably bad.  It's the kind
of performance problem that's really hard to see.

Anyway, you've gone from allocating 8 objects per 32KiB to allocating
13 objects per 32KiB, a 62% improvement in memory consumption.

