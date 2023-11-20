Return-Path: <cgroups+bounces-478-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FA67F1C8C
	for <lists+cgroups@lfdr.de>; Mon, 20 Nov 2023 19:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C79A21C216D2
	for <lists+cgroups@lfdr.de>; Mon, 20 Nov 2023 18:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FD630FBA;
	Mon, 20 Nov 2023 18:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="A6pk4gEk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mh8c/jJx"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB51CB;
	Mon, 20 Nov 2023 10:34:42 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4693A21907;
	Mon, 20 Nov 2023 18:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1700505280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vcj9xI8buQN1G/rc5/jIHh6rM1KaznuLIHKBfsphrRU=;
	b=A6pk4gEkvXgGbG5JHyYT2Bzkyi3by2QkL/UHE+Wk1ts8hf/IC0pBzq13xK3reyBKouglBG
	57BC1vGB96eU+tgepj5w4PmY6bqABN6QMVWDBrjN/R11nMT5CKdv0/TBDXb+st8aO4WZS1
	dshLAIHsoTHMmmH0K5OJHniF7PAiDXE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1700505280;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vcj9xI8buQN1G/rc5/jIHh6rM1KaznuLIHKBfsphrRU=;
	b=mh8c/jJx8hhsHnhhgXP9hnsvmHVjr5nyg7lJ6LFF9i1+3jxBbWZYqKIJ1Wqm2lzBoUWf0A
	rD2RUjMfd9VM7TCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 042B713499;
	Mon, 20 Nov 2023 18:34:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id OMF+AMCmW2UUMgAAMHmgww
	(envelope-from <vbabka@suse.cz>); Mon, 20 Nov 2023 18:34:40 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Mon, 20 Nov 2023 19:34:14 +0100
Subject: [PATCH v2 03/21] KASAN: remove code paths guarded by CONFIG_SLAB
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231120-slab-remove-slab-v2-3-9c9c70177183@suse.cz>
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
Authentication-Results: smtp-out1.suse.de;
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

With SLAB removed and SLUB the only remaining allocator, we can clean up
some code that was depending on the choice.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Marco Elver <elver@google.com>
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


