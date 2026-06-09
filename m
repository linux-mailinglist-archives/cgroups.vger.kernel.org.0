Return-Path: <cgroups+bounces-16771-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vYX5Kk7cJ2o63gIAu9opvQ
	(envelope-from <cgroups+bounces-16771-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 09 Jun 2026 11:26:38 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BF765E510
	for <lists+cgroups@lfdr.de>; Tue, 09 Jun 2026 11:26:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VHTWhGwP;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16771-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16771-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5AE9307F2AF
	for <lists+cgroups@lfdr.de>; Tue,  9 Jun 2026 09:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BD23F58DF;
	Tue,  9 Jun 2026 09:18:35 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289FD3E3C69;
	Tue,  9 Jun 2026 09:18:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780996715; cv=none; b=fxVxOGjSLBDjrPNOR55nss9FigYitXg9x39RZ2ImgfUBjA2vPjgwYQ+xutAB+7k5hOo5/r8GZMu7X3I2UEKF+q/o+CmnP6sporTrmstbVF8CC8pXCAh5kcJhsaW6jXaQ/gwCs3FaZMMCOcw0Xe0Zd8neOHH/FocV/UkrXo75vgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780996715; c=relaxed/simple;
	bh=DpOTK+stbfCA5bUIRxrL3e0vv86Jn7pJgPecNGWic6Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mR5YnJCIx1s6qaqzMR/cRDtEeJURiKMKhbOkWJrA3Jcrg5BDv71waaP3D9BnBcQRNT73BCZEqGLiMTpK0AvzCfJHt6cJOczHxJwEqiBsIkXr9x57fpvEA/o3oWyoi/UCt+LxNCtzAgX2D0leq9+CAAArCrI8JnZjVRNL9aTEzQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHTWhGwP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A9931F00898;
	Tue,  9 Jun 2026 09:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780996714;
	bh=ZczlrzStgvNUrq+xcJH6QzjOF3uagfFkpBMhQ14riTI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=VHTWhGwP6KzULqoJFDnEfw8r+gua+LReQ5BjDbuxlv1tLnr+2OcROBjdWutK33N25
	 hQ8J2kPvJV/UHss0XJnoNlQ+dMSoyJJoyHJjotpf2X3//5yRTg9xa1Y9Tm1ur3JvAY
	 qrPTq8wPA/Va9C0fmetv8KXzvpRRHPfnRhdWZwckDMdkHiOra3gslWJgok5ew3uZK7
	 Tez3U/cMR3ZyIDTwVOEu8oFMlk5ouiz8unoGf7nMNRl020Wo91vobGPOKAYAYHpoka
	 gkrN1iMMk4iKtv4UhsWLbmbUDiSzlvPfP9qIQWoYbSVTFhtE7CyewqCphH+efZlkY7
	 ePbPhuncpaujQ==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Tue, 09 Jun 2026 11:17:55 +0200
Subject: [PATCH RFC 10/15] mm/slab: allow kmem_cache_alloc_bulk() with any
 gfp flags
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-slab_alloc_flags-v1-10-2bf4a4b9b526@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-16771-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 06BF765E510

The last user of gfpflags_allow_spinning() in slab is
alloc_from_pcs_bulk(), which is only called from
kmem_cache_alloc_bulk().

It turns out that gfpflags_allow_spinning() is not necessary, because
kmem_cache_alloc_bulk() is only expected to be called from context that
does allow spinning, so simply replace it with 'true'.

With that, we can remove the "@flags must allow spinning" part of the
kernel doc, as there is no more connection to the gfp flags in the slab
implementation.

Also remove a comment in alloc_slab_obj_exts() because there should be
no more false positives possible due to gfp_allowed_mask during early
boot.

Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 mm/slub.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index b511d768e9b6..dee69e0b7780 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2171,12 +2171,6 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 
 	sz = obj_exts_alloc_size(s, slab, gfp);
 
-	/*
-	 * Note that allow_spin may be false during early boot and its
-	 * restricted GFP_BOOT_MASK. Due to kmalloc_nolock() only supporting
-	 * architectures with cmpxchg16b, early obj_exts will be missing for
-	 * very early allocations on those.
-	 */
 	if (unlikely(!allow_spin))
 		vec = kmalloc_nolock(sz, __GFP_ZERO | __GFP_NO_OBJ_EXT,
 				     slab_nid(slab));
@@ -4851,7 +4845,7 @@ unsigned int alloc_from_pcs_bulk(struct kmem_cache *s, gfp_t gfp, size_t size,
 		}
 
 		full = barn_replace_empty_sheaf(barn, pcs->main,
-						gfpflags_allow_spinning(gfp));
+						/* allow_spin = */ true);
 
 		if (full) {
 			stat(s, BARN_GET);
@@ -7317,8 +7311,7 @@ static bool __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags,
  * Allocate @size objects from @s and places them into @p.  @size must be larger
  * than 0.
  *
- * Interrupts must be enabled when calling this function and @flags must allow
- * spinning.
+ * Interrupts must be enabled when calling this function.
  *
  * Unlike alloc_pages_bulk(), this function does not check for already allocated
  * objects in @p, and thus the caller does not need to zero it.

-- 
2.54.0


