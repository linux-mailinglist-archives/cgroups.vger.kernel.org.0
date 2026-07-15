Return-Path: <cgroups+bounces-17841-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kY0KKTpeV2oVKgEAu9opvQ
	(envelope-from <cgroups+bounces-17841-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 12:17:30 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFEE75CDCE
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 12:17:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=aRAfAY+T;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17841-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17841-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D3AA31693F6
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 10:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7C343E9DC;
	Wed, 15 Jul 2026 10:11:14 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0932B43E9CE;
	Wed, 15 Jul 2026 10:11:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784110274; cv=none; b=Yn8lmMFa8E7t9IJLjh31dqbEg/hnms0+wDD/9EaWxD+ttvtjaN/f1rf6aHP0PfAu8qZPjNe0Y6LHcT5gE2Z9fxZ4HNUZikF0QpoPkjq3+dxYFUZH8mRJH/uzUIax/GcXl0kPX23dIJ4714FSqkpa27FBycim98iWSf9o9xDzkEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784110274; c=relaxed/simple;
	bh=COHePtv1R+YeIgiHqB4kOJjySGYRX9YbU+4yM3FzOng=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YusR3r1pN6JagOKPNbSJJw2kajgl0v2McCREwWnNyn3rM8Aatful/sq0skXBcjwBEBAKmZCiB5KYoH23CxtKzHL+GJ6Lrypt6gl2o2HaPKXq9pBwLouDP0SBev68kVxSPrEWRjBhRLHz/YAMZAldpOZujBOLUTbY03/Qg9RnFhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRAfAY+T; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F21381F00A3A;
	Wed, 15 Jul 2026 10:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784110272;
	bh=rRhnRYBtmzeslijuXLx/hXq2VN7nb6FRSzXhyrvEmc8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=aRAfAY+TPSpe/gjNK4eC6wi/35JisVhMsWhvXs35eNe8Gqlj4oJ9yhcxYClB08IHV
	 6UqS2mzSMjpA//zvA7KNTLP7vsQnxWPlhUP6l+Kn/mgNSwxHvBWuTT2bY+667GDS8W
	 JUcGI4Ssf0YPs690sVfCljZG5j6XG/6KJh7zJwZe5kklyOojM2j5IAZoqpdQtS2H6V
	 aSLXFZ0AXEa2Ots1eWDKBf0FJ6j0nhuFR2EKjBqv5pdKEki7NXNX8gkHy73AVCRz0d
	 FtinLySDKRz009/8P1VbzxIgSyYFETJeuQVZ46a8mIBnNIn/1vP1qRNJjkP/R8CKIs
	 +ZIVTn81cgfdQ==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Wed, 15 Jul 2026 12:10:48 +0200
Subject: [PATCH RFC 08/12] mm/slab: change struct slabobj_ext to a union
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-b4-objext_split-v1-8-9a49c4ccf4c3@kernel.org>
References: <20260715-b4-objext_split-v1-0-9a49c4ccf4c3@kernel.org>
In-Reply-To: <20260715-b4-objext_split-v1-0-9a49c4ccf4c3@kernel.org>
To: Harry Yoo <harry@kernel.org>, Suren Baghdasaryan <surenb@google.com>
Cc: Hao Li <hao.li@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
 "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:harry@kernel.org,m:surenb@google.com,m:hao.li@linux.dev,m:shakeel.butt@linux.dev,m:glider@google.com,m:elver@google.com,m:akpm@linux-foundation.org,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:vbabka@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[vbabka@kernel.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-17841-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EEFEE75CDCE

Currently, struct slabobj_ext can hold both objcg pointer and
codetag_ref (when both are compile-enabled) and there is an array of as
many slabobj_ext instances as there are objects in a slab.

This makes the layout fixed so even if codetag_ref is unused (because
memory allocation profiling is disabled), the space for them is
allocated and wasted. Similarly, some caches (currently kmalloc_normal)
do not ever need objcg pointers, leading to wasted memory with memory
allocation profiling enabled.

To make this more flexible, change the layout so that struct slabobj_ext
becomes an union of objcg pointer and codetag_ref (to ensure uniform
size; in practice both are the same size anyway). The slabobj_ext array
then can have twice as many elements as before. For cache locality
purposes, the effective memory layout is unchanged, so objcg and codetag
ref for a given object are still adjacent.

static_obj_ext_size() returns the effective size of (0-2) struct
slabobj_ext's, depending on the config. slab_obj_ext_size() is currently
static as well, but takes a slab pointer so it can be made dynamic
later. Replace all sizeof(slabobj_ext) usage with these.

No functional change intended, the layout is still effectively static.

Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 mm/slab.h | 41 +++++++++++++++++++++++++++++++++--------
 mm/slub.c | 17 +++++++++--------
 2 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index 3ad9777ad600..359ab8caf61e 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -554,14 +554,34 @@ static inline bool need_kmalloc_no_objext(void)
  * if MEMCG_DATA_OBJEXTS is set.
  */
 struct slabobj_ext {
+	union {
 #ifdef CONFIG_MEMCG
-	struct obj_cgroup *_objcg;
+		struct obj_cgroup *_objcg;
 #endif
 #ifdef CONFIG_MEM_ALLOC_PROFILING
-	union codetag_ref _ctref;
+		union codetag_ref _ctref;
 #endif
+	};
 } __aligned(8);
 
+static inline size_t static_obj_ext_size(void)
+{
+	size_t sz = 0;
+
+	if (IS_ENABLED(CONFIG_MEMCG))
+		sz += 1;
+
+	if (IS_ENABLED(CONFIG_MEM_ALLOC_PROFILING))
+		sz += 1;
+
+	return sizeof(struct slabobj_ext) * sz;
+}
+
+static inline size_t slab_obj_ext_size(struct slab *slab)
+{
+	return static_obj_ext_size();
+}
+
 #ifdef CONFIG_SLAB_OBJ_EXT
 
 /*
@@ -650,17 +670,18 @@ slab_obj_ext(struct kmem_cache *s, struct slab *slab, unsigned long obj_exts,
 {
 	struct slabobj_ext *obj_ext;
 	unsigned int index;
+	unsigned int stride;
 
 	VM_WARN_ON_ONCE(obj_exts != slab_obj_exts(slab));
 
 	index = obj_to_index(s, slab, obj);
 
-	if (!obj_exts_in_object(slab)) {
-		obj_ext = ((struct slabobj_ext *)obj_exts) + index;
-	} else {
-		unsigned int stride = s->size;
-		obj_ext = (struct slabobj_ext *)(obj_exts + index * stride);
-	}
+	if (!obj_exts_in_object(slab))
+		stride = slab_obj_ext_size(slab);
+	else
+		stride = s->size;
+
+	obj_ext = (struct slabobj_ext *)(obj_exts + index * stride);
 
 	return kasan_reset_tag(obj_ext);
 }
@@ -668,6 +689,7 @@ slab_obj_ext(struct kmem_cache *s, struct slab *slab, unsigned long obj_exts,
 #ifdef CONFIG_MEMCG
 static inline struct obj_cgroup **slab_obj_ext_objcgp(struct slabobj_ext *obj_ext)
 {
+	/* if objcg exists, it's first, so we don't need to do anything */
 	return &obj_ext->_objcg;
 }
 #endif
@@ -676,6 +698,9 @@ static inline struct obj_cgroup **slab_obj_ext_objcgp(struct slabobj_ext *obj_ex
 static inline union codetag_ref *
 slab_obj_ext_codetag_ref(struct slab *slab, struct slabobj_ext *obj_ext)
 {
+	if (IS_ENABLED(CONFIG_MEMCG))
+		obj_ext += 1;
+
 	return &obj_ext->_ctref;
 }
 #endif
diff --git a/mm/slub.c b/mm/slub.c
index 98a14e5842a2..dd15af8abd62 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -803,7 +803,7 @@ static inline bool need_slab_obj_exts(struct kmem_cache *s)
 
 static inline unsigned int obj_exts_size_in_slab(struct slab *slab)
 {
-	return sizeof(struct slabobj_ext) * slab->objects;
+	return slab_obj_ext_size(slab) * slab->objects;
 }
 
 static inline unsigned long obj_exts_offset_in_slab(struct kmem_cache *s,
@@ -1199,7 +1199,7 @@ static void print_trailer(struct kmem_cache *s, struct slab *slab, u8 *p)
 	off += kasan_metadata_size(s, false);
 
 	if (obj_exts_in_object(slab))
-		off += sizeof(struct slabobj_ext);
+		off += slab_obj_ext_size(slab);
 
 	if (off != size_from_object(s))
 		/* Beginning of the filler is the free pointer */
@@ -1404,7 +1404,7 @@ static int check_pad_bytes(struct kmem_cache *s, struct slab *slab, u8 *p)
 	off += kasan_metadata_size(s, false);
 
 	if (obj_exts_in_object(slab))
-		off += sizeof(struct slabobj_ext);
+		off += slab_obj_ext_size(slab);
 
 	if (size_from_object(s) == off)
 		return 1;
@@ -2089,6 +2089,8 @@ static inline bool mark_failed_objexts_alloc(struct slab *slab)
 static inline void handle_failed_objexts_alloc(struct slab *slab,
 		unsigned long obj_exts, struct slabobj_ext *vec)
 {
+	unsigned int stride = slab_obj_ext_size(slab) / sizeof(*vec);
+
 	/*
 	 * If vector previously failed to allocate then we have live
 	 * objects with no tag reference. Mark all references in this
@@ -2101,7 +2103,7 @@ static inline void handle_failed_objexts_alloc(struct slab *slab,
 		union codetag_ref *ref = slab_obj_ext_codetag_ref(slab, vec);
 
 		set_codetag_empty(ref);
-		vec++;
+		vec += stride;
 	}
 }
 
@@ -2127,7 +2129,7 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 	unsigned long new_exts;
 	unsigned long old_exts;
 	struct slabobj_ext *vec;
-	size_t sz = sizeof(struct slabobj_ext) * slab->objects;
+	size_t sz = slab_obj_ext_size(slab) * slab->objects;
 
 	gfp &= ~OBJCGS_CLEAR_MASK;
 	/*
@@ -2270,8 +2272,7 @@ static void alloc_slab_obj_exts_early(struct kmem_cache *s, struct slab *slab)
 
 		get_slab_obj_exts(obj_exts);
 		for_each_object(addr, s, slab_address(slab), slab->objects)
-			memset(kasan_reset_tag(addr) + offset, 0,
-			       sizeof(struct slabobj_ext));
+			memset(kasan_reset_tag(addr) + offset, 0, slab_obj_ext_size(slab));
 		put_slab_obj_exts(obj_exts);
 
 #ifdef CONFIG_MEMCG
@@ -7930,7 +7931,7 @@ static int calculate_sizes(struct kmem_cache_args *args, struct kmem_cache *s)
 	aligned_size = ALIGN(size, s->align);
 #if defined(CONFIG_SLAB_OBJ_EXT) && defined(CONFIG_64BIT)
 	if (slab_args_unmergeable(args, s->flags) &&
-			(aligned_size - size >= sizeof(struct slabobj_ext)))
+			(aligned_size - size >= static_obj_ext_size()))
 		s->flags |= SLAB_OBJ_EXT_IN_OBJ;
 #endif
 	size = aligned_size;

-- 
2.55.0


