Return-Path: <cgroups+bounces-16774-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id G3u3Lc/eJ2rr3gIAu9opvQ
	(envelope-from <cgroups+bounces-16774-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 09 Jun 2026 11:37:19 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E43565E66F
	for <lists+cgroups@lfdr.de>; Tue, 09 Jun 2026 11:37:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="D/rUgR+Q";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16774-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16774-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7034B30F5A24
	for <lists+cgroups@lfdr.de>; Tue,  9 Jun 2026 09:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1EE3F7AAD;
	Tue,  9 Jun 2026 09:18:47 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266913F86EE;
	Tue,  9 Jun 2026 09:18:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780996727; cv=none; b=gDspkXwBvYXifhUHreBNZEhOYRE9T95+ndPUbXoOkH1NkGLvbTgc7A+hPkWeV8nMrLNnNWKVSiya0UojPi7c77Q6X4vI4E1XPtj2tt+X3HXaMoQVeHRY7/MVjCwlJnT1DIOa+6766SxAyAMU6TgyYjQcfNrbJ9MbJQw1BvJea+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780996727; c=relaxed/simple;
	bh=SIeq70qkq4d/rubZyt4vyVxClzvwf5P0IJ6cPIMU8uo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kwq77XTyWioxMjliCemZvZS6N0gjMz6rYKztkIWSrgNpho302lbUYpQlcPdi40GcdVWBprsg8YANpzK5thibkN9kBwp/l0BpB+khB+ELRStiX4a1aU2CeJjdrf8kVpLqjiJZTwMODTERuvqvvch++C/TM6JiVNz2lqzCDnOoy+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/rUgR+Q; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B331F00893;
	Tue,  9 Jun 2026 09:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780996725;
	bh=ESO41yfx+PcQZlyLJsuYTYJG4PqjSzhrfbdejY9wjVM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=D/rUgR+Qfo2Hp9IBWwVLfW6pbvEMQr5eKPyun8iieLmRUWw5YzvSDwFIioOlE0kJk
	 4Lf7aYcvfU3DbpO1FnLGiWMYRyrLJ/MK66S8PLV7Zm8N7gxJMKto9kwHo5vdQVX44g
	 ryoYZkZDjKteFeAxAHeWclPYntpwGa8iaaIxtp5bAG7y5AsSgJGXvTOgv680C06v0Z
	 MMnne6t30X5rSajz4OdH/W9B10wcOQn2HCBXhfIla/wQMTobskOBi/0CaJ9XTwVoOL
	 fVWlBNnYs76OgUCOf1RE9xd51TtfTEGa1+ZWG6FpqbmaG/v9bxbw27NKYWQEXOsQSQ
	 gzJKDmve8vaqg==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Tue, 09 Jun 2026 11:17:58 +0200
Subject: [PATCH RFC 13/15] mm/slab: remove __GFP_NO_OBJ_EXT usage from
 alloc_slab_obj_exts()
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-slab_alloc_flags-v1-13-2bf4a4b9b526@kernel.org>
References: <20260609-slab_alloc_flags-v1-0-2bf4a4b9b526@kernel.org>
In-Reply-To: <20260609-slab_alloc_flags-v1-0-2bf4a4b9b526@kernel.org>
To: Harry Yoo <harry@kernel.org>
Cc: Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
 David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Suren Baghdasaryan <surenb@google.com>, Alexei Starovoitov <ast@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
 Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
 "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:harry@kernel.org,m:hao.li@linux.dev,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:surenb@google.com,m:ast@kernel.org,m:akpm@linux-foundation.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:shakeel.butt@linux.dev,m:glider@google.com,m:elver@google.com,m:dvyukov@google.com,m:kasan-dev@googlegroups.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:vbabka@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[vbabka@kernel.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-16774-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0E43565E66F

__GFP_NO_OBJ_EXT has limited scope within the slab allocator itself and
gfp flags are a scarce resource, unlike slab's alloc_flags.

Introduce SLAB_ALLOC_NO_RECURSE alloc flag that has the same intent as
__GFP_NO_OBJ_EXT but a more generic name, meaning that a kmalloc()
family function should not recurse into another kmalloc*() for the
purposes of allocating auxiliary structures (obj_ext arrays or sheaves).

First, replace the __GFP_NO_OBJ_EXT for allocating obj_ext arrays in
alloc_slab_obj_exts(). Make use of the newly added kmalloc_flags()
function, where we can pass alloc_flags with SLAB_ALLOC_NO_RECURSE
added. This will also pass through SLAB_ALLOC_TRYLOCK so we don't need
to special case kmalloc_nolock() anymore.

Note that until now the kmalloc_nolock() ignored the incoming gfp flags
and hardcoded __GFP_ZERO | __GFP_NO_OBJ_EXT. But it's correct to pass on
the incoming gfp flags (only augmented with __GFP_ZERO), because if
alloc_flags contain SLAB_ALLOC_TRYLOCK, the incoming gfp flags have to
be also compatible with it.

Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 mm/slab.h |  1 +
 mm/slub.c | 13 +++++--------
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index 13517abcad21..e5bd800d831e 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -20,6 +20,7 @@
 #define SLAB_ALLOC_DEFAULT	0x00
 #define SLAB_ALLOC_TRYLOCK	0x01
 #define SLAB_ALLOC_NEW_SLAB	0x02 /* a flag for alloc_slab_obj_exts() */
+#define SLAB_ALLOC_NO_RECURSE	0x04 /* prevent kmalloc() recursion */
 
 static inline bool alloc_flags_allow_spinning(const unsigned int alloc_flags)
 {
diff --git a/mm/slub.c b/mm/slub.c
index 86691eb14002..8a655636dee6 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2167,15 +2167,12 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 
 	gfp &= ~OBJCGS_CLEAR_MASK;
 	/* Prevent recursive extension vector allocation */
-	gfp |= __GFP_NO_OBJ_EXT;
+	alloc_flags |= SLAB_ALLOC_NO_RECURSE;
 
 	sz = obj_exts_alloc_size(s, slab, gfp);
 
-	if (unlikely(!allow_spin))
-		vec = kmalloc_nolock(sz, __GFP_ZERO | __GFP_NO_OBJ_EXT,
-				     slab_nid(slab));
-	else
-		vec = kmalloc_node(sz, gfp | __GFP_ZERO, slab_nid(slab));
+	/* This will use kmalloc_nolock() if alloc_flags say so */
+	vec = kmalloc_flags(sz, gfp | __GFP_ZERO, alloc_flags, slab_nid(slab));
 
 	if (!vec) {
 		/*
@@ -2251,7 +2248,7 @@ static inline void free_slab_obj_exts(struct slab *slab, bool allow_spin)
 	}
 
 	/*
-	 * obj_exts was created with __GFP_NO_OBJ_EXT flag, therefore its
+	 * obj_exts was created with SLAB_ALLOC_NO_RECURSE flag, therefore its
 	 * corresponding extension will be NULL. alloc_tag_sub() will throw a
 	 * warning if slab has extensions but the extension of an object is
 	 * NULL, therefore replace NULL with CODETAG_EMPTY to indicate that
@@ -2374,7 +2371,7 @@ __alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_t flags,
 	if (s->flags & (SLAB_NO_OBJ_EXT | SLAB_NOLEAKTRACE))
 		return;
 
-	if (flags & __GFP_NO_OBJ_EXT)
+	if (alloc_flags & SLAB_ALLOC_NO_RECURSE)
 		return;
 
 	slab = virt_to_slab(object);

-- 
2.54.0


