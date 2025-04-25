Return-Path: <cgroups+bounces-7842-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C1AA9D2D4
	for <lists+cgroups@lfdr.de>; Fri, 25 Apr 2025 22:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71AB69C4332
	for <lists+cgroups@lfdr.de>; Fri, 25 Apr 2025 20:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5978221D90;
	Fri, 25 Apr 2025 20:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BIk2XVRN"
X-Original-To: cgroups@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E648B218E9F
	for <cgroups@vger.kernel.org>; Fri, 25 Apr 2025 20:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745612330; cv=none; b=ZXKrRGxyKKkKJIIarOwYinbBR4SFFCLxpDht2wnmraMXHI/aAcjkKCrLODgdp7yfzZjgS7bwoq5XKLhVdKXqlHWWLghJUnXYwZSCBSBoLpvekdk+DMaXMdeHP6M0y59TOVJn7y5awBQkmFjuqsDR9gAUXznD5BUpJW/2l9/Sv/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745612330; c=relaxed/simple;
	bh=J+AK7wunnpEB2JMYQXv1n/WSaKOAkcue33/P70CTFH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rEbT7ZjFEyeq1WyJKXTnxxz4K/mGY6jBw3ioOdVbzTaRU/G5ai5hBKOowFzCDiQhkQp1mDoidIovG+joSFXzTRLIIfohRTKv6U2HVdesvy6HlpkdB4hJ39D4r33ZtoyugIIY1SzyE7UBq0U7ZpraiRwX7JsAN5CUnGt0pqMiwBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BIk2XVRN; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 25 Apr 2025 13:18:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745612324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FNLMf/5dW9WvMGj/QQPYDD8kv32KN5l1w2IaTPelp/4=;
	b=BIk2XVRNb4D0juBRNjJUrBrAmiC3GfLU66rJWolBEHCXWioRWFqLyuvixVTkjjMXiykt8D
	nZGs1le6vWy3J+gO2LBm/ZmpoY6yT/enKU6OryPyHe5nL9g7IvtIc7Vq/bbRnl4eHc6YDS
	u+S7cVpqd9DnGVX2fpLUV6g5u94/34U=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Vlastimil Babka <vbabka@suse.cz>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Soheil Hassas Yeganeh <soheil@google.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: multi-memcg percpu charge cache
Message-ID: <as5cdsm4lraxupg3t6onep2ixql72za25hvd4x334dsoyo4apr@zyzl4vkuevuv>
References: <20250416180229.2902751-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416180229.2902751-1-shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT

Hi Andrew,

Another fix for this patch. Basically simplification of refill_stock and
avoiding multiple cached entries of a memcg.

From 6f6f7736799ad8ca5fee48eca7b7038f6c9bb5b9 Mon Sep 17 00:00:00 2001
From: Shakeel Butt <shakeel.butt@linux.dev>
Date: Fri, 25 Apr 2025 13:10:43 -0700
Subject: [PATCH] memcg: multi-memcg percpu charge cache - fix 2

Simplify refill_stock by avoiding goto and doing the operations inline
and make sure the given memcg is not cached multiple times.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memcontrol.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 997e2da5d2ca..9dfdbb2fcccc 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1907,7 +1907,8 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 	struct mem_cgroup *cached;
 	uint8_t stock_pages;
 	unsigned long flags;
-	bool evict = true;
+	bool success = false;
+	int empty_slot = -1;
 	int i;
 
 	/*
@@ -1931,26 +1932,28 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 
 	stock = this_cpu_ptr(&memcg_stock);
 	for (i = 0; i < NR_MEMCG_STOCK; ++i) {
-again:
 		cached = READ_ONCE(stock->cached[i]);
-		if (!cached) {
-			css_get(&memcg->css);
-			WRITE_ONCE(stock->cached[i], memcg);
-		}
-		if (!cached || memcg == READ_ONCE(stock->cached[i])) {
+		if (!cached && empty_slot == -1)
+			empty_slot = i;
+		if (memcg == READ_ONCE(stock->cached[i])) {
 			stock_pages = READ_ONCE(stock->nr_pages[i]) + nr_pages;
 			WRITE_ONCE(stock->nr_pages[i], stock_pages);
 			if (stock_pages > MEMCG_CHARGE_BATCH)
 				drain_stock(stock, i);
-			evict = false;
+			success = true;
 			break;
 		}
 	}
 
-	if (evict) {
-		i = get_random_u32_below(NR_MEMCG_STOCK);
-		drain_stock(stock, i);
-		goto again;
+	if (!success) {
+		i = empty_slot;
+		if (i == -1) {
+			i = get_random_u32_below(NR_MEMCG_STOCK);
+			drain_stock(stock, i);
+		}
+		css_get(&memcg->css);
+		WRITE_ONCE(stock->cached[i], memcg);
+		WRITE_ONCE(stock->nr_pages[i], stock_pages);
 	}
 
 	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
-- 
2.47.1


