Return-Path: <cgroups+bounces-3468-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD18391E425
	for <lists+cgroups@lfdr.de>; Mon,  1 Jul 2024 17:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C6821C224A8
	for <lists+cgroups@lfdr.de>; Mon,  1 Jul 2024 15:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F1C16CD03;
	Mon,  1 Jul 2024 15:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="MRC5yKzX"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03AE1E871
	for <cgroups@vger.kernel.org>; Mon,  1 Jul 2024 15:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719847919; cv=none; b=FYsr5sItBzbYSPEoOHkLtB72BWB0QGLCriwzbdsNYdw1evb6JtWqsG3VLJe3DtzdtVWu7u9i39pEGyMsnSWT74CgvR8ekWwSVf2zloVUqR5BITZdrhD8nLZr2IgMSPQ77UIJVWVt3il0lty0AZeQhsZRk9kPZtEpMkg60E0mnnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719847919; c=relaxed/simple;
	bh=aLPmJpfFDxZp1wI8cGfEWSOyevGhNeXHlx96I4wN/Eg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UEq21W2EjaROCP576Fu3fs0QDDiLMsTi4QiA965okpxUn3Id1WDHYjeWwRPQbcw+hAm2B17E3Adi+XViGgIyu4ilCK/8BtGqwYA6U3716fnTNYpGRYVL1B4hRvA6SODbSY0cVUYzDytWl1Xc5TOOeEkxDJ4mNqGmABCj6cIe6Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=MRC5yKzX; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-79d5e61704eso192043885a.3
        for <cgroups@vger.kernel.org>; Mon, 01 Jul 2024 08:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1719847915; x=1720452715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=17+b38VsUVRqNvr165DW5Rz5DE2N3y0P2ksGLNjxjVs=;
        b=MRC5yKzXaLweyrLfthPUR4/JrqfSiewS7JMnzUPGALeXF78gk/P69Pz5iFUL3jfJgo
         PsT3crH4iQzQT4wTIVOpoTrNAAbcfq8kdK08gxzUmgBiJr++qFzCt9bQSos5OKpmsYQ1
         mZN3wgHk/A+fhkmlyKDlLiInn1UjfH2P8AmX46AhQfWcDGzhNMjFNOoByvljfYOppwIh
         +GLyiLksAbEdZJnHe7ax/OQhWyeYf1N3y8/8lzDprLMHjWmYF9EC4/KmnRBrY7njNQAo
         aPBrUUQIVa0klXZz0AZnj68vS9x5pPxVb1lQJ2In3s4XEnm84avxU1FiV0DzYuBWzsu2
         fKQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719847915; x=1720452715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=17+b38VsUVRqNvr165DW5Rz5DE2N3y0P2ksGLNjxjVs=;
        b=VAo2258B2I8zobhxqMhp3nFyIx2axMaE76+m2IqURi483zoS/lqS4vl4s00/4YC4vH
         OwsqkQiq3YP+H1GumGnAa9AYea5rMeB+j+NRWnUfr4S9xudhdC+5oAdwzNUgrlFedBTo
         u+HlmPwd1hNqf5EhJq94WQe7jP1mnXW6hxOPIG9oRdMZTnVgbfUBKnMf+xlZcTQ31obX
         NgXYxtnJkqIoVs7z8UT9wNrvWNpgYG4s3La0xcaaMJs1mV9M6ez+fMEnQzLuEXgv/3D/
         418EPiAVEbP3ACZHSPrMe4c7Z64xhhy2hFzXAvgjkmBSIrippKVek6LUp7lwrlmPWsYU
         8GcQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6almf5cRaYUxqOPLm/iebzyN/WflLd+mh63Kps4X/mknwZgYVRhbIAF/ge+jAJzkxmQ0zQ014zNqyOBLuo4aLPX1AnzO1zw==
X-Gm-Message-State: AOJu0YyMaRcSdlIOeMTuVp38yzQggOlxvohoS+7Cld4yNxbgPpoV1P2t
	3BiFAIK8oa9v0/0vvE523D4B9tg5mTqp2SRWmhPeXUU9Q38YhkMVTeAJdnTpRvE=
X-Google-Smtp-Source: AGHT+IF4jtSrdxRO4HiSnZtkoAZ2Q0t8j3YwN2JK8PRHBmNid9511TfufGa9v/m+bryaND+1l311kQ==
X-Received: by 2002:a05:620a:450b:b0:79a:2874:20ad with SMTP id af79cd13be357-79d7ba75ec7mr633164985a.51.1719847914449;
        Mon, 01 Jul 2024 08:31:54 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d69260065sm357997285a.5.2024.07.01.08.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 08:31:54 -0700 (PDT)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm: remove CONFIG_MEMCG_KMEM
Date: Mon,  1 Jul 2024 11:31:15 -0400
Message-ID: <20240701153148.452230-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CONFIG_MEMCG_KMEM used to be a user-visible option for whether slab
tracking is enabled. It has been default-enabled and equivalent to
CONFIG_MEMCG for almost a decade. We've only grown more kernel memory
accounting sites since, and there is no imaginable cgroup usecase
going forward that wants to track user pages but not the multitude of
user-drivable kernel allocations.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 include/linux/bpf.h                   |  4 +-
 include/linux/list_lru.h              |  2 +-
 include/linux/memcontrol.h            | 22 +++-------
 include/linux/sched.h                 |  3 +-
 include/linux/slab.h                  | 12 +++---
 include/trace/events/kmem.h           |  4 +-
 init/Kconfig                          |  5 ---
 kernel/bpf/memalloc.c                 |  9 ++--
 kernel/bpf/syscall.c                  |  6 +--
 mm/kfence/core.c                      |  6 +--
 mm/kfence/kfence.h                    |  2 +-
 mm/list_lru.c                         | 14 +++----
 mm/memcontrol-v1.c                    |  6 +--
 mm/memcontrol.c                       | 60 +++------------------------
 mm/percpu-internal.h                  |  6 +--
 mm/percpu.c                           |  6 +--
 mm/slab.h                             |  2 +-
 mm/slab_common.c                      | 10 ++---
 mm/slub.c                             | 10 ++---
 tools/testing/selftests/cgroup/config |  1 -
 20 files changed, 59 insertions(+), 131 deletions(-)

Rebased on top of mm-everything-2024-06-29-03-59.

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5e694a308081..b8637555c9c2 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -275,7 +275,7 @@ struct bpf_map {
 	u32 btf_value_type_id;
 	u32 btf_vmlinux_value_type_id;
 	struct btf *btf;
-#ifdef CONFIG_MEMCG_KMEM
+#ifdef CONFIG_MEMCG
 	struct obj_cgroup *objcg;
 #endif
 	char name[BPF_OBJ_NAME_LEN];
@@ -2252,7 +2252,7 @@ struct bpf_prog *bpf_prog_get_curr_or_next(u32 *id);
 
 int bpf_map_alloc_pages(const struct bpf_map *map, gfp_t gfp, int nid,
 			unsigned long nr_pages, struct page **page_array);
-#ifdef CONFIG_MEMCG_KMEM
+#ifdef CONFIG_MEMCG
 void *bpf_map_kmalloc_node(const struct bpf_map *map, size_t size, gfp_t flags,
 			   int node);
 void *bpf_map_kzalloc(const struct bpf_map *map, size_t size, gfp_t flags);
diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index 792b67ceb631..5099a8ccd5f4 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -50,7 +50,7 @@ struct list_lru_node {
 
 struct list_lru {
 	struct list_lru_node	*node;
-#ifdef CONFIG_MEMCG_KMEM
+#ifdef CONFIG_MEMCG
 	struct list_head	list;
 	int			shrinker_id;
 	bool			memcg_aware;
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index d0c9365ff039..e1a3e7d37312 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -193,7 +193,7 @@ struct mem_cgroup {
 	/* Range enforcement for interrupt charges */
 	struct work_struct high_work;
 
-#if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
+#ifdef CONFIG_ZSWAP
 	unsigned long zswap_max;
 
 	/*
@@ -236,7 +236,6 @@ struct mem_cgroup {
 	 */
 	unsigned long		socket_pressure;
 
-#ifdef CONFIG_MEMCG_KMEM
 	int kmemcg_id;
 	/*
 	 * memcg->objcg is wiped out as a part of the objcg repaprenting
@@ -247,7 +246,6 @@ struct mem_cgroup {
 	struct obj_cgroup	*orig_objcg;
 	/* list of inherited objcgs, protected by objcg_lock */
 	struct list_head objcg_list;
-#endif
 
 	struct memcg_vmstats_percpu __percpu *vmstats_percpu;
 
@@ -534,7 +532,6 @@ static inline struct mem_cgroup *get_mem_cgroup_from_objcg(struct obj_cgroup *ob
 	return memcg;
 }
 
-#ifdef CONFIG_MEMCG_KMEM
 /*
  * folio_memcg_kmem - Check if the folio has the memcg_kmem flag set.
  * @folio: Pointer to the folio.
@@ -550,15 +547,6 @@ static inline bool folio_memcg_kmem(struct folio *folio)
 	return folio->memcg_data & MEMCG_DATA_KMEM;
 }
 
-
-#else
-static inline bool folio_memcg_kmem(struct folio *folio)
-{
-	return false;
-}
-
-#endif
-
 static inline bool PageMemcgKmem(struct page *page)
 {
 	return folio_memcg_kmem(page_folio(page));
@@ -1490,7 +1478,7 @@ static inline void split_page_memcg(struct page *head, int old_order, int new_or
  * if MEMCG_DATA_OBJEXTS is set.
  */
 struct slabobj_ext {
-#ifdef CONFIG_MEMCG_KMEM
+#ifdef CONFIG_MEMCG
 	struct obj_cgroup *objcg;
 #endif
 #ifdef CONFIG_MEM_ALLOC_PROFILING
@@ -1665,7 +1653,7 @@ static inline void set_shrinker_bit(struct mem_cgroup *memcg,
 }
 #endif
 
-#ifdef CONFIG_MEMCG_KMEM
+#ifdef CONFIG_MEMCG
 bool mem_cgroup_kmem_disabled(void);
 int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order);
 void __memcg_kmem_uncharge_page(struct page *page, int order);
@@ -1808,9 +1796,9 @@ static inline void count_objcg_event(struct obj_cgroup *objcg,
 {
 }
 
-#endif /* CONFIG_MEMCG_KMEM */
+#endif /* CONFIG_MEMCG */
 
-#if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
+#if defined(CONFIG_MEMCG) && defined(CONFIG_ZSWAP)
 bool obj_cgroup_may_zswap(struct obj_cgroup *objcg);
 void obj_cgroup_charge_zswap(struct obj_cgroup *objcg, size_t size);
 void obj_cgroup_uncharge_zswap(struct obj_cgroup *objcg, size_t size);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index bd89e7bf65da..950fcb58534b 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1457,9 +1457,8 @@ struct task_struct {
 
 	/* Used by memcontrol for targeted memcg charge: */
 	struct mem_cgroup		*active_memcg;
-#endif
 
-#ifdef CONFIG_MEMCG_KMEM
+	/* Cache for current->cgroups->memcg->objcg lookups: */
 	struct obj_cgroup		*objcg;
 #endif
 
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 7247e217e21b..a332dd2fa6cd 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -41,7 +41,7 @@ enum _slab_flag_bits {
 #ifdef CONFIG_FAILSLAB
 	_SLAB_FAILSLAB,
 #endif
-#ifdef CONFIG_MEMCG_KMEM
+#ifdef CONFIG_MEMCG
 	_SLAB_ACCOUNT,
 #endif
 #ifdef CONFIG_KASAN_GENERIC
@@ -171,7 +171,7 @@ enum _slab_flag_bits {
 # define SLAB_FAILSLAB		__SLAB_FLAG_UNUSED
 #endif
 /* Account to memcg */
-#ifdef CONFIG_MEMCG_KMEM
+#ifdef CONFIG_MEMCG
 # define SLAB_ACCOUNT		__SLAB_FLAG_BIT(_SLAB_ACCOUNT)
 #else
 # define SLAB_ACCOUNT		__SLAB_FLAG_UNUSED
@@ -407,7 +407,7 @@ enum kmalloc_cache_type {
 #ifndef CONFIG_ZONE_DMA
 	KMALLOC_DMA = KMALLOC_NORMAL,
 #endif
-#ifndef CONFIG_MEMCG_KMEM
+#ifndef CONFIG_MEMCG
 	KMALLOC_CGROUP = KMALLOC_NORMAL,
 #endif
 	KMALLOC_RANDOM_START = KMALLOC_NORMAL,
@@ -420,7 +420,7 @@ enum kmalloc_cache_type {
 #ifdef CONFIG_ZONE_DMA
 	KMALLOC_DMA,
 #endif
-#ifdef CONFIG_MEMCG_KMEM
+#ifdef CONFIG_MEMCG
 	KMALLOC_CGROUP,
 #endif
 	NR_KMALLOC_TYPES
@@ -435,7 +435,7 @@ kmalloc_caches[NR_KMALLOC_TYPES][KMALLOC_SHIFT_HIGH + 1];
 #define KMALLOC_NOT_NORMAL_BITS					\
 	(__GFP_RECLAIMABLE |					\
 	(IS_ENABLED(CONFIG_ZONE_DMA)   ? __GFP_DMA : 0) |	\
-	(IS_ENABLED(CONFIG_MEMCG_KMEM) ? __GFP_ACCOUNT : 0))
+	(IS_ENABLED(CONFIG_MEMCG) ? __GFP_ACCOUNT : 0))
 
 extern unsigned long random_kmalloc_seed;
 
@@ -463,7 +463,7 @@ static __always_inline enum kmalloc_cache_type kmalloc_type(gfp_t flags, unsigne
 	 */
 	if (IS_ENABLED(CONFIG_ZONE_DMA) && (flags & __GFP_DMA))
 		return KMALLOC_DMA;
-	if (!IS_ENABLED(CONFIG_MEMCG_KMEM) || (flags & __GFP_RECLAIMABLE))
+	if (!IS_ENABLED(CONFIG_MEMCG) || (flags & __GFP_RECLAIMABLE))
 		return KMALLOC_RECLAIM;
 	else
 		return KMALLOC_CGROUP;
diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
index 8a829e0f6e55..b37eb0a7060f 100644
--- a/include/trace/events/kmem.h
+++ b/include/trace/events/kmem.h
@@ -36,7 +36,7 @@ TRACE_EVENT(kmem_cache_alloc,
 		__entry->bytes_alloc	= s->size;
 		__entry->gfp_flags	= (__force unsigned long)gfp_flags;
 		__entry->node		= node;
-		__entry->accounted	= IS_ENABLED(CONFIG_MEMCG_KMEM) ?
+		__entry->accounted	= IS_ENABLED(CONFIG_MEMCG) ?
 					  ((gfp_flags & __GFP_ACCOUNT) ||
 					  (s->flags & SLAB_ACCOUNT)) : false;
 	),
@@ -87,7 +87,7 @@ TRACE_EVENT(kmalloc,
 		__entry->bytes_alloc,
 		show_gfp_flags(__entry->gfp_flags),
 		__entry->node,
-		(IS_ENABLED(CONFIG_MEMCG_KMEM) &&
+		(IS_ENABLED(CONFIG_MEMCG) &&
 		 (__entry->gfp_flags & (__force unsigned long)__GFP_ACCOUNT)) ? "true" : "false")
 );
 
diff --git a/init/Kconfig b/init/Kconfig
index aca0ae9be04f..26bf8bb0a7ce 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -986,11 +986,6 @@ config MEMCG_V1
 
 	  San N is unsure.
 
-config MEMCG_KMEM
-	bool
-	depends on MEMCG
-	default y
-
 config BLK_CGROUP
 	bool "IO controller"
 	depends on BLOCK
diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index a546aba46d5d..dec892ded031 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -155,12 +155,9 @@ static void *__alloc(struct bpf_mem_cache *c, int node, gfp_t flags)
 
 static struct mem_cgroup *get_memcg(const struct bpf_mem_cache *c)
 {
-#ifdef CONFIG_MEMCG_KMEM
+#ifdef CONFIG_MEMCG
 	if (c->objcg)
 		return get_mem_cgroup_from_objcg(c->objcg);
-#endif
-
-#ifdef CONFIG_MEMCG
 	return root_mem_cgroup;
 #else
 	return NULL;
@@ -534,7 +531,7 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
 			size += LLIST_NODE_SZ; /* room for llist_node */
 		unit_size = size;
 
-#ifdef CONFIG_MEMCG_KMEM
+#ifdef CONFIG_MEMCG
 		if (memcg_bpf_enabled())
 			objcg = get_obj_cgroup_from_current();
 #endif
@@ -556,7 +553,7 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
 	pcc = __alloc_percpu_gfp(sizeof(*cc), 8, GFP_KERNEL);
 	if (!pcc)
 		return -ENOMEM;
-#ifdef CONFIG_MEMCG_KMEM
+#ifdef CONFIG_MEMCG
 	objcg = get_obj_cgroup_from_current();
 #endif
 	ma->objcg = objcg;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index f45ed6adc092..8f716f06c345 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -385,7 +385,7 @@ void bpf_map_free_id(struct bpf_map *map)
 	spin_unlock_irqrestore(&map_idr_lock, flags);
 }
 
-#ifdef CONFIG_MEMCG_KMEM
+#ifdef CONFIG_MEMCG
 static void bpf_map_save_memcg(struct bpf_map *map)
 {
 	/* Currently if a map is created by a process belonging to the root
@@ -486,7 +486,7 @@ int bpf_map_alloc_pages(const struct bpf_map *map, gfp_t gfp, int nid,
 	unsigned long i, j;
 	struct page *pg;
 	int ret = 0;
-#ifdef CONFIG_MEMCG_KMEM
+#ifdef CONFIG_MEMCG
 	struct mem_cgroup *memcg, *old_memcg;
 
 	memcg = bpf_map_get_memcg(map);
@@ -505,7 +505,7 @@ int bpf_map_alloc_pages(const struct bpf_map *map, gfp_t gfp, int nid,
 		break;
 	}
 
-#ifdef CONFIG_MEMCG_KMEM
+#ifdef CONFIG_MEMCG
 	set_active_memcg(old_memcg);
 	mem_cgroup_put(memcg);
 #endif
diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 83f8e78827c0..c5cb54fc696d 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -602,7 +602,7 @@ static unsigned long kfence_init_pool(void)
 			continue;
 
 		__folio_set_slab(slab_folio(slab));
-#ifdef CONFIG_MEMCG_KMEM
+#ifdef CONFIG_MEMCG
 		slab->obj_exts = (unsigned long)&kfence_metadata_init[i / 2 - 1].obj_exts |
 				 MEMCG_DATA_OBJEXTS;
 #endif
@@ -652,7 +652,7 @@ static unsigned long kfence_init_pool(void)
 
 		if (!i || (i % 2))
 			continue;
-#ifdef CONFIG_MEMCG_KMEM
+#ifdef CONFIG_MEMCG
 		slab->obj_exts = 0;
 #endif
 		__folio_clear_slab(slab_folio(slab));
@@ -1146,7 +1146,7 @@ void __kfence_free(void *addr)
 {
 	struct kfence_metadata *meta = addr_to_metadata((unsigned long)addr);
 
-#ifdef CONFIG_MEMCG_KMEM
+#ifdef CONFIG_MEMCG
 	KFENCE_WARN_ON(meta->obj_exts.objcg);
 #endif
 	/*
diff --git a/mm/kfence/kfence.h b/mm/kfence/kfence.h
index 084f5f36e8e7..db87a05047bd 100644
--- a/mm/kfence/kfence.h
+++ b/mm/kfence/kfence.h
@@ -97,7 +97,7 @@ struct kfence_metadata {
 	struct kfence_track free_track;
 	/* For updating alloc_covered on frees. */
 	u32 alloc_stack_hash;
-#ifdef CONFIG_MEMCG_KMEM
+#ifdef CONFIG_MEMCG
 	struct slabobj_ext obj_exts;
 #endif
 };
diff --git a/mm/list_lru.c b/mm/list_lru.c
index 3fd64736bc45..a29d96929d7c 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -15,7 +15,7 @@
 #include "slab.h"
 #include "internal.h"
 
-#ifdef CONFIG_MEMCG_KMEM
+#ifdef CONFIG_MEMCG
 static LIST_HEAD(memcg_list_lrus);
 static DEFINE_MUTEX(list_lrus_mutex);
 
@@ -83,7 +83,7 @@ list_lru_from_memcg_idx(struct list_lru *lru, int nid, int idx)
 {
 	return &lru->node[nid].lru;
 }
-#endif /* CONFIG_MEMCG_KMEM */
+#endif /* CONFIG_MEMCG */
 
 bool list_lru_add(struct list_lru *lru, struct list_head *item, int nid,
 		    struct mem_cgroup *memcg)
@@ -294,7 +294,7 @@ unsigned long list_lru_walk_node(struct list_lru *lru, int nid,
 	isolated += list_lru_walk_one(lru, nid, NULL, isolate, cb_arg,
 				      nr_to_walk);
 
-#ifdef CONFIG_MEMCG_KMEM
+#ifdef CONFIG_MEMCG
 	if (*nr_to_walk > 0 && list_lru_memcg_aware(lru)) {
 		struct list_lru_memcg *mlru;
 		unsigned long index;
@@ -324,7 +324,7 @@ static void init_one_lru(struct list_lru_one *l)
 	l->nr_items = 0;
 }
 
-#ifdef CONFIG_MEMCG_KMEM
+#ifdef CONFIG_MEMCG
 static struct list_lru_memcg *memcg_init_list_lru_one(gfp_t gfp)
 {
 	int nid;
@@ -544,14 +544,14 @@ static inline void memcg_init_list_lru(struct list_lru *lru, bool memcg_aware)
 static void memcg_destroy_list_lru(struct list_lru *lru)
 {
 }
-#endif /* CONFIG_MEMCG_KMEM */
+#endif /* CONFIG_MEMCG */
 
 int __list_lru_init(struct list_lru *lru, bool memcg_aware,
 		    struct lock_class_key *key, struct shrinker *shrinker)
 {
 	int i;
 
-#ifdef CONFIG_MEMCG_KMEM
+#ifdef CONFIG_MEMCG
 	if (shrinker)
 		lru->shrinker_id = shrinker->id;
 	else
@@ -591,7 +591,7 @@ void list_lru_destroy(struct list_lru *lru)
 	kfree(lru->node);
 	lru->node = NULL;
 
-#ifdef CONFIG_MEMCG_KMEM
+#ifdef CONFIG_MEMCG
 	lru->shrinker_id = -1;
 #endif
 }
diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 5fa48a45e34b..99cc9501eec1 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -2756,7 +2756,7 @@ static int mem_cgroup_oom_control_write(struct cgroup_subsys_state *css,
 	return 0;
 }
 
-#if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_SLUB_DEBUG)
+#ifdef CONFIG_SLUB_DEBUG
 static int mem_cgroup_slab_show(struct seq_file *m, void *p)
 {
 	/*
@@ -2863,7 +2863,7 @@ struct cftype mem_cgroup_legacy_files[] = {
 		.write = mem_cgroup_reset,
 		.read_u64 = mem_cgroup_read_u64,
 	},
-#if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_SLUB_DEBUG)
+#ifdef CONFIG_SLUB_DEBUG
 	{
 		.name = "kmem.slabinfo",
 		.seq_show = mem_cgroup_slab_show,
@@ -2922,7 +2922,6 @@ struct cftype memsw_files[] = {
 	{ },	/* terminate */
 };
 
-#ifdef CONFIG_MEMCG_KMEM
 void memcg1_account_kmem(struct mem_cgroup *memcg, int nr_pages)
 {
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys)) {
@@ -2932,7 +2931,6 @@ void memcg1_account_kmem(struct mem_cgroup *memcg, int nr_pages)
 			page_counter_uncharge(&memcg->kmem, -nr_pages);
 	}
 }
-#endif /* CONFIG_MEMCG_KMEM */
 
 bool memcg1_charge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages,
 			 gfp_t gfp_mask)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a5ca879b8861..db0abd6d2f54 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -118,7 +118,6 @@ struct mem_cgroup *vmpressure_to_memcg(struct vmpressure *vmpr)
 #define CURRENT_OBJCG_UPDATE_BIT 0
 #define CURRENT_OBJCG_UPDATE_FLAG (1UL << CURRENT_OBJCG_UPDATE_BIT)
 
-#ifdef CONFIG_MEMCG_KMEM
 static DEFINE_SPINLOCK(objcg_lock);
 
 bool mem_cgroup_kmem_disabled(void)
@@ -223,7 +222,6 @@ EXPORT_SYMBOL(memcg_kmem_online_key);
 
 DEFINE_STATIC_KEY_FALSE(memcg_bpf_enabled_key);
 EXPORT_SYMBOL(memcg_bpf_enabled_key);
-#endif
 
 /**
  * mem_cgroup_css_from_folio - css of the memcg associated with a folio
@@ -423,7 +421,7 @@ static const unsigned int memcg_vm_event_stat[] = {
 	PGDEACTIVATE,
 	PGLAZYFREE,
 	PGLAZYFREED,
-#if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
+#ifdef CONFIG_ZSWAP
 	ZSWPIN,
 	ZSWPOUT,
 	ZSWPWB,
@@ -1346,7 +1344,7 @@ static const struct memory_stat memory_stats[] = {
 	{ "sock",			MEMCG_SOCK			},
 	{ "vmalloc",			MEMCG_VMALLOC			},
 	{ "shmem",			NR_SHMEM			},
-#if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
+#ifdef CONFIG_ZSWAP
 	{ "zswap",			MEMCG_ZSWAP_B			},
 	{ "zswapped",			MEMCG_ZSWAPPED			},
 #endif
@@ -1700,13 +1698,11 @@ struct memcg_stock_pcp {
 	struct mem_cgroup *cached; /* this never be root cgroup */
 	unsigned int nr_pages;
 
-#ifdef CONFIG_MEMCG_KMEM
 	struct obj_cgroup *cached_objcg;
 	struct pglist_data *cached_pgdat;
 	unsigned int nr_bytes;
 	int nr_slab_reclaimable_b;
 	int nr_slab_unreclaimable_b;
-#endif
 
 	struct work_struct work;
 	unsigned long flags;
@@ -1717,23 +1713,10 @@ static DEFINE_PER_CPU(struct memcg_stock_pcp, memcg_stock) = {
 };
 static DEFINE_MUTEX(percpu_charge_mutex);
 
-#ifdef CONFIG_MEMCG_KMEM
 static struct obj_cgroup *drain_obj_stock(struct memcg_stock_pcp *stock);
 static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
 				     struct mem_cgroup *root_memcg);
 
-#else
-static inline struct obj_cgroup *drain_obj_stock(struct memcg_stock_pcp *stock)
-{
-	return NULL;
-}
-static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
-				     struct mem_cgroup *root_memcg)
-{
-	return false;
-}
-#endif
-
 /**
  * consume_stock: Try to consume stocked charge on this cpu.
  * @memcg: memcg to consume from.
@@ -2412,8 +2395,6 @@ void mem_cgroup_commit_charge(struct folio *folio, struct mem_cgroup *memcg)
 	local_irq_enable();
 }
 
-#ifdef CONFIG_MEMCG_KMEM
-
 static inline void __mod_objcg_mlstate(struct obj_cgroup *objcg,
 				       struct pglist_data *pgdat,
 				       enum node_stat_item idx, int nr)
@@ -3069,7 +3050,6 @@ void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
 		obj_cgroup_put(objcg);
 	}
 }
-#endif /* CONFIG_MEMCG_KMEM */
 
 /*
  * Because folio_memcg(head) is not set on tails, set it now.
@@ -3116,7 +3096,6 @@ unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap)
 	return val;
 }
 
-#ifdef CONFIG_MEMCG_KMEM
 static int memcg_online_kmem(struct mem_cgroup *memcg)
 {
 	struct obj_cgroup *objcg;
@@ -3167,15 +3146,6 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 	 */
 	memcg_reparent_list_lrus(memcg, parent);
 }
-#else
-static int memcg_online_kmem(struct mem_cgroup *memcg)
-{
-	return 0;
-}
-static void memcg_offline_kmem(struct mem_cgroup *memcg)
-{
-}
-#endif /* CONFIG_MEMCG_KMEM */
 
 unsigned long mem_cgroup_node_nr_lru_pages(struct mem_cgroup *memcg,
 					   int nid, unsigned int lru_mask,
@@ -3628,10 +3598,8 @@ static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
 	vmpressure_init(&memcg->vmpressure);
 	memcg->socket_pressure = jiffies;
 	memcg1_memcg_init(memcg);
-#ifdef CONFIG_MEMCG_KMEM
 	memcg->kmemcg_id = -1;
 	INIT_LIST_HEAD(&memcg->objcg_list);
-#endif
 #ifdef CONFIG_CGROUP_WRITEBACK
 	INIT_LIST_HEAD(&memcg->cgwb_list);
 	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++)
@@ -3665,7 +3633,7 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 
 	page_counter_set_high(&memcg->memory, PAGE_COUNTER_MAX);
 	memcg1_soft_limit_reset(memcg);
-#if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
+#ifdef CONFIG_ZSWAP
 	memcg->zswap_max = PAGE_COUNTER_MAX;
 	WRITE_ONCE(memcg->zswap_writeback,
 		!parent || READ_ONCE(parent->zswap_writeback));
@@ -3697,10 +3665,8 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 	if (cgroup_subsys_on_dfl(memory_cgrp_subsys) && !cgroup_memory_nosocket)
 		static_branch_inc(&memcg_sockets_enabled_key);
 
-#if defined(CONFIG_MEMCG_KMEM)
 	if (!cgroup_memory_nobpf)
 		static_branch_inc(&memcg_bpf_enabled_key);
-#endif
 
 	return &memcg->css;
 }
@@ -3793,10 +3759,8 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && memcg1_tcpmem_active(memcg))
 		static_branch_dec(&memcg_sockets_enabled_key);
 
-#if defined(CONFIG_MEMCG_KMEM)
 	if (!cgroup_memory_nobpf)
 		static_branch_dec(&memcg_bpf_enabled_key);
-#endif
 
 	vmpressure_cleanup(&memcg->vmpressure);
 	cancel_work_sync(&memcg->high_work);
@@ -3939,7 +3903,6 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 		atomic64_set(&memcg->vmstats->stats_updates, 0);
 }
 
-#ifdef CONFIG_MEMCG_KMEM
 static void mem_cgroup_fork(struct task_struct *task)
 {
 	/*
@@ -3967,7 +3930,6 @@ static void mem_cgroup_exit(struct task_struct *task)
 	 */
 	task->objcg = NULL;
 }
-#endif
 
 #ifdef CONFIG_LRU_GEN
 static void mem_cgroup_lru_gen_attach(struct cgroup_taskset *tset)
@@ -3991,7 +3953,6 @@ static void mem_cgroup_lru_gen_attach(struct cgroup_taskset *tset)
 static void mem_cgroup_lru_gen_attach(struct cgroup_taskset *tset) {}
 #endif /* CONFIG_LRU_GEN */
 
-#ifdef CONFIG_MEMCG_KMEM
 static void mem_cgroup_kmem_attach(struct cgroup_taskset *tset)
 {
 	struct task_struct *task;
@@ -4002,17 +3963,12 @@ static void mem_cgroup_kmem_attach(struct cgroup_taskset *tset)
 		set_bit(CURRENT_OBJCG_UPDATE_BIT, (unsigned long *)&task->objcg);
 	}
 }
-#else
-static void mem_cgroup_kmem_attach(struct cgroup_taskset *tset) {}
-#endif /* CONFIG_MEMCG_KMEM */
 
-#if defined(CONFIG_LRU_GEN) || defined(CONFIG_MEMCG_KMEM)
 static void mem_cgroup_attach(struct cgroup_taskset *tset)
 {
 	mem_cgroup_lru_gen_attach(tset);
 	mem_cgroup_kmem_attach(tset);
 }
-#endif
 
 static int seq_puts_memcg_tunable(struct seq_file *m, unsigned long value)
 {
@@ -4459,13 +4415,9 @@ struct cgroup_subsys memory_cgrp_subsys = {
 	.css_free = mem_cgroup_css_free,
 	.css_reset = mem_cgroup_css_reset,
 	.css_rstat_flush = mem_cgroup_css_rstat_flush,
-#if defined(CONFIG_LRU_GEN) || defined(CONFIG_MEMCG_KMEM)
 	.attach = mem_cgroup_attach,
-#endif
-#ifdef CONFIG_MEMCG_KMEM
 	.fork = mem_cgroup_fork,
 	.exit = mem_cgroup_exit,
-#endif
 	.dfl_cftypes = memory_files,
 #ifdef CONFIG_MEMCG_V1
 	.can_attach = memcg1_can_attach,
@@ -5443,7 +5395,7 @@ static struct cftype swap_files[] = {
 	{ }	/* terminate */
 };
 
-#if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
+#ifdef CONFIG_ZSWAP
 /**
  * obj_cgroup_may_zswap - check if this cgroup can zswap
  * @objcg: the object cgroup
@@ -5625,7 +5577,7 @@ static struct cftype zswap_files[] = {
 	},
 	{ }	/* terminate */
 };
-#endif /* CONFIG_MEMCG_KMEM && CONFIG_ZSWAP */
+#endif /* CONFIG_ZSWAP */
 
 static int __init mem_cgroup_swap_init(void)
 {
@@ -5636,7 +5588,7 @@ static int __init mem_cgroup_swap_init(void)
 #ifdef CONFIG_MEMCG_V1
 	WARN_ON(cgroup_add_legacy_cftypes(&memory_cgrp_subsys, memsw_files));
 #endif
-#if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
+#ifdef CONFIG_ZSWAP
 	WARN_ON(cgroup_add_dfl_cftypes(&memory_cgrp_subsys, zswap_files));
 #endif
 	return 0;
diff --git a/mm/percpu-internal.h b/mm/percpu-internal.h
index 7e42f0ca3b7b..4b3d6ec43703 100644
--- a/mm/percpu-internal.h
+++ b/mm/percpu-internal.h
@@ -33,7 +33,7 @@ struct pcpu_block_md {
 };
 
 struct pcpuobj_ext {
-#ifdef CONFIG_MEMCG_KMEM
+#ifdef CONFIG_MEMCG
 	struct obj_cgroup	*cgroup;
 #endif
 #ifdef CONFIG_MEM_ALLOC_PROFILING
@@ -41,7 +41,7 @@ struct pcpuobj_ext {
 #endif
 };
 
-#if defined(CONFIG_MEMCG_KMEM) || defined(CONFIG_MEM_ALLOC_PROFILING)
+#if defined(CONFIG_MEMCG) || defined(CONFIG_MEM_ALLOC_PROFILING)
 #define NEED_PCPUOBJ_EXT
 #endif
 
@@ -154,7 +154,7 @@ static inline size_t pcpu_obj_full_size(size_t size)
 {
 	size_t extra_size = 0;
 
-#ifdef CONFIG_MEMCG_KMEM
+#ifdef CONFIG_MEMCG
 	if (!mem_cgroup_kmem_disabled())
 		extra_size += size / PCPU_MIN_ALLOC_SIZE * sizeof(struct obj_cgroup *);
 #endif
diff --git a/mm/percpu.c b/mm/percpu.c
index 474e3683b74d..20d91af8c033 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1619,7 +1619,7 @@ static struct pcpu_chunk *pcpu_chunk_addr_search(void *addr)
 	return pcpu_get_page_chunk(pcpu_addr_to_page(addr));
 }
 
-#ifdef CONFIG_MEMCG_KMEM
+#ifdef CONFIG_MEMCG
 static bool pcpu_memcg_pre_alloc_hook(size_t size, gfp_t gfp,
 				      struct obj_cgroup **objcgp)
 {
@@ -1681,7 +1681,7 @@ static void pcpu_memcg_free_hook(struct pcpu_chunk *chunk, int off, size_t size)
 	obj_cgroup_put(objcg);
 }
 
-#else /* CONFIG_MEMCG_KMEM */
+#else /* CONFIG_MEMCG */
 static bool
 pcpu_memcg_pre_alloc_hook(size_t size, gfp_t gfp, struct obj_cgroup **objcgp)
 {
@@ -1697,7 +1697,7 @@ static void pcpu_memcg_post_alloc_hook(struct obj_cgroup *objcg,
 static void pcpu_memcg_free_hook(struct pcpu_chunk *chunk, int off, size_t size)
 {
 }
-#endif /* CONFIG_MEMCG_KMEM */
+#endif /* CONFIG_MEMCG */
 
 #ifdef CONFIG_MEM_ALLOC_PROFILING
 static void pcpu_alloc_tag_alloc_hook(struct pcpu_chunk *chunk, int off,
diff --git a/mm/slab.h b/mm/slab.h
index 5f8f47c5bee0..3586e6183224 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -573,7 +573,7 @@ static inline enum node_stat_item cache_vmstat_idx(struct kmem_cache *s)
 		NR_SLAB_RECLAIMABLE_B : NR_SLAB_UNRECLAIMABLE_B;
 }
 
-#ifdef CONFIG_MEMCG_KMEM
+#ifdef CONFIG_MEMCG
 bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 				  gfp_t flags, size_t size, void **p);
 void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 1560a1546bb1..60268bb258fc 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -725,7 +725,7 @@ EXPORT_SYMBOL(kmalloc_size_roundup);
 #define KMALLOC_DMA_NAME(sz)
 #endif
 
-#ifdef CONFIG_MEMCG_KMEM
+#ifdef CONFIG_MEMCG
 #define KMALLOC_CGROUP_NAME(sz)	.name[KMALLOC_CGROUP] = "kmalloc-cg-" #sz,
 #else
 #define KMALLOC_CGROUP_NAME(sz)
@@ -867,7 +867,7 @@ new_kmalloc_cache(int idx, enum kmalloc_cache_type type)
 
 	if ((KMALLOC_RECLAIM != KMALLOC_NORMAL) && (type == KMALLOC_RECLAIM)) {
 		flags |= SLAB_RECLAIM_ACCOUNT;
-	} else if (IS_ENABLED(CONFIG_MEMCG_KMEM) && (type == KMALLOC_CGROUP)) {
+	} else if (IS_ENABLED(CONFIG_MEMCG) && (type == KMALLOC_CGROUP)) {
 		if (mem_cgroup_kmem_disabled()) {
 			kmalloc_caches[type][idx] = kmalloc_caches[KMALLOC_NORMAL][idx];
 			return;
@@ -883,10 +883,10 @@ new_kmalloc_cache(int idx, enum kmalloc_cache_type type)
 #endif
 
 	/*
-	 * If CONFIG_MEMCG_KMEM is enabled, disable cache merging for
+	 * If CONFIG_MEMCG is enabled, disable cache merging for
 	 * KMALLOC_NORMAL caches.
 	 */
-	if (IS_ENABLED(CONFIG_MEMCG_KMEM) && (type == KMALLOC_NORMAL))
+	if (IS_ENABLED(CONFIG_MEMCG) && (type == KMALLOC_NORMAL))
 		flags |= SLAB_NO_MERGE;
 
 	if (minalign > ARCH_KMALLOC_MINALIGN) {
@@ -913,7 +913,7 @@ void __init create_kmalloc_caches(void)
 	enum kmalloc_cache_type type;
 
 	/*
-	 * Including KMALLOC_CGROUP if CONFIG_MEMCG_KMEM defined
+	 * Including KMALLOC_CGROUP if CONFIG_MEMCG defined
 	 */
 	for (type = KMALLOC_NORMAL; type < NR_KMALLOC_TYPES; type++) {
 		/* Caches that are NOT of the two-to-the-power-of size. */
diff --git a/mm/slub.c b/mm/slub.c
index 177ad7d3288b..cc11f3869cc6 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2020,7 +2020,7 @@ static inline bool need_slab_obj_ext(void)
 		return true;
 
 	/*
-	 * CONFIG_MEMCG_KMEM creates vector of obj_cgroup objects conditionally
+	 * CONFIG_MEMCG creates vector of obj_cgroup objects conditionally
 	 * inside memcg_slab_post_alloc_hook. No other users for now.
 	 */
 	return false;
@@ -2104,7 +2104,7 @@ alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
 
 #endif /* CONFIG_SLAB_OBJ_EXT */
 
-#ifdef CONFIG_MEMCG_KMEM
+#ifdef CONFIG_MEMCG
 
 static void memcg_alloc_abort_single(struct kmem_cache *s, void *object);
 
@@ -2146,7 +2146,7 @@ void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
 
 	__memcg_slab_free_hook(s, slab, p, objects, obj_exts);
 }
-#else /* CONFIG_MEMCG_KMEM */
+#else /* CONFIG_MEMCG */
 static inline bool memcg_slab_post_alloc_hook(struct kmem_cache *s,
 					      struct list_lru *lru,
 					      gfp_t flags, size_t size,
@@ -2159,7 +2159,7 @@ static inline void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
 					void **p, int objects)
 {
 }
-#endif /* CONFIG_MEMCG_KMEM */
+#endif /* CONFIG_MEMCG */
 
 /*
  * Hooks for other subsystems that check memory allocations. In a typical
@@ -4456,7 +4456,7 @@ void slab_free(struct kmem_cache *s, struct slab *slab, void *object,
 		do_slab_free(s, slab, object, object, 1, addr);
 }
 
-#ifdef CONFIG_MEMCG_KMEM
+#ifdef CONFIG_MEMCG
 /* Do not inline the rare memcg charging failed path into the allocation path */
 static noinline
 void memcg_alloc_abort_single(struct kmem_cache *s, void *object)
diff --git a/tools/testing/selftests/cgroup/config b/tools/testing/selftests/cgroup/config
index 97d549ee894f..39f979690dd3 100644
--- a/tools/testing/selftests/cgroup/config
+++ b/tools/testing/selftests/cgroup/config
@@ -3,5 +3,4 @@ CONFIG_CGROUP_CPUACCT=y
 CONFIG_CGROUP_FREEZER=y
 CONFIG_CGROUP_SCHED=y
 CONFIG_MEMCG=y
-CONFIG_MEMCG_KMEM=y
 CONFIG_PAGE_COUNTER=y
-- 
2.45.2


