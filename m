Return-Path: <cgroups+bounces-361-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5AD7EA382
	for <lists+cgroups@lfdr.de>; Mon, 13 Nov 2023 20:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 474931F223EC
	for <lists+cgroups@lfdr.de>; Mon, 13 Nov 2023 19:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520B9241EA;
	Mon, 13 Nov 2023 19:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="x6gwpjWZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4i4+efNv"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BB523767
	for <cgroups@vger.kernel.org>; Mon, 13 Nov 2023 19:14:17 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16241724;
	Mon, 13 Nov 2023 11:14:14 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8AC962190C;
	Mon, 13 Nov 2023 19:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1699902853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BJGzWBWfS91Bn2q4x5GTRkmtz77nGJm/AYtGcjP8oqQ=;
	b=x6gwpjWZRoU2cJwQRUstIwlnB2tOMZOiZggNYtZom5dv/fxN86SVhE8s5HQRTwoUb8s69Y
	JS+UErYoyEunv1otlp/7QTaBy+fwdnfhzEih5W5glYjm1S+f2rEMkyR0XrSwtkPNOcZHHg
	Ibt8bic0mbDFBuKf4ss5DfZvMbpCGyM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1699902853;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BJGzWBWfS91Bn2q4x5GTRkmtz77nGJm/AYtGcjP8oqQ=;
	b=4i4+efNvutHlf3ZGlqhNLQX/vcouywCQ1zBzA9GHIaTWE+CXyXRe315n8/urbTqjDAGA45
	hKHukNur3sX1ItDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3AAE713398;
	Mon, 13 Nov 2023 19:14:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id ALK4DYV1UmVFOgAAMHmgww
	(envelope-from <vbabka@suse.cz>); Mon, 13 Nov 2023 19:14:13 +0000
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
Subject: [PATCH 12/20] mm/slab: move pre/post-alloc hooks from slab.h to slub.c
Date: Mon, 13 Nov 2023 20:13:53 +0100
Message-ID: <20231113191340.17482-34-vbabka@suse.cz>
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

We don't share the hooks between two slab implementations anymore so
they can be moved away from the header. As part of the move, also move
should_failslab() from slab_common.c as the pre_alloc hook uses it.
This means slab.h can stop including fault-inject.h and kmemleak.h.
Fix up some files that were depending on the includes transitively.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/kasan/report.c |  1 +
 mm/memcontrol.c   |  1 +
 mm/slab.h         | 72 -----------------------------------------
 mm/slab_common.c  |  8 +----
 mm/slub.c         | 81 +++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 84 insertions(+), 79 deletions(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index e77facb62900..011f727bfaff 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -23,6 +23,7 @@
 #include <linux/stacktrace.h>
 #include <linux/string.h>
 #include <linux/types.h>
+#include <linux/vmalloc.h>
 #include <linux/kasan.h>
 #include <linux/module.h>
 #include <linux/sched/task_stack.h>
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 947fb50eba31..8a0603517065 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -64,6 +64,7 @@
 #include <linux/psi.h>
 #include <linux/seq_buf.h>
 #include <linux/sched/isolation.h>
+#include <linux/kmemleak.h>
 #include "internal.h"
 #include <net/sock.h>
 #include <net/ip.h>
diff --git a/mm/slab.h b/mm/slab.h
index c278f8b15251..aad18992269f 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -9,8 +9,6 @@
 #include <linux/kobject.h>
 #include <linux/sched/mm.h>
 #include <linux/memcontrol.h>
-#include <linux/fault-inject.h>
-#include <linux/kmemleak.h>
 #include <linux/kfence.h>
 #include <linux/kasan.h>
 
@@ -795,76 +793,6 @@ static inline size_t slab_ksize(const struct kmem_cache *s)
 	return s->size;
 }
 
-static inline struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s,
-						     struct list_lru *lru,
-						     struct obj_cgroup **objcgp,
-						     size_t size, gfp_t flags)
-{
-	flags &= gfp_allowed_mask;
-
-	might_alloc(flags);
-
-	if (should_failslab(s, flags))
-		return NULL;
-
-	if (!memcg_slab_pre_alloc_hook(s, lru, objcgp, size, flags))
-		return NULL;
-
-	return s;
-}
-
-static inline void slab_post_alloc_hook(struct kmem_cache *s,
-					struct obj_cgroup *objcg, gfp_t flags,
-					size_t size, void **p, bool init,
-					unsigned int orig_size)
-{
-	unsigned int zero_size = s->object_size;
-	bool kasan_init = init;
-	size_t i;
-
-	flags &= gfp_allowed_mask;
-
-	/*
-	 * For kmalloc object, the allocated memory size(object_size) is likely
-	 * larger than the requested size(orig_size). If redzone check is
-	 * enabled for the extra space, don't zero it, as it will be redzoned
-	 * soon. The redzone operation for this extra space could be seen as a
-	 * replacement of current poisoning under certain debug option, and
-	 * won't break other sanity checks.
-	 */
-	if (kmem_cache_debug_flags(s, SLAB_STORE_USER | SLAB_RED_ZONE) &&
-	    (s->flags & SLAB_KMALLOC))
-		zero_size = orig_size;
-
-	/*
-	 * When slub_debug is enabled, avoid memory initialization integrated
-	 * into KASAN and instead zero out the memory via the memset below with
-	 * the proper size. Otherwise, KASAN might overwrite SLUB redzones and
-	 * cause false-positive reports. This does not lead to a performance
-	 * penalty on production builds, as slub_debug is not intended to be
-	 * enabled there.
-	 */
-	if (__slub_debug_enabled())
-		kasan_init = false;
-
-	/*
-	 * As memory initialization might be integrated into KASAN,
-	 * kasan_slab_alloc and initialization memset must be
-	 * kept together to avoid discrepancies in behavior.
-	 *
-	 * As p[i] might get tagged, memset and kmemleak hook come after KASAN.
-	 */
-	for (i = 0; i < size; i++) {
-		p[i] = kasan_slab_alloc(s, p[i], flags, kasan_init);
-		if (p[i] && init && (!kasan_init || !kasan_has_integrated_init()))
-			memset(p[i], 0, zero_size);
-		kmemleak_alloc_recursive(p[i], s->object_size, 1,
-					 s->flags, flags);
-		kmsan_slab_alloc(s, p[i], flags);
-	}
-
-	memcg_slab_post_alloc_hook(s, objcg, flags, size, p);
-}
 
 /*
  * The slab lists for all objects.
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 63b8411db7ce..bbc2e3f061f1 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -21,6 +21,7 @@
 #include <linux/swiotlb.h>
 #include <linux/proc_fs.h>
 #include <linux/debugfs.h>
+#include <linux/kmemleak.h>
 #include <linux/kasan.h>
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
@@ -1470,10 +1471,3 @@ EXPORT_TRACEPOINT_SYMBOL(kmem_cache_alloc);
 EXPORT_TRACEPOINT_SYMBOL(kfree);
 EXPORT_TRACEPOINT_SYMBOL(kmem_cache_free);
 
-int should_failslab(struct kmem_cache *s, gfp_t gfpflags)
-{
-	if (__should_failslab(s, gfpflags))
-		return -ENOMEM;
-	return 0;
-}
-ALLOW_ERROR_INJECTION(should_failslab, ERRNO);
diff --git a/mm/slub.c b/mm/slub.c
index 64170a1ccbba..e15912d1f6ed 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -34,6 +34,7 @@
 #include <linux/memory.h>
 #include <linux/math64.h>
 #include <linux/fault-inject.h>
+#include <linux/kmemleak.h>
 #include <linux/stacktrace.h>
 #include <linux/prefetch.h>
 #include <linux/memcontrol.h>
@@ -3494,6 +3495,86 @@ static __always_inline void maybe_wipe_obj_freeptr(struct kmem_cache *s,
 			0, sizeof(void *));
 }
 
+noinline int should_failslab(struct kmem_cache *s, gfp_t gfpflags)
+{
+	if (__should_failslab(s, gfpflags))
+		return -ENOMEM;
+	return 0;
+}
+ALLOW_ERROR_INJECTION(should_failslab, ERRNO);
+
+static inline struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s,
+						     struct list_lru *lru,
+						     struct obj_cgroup **objcgp,
+						     size_t size, gfp_t flags)
+{
+	flags &= gfp_allowed_mask;
+
+	might_alloc(flags);
+
+	if (should_failslab(s, flags))
+		return NULL;
+
+	if (!memcg_slab_pre_alloc_hook(s, lru, objcgp, size, flags))
+		return NULL;
+
+	return s;
+}
+
+static inline void slab_post_alloc_hook(struct kmem_cache *s,
+					struct obj_cgroup *objcg, gfp_t flags,
+					size_t size, void **p, bool init,
+					unsigned int orig_size)
+{
+	unsigned int zero_size = s->object_size;
+	bool kasan_init = init;
+	size_t i;
+
+	flags &= gfp_allowed_mask;
+
+	/*
+	 * For kmalloc object, the allocated memory size(object_size) is likely
+	 * larger than the requested size(orig_size). If redzone check is
+	 * enabled for the extra space, don't zero it, as it will be redzoned
+	 * soon. The redzone operation for this extra space could be seen as a
+	 * replacement of current poisoning under certain debug option, and
+	 * won't break other sanity checks.
+	 */
+	if (kmem_cache_debug_flags(s, SLAB_STORE_USER | SLAB_RED_ZONE) &&
+	    (s->flags & SLAB_KMALLOC))
+		zero_size = orig_size;
+
+	/*
+	 * When slub_debug is enabled, avoid memory initialization integrated
+	 * into KASAN and instead zero out the memory via the memset below with
+	 * the proper size. Otherwise, KASAN might overwrite SLUB redzones and
+	 * cause false-positive reports. This does not lead to a performance
+	 * penalty on production builds, as slub_debug is not intended to be
+	 * enabled there.
+	 */
+	if (__slub_debug_enabled())
+		kasan_init = false;
+
+	/*
+	 * As memory initialization might be integrated into KASAN,
+	 * kasan_slab_alloc and initialization memset must be
+	 * kept together to avoid discrepancies in behavior.
+	 *
+	 * As p[i] might get tagged, memset and kmemleak hook come after KASAN.
+	 */
+	for (i = 0; i < size; i++) {
+		p[i] = kasan_slab_alloc(s, p[i], flags, kasan_init);
+		if (p[i] && init && (!kasan_init ||
+				     !kasan_has_integrated_init()))
+			memset(p[i], 0, zero_size);
+		kmemleak_alloc_recursive(p[i], s->object_size, 1,
+					 s->flags, flags);
+		kmsan_slab_alloc(s, p[i], flags);
+	}
+
+	memcg_slab_post_alloc_hook(s, objcg, flags, size, p);
+}
+
 /*
  * Inlined fastpath so that allocation functions (kmalloc, kmem_cache_alloc)
  * have the fastpath folded into their functions. So no function call
-- 
2.42.1


