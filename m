Return-Path: <cgroups+bounces-4184-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE8894D567
	for <lists+cgroups@lfdr.de>; Fri,  9 Aug 2024 19:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BB4C282B96
	for <lists+cgroups@lfdr.de>; Fri,  9 Aug 2024 17:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FB14DA04;
	Fri,  9 Aug 2024 17:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G20TQ2+p"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA975A4D5;
	Fri,  9 Aug 2024 17:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723224402; cv=none; b=l/AFNUauSzb/TPy16brxJQpu4aBuKfnC3Gw/jqnz6UZsoJFxnfFLjxl7O8ZoR1isqn1Us5cc3mrTx0wWlfU0Yli1Juky/TFLV0jOOBLZ9z+v/oY7jgB5CQNxRAiHXuOUp2j4KtzqxAypYrTDeGT1AvMmH05g+ON/umwjSXhWUvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723224402; c=relaxed/simple;
	bh=Y9AqZWGd8ifzezhtCypSmtKu6I9N0YJ4qBpfG6DjUMw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WCHidY4Nrbngn3IC2+tlLHbid1aYCJZ1bNkDmRwyauW+KcIAXhyCEbFkHQvmM88XqHCWUykgWbXyQMkXXn5UBOze9E8rKPgj2JvqKLb/L+a3gx4NnBaARr5eDFpWEUV5eZo7EuwXWQInrjaA3QviMHK4uGwBMZi6zt9mLK7XH/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G20TQ2+p; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723224396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4iM0sefc3D7BN1ZfyJuESRluKUUBy69Kzbm9ZY4Fy3M=;
	b=G20TQ2+pPsPGtYkq8R7r38M9mMpyGGn6n276jn3JI1ZBVxvkOU5QGK9WvKp0ioHSZ+boXo
	Sv7Gu5thZjvb35Jh4i2klPZasx1mouiXlypVYRheOY9kUwUC/vGw7qs1xTDlKYswOxyHLT
	zTFBdkng29rTwZaGOhIMbkqBm5ZR5UE=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>,
	cgroups@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] memcg: replace memcg ID idr with xarray
Date: Fri,  9 Aug 2024 10:26:18 -0700
Message-ID: <20240809172618.2946790-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

At the moment memcg IDs are managed through IDR which requires external
synchronization mechanisms and makes the allocation code a bit awkward.
Let's switch to xarray and make the code simpler.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memcontrol.c | 34 +++++++---------------------------
 1 file changed, 7 insertions(+), 27 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e1ffd2950393..b8e6b98485c6 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3363,29 +3363,12 @@ static void memcg_wb_domain_size_changed(struct mem_cgroup *memcg)
  */
 
 #define MEM_CGROUP_ID_MAX	((1UL << MEM_CGROUP_ID_SHIFT) - 1)
-static DEFINE_IDR(mem_cgroup_idr);
-static DEFINE_SPINLOCK(memcg_idr_lock);
-
-static int mem_cgroup_alloc_id(void)
-{
-	int ret;
-
-	idr_preload(GFP_KERNEL);
-	spin_lock(&memcg_idr_lock);
-	ret = idr_alloc(&mem_cgroup_idr, NULL, 1, MEM_CGROUP_ID_MAX + 1,
-			GFP_NOWAIT);
-	spin_unlock(&memcg_idr_lock);
-	idr_preload_end();
-	return ret;
-}
+static DEFINE_XARRAY_ALLOC1(mem_cgroup_ids);
 
 static void mem_cgroup_id_remove(struct mem_cgroup *memcg)
 {
 	if (memcg->id.id > 0) {
-		spin_lock(&memcg_idr_lock);
-		idr_remove(&mem_cgroup_idr, memcg->id.id);
-		spin_unlock(&memcg_idr_lock);
-
+		xa_erase(&mem_cgroup_ids, memcg->id.id);
 		memcg->id.id = 0;
 	}
 }
@@ -3420,7 +3403,7 @@ static inline void mem_cgroup_id_put(struct mem_cgroup *memcg)
 struct mem_cgroup *mem_cgroup_from_id(unsigned short id)
 {
 	WARN_ON_ONCE(!rcu_read_lock_held());
-	return idr_find(&mem_cgroup_idr, id);
+	return xa_load(&mem_cgroup_ids, id);
 }
 
 #ifdef CONFIG_SHRINKER_DEBUG
@@ -3519,11 +3502,10 @@ static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
 	if (!memcg)
 		return ERR_PTR(error);
 
-	memcg->id.id = mem_cgroup_alloc_id();
-	if (memcg->id.id < 0) {
-		error = memcg->id.id;
+	error = xa_alloc(&mem_cgroup_ids, &memcg->id.id, NULL,
+			 XA_LIMIT(1, MEM_CGROUP_ID_MAX), GFP_KERNEL);
+	if (error)
 		goto fail;
-	}
 
 	memcg->vmstats = kzalloc(sizeof(struct memcg_vmstats),
 				 GFP_KERNEL_ACCOUNT);
@@ -3664,9 +3646,7 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 	 * publish it here at the end of onlining. This matches the
 	 * regular ID destruction during offlining.
 	 */
-	spin_lock(&memcg_idr_lock);
-	idr_replace(&mem_cgroup_idr, memcg, memcg->id.id);
-	spin_unlock(&memcg_idr_lock);
+	xa_store(&mem_cgroup_ids, memcg->id.id, memcg, GFP_KERNEL);
 
 	return 0;
 offline_kmem:
-- 
2.43.5


