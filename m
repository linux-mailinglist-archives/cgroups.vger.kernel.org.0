Return-Path: <cgroups+bounces-14549-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODQ3L7iipmmvSAAAu9opvQ
	(envelope-from <cgroups+bounces-14549-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 09:58:32 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FE41EB586
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 09:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 231AB3063A3D
	for <lists+cgroups@lfdr.de>; Tue,  3 Mar 2026 08:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8ED388E7B;
	Tue,  3 Mar 2026 08:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VdaLmcCl"
X-Original-To: cgroups@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A8A388E4E;
	Tue,  3 Mar 2026 08:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772528062; cv=none; b=qB78eX4B/nnN9OHOkSCuqdPndB7LCLQwYlbNeFS1djkjV0hVsgvsNVqNnuP+sOmBa4mcz5XXaYyAcKZUuXXA6IMrNDbsPJ1zByJrSibXnXNouqk7Jdy0lngifoleZwvSnWqmzuOQXeeTmyx04Kk31qQ/8f5zhP3+WTetqKJhqQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772528062; c=relaxed/simple;
	bh=Q2xmAIqcvEi1bImWiPZx6m+IbHSDR2uyAntQny9gosA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AH9IzjfnuF0PzGhWSSm0GkL0IZjICfadSERxpitWVBq48lTmAcwUjtdGi+4GfdtgB58GB9/7XMfsxGBMowBydhWrC4y3d4MlGkC2RSpaHLH0ukv5AyQRWS5YVjAOR6XX9/M/i8LoNtwVJ+uBztjmcaIRvE9GTm5tFwG9QdPpH+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VdaLmcCl; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 3 Mar 2026 16:54:09 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772528058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F7y7kpyZN5h3rth4U4l4dHOAQLEKFRkncvb8z3K3NMY=;
	b=VdaLmcCldqdF5tNiByu00tqk5QGK3YQEXUwVUrW5vuWfkcPJ7QJg9zh7Qidc5PQKB+MUnE
	kOheGmcW0gKohRFMFcrhvNwA0iZiFRdvJDXAI3QtqGjxGTG4Q6JLIsDANsqzoZNOp14zyl
	ulow0/coOHbDp2q0j3Hd5nHENrLDzz4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Li <hao.li@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Vlastimil Babka <vbabka@suse.cz>, 
	Harry Yoo <harry.yoo@oracle.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] mm: memcg: separate slab stat accounting from objcg
 charge cache
Message-ID: <ji2jjt4vtmt2ox7wzytpivttc4z7j3u6cwmv23r6xit5322gns@te4t4djl5nlk>
References: <20260302195305.620713-1-hannes@cmpxchg.org>
 <20260302195305.620713-6-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302195305.620713-6-hannes@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 24FE41EB586
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14549-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hao.li@linux.dev,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:dkim,cmpxchg.org:email]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 02:50:18PM -0500, Johannes Weiner wrote:
> Cgroup slab metrics are cached per-cpu the same way as the sub-page
> charge cache. However, the intertwined code to manage those dependent
> caches right now is quite difficult to follow.
> 
> Specifically, cached slab stat updates occur in consume() if there was
> enough charge cache to satisfy the new object. If that fails, whole
> pages are reserved, and slab stats are updated when the remainder of
> those pages, after subtracting the size of the new slab object, are
> put into the charge cache. This already juggles a delicate mix of the
> object size, the page charge size, and the remainder to put into the
> byte cache. Doing slab accounting in this path as well is fragile, and
> has recently caused a bug where the input parameters between the two
> caches were mixed up.
> 
> Refactor the consume() and refill() paths into unlocked and locked
> variants that only do charge caching. Then let the slab path manage
> its own lock section and open-code charging and accounting.
> 
> This makes the slab stat cache subordinate to the charge cache:
> __refill_obj_stock() is called first to prepare it;
> __account_obj_stock() follows to hitch a ride.
> 
> This results in a minor behavioral change: previously, a mismatching
> percpu stock would always be drained for the purpose of setting up
> slab account caching, even if there was no byte remainder to put into
> the charge cache. Now, the stock is left alone, and slab accounting
> takes the uncached path if there is a mismatch. This is exceedingly
> rare, and it was probably never worth draining the whole stock just to
> cache the slab stat update.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/memcontrol.c | 100 +++++++++++++++++++++++++++++-------------------
>  1 file changed, 61 insertions(+), 39 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 4f12b75743d4..9c6f9849b717 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3218,16 +3218,18 @@ static struct obj_stock_pcp *trylock_stock(void)
>  

[...]

> @@ -3376,17 +3383,14 @@ static bool obj_stock_flush_required(struct obj_stock_pcp *stock,
>  	return flush;
>  }
>  
> -static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
> -		bool allow_uncharge, int nr_acct, struct pglist_data *pgdat,
> -		enum node_stat_item idx)
> +static void __refill_obj_stock(struct obj_cgroup *objcg,
> +			       struct obj_stock_pcp *stock,
> +			       unsigned int nr_bytes,
> +			       bool allow_uncharge)
>  {
> -	struct obj_stock_pcp *stock;
>  	unsigned int nr_pages = 0;
>  
> -	stock = trylock_stock();
>  	if (!stock) {
> -		if (pgdat)
> -			__account_obj_stock(objcg, NULL, nr_acct, pgdat, idx);
>  		nr_pages = nr_bytes >> PAGE_SHIFT;
>  		nr_bytes = nr_bytes & (PAGE_SIZE - 1);
>  		atomic_add(nr_bytes, &objcg->nr_charged_bytes);
> @@ -3404,20 +3408,25 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
>  	}
>  	stock->nr_bytes += nr_bytes;
>  
> -	if (pgdat)
> -		__account_obj_stock(objcg, stock, nr_acct, pgdat, idx);
> -
>  	if (allow_uncharge && (stock->nr_bytes > PAGE_SIZE)) {
>  		nr_pages = stock->nr_bytes >> PAGE_SHIFT;
>  		stock->nr_bytes &= (PAGE_SIZE - 1);
>  	}
>  
> -	unlock_stock(stock);
>  out:
>  	if (nr_pages)
>  		obj_cgroup_uncharge_pages(objcg, nr_pages);
>  }
>  
> +static void refill_obj_stock(struct obj_cgroup *objcg,
> +			     unsigned int nr_bytes,
> +			     bool allow_uncharge)
> +{
> +	struct obj_stock_pcp *stock = trylock_stock();
> +	__refill_obj_stock(objcg, stock, nr_bytes, allow_uncharge);
> +	unlock_stock(stock);

Hi Johannes,

I noticed that after this patch, obj_cgroup_uncharge_pages() is now inside
the obj_stock.lock critical section. Since obj_cgroup_uncharge_pages() calls
refill_stock(), which seems non-trivial, this might increase the lock hold time.
In particular, could that lead to more failed trylocks for IRQ handlers on
non-RT kernel (or for tasks that preempt others on RT kernel)?

-- 
Thanks,
Hao

