Return-Path: <cgroups+bounces-7115-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2367EA664E5
	for <lists+cgroups@lfdr.de>; Tue, 18 Mar 2025 02:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0943E3B51B3
	for <lists+cgroups@lfdr.de>; Tue, 18 Mar 2025 01:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCCB46426;
	Tue, 18 Mar 2025 01:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U8qOLmA+"
X-Original-To: cgroups@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58C21519B4
	for <cgroups@vger.kernel.org>; Tue, 18 Mar 2025 01:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742260830; cv=none; b=tCNhU9S1IMu5wuVUeMHYeeAJS2Us6mKNHxdZCmldg85KmJb+xeSEI1jI6S7AeZlriULnBPNeYpEGPt/gsASTkG3qvPhQxCqZkFiwIGaOEP+RQC1kWbtEHJp3TYQf/zGbAqwsrCOrc1D1M6XYZbkDV7OFV0S5FiRYFTUtZ2fjRqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742260830; c=relaxed/simple;
	bh=XouFCXKKpXLs77apd+bHsKKnvHmtRmJEKfww8kJFlTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VUzkB6GdxEJf6D+aaM6ngwlY+qeDEVtkWSSZGSJvafVYL5VkNIX9hbui7PmElF8eSM6yiWAAL1wWurv4o6FeFWn2+/tnS64qI7yY+0lXlX5u3tX1MATXqzjrqwx4GvywDbLlIrZ+ohH6WocEn0MDg6TLJnsiAjIvzxQtT5Iubyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U8qOLmA+; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 18 Mar 2025 01:20:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742260816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+vpwPHrf20lSWnkzGhdqIPFZKWwfBUMFQHDJp14oi8M=;
	b=U8qOLmA+CT7DQ2Jg5YUmxUs0T3NNLq9xr+yALISTNzUP1Q8xMThUfPIMAoAY8Ml45RRB08
	/Fhu3IQUMZ//yX5o2IYqitzyY9VlilY3csrYJC6kG/Hfn4Z5fGCI5aWuDjfZAsKWfsGX11
	9aUwTeUnLuWIewKUBUL6YiLMvlENnUI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 8/9] memcg: combine slab obj stock charging and accounting
Message-ID: <Z9jKSZpr41hcrqvD@google.com>
References: <20250315174930.1769599-1-shakeel.butt@linux.dev>
 <20250315174930.1769599-9-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250315174930.1769599-9-shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Sat, Mar 15, 2025 at 10:49:29AM -0700, Shakeel Butt wrote:
> From: Vlastimil Babka <vbabka@suse.cz>
> 
> When handing slab objects, we use obj_cgroup_[un]charge() for
> (un)charging and mod_objcg_state() to account NR_SLAB_[UN]RECLAIMABLE_B.
> All these operations use the percpu stock for performance. However with
> the calls being separate, the stock_lock is taken twice in each case.
> 
> By refactoring the code, we can turn mod_objcg_state() into
> __account_obj_stock() which is called on a stock that's already locked
> and validated. On the charging side we can call this function from
> consume_obj_stock() when it succeeds, and refill_obj_stock() in the
> fallback. We just expand parameters of these functions as necessary.
> The uncharge side from __memcg_slab_free_hook() is just the call to
> refill_obj_stock().
> 
> Other callers of obj_cgroup_[un]charge() (i.e. not slab) simply pass the
> extra parameters as NULL/zeroes to skip the __account_obj_stock()
> operation.
> 
> In __memcg_slab_post_alloc_hook() we now charge each object separately,
> but that's not a problem as we did call mod_objcg_state() for each
> object separately, and most allocations are non-bulk anyway. This
> could be improved by batching all operations until slab_pgdat(slab)
> changes.
> 
> Some preliminary benchmarking with a kfree(kmalloc()) loop of 10M
> iterations with/without __GFP_ACCOUNT:
> 
> Before the patch:
> kmalloc/kfree !memcg:    581390144 cycles
> kmalloc/kfree memcg:     783689984 cycles
> 
> After the patch:
> kmalloc/kfree memcg:     658723808 cycles
> 
> More than half of the overhead of __GFP_ACCOUNT relative to
> non-accounted case seems eliminated.

Oh, this is huge!

I believe the next step is to also integrate the refcnt management,
it might shave off few more percent.

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

