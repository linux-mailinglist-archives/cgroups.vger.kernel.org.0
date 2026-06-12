Return-Path: <cgroups+bounces-16911-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ah6kBzxgLGqBQAQAu9opvQ
	(envelope-from <cgroups+bounces-16911-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2026 21:38:36 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E72B367C16A
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2026 21:38:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=qnytHfng;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16911-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16911-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 327103029304
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2026 19:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB5437CD52;
	Fri, 12 Jun 2026 19:37:53 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B8A39B960
	for <cgroups@vger.kernel.org>; Fri, 12 Jun 2026 19:37:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781293073; cv=none; b=RYTXByo3jtJ1L3lwTGET8+ApmzfTuxtCDUFpFU32ZHqRy177UM00S1urzbazw6UUom2iTREnLzAw5AT8VhoShiYReepamQlJQN3+A09KfCDd6APrTiVLI5CSUgcZlyri7bSjjqvCYzHIu+oMLIpKXeMe0F/Fhg2vpAM+jF3arJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781293073; c=relaxed/simple;
	bh=qZ+/RF9bNOLqzgDk+otTjsYZXh36UOmrrJHaTMa7Jh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p8xvUEM7TrSlqvCjb9dBQCtxgpzz1J0LUUKVi/D1yDhinDZDWUdrRb9YSPVqST0ebRjGA6FvH4hH5xAHq0oCtwAXV8GQlpAnGPznoOgdRvjDI3pMlNUboP+IOiRzuli6IRpTayl1In9p0gQFAWdjF6WnQAxO5u3DrGDJx8HeV0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qnytHfng; arc=none smtp.client-ip=209.85.210.46
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7e6cfdc8382so1038635a34.2
        for <cgroups@vger.kernel.org>; Fri, 12 Jun 2026 12:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781293069; x=1781897869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9s95lWNsssGrexKzc5Gk3WQ7Nfn1S6PBNhKxMACOqk=;
        b=qnytHfng5KsOUATKksmPbG3DsPB7DAJRZntZNnXLKNwZ02/tWo+svjeJANjPQ40XOV
         0OgQieTLI62LXB98wquHEEcMGUnSwRZN0oBP2q0F35Pmd7YOj6wD+GejUOiAZsT8ml1d
         IGZgm/q38Iz7GdbCknn4PvWiH4g5/clLDAdxYzlcpdKFguoBCoLZBv1YqAHBZ4Y6VQ9C
         ymPYjlGAWz62/WClNnrroBUj5nlOjHqK2kvZCHhDm1EAjbOdWXaLsDPyuD43wZBe4wjT
         7YJSS3lVWtVKPuMtVaoU2STyjye6BacgDNuCdfF2DW9i5VW6q7Zmbsc75fcWn84MScpv
         SNDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781293069; x=1781897869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A9s95lWNsssGrexKzc5Gk3WQ7Nfn1S6PBNhKxMACOqk=;
        b=pc94MnCnM8PPnjM7JML8dfdcolJhW1LjRxeeUulmE12LVjVTSx4oMqQ95lS5rCNSk7
         ELcdXxJ8Q64O3cAZXcetaBIGTELJm9UK5XDb9RDLpcAm3+9dt5Mxt3foysySYx8b6SAJ
         0PqjIGthVdmomoeLlYIutGQBCMTEMDQGueu+OmBzq8FmdB+v/6psGRI8z9EatSw2kscY
         q95aMW9V0WxEAE4CoNOpA0GULBawYTTbIGKv7biR5sI+x+dSjE4kx80Wiyx+P7WtuBiA
         cEwUEiGqq73iaOYgBLJRVlUDnHaodb+dvmNjAaBlBRy9uLJXuJOB84RQFHh02Je4yyyd
         3epQ==
X-Forwarded-Encrypted: i=1; AFNElJ82FlzjW8BpISvMqw4g3Ix4Y7bYdUmGaLbBIfyW/rNubBrBcbb1QyZIP74+Kfra/BxZIA9kY9Ka@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+yEx2DP5J+VpFowUKYFDHWi8bDkIxU2Oa/Gbeg7FhPNGUSW9/
	HV1iUYIslmw2h0gM8prREx6hcAOz5RRD2q8QmqLcqRUyzMahi0g/8a6u
X-Gm-Gg: Acq92OElnsSFfZ72cKKWhCySlUjPPjXcwLfWzWDN/b0SgLHB/Qz/okLr1bMW/XifyhW
	Ns3NXRvD3LRp+QZ5Cm+NtvZhVQrj9/xmVi0BrV6D1pnuyHeqPRUbOoHHTxgy2L1/bOn+7IsfgwI
	TaQJH4O4jKbsA/KsW2ZgaAMAGBgLaYkrrJCCLpJx4sLdEu5ECKn9iL8EAP6+aPaNytMuuR8La3r
	Wy9hfUQ2q4m1/+K0VVZdtt2NwA3ML1Mnx+JannnjxWQvmocRrBgVu4e1l9b0UTilBBLKptONw7M
	oEzvISledB2hzlMkusIBQnMlEZYuRLHWGgEj7LJJJM772qULRE1Laybl+MU7cpHBv+AOXykLruT
	ok+lk9rJ9wClhPQVldyxDfLvZ1IWnxqo5KYndNSeSxlWbkoFfpbUDOyUpCc9qH/f6kp7uzo+Ean
	ihcJs77/EQGI3F2jduyOrq5RLPsgl21LwHEIZQeGiqwupuUQ==
X-Received: by 2002:a05:6830:8389:b0:7dd:b184:1338 with SMTP id 46e09a7af769-7e784746779mr3206503a34.6.1781293069064;
        Fri, 12 Jun 2026 12:37:49 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:72::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e781444b81sm2573874a34.4.2026.06.12.12.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 12:37:48 -0700 (PDT)
From: Nhat Pham <nphamcs@gmail.com>
To: akpm@linux-foundation.org
Cc: chrisl@kernel.org,
	kasong@tencent.com,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	yosry@kernel.org,
	david@kernel.org,
	muchun.song@linux.dev,
	shikemeng@huaweicloud.com,
	baoquan.he@linux.dev,
	baohua@kernel.org,
	youngjun.park@lge.com,
	chengming.zhou@linux.dev,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	qi.zheng@linux.dev,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	riel@surriel.com,
	gourry@gourry.net,
	haowenchao22@gmail.com,
	kernel-team@meta.com,
	nphamcs@gmail.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: [RFC PATCH v2 4/7] mm, swap: only charge physical swap entries
Date: Fri, 12 Jun 2026 12:37:35 -0700
Message-ID: <20260612193738.2183968-5-nphamcs@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260612193738.2183968-1-nphamcs@gmail.com>
References: <20260612193738.2183968-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	FREEMAIL_CC(0.00)[kernel.org,tencent.com,cmpxchg.org,linux.dev,huaweicloud.com,lge.com,infradead.org,google.com,surriel.com,gourry.net,gmail.com,meta.com,kvack.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-16911-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:chrisl@kernel.org,m:kasong@tencent.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:yosry@kernel.org,m:david@kernel.org,m:muchun.song@linux.dev,m:shikemeng@huaweicloud.com,m:baoquan.he@linux.dev,m:baohua@kernel.org,m:youngjun.park@lge.com,m:chengming.zhou@linux.dev,m:ljs@kernel.org,m:liam@infradead.org,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:qi.zheng@linux.dev,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:riel@surriel.com,m:gourry@gourry.net,m:haowenchao22@gmail.com,m:kernel-team@meta.com,m:nphamcs@gmail.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E72B367C16A

Defer the memcg->swap charge for vswap entries from vswap
allocation time to physical-backing allocation time, so
memcg->swap reflects actual on-disk swap usage rather than
virtual swap reservations. Previously, vswap entries were
charged at allocation via mem_cgroup_try_charge_swap regardless
of whether they ever acquired physical backing (zswap and zero
pages do not consume physical swap space).

Split the lifecycle into four operations: record the memcg
private ID at vswap alloc without charging; charge memcg->swap
only when physical backing is allocated via folio_realloc_swap;
uncharge in __vswap_release_backing (only nr_swapfile entries on
v2, all nr on v1 memsw); and drop the ID ref at
__swap_cluster_free_entries without uncharging.

Direct-mapped physical swap charging is unchanged.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/memcontrol.h |   5 ++
 include/linux/swap.h       |  57 +++++++++++++
 mm/memcontrol.c            | 166 +++++++++++++++++++++++++++++++++----
 mm/swapfile.c              | 123 ++++++++++++++++++++++-----
 4 files changed, 313 insertions(+), 38 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index e1f46a0016fc..3e3a3619ae7d 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1846,6 +1846,7 @@ static inline bool memcg_is_dying(struct mem_cgroup *memcg)
 
 #if defined(CONFIG_MEMCG) && defined(CONFIG_ZSWAP)
 bool obj_cgroup_may_zswap(struct obj_cgroup *objcg);
+bool mem_cgroup_may_zswap(struct mem_cgroup *memcg, bool may_flush);
 void obj_cgroup_charge_zswap(struct obj_cgroup *objcg, size_t size);
 void obj_cgroup_uncharge_zswap(struct obj_cgroup *objcg, size_t size);
 bool mem_cgroup_zswap_writeback_enabled(struct mem_cgroup *memcg);
@@ -1854,6 +1855,10 @@ static inline bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
 {
 	return true;
 }
+static inline bool mem_cgroup_may_zswap(struct mem_cgroup *memcg, bool may_flush)
+{
+	return true;
+}
 static inline void obj_cgroup_charge_zswap(struct obj_cgroup *objcg,
 					   size_t size)
 {
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 5162404770bb..2d6bc4cb442f 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -595,6 +595,43 @@ static inline int mem_cgroup_try_charge_swap(struct folio *folio)
 	return __mem_cgroup_try_charge_swap(folio);
 }
 
+extern void __mem_cgroup_record_swap(struct folio *folio);
+static inline void mem_cgroup_record_swap(struct folio *folio)
+{
+	if (mem_cgroup_disabled())
+		return;
+	__mem_cgroup_record_swap(folio);
+}
+
+extern int __mem_cgroup_charge_backing_phys_swap(struct mem_cgroup *memcg,
+					 unsigned int nr_pages);
+static inline int mem_cgroup_charge_backing_phys_swap(struct mem_cgroup *memcg,
+					      unsigned int nr_pages)
+{
+	if (mem_cgroup_disabled())
+		return 0;
+	return __mem_cgroup_charge_backing_phys_swap(memcg, nr_pages);
+}
+
+extern void __mem_cgroup_uncharge_backing_phys_swap(struct mem_cgroup *memcg,
+					    unsigned int nr_pages);
+static inline void mem_cgroup_uncharge_backing_phys_swap(struct mem_cgroup *memcg,
+						 unsigned int nr_pages)
+{
+	if (mem_cgroup_disabled())
+		return;
+	__mem_cgroup_uncharge_backing_phys_swap(memcg, nr_pages);
+}
+
+extern void __mem_cgroup_id_put_swap(unsigned short id, unsigned int nr_pages);
+static inline void mem_cgroup_id_put_swap(unsigned short id,
+					  unsigned int nr_pages)
+{
+	if (mem_cgroup_disabled())
+		return;
+	__mem_cgroup_id_put_swap(id, nr_pages);
+}
+
 extern void __mem_cgroup_uncharge_swap(unsigned short id, unsigned int nr_pages);
 static inline void mem_cgroup_uncharge_swap(unsigned short id, unsigned int nr_pages)
 {
@@ -611,6 +648,26 @@ static inline int mem_cgroup_try_charge_swap(struct folio *folio)
 	return 0;
 }
 
+static inline void mem_cgroup_record_swap(struct folio *folio)
+{
+}
+
+static inline int mem_cgroup_charge_backing_phys_swap(struct mem_cgroup *memcg,
+					      unsigned int nr_pages)
+{
+	return 0;
+}
+
+static inline void mem_cgroup_uncharge_backing_phys_swap(struct mem_cgroup *memcg,
+						 unsigned int nr_pages)
+{
+}
+
+static inline void mem_cgroup_id_put_swap(unsigned short id,
+					  unsigned int nr_pages)
+{
+}
+
 static inline void mem_cgroup_uncharge_swap(unsigned short id,
 					    unsigned int nr_pages)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 56cd4af08232..61c322b2e8b3 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -48,6 +48,7 @@
 #include <linux/rbtree.h>
 #include <linux/slab.h>
 #include <linux/swapops.h>
+#include <linux/zswap.h>
 #include <linux/spinlock.h>
 #include <linux/fs.h>
 #include <linux/seq_file.h>
@@ -5623,6 +5624,116 @@ int __mem_cgroup_try_charge_swap(struct folio *folio)
 	return 0;
 }
 
+/**
+ * __mem_cgroup_record_swap - record memcg for swap without charging
+ * @folio: folio being added to swap
+ *
+ * Pin the memcg private ID ref and record it in the swap cgroup table
+ * without charging memcg->swap; the charge is deferred to physical-backing
+ * allocation (vswap).
+ */
+void __mem_cgroup_record_swap(struct folio *folio)
+{
+	unsigned int nr_pages = folio_nr_pages(folio);
+	struct swap_cluster_info *ci;
+	struct mem_cgroup *memcg;
+	struct obj_cgroup *objcg;
+
+	if (do_memsw_account())
+		return;
+
+	objcg = folio_objcg(folio);
+	VM_WARN_ON_ONCE_FOLIO(!objcg, folio);
+	if (!objcg)
+		return;
+
+	rcu_read_lock();
+	memcg = obj_cgroup_memcg(objcg);
+	if (!folio_test_swapcache(folio)) {
+		rcu_read_unlock();
+		return;
+	}
+
+	memcg = mem_cgroup_private_id_get_online(memcg, nr_pages);
+	rcu_read_unlock();
+
+	ci = swap_cluster_get_and_lock(folio);
+	__swap_cgroup_set(ci, swp_cluster_offset(folio->swap), nr_pages,
+			  mem_cgroup_private_id(memcg));
+	swap_cluster_unlock(ci);
+}
+
+/**
+ * __mem_cgroup_charge_backing_phys_swap - charge memcg->swap counter only
+ * @memcg: the mem_cgroup to charge (may be NULL)
+ * @nr_pages: number of physical swap pages to charge
+ *
+ * Charge the swap counter when a vswap entry gains physical backing. The
+ * private ID ref is already held (pinned by __mem_cgroup_record_swap() at
+ * vswap allocation), so this only moves the counter.
+ *
+ * Returns 0 on success, -ENOMEM on failure.
+ */
+int __mem_cgroup_charge_backing_phys_swap(struct mem_cgroup *memcg,
+				  unsigned int nr_pages)
+{
+	struct page_counter *counter;
+
+	if (do_memsw_account())
+		return 0;
+	if (!memcg)
+		return 0;
+
+	if (!mem_cgroup_is_root(memcg) &&
+	    !page_counter_try_charge(&memcg->swap, nr_pages, &counter)) {
+		memcg_memory_event(memcg, MEMCG_SWAP_MAX);
+		memcg_memory_event(memcg, MEMCG_SWAP_FAIL);
+		return -ENOMEM;
+	}
+	mod_memcg_state(memcg, MEMCG_SWAP, nr_pages);
+	return 0;
+}
+
+/**
+ * __mem_cgroup_uncharge_backing_phys_swap - uncharge memcg->swap counter only
+ * @memcg: the mem_cgroup to uncharge (may be NULL)
+ * @nr_pages: number of physical swap pages to uncharge
+ *
+ * Uncharge the swap counter when physical backing is released. The private
+ * ID ref is dropped separately via __mem_cgroup_id_put_swap() when the
+ * vswap entry is freed.
+ */
+void __mem_cgroup_uncharge_backing_phys_swap(struct mem_cgroup *memcg,
+				     unsigned int nr_pages)
+{
+	if (!memcg)
+		return;
+
+	if (!mem_cgroup_is_root(memcg)) {
+		if (do_memsw_account())
+			page_counter_uncharge(&memcg->memsw, nr_pages);
+		else
+			page_counter_uncharge(&memcg->swap, nr_pages);
+	}
+	mod_memcg_state(memcg, MEMCG_SWAP, -nr_pages);
+}
+
+/**
+ * __mem_cgroup_id_put_swap - drop memcg private ID ref without uncharging
+ * @id: cgroup private id
+ * @nr_pages: number of refs to drop
+ */
+void __mem_cgroup_id_put_swap(unsigned short id, unsigned int nr_pages)
+{
+	struct mem_cgroup *memcg;
+
+	rcu_read_lock();
+	memcg = mem_cgroup_from_private_id(id);
+	if (memcg)
+		mem_cgroup_private_id_put(memcg, nr_pages);
+	rcu_read_unlock();
+}
+
 /**
  * __mem_cgroup_uncharge_swap - uncharge swap space
  * @id: cgroup id to uncharge
@@ -5649,8 +5760,21 @@ void __mem_cgroup_uncharge_swap(unsigned short id, unsigned int nr_pages)
 
 long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg)
 {
-	long nr_swap_pages = get_nr_swap_pages();
+	long nr_swap_pages;
 
+	/*
+	 * vswap charges only physical backing (folio_realloc_swap), not
+	 * allocation. For a zswap-capable memcg virtual swap is unbounded, so
+	 * the swap.max walk below would underestimate it and starve anon
+	 * reclaim; report unbounded. swap.max is still enforced at
+	 * phys-backing charge time.
+	 */
+	if (IS_ENABLED(CONFIG_VSWAP) && zswap_is_enabled() &&
+	    (mem_cgroup_disabled() || do_memsw_account() ||
+	     mem_cgroup_may_zswap(memcg, false)))
+		return PAGE_COUNTER_MAX;
+
+	nr_swap_pages = get_nr_swap_pages();
 	if (mem_cgroup_disabled() || do_memsw_account())
 		return nr_swap_pages;
 	for (; !mem_cgroup_is_root(memcg); memcg = parent_mem_cgroup(memcg))
@@ -5822,8 +5946,10 @@ static struct cftype swap_files[] = {
 
 #ifdef CONFIG_ZSWAP
 /**
- * obj_cgroup_may_zswap - check if this cgroup can zswap
- * @objcg: the object cgroup
+ * mem_cgroup_may_zswap - check if this cgroup hierarchy can zswap
+ * @original_memcg: the memcg to query
+ * @may_flush: force-flush stats for an accurate check (sleeps). Pass false
+ *             from atomic contexts; the check is then best-effort.
  *
  * Check if the hierarchical zswap limit has been reached.
  *
@@ -5833,15 +5959,13 @@ static struct cftype swap_files[] = {
  * spending cycles on compression when there is already no room left
  * or zswap is disabled altogether somewhere in the hierarchy.
  */
-bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
+bool mem_cgroup_may_zswap(struct mem_cgroup *original_memcg, bool may_flush)
 {
-	struct mem_cgroup *memcg, *original_memcg;
-	bool ret = true;
+	struct mem_cgroup *memcg;
 
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		return true;
 
-	original_memcg = get_mem_cgroup_from_objcg(objcg);
 	for (memcg = original_memcg; !mem_cgroup_is_root(memcg);
 	     memcg = parent_mem_cgroup(memcg)) {
 		unsigned long max = READ_ONCE(memcg->zswap_max);
@@ -5849,20 +5973,26 @@ bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
 
 		if (max == PAGE_COUNTER_MAX)
 			continue;
-		if (max == 0) {
-			ret = false;
-			break;
-		}
+		if (max == 0)
+			return false;
 
-		/* Force flush to get accurate stats for charging */
-		__mem_cgroup_flush_stats(memcg, true);
+		if (may_flush)
+			__mem_cgroup_flush_stats(memcg, true);
 		pages = memcg_page_state(memcg, MEMCG_ZSWAP_B) / PAGE_SIZE;
-		if (pages < max)
-			continue;
-		ret = false;
-		break;
+		if (pages >= max)
+			return false;
 	}
-	mem_cgroup_put(original_memcg);
+	return true;
+}
+
+bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
+{
+	struct mem_cgroup *memcg;
+	bool ret;
+
+	memcg = get_mem_cgroup_from_objcg(objcg);
+	ret = mem_cgroup_may_zswap(memcg, true);
+	mem_cgroup_put(memcg);
 	return ret;
 }
 
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 18c53117503d..abf6414c01c9 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -46,6 +46,7 @@
 
 #include <asm/tlbflush.h>
 #include <linux/leafops.h>
+#include "memcontrol-v1.h"
 #include "swap_table.h"
 #include "vswap.h"
 #include "internal.h"
@@ -2088,8 +2089,15 @@ int folio_alloc_swap(struct folio *folio)
 			goto again;
 	}
 
-	/* Need to call this even if allocation failed, for MEMCG_SWAP_FAIL. */
-	if (unlikely(mem_cgroup_try_charge_swap(folio)))
+	/*
+	 * Vswap entries: record memcg ID without charging - the charge is
+	 * deferred to folio_realloc_swap when physical backing is allocated.
+	 * Direct-mapped physical swap entries: charge immediately as today.
+	 */
+	if (folio_test_swapcache(folio) &&
+	    is_vswap_entry(folio->swap))
+		mem_cgroup_record_swap(folio);
+	else if (unlikely(mem_cgroup_try_charge_swap(folio)))
 		swap_cache_del_folio(folio);
 
 	if (unlikely(!folio_test_swapcache(folio)))
@@ -2178,6 +2186,26 @@ static void __swap_cluster_free_phys_backing(struct swap_info_struct *psi,
 					     unsigned int ci_start,
 					     unsigned int nr_pages);
 
+static void vswap_uncharge_cgroup_batch(unsigned short memcg_id,
+					unsigned int batch_nr,
+					unsigned int batch_nr_swapfile)
+{
+	struct mem_cgroup *memcg;
+	unsigned int n;
+
+	if (do_memsw_account())
+		n = batch_nr;
+	else
+		n = batch_nr_swapfile;
+	if (!n)
+		return;
+
+	rcu_read_lock();
+	memcg = memcg_id ? mem_cgroup_from_private_id(memcg_id) : NULL;
+	rcu_read_unlock();
+	mem_cgroup_uncharge_backing_phys_swap(memcg, n);
+}
+
 void __vswap_release_backing(struct swap_cluster_info *ci,
 			     unsigned int ci_start, unsigned int nr)
 {
@@ -2188,12 +2216,36 @@ void __vswap_release_backing(struct swap_cluster_info *ci,
 	unsigned int ci_off;
 	unsigned long vt;
 	swp_entry_t phys;
+	/*
+	 * Per-cgroup uncharge batching: a single __vswap_release_backing
+	 * range can span multiple cgroups (e.g. __swap_cluster_free_entries
+	 * batches across folios), so we cannot uncharge with the first
+	 * slot's memcg for the whole range.
+	 */
+	unsigned short batch_id;
+	unsigned int batch_nr = 0, batch_nr_swapfile = 0;
 
 	lockdep_assert_held(&ci->lock);
 	ci_dyn = container_of(ci, struct swap_cluster_info_dynamic, ci);
+	batch_id = __swap_cgroup_get(ci, ci_start);
 
 	for (ci_off = ci_start; ci_off < ci_start + nr; ci_off++) {
+		unsigned short cur_id;
+
 		vt = __vtable_get(ci_dyn, ci_off);
+		cur_id = __swap_cgroup_get(ci, ci_off);
+
+		/*
+		 * Flush per-cgroup uncharge when crossing a cgroup boundary.
+		 */
+		if (cur_id != batch_id) {
+			vswap_uncharge_cgroup_batch(batch_id, batch_nr,
+						    batch_nr_swapfile);
+			batch_id = cur_id;
+			batch_nr = 0;
+			batch_nr_swapfile = 0;
+		}
+		batch_nr++;
 
 		/*
 		 * Flush batched physical slots when the next entry
@@ -2217,6 +2269,7 @@ void __vswap_release_backing(struct swap_cluster_info *ci,
 
 		switch (vtable_type(vt)) {
 		case VSWAP_SWAPFILE:
+			batch_nr_swapfile++;
 			if (phys_start == phys_end) {
 				phys = vtable_to_phys(vt);
 				phys_start = swp_offset(phys);
@@ -2250,6 +2303,9 @@ void __vswap_release_backing(struct swap_cluster_info *ci,
 			phys_start % SWAPFILE_CLUSTER,
 			phys_end - phys_start);
 	}
+
+	/* Final cgroup-batch flush. */
+	vswap_uncharge_cgroup_batch(batch_id, batch_nr, batch_nr_swapfile);
 }
 
 /**
@@ -2342,7 +2398,10 @@ swp_entry_t folio_realloc_swap(struct folio *folio)
 	swp_entry_t vswap_entry = folio->swap;
 	struct swap_cluster_info *ci;
 	struct swap_cluster_info_dynamic *ci_dyn;
+	struct mem_cgroup *memcg;
 	unsigned int voff;
+	unsigned long vt;
+	unsigned short memcg_id;
 	swp_entry_t phys_entry = {};
 	swp_entry_t pe;
 	int i, nr = folio_nr_pages(folio);
@@ -2351,9 +2410,18 @@ swp_entry_t folio_realloc_swap(struct folio *folio)
 	VM_BUG_ON_FOLIO(!folio_test_swapcache(folio), folio);
 	VM_WARN_ON(!is_vswap_entry(vswap_entry));
 
-	phys_entry = vswap_to_phys(vswap_entry);
-	if (phys_entry.val)
-		return phys_entry;
+	voff = swp_cluster_offset(vswap_entry);
+	ci = __swap_entry_to_cluster(vswap_entry);
+	ci_dyn = container_of(ci, struct swap_cluster_info_dynamic, ci);
+
+	spin_lock(&ci->lock);
+	vt = __vtable_get(ci_dyn, voff);
+	if (vtable_type(vt) == VSWAP_SWAPFILE) {
+		spin_unlock(&ci->lock);
+		return vtable_to_phys(vt);
+	}
+	memcg_id = __swap_cgroup_get(ci, voff);
+	spin_unlock(&ci->lock);
 
 	local_lock(&percpu_swap_cluster.lock);
 	phys_entry = swap_alloc_fast(folio);
@@ -2364,10 +2432,20 @@ swp_entry_t folio_realloc_swap(struct folio *folio)
 	if (!phys_entry.val)
 		return (swp_entry_t){};
 
-	voff = swp_cluster_offset(vswap_entry);
+	rcu_read_lock();
+	memcg = folio_memcg(folio);
+	if (!memcg || mem_cgroup_private_id(memcg) != memcg_id)
+		memcg = memcg_id ? mem_cgroup_from_private_id(memcg_id) : NULL;
+	rcu_read_unlock();
+
+	if (mem_cgroup_charge_backing_phys_swap(memcg, nr)) {
+		__swap_cluster_free_phys_backing(
+			__swap_entry_to_info(phys_entry),
+			__swap_entry_to_cluster(phys_entry),
+			swp_cluster_offset(phys_entry), nr);
+		return (swp_entry_t){};
+	}
 
-	ci = __swap_entry_to_cluster(vswap_entry);
-	ci_dyn = container_of(ci, struct swap_cluster_info_dynamic, ci);
 	spin_lock(&ci->lock);
 	/*
 	 * Install PHYS backing without freeing any prior contents of the
@@ -2560,19 +2638,13 @@ static void __swap_cluster_finish_free(struct swap_info_struct *si,
 /*
  * Free physical swap slots that were backing vswap entries (Pointer-tagged).
  * Clears the physical swap table, decrements cluster count, and does
- * device-level accounting. Called from folio_release_vswap_backing.
+ * device-level accounting.
  */
 static void __swap_cluster_free_phys_backing(struct swap_info_struct *psi,
 					     struct swap_cluster_info *pci,
 					     unsigned int ci_start,
 					     unsigned int nr_pages)
 {
-	/*
-	 * Caller holds the vswap cluster lock (asserted in
-	 * folio_release_vswap_backing). Nest the physical cluster lock under it
-	 * - same lockdep class, so use SINGLE_DEPTH_NESTING to silence
-	 * PROVE_LOCKING.
-	 */
 	spin_lock_nested(&pci->lock, SINGLE_DEPTH_NESTING);
 	VM_WARN_ON(pci->count < nr_pages);
 	pci->count -= nr_pages;
@@ -2590,10 +2662,11 @@ void __swap_cluster_free_entries(struct swap_info_struct *si,
 	unsigned short batch_id = 0, id_cur;
 	unsigned int ci_off = ci_start, ci_end = ci_start + nr_pages;
 	unsigned int batch_off = ci_off;
+	bool is_vswap = swap_is_vswap(si);
 
 	VM_WARN_ON(ci->count < nr_pages);
 
-	if (swap_is_vswap(si))
+	if (is_vswap)
 		__vswap_release_backing(ci, ci_start, nr_pages);
 
 	ci->count -= nr_pages;
@@ -2613,18 +2686,28 @@ void __swap_cluster_free_entries(struct swap_info_struct *si,
 		/*
 		 * Uncharge swap slots by memcg in batches. Consecutive
 		 * slots with the same cgroup id are uncharged together.
+		 * For vswap, only drop the ID ref - physical swap was
+		 * already uncharged in __vswap_release_backing above.
 		 */
 		id_cur = __swap_cgroup_clear(ci, ci_off, 1);
 		if (batch_id != id_cur) {
-			if (batch_id)
-				mem_cgroup_uncharge_swap(batch_id, ci_off - batch_off);
+			if (batch_id) {
+				if (is_vswap)
+					mem_cgroup_id_put_swap(batch_id, ci_off - batch_off);
+				else
+					mem_cgroup_uncharge_swap(batch_id, ci_off - batch_off);
+			}
 			batch_id = id_cur;
 			batch_off = ci_off;
 		}
 	} while (++ci_off < ci_end);
 
-	if (batch_id)
-		mem_cgroup_uncharge_swap(batch_id, ci_off - batch_off);
+	if (batch_id) {
+		if (is_vswap)
+			mem_cgroup_id_put_swap(batch_id, ci_off - batch_off);
+		else
+			mem_cgroup_uncharge_swap(batch_id, ci_off - batch_off);
+	}
 
 	__swap_cluster_finish_free(si, ci, ci_start, nr_pages);
 }
-- 
2.53.0-Meta


