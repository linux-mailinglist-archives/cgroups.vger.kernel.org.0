Return-Path: <cgroups+bounces-360-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DFA7EA383
	for <lists+cgroups@lfdr.de>; Mon, 13 Nov 2023 20:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 004D91C209A2
	for <lists+cgroups@lfdr.de>; Mon, 13 Nov 2023 19:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4D3241E8;
	Mon, 13 Nov 2023 19:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JkDwUha8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7F+W9fjH"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A6B23758
	for <cgroups@vger.kernel.org>; Mon, 13 Nov 2023 19:14:17 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6F0171C;
	Mon, 13 Nov 2023 11:14:12 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 70BFD1F86A;
	Mon, 13 Nov 2023 19:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1699902851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=foUH5Pkv5cwwnwudHkR/uUiz9PA77WygUi4ZtZ6vDeI=;
	b=JkDwUha8GrNLV0F4H/HfigXcndrXbPi+DIz32fgM3T7Jbgda20PZxDrXpPDZIYMYjf0bHn
	UPDTgaHgrskjO/8xkYAnx2DM7VfXZ+fOk69GqynKai8G87Ku7QiA+TC0ZtzHdWQMbMhyQQ
	pXW5GQW7+5kbzQcbFJWPNbz3kl4pPN0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1699902851;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=foUH5Pkv5cwwnwudHkR/uUiz9PA77WygUi4ZtZ6vDeI=;
	b=7F+W9fjHMYRYgXcO9sSyXIqFYuruO4RfNRkuH4B8mqfXj7unvPpG/PV5G51XhRCrdrO9Jr
	ncE41UxL51yzoIAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1307813398;
	Mon, 13 Nov 2023 19:14:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 6MwFBIN1UmVFOgAAMHmgww
	(envelope-from <vbabka@suse.cz>); Mon, 13 Nov 2023 19:14:11 +0000
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
Subject: [PATCH 06/20] mm/slab: remove CONFIG_SLAB code from slab common code
Date: Mon, 13 Nov 2023 20:13:47 +0100
Message-ID: <20231113191340.17482-28-vbabka@suse.cz>
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

In slab_common.c and slab.h headers, we can now remove all code behind
CONFIG_SLAB and CONFIG_DEBUG_SLAB ifdefs, and remove all CONFIG_SLUB
ifdefs.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/slab.h | 13 +--------
 mm/slab.h            | 69 ++++----------------------------------------
 mm/slab_common.c     | 22 ++------------
 3 files changed, 8 insertions(+), 96 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 34e43cddc520..90fb1f0d843a 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -24,7 +24,6 @@
 
 /*
  * Flags to pass to kmem_cache_create().
- * The ones marked DEBUG are only valid if CONFIG_DEBUG_SLAB is set.
  */
 /* DEBUG: Perform (expensive) checks on alloc/free */
 #define SLAB_CONSISTENCY_CHECKS	((slab_flags_t __force)0x00000100U)
@@ -302,25 +301,15 @@ static inline unsigned int arch_slab_minalign(void)
  * Kmalloc array related definitions
  */
 
-#ifdef CONFIG_SLAB
 /*
- * SLAB and SLUB directly allocates requests fitting in to an order-1 page
+ * SLUB directly allocates requests fitting in to an order-1 page
  * (PAGE_SIZE*2).  Larger requests are passed to the page allocator.
  */
 #define KMALLOC_SHIFT_HIGH	(PAGE_SHIFT + 1)
 #define KMALLOC_SHIFT_MAX	(MAX_ORDER + PAGE_SHIFT)
 #ifndef KMALLOC_SHIFT_LOW
-#define KMALLOC_SHIFT_LOW	5
-#endif
-#endif
-
-#ifdef CONFIG_SLUB
-#define KMALLOC_SHIFT_HIGH	(PAGE_SHIFT + 1)
-#define KMALLOC_SHIFT_MAX	(MAX_ORDER + PAGE_SHIFT)
-#ifndef KMALLOC_SHIFT_LOW
 #define KMALLOC_SHIFT_LOW	3
 #endif
-#endif
 
 /* Maximum allocatable size */
 #define KMALLOC_MAX_SIZE	(1UL << KMALLOC_SHIFT_MAX)
diff --git a/mm/slab.h b/mm/slab.h
index 3d07fb428393..014c36ea51fa 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -42,21 +42,6 @@ typedef union {
 struct slab {
 	unsigned long __page_flags;
 
-#if defined(CONFIG_SLAB)
-
-	struct kmem_cache *slab_cache;
-	union {
-		struct {
-			struct list_head slab_list;
-			void *freelist;	/* array of free object indexes */
-			void *s_mem;	/* first object */
-		};
-		struct rcu_head rcu_head;
-	};
-	unsigned int active;
-
-#elif defined(CONFIG_SLUB)
-
 	struct kmem_cache *slab_cache;
 	union {
 		struct {
@@ -91,10 +76,6 @@ struct slab {
 	};
 	unsigned int __unused;
 
-#else
-#error "Unexpected slab allocator configured"
-#endif
-
 	atomic_t __page_refcount;
 #ifdef CONFIG_MEMCG
 	unsigned long memcg_data;
@@ -111,7 +92,7 @@ SLAB_MATCH(memcg_data, memcg_data);
 #endif
 #undef SLAB_MATCH
 static_assert(sizeof(struct slab) <= sizeof(struct page));
-#if defined(system_has_freelist_aba) && defined(CONFIG_SLUB)
+#if defined(system_has_freelist_aba)
 static_assert(IS_ALIGNED(offsetof(struct slab, freelist), sizeof(freelist_aba_t)));
 #endif
 
@@ -228,13 +209,7 @@ static inline size_t slab_size(const struct slab *slab)
 	return PAGE_SIZE << slab_order(slab);
 }
 
-#ifdef CONFIG_SLAB
-#include <linux/slab_def.h>
-#endif
-
-#ifdef CONFIG_SLUB
 #include <linux/slub_def.h>
-#endif
 
 #include <linux/memcontrol.h>
 #include <linux/fault-inject.h>
@@ -320,26 +295,16 @@ static inline bool is_kmalloc_cache(struct kmem_cache *s)
 			 SLAB_CACHE_DMA32 | SLAB_PANIC | \
 			 SLAB_TYPESAFE_BY_RCU | SLAB_DEBUG_OBJECTS )
 
-#if defined(CONFIG_DEBUG_SLAB)
-#define SLAB_DEBUG_FLAGS (SLAB_RED_ZONE | SLAB_POISON | SLAB_STORE_USER)
-#elif defined(CONFIG_SLUB_DEBUG)
+#ifdef CONFIG_SLUB_DEBUG
 #define SLAB_DEBUG_FLAGS (SLAB_RED_ZONE | SLAB_POISON | SLAB_STORE_USER | \
 			  SLAB_TRACE | SLAB_CONSISTENCY_CHECKS)
 #else
 #define SLAB_DEBUG_FLAGS (0)
 #endif
 
-#if defined(CONFIG_SLAB)
-#define SLAB_CACHE_FLAGS (SLAB_MEM_SPREAD | SLAB_NOLEAKTRACE | \
-			  SLAB_RECLAIM_ACCOUNT | SLAB_TEMPORARY | \
-			  SLAB_ACCOUNT | SLAB_NO_MERGE)
-#elif defined(CONFIG_SLUB)
 #define SLAB_CACHE_FLAGS (SLAB_NOLEAKTRACE | SLAB_RECLAIM_ACCOUNT | \
 			  SLAB_TEMPORARY | SLAB_ACCOUNT | \
 			  SLAB_NO_USER_FLAGS | SLAB_KMALLOC | SLAB_NO_MERGE)
-#else
-#define SLAB_CACHE_FLAGS (SLAB_NOLEAKTRACE)
-#endif
 
 /* Common flags available with current configuration */
 #define CACHE_CREATE_MASK (SLAB_CORE_FLAGS | SLAB_DEBUG_FLAGS | SLAB_CACHE_FLAGS)
@@ -672,18 +637,14 @@ size_t __ksize(const void *objp);
 
 static inline size_t slab_ksize(const struct kmem_cache *s)
 {
-#ifndef CONFIG_SLUB
-	return s->object_size;
-
-#else /* CONFIG_SLUB */
-# ifdef CONFIG_SLUB_DEBUG
+#ifdef CONFIG_SLUB_DEBUG
 	/*
 	 * Debugging requires use of the padding between object
 	 * and whatever may come after it.
 	 */
 	if (s->flags & (SLAB_RED_ZONE | SLAB_POISON))
 		return s->object_size;
-# endif
+#endif
 	if (s->flags & SLAB_KASAN)
 		return s->object_size;
 	/*
@@ -697,7 +658,6 @@ static inline size_t slab_ksize(const struct kmem_cache *s)
 	 * Else we can use all the padding etc for the allocation
 	 */
 	return s->size;
-#endif
 }
 
 static inline struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s,
@@ -775,23 +735,6 @@ static inline void slab_post_alloc_hook(struct kmem_cache *s,
  * The slab lists for all objects.
  */
 struct kmem_cache_node {
-#ifdef CONFIG_SLAB
-	raw_spinlock_t list_lock;
-	struct list_head slabs_partial;	/* partial list first, better asm code */
-	struct list_head slabs_full;
-	struct list_head slabs_free;
-	unsigned long total_slabs;	/* length of all slab lists */
-	unsigned long free_slabs;	/* length of free slab list only */
-	unsigned long free_objects;
-	unsigned int free_limit;
-	unsigned int colour_next;	/* Per-node cache coloring */
-	struct array_cache *shared;	/* shared per node */
-	struct alien_cache **alien;	/* on other nodes */
-	unsigned long next_reap;	/* updated without locking */
-	int free_touched;		/* updated without locking */
-#endif
-
-#ifdef CONFIG_SLUB
 	spinlock_t list_lock;
 	unsigned long nr_partial;
 	struct list_head partial;
@@ -800,8 +743,6 @@ struct kmem_cache_node {
 	atomic_long_t total_objects;
 	struct list_head full;
 #endif
-#endif
-
 };
 
 static inline struct kmem_cache_node *get_node(struct kmem_cache *s, int node)
@@ -818,7 +759,7 @@ static inline struct kmem_cache_node *get_node(struct kmem_cache *s, int node)
 		 if ((__n = get_node(__s, __node)))
 
 
-#if defined(CONFIG_SLAB) || defined(CONFIG_SLUB_DEBUG)
+#ifdef CONFIG_SLUB_DEBUG
 void dump_unreclaimable_slab(void);
 #else
 static inline void dump_unreclaimable_slab(void)
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 8d431193c273..63b8411db7ce 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -71,10 +71,8 @@ static int __init setup_slab_merge(char *str)
 	return 1;
 }
 
-#ifdef CONFIG_SLUB
 __setup_param("slub_nomerge", slub_nomerge, setup_slab_nomerge, 0);
 __setup_param("slub_merge", slub_merge, setup_slab_merge, 0);
-#endif
 
 __setup("slab_nomerge", setup_slab_nomerge);
 __setup("slab_merge", setup_slab_merge);
@@ -197,10 +195,6 @@ struct kmem_cache *find_mergeable(unsigned int size, unsigned int align,
 		if (s->size - size >= sizeof(void *))
 			continue;
 
-		if (IS_ENABLED(CONFIG_SLAB) && align &&
-			(align > s->align || s->align % align))
-			continue;
-
 		return s;
 	}
 	return NULL;
@@ -1222,12 +1216,8 @@ void cache_random_seq_destroy(struct kmem_cache *cachep)
 }
 #endif /* CONFIG_SLAB_FREELIST_RANDOM */
 
-#if defined(CONFIG_SLAB) || defined(CONFIG_SLUB_DEBUG)
-#ifdef CONFIG_SLAB
-#define SLABINFO_RIGHTS (0600)
-#else
+#ifdef CONFIG_SLUB_DEBUG
 #define SLABINFO_RIGHTS (0400)
-#endif
 
 static void print_slabinfo_header(struct seq_file *m)
 {
@@ -1235,18 +1225,10 @@ static void print_slabinfo_header(struct seq_file *m)
 	 * Output format version, so at least we can change it
 	 * without _too_ many complaints.
 	 */
-#ifdef CONFIG_DEBUG_SLAB
-	seq_puts(m, "slabinfo - version: 2.1 (statistics)\n");
-#else
 	seq_puts(m, "slabinfo - version: 2.1\n");
-#endif
 	seq_puts(m, "# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab>");
 	seq_puts(m, " : tunables <limit> <batchcount> <sharedfactor>");
 	seq_puts(m, " : slabdata <active_slabs> <num_slabs> <sharedavail>");
-#ifdef CONFIG_DEBUG_SLAB
-	seq_puts(m, " : globalstat <listallocs> <maxobjs> <grown> <reaped> <error> <maxfreeable> <nodeallocs> <remotefrees> <alienoverflow>");
-	seq_puts(m, " : cpustat <allochit> <allocmiss> <freehit> <freemiss>");
-#endif
 	seq_putc(m, '\n');
 }
 
@@ -1370,7 +1352,7 @@ static int __init slab_proc_init(void)
 }
 module_init(slab_proc_init);
 
-#endif /* CONFIG_SLAB || CONFIG_SLUB_DEBUG */
+#endif /* CONFIG_SLUB_DEBUG */
 
 static __always_inline __realloc_size(2) void *
 __do_krealloc(const void *p, size_t new_size, gfp_t flags)
-- 
2.42.1


