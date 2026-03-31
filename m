Return-Path: <cgroups+bounces-15129-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UITjEHK2y2kpKAYAu9opvQ
	(envelope-from <cgroups+bounces-15129-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2026 13:56:34 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 811A13692C3
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2026 13:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F45830BD997
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2026 11:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFBB3DD50E;
	Tue, 31 Mar 2026 11:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qH+lWmDY"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED5E378812;
	Tue, 31 Mar 2026 11:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774957724; cv=none; b=evUPc9c6XYxEu9rUEMBNxNX6XeruVw2pPIB95vLYuOAWK6RKeJiYNviQYQAkmmNz8shFFSfsMUYnHsEz9y4s5F+4/MqBuDx1f6StMALiqP+xMmifwSXjmE8DCeXbhF9MMpblpt1opFGtMtet7AdMoeEdrFcYPJnWbeVwVAmnY8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774957724; c=relaxed/simple;
	bh=UbzwtiFI4elDO2ehY143SPhvyyOtbmJDip5hc70RcPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FEbhTuErM9NZmQqiGjkT/lEnq8dXFkjFRaOnar258ZQmU51mXGQ7ccQfzSqovH7pVvmjnMsf10LZ0dHH0ENQllf2XQ/Ysci1DtYteOwnqbH+U5NgkkN7c1omkHKU+njZxolPwcC2iH1hsfwHujUOM0lET+DcVNpsvNB4J4Z1Zyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qH+lWmDY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7772AC2BC9E;
	Tue, 31 Mar 2026 11:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774957723;
	bh=UbzwtiFI4elDO2ehY143SPhvyyOtbmJDip5hc70RcPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qH+lWmDYqwBLGcMXBzxy6RXjgL4K97AmcRwRsEq/1CMvCesL5ZZ+szGv2L8DNIURZ
	 HRGvEGwYgDMCe5y3QMwYZQeqk+W/UIVbwdN57Fc7mfE6En2wPrK10+bQfK72RxVBSz
	 XbfunX4ZYn1g1kzmFWevbfv1dVJIAr09jEfTY0ykzvC9vQaLjYKZTAyIfGZf/q5BAs
	 eutxQ/A/MG8D7oopemN4PoVsQ3VwyojuF2jMI/c6S7YK5HX1c5Xg1xJUNyFR+G3Zmi
	 3+zfaBcoF6aKf6xU4Q5MuFiAnjd2aNJHUysVFIrdYn/Tne2E9PltBbPK1OgS3wYVBU
	 mDHSC6Hd5YEMw==
Date: Tue, 31 Mar 2026 20:48:40 +0900
From: "Harry Yoo (Oracle)" <harry@kernel.org>
To: Hui Zhu <hui.zhu@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Hui Zhu <zhuhui@kylinos.cn>
Subject: Re: [PATCH mm-stable v3] mm/memcontrol: batch memcg charging in
 __memcg_slab_post_alloc_hook
Message-ID: <acu0mGYGI6K_yTL1@hyeyoo>
References: <20260331091707.226786-1-hui.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331091707.226786-1-hui.zhu@linux.dev>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15129-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 811A13692C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 05:17:07PM +0800, Hui Zhu wrote:
> From: Hui Zhu <zhuhui@kylinos.cn>
> 
> When kmem_cache_alloc_bulk() allocates multiple objects, the post-alloc
> hook __memcg_slab_post_alloc_hook() previously charged memcg one object
> at a time, even though consecutive objects may reside on slabs backed by
> the same pgdat node.
> 
> Batch the memcg charging by scanning ahead from the current position to
> find a contiguous run of objects whose slabs share the same pgdat, then
> issue a single __obj_cgroup_charge() / __consume_obj_stock() call for
> the entire run. The per-object obj_ext assignment loop is preserved as-is
> since it cannot be further collapsed.
> 
> This implements the TODO comment left in commit bc730030f956 ("memcg:
> combine slab obj stock charging and accounting").
> 
> The existing error-recovery contract is unchanged: if size == 1 then
> memcg_alloc_abort_single() will free the sole object, and for larger
> bulk allocations kmem_cache_free_bulk() will uncharge any objects that
> were already charged before the failure.
> 
> Benchmark using kmem_cache_alloc_bulk() with SLAB_ACCOUNT
> (iters=100000):
> 
>   bulk=32  before: 215 ns/object   after: 174 ns/object  (-19%)
>   bulk=1   before: 344 ns/object   after: 335 ns/object  (  ~)
> 
> No measurable regression for bulk=1, as expected.
> 
> Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
> ---
> 
> Changelog:
> v3:
> Update base from "mm-unstable" to "mm-stable".
> v2:
> According to the comments in [1], add code to handle the integer
> overflow issue.
> 
> [1] https://sashiko.dev/#/patchset/20260316084839.1342163-1-hui.zhu%40linux.dev
> 
>  mm/memcontrol.c | 77 +++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 58 insertions(+), 19 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 051b82ebf371..3159bf39e060 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3277,51 +3277,90 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
>  			return false;
>  	}
>  
> -	for (i = 0; i < size; i++) {
> +	for (i = 0; i < size; ) {
>  		unsigned long obj_exts;
>  		struct slabobj_ext *obj_ext;
>  		struct obj_stock_pcp *stock;
> +		struct pglist_data *pgdat;
> +		int batch_bytes;
> +		size_t run_len = 0;

Let's initialize it to 1 to simplify the code. And perhaps the variable
could be renamed `batch_count` to align with `batch_bytes`.

> +		size_t j;
> +		size_t max_size;
> +		bool skip_next = false;
>  
>  		slab = virt_to_slab(p[i]);
>  
>  		if (!slab_obj_exts(slab) &&
>  		    alloc_slab_obj_exts(slab, s, flags, false)) {
> +			i++;
>  			continue;
>  		}
>  
> +		pgdat = slab_pgdat(slab);
> +		run_len = 1;

Hmm allocating 2GiB of memory at one kmem_cache_alloc_bulk() call sounds
already crazy, but if we have to check overflow anyway...

Could we simply skip the optimization
if check_mul_overflow(obj_size, size, &batch_bytes) returns nonzero?
It should be extremely unlikely to trigger anyway.

> +		/*
> +		 * The value of batch_bytes must not exceed
> +		 * (INT_MAX - PAGE_SIZE) to prevent integer overflow in

Since the vmstat data is cached at least once before it's flushed,
it isn't accurate to assume that stock->nr_slab_{un,}reclaimable will be
<= PAGE_SIZE.

So I think it's safe for `batch_bytes` to be INT_MAX but
__account_obj_stock() should check if it'll overflow before adding the
counter?

(but again that sounds quite theoretical and unlikely to hit in practice)

> +		 * the final accumulation performed by __account_obj_stock().
> +		 */
> +		max_size = min((size_t)((INT_MAX - PAGE_SIZE) / obj_size),
> +			       size);
> +
> +		for (j = i + 1; j < max_size; j++) {
> +			struct slab *slab_j = virt_to_slab(p[j]);
> +
> +			if (slab_pgdat(slab_j) != pgdat)
> +				break;
> +
> +			if (!slab_obj_exts(slab_j) &&
> +			    alloc_slab_obj_exts(slab_j, s, flags, false)) {
> +				skip_next = true;

Let's not micro-optimize it and drop skip_next.
In the next iteration of the outer loop it will be skipped anyway and
it's rare for alloc_slab_obj_exts() to fail.

> +				break;
> +			}
> +
> +			run_len++;
> +		}
> +
>  		/*
> -		 * if we fail and size is 1, memcg_alloc_abort_single() will
> +		 * If we fail and size is 1, memcg_alloc_abort_single() will
>  		 * just free the object, which is ok as we have not assigned
> -		 * objcg to its obj_ext yet
> -		 *
> -		 * for larger sizes, kmem_cache_free_bulk() will uncharge
> -		 * any objects that were already charged and obj_ext assigned
> +		 * objcg to its obj_ext yet.
>  		 *
> -		 * TODO: we could batch this until slab_pgdat(slab) changes
> -		 * between iterations, with a more complicated undo
> +		 * For larger sizes, kmem_cache_free_bulk() will uncharge
> +		 * any objects that were already charged and obj_ext assigned.
>  		 */
> +		batch_bytes = obj_size * run_len;
>  		stock = trylock_stock();
> -		if (!stock || !__consume_obj_stock(objcg, stock, obj_size)) {
> +		if (!stock || !__consume_obj_stock(objcg, stock, batch_bytes)) {
>  			size_t remainder;
>  
>  			unlock_stock(stock);
> -			if (__obj_cgroup_charge(objcg, flags, obj_size, &remainder))
> +			if (__obj_cgroup_charge(objcg, flags, batch_bytes, &remainder))
>  				return false;
>  			stock = trylock_stock();
>  			if (remainder)
>  				__refill_obj_stock(objcg, stock, remainder, false);
>  		}
> -		__account_obj_stock(objcg, stock, obj_size,
> -				    slab_pgdat(slab), cache_vmstat_idx(s));
> +		__account_obj_stock(objcg, stock, batch_bytes,
> +				    pgdat, cache_vmstat_idx(s));
>  		unlock_stock(stock);
>  
> -		obj_exts = slab_obj_exts(slab);
> -		get_slab_obj_exts(obj_exts);
> -		off = obj_to_index(s, slab, p[i]);
> -		obj_ext = slab_obj_ext(slab, obj_exts, off);
> -		obj_cgroup_get(objcg);
> -		obj_ext->objcg = objcg;
> -		put_slab_obj_exts(obj_exts);
> +		for (j = 0; j < run_len; j++) {
> +			slab = virt_to_slab(p[i + j]);
> +			obj_exts = slab_obj_exts(slab);
> +			get_slab_obj_exts(obj_exts);
> +			off = obj_to_index(s, slab, p[i + j]);
> +			obj_ext = slab_obj_ext(slab, obj_exts, off);

> +			obj_cgroup_get(objcg);

This could be batched by calling:
		obj_cgroup_get_many(objcg, batch_count);

> +			obj_ext->objcg = objcg;
> +			put_slab_obj_exts(obj_exts);
> +		}
> +
> +		if (skip_next)
> +			i = i + run_len + 1;
> +		else
> +			i += run_len;

With the suggestion above this could be `i += batch_count;`

>  	}
>  
>  	return true;

To sum up... something like this?

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c3d98ab41f1f..3252252ea9c3 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3184,8 +3184,12 @@ static void __account_obj_stock(struct obj_cgroup *objcg,
 		*bytes = nr;
 		nr = 0;
 	} else {
-		*bytes += nr;
-		if (abs(*bytes) > PAGE_SIZE) {
+		int old = *bytes;
+
+		if (unlikely(check_add_overflow(old, nr, bytes))) {
+			*bytes = nr;
+			nr = old;
+		} else if (abs(*bytes) > PAGE_SIZE) {
 			nr = *bytes;
 			*bytes = 0;
 		} else {
@@ -3422,6 +3426,8 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 	struct slab *slab;
 	unsigned long off;
 	size_t i;
+	int batch_bytes;
+	bool skip_batching = false;

 	/*
 	 * The obtained objcg pointer is safe to use within the current scope,
@@ -3455,51 +3461,77 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 			return false;
 	}

-	for (i = 0; i < size; i++) {
+	if (check_mul_overflow(obj_size, size, &batch_bytes))
+		skip_batching = true;
+
+	for (i = 0; i < size; ) {
 		unsigned long obj_exts;
 		struct slabobj_ext *obj_ext;
 		struct obj_stock_pcp *stock;
+		struct pglist_data *pgdat;
+		size_t batch_count = 1;
+		size_t j;

 		slab = virt_to_slab(p[i]);
-
 		if (!slab_obj_exts(slab) &&
 		    alloc_slab_obj_exts(slab, s, flags, false)) {
+			i++;
 			continue;
 		}

+		pgdat = slab_pgdat(slab);
+
+		if (likely(!skip_batching)) {
+			for (j = i + 1; j < size; j++) {
+				struct slab *slab_j = virt_to_slab(p[j]);
+
+				if (slab_pgdat(slab_j) != pgdat)
+					break;
+
+				if (!slab_obj_exts(slab_j) &&
+				    alloc_slab_obj_exts(slab_j, s, flags, false))
+					break;
+
+				batch_count++;
+			}
+		}
+
 		/*
-		 * if we fail and size is 1, memcg_alloc_abort_single() will
+		 * If we fail and size is 1, memcg_alloc_abort_single() will
 		 * just free the object, which is ok as we have not assigned
-		 * objcg to its obj_ext yet
-		 *
-		 * for larger sizes, kmem_cache_free_bulk() will uncharge
-		 * any objects that were already charged and obj_ext assigned
+		 * objcg to its obj_ext yet.
 		 *
-		 * TODO: we could batch this until slab_pgdat(slab) changes
-		 * between iterations, with a more complicated undo
+		 * For larger sizes, kmem_cache_free_bulk() will uncharge
+		 * any objects that were already charged and obj_ext assigned.
 		 */
+		batch_bytes = obj_size * batch_count;
 		stock = trylock_stock();
-		if (!stock || !__consume_obj_stock(objcg, stock, obj_size)) {
+		if (!stock || !__consume_obj_stock(objcg, stock, batch_bytes)) {
 			size_t remainder;

 			unlock_stock(stock);
-			if (__obj_cgroup_charge(objcg, flags, obj_size, &remainder))
+			if (__obj_cgroup_charge(objcg, flags, batch_bytes, &remainder))
 				return false;
 			stock = trylock_stock();
 			if (remainder)
 				__refill_obj_stock(objcg, stock, remainder, false);
 		}
-		__account_obj_stock(objcg, stock, obj_size,
-				    slab_pgdat(slab), cache_vmstat_idx(s));
+		__account_obj_stock(objcg, stock, batch_bytes,
+				    pgdat, cache_vmstat_idx(s));
 		unlock_stock(stock);

-		obj_exts = slab_obj_exts(slab);
-		get_slab_obj_exts(obj_exts);
-		off = obj_to_index(s, slab, p[i]);
-		obj_ext = slab_obj_ext(slab, obj_exts, off);
-		obj_cgroup_get(objcg);
-		obj_ext->objcg = objcg;
-		put_slab_obj_exts(obj_exts);
+		obj_cgroup_get_many(objcg, batch_count);
+		for (j = 0; j < batch_count; j++) {
+			slab = virt_to_slab(p[i + j]);
+			obj_exts = slab_obj_exts(slab);
+			get_slab_obj_exts(obj_exts);
+			off = obj_to_index(s, slab, p[i + j]);
+			obj_ext = slab_obj_ext(slab, obj_exts, off);
+			obj_ext->objcg = objcg;
+			put_slab_obj_exts(obj_exts);
+		}
+
+		i += batch_count;
 	}

 	return true;
--
2.43.0

-- 
Cheers,
Harry / Hyeonggon

