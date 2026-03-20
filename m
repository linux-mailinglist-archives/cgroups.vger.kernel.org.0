Return-Path: <cgroups+bounces-14953-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCN8LGmgvWkM/wIAu9opvQ
	(envelope-from <cgroups+bounces-14953-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 20:30:49 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B0A2DFFC3
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 20:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D31EC300C571
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 19:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264603EF65F;
	Fri, 20 Mar 2026 19:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrLXInbl"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF043EE1F3
	for <cgroups@vger.kernel.org>; Fri, 20 Mar 2026 19:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774034876; cv=none; b=rOg61AZvcjL3xYtULkyDcs86J3fluoFRWNIBrFyYJ5DO9zIxA62fnfcoGf8M7gufvHTcv/MO6Bg817O9SEatNzvQrVgqV1bmh4k2x4s1YjQWqpQkGU4FvrSH/u/PCexylEKGiHREuvQIMGp4MOySkdcyijLX9EtHsp8G1yRqZy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774034876; c=relaxed/simple;
	bh=1dUCBz1ekRwGyhp7aar8Ynyko8f4W8fyU8IBjgTWVT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dxtLNvHcutKyeTPxImfQOBrayb4jgztS05YN/ywEb4vxZCxM/5s3Q4vsRxc/2GwWCOsLRBFL1Q165jC7kUXB/cROe/ZjA0HuUL6BokGCGF1/h9UuTBFGTanEcjGcDnlurSYgDL0sCXtX8Feu+63tRxCtfDEhr5b2nX+gol8JbeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QrLXInbl; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-4043b27ddeaso1557799fac.1
        for <cgroups@vger.kernel.org>; Fri, 20 Mar 2026 12:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774034873; x=1774639673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KPp25151sWevMzEffEXxfQEZtCUw8Iu/6c7CfKgDuL4=;
        b=QrLXInblHomAh6OHIjBFUyK8E28FJX5P1/b3FnAs6J102tRryk9SuMvI8F4JBa9t1T
         1GvBGBe79kkmx9aruajSh5c8OMADIlD19sf+UDc67eTIcgwl+LyjJiK3QUs8z48oTLwm
         T0G0kgFKVDgeaIxt2QBBRhPDOsxnxdXRspMJf3zYWJX+8UXjgXxWnjxr8c5KKqx9gS6N
         8aisPKhV8GyNd9qRvp2BwiOeDd8PEvxNmluNFJn+whebSFBZt/vOr+s41pxe7xzPJglY
         EhtPFPJwIYHjEQ+XCzImYs8xiBRd4ubLWwBmNUynKo16gudcOCtT15vG65ZLpkVwSMjk
         tj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774034873; x=1774639673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KPp25151sWevMzEffEXxfQEZtCUw8Iu/6c7CfKgDuL4=;
        b=SLeJLUgHXrhlj68PbTFEps3+41nccKyoq2UwAemRlGLEqjTdIiFRIP08pAkud3Lkl2
         VxRqr54HFyU/R3mWwiPw6G6/Aki8hZJSyAnNCIZWJ1ThbLtion+WYumndb8ZWe0eYLqW
         mAvbA7Mm31RbGQ/HywX93A/sG9Pit0wivCsQd8Z7nAXFL1JItKcJ7rovFYEynJcAtej/
         xMUEbCTDMJd6EMG+IQTE6KW7sm2MJCK2njj2wy7Xy/HIjx1nA1RHn0aB4ez06/hpsqLK
         hirESe7kyH/SmrqU3f2TL6LS/PiEHJALop9GXKN6ZG7+ngMQQjiuGxGQoYRuELlMlout
         BFCg==
X-Forwarded-Encrypted: i=1; AJvYcCX5Qrq+SMaehuhcRe768euJHEdXOWq4ZrTOUUbCcMjGHWSssFPpZoHRp+ZQZm8LIQEIS2vyJsOs@vger.kernel.org
X-Gm-Message-State: AOJu0YzVgzbYlSZObKzRbtNjFL4e4SwQLcpBZrQNaCOgMH2mdvkv0R+i
	fbUOIVme76zdlec0pjgsRadft8Gk4IQA7io6PMUygBMS//fRipH4q4sa
X-Gm-Gg: ATEYQzy6aKC1IYLmnSYHwxQvk2f/+onatsSKMIOA/f9XFPUh8BZMEy3X2e3VRq9qxmk
	9eDa0v4usHxLy1UpDAjKRJum5NLgVoKwKYqe/g3cWyHije7IgmIeU1pa+U9ufZV1RwAoNLF6JvG
	XMl5bEQjhub/OdoGdxmsz5v2EbjC6lxlLUWdgtXZqTlUXDc9AwugMR8HoZhdqs22QkBzIsSYuSr
	Kr7FtjJmnleSCEqGFzrbaosAmBwNd9dv46YiYXE5lxWiROnY/x7HLDDNx/1e0yRajJDSH7iz/GR
	34GiQ8fZNKe4F2wawmECeVfbtdP9BdsggmFl4TkTQIj4tuxCt/maiKsSH4LsWes8XWhBl7gLety
	kXfPXWmucpmjNRh/QXMfCdzh3sZYdnlf2yKS15/fw0jflTdqwK5QvA8EPlvAzazQFJWM761QPGa
	CAguoQYKKQYWcNR3eSEvxDdAqkANh851gwWlRGdD7GoNeUYw==
X-Received: by 2002:a05:6870:f150:b0:409:7a01:6e2f with SMTP id 586e51a60fabf-41c10ffd393mr2670572fac.11.1774034872998;
        Fri, 20 Mar 2026 12:27:52 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:56::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41c14d73a19sm2659524fac.11.2026.03.20.12.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 12:27:52 -0700 (PDT)
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
	riel@surriel.com
Subject: [PATCH v5 11/21] zswap: move zswap entry management to the virtual swap descriptor
Date: Fri, 20 Mar 2026 12:27:25 -0700
Message-ID: <20260320192735.748051-12-nphamcs@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260320192735.748051-1-nphamcs@gmail.com>
References: <20260320192735.748051-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14953-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.876];
	RCPT_COUNT_GT_50(0.00)[54];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B7B0A2DFFC3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Remove the zswap tree and manage zswap entries directly
through the virtual swap descriptor. This re-partitions the zswap pool
(by virtual swap cluster), which eliminates zswap tree lock contention.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/zswap.h |   6 +++
 mm/vswap.c            | 100 ++++++++++++++++++++++++++++++++++++++++++
 mm/zswap.c            |  40 -----------------
 3 files changed, 106 insertions(+), 40 deletions(-)

diff --git a/include/linux/zswap.h b/include/linux/zswap.h
index 1a04caf283dc8..7eb3ce7e124fc 100644
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
index 3027294cd872b..9b2122647b850 100644
--- a/mm/vswap.c
+++ b/mm/vswap.c
@@ -10,6 +10,7 @@
 #include <linux/swapops.h>
 #include <linux/swap_cgroup.h>
 #include <linux/cpuhotplug.h>
+#include <linux/zswap.h>
 #include "swap.h"
 #include "swap_table.h"
 
@@ -37,11 +38,13 @@
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
@@ -238,6 +241,7 @@ static void __vswap_alloc_from_cluster(struct vswap_cluster *cluster, int start)
 	for (i = 0; i < nr; i++) {
 		desc = &cluster->descriptors[start + i];
 		desc->slot.val = 0;
+		desc->zswap_entry = NULL;
 	}
 	cluster->count += nr;
 }
@@ -1008,6 +1012,102 @@ void __swap_cache_replace_folio(struct folio *old, struct folio *new)
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
index f7313261673ff..72441131f094e 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
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
@@ -1498,8 +1460,6 @@ static bool zswap_store_page(struct page *page,
 
 	return true;
 
-store_failed:
-	zs_free(pool->zs_pool, entry->handle);
 compress_failed:
 	zswap_entry_cache_free(entry);
 	return false;
-- 
2.52.0


