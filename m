Return-Path: <cgroups+bounces-2079-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E89881890
	for <lists+cgroups@lfdr.de>; Wed, 20 Mar 2024 21:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10DAE1F21F75
	for <lists+cgroups@lfdr.de>; Wed, 20 Mar 2024 20:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117FD85933;
	Wed, 20 Mar 2024 20:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="Z4DmCFRX"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A559A85635
	for <cgroups@vger.kernel.org>; Wed, 20 Mar 2024 20:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710966475; cv=none; b=BhjRnZ8++iSrqcOk9Qm+pLHhk1ZyLhUGkPLSTD0YJYjunLeRpqPdlIHHPhE+ikxQS7uGjdQIhPc+qGK+HH5qzp6hsuUJXbUc9nLEX1m3bN20eqntUtcs+waUpbiJoqcVyeo30Yz4K1hAG3VlJEKXG2iaF10daL47+b3Sm49Vxbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710966475; c=relaxed/simple;
	bh=Z3o0cO2vMjVZroeqeWUs7GEHxO7VbHtdD226nfVA2nM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YD4kmP+ji31f77ugBJHJXRGpZOpNHASXfJUkVOpFTED3wYoJ8rkVsnFtMIvWl6zNTFeXxp0oJ2zBq2BdxsdxjFn/NA/6hIlG0VQSRaFqztP/OiPSiRipswcKGyDNr4+s9BjLZBH1W9Z0SEIwYRPStOj+m3PZSRcdeLqGs6bsLnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=Z4DmCFRX; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-695df25699fso2731386d6.2
        for <cgroups@vger.kernel.org>; Wed, 20 Mar 2024 13:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1710966471; x=1711571271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4SjCS8iYKWpGLbm15iQ0OBC2lI01t6lB3mmOdDlFIuE=;
        b=Z4DmCFRXmQNoT6//p0STtfQppxPlad+bZQMSBINIJnl4rsZqVoVikwJSGxp6c7mYGe
         mvqbBvdSHy7TBPsMGN240C+M2qLUCf8YORw3tDYFMyMNApin5V/Yi+0m+1NOgmg0V/rW
         xKDMpVOazBMIuMgiNS8LZ4EpnMaVMfLYWl4yJa558vMemW97iHME3ktJzAYfYYMOyiJj
         6iJ/PWWptk3FEaFX1oPCxsJYePjLU6IHXTOz/c9vi+hJoARe+zU/0+j8naGvqkYEpkH/
         MPazZ7ScGiAPFvSzr8KwyYAGSUFctd5Em8ED9PgCdZWRtiP4mC2prUPBYTmOM6XCfaeP
         drzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710966471; x=1711571271;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4SjCS8iYKWpGLbm15iQ0OBC2lI01t6lB3mmOdDlFIuE=;
        b=msqh8P1qZp+yxNHUm84qGDwnikyhkXItEbawaiGCsxwalnwKD3MFG6cckFguNzWQfq
         1VmODU/I2xbUEhVue9QDtBkiQVC/T2ksqTrWa47+gZF0iaG7fL0CY/cQoxgTA4/Fyi1U
         xM/dhr7io18oYt8fXCjLoF68bvlZj/m19MyFUWLfzlqthNd3ijtKUgfD14AljrA+P/Gc
         0Vm75g1N5ATEv2LmLq2fCQLy3V84RwGteWue8mKb3PGJJK0hkUNm1bxKweuLZyYMuGgq
         hDv6/Z5H2NREEcs8PGuaWdMnTvDO/wElXN3BujHw0YeCK6h+UPWWWQMJySScYRI6ld0D
         CQlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhvPo+OP59+QEPBF7+UNudeXZoi2nMxV/VqLcfzq9L3HznjhIuPF9dSPJpw9RZijKaKBE3yMyjXfEZShua+7GoJo+DE4ZldQ==
X-Gm-Message-State: AOJu0Yx0dkdhfAQRuYbc9GhE4+xFOpNsyT7DoYd1dHVSnOyKnTvH6gp9
	4gCuZQjDjgsz/bG1u6GMMaBSR4Q7bDcP0tSdjaDxitC/2rLMz3qMWy8i0qdZvbB1Hhhf0OIEmQC
	+
X-Google-Smtp-Source: AGHT+IFT7SnogHnmHdPWqeCPB/+R3GwblXW1k2+PGl6x2mP1SIeL3JqcyrTrX+T+HbpF7kwhTFHvdQ==
X-Received: by 2002:a0c:e0c9:0:b0:696:3b0b:d780 with SMTP id x9-20020a0ce0c9000000b006963b0bd780mr3316936qvk.17.1710966471325;
        Wed, 20 Mar 2024 13:27:51 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id jo4-20020a056214500400b00696147f229fsm4503998qvb.83.2024.03.20.13.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 13:27:50 -0700 (PDT)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm: remove CONFIG_MEMCG_KMEM
Date: Wed, 20 Mar 2024 16:27:45 -0400
Message-ID: <20240320202745.740843-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.44.0
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
---
 include/linux/bpf.h                   |  4 +-
 include/linux/list_lru.h              |  2 +-
 include/linux/memcontrol.h            | 20 ++------
 include/linux/sched.h                 |  2 -
 include/linux/slab.h                  | 12 ++---
 include/trace/events/kmem.h           |  4 +-
 init/Kconfig                          |  5 --
 kernel/bpf/memalloc.c                 |  9 ++--
 kernel/bpf/syscall.c                  |  6 +--
 mm/list_lru.c                         | 14 +++---
 mm/memcontrol.c                       | 67 ++++-----------------------
 mm/percpu-internal.h                  |  4 +-
 mm/percpu.c                           | 14 +++---
 mm/slab.h                             |  6 +--
 mm/slab_common.c                      | 10 ++--
 mm/slub.c                             |  6 +--
 mm/zswap.c                            |  2 +-
 tools/testing/selftests/cgroup/config |  1 -
 18 files changed, 57 insertions(+), 131 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4f20f62f9d63..e286433d291f 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -273,7 +273,7 @@ struct bpf_map {
 	u32 btf_value_type_id;
 	u32 btf_vmlinux_value_type_id;
 	struct btf *btf;
-#ifdef CONFIG_MEMCG_KMEM
+#ifdef CONFIG_MEMCG
 	struct obj_cgroup *objcg;
 #endif
 	char name[BPF_OBJ_NAME_LEN];
@@ -2221,7 +2221,7 @@ struct bpf_prog *bpf_prog_get_curr_or_next(u32 *id);
 
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
index b6264796815d..6b273833caa2 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -218,7 +218,7 @@ struct mem_cgroup {
 	/* Range enforcement for interrupt charges */
 	struct work_struct high_work;
 
-#if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
+#ifdef CONFIG_ZSWAP
 	unsigned long zswap_max;
 
 	/*
@@ -294,7 +294,6 @@ struct mem_cgroup {
 	bool			tcpmem_active;
 	int			tcpmem_pressure;
 
-#ifdef CONFIG_MEMCG_KMEM
 	int kmemcg_id;
 	/*
 	 * memcg->objcg is wiped out as a part of the objcg repaprenting
@@ -305,7 +304,6 @@ struct mem_cgroup {
 	struct obj_cgroup	*orig_objcg;
 	/* list of inherited objcgs, protected by objcg_lock */
 	struct list_head objcg_list;
-#endif
 
 	CACHELINE_PADDING(_pad2_);
 
@@ -540,7 +538,6 @@ static inline struct mem_cgroup *get_mem_cgroup_from_objcg(struct obj_cgroup *ob
 	return memcg;
 }
 
-#ifdef CONFIG_MEMCG_KMEM
 /*
  * folio_memcg_kmem - Check if the folio has the memcg_kmem flag set.
  * @folio: Pointer to the folio.
@@ -556,15 +553,6 @@ static inline bool folio_memcg_kmem(struct folio *folio)
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
@@ -1798,7 +1786,7 @@ static inline void set_shrinker_bit(struct mem_cgroup *memcg,
 }
 #endif
 
-#ifdef CONFIG_MEMCG_KMEM
+#ifdef CONFIG_MEMCG
 bool mem_cgroup_kmem_disabled(void);
 int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order);
 void __memcg_kmem_uncharge_page(struct page *page, int order);
@@ -1941,9 +1929,9 @@ static inline void count_objcg_event(struct obj_cgroup *objcg,
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
index 3c2abbc587b4..f905fe9ea289 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1451,9 +1451,7 @@ struct task_struct {
 
 	/* Used by memcontrol for targeted memcg charge: */
 	struct mem_cgroup		*active_memcg;
-#endif
 
-#ifdef CONFIG_MEMCG_KMEM
 	struct obj_cgroup		*objcg;
 #endif
 
diff --git a/include/linux/slab.h b/include/linux/slab.h
index e53cbfa18325..77a1103993bc 100644
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
@@ -168,7 +168,7 @@ enum _slab_flag_bits {
 # define SLAB_FAILSLAB		__SLAB_FLAG_UNUSED
 #endif
 /* Account to memcg */
-#ifdef CONFIG_MEMCG_KMEM
+#ifdef CONFIG_MEMCG
 # define SLAB_ACCOUNT		__SLAB_FLAG_BIT(_SLAB_ACCOUNT)
 #else
 # define SLAB_ACCOUNT		__SLAB_FLAG_UNUSED
@@ -394,7 +394,7 @@ enum kmalloc_cache_type {
 #ifndef CONFIG_ZONE_DMA
 	KMALLOC_DMA = KMALLOC_NORMAL,
 #endif
-#ifndef CONFIG_MEMCG_KMEM
+#ifndef CONFIG_MEMCG
 	KMALLOC_CGROUP = KMALLOC_NORMAL,
 #endif
 	KMALLOC_RANDOM_START = KMALLOC_NORMAL,
@@ -407,7 +407,7 @@ enum kmalloc_cache_type {
 #ifdef CONFIG_ZONE_DMA
 	KMALLOC_DMA,
 #endif
-#ifdef CONFIG_MEMCG_KMEM
+#ifdef CONFIG_MEMCG
 	KMALLOC_CGROUP,
 #endif
 	NR_KMALLOC_TYPES
@@ -422,7 +422,7 @@ kmalloc_caches[NR_KMALLOC_TYPES][KMALLOC_SHIFT_HIGH + 1];
 #define KMALLOC_NOT_NORMAL_BITS					\
 	(__GFP_RECLAIMABLE |					\
 	(IS_ENABLED(CONFIG_ZONE_DMA)   ? __GFP_DMA : 0) |	\
-	(IS_ENABLED(CONFIG_MEMCG_KMEM) ? __GFP_ACCOUNT : 0))
+	(IS_ENABLED(CONFIG_KMEM) ? __GFP_ACCOUNT : 0))
 
 extern unsigned long random_kmalloc_seed;
 
@@ -450,7 +450,7 @@ static __always_inline enum kmalloc_cache_type kmalloc_type(gfp_t flags, unsigne
 	 */
 	if (IS_ENABLED(CONFIG_ZONE_DMA) && (flags & __GFP_DMA))
 		return KMALLOC_DMA;
-	if (!IS_ENABLED(CONFIG_MEMCG_KMEM) || (flags & __GFP_RECLAIMABLE))
+	if (!IS_ENABLED(CONFIG_MEMCG) || (flags & __GFP_RECLAIMABLE))
 		return KMALLOC_RECLAIM;
 	else
 		return KMALLOC_CGROUP;
diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
index 6e62cc64cd92..33d3e6af7f43 100644
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
index f3ea5dea9c85..ef6bf97005ce 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -965,11 +965,6 @@ config MEMCG
 	help
 	  Provides control over the memory footprint of tasks in a cgroup.
 
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
index ae2ff73bde7e..be5007eb351d 100644
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
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index aab3f5473203..7251ed124011 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -255,7 +255,6 @@ struct mem_cgroup *vmpressure_to_memcg(struct vmpressure *vmpr)
 #define CURRENT_OBJCG_UPDATE_BIT 0
 #define CURRENT_OBJCG_UPDATE_FLAG (1UL << CURRENT_OBJCG_UPDATE_BIT)
 
-#ifdef CONFIG_MEMCG_KMEM
 static DEFINE_SPINLOCK(objcg_lock);
 
 bool mem_cgroup_kmem_disabled(void)
@@ -360,7 +359,6 @@ EXPORT_SYMBOL(memcg_kmem_online_key);
 
 DEFINE_STATIC_KEY_FALSE(memcg_bpf_enabled_key);
 EXPORT_SYMBOL(memcg_bpf_enabled_key);
-#endif
 
 /**
  * mem_cgroup_css_from_folio - css of the memcg associated with a folio
@@ -593,7 +591,7 @@ static const unsigned int memcg_vm_event_stat[] = {
 	PGDEACTIVATE,
 	PGLAZYFREE,
 	PGLAZYFREED,
-#if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
+#ifdef CONFIG_ZSWAP
 	ZSWPIN,
 	ZSWPOUT,
 	ZSWPWB,
@@ -1556,7 +1554,7 @@ static const struct memory_stat memory_stats[] = {
 	{ "sock",			MEMCG_SOCK			},
 	{ "vmalloc",			MEMCG_VMALLOC			},
 	{ "shmem",			NR_SHMEM			},
-#if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
+#ifdef CONFIG_ZSWAP
 	{ "zswap",			MEMCG_ZSWAP_B			},
 	{ "zswapped",			MEMCG_ZSWAPPED			},
 #endif
@@ -2259,13 +2257,11 @@ struct memcg_stock_pcp {
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
@@ -2276,27 +2272,11 @@ static DEFINE_PER_CPU(struct memcg_stock_pcp, memcg_stock) = {
 };
 static DEFINE_MUTEX(percpu_charge_mutex);
 
-#ifdef CONFIG_MEMCG_KMEM
 static struct obj_cgroup *drain_obj_stock(struct memcg_stock_pcp *stock);
 static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
 				     struct mem_cgroup *root_memcg);
 static void memcg_account_kmem(struct mem_cgroup *memcg, int nr_pages);
 
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
-static void memcg_account_kmem(struct mem_cgroup *memcg, int nr_pages)
-{
-}
-#endif
-
 /**
  * consume_stock: Try to consume stocked charge on this cpu.
  * @memcg: memcg to consume from.
@@ -2978,7 +2958,6 @@ void mem_cgroup_commit_charge(struct folio *folio, struct mem_cgroup *memcg)
 	local_irq_enable();
 }
 
-#ifdef CONFIG_MEMCG_KMEM
 /*
  * The allocated objcg pointers array is not accounted directly.
  * Moreover, it should not come from DMA buffer and is not readily
@@ -3600,8 +3579,6 @@ void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size)
 	refill_obj_stock(objcg, size, true);
 }
 
-#endif /* CONFIG_MEMCG_KMEM */
-
 /*
  * Because page_memcg(head) is not set on tails, set it now.
  */
@@ -3941,7 +3918,6 @@ static int mem_cgroup_dummy_seq_show(__always_unused struct seq_file *m,
 	return -EINVAL;
 }
 
-#ifdef CONFIG_MEMCG_KMEM
 static int memcg_online_kmem(struct mem_cgroup *memcg)
 {
 	struct obj_cgroup *objcg;
@@ -3992,15 +3968,6 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
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
 
 static int memcg_update_tcp_max(struct mem_cgroup *memcg, unsigned long max)
 {
@@ -5197,7 +5164,7 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
 	return ret;
 }
 
-#if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_SLUB_DEBUG)
+#ifdef CONFIG_SLUB_DEBUG
 static int mem_cgroup_slab_show(struct seq_file *m, void *p)
 {
 	/*
@@ -5306,7 +5273,7 @@ static struct cftype mem_cgroup_legacy_files[] = {
 		.write = mem_cgroup_reset,
 		.read_u64 = mem_cgroup_read_u64,
 	},
-#if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_SLUB_DEBUG)
+#ifdef CONFIG_SLUB_DEBUG
 	{
 		.name = "kmem.slabinfo",
 		.seq_show = mem_cgroup_slab_show,
@@ -5533,10 +5500,8 @@ static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
 	INIT_LIST_HEAD(&memcg->event_list);
 	spin_lock_init(&memcg->event_list_lock);
 	memcg->socket_pressure = jiffies;
-#ifdef CONFIG_MEMCG_KMEM
 	memcg->kmemcg_id = -1;
 	INIT_LIST_HEAD(&memcg->objcg_list);
-#endif
 #ifdef CONFIG_CGROUP_WRITEBACK
 	INIT_LIST_HEAD(&memcg->cgwb_list);
 	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++)
@@ -5570,7 +5535,7 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 
 	page_counter_set_high(&memcg->memory, PAGE_COUNTER_MAX);
 	WRITE_ONCE(memcg->soft_limit, PAGE_COUNTER_MAX);
-#if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
+#ifdef CONFIG_ZSWAP
 	memcg->zswap_max = PAGE_COUNTER_MAX;
 	WRITE_ONCE(memcg->zswap_writeback,
 		!parent || READ_ONCE(parent->zswap_writeback));
@@ -5598,10 +5563,8 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 	if (cgroup_subsys_on_dfl(memory_cgrp_subsys) && !cgroup_memory_nosocket)
 		static_branch_inc(&memcg_sockets_enabled_key);
 
-#if defined(CONFIG_MEMCG_KMEM)
 	if (!cgroup_memory_nobpf)
 		static_branch_inc(&memcg_bpf_enabled_key);
-#endif
 
 	return &memcg->css;
 }
@@ -5705,10 +5668,8 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && memcg->tcpmem_active)
 		static_branch_dec(&memcg_sockets_enabled_key);
 
-#if defined(CONFIG_MEMCG_KMEM)
 	if (!cgroup_memory_nobpf)
 		static_branch_dec(&memcg_bpf_enabled_key);
-#endif
 
 	vmpressure_cleanup(&memcg->vmpressure);
 	cancel_work_sync(&memcg->high_work);
@@ -6599,7 +6560,6 @@ static void mem_cgroup_move_task(void)
 }
 #endif
 
-#ifdef CONFIG_MEMCG_KMEM
 static void mem_cgroup_fork(struct task_struct *task)
 {
 	/*
@@ -6627,7 +6587,6 @@ static void mem_cgroup_exit(struct task_struct *task)
 	 */
 	task->objcg = NULL;
 }
-#endif
 
 #ifdef CONFIG_LRU_GEN
 static void mem_cgroup_lru_gen_attach(struct cgroup_taskset *tset)
@@ -6651,7 +6610,6 @@ static void mem_cgroup_lru_gen_attach(struct cgroup_taskset *tset)
 static void mem_cgroup_lru_gen_attach(struct cgroup_taskset *tset) {}
 #endif /* CONFIG_LRU_GEN */
 
-#ifdef CONFIG_MEMCG_KMEM
 static void mem_cgroup_kmem_attach(struct cgroup_taskset *tset)
 {
 	struct task_struct *task;
@@ -6662,17 +6620,12 @@ static void mem_cgroup_kmem_attach(struct cgroup_taskset *tset)
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
@@ -7120,15 +7073,11 @@ struct cgroup_subsys memory_cgrp_subsys = {
 	.css_reset = mem_cgroup_css_reset,
 	.css_rstat_flush = mem_cgroup_css_rstat_flush,
 	.can_attach = mem_cgroup_can_attach,
-#if defined(CONFIG_LRU_GEN) || defined(CONFIG_MEMCG_KMEM)
 	.attach = mem_cgroup_attach,
-#endif
 	.cancel_attach = mem_cgroup_cancel_attach,
 	.post_attach = mem_cgroup_move_task,
-#ifdef CONFIG_MEMCG_KMEM
 	.fork = mem_cgroup_fork,
 	.exit = mem_cgroup_exit,
-#endif
 	.dfl_cftypes = memory_files,
 	.legacy_cftypes = mem_cgroup_legacy_files,
 	.early_init = 0,
@@ -8147,7 +8096,7 @@ static struct cftype memsw_files[] = {
 	{ },	/* terminate */
 };
 
-#if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
+#ifdef CONFIG_ZSWAP
 /**
  * obj_cgroup_may_zswap - check if this cgroup can zswap
  * @objcg: the object cgroup
@@ -8329,7 +8278,7 @@ static struct cftype zswap_files[] = {
 	},
 	{ }	/* terminate */
 };
-#endif /* CONFIG_MEMCG_KMEM && CONFIG_ZSWAP */
+#endif /* CONFIG_ZSWAP */
 
 static int __init mem_cgroup_swap_init(void)
 {
@@ -8338,7 +8287,7 @@ static int __init mem_cgroup_swap_init(void)
 
 	WARN_ON(cgroup_add_dfl_cftypes(&memory_cgrp_subsys, swap_files));
 	WARN_ON(cgroup_add_legacy_cftypes(&memory_cgrp_subsys, memsw_files));
-#if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
+#ifdef CONFIG_ZSWAP
 	WARN_ON(cgroup_add_dfl_cftypes(&memory_cgrp_subsys, zswap_files));
 #endif
 	return 0;
diff --git a/mm/percpu-internal.h b/mm/percpu-internal.h
index cdd0aa597a81..7c3f2281ff98 100644
--- a/mm/percpu-internal.h
+++ b/mm/percpu-internal.h
@@ -64,7 +64,7 @@ struct pcpu_chunk {
 	int			end_offset;	/* additional area required to
 						   have the region end page
 						   aligned */
-#ifdef CONFIG_MEMCG_KMEM
+#ifdef CONFIG_MEMCG
 	struct obj_cgroup	**obj_cgroups;	/* vector of object cgroups */
 #endif
 
@@ -132,7 +132,7 @@ static inline size_t pcpu_obj_full_size(size_t size)
 {
 	size_t extra_size = 0;
 
-#ifdef CONFIG_MEMCG_KMEM
+#ifdef CONFIG_MEMCG
 	if (!mem_cgroup_kmem_disabled())
 		extra_size += size / PCPU_MIN_ALLOC_SIZE * sizeof(struct obj_cgroup *);
 #endif
diff --git a/mm/percpu.c b/mm/percpu.c
index 4e11fc1e6def..563ada75087e 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1392,7 +1392,7 @@ static struct pcpu_chunk * __init pcpu_alloc_first_chunk(unsigned long tmp_addr,
 		panic("%s: Failed to allocate %zu bytes\n", __func__,
 		      alloc_size);
 
-#ifdef CONFIG_MEMCG_KMEM
+#ifdef CONFIG_MEMCG
 	/* first chunk is free to use */
 	chunk->obj_cgroups = NULL;
 #endif
@@ -1463,7 +1463,7 @@ static struct pcpu_chunk *pcpu_alloc_chunk(gfp_t gfp)
 	if (!chunk->md_blocks)
 		goto md_blocks_fail;
 
-#ifdef CONFIG_MEMCG_KMEM
+#ifdef CONFIG_MEMCG
 	if (!mem_cgroup_kmem_disabled()) {
 		chunk->obj_cgroups =
 			pcpu_mem_zalloc(pcpu_chunk_map_bits(chunk) *
@@ -1480,7 +1480,7 @@ static struct pcpu_chunk *pcpu_alloc_chunk(gfp_t gfp)
 
 	return chunk;
 
-#ifdef CONFIG_MEMCG_KMEM
+#ifdef CONFIG_MEMCG
 objcg_fail:
 	pcpu_mem_free(chunk->md_blocks);
 #endif
@@ -1498,7 +1498,7 @@ static void pcpu_free_chunk(struct pcpu_chunk *chunk)
 {
 	if (!chunk)
 		return;
-#ifdef CONFIG_MEMCG_KMEM
+#ifdef CONFIG_MEMCG
 	pcpu_mem_free(chunk->obj_cgroups);
 #endif
 	pcpu_mem_free(chunk->md_blocks);
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
 
 /**
  * pcpu_alloc - the percpu allocator
diff --git a/mm/slab.h b/mm/slab.h
index d2bc9b191222..ea49f899c99f 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -536,7 +536,7 @@ static inline bool kmem_cache_debug_flags(struct kmem_cache *s, slab_flags_t fla
 	return false;
 }
 
-#ifdef CONFIG_MEMCG_KMEM
+#ifdef CONFIG_MEMCG
 /*
  * slab_objcgs - get the object cgroups vector associated with a slab
  * @slab: a pointer to the slab struct
@@ -559,7 +559,7 @@ int memcg_alloc_slab_cgroups(struct slab *slab, struct kmem_cache *s,
 				 gfp_t gfp, bool new_slab);
 void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 		     enum node_stat_item idx, int nr);
-#else /* CONFIG_MEMCG_KMEM */
+#else /* CONFIG_MEMCG */
 static inline struct obj_cgroup **slab_objcgs(struct slab *slab)
 {
 	return NULL;
@@ -571,7 +571,7 @@ static inline int memcg_alloc_slab_cgroups(struct slab *slab,
 {
 	return 0;
 }
-#endif /* CONFIG_MEMCG_KMEM */
+#endif /* CONFIG_MEMCG */
 
 size_t __ksize(const void *objp);
 
diff --git a/mm/slab_common.c b/mm/slab_common.c
index f5234672f03c..18a42b12696e 100644
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
 		for (i = KMALLOC_SHIFT_LOW; i <= KMALLOC_SHIFT_HIGH; i++) {
diff --git a/mm/slub.c b/mm/slub.c
index 1bb2a93cf7b6..3444a1c34abc 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1871,7 +1871,7 @@ static inline enum node_stat_item cache_vmstat_idx(struct kmem_cache *s)
 		NR_SLAB_RECLAIMABLE_B : NR_SLAB_UNRECLAIMABLE_B;
 }
 
-#ifdef CONFIG_MEMCG_KMEM
+#ifdef CONFIG_MEMCG
 static inline void memcg_free_slab_cgroups(struct slab *slab)
 {
 	kfree(slab_objcgs(slab));
@@ -2027,7 +2027,7 @@ void memcg_slab_alloc_error_hook(struct kmem_cache *s, int objects,
 	if (objcg)
 		obj_cgroup_uncharge(objcg, objects * obj_full_size(s));
 }
-#else /* CONFIG_MEMCG_KMEM */
+#else /* CONFIG_MEMCG */
 static inline void memcg_free_slab_cgroups(struct slab *slab)
 {
 }
@@ -2057,7 +2057,7 @@ void memcg_slab_alloc_error_hook(struct kmem_cache *s, int objects,
 				 struct obj_cgroup *objcg)
 {
 }
-#endif /* CONFIG_MEMCG_KMEM */
+#endif /* CONFIG_MEMCG */
 
 /*
  * Hooks for other subsystems that check memory allocations. In a typical
diff --git a/mm/zswap.c b/mm/zswap.c
index b31c977f53e9..a4db8028a875 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1303,7 +1303,7 @@ static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
 	if (!zswap_shrinker_enabled || !mem_cgroup_zswap_writeback_enabled(memcg))
 		return 0;
 
-#ifdef CONFIG_MEMCG_KMEM
+#ifdef CONFIG_MEMCG
 	mem_cgroup_flush_stats(memcg);
 	nr_backing = memcg_page_state(memcg, MEMCG_ZSWAP_B) >> PAGE_SHIFT;
 	nr_stored = memcg_page_state(memcg, MEMCG_ZSWAPPED);
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
2.44.0


