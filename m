Return-Path: <cgroups+bounces-17839-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ItTOOihdV2q6KQEAu9opvQ
	(envelope-from <cgroups+bounces-17839-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 12:12:56 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6C075CCDC
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 12:12:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=B708yIID;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17839-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17839-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0ED3B307E69B
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 10:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4DD43DA27;
	Wed, 15 Jul 2026 10:11:08 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2EC43DA5D;
	Wed, 15 Jul 2026 10:11:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784110268; cv=none; b=SmVXp8g0ACZNgCr3owzI9HnNCXu64+FpOehJqxvZjDB9hK0iC2ryrktN/kij3EV/jfufd4r7w9YCBsB9QiaogvN7U9031mBVw7deiCpjYWJXGSja7MajCSEYFBqk8NT1mz1jlYIDYL3DXSVDoI+XmNFlR+jptx/roxD4T5cwcP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784110268; c=relaxed/simple;
	bh=GfyLpES3wI8YbZIuBZalmdfcOlG7HdO2QJaXY7Zp+TI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iRVljvoMgHgJdHgRUODIkFeyxcIRB/LMfX8CQ5WqItpDxfAkDyxW9t/qqPgHb1s6slSIXIc4khMDovtcmsKqp6OyApdQTAGlFjdqcr/kIBbXYTjY2Rrl26S2lLH8rMaruQ/Cj6N5hNt6S4fln6Bc9d+dMw6JKQhFj8QHcAMKYJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B708yIID; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF701F00A3A;
	Wed, 15 Jul 2026 10:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784110266;
	bh=HzIaBZel8a8JeHhvZs2k8s/0l5364bN/PN4wTwimX2g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=B708yIIDl8WT85J9RFbuGnwpgMU6yVOaj/crA1PR95SaKa6nytSokx5tzo+FKV7D6
	 XpT3SBumfJ9I1/tg/XmpFMZn+Z1V4IFMHCGLtcNePxD0z9V3jpeTpWbO0k5UTTDmqm
	 v97YwPDi+4USWOZlpvWv+5MbygBhjQ9RGRB8CYzPVLt8mo026uLWxwvMu6pW8PG7rr
	 zu7b9AGPwUGbSL3B4lmBAIaE7J/o2tn/0GgwIaufhE8fxpD8I0bqrvRTAlbp088T/u
	 HeoI8Q7Lj2IQtxqJBrzTY63AFWMgJL3wiDwxxHa+BIRzP/68gy/zdnZGWj0MTSbR+w
	 xBI2D/ccN0R5g==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Wed, 15 Jul 2026 12:10:46 +0200
Subject: [PATCH RFC 06/12] mm/slab: abstract slabobj_ext.ref access
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-b4-objext_split-v1-6-9a49c4ccf4c3@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
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
	TAGGED_FROM(0.00)[bounces-17839-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7B6C075CCDC

In preparation for changes to the structure, abstract access to the ref
field with a slab_obj_ext_codetag_ref() function. Rename the field to
_ctref to make an unexpected direct access a compile error.

No functional change intended.

Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 mm/slab.h | 10 +++++++++-
 mm/slub.c | 42 ++++++++++++++++++++++++++++--------------
 2 files changed, 37 insertions(+), 15 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index 789bd292075f..e3f8e42070f1 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -558,7 +558,7 @@ struct slabobj_ext {
 	struct obj_cgroup *_objcg;
 #endif
 #ifdef CONFIG_MEM_ALLOC_PROFILING
-	union codetag_ref ref;
+	union codetag_ref _ctref;
 #endif
 } __aligned(8);
 
@@ -668,6 +668,14 @@ static inline struct obj_cgroup **slab_obj_ext_objcgp(struct slabobj_ext *obj_ex
 }
 #endif
 
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+static inline union codetag_ref *
+slab_obj_ext_codetag_ref(struct slab *slab, struct slabobj_ext *obj_ext)
+{
+	return &obj_ext->_ctref;
+}
+#endif
+
 int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 			gfp_t gfp, unsigned int alloc_flags);
 
diff --git a/mm/slub.c b/mm/slub.c
index 48e10198a3ce..2bfcabc4c51a 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2071,18 +2071,20 @@ static inline void mark_obj_codetag_empty(const void *obj)
 	slab_exts = slab_obj_exts(obj_slab);
 	if (slab_exts) {
 		struct slabobj_ext *ext;
+		union codetag_ref *ref;
 
 		get_slab_obj_exts(slab_exts);
 		ext = slab_obj_ext(obj_slab->slab_cache, obj_slab, slab_exts, obj);
+		ref = slab_obj_ext_codetag_ref(obj_slab, ext);
 
-		if (unlikely(is_codetag_empty(&ext->ref))) {
+		if (unlikely(is_codetag_empty(ref))) {
 			put_slab_obj_exts(slab_exts);
 			return;
 		}
 
 		/* codetag should be NULL here */
-		WARN_ON(ext->ref.ct);
-		set_codetag_empty(&ext->ref);
+		WARN_ON(ref->ct);
+		set_codetag_empty(ref);
 		put_slab_obj_exts(slab_exts);
 	}
 }
@@ -2092,19 +2094,22 @@ static inline bool mark_failed_objexts_alloc(struct slab *slab)
 	return cmpxchg(&slab->obj_exts, 0, OBJEXTS_ALLOC_FAIL) == 0;
 }
 
-static inline void handle_failed_objexts_alloc(unsigned long obj_exts,
-			struct slabobj_ext *vec, unsigned int objects)
+static inline void handle_failed_objexts_alloc(struct slab *slab,
+		unsigned long obj_exts, struct slabobj_ext *vec)
 {
 	/*
 	 * If vector previously failed to allocate then we have live
 	 * objects with no tag reference. Mark all references in this
 	 * vector as empty to avoid warnings later on.
 	 */
-	if (obj_exts == OBJEXTS_ALLOC_FAIL) {
-		unsigned int i;
+	if (obj_exts != OBJEXTS_ALLOC_FAIL)
+		return;
+
+	for (unsigned int i = 0; i < slab->objects; i++) {
+		union codetag_ref *ref = slab_obj_ext_codetag_ref(slab, vec);
 
-		for (i = 0; i < objects; i++)
-			set_codetag_empty(&vec[i].ref);
+		set_codetag_empty(ref);
+		vec++;
 	}
 }
 
@@ -2112,8 +2117,8 @@ static inline void handle_failed_objexts_alloc(unsigned long obj_exts,
 
 static inline void mark_obj_codetag_empty(const void *obj) {}
 static inline bool mark_failed_objexts_alloc(struct slab *slab) { return false; }
-static inline void handle_failed_objexts_alloc(unsigned long obj_exts,
-			struct slabobj_ext *vec, unsigned int objects) {}
+static inline void handle_failed_objexts_alloc(struct slab *slab,
+		unsigned long obj_exts, struct slabobj_ext *vec) {}
 
 #endif /* CONFIG_MEM_ALLOC_PROFILING_DEBUG */
 
@@ -2181,7 +2186,7 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 #endif
 retry:
 	old_exts = READ_ONCE(slab->obj_exts);
-	handle_failed_objexts_alloc(old_exts, vec, slab->objects);
+	handle_failed_objexts_alloc(slab, old_exts, vec);
 
 	if (new_slab) {
 		/*
@@ -2361,9 +2366,15 @@ __alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_t flags,
 	 * check should be added before alloc_tag_add().
 	 */
 	if (obj_exts) {
+		union codetag_ref *ref;
+
 		get_slab_obj_exts(obj_exts);
+
 		obj_ext = slab_obj_ext(s, slab, obj_exts, object);
-		alloc_tag_add(&obj_ext->ref, current->alloc_tag, s->size);
+		ref = slab_obj_ext_codetag_ref(slab, obj_ext);
+
+		alloc_tag_add(ref, current->alloc_tag, s->size);
+
 		put_slab_obj_exts(obj_exts);
 	} else {
 		alloc_tag_set_inaccurate(current->alloc_tag);
@@ -2395,10 +2406,13 @@ __alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p
 
 	get_slab_obj_exts(obj_exts);
 	for (int i = 0; i < objects; i++) {
+		struct slabobj_ext *ext;
+
 		if (is_kfence_address(p[i]))
 			continue;
 
-		alloc_tag_sub(&slab_obj_ext(s, slab, obj_exts, p[i])->ref, s->size);
+		ext = slab_obj_ext(s, slab, obj_exts, p[i]);
+		alloc_tag_sub(slab_obj_ext_codetag_ref(slab, ext), s->size);
 	}
 	put_slab_obj_exts(obj_exts);
 }

-- 
2.55.0


