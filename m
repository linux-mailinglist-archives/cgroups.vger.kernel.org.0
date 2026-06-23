Return-Path: <cgroups+bounces-17161-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id m1lBHEjQOWpVxwcAu9opvQ
	(envelope-from <cgroups+bounces-17161-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 02:16:08 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E226B2F09
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 02:16:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=lyI9QEjd;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17161-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17161-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE6173037421
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 00:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C138F175A79;
	Tue, 23 Jun 2026 00:16:02 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537A9D531;
	Tue, 23 Jun 2026 00:16:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782173762; cv=none; b=R4tVyJusP8/RnEEX8HykiVE/tsCMY4JDQsqXamNfce63p7ffz0ZL917lnn7BkCSzrDPCVO4rLWl3nwTvoTWEEC6xn4/wxNRSlCUDUQ/hb42NOaiDJk4lsJz2R15JNBQpsqDnIq0SxCjgC+bWvlE81H3MWztlYMSiLJqczqGgv3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782173762; c=relaxed/simple;
	bh=bCJ1M6ktNoK0ZNHoaOoa1FC0bIZv3elAIYCkqSfby0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ATI4EFdLpRJbY17BG6ndtQYUHBsOhTbTvfGPa2W+YG7vFkd//6bH76nf9Md6ENQa+QRCwUz4YW+Na2zZOMXum9NXhoNOQmWzcVP492MpIQZtMZQkBz3DB2kIG55ao5pq/RKAUAA2QmmedXvc52LXrrQ5XHXfu1aI+PIvaFecUZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lyI9QEjd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 989571F000E9;
	Tue, 23 Jun 2026 00:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782173760;
	bh=umsOQ0srOaaouQ1wwMTp3caQiMkiMWPQfAtHOceVpz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lyI9QEjd4fWY0bqzQ1QVAa1Kh4MZf8EHugEiH09pxz0VRDGa1Nt0NVAwe4sKaOnnV
	 K0iiCX+9AGmhnGp/K2SeAn0b1ensgVgJlUZUds0M9uUHLeYzVMv3an+60FC8k/Z/Wf
	 HAZOGfDmMO/wSkMCoGtRPKrJV+CS10RWfbDBGIyiK3ThUOxEO/p4CwfDSeqECoeQlq
	 v5qMyQWIzFYA4CAeVYY0y8iBKlSwltjGbqCJ1k5tkeX1SLUDynqf5LS76n1rEKTuff
	 Dq+xa+X9HuO8+x/mcYVYaTo9CicpYZ2IRw1yC7bwuA97aK19Zq23RXS0KS2S66QpIq
	 bcib2jMFj/Z8A==
Date: Tue, 23 Jun 2026 00:15:58 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, chrisl@kernel.org, kasong@tencent.com, 
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, david@kernel.org, muchun.song@linux.dev, 
	shikemeng@huaweicloud.com, baoquan.he@linux.dev, baohua@kernel.org, youngjun.park@lge.com, 
	chengming.zhou@linux.dev, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, 
	rppt@kernel.org, surenb@google.com, qi.zheng@linux.dev, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, riel@surriel.com, gourry@gourry.net, 
	haowenchao22@gmail.com, kernel-team@meta.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/7] mm, swap: support zswap and zeroswap as vswap
 backends
Message-ID: <ajnNWRO7apBq2-kQ@google.com>
References: <20260612193738.2183968-1-nphamcs@gmail.com>
 <20260612193738.2183968-3-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612193738.2183968-3-nphamcs@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:nphamcs@gmail.com,m:akpm@linux-foundation.org,m:chrisl@kernel.org,m:kasong@tencent.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:david@kernel.org,m:muchun.song@linux.dev,m:shikemeng@huaweicloud.com,m:baoquan.he@linux.dev,m:baohua@kernel.org,m:youngjun.park@lge.com,m:chengming.zhou@linux.dev,m:ljs@kernel.org,m:liam@infradead.org,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:qi.zheng@linux.dev,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:riel@surriel.com,m:gourry@gourry.net,m:haowenchao22@gmail.com,m:kernel-team@meta.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	FORGED_SENDER(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-17161-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,tencent.com,cmpxchg.org,linux.dev,huaweicloud.com,lge.com,infradead.org,google.com,surriel.com,gourry.net,gmail.com,meta.com,kvack.org,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A8E226B2F09

On Fri, Jun 12, 2026 at 12:37:33PM -0700, Nhat Pham wrote:
> Build the virtual swap layer on top of the swap-table infrastructure.
> Virtual swap entries decouple PTE swap entries from physical backing,
> allowing pages to be compressed by zswap (or detected as zero-filled)
> without pre-allocating a physical swap slot.
> 
> This patch only supports zswap and zero-page backends. If zswap_store
> fails, the page stays dirty in the swap cache (AOP_WRITEPAGE_ACTIVATE)
> - physical disk backing fallback comes in the next patch. Zswap
> writeback of vswap-backed entries is also disabled - the shrinker
> skips when no physical swap pages are available.
> 
> Suggested-by: Kairui Song <kasong@tencent.com>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
[..]
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 993406074d58..466f8a182716 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -38,6 +38,7 @@
>  #include <linux/zsmalloc.h>
>  
>  #include "swap.h"
> +#include "vswap.h"
>  #include "internal.h"
>  
>  /*********************************
> @@ -762,7 +763,7 @@ static void zswap_entry_cache_free(struct zswap_entry *entry)
>   * Carries out the common pattern of freeing an entry's zsmalloc allocation,
>   * freeing the entry itself, and decrementing the number of stored pages.
>   */
> -static void zswap_entry_free(struct zswap_entry *entry)
> +void zswap_entry_free(struct zswap_entry *entry)
>  {
>  	zswap_lru_del(&zswap_list_lru, entry);
>  	zs_free(entry->pool->zs_pool, entry->handle);
> @@ -994,16 +995,21 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
>  	struct swap_info_struct *si;
>  	int ret = 0;
>  
> +	/* try to allocate swap cache folio */
>  	si = get_swap_device(swpentry);
>  	if (!si)
>  		return -EEXIST;
>  
> +	/*
> +	 * Vswap entries have no physical backing - writeback would fail
> +	 * and SIGBUS the caller. Bail before we waste a swap-cache folio
> +	 * allocation.
> +	 */

Seems like this comment belongs in the previous patch, and the other
comment movement is undoing what last patch did.

>  	if (si->flags & SWP_VSWAP) {
>  		put_swap_device(si);
>  		return -EINVAL;
>  	}
>  
> -	/* try to allocate swap cache folio */
>  	mpol = get_task_policy(current);
>  	folio = swap_cache_alloc_folio(swpentry, GFP_KERNEL, BIT(0), NULL, mpol,
>  				       NO_INTERLEAVE_INDEX);
> @@ -1416,25 +1422,25 @@ static bool zswap_store_page(struct page *page,
>  	if (!zswap_compress(page, entry, pool))
>  		goto compress_failed;
>  
> -	old = xa_store(swap_zswap_tree(page_swpentry),
> -		       swp_offset(page_swpentry),
> -		       entry, GFP_KERNEL);
> -	if (xa_is_err(old)) {
> -		int err = xa_err(old);
> +	if (is_vswap_entry(page_swpentry)) {
> +		vswap_zswap_store(page_swpentry, entry);
> +	} else {
> +		old = xa_store(swap_zswap_tree(page_swpentry),
> +			       swp_offset(page_swpentry),
> +			       entry, GFP_KERNEL);
> +		if (xa_is_err(old)) {
> +			int err = xa_err(old);
> +
> +			WARN_ONCE(err != -ENOMEM,
> +				  "unexpected xarray error: %d\n", err);
> +			zswap_reject_alloc_fail++;
> +			goto store_failed;
> +		}
>  
> -		WARN_ONCE(err != -ENOMEM, "unexpected xarray error: %d\n", err);
> -		zswap_reject_alloc_fail++;
> -		goto store_failed;
> +		if (old)
> +			zswap_entry_free(old);
>  	}
>  
> -	/*
> -	 * We may have had an existing entry that became stale when
> -	 * the folio was redirtied and now the new version is being
> -	 * swapped out. Get rid of the old.
> -	 */
> -	if (old)
> -		zswap_entry_free(old);
> -
>  	/*
>  	 * The entry is successfully compressed and stored in the tree, there is
>  	 * no further possibility of failure. Grab refs to the pool and objcg,
> @@ -1487,6 +1493,7 @@ bool zswap_store(struct folio *folio)
>  	struct mem_cgroup *memcg = NULL;
>  	struct zswap_pool *pool;
>  	bool ret = false;
> +	bool partial_store = false;
>  	long index;
>  
>  	VM_WARN_ON_ONCE(!folio_test_locked(folio));
> @@ -1524,8 +1531,10 @@ bool zswap_store(struct folio *folio)
>  	for (index = 0; index < nr_pages; ++index) {
>  		struct page *page = folio_page(folio, index);
>  
> -		if (!zswap_store_page(page, objcg, pool))
> +		if (!zswap_store_page(page, objcg, pool)) {
> +			partial_store = index > 0;
>  			goto put_pool;
> +		}
>  	}
>  
>  	if (objcg)
> @@ -1548,7 +1557,9 @@ bool zswap_store(struct folio *folio)
>  	 * offsets corresponding to each page of the folio. Otherwise,
>  	 * writeback could overwrite the new data in the swapfile.
>  	 */
> -	if (!ret) {
> +	if (partial_store && is_vswap_entry(swp))
> +		folio_release_vswap_backing(folio);

Hmm the above should also only happen in the !ret case, but that's not
obvious from the code here. I think all of this should go under if
(!ret), but maybe reverse the polarity to avoid the indentation?

	if (ret)
		return ret;

	if (is_vswap_entry(swp)) {
		if (partial_store)
			folio_release_vswap_backing(folio);
		return ret;
	}

	...

Alternatively you can move the check_old code for xarray into a helper
and do:

	if (!ret) {
		if (is_vswap_entry(swp)) {
			if (partial_store)
				folio_release_vswap_backing(folio);
		} else {
			zswap_free_old_xa_entries(swp, nr_pages)
		}
	}

Also, I think you can probably drop partial_store and check the index
directly here.

> +	else if (!ret && !is_vswap_entry(swp)) {
>  		unsigned type = swp_type(swp);
>  		pgoff_t offset = swp_offset(swp);
>  		struct zswap_entry *entry;
> @@ -1588,8 +1599,7 @@ bool zswap_store(struct folio *folio)
>  int zswap_load(struct folio *folio)
>  {
>  	swp_entry_t swp = folio->swap;
> -	pgoff_t offset = swp_offset(swp);
> -	struct xarray *tree = swap_zswap_tree(swp);
> +	struct swap_info_struct *si = __swap_entry_to_info(swp);
>  	struct zswap_entry *entry;
>  
>  	VM_WARN_ON_ONCE(!folio_test_locked(folio));
> @@ -1599,16 +1609,25 @@ int zswap_load(struct folio *folio)
>  		return -ENOENT;
>  
>  	/*
> -	 * Large folios should not be swapped in while zswap is being used, as
> -	 * they are not properly handled. Zswap does not properly load large
> -	 * folios, and a large folio may only be partially in zswap.
> +	 * zswap_load() does not support large folios. For non-vswap
> +	 * entries this is unexpected on the swapin path: WARN and
> +	 * sigbus. For vswap entries __swap_cache_add_check() has already
> +	 * filtered out ZSWAP-backed THPs under the cluster lock, so the
> +	 * large folio here is zero- or phys-backed; return -ENOENT to
> +	 * fall through to the phys/zero IO path.

Hmm should we start simple and avoid THP swapin for vswap initially?

IIUC, it isn't really vswap specific. Even without vswap, it's possible
that an entire folio is on-disk, not in zswap, in which case THP swap
should be allowed.

I assume it's not common for zswap to be enabled and an entire THP worth
of pages are not in zswap, so maybe we can add this later?

>  	 */
> -	if (WARN_ON_ONCE(folio_test_large(folio))) {
> -		folio_unlock(folio);
> -		return -EINVAL;
> +	if (folio_test_large(folio)) {
> +		if (WARN_ON_ONCE(!swap_is_vswap(si))) {
> +			folio_unlock(folio);
> +			return -EINVAL;
> +		}
> +		return -ENOENT;
>  	}
>  
> -	entry = xa_load(tree, offset);
> +	if (swap_is_vswap(si))
> +		entry = vswap_zswap_load(swp);
> +	else
> +		entry = xa_load(swap_zswap_tree(swp), swp_offset(swp));
>  	if (!entry)
>  		return -ENOENT;
>  
> @@ -1623,16 +1642,14 @@ int zswap_load(struct folio *folio)
>  	if (entry->objcg)
>  		count_objcg_events(entry->objcg, ZSWPIN, 1);
>  
> -	/*
> -	 * We are reading into the swapcache, invalidate zswap entry.
> -	 * The swapcache is the authoritative owner of the page and
> -	 * its mappings, and the pressure that results from having two
> -	 * in-memory copies outweighs any benefits of caching the
> -	 * compression work.
> -	 */
>  	folio_mark_dirty(folio);
> -	xa_erase(tree, offset);
> -	zswap_entry_free(entry);
> +
> +	if (swap_is_vswap(si)) {
> +		folio_release_vswap_backing(folio);

Is there any advantage to calling folio_release_vswap_backing() over
zswap_entry_free()? Seems like __vswap_release_backing() ends up just
calling zswap_entry_free() -- and I don't see any vswap-specific state
being cleaned up.

I wonder if the zswap code should call zswap_entry_free() directly? Same
goes for the call in zswap_store() above.

> +	} else {
> +		xa_erase(swap_zswap_tree(swp), swp_offset(swp));
> +		zswap_entry_free(entry);
> +	}
>  
>  	folio_unlock(folio);
>  	return 0;
> -- 
> 2.53.0-Meta
> 

