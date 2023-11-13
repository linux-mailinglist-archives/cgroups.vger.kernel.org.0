Return-Path: <cgroups+bounces-356-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FCF7EA37E
	for <lists+cgroups@lfdr.de>; Mon, 13 Nov 2023 20:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FF0BB20B5C
	for <lists+cgroups@lfdr.de>; Mon, 13 Nov 2023 19:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212062377C;
	Mon, 13 Nov 2023 19:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="X7VVhHyL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zRCPFoeZ"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31802374B
	for <cgroups@vger.kernel.org>; Mon, 13 Nov 2023 19:14:13 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0D710E5;
	Mon, 13 Nov 2023 11:14:11 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0504B21906;
	Mon, 13 Nov 2023 19:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1699902850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sRrsgxJwat5NXRr1zzXEwT9soXXRRzcekV8Be8tRJ7Y=;
	b=X7VVhHyLuw5jRZn5p6oH6ejSLGgR3WPVlTm60bL6sWdiNYHztbNOQXsqe9CFMWqTmaZ3AY
	D2x+osw9tXWkHMxDHk30QEXQfKJLix4xQsfkUN57u8I8L/5+BSQ9CHWn98tBc06/T/FD45
	7mYBlBSp0TXagVjFeR2CGXtvDAN6tDE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1699902850;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sRrsgxJwat5NXRr1zzXEwT9soXXRRzcekV8Be8tRJ7Y=;
	b=zRCPFoeZ2GTmsf6m0d+7i1K/BRLZjeTx5IgmKVyhLF3sum1/TSGRYltQYoISNmy/QPsNek
	wpyEGHbfsfHhT1AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A64FA13398;
	Mon, 13 Nov 2023 19:14:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 6DkBKIF1UmVFOgAAMHmgww
	(envelope-from <vbabka@suse.cz>); Mon, 13 Nov 2023 19:14:09 +0000
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
Subject: [PATCH 02/20] KASAN: remove code paths guarded by CONFIG_SLAB
Date: Mon, 13 Nov 2023 20:13:43 +0100
Message-ID: <20231113191340.17482-24-vbabka@suse.cz>
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

With SLAB removed and SLUB the only remaining allocator, we can clean up
some code that was depending on the choice.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/kasan/common.c     | 13 ++-----------
 mm/kasan/kasan.h      |  3 +--
 mm/kasan/quarantine.c |  7 -------
 3 files changed, 3 insertions(+), 20 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 256930da578a..5d95219e69d7 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -153,10 +153,6 @@ void __kasan_poison_object_data(struct kmem_cache *cache, void *object)
  * 2. A cache might be SLAB_TYPESAFE_BY_RCU, which means objects can be
  *    accessed after being freed. We preassign tags for objects in these
  *    caches as well.
- * 3. For SLAB allocator we can't preassign tags randomly since the freelist
- *    is stored as an array of indexes instead of a linked list. Assign tags
- *    based on objects indexes, so that objects that are next to each other
- *    get different tags.
  */
 static inline u8 assign_tag(struct kmem_cache *cache,
 					const void *object, bool init)
@@ -171,17 +167,12 @@ static inline u8 assign_tag(struct kmem_cache *cache,
 	if (!cache->ctor && !(cache->flags & SLAB_TYPESAFE_BY_RCU))
 		return init ? KASAN_TAG_KERNEL : kasan_random_tag();
 
-	/* For caches that either have a constructor or SLAB_TYPESAFE_BY_RCU: */
-#ifdef CONFIG_SLAB
-	/* For SLAB assign tags based on the object index in the freelist. */
-	return (u8)obj_to_index(cache, virt_to_slab(object), (void *)object);
-#else
 	/*
-	 * For SLUB assign a random tag during slab creation, otherwise reuse
+	 * For caches that either have a constructor or SLAB_TYPESAFE_BY_RCU,
+	 * assign a random tag during slab creation, otherwise reuse
 	 * the already assigned tag.
 	 */
 	return init ? kasan_random_tag() : get_tag(object);
-#endif
 }
 
 void * __must_check __kasan_init_slab_obj(struct kmem_cache *cache,
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 8b06bab5c406..eef50233640a 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -373,8 +373,7 @@ void kasan_set_track(struct kasan_track *track, gfp_t flags);
 void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags);
 void kasan_save_free_info(struct kmem_cache *cache, void *object);
 
-#if defined(CONFIG_KASAN_GENERIC) && \
-	(defined(CONFIG_SLAB) || defined(CONFIG_SLUB))
+#ifdef CONFIG_KASAN_GENERIC
 bool kasan_quarantine_put(struct kmem_cache *cache, void *object);
 void kasan_quarantine_reduce(void);
 void kasan_quarantine_remove_cache(struct kmem_cache *cache);
diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
index ca4529156735..138c57b836f2 100644
--- a/mm/kasan/quarantine.c
+++ b/mm/kasan/quarantine.c
@@ -144,10 +144,6 @@ static void qlink_free(struct qlist_node *qlink, struct kmem_cache *cache)
 {
 	void *object = qlink_to_object(qlink, cache);
 	struct kasan_free_meta *meta = kasan_get_free_meta(cache, object);
-	unsigned long flags;
-
-	if (IS_ENABLED(CONFIG_SLAB))
-		local_irq_save(flags);
 
 	/*
 	 * If init_on_free is enabled and KASAN's free metadata is stored in
@@ -166,9 +162,6 @@ static void qlink_free(struct qlist_node *qlink, struct kmem_cache *cache)
 	*(u8 *)kasan_mem_to_shadow(object) = KASAN_SLAB_FREE;
 
 	___cache_free(cache, object, _THIS_IP_);
-
-	if (IS_ENABLED(CONFIG_SLAB))
-		local_irq_restore(flags);
 }
 
 static void qlist_free_all(struct qlist_head *q, struct kmem_cache *cache)
-- 
2.42.1


