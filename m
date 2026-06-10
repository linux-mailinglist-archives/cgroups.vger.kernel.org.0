Return-Path: <cgroups+bounces-16826-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rl6ZLtGIKWqFYwMAu9opvQ
	(envelope-from <cgroups+bounces-16826-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 17:54:57 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B37266B120
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 17:54:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=GEd6pmnW;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16826-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16826-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 47E4E314B355
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 15:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193C547A0B7;
	Wed, 10 Jun 2026 15:42:13 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6AD439000;
	Wed, 10 Jun 2026 15:42:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106132; cv=none; b=Tnl3LbuNgUSrsxUsfhW6CP+lglHWAoM70yV0R/a8uJw0lltReRPAyCGjt9s7rqkoofra/oKKdfBaqRuTF2KEyLxb22SQ4hnydXv6nK1cPjg14WE3Y0NE/NOgTv3U50imzBkqlN247VNJp8eDmTPwdchtuvqNMAWt1PBT2yaawu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106132; c=relaxed/simple;
	bh=5pHsEzyr0Vd0Xy2vYaiiJdbY7BpxaUAA6UW1iYNWp1Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wx35GebE8a792MYDH1cE+t4ucj1CQQNMPhVL2TD4TTrmMhR4NpiB85olsrGg+Bdx2t6qcOcBLaPS/9Vx0ueBI6Zq+rnskjKWqhzNv8m9sLaEmt0pWWwa+qs9OMFWmK2byLB3oKVx0/bzJh/kGM7KDeAqSrI/wFF/Ysqnx8etoBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GEd6pmnW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB1361F00898;
	Wed, 10 Jun 2026 15:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781106131;
	bh=LD3P9VI3kjMnaqB1oWeO35sHnckrRuScdE5T1wmgSZs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=GEd6pmnWoUybWjiSrGOgz3MjARHxwYF1EkDs3P05KxdPrviAgZnvZrs3E+6sqnGyV
	 /Xc1+8914FhjyocqKuioJa8fozQXsDwux14jBP19Ecyuqba2Gn0k6k1BAwHWsCnjOp
	 O6ShU/N7791wlISrpDXJKvtNRIMG84z/WSudl9weD0K38WwRwUur2BfDVDpIHF23il
	 u1tmFh2iyChexe2PkTC0Q3knY09QmGQM+D0OofLrzHtoccqpHWYtKPCKS9guSiGc/u
	 AlzpHYv/fqwCHFnUxkz4yseJ1+E9O7lY6wFjATckkfEJFXS0VjQFd6TfrgQ/YAn0y5
	 EetBTmqF7i+jg==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Wed, 10 Jun 2026 17:40:17 +0200
Subject: [PATCH v2 15/16] mm/slab: remove __GFP_NO_OBJ_EXT usage from
 alloc_slab_obj_exts()
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-slab_alloc_flags-v2-15-7190909db118@kernel.org>
References: <20260610-slab_alloc_flags-v2-0-7190909db118@kernel.org>
In-Reply-To: <20260610-slab_alloc_flags-v2-0-7190909db118@kernel.org>
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
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:harry@kernel.org,m:hao.li@linux.dev,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:surenb@google.com,m:ast@kernel.org,m:akpm@linux-foundation.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:shakeel.butt@linux.dev,m:glider@google.com,m:elver@google.com,m:dvyukov@google.com,m:kasan-dev@googlegroups.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:vbabka@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[vbabka@kernel.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-16826-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5B37266B120

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
index 45bfcfb35a9c..509f330654b8 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -21,6 +21,7 @@
 #define SLAB_ALLOC_DEFAULT	0x00 /* no flags */
 #define SLAB_ALLOC_TRYLOCK	0x01 /* a kmalloc_nolock() allocation */
 #define SLAB_ALLOC_NEW_SLAB	0x02 /* a flag for alloc_slab_obj_exts() */
+#define SLAB_ALLOC_NO_RECURSE	0x04 /* prevent kmalloc() recursion */
 
 static inline bool alloc_flags_allow_spinning(const unsigned int alloc_flags)
 {
diff --git a/mm/slub.c b/mm/slub.c
index cbb38bd01e46..7dfbd0251aa2 100644
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


