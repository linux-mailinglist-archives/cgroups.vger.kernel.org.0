Return-Path: <cgroups+bounces-17840-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KGgtHUldV2rDKQEAu9opvQ
	(envelope-from <cgroups+bounces-17840-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 12:13:29 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5EB75CCF8
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 12:13:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=N7zy9xEx;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17840-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17840-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E3713094259
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 10:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A485343E48E;
	Wed, 15 Jul 2026 10:11:11 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AA8433E7A;
	Wed, 15 Jul 2026 10:11:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784110271; cv=none; b=En+ikWj3B+VUeYScwtqCeDy6sKzBYMeoQeJWDU2q2tF3hTsvbVbVJ8+h3RLkzM6ERvzhgBocC/VgWuoQUJUNqbmHn+55QM85TwRdcPadgDWhGpnD8GcRDyjwgY7qN6IfQbjpR/Sm2Z0A7ugrlwbURwAJ90OtM08pRw09czDRiag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784110271; c=relaxed/simple;
	bh=exr6yeChGKovDu3PsxGt445/8UY+SaFhSEkS2xjD3mA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CyxsSBFo71vbLl4YeHvbKCywFMErIKPE1KcmWRVl45zv8FZGHwGqW7tDnBIKWqFgM8GH8EksdcruI84Um+v3sHR3YHRiL0/t04WO3YYl3F64e3zbkAj3QSSaRydAVEhK8BlD2K73bbcWC9vfhA5uZ+I4/avX3xKKS0l3ZZbxdLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7zy9xEx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0D501F000E9;
	Wed, 15 Jul 2026 10:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784110269;
	bh=fqtJ5hqMpkrlyY02tT9s783SqiD4ZiPky1xiCi8taEI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=N7zy9xExGIdDNEynI/MArerPHqN4oLJg1dowzWYxkuWiOTXgemebHAxnlJvKMq2zD
	 5e0XozLwkb57FUanjtri7zlxMmtL1cY6c+ax9KMc48AK/FaqLcU4Sg2oCP2dBu7EW1
	 ww5+owBx3CnkDhJvZ7mOBB7UZQmXQwvIJ1RF0XWh/Acum2GzpC5itqKLp93al83d3U
	 90v5NyecbSqaqQWTHXBzjXdHHx44iuV2p/Ehx/Mk58xFVH34Fvxw9TZFxfkCLIct1Z
	 HqAFRxa93QkcSvKc0D1GNJCnpKmiIILOIO4KIpvCM6KsTu8ss6LNr88hcXpqKosB/2
	 WOaQo4s93L7pQ==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Wed, 15 Jul 2026 12:10:47 +0200
Subject: [PATCH RFC 07/12] mm/slab: replace slab.stride with
 obj_exts_in_object
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-b4-objext_split-v1-7-9a49c4ccf4c3@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:harry@kernel.org,m:surenb@google.com,m:hao.li@linux.dev,m:shakeel.butt@linux.dev,m:glider@google.com,m:elver@google.com,m:akpm@linux-foundation.org,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:vbabka@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[vbabka@kernel.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-17840-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DC5EB75CCF8

The stride field is used to convert object index to an slabobj_ext so
both compact arrays (kmalloc() or in-slab-leftover) and spread
in-object-padding obj_ext layouts are supported.

In practice thus the stride is always sizeof(slabobj_ext) or s->size.

This simplifies the calculations, but with the upcoming slabobj_ext
handling changes, it will be easier to stop storing the stride and
instead just have a flag whether obj_ext is in the object padding.
obj_exts_in_object() can then rely on this flag and slab_obj_ext()
can use that to determine the stride.

No functional change intended. Performance impact TBD, hopefully
in the noise.

Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 mm/slab.h | 43 ++++++++++++++++++++++++-------------------
 mm/slub.c | 42 ++++++++++++++++--------------------------
 2 files changed, 40 insertions(+), 45 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index e3f8e42070f1..3ad9777ad600 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -81,10 +81,10 @@ struct freelist_counters {
 #ifdef CONFIG_64BIT
 					/*
 					 * Some optimizations use free bits in 'counters' field
-					 * to save memory. In case ->stride field is not available,
+					 * to save memory. If these free bits are not available,
 					 * such optimizations are disabled.
 					 */
-					unsigned int stride;
+					unsigned obj_exts_in_object:1;
 #endif
 				};
 			};
@@ -617,22 +617,20 @@ static inline void put_slab_obj_exts(unsigned long obj_exts)
 }
 
 #ifdef CONFIG_64BIT
-static inline void slab_set_stride(struct slab *slab, unsigned int stride)
+static inline bool obj_exts_in_object(struct slab *slab)
 {
-	slab->stride = stride;
-}
-static inline unsigned int slab_get_stride(struct slab *slab)
-{
-	return slab->stride;
+	/*
+	 * Note we cannot rely on the SLAB_OBJ_EXT_IN_OBJ flag here and need to
+	 * check the per-slab bit. A cache can have SLAB_OBJ_EXT_IN_OBJ set, but
+	 * allocations within_slab_leftover are preferred. And those may be
+	 * possible or not depending on the particular slab's size.
+	 */
+	return slab->obj_exts_in_object;
 }
 #else
-static inline void slab_set_stride(struct slab *slab, unsigned int stride)
+static inline bool obj_exts_in_object(struct slab *slab)
 {
-	VM_WARN_ON_ONCE(stride != sizeof(struct slabobj_ext));
-}
-static inline unsigned int slab_get_stride(struct slab *slab)
-{
-	return sizeof(struct slabobj_ext);
+	return false;
 }
 #endif
 
@@ -656,8 +654,14 @@ slab_obj_ext(struct kmem_cache *s, struct slab *slab, unsigned long obj_exts,
 	VM_WARN_ON_ONCE(obj_exts != slab_obj_exts(slab));
 
 	index = obj_to_index(s, slab, obj);
-	obj_ext = (struct slabobj_ext *)(obj_exts +
-					 slab_get_stride(slab) * index);
+
+	if (!obj_exts_in_object(slab)) {
+		obj_ext = ((struct slabobj_ext *)obj_exts) + index;
+	} else {
+		unsigned int stride = s->size;
+		obj_ext = (struct slabobj_ext *)(obj_exts + index * stride);
+	}
+
 	return kasan_reset_tag(obj_ext);
 }
 
@@ -693,9 +697,10 @@ slab_obj_ext(struct kmem_cache *s, struct slab *slab, unsigned long obj_exts,
 	return NULL;
 }
 
-static inline void slab_set_stride(struct slab *slab, unsigned int stride) { }
-static inline unsigned int slab_get_stride(struct slab *slab) { return 0; }
-
+static inline bool obj_exts_in_object(struct slab *slab)
+{
+	return false;
+}
 
 #endif /* CONFIG_SLAB_OBJ_EXT */
 
diff --git a/mm/slub.c b/mm/slub.c
index 2bfcabc4c51a..98a14e5842a2 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -870,18 +870,6 @@ static inline bool obj_exts_in_slab(struct kmem_cache *s, struct slab *slab)
 #endif
 
 #if defined(CONFIG_SLAB_OBJ_EXT) && defined(CONFIG_64BIT)
-static bool obj_exts_in_object(struct kmem_cache *s, struct slab *slab)
-{
-	/*
-	 * Note we cannot rely on the SLAB_OBJ_EXT_IN_OBJ flag here and need to
-	 * check the stride. A cache can have SLAB_OBJ_EXT_IN_OBJ set, but
-	 * allocations within_slab_leftover are preferred. And those may be
-	 * possible or not depending on the particular slab's size.
-	 */
-	return obj_exts_in_slab(s, slab) &&
-	       (slab_get_stride(slab) == s->size);
-}
-
 static unsigned int obj_exts_offset_in_object(struct kmem_cache *s)
 {
 	unsigned int offset = get_info_end(s);
@@ -896,16 +884,20 @@ static unsigned int obj_exts_offset_in_object(struct kmem_cache *s)
 
 	return offset;
 }
-#else
-static inline bool obj_exts_in_object(struct kmem_cache *s, struct slab *slab)
+
+static inline void slab_set_obj_exts_in_object(struct slab *slab)
 {
-	return false;
+	slab->obj_exts_in_object = 1;
 }
-
+#else
 static inline unsigned int obj_exts_offset_in_object(struct kmem_cache *s)
 {
 	return 0;
 }
+
+static inline void slab_set_obj_exts_in_object(struct slab *slab)
+{
+}
 #endif
 
 #ifdef CONFIG_SLUB_DEBUG
@@ -1206,7 +1198,7 @@ static void print_trailer(struct kmem_cache *s, struct slab *slab, u8 *p)
 
 	off += kasan_metadata_size(s, false);
 
-	if (obj_exts_in_object(s, slab))
+	if (obj_exts_in_object(slab))
 		off += sizeof(struct slabobj_ext);
 
 	if (off != size_from_object(s))
@@ -1411,7 +1403,7 @@ static int check_pad_bytes(struct kmem_cache *s, struct slab *slab, u8 *p)
 
 	off += kasan_metadata_size(s, false);
 
-	if (obj_exts_in_object(s, slab))
+	if (obj_exts_in_object(slab))
 		off += sizeof(struct slabobj_ext);
 
 	if (size_from_object(s) == off)
@@ -1439,7 +1431,7 @@ slab_pad_check(struct kmem_cache *s, struct slab *slab)
 	length = slab_size(slab);
 	end = start + length;
 
-	if (obj_exts_in_slab(s, slab) && !obj_exts_in_object(s, slab)) {
+	if (obj_exts_in_slab(s, slab) && !obj_exts_in_object(slab)) {
 		remainder = length;
 		remainder -= obj_exts_offset_in_slab(s, slab);
 		remainder -= obj_exts_size_in_slab(slab);
@@ -2253,9 +2245,6 @@ static void alloc_slab_obj_exts_early(struct kmem_cache *s, struct slab *slab)
 	void *addr;
 	unsigned long obj_exts;
 
-	/* Initialize stride early to avoid memory ordering issues */
-	slab_set_stride(slab, sizeof(struct slabobj_ext));
-
 	if (!need_slab_obj_exts(s))
 		return;
 
@@ -2289,7 +2278,7 @@ static void alloc_slab_obj_exts_early(struct kmem_cache *s, struct slab *slab)
 		obj_exts |= MEMCG_DATA_OBJEXTS;
 #endif
 		slab->obj_exts = obj_exts;
-		slab_set_stride(slab, s->size);
+		slab_set_obj_exts_in_object(slab);
 	}
 }
 
@@ -3402,9 +3391,10 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags,
 		stat(s, ORDER_FALLBACK);
 	}
 
+	/* Initializes frozen, inuse, and any extra 64bit-only flags */
+	slab->counters = 0;
+
 	slab->objects = oo_objects(oo);
-	slab->inuse = 0;
-	slab->frozen = 0;
 
 	slab->slab_cache = s;
 
@@ -6537,7 +6527,7 @@ static inline size_t slab_ksize(struct slab *slab)
 	 */
 	if (s->flags & (SLAB_TYPESAFE_BY_RCU | SLAB_STORE_USER))
 		return s->inuse;
-	else if (obj_exts_in_object(s, slab))
+	else if (obj_exts_in_object(slab))
 		return s->inuse;
 	/*
 	 * Else we can use all the padding etc for the allocation

-- 
2.55.0


