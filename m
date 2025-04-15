Return-Path: <cgroups+bounces-7573-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1962A8923C
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 04:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E39E117DB6E
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 02:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72403220694;
	Tue, 15 Apr 2025 02:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="kNei1fmG"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273772356BC
	for <cgroups@vger.kernel.org>; Tue, 15 Apr 2025 02:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744685304; cv=none; b=nnI7xe7c31TK/pBrMDWLvA5P9Ley3K2pjcDVJ9wtglBg/eNCWd2FpBDVJXMGI2AntUCUq6ifUNycXJ2HkOtcjNzFIL8dGLi7elNipBu5ZaD07pGwFNP8nu6k2VwjzpgVbJ+CvX+qWzMXpTRTGgrY0GCMLyaX3aXpklhzjtQT0Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744685304; c=relaxed/simple;
	bh=H0r0s+aNVtABcImPElCvxEcapJXkAeLu6EgaDJbCxCA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XOUGpG/X/XGGTbVqXvH3L6mLS51HU3KsNeL5mKWwBUKQt5JwPAomJXpj8ZUvuXqGANSzzdDGt+KEe/yyPUdgBGDNbxOblJnkmI7AgyyL1Vpqt7mIVxQHI4F0PqGxHWXAjVBh4Emn7pIVxG1iTvUP977IfDv7mSrXYBlDR9zGIik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=kNei1fmG; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ff615a114bso5113041a91.0
        for <cgroups@vger.kernel.org>; Mon, 14 Apr 2025 19:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1744685301; x=1745290101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/5hAkTeajZjUlhSwkD9bqooCoCo2zpB/VByckb93fwU=;
        b=kNei1fmGe10RFBA5v5bcBI9E8P9ZVE4NpwYjRNcsOPkDdAJK5g8MiIk9/ESvHmbXek
         QnEaS7uQDNVLv9quBlm9CP8plUikUG4DQIO3KlVoDfhGmrebuJWVIQQM4V3nH2i73DCt
         2oUBPFzb+W0TcbESzzaLVDEUbjm/7hJeSJ4717axwQySJQKMzxwWz6uVdAt3ANlh12Bd
         +vdKhRIHVoG+jrzeLSzbQCXIw8vL41YojA+5tklb1AEbGYgjFmjf2ZFul4Nw8SUTnesZ
         40bxlC2VpWmqKO29rtvyMy0vtjaYKpVGABh5l+NFkdp/OwlUI17OLbVKxRyD2w7PPxlt
         y++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744685301; x=1745290101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/5hAkTeajZjUlhSwkD9bqooCoCo2zpB/VByckb93fwU=;
        b=hBtBw357MR9NR5xciitsb5MWWc40EAP/BjtLPlaLwJUp1V/Aph8ZapMeHc7d/L9itk
         CXeZ6EopPxEt6+PXar+cDSZ1z0thAxOPPCeEkDmdJS4h7qKEmNASQmOc3qLIVVopfC4G
         JO8cKG+PRBpBl8m/eTo3/GCYqOah4NzB0oTT45K/mjFt3a57PW0NmNrm0AJozEkpfjCj
         0ib7eFvATu2LlE/eRRSIifpcbPIvlziEILEKoD660PDs9n6OC0wniOrsDXY/eJOWGYXZ
         CNVw39+Xmv+x/HQ6zHDKn9AYV8MBGhzUPOiJ8PbkYfDB8aOTmF97SQwAqxzhhsaUtVcW
         EBGw==
X-Forwarded-Encrypted: i=1; AJvYcCUuU53x3uBcw4EYY8pPAMzwE4+yQP3PMrdHoSKYYquU8FJVtzHM/q8io3lNxVdx67K+4BozEMWi@vger.kernel.org
X-Gm-Message-State: AOJu0YxGHgSpUCwVWgMchjYnXpi6mUlojLO50jzZe0F3zlc5CPuOHVgK
	Fqz2+XXdg4WysvuGV2zHnkHa4t1IUhxprQOc+2jWFaQ8Qw/Y94wIxzv/4espv3M=
X-Gm-Gg: ASbGncuaK0Ua4aTluGDnBa1ew4XGL6DSKFKdlCOUsAWNQkTkDeP1Lucz1xNjN59z4pn
	r4QkA8CIAhmMB5SK0F4D9D3xpWV3lzXxkc+l2AsGb8QJDJm+ihVBaJN9JqfEmt3yAOvhgqPMYnb
	uYyaaF1hkjbL8v+VIC26O0uowKCHKFJRQ8ApViq26rBzhoOEpLiDXkkaXPKC6SmvtaWx+HHPPVv
	z171x9ZYDvr0apJX6+SsJk6QXWAwZp2csC4A+HhGBi7/dvCYslCWAcu0mFDRvDbKbUbHCQb1BJ6
	iXuMV/+l4TcTQXC/Wc464WWMv7GYFMSIBjfWsXsZ7y+5Dlh6Hr9xlcuslTEtMoR3aM6/mT5j
X-Google-Smtp-Source: AGHT+IHCiWoDN+bE/e12Bjpe86h+z5c2l97IYpJx1vPLZfIiCxp0ezSHDN9cZFtMGTkakWuJkAZr7g==
X-Received: by 2002:a17:90b:2dcd:b0:306:b593:455e with SMTP id 98e67ed59e1d1-3084f306f84mr2571647a91.1.1744685301315;
        Mon, 14 Apr 2025 19:48:21 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7ccac49sm106681185ad.217.2025.04.14.19.48.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Apr 2025 19:48:20 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	david@fromorbit.com,
	zhengqi.arch@bytedance.com,
	yosry.ahmed@linux.dev,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH RFC 27/28] mm: memcontrol: eliminate the problem of dying memory cgroup for LRU folios
Date: Tue, 15 Apr 2025 10:45:31 +0800
Message-Id: <20250415024532.26632-28-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250415024532.26632-1-songmuchun@bytedance.com>
References: <20250415024532.26632-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pagecache pages are charged at allocation time and hold a reference
to the original memory cgroup until reclaimed. Depending on memory
pressure, page sharing patterns between different cgroups and cgroup
creation/destruction rates, many dying memory cgroups can be pinned
by pagecache pages, reducing page reclaim efficiency and wasting
memory. Converting LRU folios and most other raw memory cgroup pins
to the object cgroup direction can fix this long-living problem.

Finally, folio->memcg_data of LRU folios and kmem folios will always
point to an object cgroup pointer. The folio->memcg_data of slab
folios will point to an vector of object cgroups.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/memcontrol.h |  78 +++++--------
 mm/huge_memory.c           |  33 ++++++
 mm/memcontrol-v1.c         |  15 ++-
 mm/memcontrol.c            | 228 +++++++++++++++++++++++++------------
 4 files changed, 222 insertions(+), 132 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0e450623f8fa..7b1279963c0c 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -368,9 +368,6 @@ enum objext_flags {
 #define OBJEXTS_FLAGS_MASK (__NR_OBJEXTS_FLAGS - 1)
 
 #ifdef CONFIG_MEMCG
-
-static inline bool folio_memcg_kmem(struct folio *folio);
-
 /*
  * After the initialization objcg->memcg is always pointing at
  * a valid memcg, but can be atomically swapped to the parent memcg.
@@ -384,43 +381,19 @@ static inline struct mem_cgroup *obj_cgroup_memcg(struct obj_cgroup *objcg)
 }
 
 /*
- * __folio_memcg - Get the memory cgroup associated with a non-kmem folio
- * @folio: Pointer to the folio.
- *
- * Returns a pointer to the memory cgroup associated with the folio,
- * or NULL. This function assumes that the folio is known to have a
- * proper memory cgroup pointer. It's not safe to call this function
- * against some type of folios, e.g. slab folios or ex-slab folios or
- * kmem folios.
- */
-static inline struct mem_cgroup *__folio_memcg(struct folio *folio)
-{
-	unsigned long memcg_data = folio->memcg_data;
-
-	VM_BUG_ON_FOLIO(folio_test_slab(folio), folio);
-	VM_BUG_ON_FOLIO(memcg_data & MEMCG_DATA_OBJEXTS, folio);
-	VM_BUG_ON_FOLIO(memcg_data & MEMCG_DATA_KMEM, folio);
-
-	return (struct mem_cgroup *)(memcg_data & ~OBJEXTS_FLAGS_MASK);
-}
-
-/*
- * __folio_objcg - get the object cgroup associated with a kmem folio.
+ * folio_objcg - get the object cgroup associated with a folio.
  * @folio: Pointer to the folio.
  *
  * Returns a pointer to the object cgroup associated with the folio,
  * or NULL. This function assumes that the folio is known to have a
- * proper object cgroup pointer. It's not safe to call this function
- * against some type of folios, e.g. slab folios or ex-slab folios or
- * LRU folios.
+ * proper object cgroup pointer.
  */
-static inline struct obj_cgroup *__folio_objcg(struct folio *folio)
+static inline struct obj_cgroup *folio_objcg(struct folio *folio)
 {
 	unsigned long memcg_data = folio->memcg_data;
 
 	VM_BUG_ON_FOLIO(folio_test_slab(folio), folio);
 	VM_BUG_ON_FOLIO(memcg_data & MEMCG_DATA_OBJEXTS, folio);
-	VM_BUG_ON_FOLIO(!(memcg_data & MEMCG_DATA_KMEM), folio);
 
 	return (struct obj_cgroup *)(memcg_data & ~OBJEXTS_FLAGS_MASK);
 }
@@ -434,21 +407,31 @@ static inline struct obj_cgroup *__folio_objcg(struct folio *folio)
  * proper memory cgroup pointer. It's not safe to call this function
  * against some type of folios, e.g. slab folios or ex-slab folios.
  *
- * For a non-kmem folio any of the following ensures folio and memcg binding
- * stability:
+ * For a folio any of the following ensures folio and objcg binding stability:
  *
  * - the folio lock
  * - LRU isolation
  * - exclusive reference
  *
- * For a kmem folio a caller should hold an rcu read lock to protect memcg
- * associated with a kmem folio from being released.
+ * Based on the stable binding of folio and objcg, for a folio any of the
+ * following ensures folio and memcg binding stability:
+ *
+ * - cgroup_mutex
+ * - the lruvec lock
+ * - the split queue lock (only THP page)
+ *
+ * If the caller only want to ensure that the page counters of memcg are
+ * updated correctly, ensure that the binding stability of folio and objcg
+ * is sufficient.
+ *
+ * Note: The caller should hold an rcu read lock or cgroup_mutex to protect
+ * memcg associated with a folio from being released.
  */
 static inline struct mem_cgroup *folio_memcg(struct folio *folio)
 {
-	if (folio_memcg_kmem(folio))
-		return obj_cgroup_memcg(__folio_objcg(folio));
-	return __folio_memcg(folio);
+	struct obj_cgroup *objcg = folio_objcg(folio);
+
+	return objcg ? obj_cgroup_memcg(objcg) : NULL;
 }
 
 /*
@@ -472,15 +455,10 @@ static inline bool folio_memcg_charged(struct folio *folio)
  * has an associated memory cgroup pointer or an object cgroups vector or
  * an object cgroup.
  *
- * For a non-kmem folio any of the following ensures folio and memcg binding
- * stability:
+ * The page and objcg or memcg binding rules can refer to folio_memcg().
  *
- * - the folio lock
- * - LRU isolation
- * - exclusive reference
- *
- * For a kmem folio a caller should hold an rcu read lock to protect memcg
- * associated with a kmem folio from being released.
+ * A caller should hold an rcu read lock to protect memcg associated with a
+ * page from being released.
  */
 static inline struct mem_cgroup *folio_memcg_check(struct folio *folio)
 {
@@ -489,18 +467,14 @@ static inline struct mem_cgroup *folio_memcg_check(struct folio *folio)
 	 * for slabs, READ_ONCE() should be used here.
 	 */
 	unsigned long memcg_data = READ_ONCE(folio->memcg_data);
+	struct obj_cgroup *objcg;
 
 	if (memcg_data & MEMCG_DATA_OBJEXTS)
 		return NULL;
 
-	if (memcg_data & MEMCG_DATA_KMEM) {
-		struct obj_cgroup *objcg;
-
-		objcg = (void *)(memcg_data & ~OBJEXTS_FLAGS_MASK);
-		return obj_cgroup_memcg(objcg);
-	}
+	objcg = (void *)(memcg_data & ~OBJEXTS_FLAGS_MASK);
 
-	return (struct mem_cgroup *)(memcg_data & ~OBJEXTS_FLAGS_MASK);
+	return objcg ? obj_cgroup_memcg(objcg) : NULL;
 }
 
 static inline struct mem_cgroup *page_memcg_check(struct page *page)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 813334994f84..0236020de5b3 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1075,6 +1075,39 @@ static inline struct deferred_split *folio_memcg_split_queue(struct folio *folio
 
 	return memcg ? &memcg->deferred_split_queue : NULL;
 }
+
+static void thp_sq_reparent_lock(struct mem_cgroup *src, struct mem_cgroup *dst)
+{
+	spin_lock(&src->deferred_split_queue.split_queue_lock);
+	spin_lock_nested(&dst->deferred_split_queue.split_queue_lock,
+			 SINGLE_DEPTH_NESTING);
+}
+
+static void thp_sq_reparent_relocate(struct mem_cgroup *src, struct mem_cgroup *dst)
+{
+	int nid;
+	struct deferred_split *src_queue, *dst_queue;
+
+	src_queue = &src->deferred_split_queue;
+	dst_queue = &dst->deferred_split_queue;
+
+	if (!src_queue->split_queue_len)
+		return;
+
+	list_splice_tail_init(&src_queue->split_queue, &dst_queue->split_queue);
+	dst_queue->split_queue_len += src_queue->split_queue_len;
+	src_queue->split_queue_len = 0;
+
+	for_each_node(nid)
+		set_shrinker_bit(dst, nid, deferred_split_shrinker->id);
+}
+
+static void thp_sq_reparent_unlock(struct mem_cgroup *src, struct mem_cgroup *dst)
+{
+	spin_unlock(&dst->deferred_split_queue.split_queue_lock);
+	spin_unlock(&src->deferred_split_queue.split_queue_lock);
+}
+DEFINE_MEMCG_REPARENT_OPS(thp_sq);
 #else
 static inline
 struct mem_cgroup *folio_split_queue_memcg(struct folio *folio,
diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 8660908850dc..fb060e5c28ca 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -591,6 +591,7 @@ void memcg1_commit_charge(struct folio *folio, struct mem_cgroup *memcg)
 void memcg1_swapout(struct folio *folio, swp_entry_t entry)
 {
 	struct mem_cgroup *memcg, *swap_memcg;
+	struct obj_cgroup *objcg;
 	unsigned int nr_entries;
 
 	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
@@ -602,12 +603,13 @@ void memcg1_swapout(struct folio *folio, swp_entry_t entry)
 	if (!do_memsw_account())
 		return;
 
-	memcg = folio_memcg(folio);
-
-	VM_WARN_ON_ONCE_FOLIO(!memcg, folio);
-	if (!memcg)
+	objcg = folio_objcg(folio);
+	VM_WARN_ON_ONCE_FOLIO(!objcg, folio);
+	if (!objcg)
 		return;
 
+	rcu_read_lock();
+	memcg = obj_cgroup_memcg(objcg);
 	/*
 	 * In case the memcg owning these pages has been offlined and doesn't
 	 * have an ID allocated to it anymore, charge the closest online
@@ -625,7 +627,7 @@ void memcg1_swapout(struct folio *folio, swp_entry_t entry)
 	folio_unqueue_deferred_split(folio);
 	folio->memcg_data = 0;
 
-	if (!mem_cgroup_is_root(memcg))
+	if (!obj_cgroup_is_root(objcg))
 		page_counter_uncharge(&memcg->memory, nr_entries);
 
 	if (memcg != swap_memcg) {
@@ -646,7 +648,8 @@ void memcg1_swapout(struct folio *folio, swp_entry_t entry)
 	preempt_enable_nested();
 	memcg1_check_events(memcg, folio_nid(folio));
 
-	css_put(&memcg->css);
+	rcu_read_unlock();
+	obj_cgroup_put(objcg);
 }
 
 /*
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 3fac51179186..1381a9e97ec5 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -220,8 +220,78 @@ static void objcg_reparent_unlock(struct mem_cgroup *src, struct mem_cgroup *dst
 
 static DEFINE_MEMCG_REPARENT_OPS(objcg);
 
+static void lruvec_reparent_lock(struct mem_cgroup *src, struct mem_cgroup *dst)
+{
+	int nid, nest = 0;
+
+	for_each_node(nid) {
+		spin_lock_nested(&mem_cgroup_lruvec(src,
+				 NODE_DATA(nid))->lru_lock, nest++);
+		spin_lock_nested(&mem_cgroup_lruvec(dst,
+				 NODE_DATA(nid))->lru_lock, nest++);
+	}
+}
+
+static void lruvec_reparent_lru(struct lruvec *src, struct lruvec *dst,
+				enum lru_list lru)
+{
+	int zid;
+	struct mem_cgroup_per_node *mz_src, *mz_dst;
+
+	mz_src = container_of(src, struct mem_cgroup_per_node, lruvec);
+	mz_dst = container_of(dst, struct mem_cgroup_per_node, lruvec);
+
+	if (lru != LRU_UNEVICTABLE)
+		list_splice_tail_init(&src->lists[lru], &dst->lists[lru]);
+
+	for (zid = 0; zid < MAX_NR_ZONES; zid++) {
+		mz_dst->lru_zone_size[zid][lru] += mz_src->lru_zone_size[zid][lru];
+		mz_src->lru_zone_size[zid][lru] = 0;
+	}
+}
+
+static void lruvec_reparent_relocate(struct mem_cgroup *src, struct mem_cgroup *dst)
+{
+	int nid;
+
+	for_each_node(nid) {
+		enum lru_list lru;
+		struct lruvec *src_lruvec, *dst_lruvec;
+
+		src_lruvec = mem_cgroup_lruvec(src, NODE_DATA(nid));
+		dst_lruvec = mem_cgroup_lruvec(dst, NODE_DATA(nid));
+
+		dst_lruvec->anon_cost += src_lruvec->anon_cost;
+		dst_lruvec->file_cost += src_lruvec->file_cost;
+
+		for_each_lru(lru)
+			lruvec_reparent_lru(src_lruvec, dst_lruvec, lru);
+	}
+}
+
+static void lruvec_reparent_unlock(struct mem_cgroup *src, struct mem_cgroup *dst)
+{
+	int nid;
+
+	for_each_node(nid) {
+		spin_unlock(&mem_cgroup_lruvec(dst, NODE_DATA(nid))->lru_lock);
+		spin_unlock(&mem_cgroup_lruvec(src, NODE_DATA(nid))->lru_lock);
+	}
+}
+
+static DEFINE_MEMCG_REPARENT_OPS(lruvec);
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+DECLARE_MEMCG_REPARENT_OPS(thp_sq);
+#endif
+
+/* The lock order depends on the order of elements in this array. */
 static const struct memcg_reparent_ops *memcg_reparent_ops[] = {
 	&memcg_objcg_reparent_ops,
+	&memcg_lruvec_reparent_ops,
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	&memcg_thp_sq_reparent_ops,
+#endif
 };
 
 #define DEFINE_MEMCG_REPARENT_FUNC(phase)				\
@@ -1018,6 +1088,8 @@ struct mem_cgroup *get_mem_cgroup_from_current(void)
 /**
  * get_mem_cgroup_from_folio - Obtain a reference on a given folio's memcg.
  * @folio: folio from which memcg should be extracted.
+ *
+ * The page and objcg or memcg binding rules can refer to folio_memcg().
  */
 struct mem_cgroup *get_mem_cgroup_from_folio(struct folio *folio)
 {
@@ -2489,17 +2561,17 @@ static inline int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	return try_charge_memcg(memcg, gfp_mask, nr_pages);
 }
 
-static void commit_charge(struct folio *folio, struct mem_cgroup *memcg)
+static void commit_charge(struct folio *folio, struct obj_cgroup *objcg)
 {
 	VM_BUG_ON_FOLIO(folio_memcg_charged(folio), folio);
 	/*
-	 * Any of the following ensures page's memcg stability:
+	 * Any of the following ensures page's objcg stability:
 	 *
 	 * - the page lock
 	 * - LRU isolation
 	 * - exclusive reference
 	 */
-	folio->memcg_data = (unsigned long)memcg;
+	folio->memcg_data = (unsigned long)objcg;
 }
 
 static inline void __mod_objcg_mlstate(struct obj_cgroup *objcg,
@@ -2580,6 +2652,17 @@ static struct obj_cgroup *__get_obj_cgroup_from_memcg(struct mem_cgroup *memcg)
 	return NULL;
 }
 
+static inline struct obj_cgroup *get_obj_cgroup_from_memcg(struct mem_cgroup *memcg)
+{
+	struct obj_cgroup *objcg;
+
+	rcu_read_lock();
+	objcg = __get_obj_cgroup_from_memcg(memcg);
+	rcu_read_unlock();
+
+	return objcg;
+}
+
 static struct obj_cgroup *current_objcg_update(void)
 {
 	struct mem_cgroup *memcg;
@@ -2677,17 +2760,10 @@ struct obj_cgroup *get_obj_cgroup_from_folio(struct folio *folio)
 {
 	struct obj_cgroup *objcg;
 
-	if (!memcg_kmem_online())
-		return NULL;
-
-	if (folio_memcg_kmem(folio)) {
-		objcg = __folio_objcg(folio);
+	objcg = folio_objcg(folio);
+	if (objcg)
 		obj_cgroup_get(objcg);
-	} else {
-		rcu_read_lock();
-		objcg = __get_obj_cgroup_from_memcg(__folio_memcg(folio));
-		rcu_read_unlock();
-	}
+
 	return objcg;
 }
 
@@ -3168,7 +3244,7 @@ void folio_split_memcg_refs(struct folio *folio, unsigned old_order,
 		return;
 
 	new_refs = (1 << (old_order - new_order)) - 1;
-	css_get_many(&__folio_memcg(folio)->css, new_refs);
+	obj_cgroup_get_many(folio_objcg(folio), new_refs);
 }
 
 unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap)
@@ -4616,16 +4692,20 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
 static int charge_memcg(struct folio *folio, struct mem_cgroup *memcg,
 			gfp_t gfp)
 {
-	int ret;
-
-	ret = try_charge(memcg, gfp, folio_nr_pages(folio));
-	if (ret)
-		goto out;
+	int ret = 0;
+	struct obj_cgroup *objcg;
 
-	css_get(&memcg->css);
-	commit_charge(folio, memcg);
+	objcg = get_obj_cgroup_from_memcg(memcg);
+	/* Do not account at the root objcg level. */
+	if (!obj_cgroup_is_root(objcg))
+		ret = try_charge(memcg, gfp, folio_nr_pages(folio));
+	if (ret) {
+		obj_cgroup_put(objcg);
+		return ret;
+	}
+	commit_charge(folio, objcg);
 	memcg1_commit_charge(folio, memcg);
-out:
+
 	return ret;
 }
 
@@ -4711,7 +4791,7 @@ int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struct *mm,
 }
 
 struct uncharge_gather {
-	struct mem_cgroup *memcg;
+	struct obj_cgroup *objcg;
 	unsigned long nr_memory;
 	unsigned long pgpgout;
 	unsigned long nr_kmem;
@@ -4725,60 +4805,54 @@ static inline void uncharge_gather_clear(struct uncharge_gather *ug)
 
 static void uncharge_batch(const struct uncharge_gather *ug)
 {
+	struct mem_cgroup *memcg;
+
+	rcu_read_lock();
+	memcg = obj_cgroup_memcg(ug->objcg);
 	if (ug->nr_memory) {
-		page_counter_uncharge(&ug->memcg->memory, ug->nr_memory);
+		page_counter_uncharge(&memcg->memory, ug->nr_memory);
 		if (do_memsw_account())
-			page_counter_uncharge(&ug->memcg->memsw, ug->nr_memory);
+			page_counter_uncharge(&memcg->memsw, ug->nr_memory);
 		if (ug->nr_kmem) {
-			mod_memcg_state(ug->memcg, MEMCG_KMEM, -ug->nr_kmem);
-			memcg1_account_kmem(ug->memcg, -ug->nr_kmem);
+			mod_memcg_state(memcg, MEMCG_KMEM, -ug->nr_kmem);
+			memcg1_account_kmem(memcg, -ug->nr_kmem);
 		}
-		memcg1_oom_recover(ug->memcg);
+		memcg1_oom_recover(memcg);
 	}
 
-	memcg1_uncharge_batch(ug->memcg, ug->pgpgout, ug->nr_memory, ug->nid);
+	memcg1_uncharge_batch(memcg, ug->pgpgout, ug->nr_memory, ug->nid);
+	rcu_read_unlock();
 
 	/* drop reference from uncharge_folio */
-	css_put(&ug->memcg->css);
+	obj_cgroup_put(ug->objcg);
 }
 
 static void uncharge_folio(struct folio *folio, struct uncharge_gather *ug)
 {
 	long nr_pages;
-	struct mem_cgroup *memcg;
 	struct obj_cgroup *objcg;
 
 	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
 
 	/*
 	 * Nobody should be changing or seriously looking at
-	 * folio memcg or objcg at this point, we have fully
-	 * exclusive access to the folio.
+	 * folio objcg at this point, we have fully exclusive
+	 * access to the folio.
 	 */
-	if (folio_memcg_kmem(folio)) {
-		objcg = __folio_objcg(folio);
-		/*
-		 * This get matches the put at the end of the function and
-		 * kmem pages do not hold memcg references anymore.
-		 */
-		memcg = get_mem_cgroup_from_objcg(objcg);
-	} else {
-		memcg = __folio_memcg(folio);
-	}
-
-	if (!memcg)
+	objcg = folio_objcg(folio);
+	if (!objcg)
 		return;
 
-	if (ug->memcg != memcg) {
-		if (ug->memcg) {
+	if (ug->objcg != objcg) {
+		if (ug->objcg) {
 			uncharge_batch(ug);
 			uncharge_gather_clear(ug);
 		}
-		ug->memcg = memcg;
+		ug->objcg = objcg;
 		ug->nid = folio_nid(folio);
 
-		/* pairs with css_put in uncharge_batch */
-		css_get(&memcg->css);
+		/* pairs with obj_cgroup_put in uncharge_batch */
+		obj_cgroup_get(objcg);
 	}
 
 	nr_pages = folio_nr_pages(folio);
@@ -4786,20 +4860,17 @@ static void uncharge_folio(struct folio *folio, struct uncharge_gather *ug)
 	if (folio_memcg_kmem(folio)) {
 		ug->nr_memory += nr_pages;
 		ug->nr_kmem += nr_pages;
-
-		folio->memcg_data = 0;
-		obj_cgroup_put(objcg);
 	} else {
 		/* LRU pages aren't accounted at the root level */
-		if (!mem_cgroup_is_root(memcg))
+		if (!obj_cgroup_is_root(objcg))
 			ug->nr_memory += nr_pages;
 		ug->pgpgout++;
 
 		WARN_ON_ONCE(folio_unqueue_deferred_split(folio));
-		folio->memcg_data = 0;
 	}
 
-	css_put(&memcg->css);
+	folio->memcg_data = 0;
+	obj_cgroup_put(objcg);
 }
 
 void __mem_cgroup_uncharge(struct folio *folio)
@@ -4823,7 +4894,7 @@ void __mem_cgroup_uncharge_folios(struct folio_batch *folios)
 	uncharge_gather_clear(&ug);
 	for (i = 0; i < folios->nr; i++)
 		uncharge_folio(folios->folios[i], &ug);
-	if (ug.memcg)
+	if (ug.objcg)
 		uncharge_batch(&ug);
 }
 
@@ -4840,6 +4911,7 @@ void __mem_cgroup_uncharge_folios(struct folio_batch *folios)
 void mem_cgroup_replace_folio(struct folio *old, struct folio *new)
 {
 	struct mem_cgroup *memcg;
+	struct obj_cgroup *objcg;
 	long nr_pages = folio_nr_pages(new);
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(old), old);
@@ -4854,21 +4926,24 @@ void mem_cgroup_replace_folio(struct folio *old, struct folio *new)
 	if (folio_memcg_charged(new))
 		return;
 
-	memcg = folio_memcg(old);
-	VM_WARN_ON_ONCE_FOLIO(!memcg, old);
-	if (!memcg)
+	objcg = folio_objcg(old);
+	VM_WARN_ON_ONCE_FOLIO(!objcg, old);
+	if (!objcg)
 		return;
 
+	rcu_read_lock();
+	memcg = obj_cgroup_memcg(objcg);
 	/* Force-charge the new page. The old one will be freed soon */
-	if (!mem_cgroup_is_root(memcg)) {
+	if (!obj_cgroup_is_root(objcg)) {
 		page_counter_charge(&memcg->memory, nr_pages);
 		if (do_memsw_account())
 			page_counter_charge(&memcg->memsw, nr_pages);
 	}
 
-	css_get(&memcg->css);
-	commit_charge(new, memcg);
+	obj_cgroup_get(objcg);
+	commit_charge(new, objcg);
 	memcg1_commit_charge(new, memcg);
+	rcu_read_unlock();
 }
 
 /**
@@ -4884,7 +4959,7 @@ void mem_cgroup_replace_folio(struct folio *old, struct folio *new)
  */
 void mem_cgroup_migrate(struct folio *old, struct folio *new)
 {
-	struct mem_cgroup *memcg;
+	struct obj_cgroup *objcg;
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(old), old);
 	VM_BUG_ON_FOLIO(!folio_test_locked(new), new);
@@ -4895,18 +4970,18 @@ void mem_cgroup_migrate(struct folio *old, struct folio *new)
 	if (mem_cgroup_disabled())
 		return;
 
-	memcg = folio_memcg(old);
+	objcg = folio_objcg(old);
 	/*
-	 * Note that it is normal to see !memcg for a hugetlb folio.
+	 * Note that it is normal to see !objcg for a hugetlb folio.
 	 * For e.g, itt could have been allocated when memory_hugetlb_accounting
 	 * was not selected.
 	 */
-	VM_WARN_ON_ONCE_FOLIO(!folio_test_hugetlb(old) && !memcg, old);
-	if (!memcg)
+	VM_WARN_ON_ONCE_FOLIO(!folio_test_hugetlb(old) && !objcg, old);
+	if (!objcg)
 		return;
 
-	/* Transfer the charge and the css ref */
-	commit_charge(new, memcg);
+	/* Transfer the charge and the objcg ref */
+	commit_charge(new, objcg);
 
 	/* Warning should never happen, so don't worry about refcount non-0 */
 	WARN_ON_ONCE(folio_unqueue_deferred_split(old));
@@ -5049,22 +5124,27 @@ int __mem_cgroup_try_charge_swap(struct folio *folio, swp_entry_t entry)
 	unsigned int nr_pages = folio_nr_pages(folio);
 	struct page_counter *counter;
 	struct mem_cgroup *memcg;
+	struct obj_cgroup *objcg;
 
 	if (do_memsw_account())
 		return 0;
 
-	memcg = folio_memcg(folio);
-
-	VM_WARN_ON_ONCE_FOLIO(!memcg, folio);
-	if (!memcg)
+	objcg = folio_objcg(folio);
+	VM_WARN_ON_ONCE_FOLIO(!objcg, folio);
+	if (!objcg)
 		return 0;
 
+	rcu_read_lock();
+	memcg = obj_cgroup_memcg(objcg);
 	if (!entry.val) {
 		memcg_memory_event(memcg, MEMCG_SWAP_FAIL);
+		rcu_read_unlock();
 		return 0;
 	}
 
 	memcg = mem_cgroup_id_get_online(memcg);
+	/* memcg is pined by memcg ID. */
+	rcu_read_unlock();
 
 	if (!mem_cgroup_is_root(memcg) &&
 	    !page_counter_try_charge(&memcg->swap, nr_pages, &counter)) {
-- 
2.20.1


