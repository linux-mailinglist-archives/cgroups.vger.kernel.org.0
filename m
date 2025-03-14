Return-Path: <cgroups+bounces-7060-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2100A6091D
	for <lists+cgroups@lfdr.de>; Fri, 14 Mar 2025 07:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71D633AB68E
	for <lists+cgroups@lfdr.de>; Fri, 14 Mar 2025 06:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40C519C569;
	Fri, 14 Mar 2025 06:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kEdIKGlD"
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBAB199249
	for <cgroups@vger.kernel.org>; Fri, 14 Mar 2025 06:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741932956; cv=none; b=LM8wlmwpXlW4R8Qk4sdJnEkPpwXh3uL+K46S8U4NFIOz8+oA2K11cQ2KC9CVzP8l9Rj2oSWGHHtfihI6PZBKKtgY47lhYl/3LiVnQD8fALOj4CH+q/APZF9zv46ctPb1kknqygrjgI+tqGk7sBbrK7B35hPl8C9huA/BofqHF9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741932956; c=relaxed/simple;
	bh=0zD7s3jtU8T0QnDwNFPVi23rov59ZSfE8r2niGUwTpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kZxb2DfukZSGU9d+iNBF+9P23+KnWqv5VFmyNYknVZMzRRZuiLt1wjrkyO6V89XtygLSO8ehPwGvrfxEDUhMKLadFD95r7D7YxWgP1rmPsnUIjjSFC6IeHFHOxkLlLLwSVw8rmLmAHEx0+r+kybUE6rm6i1LBV3WB8CCMRSOAcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kEdIKGlD; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741932952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MpyYup93rtdpPqOazjOWpUMNns5c+BBQgx0og/O/C6c=;
	b=kEdIKGlDaWDMSsPANjgdCoWUUq9Aqr4mi5OYIz7rsALJ4sjMBJg3BQ1uxepzQ2QiLXHTeS
	rgI7A3Z1vT15uePUZX+pSwvZjlpzip9/HvgWyN0cmiA5TbQ+zAeduhWHSB0dERoJH14Q2S
	Fot0pjHwPM3UuiKee4avcxnTc57xAL0=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [RFC PATCH 09/10] memcg: trylock stock for objcg
Date: Thu, 13 Mar 2025 23:15:10 -0700
Message-ID: <20250314061511.1308152-10-shakeel.butt@linux.dev>
In-Reply-To: <20250314061511.1308152-1-shakeel.butt@linux.dev>
References: <20250314061511.1308152-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

To make objcg stock functions work without disabling irq, we need to
convert those function to use localtry_trylock_irqsave() instead of
localtry_lock_irqsave(). This patch for now just does the conversion and
later patch will eliminate the irq disabling code.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memcontrol.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c803d2f5e322..ba5d004049d3 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2764,7 +2764,11 @@ static void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 	unsigned long flags;
 	int *bytes;
 
-	localtry_lock_irqsave(&memcg_stock.stock_lock, flags);
+	if (!localtry_trylock_irqsave(&memcg_stock.stock_lock, flags)) {
+		__mod_objcg_mlstate(objcg, pgdat, idx, nr);
+		return;
+	}
+
 	stock = this_cpu_ptr(&memcg_stock);
 
 	/*
@@ -2822,7 +2826,8 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
 	unsigned long flags;
 	bool ret = false;
 
-	localtry_lock_irqsave(&memcg_stock.stock_lock, flags);
+	if (!localtry_trylock_irqsave(&memcg_stock.stock_lock, flags))
+		return ret;
 
 	stock = this_cpu_ptr(&memcg_stock);
 	if (objcg == READ_ONCE(stock->cached_objcg) && stock->nr_bytes >= nr_bytes) {
@@ -2918,7 +2923,10 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 	unsigned long flags;
 	unsigned int nr_pages = 0;
 
-	localtry_lock_irqsave(&memcg_stock.stock_lock, flags);
+	if (!localtry_trylock_irqsave(&memcg_stock.stock_lock, flags)) {
+		atomic_add(nr_bytes, &objcg->nr_charged_bytes);
+		return;
+	}
 
 	stock = this_cpu_ptr(&memcg_stock);
 	if (READ_ONCE(stock->cached_objcg) != objcg) { /* reset if necessary */
-- 
2.47.1


