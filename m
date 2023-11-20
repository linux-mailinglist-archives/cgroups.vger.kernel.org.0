Return-Path: <cgroups+bounces-494-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F5B7F1CA6
	for <lists+cgroups@lfdr.de>; Mon, 20 Nov 2023 19:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9DD22828C1
	for <lists+cgroups@lfdr.de>; Mon, 20 Nov 2023 18:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED18C34555;
	Mon, 20 Nov 2023 18:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dA1DtXnN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hPvTmXax"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3D4CB;
	Mon, 20 Nov 2023 10:34:46 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A69CC1F8B4;
	Mon, 20 Nov 2023 18:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1700505284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CxVtau361btrxEZ1p8oQK+uCjxmURZ9Wrr8QyUc+PdA=;
	b=dA1DtXnNqrzA2tfUWppvLMcFXSoz5YA8kR1l30NMkK9d/reHC3N3+6WLFQbFu+6G/gWj76
	JC3Uh1TALn6ggVdxqlFKre2d3QneXkVjlbhMiZCcq3uLU/WAx9iR2vAZpfgBG5X2D4mPUD
	jM3np8iFo/V/3eDfwFTF2GdSkTpwG4M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1700505284;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CxVtau361btrxEZ1p8oQK+uCjxmURZ9Wrr8QyUc+PdA=;
	b=hPvTmXaxercEKsn6Df6woNxnTvve8p2Um8LN9+kKZnVI6mHvDWKoVXO6fZr38i79VzZZAW
	lzYTXtH3eDkXvLAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 67EF913912;
	Mon, 20 Nov 2023 18:34:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id UHi1GMSmW2UUMgAAMHmgww
	(envelope-from <vbabka@suse.cz>); Mon, 20 Nov 2023 18:34:44 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Mon, 20 Nov 2023 19:34:32 +0100
Subject: [PATCH v2 21/21] mm/slub: optimize free fast path code layout
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231120-slab-remove-slab-v2-21-9c9c70177183@suse.cz>
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
X-Spam-Level: 
X-Spam-Score: -6.80
X-Spamd-Result: default: False [-6.80 / 50.00];
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
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 BAYES_HAM(-3.00)[100.00%];
	 RCPT_COUNT_TWELVE(0.00)[24];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,linux.dev,google.com,arm.com,cmpxchg.org,kernel.org,chromium.org,kvack.org,vger.kernel.org,googlegroups.com,suse.cz];
	 RCVD_COUNT_TWO(0.00)[2];
	 SUSPICIOUS_RECIPS(1.50)[]

Inspection of kmem_cache_free() disassembly showed we could make the
fast path smaller by providing few more hints to the compiler, and
splitting the memcg_slab_free_hook() into an inline part that only
checks if there's work to do, and an out of line part doing the actual
uncharge.

bloat-o-meter results:
add/remove: 2/0 grow/shrink: 0/3 up/down: 286/-554 (-268)
Function                                     old     new   delta
__memcg_slab_free_hook                         -     270    +270
__pfx___memcg_slab_free_hook                   -      16     +16
kfree                                        828     665    -163
kmem_cache_free                             1116     948    -168
kmem_cache_free_bulk.part                   1701    1478    -223

Checking kmem_cache_free() disassembly now shows the non-fastpath
cases are handled out of line, which should reduce instruction cache
usage.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 77d259f3d592..3f8b95757106 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1959,20 +1959,11 @@ void memcg_slab_post_alloc_hook(struct kmem_cache *s, struct obj_cgroup *objcg,
 	return __memcg_slab_post_alloc_hook(s, objcg, flags, size, p);
 }
 
-static inline void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
-					void **p, int objects)
+static void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
+				   void **p, int objects,
+				   struct obj_cgroup **objcgs)
 {
-	struct obj_cgroup **objcgs;
-	int i;
-
-	if (!memcg_kmem_online())
-		return;
-
-	objcgs = slab_objcgs(slab);
-	if (!objcgs)
-		return;
-
-	for (i = 0; i < objects; i++) {
+	for (int i = 0; i < objects; i++) {
 		struct obj_cgroup *objcg;
 		unsigned int off;
 
@@ -1988,6 +1979,22 @@ static inline void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
 		obj_cgroup_put(objcg);
 	}
 }
+
+static __fastpath_inline
+void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
+			  int objects)
+{
+	struct obj_cgroup **objcgs;
+
+	if (!memcg_kmem_online())
+		return;
+
+	objcgs = slab_objcgs(slab);
+	if (likely(!objcgs))
+		return;
+
+	__memcg_slab_free_hook(s, slab, p, objects, objcgs);
+}
 #else /* CONFIG_MEMCG_KMEM */
 static inline struct mem_cgroup *memcg_from_slab_obj(void *ptr)
 {
@@ -2047,7 +2054,7 @@ static __always_inline bool slab_free_hook(struct kmem_cache *s,
 	 * The initialization memset's clear the object and the metadata,
 	 * but don't touch the SLAB redzone.
 	 */
-	if (init) {
+	if (unlikely(init)) {
 		int rsize;
 
 		if (!kasan_has_integrated_init())
@@ -2083,7 +2090,8 @@ static inline bool slab_free_freelist_hook(struct kmem_cache *s,
 		next = get_freepointer(s, object);
 
 		/* If object's reuse doesn't have to be delayed */
-		if (!slab_free_hook(s, object, slab_want_init_on_free(s))) {
+		if (likely(!slab_free_hook(s, object,
+					   slab_want_init_on_free(s)))) {
 			/* Move object to the new freelist */
 			set_freepointer(s, object, *head);
 			*head = object;
@@ -4282,7 +4290,7 @@ static __fastpath_inline void slab_free(struct kmem_cache *s, struct slab *slab,
 	 * With KASAN enabled slab_free_freelist_hook modifies the freelist
 	 * to remove objects, whose reuse must be delayed.
 	 */
-	if (slab_free_freelist_hook(s, &head, &tail, &cnt))
+	if (likely(slab_free_freelist_hook(s, &head, &tail, &cnt)))
 		do_slab_free(s, slab, head, tail, cnt, addr);
 }
 

-- 
2.42.1


