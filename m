Return-Path: <cgroups+bounces-17163-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GqZNMCTSOWqhxwcAu9opvQ
	(envelope-from <cgroups+bounces-17163-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 02:24:04 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0536B2F6F
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 02:24:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=iGcL9jYX;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17163-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17163-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 107DA30435A8
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 00:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF47283C82;
	Tue, 23 Jun 2026 00:23:52 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9EA27E1D7;
	Tue, 23 Jun 2026 00:23:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782174232; cv=none; b=tZzLrN1KHOdhS4QxhRpg4fC4cxAzvWe1CmJ1So/KPOi/kY5QnVD2VuRkQWIHiEfBKLtwyGWtiX/6MjkA/yOApDCUY/i6UsbcoZsvMurWFhms7eDhEXj2+MTzfWD+QhRHSKOrJVC49MdIGpeyiIZbld5kWqMRU+4Q2nHn9qa2sS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782174232; c=relaxed/simple;
	bh=QcVNEI1SmRG3lYwtNMZcvXBBrvnbg1LC/GB+Q/0VFQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5ALJ16Hmr1ZeJIOj6RGD/NQkrFWsWQ2AGNyTCaJZmkvuz2bbg9+/rRmORy6lhyG55oMjJqzkKWY48Sx5bcctqz45oUEKzpK8Nxg4j1dNlMiFwSiG68umnTiOSjLyJi70DDU3iTBtoaKdwJnROybkEpL+l9JYseqsNtaX9Xc1VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGcL9jYX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CFFE1F000E9;
	Tue, 23 Jun 2026 00:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782174228;
	bh=YHit9r0IoRMWbFlRiQsg1wNHzJglnuxwq3p+QyJDFZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iGcL9jYXrRA14FgJKhdYXvQW/0W0QLe4XZcr0d0Qs59PcihXu+134azYTICi0lOlk
	 MRDU3duuHCQaMZOSZGdhdae8ywcybNLcB4seQOx6fIxF6Uzu5GfQ9Uu9Rg0QTXplPq
	 c3JB+C9wbNcH5tTYFEcMUa+FsR/zaV0KsNrgFvpXydh0kUMJNKl7uWQAWYp0522BDa
	 mRKpEK1t3NjGi9h+5SdKxtGdXUsOpNI//cetu+Fgr3sjbIb0yT2ghLqS9M+T5jqncQ
	 WTC9Z4GberOxNy0bYADldKqRDU4fs8FZl7kAo2fb0mg4VPBKuPR6P8eKZ2FUZsBgIP
	 wv0UOybOxFlFQ==
Date: Tue, 23 Jun 2026 00:23:46 +0000
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
Subject: Re: [RFC PATCH v2 3/7] mm, swap: support physical swap as a vswap
 backend
Message-ID: <ajnRulrxAKnZavOl@google.com>
References: <20260612193738.2183968-1-nphamcs@gmail.com>
 <20260612193738.2183968-4-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612193738.2183968-4-nphamcs@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nphamcs@gmail.com,m:akpm@linux-foundation.org,m:chrisl@kernel.org,m:kasong@tencent.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:david@kernel.org,m:muchun.song@linux.dev,m:shikemeng@huaweicloud.com,m:baoquan.he@linux.dev,m:baohua@kernel.org,m:youngjun.park@lge.com,m:chengming.zhou@linux.dev,m:ljs@kernel.org,m:liam@infradead.org,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:qi.zheng@linux.dev,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:riel@surriel.com,m:gourry@gourry.net,m:haowenchao22@gmail.com,m:kernel-team@meta.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	FORGED_SENDER(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-17163-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,tencent.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1F0536B2F6F

On Fri, Jun 12, 2026 at 12:37:34PM -0700, Nhat Pham wrote:
> Add physical swap as a backend for the virtual swap layer.
> 
> With physical swap backing, vswap can allocate a physical slot on
> demand when needed: as a fallback for zswap_store failures, or as
> the destination for zswap writeback.
> 
> Each vswap entry's physical slot is tracked via a Pointer-tagged
> swap_table entry on the physical cluster (rmap back to the vswap
> entry).
> 
> Suggested-by: Kairui Song <kasong@tencent.com>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> ---
[..]
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 466f8a182716..5daff7a25f67 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -993,6 +993,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
>  	struct folio *folio;
>  	struct mempolicy *mpol;
>  	struct swap_info_struct *si;
> +	swp_entry_t phys = {};
>  	int ret = 0;
>  
>  	/* try to allocate swap cache folio */
> @@ -1000,16 +1001,6 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
>  	if (!si)
>  		return -EEXIST;
>  
> -	/*
> -	 * Vswap entries have no physical backing - writeback would fail
> -	 * and SIGBUS the caller. Bail before we waste a swap-cache folio
> -	 * allocation.
> -	 */
> -	if (si->flags & SWP_VSWAP) {
> -		put_swap_device(si);
> -		return -EINVAL;
> -	}
> -
>  	mpol = get_task_policy(current);
>  	folio = swap_cache_alloc_folio(swpentry, GFP_KERNEL, BIT(0), NULL, mpol,
>  				       NO_INTERLEAVE_INDEX);
> @@ -1028,40 +1019,78 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
>  	/*
>  	 * folio is locked, and the swapcache is now secured against
>  	 * concurrent swapping to and from the slot, and concurrent
> -	 * swapoff so we can safely dereference the zswap tree here.
> -	 * Verify that the swap entry hasn't been invalidated and recycled
> -	 * behind our backs, to avoid overwriting a new swap folio with
> -	 * old compressed data. Only when this is successful can the entry
> -	 * be dereferenced.
> +	 * swapoff so we can safely dereference the zswap tree (or vswap
> +	 * vtable) here. Verify that the swap entry hasn't been
> +	 * invalidated and recycled behind our backs, to avoid overwriting
> +	 * a new swap folio with old compressed data. Only when this is
> +	 * successful can the entry be dereferenced.
>  	 */
> -	tree = swap_zswap_tree(swpentry);
> -	if (entry != xa_load(tree, offset)) {
> -		ret = -ENOMEM;
> -		goto out;
> +	if (swap_is_vswap(si)) {
> +		if (entry != vswap_zswap_load(swpentry)) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +		/*
> +		 * Allocate physical backing BEFORE decompress - if it fails,
> +		 * no wasted work. folio_realloc_swap sets vtable to PHYS,
> +		 * overwriting ZSWAP - the old entry pointer is only held
> +		 * by the caller now.
> +		 */
> +		phys = folio_realloc_swap(folio);
> +		if (!phys.val) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}

I didn't look through the rest of the series, but are there use cases
for calling folio_realloc_swap() without calling vswap_zswap_load()
first? I wonder if the realloc_swap API should take the swpentry
directly and do the load within? Something like
vswap_alloc_phys(swpentry, folio)?

