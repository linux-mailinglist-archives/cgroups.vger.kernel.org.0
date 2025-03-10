Return-Path: <cgroups+bounces-6951-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC957A5AB60
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 00:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2554D172BAB
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 23:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29059214A9A;
	Mon, 10 Mar 2025 23:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nvWTMrbr"
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17601F872A
	for <cgroups@vger.kernel.org>; Mon, 10 Mar 2025 23:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741648218; cv=none; b=SfQKOn3+Ikx4ZldtAppCS8Ecc0kQg6C0M7toTnikU8Zasxpl4h/yVdx3ymz357Rhnt678G0/96iv9nFoBLo5D0jYdlTNskdr6YpQs+19b3lAUmLJ2gV4qOewt0kONwileN8UiMoNiU2LfCA3d1mWR3DKHaxoiRHJrMQOd/Khfxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741648218; c=relaxed/simple;
	bh=B0wsxLRu96GQzUnD7p0MliFsrmkAdovcJXpgr7MXZWc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DudRs93Y7e5SE41iQBCEHfGyeoWYeYqvx8W04naAOTQsHtdqbKW6mLV/LW76fFh/7OygpJ/7uKmwKBMyTAPQjQ9sQxHNRoGyjC9NV+5i7H0yOb4RajjRFZKBMlOF7xrTwnXWQBwAwFYi4OTKNooKRq+5etuZ32MGpeeecFenJSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nvWTMrbr; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741648204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=G/HCAo/u+1dwdadYxdqNt5UgFUYiXAtMaH9rWhYyOUw=;
	b=nvWTMrbrSy3vyrHVRQjNOsw5HFvNCWN5XnIBGK9DKyMeWP1Tupy2DYJRgPjF5UPUL2806b
	LcdTNMCkBHDbnGwmzwAGZ46EqnY75LZS5JGO30XpyYCZ9eHmWi+ZzDo3b/zgw6IeEgjaVp
	EeF6ma+K94mkBgWcKZ2wFvw9uMG6Ta8=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>,
	stable@vger.kernel.org
Subject: [PATCH] memcg: drain obj stock on cpu hotplug teardown
Date: Mon, 10 Mar 2025 16:09:34 -0700
Message-ID: <20250310230934.2913113-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Currently on cpu hotplug teardown, only memcg stock is drained but we
need to drain the obj stock as well otherwise we will miss the stats
accumulated on the target cpu as well as the nr_bytes cached. The stats
include MEMCG_KMEM, NR_SLAB_RECLAIMABLE_B & NR_SLAB_UNRECLAIMABLE_B. In
addition we are leaking reference to struct obj_cgroup object.

Fixes: bf4f059954dc ("mm: memcg/slab: obj_cgroup API")
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Cc: <stable@vger.kernel.org>
---
 mm/memcontrol.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4de6acb9b8ec..59dcaf6a3519 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1921,9 +1921,18 @@ void drain_all_stock(struct mem_cgroup *root_memcg)
 static int memcg_hotplug_cpu_dead(unsigned int cpu)
 {
 	struct memcg_stock_pcp *stock;
+	struct obj_cgroup *old;
+	unsigned long flags;
 
 	stock = &per_cpu(memcg_stock, cpu);
+
+	/* drain_obj_stock requires stock_lock */
+	local_lock_irqsave(&memcg_stock.stock_lock, flags);
+	old = drain_obj_stock(stock);
+	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+
 	drain_stock(stock);
+	obj_cgroup_put(old);
 
 	return 0;
 }
-- 
2.47.1


