Return-Path: <cgroups+bounces-15616-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIgILasP+mntIgMAu9opvQ
	(envelope-from <cgroups+bounces-15616-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 05 May 2026 17:41:31 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5F44D0643
	for <lists+cgroups@lfdr.de>; Tue, 05 May 2026 17:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1C7CF302F53D
	for <lists+cgroups@lfdr.de>; Tue,  5 May 2026 15:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E8248C40A;
	Tue,  5 May 2026 15:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oWd0CJCo"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7F448AE13
	for <cgroups@vger.kernel.org>; Tue,  5 May 2026 15:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777995566; cv=none; b=oBlochUj7zazW28SVtMftZCMPWwjM4u8F30JILo8naI0jDoMVJGOtgEAmd6mQNbxD5OtUhh0nIGaTqdiRPSUvn/eIggwLObAHJq/6US7exWM4ytKz3srlF3kqGz1oo75TDnSpS7MPvGNCdSyLuNVO+VcX+s21BsUHcPgS/sKR+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777995566; c=relaxed/simple;
	bh=WN14xqyobls2ncY90yTq3yHmvoM7PpJqiIr/7Y2t7cI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oBQcel3dPN+JJhveS1rkuC0+mYZaufoYr6LQ+4HnYpqzUVvr9P9VPKw4g6bI11CjTwhzfsuQ9nG5RQ2ZCK2/2zWQv5CP4WTNFLU6U59cB6GGnruTi5yxVDoB8tWuzk8EBBm6oLsjLhWeZmtPlSbencrcPUdIshtA6M9rckG71p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oWd0CJCo; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-47c941f7213so1677625b6e.1
        for <cgroups@vger.kernel.org>; Tue, 05 May 2026 08:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777995563; x=1778600363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4A1Rhza7++tBGVkrCxZWq6+tCWAvd5BViTmAL2CBcjA=;
        b=oWd0CJCo8S0wPgozwTv+ceLOuW2DK1WnavG3vxuvt9+S9h9KzP+PhdcO4UugMYy+xY
         KCB6nZ7oivEURVHmi4KFOtonbcoN8dxTxl9zPi5i5pAOju7m1DNJM31UEU1ZcYF7kef0
         zEY4pfSFXwfwf9wbN+pN0ttmBAyTJJxhEXV3nGPXdRwTUDWlzRcDC0j8D8Tg6DrfM9qE
         SfuCf7/nFtX6J37LT0PI5G1xRjh0sXyqV0z3Isoqmmjy1EyhWbUfMvnnR8hyRzZ5/+HO
         L+QbTwkNmDL90YRy1ROQxOceMeX2k9drqzqQUwhLNetibDhqhSKbJT39JZ64mTV0ONXa
         wtiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777995563; x=1778600363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4A1Rhza7++tBGVkrCxZWq6+tCWAvd5BViTmAL2CBcjA=;
        b=jvY2epz39cJF1cVq4DA4+s88IfKEsvHW0FWK0muNJWqZGbV5hVdte39caT293NNhLg
         cacZRDOm0SgtB5c77Gz1aR5N0cjHDO2eLE9K6Ei4/8Hy0VGIu87cvM25WWiEeGk0XIEM
         zYB0ACUqvYkuVW98nY+b7ozNe3dIQnkxxznHmGAA2TQjCdEr1ucVEScwvQaaHoxX0Scu
         qfz9104BmBvOBWgfshDX0h/ADTeZtlSN5rR9QucRwcw/YK4og11MAv8Ugqoir4kwmWI4
         ZJ7NnVq6ixVwDfTayGYYlsh/ispfF5c7diQy0hxepIPe8e+DnybxqqMQEHwAqusnO6Pn
         BA6g==
X-Forwarded-Encrypted: i=1; AFNElJ91nqaFRPIyY3mhutn8zTlpcf5tVY+DV/FA2fuWFQPYt9QtYx18jqHhxNZPw8pzx/F3oltdOLHv@vger.kernel.org
X-Gm-Message-State: AOJu0YxGVVl+YhxVaing8Am0JR8c1gdQjspVSU4043kWYctHzsWteU76
	Gjwz6/jQkTs7mQFZ1LIp8tBnh23/AXC+UtQqH0tk6I9EAuileQxOtBGq
X-Gm-Gg: AeBDies4htj/w9uslacXlP9nPw4RNIbtinLL5um3z7yBYQoGD2GD81KnJ+ONYm5AWwV
	yxP8zGSAqLJErekIFpdTS0mX2Sh+CpfbLWC1tn0hb2Bb4dwiCRn9kN81pnVNy4ADDlz6eFZ4e8j
	lcXAwFVRJpz41dxd3KTkCT9Vc+dVAfaaNsbAWDOiRiqgROg5Ls7qtJ4+8rqKQNmidbUA3e4LJZp
	NnMueF8eWDI7jVOsa7Jl403R3fv8l2mc5gHVkbLuia3o2hNYRVQkf45UJSRzwLyah4IKx7x+6RL
	qi8BuYZkVF/zlGfISp0sT1Mv8MCtLVkzE9gBlD3afDzEWlw6Mpp4yIE7I3cNn3UkmbgeoaP6Rzl
	TDBwcuxl9GunYsyjhIxLmXfBdlZ/RpUBN1uUcz8AxXf6hFN3sswoOxeFS18pG820R6DDv7T8lDD
	JHNZQLaQR9W2nEKF+klyqewAIoLieL8MeDFlmCCnyp2SiU4pboDtTwoMm1eh1p9hk5uFY=
X-Received: by 2002:a05:6808:190b:b0:472:878f:347d with SMTP id 5614622812f47-47c8922ed6dmr6800850b6e.26.1777995563088;
        Tue, 05 May 2026 08:39:23 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:51::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c76985f8fsm8843938b6e.14.2026.05.05.08.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 08:39:22 -0700 (PDT)
From: Nhat Pham <nphamcs@gmail.com>
To: kasong@tencent.com
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	apopple@nvidia.com,
	axelrasmussen@google.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	bhe@redhat.com,
	byungchul@sk.com,
	cgroups@vger.kernel.org,
	chengming.zhou@linux.dev,
	chrisl@kernel.org,
	corbet@lwn.net,
	david@kernel.org,
	dev.jain@arm.com,
	gourry@gourry.net,
	hannes@cmpxchg.org,
	hughd@google.com,
	jannh@google.com,
	joshua.hahnjy@gmail.com,
	lance.yang@linux.dev,
	lenb@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-pm@vger.kernel.org,
	lorenzo.stoakes@oracle.com,
	matthew.brost@intel.com,
	mhocko@suse.com,
	muchun.song@linux.dev,
	npache@redhat.com,
	nphamcs@gmail.com,
	pavel@kernel.org,
	peterx@redhat.com,
	peterz@infradead.org,
	pfalcato@suse.de,
	rafael@kernel.org,
	rakie.kim@sk.com,
	roman.gushchin@linux.dev,
	rppt@kernel.org,
	ryan.roberts@arm.com,
	shakeel.butt@linux.dev,
	shikemeng@huaweicloud.com,
	surenb@google.com,
	tglx@kernel.org,
	vbabka@suse.cz,
	weixugc@google.com,
	ying.huang@linux.alibaba.com,
	yosry.ahmed@linux.dev,
	yuanchu@google.com,
	zhengqi.arch@bytedance.com,
	ziy@nvidia.com,
	kernel-team@meta.com,
	riel@surriel.com,
	haowenchao22@gmail.com
Subject: [PATCH v6 11/22] zswap: move zswap entry management to the virtual swap descriptor
Date: Tue,  5 May 2026 08:38:40 -0700
Message-ID: <20260505153854.1612033-12-nphamcs@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260505153854.1612033-1-nphamcs@gmail.com>
References: <20260505153854.1612033-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9E5F44D0643
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15616-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	RCPT_COUNT_GT_50(0.00)[55];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Remove the zswap tree and manage zswap entries directly
through the virtual swap descriptor. This re-partitions the zswap pool
(by virtual swap cluster), which eliminates zswap tree lock contention.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/zswap.h |   6 +++
 mm/vswap.c            | 100 ++++++++++++++++++++++++++++++++++++++++++
 mm/zswap.c            |  56 ++++-------------------
 3 files changed, 114 insertions(+), 48 deletions(-)

diff --git a/include/linux/zswap.h b/include/linux/zswap.h
index 1a04caf283dc..7eb3ce7e124f 100644
--- a/include/linux/zswap.h
+++ b/include/linux/zswap.h
@@ -6,6 +6,7 @@
 #include <linux/mm_types.h>
 
 struct lruvec;
+struct zswap_entry;
 
 extern atomic_long_t zswap_stored_pages;
 
@@ -33,6 +34,11 @@ void zswap_lruvec_state_init(struct lruvec *lruvec);
 void zswap_folio_swapin(struct folio *folio);
 bool zswap_is_enabled(void);
 bool zswap_never_enabled(void);
+void *zswap_entry_store(swp_entry_t swpentry, struct zswap_entry *entry);
+void *zswap_entry_load(swp_entry_t swpentry);
+void *zswap_entry_erase(swp_entry_t swpentry);
+bool zswap_empty(swp_entry_t swpentry);
+
 #else
 
 struct zswap_lruvec_state {};
diff --git a/mm/vswap.c b/mm/vswap.c
index 3be42c45a1bb..fad1fd86e0f5 100644
--- a/mm/vswap.c
+++ b/mm/vswap.c
@@ -10,6 +10,7 @@
 #include <linux/swapops.h>
 #include <linux/swap_cgroup.h>
 #include <linux/cpuhotplug.h>
+#include <linux/zswap.h>
 #include <linux/vmalloc.h>
 #include "swap.h"
 #include "swap_table.h"
@@ -38,11 +39,13 @@
  * Swap descriptor - metadata of a swapped out page.
  *
  * @slot: The handle to the physical swap slot backing this page.
+ * @zswap_entry: The zswap entry associated with this swap slot.
  * @swap_cache: The folio in swap cache.
  * @shadow: The shadow entry.
  */
 struct swp_desc {
 	swp_slot_t slot;
+	struct zswap_entry *zswap_entry;
 	union {
 		struct folio *swap_cache;
 		void *shadow;
@@ -241,6 +244,7 @@ static void __vswap_alloc_from_cluster(struct vswap_cluster *cluster, int start,
 	for (i = 0; i < nr; i++) {
 		desc = &cluster->descriptors[start + i];
 		desc->slot.val = 0;
+		desc->zswap_entry = NULL;
 		desc->swap_cache = folio;
 	}
 	cluster->count += nr;
@@ -1034,6 +1038,102 @@ void __swap_cache_replace_folio(struct folio *old, struct folio *new)
 	rcu_read_unlock();
 }
 
+#ifdef CONFIG_ZSWAP
+/**
+ * zswap_entry_store - store a zswap entry for a swap entry
+ * @swpentry: the swap entry
+ * @entry: the zswap entry to store
+ *
+ * Stores a zswap entry in the swap descriptor for the given swap entry.
+ * The cluster is locked during the store operation.
+ *
+ * Return: the old zswap entry if one existed, NULL otherwise
+ */
+void *zswap_entry_store(swp_entry_t swpentry, struct zswap_entry *entry)
+{
+	struct vswap_cluster *cluster = NULL;
+	struct swp_desc *desc;
+	void *old;
+
+	rcu_read_lock();
+	desc = vswap_iter(&cluster, swpentry.val);
+	if (!desc) {
+		rcu_read_unlock();
+		return NULL;
+	}
+
+	old = desc->zswap_entry;
+	desc->zswap_entry = entry;
+	spin_unlock(&cluster->lock);
+	rcu_read_unlock();
+
+	return old;
+}
+
+/**
+ * zswap_entry_load - load a zswap entry for a swap entry
+ * @swpentry: the swap entry
+ *
+ * Loads the zswap entry from the swap descriptor for the given swap entry.
+ *
+ * Return: the zswap entry if one exists, NULL otherwise
+ */
+void *zswap_entry_load(swp_entry_t swpentry)
+{
+	struct vswap_cluster *cluster = NULL;
+	struct swp_desc *desc;
+	void *zswap_entry;
+
+	rcu_read_lock();
+	desc = vswap_iter(&cluster, swpentry.val);
+	if (!desc) {
+		rcu_read_unlock();
+		return NULL;
+	}
+
+	zswap_entry = desc->zswap_entry;
+	spin_unlock(&cluster->lock);
+	rcu_read_unlock();
+
+	return zswap_entry;
+}
+
+/**
+ * zswap_entry_erase - erase a zswap entry for a swap entry
+ * @swpentry: the swap entry
+ *
+ * Erases the zswap entry from the swap descriptor for the given swap entry.
+ * The cluster is locked during the erase operation.
+ *
+ * Return: the zswap entry that was erased, NULL if none existed
+ */
+void *zswap_entry_erase(swp_entry_t swpentry)
+{
+	struct vswap_cluster *cluster = NULL;
+	struct swp_desc *desc;
+	void *old;
+
+	rcu_read_lock();
+	desc = vswap_iter(&cluster, swpentry.val);
+	if (!desc) {
+		rcu_read_unlock();
+		return NULL;
+	}
+
+	old = desc->zswap_entry;
+	desc->zswap_entry = NULL;
+	spin_unlock(&cluster->lock);
+	rcu_read_unlock();
+
+	return old;
+}
+
+bool zswap_empty(swp_entry_t swpentry)
+{
+	return xa_empty(&vswap_cluster_map);
+}
+#endif /* CONFIG_ZSWAP */
+
 int vswap_init(void)
 {
 	int i;
diff --git a/mm/zswap.c b/mm/zswap.c
index f7313261673f..18725d9b1194 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -145,10 +145,10 @@ struct crypto_acomp_ctx {
 };
 
 /*
- * The lock ordering is zswap_tree.lock -> zswap_pool.lru_lock.
- * The only case where lru_lock is not acquired while holding tree.lock is
- * when a zswap_entry is taken off the lru for writeback, in that case it
- * needs to be verified that it's still valid in the tree.
+ * The lock ordering is the vswap cluster lock -> zswap_pool.lru_lock.
+ * The only case where lru_lock is not acquired while holding the vswap
+ * cluster lock is when a zswap_entry is taken off the lru for writeback,
+ * in that case it needs to be verified that it's still valid in vswap.
  */
 struct zswap_pool {
 	struct zs_pool *zs_pool;
@@ -223,37 +223,6 @@ static bool zswap_has_pool;
 * helpers and fwd declarations
 **********************************/
 
-static DEFINE_XARRAY(zswap_tree);
-
-#define zswap_tree_index(entry)	(entry.val)
-
-static inline void *zswap_entry_store(swp_entry_t swpentry,
-		struct zswap_entry *entry)
-{
-	pgoff_t offset = zswap_tree_index(swpentry);
-
-	return xa_store(&zswap_tree, offset, entry, GFP_KERNEL);
-}
-
-static inline void *zswap_entry_load(swp_entry_t swpentry)
-{
-	pgoff_t offset = zswap_tree_index(swpentry);
-
-	return xa_load(&zswap_tree, offset);
-}
-
-static inline void *zswap_entry_erase(swp_entry_t swpentry)
-{
-	pgoff_t offset = zswap_tree_index(swpentry);
-
-	return xa_erase(&zswap_tree, offset);
-}
-
-static inline bool zswap_empty(swp_entry_t swpentry)
-{
-	return xa_empty(&zswap_tree);
-}
-
 #define zswap_pool_debug(msg, p)			\
 	pr_debug("%s pool %s\n", msg, (p)->tfm_name)
 
@@ -1168,7 +1137,7 @@ static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_o
 	/*
 	 * Once the lru lock is dropped, the entry might get freed. The
 	 * swpentry is copied to the stack, and entry isn't deref'd again
-	 * until the entry is verified to still be alive in the tree.
+	 * until the entry is verified to still be alive in vswap.
 	 */
 	swpentry = entry->swpentry;
 
@@ -1445,13 +1414,6 @@ static bool zswap_store_page(struct page *page,
 		goto compress_failed;
 
 	old = zswap_entry_store(page_swpentry, entry);
-	if (xa_is_err(old)) {
-		int err = xa_err(old);
-
-		WARN_ONCE(err != -ENOMEM, "unexpected xarray error: %d\n", err);
-		zswap_reject_alloc_fail++;
-		goto store_failed;
-	}
 
 	/*
 	 * We may have had an existing entry that became stale when
@@ -1462,11 +1424,11 @@ static bool zswap_store_page(struct page *page,
 		zswap_entry_free(old);
 
 	/*
-	 * The entry is successfully compressed and stored in the tree, there is
+	 * The entry is successfully compressed and stored in vswap, there is
 	 * no further possibility of failure. Grab refs to the pool and objcg,
 	 * charge zswap memory, and increment zswap_stored_pages.
 	 * The opposite actions will be performed by zswap_entry_free()
-	 * when the entry is removed from the tree.
+	 * when the entry is removed from vswap.
 	 */
 	zswap_pool_get(pool);
 	if (objcg) {
@@ -1478,7 +1440,7 @@ static bool zswap_store_page(struct page *page,
 		atomic_long_inc(&zswap_stored_incompressible_pages);
 
 	/*
-	 * We finish initializing the entry while it's already in xarray.
+	 * We finish initializing the entry while it's already in vswap.
 	 * This is safe because:
 	 *
 	 * 1. Concurrent stores and invalidations are excluded by folio lock.
@@ -1498,8 +1460,6 @@ static bool zswap_store_page(struct page *page,
 
 	return true;
 
-store_failed:
-	zs_free(pool->zs_pool, entry->handle);
 compress_failed:
 	zswap_entry_cache_free(entry);
 	return false;
-- 
2.52.0


