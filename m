Return-Path: <cgroups+bounces-17838-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PXsaDcNdV2rpKQEAu9opvQ
	(envelope-from <cgroups+bounces-17838-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 12:15:31 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5B675CD58
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 12:15:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CIAt3+pe;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17838-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17838-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 377B2311F098
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 10:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACEE433E7A;
	Wed, 15 Jul 2026 10:11:05 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD2143B6CA;
	Wed, 15 Jul 2026 10:11:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784110265; cv=none; b=hyemUFs4rTOd/S6hG5Ny85btyCsq427gb+N10hIlH11AklW+P2Ge3AvpJQWmDhUfLraqwEOIzRR2VmL7sqn1mtfewZBrKyXyJQN0TlKv+n06BI95U7oCdA8OX2zsmC5KpC3dJAhEgP07o/cXY3yJ//eGeY7EJkauz9xzzU9S/xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784110265; c=relaxed/simple;
	bh=WUP+u5LtCO9Lnm0bpz/QH3WvOGZg0zXtJV5J+ezU95M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fSe3Xb8ybB82ImKMApaOCqmbKfQJu8KDgXEqdCG8oXYH51kh4hj3kfjS2D6pX6D5iCvAhb90OBeCr3X0uiDG0Qa/4/R0frOdhFdTTKEGYyHG5iqChCViInFCT2t9ot+EAT4smm4cJMM/pBjMhEwxssOqSQOtcCfDTwYIgaaRBJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIAt3+pe; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF521F00A3D;
	Wed, 15 Jul 2026 10:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784110263;
	bh=GxN00IWro8eCPaP3MfYs22vlSvWNn2fiqNBuPgHAw1Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CIAt3+peHEAjVLCFNdEtjzKI6Bn831EpZQol9Ve4nYeSqpWpoEXH+e1PZiE69sypP
	 1nJ13de+fohnPBl/BNpnTUPnAvLsaLRYx67o3i3crWhZ+5Yste9ZYlSMVqxJx3jp0t
	 M5ulcTaGX3MFh4DZ4V9bU3v1znNXCpBkEmUcKozrFkKdKb7dSBF/pnOr2fqmADvnYS
	 p1QlnbmjV61UxE8ygT37MjupfQDhVPwJQ1euv8w2itANBlrgDvzIyxNi/L66pVVI0A
	 BoHx+F42FMcDhpYFTkq6U/aCa1NeoRS6Zh0wjgd8TE5xnatzwnEFUmG4r8e9jbvlFu
	 2ijvQhifFuvNw==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Wed, 15 Jul 2026 12:10:45 +0200
Subject: [PATCH RFC 05/12] mm/slab: abstract slabobj_ext.objcg access
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-b4-objext_split-v1-5-9a49c4ccf4c3@kernel.org>
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
	FORGED_RECIPIENTS(0.00)[m:harry@kernel.org,m:surenb@google.com,m:hao.li@linux.dev,m:shakeel.butt@linux.dev,m:glider@google.com,m:elver@google.com,m:akpm@linux-foundation.org,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:vbabka@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[vbabka@kernel.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-17838-lists,cgroups=lfdr.de];
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
X-Rspamd-Queue-Id: 8D5B675CD58

In preparation for changes to the structure, abstract access to the
objcg field with a slab_obj_ext_objcgp() function.
Rename the field to _objcg to make an unexpected direct access a compile
error.

No functional change intended.

Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 mm/kfence/core.c |  2 +-
 mm/memcontrol.c  | 23 +++++++++++++++--------
 mm/slab.h        |  9 ++++++++-
 mm/slub.c        |  2 +-
 4 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 6577bd76954e..717e8baf7e5d 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -1249,7 +1249,7 @@ void __kfence_free(void *addr)
 	struct kfence_metadata *meta = addr_to_metadata((unsigned long)addr);
 
 #ifdef CONFIG_MEMCG
-	KFENCE_WARN_ON(meta->obj_exts.objcg);
+	KFENCE_WARN_ON(*slab_obj_ext_objcgp(&meta->obj_exts));
 #endif
 	/*
 	 * If the objects of the cache are SLAB_TYPESAFE_BY_RCU, defer freeing
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4e427286a88a..6303a2b1a9d0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2865,6 +2865,7 @@ struct mem_cgroup *mem_cgroup_from_obj_slab(struct slab *slab, void *p)
 	 */
 	unsigned long obj_exts;
 	struct slabobj_ext *obj_ext;
+	struct obj_cgroup *objcg;
 
 	obj_exts = slab_obj_exts(slab);
 	if (!obj_exts)
@@ -2872,9 +2873,8 @@ struct mem_cgroup *mem_cgroup_from_obj_slab(struct slab *slab, void *p)
 
 	get_slab_obj_exts(obj_exts);
 	obj_ext = slab_obj_ext(slab->slab_cache, slab, obj_exts, p);
-	if (obj_ext->objcg) {
-		struct obj_cgroup *objcg = obj_ext->objcg;
-
+	objcg = *slab_obj_ext_objcgp(obj_ext);
+	if (objcg) {
 		put_slab_obj_exts(obj_exts);
 		return obj_cgroup_memcg(objcg);
 	}
@@ -3577,6 +3577,7 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 		unsigned long obj_exts;
 		struct slabobj_ext *obj_ext;
 		struct obj_stock_pcp *stock;
+		struct obj_cgroup **objcgp;
 
 		slab = virt_to_slab(p[i]);
 
@@ -3612,10 +3613,15 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 		unlock_stock(stock);
 
 		obj_exts = slab_obj_exts(slab);
+
 		get_slab_obj_exts(obj_exts);
+
 		obj_ext = slab_obj_ext(s, slab, obj_exts, p[i]);
+		objcgp = slab_obj_ext_objcgp(obj_ext);
+
 		obj_cgroup_get(objcg);
-		obj_ext->objcg = objcg;
+		*objcgp = objcg;
+
 		put_slab_obj_exts(obj_exts);
 	}
 
@@ -3628,16 +3634,17 @@ void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
 	size_t obj_size = obj_full_size(s);
 
 	for (int i = 0; i < objects; i++) {
-		struct obj_cgroup *objcg;
+		struct obj_cgroup **objcgp, *objcg;
 		struct slabobj_ext *obj_ext;
 		struct obj_stock_pcp *stock;
 
 		obj_ext = slab_obj_ext(s, slab, obj_exts, p[i]);
-		objcg = obj_ext->objcg;
-		if (!objcg)
+		objcgp = slab_obj_ext_objcgp(obj_ext);
+		if (!*objcgp)
 			continue;
 
-		obj_ext->objcg = NULL;
+		objcg = *objcgp;
+		*objcgp = NULL;
 
 		stock = trylock_stock();
 		__refill_obj_stock(objcg, stock, obj_size, true);
diff --git a/mm/slab.h b/mm/slab.h
index 36d067d6e7c0..789bd292075f 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -555,7 +555,7 @@ static inline bool need_kmalloc_no_objext(void)
  */
 struct slabobj_ext {
 #ifdef CONFIG_MEMCG
-	struct obj_cgroup *objcg;
+	struct obj_cgroup *_objcg;
 #endif
 #ifdef CONFIG_MEM_ALLOC_PROFILING
 	union codetag_ref ref;
@@ -661,6 +661,13 @@ slab_obj_ext(struct kmem_cache *s, struct slab *slab, unsigned long obj_exts,
 	return kasan_reset_tag(obj_ext);
 }
 
+#ifdef CONFIG_MEMCG
+static inline struct obj_cgroup **slab_obj_ext_objcgp(struct slabobj_ext *obj_ext)
+{
+	return &obj_ext->_objcg;
+}
+#endif
+
 int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 			gfp_t gfp, unsigned int alloc_flags);
 
diff --git a/mm/slub.c b/mm/slub.c
index 5e3f53bcd0d3..48e10198a3ce 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2523,7 +2523,7 @@ bool memcg_slab_post_charge(void *p, gfp_t flags)
 	if (obj_exts) {
 		get_slab_obj_exts(obj_exts);
 		obj_ext = slab_obj_ext(s, slab, obj_exts, p);
-		if (unlikely(obj_ext->objcg)) {
+		if (unlikely(*slab_obj_ext_objcgp(obj_ext))) {
 			put_slab_obj_exts(obj_exts);
 			return true;
 		}

-- 
2.55.0


