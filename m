Return-Path: <cgroups+bounces-12999-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D40FCD06265
	for <lists+cgroups@lfdr.de>; Thu, 08 Jan 2026 21:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C2C030848E7
	for <lists+cgroups@lfdr.de>; Thu,  8 Jan 2026 20:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B3B33120A;
	Thu,  8 Jan 2026 20:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="AfZQstJT"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9003328F3
	for <cgroups@vger.kernel.org>; Thu,  8 Jan 2026 20:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767904753; cv=none; b=QIKiz1KOfgpWq6KC3Eh2vbmLqAz/S+PriaOf88oz7+3hpizutwLhCS71rozdiTsK/riEdJFJZoW5fzBpeTzvnSjBrhnb2VYPp9o9PJSOT3e5cHzrDPBLEQ1Gq0wdY4G6V5AWlTbqtEzQHFf/LaY1LHJ8D+DGl43+cqxHflZyJLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767904753; c=relaxed/simple;
	bh=Q6n6H6pGLwW6lg8o+yJkMzcp5ygcedJTXlkaT5WaISo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ocJICDLo7hNRTDeZmy+7u6Ytp2QVjpcYwuge4L+5/vIBJg01sGZBmrV2Rv7Yko6EQABJbCHU3Ic0NNYOEbPDPyUJewMUWePb7t0W1uKW1IXzK0vBuq4ep31k7EeHZQ7q7sUCjaWpdJf/LdA36SvSszJp8IcXQOJwEAELbPSuN5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=AfZQstJT; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ffbea7fdf1so10617351cf.1
        for <cgroups@vger.kernel.org>; Thu, 08 Jan 2026 12:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1767904750; x=1768509550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5OTZsz9YEfzZ2R8Vdeqp1RCaOkKgwxKsmSu+J9FA9fQ=;
        b=AfZQstJTicHT8cU0FpbOpZQ226cG57nxuzO9CXkQR2+q1EpDMkbKf6rUuAVsxrGdTh
         v6crsNu+AYUpEvyGFd60KQYYnTuKPc9OACtbdGy0jGPVY91zv6lyHAUaabz5uhDce9gt
         iY7+Aa2Nt4/6bImyHuiist25XkTpKbeWo8KK6FajaQ6+ranNVv4zReewKrjXTfhiu+o0
         n/wuib40Q1w5he3k9YH0trpvMh7uZy/SavVCwu1PyWvfBoqpOPGa/VuIcJRMGnkO82cM
         /7oqylfUe9lJIzHM3fNaOzy0rWjLtTtk7dU/bk+cn9qklC4SXwr+6sCGibE8ZCp7ZWeV
         OrKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767904750; x=1768509550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5OTZsz9YEfzZ2R8Vdeqp1RCaOkKgwxKsmSu+J9FA9fQ=;
        b=V7p+tqCGKTKh4OHei+UmxYk/vJj5dzYpq2k9LJQQwZ/qdv0oAuL0gArmPITKkaKNVv
         JblO6DW3wMx5B413ZhEBRqR9Jfua1DedynikqR1/ED9Wrp8H4+FTZt5HejYoXpfxyqjO
         XcO35SEDhwDA8t9JtN2mj/cV34q7ovWM1VD4zK0SX8AT7E3X9D+DZJWOtbMiK3nvLnIO
         WmaEVc8v5+6UMkr6iSijDG3KS+b3L5PDcByg9kBX0oLUPuzEp5da/r523vi+xv6lW3SB
         0YMFgSfdtAasCMUa1cY2TQ/Yq2Yg7Zvc4uOGdFpdZ6mmEtbbcneRffgiPJXcS4GhDntV
         Uarg==
X-Forwarded-Encrypted: i=1; AJvYcCX+4Xtco8zeES0DPQwcmEYwdNaZPXaZPwaj0Tq0N3yxlDzu4LsDsx6p5GaPbyzylYS1alssX0kp@vger.kernel.org
X-Gm-Message-State: AOJu0YzGR/zpyjdjLdbBaE/S0WEPbibfazCaW3cqtFeH8S8aBgicDUvQ
	OZqzK5FyaslIAhR0fbWJTt2+g0/wQ8ix2XtbkriIkm9zVYsI/zBGMU2DgL1WOPMWxJE=
X-Gm-Gg: AY/fxX7oIiaOrX/7vantvEK2pK2Qf98IkNeaIUPeaIfJlhnLym66FlGZmU6UyXAnsJi
	oUbMa4d3WHuxaLCxjf5fdnVxmOZBr/EN3guNCCua0hNEY//BWKH+TZRya4f8hZpY50xzggmqoPb
	5/N3qewU7qyRUtuuTbS0xmJAM29R4kUHDAcaoorvGm7dNcjr0WsIQyNhunXs4qsZwCa2R36GyB5
	Qez7uVk8PxskDG0EOINK0lVLz7h7Ijj5elr8nR/4BI+sP5vQo8SPVs45OytFcTFGx41gDjWw/WC
	l/97LlAlJSIdcTYf3hXdudrL1OpmCfe/dBeim9HgItwW7oKoaX62fhWcYzsfYj/OPry4ftSnCHJ
	sJhUnKoubdhVDlEU41kko9Z0LpAuZ2JlaTIc90SlvdgfplebMzDnTURGj0L0y7bwDyGYgdiQpxP
	+2LPJ4Tovhwq7GkRHeZ4CJ/LpuqPmiZtsf5O/2coIRwtg5oXA/d9RMKnjVegjVEbzBCGKKbrbD9
	vs=
X-Google-Smtp-Source: AGHT+IHjrJedObjQLnkqlATuK0iiTd2ReDzXEhDuZpiEE8iScOlIeLDoodxwtlrvEQjvQ0kp+C8/HQ==
X-Received: by 2002:a05:622a:554:b0:4ee:26bd:13fa with SMTP id d75a77b69052e-4ffb4a38073mr98924131cf.80.1767904749843;
        Thu, 08 Jan 2026 12:39:09 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770e472csm60483886d6.23.2026.01.08.12.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 12:39:09 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-cxl@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	corbet@lwn.net,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	akpm@linux-foundation.org,
	vbabka@suse.cz,
	surenb@google.com,
	mhocko@suse.com,
	jackmanb@google.com,
	ziy@nvidia.com,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	rppt@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	chrisl@kernel.org,
	kasong@tencent.com,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	baohua@kernel.org,
	yosry.ahmed@linux.dev,
	chengming.zhou@linux.dev,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev,
	osalvador@suse.de,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	cl@gentwo.org,
	harry.yoo@oracle.com,
	zhengqi.arch@bytedance.com
Subject: [RFC PATCH v3 7/8] mm/zswap: compressed ram direct integration
Date: Thu,  8 Jan 2026 15:37:54 -0500
Message-ID: <20260108203755.1163107-8-gourry@gourry.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108203755.1163107-1-gourry@gourry.net>
References: <20260108203755.1163107-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a private zswap-node is available, skip the entire software
compression process and memcpy directly to a compressed memory
folio, and store the newly allocated compressed memory page as
the zswap entry->handle.

On decompress we do the opposite: copy directly from the stored
page to the destination, and free the compressed memory page.

The driver callback is responsible for preventing run-away
compression ratio failures by checking that the allocated page is
safe to use (i.e. a compression ratio limit hasn't been crossed).

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 include/linux/zswap.h |   5 ++
 mm/zswap.c            | 106 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 109 insertions(+), 2 deletions(-)

diff --git a/include/linux/zswap.h b/include/linux/zswap.h
index 30c193a1207e..4b52fe447e7e 100644
--- a/include/linux/zswap.h
+++ b/include/linux/zswap.h
@@ -35,6 +35,8 @@ void zswap_lruvec_state_init(struct lruvec *lruvec);
 void zswap_folio_swapin(struct folio *folio);
 bool zswap_is_enabled(void);
 bool zswap_never_enabled(void);
+void zswap_add_direct_node(int nid);
+void zswap_remove_direct_node(int nid);
 #else
 
 struct zswap_lruvec_state {};
@@ -69,6 +71,9 @@ static inline bool zswap_never_enabled(void)
 	return true;
 }
 
+static inline void zswap_add_direct_node(int nid) {}
+static inline void zswap_remove_direct_node(int nid) {}
+
 #endif
 
 #endif /* _LINUX_ZSWAP_H */
diff --git a/mm/zswap.c b/mm/zswap.c
index de8858ff1521..aada588c957e 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -35,6 +35,7 @@
 #include <linux/workqueue.h>
 #include <linux/list_lru.h>
 #include <linux/zsmalloc.h>
+#include <linux/node.h>
 
 #include "swap.h"
 #include "internal.h"
@@ -190,6 +191,7 @@ struct zswap_entry {
 	swp_entry_t swpentry;
 	unsigned int length;
 	bool referenced;
+	bool direct;
 	struct zswap_pool *pool;
 	unsigned long handle;
 	struct obj_cgroup *objcg;
@@ -199,6 +201,20 @@ struct zswap_entry {
 static struct xarray *zswap_trees[MAX_SWAPFILES];
 static unsigned int nr_zswap_trees[MAX_SWAPFILES];
 
+/* Nodemask for compressed RAM nodes used by zswap_compress_direct */
+static nodemask_t zswap_direct_nodes = NODE_MASK_NONE;
+
+void zswap_add_direct_node(int nid)
+{
+	node_set(nid, zswap_direct_nodes);
+}
+
+void zswap_remove_direct_node(int nid)
+{
+	if (!node_online(nid))
+		node_clear(nid, zswap_direct_nodes);
+}
+
 /* RCU-protected iteration */
 static LIST_HEAD(zswap_pools);
 /* protects zswap_pools list modification */
@@ -716,7 +732,13 @@ static void zswap_entry_cache_free(struct zswap_entry *entry)
 static void zswap_entry_free(struct zswap_entry *entry)
 {
 	zswap_lru_del(&zswap_list_lru, entry);
-	zs_free(entry->pool->zs_pool, entry->handle);
+	if (entry->direct) {
+		struct page *page = (struct page *)entry->handle;
+
+		node_private_freed(page);
+		__free_page(page);
+	} else
+		zs_free(entry->pool->zs_pool, entry->handle);
 	zswap_pool_put(entry->pool);
 	if (entry->objcg) {
 		obj_cgroup_uncharge_zswap(entry->objcg, entry->length);
@@ -849,6 +871,58 @@ static void acomp_ctx_put_unlock(struct crypto_acomp_ctx *acomp_ctx)
 	mutex_unlock(&acomp_ctx->mutex);
 }
 
+static struct page *zswap_compress_direct(struct page *src,
+					  struct zswap_entry *entry)
+{
+	int nid;
+	struct page *dst;
+	gfp_t gfp;
+	nodemask_t tried_nodes = NODE_MASK_NONE;
+
+	if (nodes_empty(zswap_direct_nodes))
+		return NULL;
+
+	gfp = GFP_NOWAIT | __GFP_NORETRY | __GFP_HIGHMEM | __GFP_MOVABLE |
+	      __GFP_THISNODE;
+
+	for_each_node_mask(nid, zswap_direct_nodes) {
+		int ret;
+
+		/* Skip nodes we've already tried and failed */
+		if (node_isset(nid, tried_nodes))
+			continue;
+
+		dst = __alloc_pages(gfp, 0, nid, &zswap_direct_nodes);
+		if (!dst)
+			continue;
+
+		/*
+		 * Check with the device driver that this page is safe to use.
+		 * If the device reports an error (e.g., compression ratio is
+		 * too low and the page can't safely store data), free the page
+		 * and try another node.
+		 */
+		ret = node_private_allocated(dst);
+		if (ret) {
+			__free_page(dst);
+			node_set(nid, tried_nodes);
+			continue;
+		}
+
+		goto found;
+	}
+
+	return NULL;
+
+found:
+	/* If we fail to copy at this point just fallback */
+	if (copy_mc_highpage(dst, src)) {
+		__free_page(dst);
+		dst = NULL;
+	}
+	return dst;
+}
+
 static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 			   struct zswap_pool *pool)
 {
@@ -860,6 +934,17 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 	gfp_t gfp;
 	u8 *dst;
 	bool mapped = false;
+	struct page *zpage;
+
+	/* Try to shunt directly to compressed ram */
+	zpage = zswap_compress_direct(page, entry);
+	if (zpage) {
+		entry->handle = (unsigned long)zpage;
+		entry->length = PAGE_SIZE;
+		entry->direct = true;
+		return true;
+	}
+	/* otherwise fallback to normal zswap */
 
 	acomp_ctx = acomp_ctx_get_cpu_lock(pool);
 	dst = acomp_ctx->buffer;
@@ -913,6 +998,7 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 	zs_obj_write(pool->zs_pool, handle, dst, dlen);
 	entry->handle = handle;
 	entry->length = dlen;
+	entry->direct = false;
 
 unlock:
 	if (mapped)
@@ -936,6 +1022,15 @@ static bool zswap_decompress(struct zswap_entry *entry, struct folio *folio)
 	int decomp_ret = 0, dlen = PAGE_SIZE;
 	u8 *src, *obj;
 
+	/* compressed ram page */
+	if (entry->direct) {
+		struct page *src = (struct page *)entry->handle;
+		struct folio *zfolio = page_folio(src);
+
+		memcpy_folio(folio, 0, zfolio, 0, PAGE_SIZE);
+		goto direct_done;
+	}
+
 	acomp_ctx = acomp_ctx_get_cpu_lock(pool);
 	obj = zs_obj_read_begin(pool->zs_pool, entry->handle, acomp_ctx->buffer);
 
@@ -969,6 +1064,7 @@ static bool zswap_decompress(struct zswap_entry *entry, struct folio *folio)
 	zs_obj_read_end(pool->zs_pool, entry->handle, obj);
 	acomp_ctx_put_unlock(acomp_ctx);
 
+direct_done:
 	if (!decomp_ret && dlen == PAGE_SIZE)
 		return true;
 
@@ -1483,7 +1579,13 @@ static bool zswap_store_page(struct page *page,
 	return true;
 
 store_failed:
-	zs_free(pool->zs_pool, entry->handle);
+	if (entry->direct) {
+		struct page *freepage = (struct page *)entry->handle;
+
+		node_private_freed(freepage);
+		__free_page(freepage);
+	} else
+		zs_free(pool->zs_pool, entry->handle);
 compress_failed:
 	zswap_entry_cache_free(entry);
 	return false;
-- 
2.52.0


