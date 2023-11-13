Return-Path: <cgroups+bounces-365-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E71C27EA38D
	for <lists+cgroups@lfdr.de>; Mon, 13 Nov 2023 20:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B72CB20AF9
	for <lists+cgroups@lfdr.de>; Mon, 13 Nov 2023 19:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E58F2376E;
	Mon, 13 Nov 2023 19:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oIHlLgRj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yC6gI2Oa"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85E523778
	for <cgroups@vger.kernel.org>; Mon, 13 Nov 2023 19:14:18 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C3C1731;
	Mon, 13 Nov 2023 11:14:16 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E153B1F88E;
	Mon, 13 Nov 2023 19:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1699902854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AvYULxpvTpi0KZyzNL3YX1bvF9SuuOz0+MetYRBUoJQ=;
	b=oIHlLgRjvw7JPEbJGFmSOpsKrINW0f9XdqQWVeRsISFOABjZ4DK8pmw1yqPCX9sGOBppD7
	/2PaS3UjA8toXgHPERa2WAt2ew9Q/P4mq1rIHw9O8CtTaonrLfZW/F/b1AC8WVMaSEimF7
	oFMsRG1N0wxBUjIAKDrXoROaTC6D8HQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1699902854;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AvYULxpvTpi0KZyzNL3YX1bvF9SuuOz0+MetYRBUoJQ=;
	b=yC6gI2OaZlpEgEV5qLkZwNfRnz195znLfF6b/XZpYlw9m0kJIbvR1gOmpqfTy7c7Hdbuie
	qkHrE5YZ8HMzm4Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9CF6613398;
	Mon, 13 Nov 2023 19:14:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id sLfCJYZ1UmVFOgAAMHmgww
	(envelope-from <vbabka@suse.cz>); Mon, 13 Nov 2023 19:14:14 +0000
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
Subject: [PATCH 16/20] mm/slab: move kmalloc_slab() to mm/slab.h
Date: Mon, 13 Nov 2023 20:13:57 +0100
Message-ID: <20231113191340.17482-38-vbabka@suse.cz>
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

In preparation for the next patch, move the kmalloc_slab() function to
the header, as it will have callers from two files, and make it inline.
To avoid unnecessary bloat, remove all size checks/warnings from
kmalloc_slab() as they just duplicate those in callers, especially after
recent changes to kmalloc_size_roundup(). We just need to adjust handling
of zero size in __do_kmalloc_node(). Also we can stop handling NULL
result from kmalloc_slab() there as that now cannot happen (unless
called too early during boot).

The size_index array becomes visible so rename it to a more specific
kmalloc_size_index.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slab.h        | 28 ++++++++++++++++++++++++++--
 mm/slab_common.c | 43 ++++++++-----------------------------------
 2 files changed, 34 insertions(+), 37 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index 179467e8aacc..744384efa7be 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -388,8 +388,32 @@ extern const struct kmalloc_info_struct {
 void setup_kmalloc_cache_index_table(void);
 void create_kmalloc_caches(slab_flags_t);
 
-/* Find the kmalloc slab corresponding for a certain size */
-struct kmem_cache *kmalloc_slab(size_t size, gfp_t flags, unsigned long caller);
+extern u8 kmalloc_size_index[24];
+
+static inline unsigned int size_index_elem(unsigned int bytes)
+{
+	return (bytes - 1) / 8;
+}
+
+/*
+ * Find the kmem_cache structure that serves a given size of
+ * allocation
+ *
+ * This assumes size is larger than zero and not larger than
+ * KMALLOC_MAX_CACHE_SIZE and the caller must check that.
+ */
+static inline struct kmem_cache *
+kmalloc_slab(size_t size, gfp_t flags, unsigned long caller)
+{
+	unsigned int index;
+
+	if (size <= 192)
+		index = kmalloc_size_index[size_index_elem(size)];
+	else
+		index = fls(size - 1);
+
+	return kmalloc_caches[kmalloc_type(flags, caller)][index];
+}
 
 void *__kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags,
 			      int node, size_t orig_size,
diff --git a/mm/slab_common.c b/mm/slab_common.c
index f4f275613d2a..31ade17a7ad9 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -665,7 +665,7 @@ EXPORT_SYMBOL(random_kmalloc_seed);
  * of two cache sizes there. The size of larger slabs can be determined using
  * fls.
  */
-static u8 size_index[24] __ro_after_init = {
+u8 kmalloc_size_index[24] __ro_after_init = {
 	3,	/* 8 */
 	4,	/* 16 */
 	5,	/* 24 */
@@ -692,33 +692,6 @@ static u8 size_index[24] __ro_after_init = {
 	2	/* 192 */
 };
 
-static inline unsigned int size_index_elem(unsigned int bytes)
-{
-	return (bytes - 1) / 8;
-}
-
-/*
- * Find the kmem_cache structure that serves a given size of
- * allocation
- */
-struct kmem_cache *kmalloc_slab(size_t size, gfp_t flags, unsigned long caller)
-{
-	unsigned int index;
-
-	if (size <= 192) {
-		if (!size)
-			return ZERO_SIZE_PTR;
-
-		index = size_index[size_index_elem(size)];
-	} else {
-		if (WARN_ON_ONCE(size > KMALLOC_MAX_CACHE_SIZE))
-			return NULL;
-		index = fls(size - 1);
-	}
-
-	return kmalloc_caches[kmalloc_type(flags, caller)][index];
-}
-
 size_t kmalloc_size_roundup(size_t size)
 {
 	if (size && size <= KMALLOC_MAX_CACHE_SIZE) {
@@ -843,9 +816,9 @@ void __init setup_kmalloc_cache_index_table(void)
 	for (i = 8; i < KMALLOC_MIN_SIZE; i += 8) {
 		unsigned int elem = size_index_elem(i);
 
-		if (elem >= ARRAY_SIZE(size_index))
+		if (elem >= ARRAY_SIZE(kmalloc_size_index))
 			break;
-		size_index[elem] = KMALLOC_SHIFT_LOW;
+		kmalloc_size_index[elem] = KMALLOC_SHIFT_LOW;
 	}
 
 	if (KMALLOC_MIN_SIZE >= 64) {
@@ -854,7 +827,7 @@ void __init setup_kmalloc_cache_index_table(void)
 		 * is 64 byte.
 		 */
 		for (i = 64 + 8; i <= 96; i += 8)
-			size_index[size_index_elem(i)] = 7;
+			kmalloc_size_index[size_index_elem(i)] = 7;
 
 	}
 
@@ -865,7 +838,7 @@ void __init setup_kmalloc_cache_index_table(void)
 		 * instead.
 		 */
 		for (i = 128 + 8; i <= 192; i += 8)
-			size_index[size_index_elem(i)] = 8;
+			kmalloc_size_index[size_index_elem(i)] = 8;
 	}
 }
 
@@ -977,10 +950,10 @@ void *__do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller
 		return ret;
 	}
 
-	s = kmalloc_slab(size, flags, caller);
+	if (unlikely(!size))
+		return ZERO_SIZE_PTR;
 
-	if (unlikely(ZERO_OR_NULL_PTR(s)))
-		return s;
+	s = kmalloc_slab(size, flags, caller);
 
 	ret = __kmem_cache_alloc_node(s, flags, node, size, caller);
 	ret = kasan_kmalloc(s, ret, size, flags);
-- 
2.42.1


