Return-Path: <cgroups+bounces-364-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BD37EA389
	for <lists+cgroups@lfdr.de>; Mon, 13 Nov 2023 20:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37589280F60
	for <lists+cgroups@lfdr.de>; Mon, 13 Nov 2023 19:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5B223771;
	Mon, 13 Nov 2023 19:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vks2zsCM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NVLU6T7U"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D496B2375A
	for <cgroups@vger.kernel.org>; Mon, 13 Nov 2023 19:14:17 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C17D56;
	Mon, 13 Nov 2023 11:14:14 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7F8F31F88B;
	Mon, 13 Nov 2023 19:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1699902852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s3nv+0Sqzbudyo8axulOBmhTAGTu9yIEYPQrJtiVg8g=;
	b=vks2zsCM2llHj2sCCNK9iUCdg8yLjPuDMFNCq4IalcG7o90NBHa+OTVb0fXGiJrhrwpwYi
	eoM6HhnvLwPRECQzx2k/FUKvIv7EsitvuHas9JkZUEjuQNDLF/nXp8s710eafRrHg4uXmO
	K8nDzHTLl4j/Sw18qemcBGyijZRNTPg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1699902852;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s3nv+0Sqzbudyo8axulOBmhTAGTu9yIEYPQrJtiVg8g=;
	b=NVLU6T7UIVzg+w41i7fPZrmuaz6c4SpNekbAkxpwCsyh8sjZD+OYPyG+lLTH+jGSwt97x2
	yJeIxfuLzOomJoAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 350B613907;
	Mon, 13 Nov 2023 19:14:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 6KdtDIR1UmVFOgAAMHmgww
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
Subject: [PATCH 09/20] mm/slab: move struct kmem_cache_cpu declaration to slub.c
Date: Mon, 13 Nov 2023 20:13:50 +0100
Message-ID: <20231113191340.17482-31-vbabka@suse.cz>
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

Nothing outside SLUB itself accesses the struct kmem_cache_cpu fields so
it does not need to be declared in slub_def.h. This allows also to move
enum stat_item.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/slub_def.h | 54 ----------------------------------------
 mm/slub.c                | 54 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 54 deletions(-)

diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
index deb90cf4bffb..a0229ea42977 100644
--- a/include/linux/slub_def.h
+++ b/include/linux/slub_def.h
@@ -12,60 +12,6 @@
 #include <linux/reciprocal_div.h>
 #include <linux/local_lock.h>
 
-enum stat_item {
-	ALLOC_FASTPATH,		/* Allocation from cpu slab */
-	ALLOC_SLOWPATH,		/* Allocation by getting a new cpu slab */
-	FREE_FASTPATH,		/* Free to cpu slab */
-	FREE_SLOWPATH,		/* Freeing not to cpu slab */
-	FREE_FROZEN,		/* Freeing to frozen slab */
-	FREE_ADD_PARTIAL,	/* Freeing moves slab to partial list */
-	FREE_REMOVE_PARTIAL,	/* Freeing removes last object */
-	ALLOC_FROM_PARTIAL,	/* Cpu slab acquired from node partial list */
-	ALLOC_SLAB,		/* Cpu slab acquired from page allocator */
-	ALLOC_REFILL,		/* Refill cpu slab from slab freelist */
-	ALLOC_NODE_MISMATCH,	/* Switching cpu slab */
-	FREE_SLAB,		/* Slab freed to the page allocator */
-	CPUSLAB_FLUSH,		/* Abandoning of the cpu slab */
-	DEACTIVATE_FULL,	/* Cpu slab was full when deactivated */
-	DEACTIVATE_EMPTY,	/* Cpu slab was empty when deactivated */
-	DEACTIVATE_TO_HEAD,	/* Cpu slab was moved to the head of partials */
-	DEACTIVATE_TO_TAIL,	/* Cpu slab was moved to the tail of partials */
-	DEACTIVATE_REMOTE_FREES,/* Slab contained remotely freed objects */
-	DEACTIVATE_BYPASS,	/* Implicit deactivation */
-	ORDER_FALLBACK,		/* Number of times fallback was necessary */
-	CMPXCHG_DOUBLE_CPU_FAIL,/* Failure of this_cpu_cmpxchg_double */
-	CMPXCHG_DOUBLE_FAIL,	/* Number of times that cmpxchg double did not match */
-	CPU_PARTIAL_ALLOC,	/* Used cpu partial on alloc */
-	CPU_PARTIAL_FREE,	/* Refill cpu partial on free */
-	CPU_PARTIAL_NODE,	/* Refill cpu partial from node partial */
-	CPU_PARTIAL_DRAIN,	/* Drain cpu partial to node partial */
-	NR_SLUB_STAT_ITEMS
-};
-
-#ifndef CONFIG_SLUB_TINY
-/*
- * When changing the layout, make sure freelist and tid are still compatible
- * with this_cpu_cmpxchg_double() alignment requirements.
- */
-struct kmem_cache_cpu {
-	union {
-		struct {
-			void **freelist;	/* Pointer to next available object */
-			unsigned long tid;	/* Globally unique transaction id */
-		};
-		freelist_aba_t freelist_tid;
-	};
-	struct slab *slab;	/* The slab from which we are allocating */
-#ifdef CONFIG_SLUB_CPU_PARTIAL
-	struct slab *partial;	/* Partially allocated frozen slabs */
-#endif
-	local_lock_t lock;	/* Protects the fields above */
-#ifdef CONFIG_SLUB_STATS
-	unsigned stat[NR_SLUB_STAT_ITEMS];
-#endif
-};
-#endif /* CONFIG_SLUB_TINY */
-
 #ifdef CONFIG_SLUB_CPU_PARTIAL
 #define slub_percpu_partial(c)		((c)->partial)
 
diff --git a/mm/slub.c b/mm/slub.c
index 63d281dfacdb..64170a1ccbba 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -330,6 +330,60 @@ static void debugfs_slab_add(struct kmem_cache *);
 static inline void debugfs_slab_add(struct kmem_cache *s) { }
 #endif
 
+enum stat_item {
+	ALLOC_FASTPATH,		/* Allocation from cpu slab */
+	ALLOC_SLOWPATH,		/* Allocation by getting a new cpu slab */
+	FREE_FASTPATH,		/* Free to cpu slab */
+	FREE_SLOWPATH,		/* Freeing not to cpu slab */
+	FREE_FROZEN,		/* Freeing to frozen slab */
+	FREE_ADD_PARTIAL,	/* Freeing moves slab to partial list */
+	FREE_REMOVE_PARTIAL,	/* Freeing removes last object */
+	ALLOC_FROM_PARTIAL,	/* Cpu slab acquired from node partial list */
+	ALLOC_SLAB,		/* Cpu slab acquired from page allocator */
+	ALLOC_REFILL,		/* Refill cpu slab from slab freelist */
+	ALLOC_NODE_MISMATCH,	/* Switching cpu slab */
+	FREE_SLAB,		/* Slab freed to the page allocator */
+	CPUSLAB_FLUSH,		/* Abandoning of the cpu slab */
+	DEACTIVATE_FULL,	/* Cpu slab was full when deactivated */
+	DEACTIVATE_EMPTY,	/* Cpu slab was empty when deactivated */
+	DEACTIVATE_TO_HEAD,	/* Cpu slab was moved to the head of partials */
+	DEACTIVATE_TO_TAIL,	/* Cpu slab was moved to the tail of partials */
+	DEACTIVATE_REMOTE_FREES,/* Slab contained remotely freed objects */
+	DEACTIVATE_BYPASS,	/* Implicit deactivation */
+	ORDER_FALLBACK,		/* Number of times fallback was necessary */
+	CMPXCHG_DOUBLE_CPU_FAIL,/* Failures of this_cpu_cmpxchg_double */
+	CMPXCHG_DOUBLE_FAIL,	/* Failures of slab freelist update */
+	CPU_PARTIAL_ALLOC,	/* Used cpu partial on alloc */
+	CPU_PARTIAL_FREE,	/* Refill cpu partial on free */
+	CPU_PARTIAL_NODE,	/* Refill cpu partial from node partial */
+	CPU_PARTIAL_DRAIN,	/* Drain cpu partial to node partial */
+	NR_SLUB_STAT_ITEMS
+};
+
+#ifndef CONFIG_SLUB_TINY
+/*
+ * When changing the layout, make sure freelist and tid are still compatible
+ * with this_cpu_cmpxchg_double() alignment requirements.
+ */
+struct kmem_cache_cpu {
+	union {
+		struct {
+			void **freelist;	/* Pointer to next available object */
+			unsigned long tid;	/* Globally unique transaction id */
+		};
+		freelist_aba_t freelist_tid;
+	};
+	struct slab *slab;	/* The slab from which we are allocating */
+#ifdef CONFIG_SLUB_CPU_PARTIAL
+	struct slab *partial;	/* Partially allocated frozen slabs */
+#endif
+	local_lock_t lock;	/* Protects the fields above */
+#ifdef CONFIG_SLUB_STATS
+	unsigned int stat[NR_SLUB_STAT_ITEMS];
+#endif
+};
+#endif /* CONFIG_SLUB_TINY */
+
 static inline void stat(const struct kmem_cache *s, enum stat_item si)
 {
 #ifdef CONFIG_SLUB_STATS
-- 
2.42.1


