Return-Path: <cgroups+bounces-17844-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WrGgNUteV2ofKgEAu9opvQ
	(envelope-from <cgroups+bounces-17844-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 12:17:47 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE7475CDDE
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 12:17:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="Olo3/0Ii";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17844-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17844-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A93863034571
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 10:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A3843CEC3;
	Wed, 15 Jul 2026 10:11:23 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E05143FD14;
	Wed, 15 Jul 2026 10:11:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784110283; cv=none; b=ga7zcFDqEvvkljPNB8Bt7FNtuwrKZ4SA+3q3jqWpk1Qba+Vz2s7UHHNMQV6Y8yzRkC01lQIWJcOuvJHmVIeS1Sk+wpDc8klw80HQ70JBxAKDMv1yP06JCCRYgr7kBz8U5yMg/gimX0Va0u1taflWN6Fi1+S/eoXRju9tL1TxSYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784110283; c=relaxed/simple;
	bh=yL9qj2aMDxVh01ChtbbElt5w9xb9vxWtupcsfHusP5w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fndNd49wHV8IVCdyNKl7/XPXNWCrFGKb9G64D7rmrFqqdYKd5HzWicifdmrLzzDt5IEa8mManKAWJ0mYPMPgvdSfDT35Ja3IEfKEI2HIm0G1Lr2akJDY8+jYd+fj0xOkQx4qlmoiRgosPwmyJZNs7y4E5SvQDrrUQ++D6JRH9y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Olo3/0Ii; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 621711F000E9;
	Wed, 15 Jul 2026 10:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784110282;
	bh=PE3KTV7cHysrre7SDOgoC57Bp7TB5EzPerhfduGTM0M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Olo3/0Iiz7E7xxUfliQ4rw0McZ1OC9LZxrxLmUFBSHXcdcW024RB9Y/+dShJ2mOmW
	 ycqXeuBNBGXZuMdlW0pBkoYC/nWOQbSDL8zBd98HxqkPkQ1aWh6Uvmgs5MpYcdKOD4
	 q8ZIxTEO9hMiAlBFovcPtPQ81SIENvs8/3F2dWA9f2iXUVb4dlETypYdQdminnGU9/
	 yrS+X9HayZM2kB/168UM9IPFLCyp0YPUIaG93Lva575xJ2t4Di9IVSGcI5IxuLJL7U
	 MXcNKENijEuPjYGbkZ75UfPJtoj6+UXzrXa1Rex9HmsT8jqyFeDNXlQ5v3UJVa+OqA
	 2EcYBfZSVsxsg==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Wed, 15 Jul 2026 12:10:51 +0200
Subject: [PATCH RFC 11/12] mm/slab: add slab_needs_objcg() helper
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-b4-objext_split-v1-11-9a49c4ccf4c3@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-17844-lists,cgroups=lfdr.de];
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
X-Rspamd-Queue-Id: 3DE7475CDDE

Slabs of some caches never need the objcg part of struct slabobj_ext.
Introduce a helper to query this for a slab.

Currently only is_kmalloc_normal() caches are considered as not needing
objcg's. We could also consider all kmem caches without SLAB_ACCOUNT,
however some might be used with and without __GFP_ACCOUNT concurrently
and we currently don't restrict that. This can be improved later.

To make the evaluation of slab_needs_objcg() faster in the allocation
and free fast paths, add a obj_exts_needs_objcg flag into slab itself.
This optimization is only available on 64bit architectures where free
bits are available for the flag.

Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 mm/kfence/core.c |  3 +++
 mm/slab.h        | 31 +++++++++++++++++++++++++++++--
 mm/slub.c        |  4 ++++
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 717e8baf7e5d..afeaf80484ad 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -640,6 +640,9 @@ static unsigned long kfence_init_pool(void)
 		struct slab *slab = page_slab(page);
 		slab->obj_exts = (unsigned long)&kfence_metadata_init[i / 2 - 1].obj_exts |
 				 MEMCG_DATA_OBJEXTS;
+#ifdef CONFIG_64BIT
+		slab->obj_exts_needs_objcg = 1;
+#endif
 #endif
 	}
 
diff --git a/mm/slab.h b/mm/slab.h
index a50347c9dbe3..948d075cdbef 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -81,10 +81,11 @@ struct freelist_counters {
 #ifdef CONFIG_64BIT
 					/*
 					 * Some optimizations use free bits in 'counters' field
-					 * to save memory. If these free bits are not available,
-					 * such optimizations are disabled.
+					 * to save memory or CPU. If these free bits are not
+					 * available, such optimizations are disabled.
 					 */
 					unsigned obj_exts_in_object:1;
+					unsigned obj_exts_needs_objcg:1;
 #endif
 				};
 			};
@@ -580,6 +581,32 @@ static inline bool slab_obj_ext_has_codetag(void)
 }
 #endif
 
+#ifdef CONFIG_MEMCG
+static inline bool cache_needs_objcg(struct kmem_cache *cache)
+{
+	return !is_kmalloc_normal(cache);
+}
+
+static inline bool slab_needs_objcg(struct slab *slab)
+{
+#ifdef CONFIG_64BIT
+	return slab->obj_exts_needs_objcg;
+#else
+	return cache_needs_objcg(slab->slab_cache);
+#endif
+}
+#else
+static inline bool cache_needs_objcg(struct kmem_cache *cache)
+{
+	return false;
+}
+
+static inline bool slab_needs_objcg(struct slab *slab)
+{
+	return false;
+}
+#endif
+
 static inline size_t static_obj_ext_size(void)
 {
 	size_t sz = 0;
diff --git a/mm/slub.c b/mm/slub.c
index 4200e7105b30..771d73abacb6 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3426,6 +3426,10 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags,
 
 	slab->objects = oo_objects(oo);
 
+#ifdef CONFIG_64BIT
+	if (cache_needs_objcg(s))
+		slab->obj_exts_needs_objcg = 1;
+#endif
 	slab->slab_cache = s;
 
 	kasan_poison_slab(slab);

-- 
2.55.0


