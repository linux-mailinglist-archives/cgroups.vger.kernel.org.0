Return-Path: <cgroups+bounces-16018-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLL0DE/iCWo6twQAu9opvQ
	(envelope-from <cgroups+bounces-16018-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 17 May 2026 17:44:15 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDA6562172
	for <lists+cgroups@lfdr.de>; Sun, 17 May 2026 17:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D6A1304C04A
	for <lists+cgroups@lfdr.de>; Sun, 17 May 2026 15:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286143C13F8;
	Sun, 17 May 2026 15:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4d9ocNS"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7276F3BED76;
	Sun, 17 May 2026 15:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779032389; cv=none; b=SY2FvDpTjNmSFLQknZjPs63NfjNqvD1Tt7zXsyDjQNq8GbgzGF91naGeIHUvJVbfmOTR74ziAM4jkMezTNwj5nSeS/WEAuZYOFUr5LY/TeNPh+EPRFosuO7zOreDVq5LuzcYfalbG8t1bNSdcW6/Vgq6HR1Tc13zLzdt3rHyet4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779032389; c=relaxed/simple;
	bh=ufU1ySsOqiRZPnCHz7wte/G4BO/nmQmUUaeDl7sofnQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XL4QwcC71yrYd1sLLq2ZJmIfoYl7e7Lc5l6T/0niAovOHq9wXCWca/ac8js4s1VB8JFGaTHW1yj8TWyWGeVv6YoL114XEjkWvPWwD7YStmXl58KHKezLmQSQfW6uHO8jtxdidUy93490CvK73mHW/BJz1xZRQRT0Ti846R3U+Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4d9ocNS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4B0B2C2BCB8;
	Sun, 17 May 2026 15:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779032389;
	bh=ufU1ySsOqiRZPnCHz7wte/G4BO/nmQmUUaeDl7sofnQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=i4d9ocNSV+J2qEOZBzsNaaBcr1rrZV78Pzms/udoUFzqNM/dHWNtoGEKRooDbhjKn
	 9bdwZ26RQ6qDr5Nfgaao/o4aM/0/X68HzhqcUqWgbAg2SOCotz84w/+hdHu1smTq2N
	 LCA3xMEqd4iLsqQdMwQzsR0C5gQFei1Eu9qGGM5p+/tWUYmazvVmGV9c1OGK2mChyv
	 5rsohQR+L/aKNQAOeIcYoVdvu3eJRfBFe5bFdOUUmmW/TB0XKrIUeBD9/wViZ7r0W3
	 rLBNA88zt17t4LKVSfSrNSxwLZRwcGod906+px5oErBZbs3yl/ItfAvoE4NLdno70X
	 NMlKjCKxj5xHQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED5CCD4F4B;
	Sun, 17 May 2026 15:39:49 +0000 (UTC)
From: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>
Date: Sun, 17 May 2026 23:39:48 +0800
Subject: [PATCH v5 09/12] mm, swap: consolidate cluster allocation helpers
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260517-swap-table-p4-v5-9-88ae43e064c7@tencent.com>
References: <20260517-swap-table-p4-v5-0-88ae43e064c7@tencent.com>
In-Reply-To: <20260517-swap-table-p4-v5-0-88ae43e064c7@tencent.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>, 
 Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
 Baoquan He <bhe@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Youngjun Park <youngjun.park@lge.com>, 
 Chengming Zhou <chengming.zhou@linux.dev>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, linux-kernel@vger.kernel.org, 
 cgroups@vger.kernel.org, Kairui Song <kasong@tencent.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, Yosry Ahmed <yosry@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779032386; l=7205;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=c3oYSj0Wv0VB37K97Td0A16y0BTkJDC6ZCRW5Z0N+vc=;
 b=zqRQIF0gJ1NS70Y3n4NafR8BRy6VcNbWVCBT3V3wQlQir61v4EF1nqvCQihtd/BI6Arz34fXN
 /X7F3BMdUmBCuMh2dNHAb2GzYmlMa2rgpiG/Xai0f4fA0JlMYKPDPis
X-Developer-Key: i=kasong@tencent.com; a=ed25519;
 pk=kCdoBuwrYph+KrkJnrr7Sm1pwwhGDdZKcKrqiK8Y1mI=
X-Endpoint-Received: by B4 Relay for kasong@tencent.com/kasong-sign-tencent
 with auth_id=562
X-Original-From: Kairui Song <kasong@tencent.com>
Reply-To: kasong@tencent.com
X-Rspamd-Queue-Id: CFDA6562172
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16018-lists,cgroups=lfdr.de,kasong.tencent.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,nvidia.com,linux.alibaba.com,google.com,huaweicloud.com,gmail.com,redhat.com,cmpxchg.org,lge.com,linux.dev,vger.kernel.org,tencent.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[kasong@tencent.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tencent.com:email,tencent.com:mid,tencent.com:replyto]
X-Rspamd-Action: no action

From: Kairui Song <kasong@tencent.com>

Swap cluster table management is spread across several narrow
helpers. As a result, the allocation and fallback sequences are
open-coded in multiple places.

A few more per-cluster tables will be added soon, so avoid
duplicating these sequences per table type. Fold the existing
pairs into cluster-oriented helpers, and rename for consistency.

No functional change, only a few sanity checks are slightly adjusted.

Acked-by: Chris Li <chrisl@kernel.org>
Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swapfile.c | 110 ++++++++++++++++++++++++++--------------------------------
 1 file changed, 49 insertions(+), 61 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index c9c80ba9252b..7740ba99f87e 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -411,20 +411,7 @@ static inline unsigned int cluster_offset(struct swap_info_struct *si,
 	return cluster_index(si, ci) * SWAPFILE_CLUSTER;
 }
 
-static struct swap_table *swap_table_alloc(gfp_t gfp)
-{
-	struct folio *folio;
-
-	if (!SWP_TABLE_USE_PAGE)
-		return kmem_cache_zalloc(swap_table_cachep, gfp);
-
-	folio = folio_alloc(gfp | __GFP_ZERO, 0);
-	if (folio)
-		return folio_address(folio);
-	return NULL;
-}
-
-static void swap_table_free_folio_rcu_cb(struct rcu_head *head)
+static void swap_cluster_free_table_folio_rcu_cb(struct rcu_head *head)
 {
 	struct folio *folio;
 
@@ -432,15 +419,46 @@ static void swap_table_free_folio_rcu_cb(struct rcu_head *head)
 	folio_put(folio);
 }
 
-static void swap_table_free(struct swap_table *table)
+static void swap_cluster_free_table(struct swap_cluster_info *ci)
 {
+	struct swap_table *table;
+
+	table = (struct swap_table *)rcu_dereference_protected(ci->table, true);
+	if (!table)
+		return;
+
+	rcu_assign_pointer(ci->table, NULL);
 	if (!SWP_TABLE_USE_PAGE) {
 		kmem_cache_free(swap_table_cachep, table);
 		return;
 	}
 
 	call_rcu(&(folio_page(virt_to_folio(table), 0)->rcu_head),
-		 swap_table_free_folio_rcu_cb);
+		 swap_cluster_free_table_folio_rcu_cb);
+}
+
+static int swap_cluster_alloc_table(struct swap_cluster_info *ci, gfp_t gfp)
+{
+	struct swap_table *table = NULL;
+	struct folio *folio;
+
+	/* The cluster must be empty and not on any list during allocation. */
+	VM_WARN_ON_ONCE(ci->flags || !cluster_is_empty(ci));
+	if (rcu_access_pointer(ci->table))
+		return 0;
+
+	if (SWP_TABLE_USE_PAGE) {
+		folio = folio_alloc(gfp | __GFP_ZERO, 0);
+		if (folio)
+			table = folio_address(folio);
+	} else {
+		table = kmem_cache_zalloc(swap_table_cachep, gfp);
+	}
+	if (!table)
+		return -ENOMEM;
+
+	rcu_assign_pointer(ci->table, table);
+	return 0;
 }
 
 /*
@@ -471,27 +489,15 @@ static void swap_cluster_assert_empty(struct swap_cluster_info *ci,
 	WARN_ON_ONCE(nr == SWAPFILE_CLUSTER && ci->extend_table);
 }
 
-static void swap_cluster_free_table(struct swap_cluster_info *ci)
-{
-	struct swap_table *table;
-
-	/* Only empty cluster's table is allow to be freed  */
-	lockdep_assert_held(&ci->lock);
-	table = (void *)rcu_dereference_protected(ci->table, true);
-	rcu_assign_pointer(ci->table, NULL);
-
-	swap_table_free(table);
-}
-
 /*
  * Allocate swap table for one cluster. Attempt an atomic allocation first,
  * then fallback to sleeping allocation.
  */
 static struct swap_cluster_info *
-swap_cluster_alloc_table(struct swap_info_struct *si,
+swap_cluster_populate(struct swap_info_struct *si,
 			 struct swap_cluster_info *ci)
 {
-	struct swap_table *table;
+	int ret;
 
 	/*
 	 * Only cluster isolation from the allocator does table allocation.
@@ -502,14 +508,9 @@ swap_cluster_alloc_table(struct swap_info_struct *si,
 		lockdep_assert_held(&si->global_cluster_lock);
 	lockdep_assert_held(&ci->lock);
 
-	/* The cluster must be free and was just isolated from the free list. */
-	VM_WARN_ON_ONCE(ci->flags || !cluster_is_empty(ci));
-
-	table = swap_table_alloc(__GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN);
-	if (table) {
-		rcu_assign_pointer(ci->table, table);
+	if (!swap_cluster_alloc_table(ci, __GFP_HIGH | __GFP_NOMEMALLOC |
+					  __GFP_NOWARN))
 		return ci;
-	}
 
 	/*
 	 * Try a sleep allocation. Each isolated free cluster may cause
@@ -521,7 +522,8 @@ swap_cluster_alloc_table(struct swap_info_struct *si,
 		spin_unlock(&si->global_cluster_lock);
 	local_unlock(&percpu_swap_cluster.lock);
 
-	table = swap_table_alloc(__GFP_HIGH | __GFP_NOMEMALLOC | GFP_KERNEL);
+	ret = swap_cluster_alloc_table(ci, __GFP_HIGH | __GFP_NOMEMALLOC |
+					   GFP_KERNEL);
 
 	/*
 	 * Back to atomic context. We might have migrated to a new CPU with a
@@ -536,20 +538,11 @@ swap_cluster_alloc_table(struct swap_info_struct *si,
 		spin_lock(&si->global_cluster_lock);
 	spin_lock(&ci->lock);
 
-	/* Nothing except this helper should touch a dangling empty cluster. */
-	if (WARN_ON_ONCE(cluster_table_is_alloced(ci))) {
-		if (table)
-			swap_table_free(table);
-		return ci;
-	}
-
-	if (!table) {
+	if (ret) {
 		move_cluster(si, ci, &si->free_clusters, CLUSTER_FLAG_FREE);
 		spin_unlock(&ci->lock);
 		return NULL;
 	}
-
-	rcu_assign_pointer(ci->table, table);
 	return ci;
 }
 
@@ -621,12 +614,11 @@ static struct swap_cluster_info *isolate_lock_cluster(
 	}
 	spin_unlock(&si->lock);
 
-	if (found && !cluster_table_is_alloced(found)) {
-		/* Only an empty free cluster's swap table can be freed. */
-		VM_WARN_ON_ONCE(flags != CLUSTER_FLAG_FREE);
+	/* Cluster's table is freed when and only when it's on the free list. */
+	if (found && flags == CLUSTER_FLAG_FREE) {
 		VM_WARN_ON_ONCE(list != &si->free_clusters);
-		VM_WARN_ON_ONCE(!cluster_is_empty(found));
-		return swap_cluster_alloc_table(si, found);
+		VM_WARN_ON_ONCE(cluster_table_is_alloced(found));
+		return swap_cluster_populate(si, found);
 	}
 
 	return found;
@@ -769,7 +761,6 @@ static int swap_cluster_setup_bad_slot(struct swap_info_struct *si,
 	unsigned int ci_off = offset % SWAPFILE_CLUSTER;
 	unsigned long idx = offset / SWAPFILE_CLUSTER;
 	struct swap_cluster_info *ci;
-	struct swap_table *table;
 	int ret = 0;
 
 	/* si->max may got shrunk by swap swap_activate() */
@@ -790,12 +781,9 @@ static int swap_cluster_setup_bad_slot(struct swap_info_struct *si,
 	}
 
 	ci = cluster_info + idx;
-	if (!ci->table) {
-		table = swap_table_alloc(GFP_KERNEL);
-		if (!table)
-			return -ENOMEM;
-		rcu_assign_pointer(ci->table, table);
-	}
+	/* Need to allocate swap table first for initial bad slot marking. */
+	if (!ci->count && swap_cluster_alloc_table(ci, GFP_KERNEL))
+		return -ENOMEM;
 	spin_lock(&ci->lock);
 	/* Check for duplicated bad swap slots. */
 	if (__swap_table_xchg(ci, ci_off, SWP_TB_BAD) != SWP_TB_NULL) {
@@ -3054,7 +3042,7 @@ static void free_swap_cluster_info(struct swap_cluster_info *cluster_info,
 		ci = cluster_info + i;
 		/* Cluster with bad marks count will have a remaining table */
 		spin_lock(&ci->lock);
-		if (rcu_dereference_protected(ci->table, true)) {
+		if (cluster_table_is_alloced(ci)) {
 			swap_cluster_assert_empty(ci, 0, SWAPFILE_CLUSTER, true);
 			swap_cluster_free_table(ci);
 		}

-- 
2.54.0



