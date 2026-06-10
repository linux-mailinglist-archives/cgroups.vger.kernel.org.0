Return-Path: <cgroups+bounces-16814-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9RYcFSyJKWqiYwMAu9opvQ
	(envelope-from <cgroups+bounces-16814-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 17:56:28 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B61766B145
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 17:56:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=UaFWjH3U;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16814-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16814-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 65ECA301C9D3
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 15:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9961C44A725;
	Wed, 10 Jun 2026 15:40:44 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF29449ED7;
	Wed, 10 Jun 2026 15:40:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106044; cv=none; b=NLzMPFjRqkIOrUNLE/wolRKw7x6MHUeQ1NYHpOqMrgIYAEXm0kfSLh+IqgMhYDY+4E2XHGgIjrD8g7KcdZ/y4ObEp1C8xyvpxNiUh6hB4GBnEMubGu0g33Mpfy9Z2pCow94R54ftWJO8AmHBqQF8so6KMWjP7An/tiJ3Se8Pn7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106044; c=relaxed/simple;
	bh=8602drIWvaMzE1J7gRFwq87zIHWzXIetqQvqoPq1HB4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qSV80L5GiJ0SWwaB0nI/5p4bcj2MuPg0mJLgn+HD332wTvDtnZFDoej391fOi4nxqLr7QmZ/mRntTIzjmsQLn9k5S2q7PTtcCiGKv3kWrD881AI9aXIO36Qo6oUHUJwjZ5dqZlMipdIo7i2+799MEajHmztX+by3LH/eLlNM/VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UaFWjH3U; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B281F00898;
	Wed, 10 Jun 2026 15:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781106043;
	bh=Z++mZQokUZ73KMQBNMzzxOT6j7m/HHKA2PQwEqwlqcs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=UaFWjH3USM6+6T78Sjt/86W5bncAKXl2WivN7Bst2gu6MiEIipnORJuiZFcoMwV32
	 xupyRppQ++6a/7mKK+ctOLW5TePbzH3Yhw2E+7p4WhromGLsj9GNbMMLgRYi6l8/EN
	 ghoK46HcRrwqjfqY+ZGfOJDMbVPniXXl9hxUycYLI1AQyF9WNrUtthXOq224WXXReg
	 i/0NoPpfo7Qa9c3nnyqprZmjds3O4z7fn1inJhaSt31jFA+F8Vt4Wq3cbZZtNGFC6X
	 TmL/+f7gRnrwWNcxtIb4i4ZNqDxx/jkfHxfqjjMFRbq8YCQyI7QkHCTWfzaHOaepxt
	 2H3HaPXzgcwhg==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Wed, 10 Jun 2026 17:40:05 +0200
Subject: [PATCH v2 03/16] mm/slab: stop inlining __slab_alloc_node()
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-slab_alloc_flags-v2-3-7190909db118@kernel.org>
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
	FORGED_RECIPIENTS(0.00)[m:harry@kernel.org,m:hao.li@linux.dev,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:surenb@google.com,m:ast@kernel.org,m:akpm@linux-foundation.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:shakeel.butt@linux.dev,m:glider@google.com,m:elver@google.com,m:dvyukov@google.com,m:kasan-dev@googlegroups.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:vbabka@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[vbabka@kernel.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-16814-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2B61766B145

With sheaves, this is no longer part of the allocation fastpath.  For
the same reason, also mark the call to it from slab_alloc_node() as
unlikely().

Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 mm/slub.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 8e5264d3ddbf..7b48c0d38404 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4519,8 +4519,8 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	return object;
 }
 
-static __always_inline void *__slab_alloc_node(struct kmem_cache *s,
-		gfp_t gfpflags, int node, unsigned long addr, size_t orig_size)
+static void *__slab_alloc_node(struct kmem_cache *s, gfp_t gfpflags, int node,
+			       unsigned long addr, size_t orig_size)
 {
 	void *object;
 
@@ -4923,7 +4923,7 @@ static __fastpath_inline void *slab_alloc_node(struct kmem_cache *s, struct list
 
 	object = alloc_from_pcs(s, gfpflags, node);
 
-	if (!object)
+	if (unlikely(!object))
 		object = __slab_alloc_node(s, gfpflags, node, addr, orig_size);
 
 	maybe_wipe_obj_freeptr(s, object);

-- 
2.54.0


