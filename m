Return-Path: <cgroups+bounces-7908-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAD3AA3BE0
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 01:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3D271BC1296
	for <lists+cgroups@lfdr.de>; Tue, 29 Apr 2025 23:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4803C30;
	Tue, 29 Apr 2025 23:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CJCd6vVv"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167762DAF8C
	for <cgroups@vger.kernel.org>; Tue, 29 Apr 2025 23:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745967902; cv=none; b=gi8A/Y7Ijp0Md5IwoRosGv8xHu6/Bq9smqwKrwZAS041Hv1pJ9Ckpe8FzjhE3JDKepqFxxOP7OtdDW0uqU3o1egSlpAor9MHq/u9pch/zxVPQ87ksNKYgBFiIbUDnR6Lwfzb+n8+YsQCD6uwXKYsxkX17KAB23uz8cLD+TAzKqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745967902; c=relaxed/simple;
	bh=kNpHfcQPDo+Dwyzi8dvG+NXgW53MJezi2FuhTG11jW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FA9ubyTmvX2CM2cTmmhQtXVVfZgb0aPRpPaN70llMq5AUYEg4VPVvFqtehNJhSdxNewpu1lDKAGCuZq24MbXrueZWajZpESquJV38K+VJYy7diCH9tzyYCrYOfbsQpNPVaixI3b2eMoEX+Cx+ACXd09fzqjo3ddCVjkGP+0mZ4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CJCd6vVv; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745967896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nbvCkVhHHtDcKqUC2DWDg/6KEw2udjRnrOYkfHNgmcQ=;
	b=CJCd6vVvXZmXfHc16o6jHtkjQhqPmzqlTLuls9wv21E9hSk5pLIRwuOpgLHAUdkr/xPWcd
	YcTswv8gGCM1Yzmbh01N3laHDwhpOTiw6sGCXQu1zWaXvJcc+GAOhT5P6u74GEev34ey9n
	DoqFyl9jm8SW2DIYAreOcNHzQRvsdqI=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH 1/4] memcg: simplify consume_stock
Date: Tue, 29 Apr 2025 16:04:25 -0700
Message-ID: <20250429230428.1935619-2-shakeel.butt@linux.dev>
In-Reply-To: <20250429230428.1935619-1-shakeel.butt@linux.dev>
References: <20250429230428.1935619-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The consume_stock() does not need to check gfp_mask for spinning and can
simply trylock the local lock to decide to proceed or fail. No need to
spin at all for local lock.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memcontrol.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 650fe4314c39..40d0838d88bc 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1804,16 +1804,14 @@ static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
  * consume_stock: Try to consume stocked charge on this cpu.
  * @memcg: memcg to consume from.
  * @nr_pages: how many pages to charge.
- * @gfp_mask: allocation mask.
  *
- * The charges will only happen if @memcg matches the current cpu's memcg
- * stock, and at least @nr_pages are available in that stock.  Failure to
- * service an allocation will refill the stock.
+ * Consume the cached charge if enough nr_pages are present otherwise return
+ * failure. Also return failure for charge request larger than
+ * MEMCG_CHARGE_BATCH or if the local lock is already taken.
  *
  * returns true if successful, false otherwise.
  */
-static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages,
-			  gfp_t gfp_mask)
+static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 {
 	struct memcg_stock_pcp *stock;
 	uint8_t stock_pages;
@@ -1821,12 +1819,8 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages,
 	bool ret = false;
 	int i;
 
-	if (nr_pages > MEMCG_CHARGE_BATCH)
-		return ret;
-
-	if (gfpflags_allow_spinning(gfp_mask))
-		local_lock_irqsave(&memcg_stock.stock_lock, flags);
-	else if (!local_trylock_irqsave(&memcg_stock.stock_lock, flags))
+	if (nr_pages > MEMCG_CHARGE_BATCH ||
+	    !local_trylock_irqsave(&memcg_stock.stock_lock, flags))
 		return ret;
 
 	stock = this_cpu_ptr(&memcg_stock);
@@ -2329,7 +2323,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	unsigned long pflags;
 
 retry:
-	if (consume_stock(memcg, nr_pages, gfp_mask))
+	if (consume_stock(memcg, nr_pages))
 		return 0;
 
 	if (!gfpflags_allow_spinning(gfp_mask))
-- 
2.47.1


