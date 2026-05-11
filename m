Return-Path: <cgroups+bounces-15794-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gElCDXE8AmrmpAEAu9opvQ
	(envelope-from <cgroups+bounces-15794-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 22:30:41 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C74515E38
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 22:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2897C3010BC3
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 20:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5521F38A734;
	Mon, 11 May 2026 20:30:38 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3DD3876B5;
	Mon, 11 May 2026 20:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778531435; cv=none; b=TJarPjOOriZDLMjvhl0R2AF4PQyKODgU9PIYwP0mC/6XTGLDfbTdaDssVCnqu2aZ3QBL10b+QrfoQjgtrIVlFc+4EdvnmetJzwJb2YlXUoLh5Ot8SrVLWOz/k61y8TlxIh74VVTshOTcEgpOt2QqxEiX+XIL7lqDhZ16GMgg90Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778531435; c=relaxed/simple;
	bh=b3XCt4jBVTS5bgYXOYIDPqP/5BqDfLRGMWiA3EeOk68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jULc5muuau+7Pl50RkV+4IWkDCVxuRAgxCK1He7WpvQYCij8a0Wl1lnDGto0fo/UtIrUmny6KkdXRydpFdsroZtco6Z/vzGBsxMY7DQg2+EtP2/eWy6I/D5w6lduErWC1QPBfpUQMIdKs/kmWA6UhMq+T6adU6wSpPPw4tOxOMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5FD5D3ED2B;
	Mon, 11 May 2026 20:30:21 +0000 (UTC)
From: Alexandre Ghiti <alex@ghiti.fr>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Yosry Ahmed <yosry@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Minchan Kim <minchan@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Barry Song <baohua@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Wei Xu <weixugc@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH 8/8] mm: zswap: per-node kmem accounting for zswap/zsmalloc
Date: Mon, 11 May 2026 22:20:43 +0200
Message-ID: <20260511202136.330358-9-alex@ghiti.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511202136.330358-1-alex@ghiti.fr>
References: <20260511202136.330358-1-alex@ghiti.fr>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTEy/cPNEbIyKrA/MitPZ5mKJRYC7nugubgDZQLwxnW3NtraSF5cXcbucibxUEBAotu/5jA1kLeArlpAogW+GpNJjlA4w7QhN/lDeSHlX/Qt+YqfWaw9ykhvJM8lt9hdo+KGSa3ccimd6/Kvq+tL15sdDHSfkmskxsDwrEYKu+l9AqGPE3dpM+cbmvO2vqWtd1u1ufLrqqOjN3r9L31WsWPWcBrGNG6kL/c40kf4ChjHAF+7vC+CNmupNLCagakrkdFm8c03q2Lybo5Oyu0FDYAsKvV8ZK0sd5GzHXto28BE6BHQl6FYyXYyPmqkM8PtnN68vFHb7/uWt4sG+sfew8sak61TG91ooJfwp+9kVzzzE1D31WVUhLhGPRo6QOVJVrlCpXv2pHKs2yyy6GN+kNsfhxtCRVL665NQ0h9pLundbYcUhgU9xzoVJMhum8zT21UPCCP/TfS7hyvToiO9t+aL8imvrWvoSM2cW7lw3NZUEHkr8J1aSjh6s3UWlmOYJ9hkfnUDWDcoUErgPenJTFm4HBgaT/POn0dieHepR38LlKGATsS125feE/hpxAto0XbuMddREBxfHBF0eh/kh4nJqo+ELjeWVJKdJzPoMw4BslmEavYds3WpGJNNEERFki37eDLy5C/qvqz+DhKKWW96iO7kOR9yDTRLz7ULnmvehA
X-Rspamd-Queue-Id: B9C74515E38
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-15794-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[31];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ghiti.fr];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,linux.dev,gentwo.org,gmail.com,chromium.org,google.com,tencent.com,oracle.com,kvack.org,vger.kernel.org,ghiti.fr];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@ghiti.fr,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.079];
	TAGGED_RCPT(0.00)[cgroups];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ghiti.fr:email,ghiti.fr:mid]
X-Rspamd-Action: no action

Update zswap and zsmalloc to use per-node obj_cgroup for kmem
accounting, attributing compressed page charges to the correct
NUMA node.

But actually, this is incomplete because it does not correctly account
for entries that straddle pages, those pages being possibly on 2 different
nodes.

This will be correctly handled by Joshua in a different series [1].

Link: https://lore.kernel.org/linux-mm/20260311195153.4013476-1-joshua.hahnjy@gmail.com/ [1]
Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 include/linux/zsmalloc.h |  2 ++
 mm/zsmalloc.c            | 11 +++++++++++
 mm/zswap.c               |  9 +++++++--
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/linux/zsmalloc.h b/include/linux/zsmalloc.h
index 478410c880b1..30427f3fe232 100644
--- a/include/linux/zsmalloc.h
+++ b/include/linux/zsmalloc.h
@@ -50,6 +50,8 @@ void zs_obj_read_sg_end(struct zs_pool *pool, unsigned long handle);
 void zs_obj_write(struct zs_pool *pool, unsigned long handle,
 		  void *handle_mem, size_t mem_len);
 
+int zs_handle_to_nid(struct zs_pool *pool, unsigned long handle);
+
 extern const struct movable_operations zsmalloc_mops;
 
 #endif
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 63128ddb7959..7b45c67e51f1 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1381,6 +1381,17 @@ static void obj_free(int class_size, unsigned long obj)
 	mod_zspage_inuse(zspage, -1);
 }
 
+int zs_handle_to_nid(struct zs_pool *pool, unsigned long handle)
+{
+	unsigned long obj;
+	struct zpdesc *zpdesc;
+
+	obj = handle_to_obj(handle);
+	obj_to_zpdesc(obj, &zpdesc);
+	return page_to_nid(zpdesc_page(zpdesc));
+}
+EXPORT_SYMBOL(zs_handle_to_nid);
+
 void zs_free(struct zs_pool *pool, unsigned long handle)
 {
 	struct zspage *zspage;
diff --git a/mm/zswap.c b/mm/zswap.c
index 4b5149173b0e..e3a9a294f14b 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1443,8 +1443,13 @@ static bool zswap_store_page(struct page *page,
 	 */
 	zswap_pool_get(pool);
 	if (objcg) {
-		obj_cgroup_get(objcg);
-		obj_cgroup_charge_zswap(objcg, entry->length);
+		struct obj_cgroup *nid_objcg;
+		int nid = zs_handle_to_nid(pool->zs_pool, entry->handle);
+
+		nid_objcg = obj_cgroup_get_nid(objcg, nid);
+		obj_cgroup_charge_zswap(nid_objcg, entry->length);
+		obj_cgroup_get(nid_objcg);
+		objcg = nid_objcg;
 	}
 	atomic_long_inc(&zswap_stored_pages);
 	if (entry->length == PAGE_SIZE)
-- 
2.54.0


