Return-Path: <cgroups+bounces-370-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 583A47EA391
	for <lists+cgroups@lfdr.de>; Mon, 13 Nov 2023 20:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B5341C20937
	for <lists+cgroups@lfdr.de>; Mon, 13 Nov 2023 19:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B24123775;
	Mon, 13 Nov 2023 19:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J/xXyVkR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="x7V0Kskh"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F7A2377D
	for <cgroups@vger.kernel.org>; Mon, 13 Nov 2023 19:14:18 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208001728;
	Mon, 13 Nov 2023 11:14:15 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DAF4D1F88C;
	Mon, 13 Nov 2023 19:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1699902852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cXA2SgJxJZfvYr5jQXRsm4AX40wbUd1muC5Hg9F2/Ho=;
	b=J/xXyVkRwG9lSfoCJ0sf2qONquUSYGBcGDQOJ/KZqHp/2Ym7NKdEIeRsO1HMAF00YvGdpQ
	++5uNeJdkS1dnWj3bfV85B7sWKeT1esox0SyGaMjRaFHxV5UzdaNlz0cFN4h27vUuLRdmi
	b2xb85b9yRuj00ahmRBUZ1SvldtCpa0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1699902852;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cXA2SgJxJZfvYr5jQXRsm4AX40wbUd1muC5Hg9F2/Ho=;
	b=x7V0Kskh+UT6qgyWN1pbjlXOVG+wZu56XEQE1QMz53nsyEzacDIO/mco2BfSmDidoPDY3u
	8ufLwRenOBSrIlAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 817BD13398;
	Mon, 13 Nov 2023 19:14:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id iCnpHoR1UmVFOgAAMHmgww
	(envelope-from <vbabka@suse.cz>); Mon, 13 Nov 2023 19:14:12 +0000
From: Vlastimil Babka <vbabka@suse.cz>
To: David Rientjes <rientjes@google.com>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Marco Elver <elver@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Kees Cook <keescook@chromium.org>,
	kasan-dev@googlegroups.com,
	cgroups@vger.kernel.org,
	Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 10/20] mm/slab: move the rest of slub_def.h to mm/slab.h
Date: Mon, 13 Nov 2023 20:13:51 +0100
Message-ID: <20231113191340.17482-32-vbabka@suse.cz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231113191340.17482-22-vbabka@suse.cz>
References: <20231113191340.17482-22-vbabka@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mm/slab.h is the only place to include include/linux/slub_def.h which
has allowed switching between SLAB and SLUB. Now we can simply move the
contents over and remove slub_def.h.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/slub_def.h | 150 ---------------------------------------
 mm/slab.h                | 137 ++++++++++++++++++++++++++++++++++-
 2 files changed, 136 insertions(+), 151 deletions(-)
 delete mode 100644 include/linux/slub_def.h

diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
deleted file mode 100644
index a0229ea42977..000000000000
--- a/include/linux/slub_def.h
+++ /dev/null
@@ -1,150 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LINUX_SLUB_DEF_H
-#define _LINUX_SLUB_DEF_H
-
-/*
- * SLUB : A Slab allocator without object queues.
- *
- * (C) 2007 SGI, Christoph Lameter
- */
-#include <linux/kfence.h>
-#include <linux/kobject.h>
-#include <linux/reciprocal_div.h>
-#include <linux/local_lock.h>
-
-#ifdef CONFIG_SLUB_CPU_PARTIAL
-#define slub_percpu_partial(c)		((c)->partial)
-
-#define slub_set_percpu_partial(c, p)		\
-({						\
-	slub_percpu_partial(c) = (p)->next;	\
-})
-
-#define slub_percpu_partial_read_once(c)     READ_ONCE(slub_percpu_partial(c))
-#else
-#define slub_percpu_partial(c)			NULL
-
-#define slub_set_percpu_partial(c, p)
-
-#define slub_percpu_partial_read_once(c)	NULL
-#endif // CONFIG_SLUB_CPU_PARTIAL
-
-/*
- * Word size structure that can be atomically updated or read and that
- * contains both the order and the number of objects that a slab of the
- * given order would contain.
- */
-struct kmem_cache_order_objects {
-	unsigned int x;
-};
-
-/*
- * Slab cache management.
- */
-struct kmem_cache {
-#ifndef CONFIG_SLUB_TINY
-	struct kmem_cache_cpu __percpu *cpu_slab;
-#endif
-	/* Used for retrieving partial slabs, etc. */
-	slab_flags_t flags;
-	unsigned long min_partial;
-	unsigned int size;	/* The size of an object including metadata */
-	unsigned int object_size;/* The size of an object without metadata */
-	struct reciprocal_value reciprocal_size;
-	unsigned int offset;	/* Free pointer offset */
-#ifdef CONFIG_SLUB_CPU_PARTIAL
-	/* Number of per cpu partial objects to keep around */
-	unsigned int cpu_partial;
-	/* Number of per cpu partial slabs to keep around */
-	unsigned int cpu_partial_slabs;
-#endif
-	struct kmem_cache_order_objects oo;
-
-	/* Allocation and freeing of slabs */
-	struct kmem_cache_order_objects min;
-	gfp_t allocflags;	/* gfp flags to use on each alloc */
-	int refcount;		/* Refcount for slab cache destroy */
-	void (*ctor)(void *);
-	unsigned int inuse;		/* Offset to metadata */
-	unsigned int align;		/* Alignment */
-	unsigned int red_left_pad;	/* Left redzone padding size */
-	const char *name;	/* Name (only for display!) */
-	struct list_head list;	/* List of slab caches */
-#ifdef CONFIG_SYSFS
-	struct kobject kobj;	/* For sysfs */
-#endif
-#ifdef CONFIG_SLAB_FREELIST_HARDENED
-	unsigned long random;
-#endif
-
-#ifdef CONFIG_NUMA
-	/*
-	 * Defragmentation by allocating from a remote node.
-	 */
-	unsigned int remote_node_defrag_ratio;
-#endif
-
-#ifdef CONFIG_SLAB_FREELIST_RANDOM
-	unsigned int *random_seq;
-#endif
-
-#ifdef CONFIG_KASAN_GENERIC
-	struct kasan_cache kasan_info;
-#endif
-
-#ifdef CONFIG_HARDENED_USERCOPY
-	unsigned int useroffset;	/* Usercopy region offset */
-	unsigned int usersize;		/* Usercopy region size */
-#endif
-
-	struct kmem_cache_node *node[MAX_NUMNODES];
-};
-
-#if defined(CONFIG_SYSFS) && !defined(CONFIG_SLUB_TINY)
-#define SLAB_SUPPORTS_SYSFS
-void sysfs_slab_unlink(struct kmem_cache *);
-void sysfs_slab_release(struct kmem_cache *);
-#else
-static inline void sysfs_slab_unlink(struct kmem_cache *s)
-{
-}
-static inline void sysfs_slab_release(struct kmem_cache *s)
-{
-}
-#endif
-
-void *fixup_red_left(struct kmem_cache *s, void *p);
-
-static inline void *nearest_obj(struct kmem_cache *cache, const struct slab *slab,
-				void *x) {
-	void *object = x - (x - slab_address(slab)) % cache->size;
-	void *last_object = slab_address(slab) +
-		(slab->objects - 1) * cache->size;
-	void *result = (unlikely(object > last_object)) ? last_object : object;
-
-	result = fixup_red_left(cache, result);
-	return result;
-}
-
-/* Determine object index from a given position */
-static inline unsigned int __obj_to_index(const struct kmem_cache *cache,
-					  void *addr, void *obj)
-{
-	return reciprocal_divide(kasan_reset_tag(obj) - addr,
-				 cache->reciprocal_size);
-}
-
-static inline unsigned int obj_to_index(const struct kmem_cache *cache,
-					const struct slab *slab, void *obj)
-{
-	if (is_kfence_address(obj))
-		return 0;
-	return __obj_to_index(cache, slab_address(slab), obj);
-}
-
-static inline int objs_per_slab(const struct kmem_cache *cache,
-				     const struct slab *slab)
-{
-	return slab->objects;
-}
-#endif /* _LINUX_SLUB_DEF_H */
diff --git a/mm/slab.h b/mm/slab.h
index 014c36ea51fa..6e76216ac74e 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -209,7 +209,142 @@ static inline size_t slab_size(const struct slab *slab)
 	return PAGE_SIZE << slab_order(slab);
 }
 
-#include <linux/slub_def.h>
+#include <linux/kfence.h>
+#include <linux/kobject.h>
+#include <linux/reciprocal_div.h>
+#include <linux/local_lock.h>
+
+#ifdef CONFIG_SLUB_CPU_PARTIAL
+#define slub_percpu_partial(c)		((c)->partial)
+
+#define slub_set_percpu_partial(c, p)		\
+({						\
+	slub_percpu_partial(c) = (p)->next;	\
+})
+
+#define slub_percpu_partial_read_once(c)     READ_ONCE(slub_percpu_partial(c))
+#else
+#define slub_percpu_partial(c)			NULL
+
+#define slub_set_percpu_partial(c, p)
+
+#define slub_percpu_partial_read_once(c)	NULL
+#endif // CONFIG_SLUB_CPU_PARTIAL
+
+/*
+ * Word size structure that can be atomically updated or read and that
+ * contains both the order and the number of objects that a slab of the
+ * given order would contain.
+ */
+struct kmem_cache_order_objects {
+	unsigned int x;
+};
+
+/*
+ * Slab cache management.
+ */
+struct kmem_cache {
+#ifndef CONFIG_SLUB_TINY
+	struct kmem_cache_cpu __percpu *cpu_slab;
+#endif
+	/* Used for retrieving partial slabs, etc. */
+	slab_flags_t flags;
+	unsigned long min_partial;
+	unsigned int size;	/* The size of an object including metadata */
+	unsigned int object_size;/* The size of an object without metadata */
+	struct reciprocal_value reciprocal_size;
+	unsigned int offset;	/* Free pointer offset */
+#ifdef CONFIG_SLUB_CPU_PARTIAL
+	/* Number of per cpu partial objects to keep around */
+	unsigned int cpu_partial;
+	/* Number of per cpu partial slabs to keep around */
+	unsigned int cpu_partial_slabs;
+#endif
+	struct kmem_cache_order_objects oo;
+
+	/* Allocation and freeing of slabs */
+	struct kmem_cache_order_objects min;
+	gfp_t allocflags;	/* gfp flags to use on each alloc */
+	int refcount;		/* Refcount for slab cache destroy */
+	void (*ctor)(void *object);	/* Object constructor */
+	unsigned int inuse;		/* Offset to metadata */
+	unsigned int align;		/* Alignment */
+	unsigned int red_left_pad;	/* Left redzone padding size */
+	const char *name;	/* Name (only for display!) */
+	struct list_head list;	/* List of slab caches */
+#ifdef CONFIG_SYSFS
+	struct kobject kobj;	/* For sysfs */
+#endif
+#ifdef CONFIG_SLAB_FREELIST_HARDENED
+	unsigned long random;
+#endif
+
+#ifdef CONFIG_NUMA
+	/*
+	 * Defragmentation by allocating from a remote node.
+	 */
+	unsigned int remote_node_defrag_ratio;
+#endif
+
+#ifdef CONFIG_SLAB_FREELIST_RANDOM
+	unsigned int *random_seq;
+#endif
+
+#ifdef CONFIG_KASAN_GENERIC
+	struct kasan_cache kasan_info;
+#endif
+
+#ifdef CONFIG_HARDENED_USERCOPY
+	unsigned int useroffset;	/* Usercopy region offset */
+	unsigned int usersize;		/* Usercopy region size */
+#endif
+
+	struct kmem_cache_node *node[MAX_NUMNODES];
+};
+
+#if defined(CONFIG_SYSFS) && !defined(CONFIG_SLUB_TINY)
+#define SLAB_SUPPORTS_SYSFS
+void sysfs_slab_unlink(struct kmem_cache *s);
+void sysfs_slab_release(struct kmem_cache *s);
+#else
+static inline void sysfs_slab_unlink(struct kmem_cache *s) { }
+static inline void sysfs_slab_release(struct kmem_cache *s) { }
+#endif
+
+void *fixup_red_left(struct kmem_cache *s, void *p);
+
+static inline void *nearest_obj(struct kmem_cache *cache,
+				const struct slab *slab, void *x) {
+	void *object = x - (x - slab_address(slab)) % cache->size;
+	void *last_object = slab_address(slab) +
+		(slab->objects - 1) * cache->size;
+	void *result = (unlikely(object > last_object)) ? last_object : object;
+
+	result = fixup_red_left(cache, result);
+	return result;
+}
+
+/* Determine object index from a given position */
+static inline unsigned int __obj_to_index(const struct kmem_cache *cache,
+					  void *addr, void *obj)
+{
+	return reciprocal_divide(kasan_reset_tag(obj) - addr,
+				 cache->reciprocal_size);
+}
+
+static inline unsigned int obj_to_index(const struct kmem_cache *cache,
+					const struct slab *slab, void *obj)
+{
+	if (is_kfence_address(obj))
+		return 0;
+	return __obj_to_index(cache, slab_address(slab), obj);
+}
+
+static inline int objs_per_slab(const struct kmem_cache *cache,
+				const struct slab *slab)
+{
+	return slab->objects;
+}
 
 #include <linux/memcontrol.h>
 #include <linux/fault-inject.h>
-- 
2.42.1


