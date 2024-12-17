Return-Path: <cgroups+bounces-5947-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBA99F55E7
	for <lists+cgroups@lfdr.de>; Tue, 17 Dec 2024 19:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B870162E7A
	for <lists+cgroups@lfdr.de>; Tue, 17 Dec 2024 18:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBD11F8925;
	Tue, 17 Dec 2024 18:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wyz1PN7J"
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2BB1448DC
	for <cgroups@vger.kernel.org>; Tue, 17 Dec 2024 18:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734459589; cv=none; b=kF18oMVZe16113+HfFHilCVbMEMMPNO7sKvP7+MAIgefEjfbbtuNis2czzrSjys607Y7DTAM/OlpsgHazs8dlguV0rbALl2782z2fLTsw54roPbwhZgm58O9ob2/wtAvFGO1ovKC/6r6wvzGmk8YqjGs7KsPShSsR/+HvBL4dXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734459589; c=relaxed/simple;
	bh=69b/sBPshrHOq+7LUEEnEYu/4ajNrLpJyMCfWAJDpQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZMIjjCtIV575oF5g31TnqN2cAi6yKmx/AaNga8H6CTNaP1SfueicHNMRMAa0lsnLOf3M3emkOMsR1ghM1VDSHIPdl5/oH/FzttBjOxO4MybCKU/rMaDMG8UXebFDKCDNBCXqS/tnhS0IB9l/cWJcl9Nnm0ye9yzgcs7eOg2UhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wyz1PN7J; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 17 Dec 2024 10:19:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734459585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=90cmCkJH8sbTboIFC394aI8JGeyjUNZJnQeP7FThfM4=;
	b=wyz1PN7JIA6uNzud5GRqCX2eaXCis/C7BrkZhH1eKxmlPyM4bbVu2v7u5c4YMpFJgMfnsb
	OvNzlZhgGvWjIs5V/EFZCZXMJhL0ijrBq6gyXwdxGHpMwZadpWke2qAzeW1amQrhd88G4L
	7eIONPeJRYnLgoIz/eW9UOe2Z07I1lc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: akpm@linux-foundation.org, mhocko@kernel.org, hannes@cmpxchg.org, 
	yosryahmed@google.com, roman.gushchin@linux.dev, muchun.song@linux.dev, 
	davidf@vimeo.com, vbabka@suse.cz, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, chenridong@huawei.com, wangweiyang2@huawei.com
Subject: Re: [next -v1 4/5] memcg: factor out the __refill_obj_stock function
Message-ID: <q7k5vqzeit4ib6joowtib6mlpwu2zdnrzse5kx44wx7jhmb6ta@w6deef6omz3d>
References: <20241206013512.2883617-1-chenridong@huaweicloud.com>
 <20241206013512.2883617-5-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206013512.2883617-5-chenridong@huaweicloud.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Dec 06, 2024 at 01:35:11AM +0000, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> Factor out the '__refill_obj_stock' function to make the code more
> cohesive.
> 
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>  mm/memcontrol.c | 31 ++++++++++++++++++-------------
>  1 file changed, 18 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index f977e0be1c04..0c9331d7b606 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2697,6 +2697,21 @@ void __memcg_kmem_uncharge_page(struct page *page, int order)
>  	obj_cgroup_put(objcg);
>  }
>  
> +/* If the cached_objcg was refilled, return true; otherwise, return false */
> +static bool __refill_obj_stock(struct memcg_stock_pcp *stock,
> +		struct obj_cgroup *objcg, struct obj_cgroup **old_objcg)
> +{
> +	if (READ_ONCE(stock->cached_objcg) != objcg) {

Keep the above check in the calling functions and make this a void
function. Also I think we need a better name.

> +		*old_objcg = drain_obj_stock(stock);
> +		obj_cgroup_get(objcg);
> +		stock->nr_bytes = atomic_read(&objcg->nr_charged_bytes)
> +				? atomic_xchg(&objcg->nr_charged_bytes, 0) : 0;
> +		WRITE_ONCE(stock->cached_objcg, objcg);
> +		return true;
> +	}
> +	return false;
> +}
> +
>  static void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
>  		     enum node_stat_item idx, int nr)
>  {
> @@ -2713,12 +2728,7 @@ static void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
>  	 * accumulating over a page of vmstat data or when pgdat or idx
>  	 * changes.
>  	 */
> -	if (READ_ONCE(stock->cached_objcg) != objcg) {
> -		old = drain_obj_stock(stock);
> -		obj_cgroup_get(objcg);
> -		stock->nr_bytes = atomic_read(&objcg->nr_charged_bytes)
> -				? atomic_xchg(&objcg->nr_charged_bytes, 0) : 0;
> -		WRITE_ONCE(stock->cached_objcg, objcg);
> +	if (__refill_obj_stock(stock, objcg, &old)) {
>  		stock->cached_pgdat = pgdat;
>  	} else if (stock->cached_pgdat != pgdat) {
>  		/* Flush the existing cached vmstat data */
> @@ -2871,14 +2881,9 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
>  	local_lock_irqsave(&memcg_stock.stock_lock, flags);
>  
>  	stock = this_cpu_ptr(&memcg_stock);
> -	if (READ_ONCE(stock->cached_objcg) != objcg) { /* reset if necessary */
> -		old = drain_obj_stock(stock);
> -		obj_cgroup_get(objcg);
> -		WRITE_ONCE(stock->cached_objcg, objcg);
> -		stock->nr_bytes = atomic_read(&objcg->nr_charged_bytes)
> -				? atomic_xchg(&objcg->nr_charged_bytes, 0) : 0;
> +	if (__refill_obj_stock(stock, objcg, &old))
>  		allow_uncharge = true;	/* Allow uncharge when objcg changes */
> -	}
> +
>  	stock->nr_bytes += nr_bytes;
>  
>  	if (allow_uncharge && (stock->nr_bytes > PAGE_SIZE)) {
> -- 
> 2.34.1
> 

