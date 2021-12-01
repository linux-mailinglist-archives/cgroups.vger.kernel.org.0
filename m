Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C0C4654F4
	for <lists+cgroups@lfdr.de>; Wed,  1 Dec 2021 19:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239098AbhLASTF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Dec 2021 13:19:05 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:58754 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239885AbhLASSl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Dec 2021 13:18:41 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 46216218D6;
        Wed,  1 Dec 2021 18:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638382519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0hE0fFmqoiNZ5hGJ3u4gMJGlq9TtEyRvQ+tV3jhQOoQ=;
        b=z170mukVloZHhS6lJptM10xtAdRsGMxhNSPKammn6pvi8TlZQcjaglrR6cj7LVZVRJA4Oy
        JErbVeTrM9RAURU1MaaLNKzH3jXcaTygrZzBCIKOVqLt28AAQ8/qiMu25F+ZmfDV2YbKzT
        CXYBTxx+dIZgMe+mdOhnG+wFjfdCabc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638382519;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0hE0fFmqoiNZ5hGJ3u4gMJGlq9TtEyRvQ+tV3jhQOoQ=;
        b=5DrVK1sbQLQp5OFueaxVJonuaPm+HG74o1cuMdaw8/IvCEWjHCJfivzYR8141RA2V9eAs2
        7hIYv+kV1HnIJuBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F344713D9D;
        Wed,  1 Dec 2021 18:15:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qAKTOra7p2HPSAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 01 Dec 2021 18:15:18 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        patches@lists.linux.dev, Vlastimil Babka <vbabka@suse.cz>,
        Julia Lawall <julia.lawall@inria.fr>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        kasan-dev@googlegroups.com, cgroups@vger.kernel.org
Subject: [PATCH v2 22/33] mm: Convert struct page to struct slab in functions used by other subsystems
Date:   Wed,  1 Dec 2021 19:14:59 +0100
Message-Id: <20211201181510.18784-23-vbabka@suse.cz>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211201181510.18784-1-vbabka@suse.cz>
References: <20211201181510.18784-1-vbabka@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12792; h=from:subject; bh=4aC1m/tIrV4f6A5tkcUR9hSbFwicVFxxUNwxtFuHz/M=; b=owEBbQGS/pANAwAIAeAhynPxiakQAcsmYgBhp7uQyjTM0RJhg4ccVNFUdyJhAwEXyRJTcz2A4Bws HDG/JZ6JATMEAAEIAB0WIQSNS5MBqTXjGL5IXszgIcpz8YmpEAUCYae7kAAKCRDgIcpz8YmpEBwHCA CV52ZgS8UXOsnBBdrE53Gl6hG4swDw+A5JfmgHoqHu4rUV/Tz3WPV+nTXk71knhMXKKsCm/4i3EYKK GWVge1l2dvBcnhjpD+BbCTPOcz1o3HfQi2aIclyf14+n7WuS3sI/fxSKyZCOevsOa7FB/d5dTuSleZ XxaBG+9au8ZW0MUX8oGEtY45J1XEKbYSf/iHIsCiDR3j6oH/lon+dSvJPKRFWt2oTaovTUXfZQMnBJ yWKAjskRJMfrL4/TSqYvOAre8YMDwGzZ52KS7Pf3x+mVP8TDARN/5StCCkyamZ5SXwfpdNPzJuerUk ViQTe1/XyDC56z5cZNeqEf4FFAjMFa
X-Developer-Key: i=vbabka@suse.cz; a=openpgp; fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

KASAN, KFENCE and memcg interact with SLAB or SLUB internals through functions
nearest_obj(), obj_to_index() and objs_per_slab() that use struct page as
parameter. This patch converts it to struct slab including all callers, through
a coccinelle semantic patch.

// Options: --include-headers --no-includes --smpl-spacing include/linux/slab_def.h include/linux/slub_def.h mm/slab.h mm/kasan/*.c mm/kfence/kfence_test.c mm/memcontrol.c mm/slab.c mm/slub.c
// Note: needs coccinelle 1.1.1 to avoid breaking whitespace

@@
@@

-objs_per_slab_page(
+objs_per_slab(
 ...
 )
 { ... }

@@
@@

-objs_per_slab_page(
+objs_per_slab(
 ...
 )

@@
identifier fn =~ "obj_to_index|objs_per_slab";
@@

 fn(...,
-   const struct page *page
+   const struct slab *slab
    ,...)
 {
<...
(
- page_address(page)
+ slab_address(slab)
|
- page
+ slab
)
...>
 }

@@
identifier fn =~ "nearest_obj";
@@

 fn(...,
-   struct page *page
+   const struct slab *slab
    ,...)
 {
<...
(
- page_address(page)
+ slab_address(slab)
|
- page
+ slab
)
...>
 }

@@
identifier fn =~ "nearest_obj|obj_to_index|objs_per_slab";
expression E;
@@

 fn(...,
(
- slab_page(E)
+ E
|
- virt_to_page(E)
+ virt_to_slab(E)
|
- virt_to_head_page(E)
+ virt_to_slab(E)
|
- page
+ page_slab(page)
)
  ,...)

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Julia Lawall <julia.lawall@inria.fr>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Marco Elver <elver@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: <kasan-dev@googlegroups.com>
Cc: <cgroups@vger.kernel.org>
---
 include/linux/slab_def.h | 16 ++++++++--------
 include/linux/slub_def.h | 18 +++++++++---------
 mm/kasan/common.c        |  4 ++--
 mm/kasan/generic.c       |  2 +-
 mm/kasan/report.c        |  2 +-
 mm/kasan/report_tags.c   |  2 +-
 mm/kfence/kfence_test.c  |  4 ++--
 mm/memcontrol.c          |  4 ++--
 mm/slab.c                | 10 +++++-----
 mm/slab.h                |  4 ++--
 mm/slub.c                |  2 +-
 11 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/include/linux/slab_def.h b/include/linux/slab_def.h
index 3aa5e1e73ab6..e24c9aff6fed 100644
--- a/include/linux/slab_def.h
+++ b/include/linux/slab_def.h
@@ -87,11 +87,11 @@ struct kmem_cache {
 	struct kmem_cache_node *node[MAX_NUMNODES];
 };
 
-static inline void *nearest_obj(struct kmem_cache *cache, struct page *page,
+static inline void *nearest_obj(struct kmem_cache *cache, const struct slab *slab,
 				void *x)
 {
-	void *object = x - (x - page->s_mem) % cache->size;
-	void *last_object = page->s_mem + (cache->num - 1) * cache->size;
+	void *object = x - (x - slab->s_mem) % cache->size;
+	void *last_object = slab->s_mem + (cache->num - 1) * cache->size;
 
 	if (unlikely(object > last_object))
 		return last_object;
@@ -106,16 +106,16 @@ static inline void *nearest_obj(struct kmem_cache *cache, struct page *page,
  *   reciprocal_divide(offset, cache->reciprocal_buffer_size)
  */
 static inline unsigned int obj_to_index(const struct kmem_cache *cache,
-					const struct page *page, void *obj)
+					const struct slab *slab, void *obj)
 {
-	u32 offset = (obj - page->s_mem);
+	u32 offset = (obj - slab->s_mem);
 	return reciprocal_divide(offset, cache->reciprocal_buffer_size);
 }
 
-static inline int objs_per_slab_page(const struct kmem_cache *cache,
-				     const struct page *page)
+static inline int objs_per_slab(const struct kmem_cache *cache,
+				     const struct slab *slab)
 {
-	if (is_kfence_address(page_address(page)))
+	if (is_kfence_address(slab_address(slab)))
 		return 1;
 	return cache->num;
 }
diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
index 8a9c2876ca89..33c5c0e3bd8d 100644
--- a/include/linux/slub_def.h
+++ b/include/linux/slub_def.h
@@ -158,11 +158,11 @@ static inline void sysfs_slab_release(struct kmem_cache *s)
 
 void *fixup_red_left(struct kmem_cache *s, void *p);
 
-static inline void *nearest_obj(struct kmem_cache *cache, struct page *page,
+static inline void *nearest_obj(struct kmem_cache *cache, const struct slab *slab,
 				void *x) {
-	void *object = x - (x - page_address(page)) % cache->size;
-	void *last_object = page_address(page) +
-		(page->objects - 1) * cache->size;
+	void *object = x - (x - slab_address(slab)) % cache->size;
+	void *last_object = slab_address(slab) +
+		(slab->objects - 1) * cache->size;
 	void *result = (unlikely(object > last_object)) ? last_object : object;
 
 	result = fixup_red_left(cache, result);
@@ -178,16 +178,16 @@ static inline unsigned int __obj_to_index(const struct kmem_cache *cache,
 }
 
 static inline unsigned int obj_to_index(const struct kmem_cache *cache,
-					const struct page *page, void *obj)
+					const struct slab *slab, void *obj)
 {
 	if (is_kfence_address(obj))
 		return 0;
-	return __obj_to_index(cache, page_address(page), obj);
+	return __obj_to_index(cache, slab_address(slab), obj);
 }
 
-static inline int objs_per_slab_page(const struct kmem_cache *cache,
-				     const struct page *page)
+static inline int objs_per_slab(const struct kmem_cache *cache,
+				     const struct slab *slab)
 {
-	return page->objects;
+	return slab->objects;
 }
 #endif /* _LINUX_SLUB_DEF_H */
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 8428da2aaf17..6a1cd2d38bff 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -298,7 +298,7 @@ static inline u8 assign_tag(struct kmem_cache *cache,
 	/* For caches that either have a constructor or SLAB_TYPESAFE_BY_RCU: */
 #ifdef CONFIG_SLAB
 	/* For SLAB assign tags based on the object index in the freelist. */
-	return (u8)obj_to_index(cache, virt_to_head_page(object), (void *)object);
+	return (u8)obj_to_index(cache, virt_to_slab(object), (void *)object);
 #else
 	/*
 	 * For SLUB assign a random tag during slab creation, otherwise reuse
@@ -341,7 +341,7 @@ static inline bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
 	if (is_kfence_address(object))
 		return false;
 
-	if (unlikely(nearest_obj(cache, virt_to_head_page(object), object) !=
+	if (unlikely(nearest_obj(cache, virt_to_slab(object), object) !=
 	    object)) {
 		kasan_report_invalid_free(tagged_object, ip);
 		return true;
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index 84a038b07c6f..5d0b79416c4e 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -339,7 +339,7 @@ static void __kasan_record_aux_stack(void *addr, bool can_alloc)
 		return;
 
 	cache = page->slab_cache;
-	object = nearest_obj(cache, page, addr);
+	object = nearest_obj(cache, page_slab(page), addr);
 	alloc_meta = kasan_get_alloc_meta(cache, object);
 	if (!alloc_meta)
 		return;
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 0bc10f452f7e..e00999dc6499 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -249,7 +249,7 @@ static void print_address_description(void *addr, u8 tag)
 
 	if (page && PageSlab(page)) {
 		struct kmem_cache *cache = page->slab_cache;
-		void *object = nearest_obj(cache, page,	addr);
+		void *object = nearest_obj(cache, page_slab(page),	addr);
 
 		describe_object(cache, object, addr, tag);
 	}
diff --git a/mm/kasan/report_tags.c b/mm/kasan/report_tags.c
index 8a319fc16dab..06c21dd77493 100644
--- a/mm/kasan/report_tags.c
+++ b/mm/kasan/report_tags.c
@@ -23,7 +23,7 @@ const char *kasan_get_bug_type(struct kasan_access_info *info)
 	page = kasan_addr_to_page(addr);
 	if (page && PageSlab(page)) {
 		cache = page->slab_cache;
-		object = nearest_obj(cache, page, (void *)addr);
+		object = nearest_obj(cache, page_slab(page), (void *)addr);
 		alloc_meta = kasan_get_alloc_meta(cache, object);
 
 		if (alloc_meta) {
diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
index 695030c1fff8..f7276711d7b9 100644
--- a/mm/kfence/kfence_test.c
+++ b/mm/kfence/kfence_test.c
@@ -291,8 +291,8 @@ static void *test_alloc(struct kunit *test, size_t size, gfp_t gfp, enum allocat
 			 * even for KFENCE objects; these are required so that
 			 * memcg accounting works correctly.
 			 */
-			KUNIT_EXPECT_EQ(test, obj_to_index(s, page, alloc), 0U);
-			KUNIT_EXPECT_EQ(test, objs_per_slab_page(s, page), 1);
+			KUNIT_EXPECT_EQ(test, obj_to_index(s, page_slab(page), alloc), 0U);
+			KUNIT_EXPECT_EQ(test, objs_per_slab(s, page_slab(page)), 1);
 
 			if (policy == ALLOCATE_ANY)
 				return alloc;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6863a834ed42..906edbd92436 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2819,7 +2819,7 @@ static struct mem_cgroup *get_mem_cgroup_from_objcg(struct obj_cgroup *objcg)
 int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s,
 				 gfp_t gfp, bool new_page)
 {
-	unsigned int objects = objs_per_slab_page(s, page);
+	unsigned int objects = objs_per_slab(s, page_slab(page));
 	unsigned long memcg_data;
 	void *vec;
 
@@ -2881,7 +2881,7 @@ struct mem_cgroup *mem_cgroup_from_obj(void *p)
 		struct obj_cgroup *objcg;
 		unsigned int off;
 
-		off = obj_to_index(page->slab_cache, page, p);
+		off = obj_to_index(page->slab_cache, page_slab(page), p);
 		objcg = page_objcgs(page)[off];
 		if (objcg)
 			return obj_cgroup_memcg(objcg);
diff --git a/mm/slab.c b/mm/slab.c
index f0447b087d02..785fffd527fe 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1560,7 +1560,7 @@ static void check_poison_obj(struct kmem_cache *cachep, void *objp)
 		struct slab *slab = virt_to_slab(objp);
 		unsigned int objnr;
 
-		objnr = obj_to_index(cachep, slab_page(slab), objp);
+		objnr = obj_to_index(cachep, slab, objp);
 		if (objnr) {
 			objp = index_to_obj(cachep, slab, objnr - 1);
 			realobj = (char *)objp + obj_offset(cachep);
@@ -2530,7 +2530,7 @@ static void *slab_get_obj(struct kmem_cache *cachep, struct slab *slab)
 static void slab_put_obj(struct kmem_cache *cachep,
 			struct slab *slab, void *objp)
 {
-	unsigned int objnr = obj_to_index(cachep, slab_page(slab), objp);
+	unsigned int objnr = obj_to_index(cachep, slab, objp);
 #if DEBUG
 	unsigned int i;
 
@@ -2717,7 +2717,7 @@ static void *cache_free_debugcheck(struct kmem_cache *cachep, void *objp,
 	if (cachep->flags & SLAB_STORE_USER)
 		*dbg_userword(cachep, objp) = (void *)caller;
 
-	objnr = obj_to_index(cachep, slab_page(slab), objp);
+	objnr = obj_to_index(cachep, slab, objp);
 
 	BUG_ON(objnr >= cachep->num);
 	BUG_ON(objp != index_to_obj(cachep, slab, objnr));
@@ -3663,7 +3663,7 @@ void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
 	objp = object - obj_offset(cachep);
 	kpp->kp_data_offset = obj_offset(cachep);
 	slab = virt_to_slab(objp);
-	objnr = obj_to_index(cachep, slab_page(slab), objp);
+	objnr = obj_to_index(cachep, slab, objp);
 	objp = index_to_obj(cachep, slab, objnr);
 	kpp->kp_objp = objp;
 	if (DEBUG && cachep->flags & SLAB_STORE_USER)
@@ -4181,7 +4181,7 @@ void __check_heap_object(const void *ptr, unsigned long n,
 
 	/* Find and validate object. */
 	cachep = slab->slab_cache;
-	objnr = obj_to_index(cachep, slab_page(slab), (void *)ptr);
+	objnr = obj_to_index(cachep, slab, (void *)ptr);
 	BUG_ON(objnr >= cachep->num);
 
 	/* Find offset within object. */
diff --git a/mm/slab.h b/mm/slab.h
index 7376c9d8aa2b..15d109d8ec89 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -483,7 +483,7 @@ static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
 				continue;
 			}
 
-			off = obj_to_index(s, page, p[i]);
+			off = obj_to_index(s, page_slab(page), p[i]);
 			obj_cgroup_get(objcg);
 			page_objcgs(page)[off] = objcg;
 			mod_objcg_state(objcg, page_pgdat(page),
@@ -522,7 +522,7 @@ static inline void memcg_slab_free_hook(struct kmem_cache *s_orig,
 		else
 			s = s_orig;
 
-		off = obj_to_index(s, page, p[i]);
+		off = obj_to_index(s, page_slab(page), p[i]);
 		objcg = objcgs[off];
 		if (!objcg)
 			continue;
diff --git a/mm/slub.c b/mm/slub.c
index f5344211d8cc..61aaaa662c5e 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4342,7 +4342,7 @@ void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
 #else
 	objp = objp0;
 #endif
-	objnr = obj_to_index(s, slab_page(slab), objp);
+	objnr = obj_to_index(s, slab, objp);
 	kpp->kp_data_offset = (unsigned long)((char *)objp0 - (char *)objp);
 	objp = base + s->size * objnr;
 	kpp->kp_objp = objp;
-- 
2.33.1

