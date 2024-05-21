Return-Path: <cgroups+bounces-2972-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B73E8CAE90
	for <lists+cgroups@lfdr.de>; Tue, 21 May 2024 14:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CF091F21509
	for <lists+cgroups@lfdr.de>; Tue, 21 May 2024 12:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678705337C;
	Tue, 21 May 2024 12:51:04 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60D012E6A
	for <cgroups@vger.kernel.org>; Tue, 21 May 2024 12:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716295864; cv=none; b=qKIHUHz1g0FYHo7ayqdijFczIHyywhff9uQofmARU2RfpJ7disTKFwl7tp6xBGufLZD00BTNR1o6xLxO24pDTvmrvwpuT8INLxOP9pN6lbIRe4e0AN3V8jA/hni5GH29H0sYIFQ6ahcV0ToGAdNNRD4dYzpzpWWexjWvlGs2qXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716295864; c=relaxed/simple;
	bh=iFhpxbsZXML7gYcki62aQ1d/rmHrpv53G8WlR31lmyo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JcDLR91UpkvxI+q4Uz+fjoQNas3FFMx9kY3f5cBtTajyLcI3sfhw+tlkUrHQZfhbQlg3lgqs6IX6v8VyUXEgGIOy9qruo6CzgTODr+rji4OQcEV/5V/Rp6caWRjldsnW7IgxWDZADSAH1VWLa6u2c41MSSwiTRGyAcLJOU/4UA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VkDjQ0Tkcz1S6GJ;
	Tue, 21 May 2024 20:47:22 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id E5D2918007E;
	Tue, 21 May 2024 20:50:58 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 21 May 2024 20:50:58 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt
	<shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
	<linux-mm@kvack.org>, <cgroups@vger.kernel.org>, Kefeng Wang
	<wangkefeng.wang@huawei.com>
Subject: [PATCH] mm: memcontrol: remove page_memcg()
Date: Tue, 21 May 2024 21:15:56 +0800
Message-ID: <20240521131556.142176-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm100001.china.huawei.com (7.185.36.93)

The page_memcg() only called by mod_memcg_page_state(), so squash it to
cleanup page_memcg().

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/memcontrol.h | 14 ++------------
 mm/memcontrol.c            |  2 +-
 2 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 030d34e9d117..8abc70cc7219 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -443,11 +443,6 @@ static inline struct mem_cgroup *folio_memcg(struct folio *folio)
 	return __folio_memcg(folio);
 }
 
-static inline struct mem_cgroup *page_memcg(struct page *page)
-{
-	return folio_memcg(page_folio(page));
-}
-
 /**
  * folio_memcg_rcu - Locklessly get the memory cgroup associated with a folio.
  * @folio: Pointer to the folio.
@@ -1014,7 +1009,7 @@ static inline void mod_memcg_page_state(struct page *page,
 		return;
 
 	rcu_read_lock();
-	memcg = page_memcg(page);
+	memcg = folio_memcg(page_folio(page));
 	if (memcg)
 		mod_memcg_state(memcg, idx, val);
 	rcu_read_unlock();
@@ -1133,11 +1128,6 @@ static inline struct mem_cgroup *folio_memcg(struct folio *folio)
 	return NULL;
 }
 
-static inline struct mem_cgroup *page_memcg(struct page *page)
-{
-	return NULL;
-}
-
 static inline struct mem_cgroup *folio_memcg_rcu(struct folio *folio)
 {
 	WARN_ON_ONCE(!rcu_read_lock_held());
@@ -1636,7 +1626,7 @@ static inline void unlock_page_lruvec_irqrestore(struct lruvec *lruvec,
 	spin_unlock_irqrestore(&lruvec->lru_lock, flags);
 }
 
-/* Test requires a stable page->memcg binding, see page_memcg() */
+/* Test requires a stable page->memcg binding, see folio_memcg() */
 static inline bool folio_matches_lruvec(struct folio *folio,
 		struct lruvec *lruvec)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 54070687aad2..72833f6f0944 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3811,7 +3811,7 @@ void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
 #endif /* CONFIG_MEMCG_KMEM */
 
 /*
- * Because page_memcg(head) is not set on tails, set it now.
+ * Because folio_memcg(head) is not set on tails, set it now.
  */
 void split_page_memcg(struct page *head, int old_order, int new_order)
 {
-- 
2.41.0


