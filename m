Return-Path: <cgroups+bounces-17834-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fHa6Bk5dV2rEKQEAu9opvQ
	(envelope-from <cgroups+bounces-17834-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 12:13:34 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6972475CCFD
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 12:13:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=RrmWcN1z;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17834-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17834-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 893CB30AFD2B
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 10:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5541643B6ED;
	Wed, 15 Jul 2026 10:10:52 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A28C43B6E5;
	Wed, 15 Jul 2026 10:10:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784110252; cv=none; b=S5vTsF+qEYGi+8Yx+8264PDPeDK7gDbIRv5U0bmDAIm4PicHfFj5SVC00/yHMHPtKYpT24H09ezHLAzn7bo2w+BOjYaT1GAB9RiOQ0gbFCXo0Tao2AoYfi+cCtXQE6KGLeu+q2eDEQpMa+uUNfIF9/kANtGqCs4QvNqH9D9YVT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784110252; c=relaxed/simple;
	bh=qrvBi037NaDO5Ac9ofIMepjLFwbLj4Xq6ZZHsuekDEQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ikn17uTBFDdNNsmJl0TkaWeYzZSVXvgdnRYGT6eyqIT9obdRb1VXEYtaSGosnMDlKdGLlEM1SrUwOGfbUiHyvv5FeVS+dCxDBC71C9tk+E1U8HZIQatdcb49vs2r/udxRpTrqzzvCN7Drh9KesztOGfaI9/V7DRCHE3745eYN2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrmWcN1z; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE2F1F000E9;
	Wed, 15 Jul 2026 10:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784110250;
	bh=j/MNUihFnJ5m2LB0LV8GlcwqRsbdT05/VOgE/B2r1H8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=RrmWcN1zFUQL1nATXeEdG5TTLgpmKdOGfLgt4DJn3a2jKiMPGqNcTxonnc7uopQua
	 SX5xTyAFXfths7sBj+EG8Bw3uI05RRsRknVthAW5YiEzYKpajVnvd5POJcPO8HjcKk
	 gOYmeN1kdT8L3irY4goVANf7kkv8Pvnypzm0sLrbQiiW3javGplxXqCnnAsvMS1gSZ
	 NAs92/Kw46cHjkeCe6/8a1yqIA4Rj51qCtlTX0aH+uxvTeuVUm9EP0VD2glJQKEkDg
	 5a0cfcP25m0gj45nBITGhc3Sn+R+QYrRr0dYmt08vFRBldJS1dKr/YqJCwSFa73ySf
	 kIuo/G8jpo8fg==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Wed, 15 Jul 2026 12:10:41 +0200
Subject: [PATCH RFC 01/12] mm/slab: skip kfence objects in allocation
 profiling
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-b4-objext_split-v1-1-9a49c4ccf4c3@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
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
	TAGGED_FROM(0.00)[bounces-17834-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6972475CCFD

struct kfence_metadata only has obj_exts with CONFIG_MEMCG. If it's
enabled, it does also work for allocation profiling, but there's little
value recording tags for KFENCE objects. Furthermore it would complicate
the upcoming changes, so just skip them in the slab hooks.

Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 mm/slub.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/slub.c b/mm/slub.c
index 0337e60db5ac..a4be70d080fb 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2352,6 +2352,9 @@ __alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_t flags,
 	if (alloc_flags & SLAB_ALLOC_NO_RECURSE)
 		return;
 
+	if (is_kfence_address(object))
+		return;
+
 	slab = virt_to_slab(object);
 	obj_exts = prepare_slab_obj_exts_hook(s, slab, flags, alloc_flags, object);
 	/*
@@ -2399,6 +2402,9 @@ __alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p
 	for (i = 0; i < objects; i++) {
 		unsigned int off = obj_to_index(s, slab, p[i]);
 
+		if (is_kfence_address(p[i]))
+			continue;
+
 		alloc_tag_sub(&slab_obj_ext(slab, obj_exts, off)->ref, s->size);
 	}
 	put_slab_obj_exts(obj_exts);

-- 
2.55.0


