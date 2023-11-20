Return-Path: <cgroups+bounces-495-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1783C7F1CA7
	for <lists+cgroups@lfdr.de>; Mon, 20 Nov 2023 19:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3981C1C218CD
	for <lists+cgroups@lfdr.de>; Mon, 20 Nov 2023 18:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FC436AFB;
	Mon, 20 Nov 2023 18:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="puBmaHYO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="61j42JPK"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA3310E;
	Mon, 20 Nov 2023 10:34:45 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7BA801F8B0;
	Mon, 20 Nov 2023 18:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1700505282; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HkihGKFc7KfRcWPJtAKuLkRXW3e6zJHroeb9H0FmoFU=;
	b=puBmaHYOLcQhulZIDjXI09Vo8lTbTPvOPmojSUQejrrEFaTLXdCS3Jkg1iYOVQWphuVXI0
	yBCLxHR7NAQOIexwX+cU6UWapVt23UObrlMqRJwWBxcBzyNgNObd7pD7PVTp4sgRJLHEFa
	u2Os382UirLoEEFn1tiSPCBLBPJVkJw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1700505282;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HkihGKFc7KfRcWPJtAKuLkRXW3e6zJHroeb9H0FmoFU=;
	b=61j42JPKc2OPFeYKBJ+8Rs2/oGvqgHWV0FVnaaCdFKUgEgCcW51EtfqMnyXUrtU+S1rntl
	kr6P9SX6Fr7TfBBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4A47713912;
	Mon, 20 Nov 2023 18:34:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id ANuuEcKmW2UUMgAAMHmgww
	(envelope-from <vbabka@suse.cz>); Mon, 20 Nov 2023 18:34:42 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Mon, 20 Nov 2023 19:34:24 +0100
Subject: [PATCH v2 13/21] mm/slab: move pre/post-alloc hooks from slab.h to
 slub.c
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231120-slab-remove-slab-v2-13-9c9c70177183@suse.cz>
References: <20231120-slab-remove-slab-v2-0-9c9c70177183@suse.cz>
In-Reply-To: <20231120-slab-remove-slab-v2-0-9c9c70177183@suse.cz>
To: David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>, 
 Pekka Enberg <penberg@kernel.org>, Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
 Alexander Potapenko <glider@google.com>, 
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Marco Elver <elver@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeelb@google.com>, 
 Muchun Song <muchun.song@linux.dev>, Kees Cook <keescook@chromium.org>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 kasan-dev@googlegroups.com, cgroups@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.12.4
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: 1.30
X-Spamd-Result: default: False [1.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RCVD_TLS_ALL(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 R_RATELIMIT(0.00)[to_ip_from(RL563rtnmcmc9sawm86hmgtctc)];
	 BAYES_SPAM(5.10)[100.00%];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[24];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,linux.dev,google.com,arm.com,cmpxchg.org,kernel.org,chromium.org,kvack.org,vger.kernel.org,googlegroups.com,suse.cz];
	 RCVD_COUNT_TWO(0.00)[2];
	 SUSPICIOUS_RECIPS(1.50)[]

We don't share the hooks between two slab implementations anymore so
they can be moved away from the header. As part of the move, also move
should_failslab() from slab_common.c as the pre_alloc hook uses it.
This means slab.h can stop including fault-inject.h and kmemleak.h.
Fix up some files that were depending on the includes transitively.

Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/kasan/report.c |  1 +
 mm/memcontrol.c   |  1 +
 mm/slab.h         | 72 -------------------------------------------------
 mm/slab_common.c  |  8 +-----
 mm/slub.c         | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
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
index 1ac3a2f8d4c0..65ebf86b3fe9 100644
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
 
@@ -796,76 +794,6 @@ static inline size_t slab_ksize(const struct kmem_cache *s)
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
index 979932d046fd..9eb6508152c2 100644
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


