Return-Path: <cgroups+bounces-5285-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 810929B19D4
	for <lists+cgroups@lfdr.de>; Sat, 26 Oct 2024 18:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD4A61C2131A
	for <lists+cgroups@lfdr.de>; Sat, 26 Oct 2024 16:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7FF13CA93;
	Sat, 26 Oct 2024 16:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JwppYDbH"
X-Original-To: cgroups@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF746168BE
	for <cgroups@vger.kernel.org>; Sat, 26 Oct 2024 16:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729960652; cv=none; b=sgOL8Er7XTml+hRvewnSnA6UVKERbvbMy7RExp64modNJRIxuXso36yrDdkoDnJ26RQkTKTlshTYfDiD6+cynxDAd0pCWbdnKRN0TwsPk4fJ/5qg7CVNSAtXhlc0prEHcNEX+oNF/rw0ukP11eNkWNBTG0xih4n3Dv20a5Dvcu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729960652; c=relaxed/simple;
	bh=JcpoZk3RoHBHOWSG0QF+MLHrkxvWSoXtLhQCXhkoulg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kv3vNTsRSH+smS6sDb0twiWpj69eSHiGi3A7xN/WHgIpjYMB4r/kq/GU7jC+9ODg0QxUyznmBpWTcX7J7D13U8oQacdL5rb/KZnbwJzalNH/Od9+qrKyqinGCXhy5h+K78x1C5/6ArdkRoU6/el5knOn+NSxAE46rVPPZjk3G6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JwppYDbH; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729960647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kDTFYQ4jfbUxBCetm9ZFD4nERqP1KIxH9DYbqDWNu3k=;
	b=JwppYDbH2Y4GmKniz7qVDqFGFp1tsToZx/rxO0MEc2PqpYqIqAAhWWcca8GGeF3aCjvw9q
	e2B5pQKYY4kcnmMwPOE2WBXhtzF9a4jmTIGUkmGP4RqDiDN6Nl49PuKHBc2UOZeAtx7GNE
	E8+8oNOLfm9juAowpJAw1mYzw11TBc4=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>,
	Yu Zhao <yuzhao@google.com>
Subject: [PATCH v2] memcg: workingset: remove folio_memcg_rcu usage
Date: Sat, 26 Oct 2024 09:37:07 -0700
Message-ID: <20241026163707.2479526-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The function workingset_activation() is called from
folio_mark_accessed() with the guarantee that the given folio can not be
freed under us in workingset_activation(). In addition, the association
of the folio and its memcg can not be broken here because charge
migration is no more. There is no need to use folio_memcg_rcu. Simply
use folio_memcg_charged() because that is what this function cares
about.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Suggested-by: Yu Zhao <yuzhao@google.com>
---
Andrew, please put this patch after charge migration deprecation series.

Changes since v1:
- Fix for mem_cgroup_disabled(). (Yu Zhao)

 include/linux/memcontrol.h | 35 -----------------------------------
 mm/workingset.c            | 14 ++------------
 2 files changed, 2 insertions(+), 47 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 932534291ca2..89a1e9f10e1b 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -443,35 +443,6 @@ static inline bool folio_memcg_charged(struct folio *folio)
 	return __folio_memcg(folio) != NULL;
 }
 
-/**
- * folio_memcg_rcu - Locklessly get the memory cgroup associated with a folio.
- * @folio: Pointer to the folio.
- *
- * This function assumes that the folio is known to have a
- * proper memory cgroup pointer. It's not safe to call this function
- * against some type of folios, e.g. slab folios or ex-slab folios.
- *
- * Return: A pointer to the memory cgroup associated with the folio,
- * or NULL.
- */
-static inline struct mem_cgroup *folio_memcg_rcu(struct folio *folio)
-{
-	unsigned long memcg_data = READ_ONCE(folio->memcg_data);
-
-	VM_BUG_ON_FOLIO(folio_test_slab(folio), folio);
-
-	if (memcg_data & MEMCG_DATA_KMEM) {
-		struct obj_cgroup *objcg;
-
-		objcg = (void *)(memcg_data & ~OBJEXTS_FLAGS_MASK);
-		return obj_cgroup_memcg(objcg);
-	}
-
-	WARN_ON_ONCE(!rcu_read_lock_held());
-
-	return (struct mem_cgroup *)(memcg_data & ~OBJEXTS_FLAGS_MASK);
-}
-
 /*
  * folio_memcg_check - Get the memory cgroup associated with a folio.
  * @folio: Pointer to the folio.
@@ -1084,12 +1055,6 @@ static inline struct mem_cgroup *folio_memcg(struct folio *folio)
 	return NULL;
 }
 
-static inline struct mem_cgroup *folio_memcg_rcu(struct folio *folio)
-{
-	WARN_ON_ONCE(!rcu_read_lock_held());
-	return NULL;
-}
-
 static inline struct mem_cgroup *folio_memcg_check(struct folio *folio)
 {
 	return NULL;
diff --git a/mm/workingset.c b/mm/workingset.c
index 4b58ef535a17..a4705e196545 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -591,22 +591,12 @@ void workingset_refault(struct folio *folio, void *shadow)
  */
 void workingset_activation(struct folio *folio)
 {
-	struct mem_cgroup *memcg;
-
-	rcu_read_lock();
 	/*
 	 * Filter non-memcg pages here, e.g. unmap can call
 	 * mark_page_accessed() on VDSO pages.
-	 *
-	 * XXX: See workingset_refault() - this should return
-	 * root_mem_cgroup even for !CONFIG_MEMCG.
 	 */
-	memcg = folio_memcg_rcu(folio);
-	if (!mem_cgroup_disabled() && !memcg)
-		goto out;
-	workingset_age_nonresident(folio_lruvec(folio), folio_nr_pages(folio));
-out:
-	rcu_read_unlock();
+	if (mem_cgroup_disabled() || folio_memcg_charged(folio))
+		workingset_age_nonresident(folio_lruvec(folio), folio_nr_pages(folio));
 }
 
 /*
-- 
2.43.5


