Return-Path: <cgroups+bounces-14770-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLxxCjXIsWnvFAAAu9opvQ
	(envelope-from <cgroups+bounces-14770-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 20:53:25 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D193269A7E
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 20:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 884753028659
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 19:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB645385505;
	Wed, 11 Mar 2026 19:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="foAkeCW2"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D1638237F
	for <cgroups@vger.kernel.org>; Wed, 11 Mar 2026 19:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773258730; cv=none; b=COz2y6f8iKvLotc27DluUrZLIALe8nbqJx1qqv+CCUEzIJPryXWgqBzg8jUMDKi3ITAN4M+ZJci0evnl1YcMbfH+v72kGY2IpSocr9QuX5FF0X098D30qFxz6WSXUYIiR4M0huURdOfjTn0t3hSCCwZY55x0jT6C1dfB7ETQNDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773258730; c=relaxed/simple;
	bh=ltWZnUnXeRVqYVTEBtTy0eYCoDdqibyFZCtqJ7qUlq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rIwnPe3uGMfqUsyXNOrdh9Z/gfEmmyXfQcOyGir5VXdo+f3ckjXhD/DFBGSnq39Ja+pl0zaySAwi6Tvw4gwpNqO2axMJQYQkbDKZBNBD0u3dS1CJvY7unZ+NhEdl8sFds014UvN+vSzsNDxSvrDpdHfyWyjopVtzxjDBcE3J6lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=foAkeCW2; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-41708f6c3feso189562fac.3
        for <cgroups@vger.kernel.org>; Wed, 11 Mar 2026 12:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773258724; x=1773863524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8u5o092L3ULCpmoipnWOnXiIPpIcwoMHmpMXH/cA6Oo=;
        b=foAkeCW2rLG48Jt1YjeSANAiyq3bdHTJ6/zTw+Sp677+qvV0xiPJ9PKZgczYzHi8NC
         e6ZQtHTwqyOaL4gEXamXx/JzgULF/0zGxwKfmqo2iEQ48VEo4hvVzUnV2VnFSAvEX47+
         4eBiEIP00POoi2ATzv4xQDaVA3s+CdtbqqEBspnJM5se/YZ60Be158amBJHcE38W2/UI
         ZU4Rs/QbF5TIlNTeg/ugHB9ShVS5lUO4mDK4zoSCwYvXg2sgfQ44825xzs9rLrrh6pqm
         igf02XDUUHdA22HqjVXojxGx0mN99w+tu0gSD8RwQX+Nu/ld7HvLsbb7DUP8V23ZcDi6
         FZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773258724; x=1773863524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8u5o092L3ULCpmoipnWOnXiIPpIcwoMHmpMXH/cA6Oo=;
        b=pqih3zqCDoNY0q+UbdLP8BKagihCo4gnqXWX2oMws9tIfBbbQ5P/AXfqUxp9jtKYka
         uyKUNrsof1LMuLAp4Ah/0+fzhT/8v1ycKgGlXyXTuH0jWXk6o1oQSQeYg/dQ/qptyH/m
         u4Ljnoon6ejdOglgpA3zGEJOc+ortOFDVrVzQ1ifWdn3d4hszzjDEfu4+RRnTg90g9QE
         EIrYADAmdFaIF2N1zkFB5Xi2BO111a8Qvc4EfoqlB3zuQavvhR/3+d5Z62GCVjis6D/Z
         oJFYCYF0qlxFEQ0bgNYdIZ7zwIOsZ+DK6Qncpq16F+pMdKzqkSKttOP1/6Yv9NYaU6nv
         Pavg==
X-Forwarded-Encrypted: i=1; AJvYcCU6ZyG8pC5oR6s4eMjWE7MZtaWmsb7lBwofPlZ/XG9726eEmmeurL2QPGfNfcDMdU5w0Rq1TPOV@vger.kernel.org
X-Gm-Message-State: AOJu0YzzDOb2aqUNj4fbS7+e69VSgRyy4I1HE8tH+/0iY8rOecMfE8WZ
	bQeXwIkRmTdaO+xDZv+tGvvSeA5fp7siwIZF2j4TKSNqvPO8otZ5Lj4J
X-Gm-Gg: ATEYQzzngs+sfYg/Be2p1AZVHEDfCGjozI8qIfEqTYP7/BEoDQN/qA1QKDgBG/kxsY9
	JIpOM+dY9nWTP8AjoYNOmi8hr0dBdelKLx9x4u9siAoB6TrR5RnLRc0ejjU+l/HJeQDPQTcOSJI
	nS6g8uo4PfxlQqib29EmnkgT1Znq1Gns0GHncOGr/pj6/apgtwTr98J3izh25AiIF9tBZYJwiFU
	YQaq0H3umPhZUscXk7U9mdiakKd6BCP2it1PDx/LomrKPyW0FoHNl/joSr2tO5Hr6jgpZKrxMPn
	JpzBndWLqRjJy7yx56tku/UzPceZm7iAdun/P0c2gVFK8Q/mqEoHS1p/1YjlPQkrF2TX3QGqYW7
	Zd7dqprtybqlneINgMQGyhheUor9sAOFXzFdNX6lNl6/2+fX9gtGgDd0QQKrdqMOD/cy1+QCQY8
	qU6r8PFcZARR+wj67ij7j9ag==
X-Received: by 2002:a05:6870:169d:b0:3fa:eb8:4c92 with SMTP id 586e51a60fabf-4177c9c1dd0mr2187825fac.50.1773258724198;
        Wed, 11 Mar 2026 12:52:04 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:46::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e6e82cdsm3116391fac.18.2026.03.11.12.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 12:52:03 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Nhat Pham <hoangnhat.pham@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 07/11] mm/zsmalloc, zswap: Handle objcg charging and lifetime in zsmalloc
Date: Wed, 11 Mar 2026 12:51:44 -0700
Message-ID: <20260311195153.4013476-8-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260311195153.4013476-1-joshua.hahnjy@gmail.com>
References: <20260311195153.4013476-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,linux.dev,gmail.com,kernel.org,linux-foundation.org,vger.kernel.org,kvack.org,meta.com];
	TAGGED_FROM(0.00)[bounces-14770-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9D193269A7E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Now that zswap_entries do not directly track obj_cgroups of the entries,
handle the lifetime management and charging of these entries into the
zsmalloc layer.

One functional change is that zswap entries are now no longer accounted
by the size of the compressed object, but by the size of the size_class
slot they occupy.

This brings charging one step closer to an accurate representation of
the memory consumed in the zpdesc; even if a compressed object doesn't
consume the entirety of a obj slot, we should account the entirety of
the compressed object slot that the object makes unusable.

While at it, also remove an unnecessary newline in obj_free.

Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 include/linux/memcontrol.h | 10 ------
 mm/memcontrol.c            | 54 ++-----------------------------
 mm/zsmalloc.c              | 65 ++++++++++++++++++++++++++++++++++++--
 mm/zswap.c                 |  8 -----
 4 files changed, 66 insertions(+), 71 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0652db4ff2d5..701d9ab6fef1 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1851,22 +1851,12 @@ static inline bool memcg_is_dying(struct mem_cgroup *memcg)
 
 #if defined(CONFIG_MEMCG) && defined(CONFIG_ZSWAP)
 bool obj_cgroup_may_zswap(struct obj_cgroup *objcg);
-void obj_cgroup_charge_zswap(struct obj_cgroup *objcg, size_t size);
-void obj_cgroup_uncharge_zswap(struct obj_cgroup *objcg, size_t size);
 bool mem_cgroup_zswap_writeback_enabled(struct mem_cgroup *memcg);
 #else
 static inline bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
 {
 	return true;
 }
-static inline void obj_cgroup_charge_zswap(struct obj_cgroup *objcg,
-					   size_t size)
-{
-}
-static inline void obj_cgroup_uncharge_zswap(struct obj_cgroup *objcg,
-					     size_t size)
-{
-}
 static inline bool mem_cgroup_zswap_writeback_enabled(struct mem_cgroup *memcg)
 {
 	/* if zswap is disabled, do not block pages going to the swapping device */
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a52da3a5e4fd..68139be66a4f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -716,6 +716,7 @@ void mod_memcg_state(struct mem_cgroup *memcg, enum memcg_stat_item idx,
 
 	put_cpu();
 }
+EXPORT_SYMBOL(mod_memcg_state);
 
 #ifdef CONFIG_MEMCG_V1
 /* idx can be of type enum memcg_stat_item or node_stat_item. */
@@ -3169,11 +3170,13 @@ int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size)
 {
 	return obj_cgroup_charge_account(objcg, gfp, size, NULL, 0);
 }
+EXPORT_SYMBOL(obj_cgroup_charge);
 
 void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size)
 {
 	refill_obj_stock(objcg, size, true, 0, NULL, 0);
 }
+EXPORT_SYMBOL(obj_cgroup_uncharge);
 
 static inline size_t obj_full_size(struct kmem_cache *s)
 {
@@ -5488,57 +5491,6 @@ bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
 	return ret;
 }
 
-/**
- * obj_cgroup_charge_zswap - charge compression backend memory
- * @objcg: the object cgroup
- * @size: size of compressed object
- *
- * This forces the charge after obj_cgroup_may_zswap() allowed
- * compression and storage in zswap for this cgroup to go ahead.
- */
-void obj_cgroup_charge_zswap(struct obj_cgroup *objcg, size_t size)
-{
-	struct mem_cgroup *memcg;
-
-	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
-		return;
-
-	VM_WARN_ON_ONCE(!(current->flags & PF_MEMALLOC));
-
-	/* PF_MEMALLOC context, charging must succeed */
-	if (obj_cgroup_charge(objcg, GFP_KERNEL, size))
-		VM_WARN_ON_ONCE(1);
-
-	rcu_read_lock();
-	memcg = obj_cgroup_memcg(objcg);
-	mod_memcg_state(memcg, MEMCG_ZSWAP_B, size);
-	mod_memcg_state(memcg, MEMCG_ZSWAPPED, 1);
-	rcu_read_unlock();
-}
-
-/**
- * obj_cgroup_uncharge_zswap - uncharge compression backend memory
- * @objcg: the object cgroup
- * @size: size of compressed object
- *
- * Uncharges zswap memory on page in.
- */
-void obj_cgroup_uncharge_zswap(struct obj_cgroup *objcg, size_t size)
-{
-	struct mem_cgroup *memcg;
-
-	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
-		return;
-
-	obj_cgroup_uncharge(objcg, size);
-
-	rcu_read_lock();
-	memcg = obj_cgroup_memcg(objcg);
-	mod_memcg_state(memcg, MEMCG_ZSWAP_B, -size);
-	mod_memcg_state(memcg, MEMCG_ZSWAPPED, -1);
-	rcu_read_unlock();
-}
-
 bool mem_cgroup_zswap_writeback_enabled(struct mem_cgroup *memcg)
 {
 	/* if zswap is disabled, do not block pages going to the swapping device */
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index a94ca8c26ad9..291194572a09 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1028,6 +1028,59 @@ static bool zspage_empty(struct zspage *zspage)
 	return get_zspage_inuse(zspage) == 0;
 }
 
+#ifdef CONFIG_MEMCG
+static void zs_charge_objcg(struct zs_pool *pool, struct obj_cgroup *objcg,
+			    int size)
+{
+	struct mem_cgroup *memcg;
+
+	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
+		return;
+
+	VM_WARN_ON_ONCE(!(current->flags & PF_MEMALLOC));
+	WARN_ON_ONCE(!pool->memcg_aware);
+
+	/* PF_MEMALLOC context, charging must succeed */
+	if (obj_cgroup_charge(objcg, GFP_KERNEL, size))
+		VM_WARN_ON_ONCE(1);
+
+	rcu_read_lock();
+	memcg = obj_cgroup_memcg(objcg);
+	mod_memcg_state(memcg, pool->compressed_stat, size);
+	mod_memcg_state(memcg, pool->uncompressed_stat, 1);
+	rcu_read_unlock();
+}
+
+static void zs_uncharge_objcg(struct zs_pool *pool, struct obj_cgroup *objcg,
+			      int size)
+{
+	struct mem_cgroup *memcg;
+
+	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
+		return;
+
+	WARN_ON_ONCE(!pool->memcg_aware);
+
+	obj_cgroup_uncharge(objcg, size);
+
+	rcu_read_lock();
+	memcg = obj_cgroup_memcg(objcg);
+	mod_memcg_state(memcg, pool->compressed_stat, -size);
+	mod_memcg_state(memcg, pool->uncompressed_stat, -1);
+	rcu_read_unlock();
+}
+#else
+static void zs_charge_objcg(struct zs_pool *pool, struct obj_cgroup *objcg,
+			    int size)
+{
+}
+
+static void zs_uncharge_objcg(struct zs_pool *pool, struct obj_cgroup *objcg,
+			      int size)
+{
+}
+#endif
+
 /**
  * zs_lookup_class_index() - Returns index of the zsmalloc &size_class
  * that hold objects of the provided size.
@@ -1244,6 +1297,8 @@ void zs_obj_write(struct zs_pool *pool, unsigned long handle,
 	if (objcg) {
 		WARN_ON_ONCE(!pool->memcg_aware);
 		zspage->objcgs[obj_idx] = objcg;
+		obj_cgroup_get(objcg);
+		zs_charge_objcg(pool, objcg, class->size);
 	}
 
 	if (!ZsHugePage(zspage))
@@ -1409,17 +1464,23 @@ static void obj_free(int class_size, unsigned long obj)
 	struct link_free *link;
 	struct zspage *zspage;
 	struct zpdesc *f_zpdesc;
+	struct zs_pool *pool;
 	unsigned long f_offset;
 	unsigned int f_objidx;
 	void *vaddr;
 
-
 	obj_to_location(obj, &f_zpdesc, &f_objidx);
 	f_offset = offset_in_page(class_size * f_objidx);
 	zspage = get_zspage(f_zpdesc);
+	pool = zspage->pool;
+
+	if (pool->memcg_aware && zspage->objcgs[f_objidx]) {
+		struct obj_cgroup *objcg = zspage->objcgs[f_objidx];
 
-	if (zspage->pool->memcg_aware)
+		zs_uncharge_objcg(pool, objcg, class_size);
+		obj_cgroup_put(objcg);
 		zspage->objcgs[f_objidx] = NULL;
+	}
 
 	vaddr = kmap_local_zpdesc(f_zpdesc);
 	link = (struct link_free *)(vaddr + f_offset);
diff --git a/mm/zswap.c b/mm/zswap.c
index 436066965413..bca29a6e18f3 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -711,10 +711,6 @@ static void zswap_entry_free(struct zswap_entry *entry)
 	zswap_lru_del(&zswap_list_lru, entry, objcg);
 	zs_free(entry->pool->zs_pool, entry->handle);
 	zswap_pool_put(entry->pool);
-	if (objcg) {
-		obj_cgroup_uncharge_zswap(objcg, entry->length);
-		obj_cgroup_put(objcg);
-	}
 	if (entry->length == PAGE_SIZE)
 		atomic_long_dec(&zswap_stored_incompressible_pages);
 	zswap_entry_cache_free(entry);
@@ -1437,10 +1433,6 @@ static bool zswap_store_page(struct page *page,
 	 * when the entry is removed from the tree.
 	 */
 	zswap_pool_get(pool);
-	if (objcg) {
-		obj_cgroup_get(objcg);
-		obj_cgroup_charge_zswap(objcg, entry->length);
-	}
 	atomic_long_inc(&zswap_stored_pages);
 	if (entry->length == PAGE_SIZE)
 		atomic_long_inc(&zswap_stored_incompressible_pages);
-- 
2.52.0


