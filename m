Return-Path: <cgroups+bounces-16961-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id radJFEbpL2qmIwUAu9opvQ
	(envelope-from <cgroups+bounces-16961-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 14:00:06 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBA6685EA8
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 14:00:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=k53SX+hd;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16961-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-16961-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F94A3089CA1
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 11:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E0E3E7BA2;
	Mon, 15 Jun 2026 11:55:25 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7AD3E6DF5;
	Mon, 15 Jun 2026 11:55:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781524525; cv=none; b=FLUnavDCIi/9Xv4SF8mmJqGB/FiBt4F7mvuVDrUi8EcpKlMcCyg8ln98d06cWo43YWfEK4Z6qSlfr+dK9L5CuddMfAAkEXr021FU1400WA+SUKSz5y7vovYmkdaoJqIIRrbsf7UvBZK+iZjsjtgFrZdEX+jSFEGzRgeJ++Gp5eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781524525; c=relaxed/simple;
	bh=uXeY8nc8X0hclhRQwCLZkjKE8uJrSMHEq9WGnlgPWzs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dw5ieacNSpdX5oRnKvb7lUJ1o8PTRRhyHyLYwQJ4dU2L+T2zz6heuJXzxyHQPHiryFLtVIjEUgM61vnDp3+LJVPDbMXFVNAtBZSQy9fmXPt2QcbRzQYDr/uuVCf6Hwy2SrYYZLJV3lKoaq6c844c8SK3sEHHpBBFMocF+EnFhBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k53SX+hd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C20E1F00A3D;
	Mon, 15 Jun 2026 11:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781524523;
	bh=ebzcFj5BKF/W8hw3xShUpyqxyWez0/CEroCTp+cjzdk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=k53SX+hdNKSO4F+2QdGRewU07K+P4JkgXQWXn5mkCdLhn5MRVSmjAPyFQJLlFqOI6
	 6/h9nqvrzu9UK8w2e265TXGtJydhU2AKlSl/t4+8+EBhSXwQQhPQrEly4/idNyC0iz
	 xcFdsz7LdrfKUTktxP053HuNgOsvPlIu3HK+6zoYbVE+MyixgU8PcJnVvrfVZ+aheN
	 og4wmzoVBOhi7f8zA7a2/knEFVH3wHTvDpAoow3PzL3xHQCwhaBsHxuu9j9/QdgcnG
	 BGilDC/BybWyAL6ULwZRohrt8M0BAnLL8cXytktfBRqBxXALiY4m4cmqYgtI3xbMJD
	 DC/x0AHo67yiA==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Mon, 15 Jun 2026 13:54:43 +0200
Subject: [PATCH v3 10/15] mm/slab: allow kmem_cache_alloc_bulk() with any
 gfp flags
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-slab_alloc_flags-v3-10-ce1146d140fb@kernel.org>
References: <20260615-slab_alloc_flags-v3-0-ce1146d140fb@kernel.org>
In-Reply-To: <20260615-slab_alloc_flags-v3-0-ce1146d140fb@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
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
	TAGGED_FROM(0.00)[bounces-16961-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BBBA6685EA8

The last user of gfpflags_allow_spinning() in slab is
alloc_from_pcs_bulk(), which is only called from
kmem_cache_alloc_bulk().

It turns out that gfpflags_allow_spinning() is not necessary, because
kmem_cache_alloc_bulk() is only expected to be called from context that
does allow spinning, so simply replace it with 'true'. This means we can
also drop the gfp parameter from alloc_from_pcs_bulk().

With that, we can remove the "@flags must allow spinning" part of the
kernel doc, as there is no more connection to the gfp flags in the slab
implementation.

Also remove a comment in alloc_slab_obj_exts() because there should be
no more false positives possible due to gfp_allowed_mask during early
boot.

Link: https://patch.msgid.link/20260610-slab_alloc_flags-v2-11-7190909db118@kernel.org
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 mm/slub.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 562495b80d74..81938774098b 100644
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
@@ -4830,8 +4824,7 @@ void *alloc_from_pcs(struct kmem_cache *s, gfp_t gfp, unsigned int alloc_flags,
 }
 
 static __fastpath_inline
-unsigned int alloc_from_pcs_bulk(struct kmem_cache *s, gfp_t gfp, size_t size,
-				 void **p)
+unsigned int alloc_from_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
 {
 	struct slub_percpu_sheaves *pcs;
 	struct slab_sheaf *main;
@@ -4866,7 +4859,7 @@ unsigned int alloc_from_pcs_bulk(struct kmem_cache *s, gfp_t gfp, size_t size,
 		}
 
 		full = barn_replace_empty_sheaf(barn, pcs->main,
-						gfpflags_allow_spinning(gfp));
+						/* allow_spin = */ true);
 
 		if (full) {
 			stat(s, BARN_GET);
@@ -7331,8 +7324,7 @@ static bool __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags,
  * Allocate @size objects from @s and places them into @p.  @size must be larger
  * than 0.
  *
- * Interrupts must be enabled when calling this function and @flags must allow
- * spinning.
+ * Interrupts must be enabled when calling this function.
  *
  * Unlike alloc_pages_bulk(), this function does not check for already allocated
  * objects in @p, and thus the caller does not need to zero it.
@@ -7370,7 +7362,7 @@ bool kmem_cache_alloc_bulk_noprof(struct kmem_cache *s, gfp_t flags,
 		size--;
 	}
 
-	i = alloc_from_pcs_bulk(s, flags, size, p);
+	i = alloc_from_pcs_bulk(s, size, p);
 	if (i < size) {
 		/*
 		 * If we ran out of memory, don't bother with freeing back to

-- 
2.54.0


