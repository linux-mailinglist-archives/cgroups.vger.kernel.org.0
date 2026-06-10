Return-Path: <cgroups+bounces-16822-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fG8bD/6KKWpUZAMAu9opvQ
	(envelope-from <cgroups+bounces-16822-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 18:04:14 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E60D866B246
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 18:04:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=jG++jPB3;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16822-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16822-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 043AC3097BE1
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 15:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F9D478864;
	Wed, 10 Jun 2026 15:41:42 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B937C427A14;
	Wed, 10 Jun 2026 15:41:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106102; cv=none; b=VeMSBaBjY6lFqdAK+rplDfJ3QSBONZJWONHLDYh93Vc6BDOMjbpY5flJ4T4aW5hRAxWy0xnjzznpKKFzR9iQLVy3wjf4SmkDM++L352wBwPsOjf0sOVTycdxizCY1GlC1CDRKHD0nNvE27ANkR36ItYnyntE/pHHxjv9aGr+hdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106102; c=relaxed/simple;
	bh=t5/NAGAIdygAciNzv+ca67lRXpVkp3wTRx5K2OM2XII=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J8EwN2w+rTJXAtT3zaCM2fp0P/2xkjY5LfEyNK2o7xK0fesg6uxFhs/qmqdmyXhnmsMPeV+bc0K9k3BZ4KYosXjjBqhfwbl8eAviYWFf2vVFxZ7efklGrEqdjSVfWr8d3l/cAjuqPxB6imMGmTxtTeord0hDd+W+ZkHDg7R0zoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jG++jPB3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F39C61F00898;
	Wed, 10 Jun 2026 15:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781106100;
	bh=dSB8ooC+6hgvQ0d6cKYfHgJDcXeMR4283Uzll9HAga4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jG++jPB3VG5I/EtNtf62Ed1ln6osVnnbU74LV3nqK+1LFuUZdvgJkQWVzMpx2G0fI
	 zqBZAW6VeMSMQ4SJQ7zsDtD+/gXWx2wA9oLWbOXRivXk4kuy3rLbbssxonPu/bixaa
	 BbpMzgfNK5YKTbkxlA531Z0m5IlAWev7ycTLGp1qthHpEhRTIG2e+GVy5pN1RE46Hu
	 FyugsmjTgtYeZo5BOVRn92SXFEPLPKyQuIO2Uwsi05pkcC9eb7niNP8AGMFFNue4bM
	 SMs7ocwMo48fAOM4EN0ynLFA7E/bwMslb5/DnulvwOEtq6ZD5bXC7SpvKClLHcfUoK
	 fuh8YJhSRzmJg==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Wed, 10 Jun 2026 17:40:13 +0200
Subject: [PATCH v2 11/16] mm/slab: allow kmem_cache_alloc_bulk() with any
 gfp flags
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-slab_alloc_flags-v2-11-7190909db118@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:harry@kernel.org,m:hao.li@linux.dev,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:surenb@google.com,m:ast@kernel.org,m:akpm@linux-foundation.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:shakeel.butt@linux.dev,m:glider@google.com,m:elver@google.com,m:dvyukov@google.com,m:kasan-dev@googlegroups.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:vbabka@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[vbabka@kernel.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-16822-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E60D866B246

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
index 0b9974bfcb24..ef457e07db83 100644
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
@@ -4867,7 +4861,7 @@ unsigned int alloc_from_pcs_bulk(struct kmem_cache *s, gfp_t gfp, size_t size,
 		}
 
 		full = barn_replace_empty_sheaf(barn, pcs->main,
-						gfpflags_allow_spinning(gfp));
+						/* allow_spin = */ true);
 
 		if (full) {
 			stat(s, BARN_GET);
@@ -7333,8 +7327,7 @@ static bool __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags,
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


