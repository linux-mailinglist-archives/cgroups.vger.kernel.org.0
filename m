Return-Path: <cgroups+bounces-16328-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePTfEjtMFmrZkQcAu9opvQ
	(envelope-from <cgroups+bounces-16328-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 03:43:23 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 044045DE550
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 03:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EE6BE300981A
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 01:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109E23264E2;
	Wed, 27 May 2026 01:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jlIwSpdl"
X-Original-To: cgroups@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165A2315D21
	for <cgroups@vger.kernel.org>; Wed, 27 May 2026 01:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779846186; cv=none; b=lzUO0dBqzgVGG5il53oRQDDwA0QQXQZcHpPF2FoiKrwENs6Fjt0EVGLrLRz3p6HJfhJ+XDQLSaOR91HM9qVKdYlDuPZLqPnmyJYRIdlgEv0gs9qUoaThEWIbdbPeXn9FZ+lbRwPN5gTYfsoTzrZoBWdEt0VttTI4E8My6zPTHk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779846186; c=relaxed/simple;
	bh=ycfMMg9+7DShBq3vWQYzurSrqAe8/KImlo6O2xMlEYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lWx1AVAKvIALlAWy3f9p3uu3I3XRDKYtwLqJT6Y3T+LUL39u6h04BSlp5D1RIx3usc6/de2th4+QCgcVdfs5GPJpX1evm+8A2OLT6w1E9TMRbAj/jw+UYsSEsZp9tSmFygzYLGSEGSYpxrteCu5lDI28RJv41xBlJzbVK11Qp+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jlIwSpdl; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 27 May 2026 09:42:54 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779846181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8fHAP+dXRYZTfGDBp++y6CzrTTEWIHFIL88enGg73+U=;
	b=jlIwSpdlreKSpJiPJIJXN3tq/5wWkEDhReZkiz33cL2TG4g0BUmL8/wp5MBt85mFCMEHqw
	H/S9TlvOOE8WKvXtIuwl8/lDMkK+FtYRZbgES6thaBMrVzGG6M+eXviZGZBuZ2OQQ0JreJ
	yyB4VQJ8QZTG4xjO5Mx0BZYjSKNjuMc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Baoquan He <baoquan.he@linux.dev>
To: Youngjun Park <youngjun.park@lge.com>
Cc: akpm@linux-foundation.org, chrisl@kernel.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	kasong@tencent.com, hannes@cmpxchg.org, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, shikemeng@huaweicloud.com, nphamcs@gmail.com,
	bhe@redhat.com, baohua@kernel.org, gunho.lee@lge.com,
	taejoon.song@lge.com, hyungjun.cho@lge.com, mkoutny@suse.com,
	baver.bae@lge.com, matia.kim@lge.com
Subject: Re: [PATCH v6 4/4] mm: swap: filter swap allocation by memcg tier
 mask
Message-ID: <ahZMHmMbhnNPspQj@MiWiFi-R3L-srv>
References: <20260421055323.940344-1-youngjun.park@lge.com>
 <20260421055323.940344-5-youngjun.park@lge.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421055323.940344-5-youngjun.park@lge.com>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16328-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,kvack.org,vger.kernel.org,tencent.com,cmpxchg.org,linux.dev,huaweicloud.com,gmail.com,redhat.com,lge.com,suse.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baoquan.he@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.dev:dkim,lge.com:email]
X-Rspamd-Queue-Id: 044045DE550
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 04/21/26 at 02:53pm, Youngjun Park wrote:
> Apply memcg tier effective mask during swap slot allocation to
> enforce per-cgroup swap tier restrictions.
> 
> In the fast path, check the percpu cached swap_info's tier_mask
> against the folio's effective mask. If it does not match, fall
> through to the slow path. In the slow path, skip swap devices
> whose tier_mask is not covered by the folio's effective mask.
> 
> This works correctly when there is only one non-rotational
> device in the system and no devices share the same priority.
> However, there are known limitations:
> 
>  - When non-rotational devices are distributed across multiple
>    tiers, and different memcgs are configured to use those
>    distinct tiers, they may constantly overwrite the shared
>    percpu swap cache. This cache thrashing leads to frequent
>    fast path misses.
> 
>  - Combined with the above issue, if same-priority devices exist
>    among them, a percpu cache miss (overwritten by another memcg)
>    forces the allocator to round-robin to the next device
>    prematurely, even if the current cluster is not fully
>    exhausted.
> 
> These edge cases do not affect the primary use case of
> directing swap traffic per cgroup. Further optimization is
> planned for future work.
> 
> Signed-off-by: Youngjun Park <youngjun.park@lge.com>
> ---
>  mm/swapfile.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index d5abc831cde7..8734e5d26b08 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1352,15 +1352,22 @@ static bool swap_alloc_fast(struct folio *folio)
>  	struct swap_cluster_info *ci;
>  	struct swap_info_struct *si;
>  	unsigned int offset;
> +	int mask = folio_tier_effective_mask(folio);
>  
>  	/*
>  	 * Once allocated, swap_info_struct will never be completely freed,
>  	 * so checking it's liveness by get_swap_device_info is enough.
>  	 */
>  	si = this_cpu_read(percpu_swap_cluster.si[order]);
> +	if (!si || !swap_tiers_mask_test(si->tier_mask, mask) ||
> +		!get_swap_device_info(si))
> +		return false;
> +
>  	offset = this_cpu_read(percpu_swap_cluster.offset[order]);
> -	if (!si || !offset || !get_swap_device_info(si))
> +	if (!offset) {
> +		put_swap_device(si);
>  		return false;
> +	}

The whole patch looks good to me except of one nitpick. Is it a lille
cleaner with below tiny adjustment?

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 2864cd8c2da9..cdf453bf6b80 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1359,15 +1359,12 @@ static bool swap_alloc_fast(struct folio *folio)
 	 * so checking it's liveness by get_swap_device_info is enough.
 	 */
 	si = this_cpu_read(percpu_swap_cluster.si[order]);
-	if (!si || !swap_tiers_mask_test(si->tier_mask, mask) ||
-		!get_swap_device_info(si))
+	if (!si || !swap_tiers_mask_test(si->tier_mask, mask))
 		return false;
 
 	offset = this_cpu_read(percpu_swap_cluster.offset[order]);
-	if (!offset) {
-		put_swap_device(si);
+	if (!offset || !get_swap_device_info(si))
 		return false;
-	}
 
 	ci = swap_cluster_lock(si, offset);
 	if (cluster_is_usable(ci, order)) {

>  
>  	ci = swap_cluster_lock(si, offset);
>  	if (cluster_is_usable(ci, order)) {
> @@ -1379,10 +1386,14 @@ static bool swap_alloc_fast(struct folio *folio)
>  static void swap_alloc_slow(struct folio *folio)
>  {
>  	struct swap_info_struct *si, *next;
> +	int mask = folio_tier_effective_mask(folio);
>  
>  	spin_lock(&swap_avail_lock);
>  start_over:
>  	plist_for_each_entry_safe(si, next, &swap_avail_head, avail_list) {
> +		if (!swap_tiers_mask_test(si->tier_mask, mask))
> +			continue;
> +
>  		/* Rotate the device and switch to a new cluster */
>  		plist_requeue(&si->avail_list, &swap_avail_head);
>  		spin_unlock(&swap_avail_lock);
> -- 
> 2.34.1
> 

