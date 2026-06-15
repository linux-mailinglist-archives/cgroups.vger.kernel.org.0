Return-Path: <cgroups+bounces-16963-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GKinKb/pL2rJIwUAu9opvQ
	(envelope-from <cgroups+bounces-16963-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 14:02:07 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDCA685F01
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 14:02:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nSPq5Pu2;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16963-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16963-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A09332003E8
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 11:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350FB3E835B;
	Mon, 15 Jun 2026 11:55:33 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68F13EB11F;
	Mon, 15 Jun 2026 11:55:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781524533; cv=none; b=RUi52iQoI3GCpWxlccwPgo8KwFL8dL6zATKodA/kYYbHzMonXurMbze5AvO6d3u0vhlRkqiolU1aquNK1AqF6sqtt+iV5T6Z/gB8RUqWxTylAi23OdgMSjKc78oaDOGOyFoCDvunx8PIJLgbAlUbRFuvhuXiKQrpZ4gh2yw2Zik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781524533; c=relaxed/simple;
	bh=5gIOqWV9wcmyu4ON19sKXUdCyuzk68JxO2tp0nhdzKw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qsLD8dxZWlWRe6vkGNPK8fBaL1wMywRuL+TeOpo8XHkCy2364awLW9Fu4dVVTJgbOW9cgjLcQt3BJTBG+4IscOIP6yNG9xFuihoff/7jVLn8N1ieZ9QrEYL0tdEJm9uND6fOkh3VvjwdkH7iSn3MI6L+ObL/CCQHeY1pC/vVF38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSPq5Pu2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D7031F00A3D;
	Mon, 15 Jun 2026 11:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781524531;
	bh=1LMlha3I3jmWXWTn3LCS36ZII8qgnXRUvT0Ggzn4U4k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=nSPq5Pu2IrBynukV+o2+XQc5aXPntEQ5LyA88YUlAq7W/+J4DZ6nG2UnHMo2CuFgW
	 ei8Ls9ftSWVnK74ef1CwdMD3y+g12ip3WVnH/mBQvQ+mIZOlVqeV2t+WLlmRCDxr/+
	 EV3OXmSBpDdiW3v/rprj+fNd7gd5vrn1XrKYPMnmeXh3ogUkZU1kNB59js63pHfGY/
	 wmUUzMO84rwLMwkLH7ypPY2jcE12UDCjG61HdOZdcm+rs7GK0FXQCdpPuTSogzD70q
	 geIXxfN9D8/S7OC5CgwQnOzT1Qg1uO0/aZSEey8Y43VTxtofTAju0NbtCIxMMVNi7q
	 RpHp+TIitP3tg==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Mon, 15 Jun 2026 13:54:45 +0200
Subject: [PATCH v3 12/15] mm/slab: allow __GFP_NOMEMALLOC and __GFP_NOWARN
 for kmalloc_nolock()
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-slab_alloc_flags-v3-12-ce1146d140fb@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
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
	TAGGED_FROM(0.00)[bounces-16963-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EFDCA685F01

The two flags are added internally so there's no point for warning if
they are passed by the caller as well, so allow them. This will allow
simplifying obj_ext allocation under kmalloc_nolock().

Also it's not necessary to have the extra alloc_gfp variable for adding
the two flags. The original gfp_flags parameter is not used anywhere
except for the warning. So remove alloc_gfp and directly modify and use
gfp_flags everywhere.

Link: https://patch.msgid.link/20260610-slab_alloc_flags-v2-13-7190909db118@kernel.org
Reviewed-by: Hao Li <hao.li@linux.dev>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 include/linux/slab.h |  3 ++-
 mm/slub.c            | 19 ++++++++++---------
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index ce1c867dc0ba..b955f3cbb732 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -1040,7 +1040,8 @@ void *_kmalloc_nolock_noprof(DECL_TOKEN_PARAMS(size, token), gfp_t gfp_flags, in
  * kmalloc_nolock - Allocate an object of given size from any context.
  * @size: size to allocate
  * @gfp_flags: GFP flags. Only __GFP_ACCOUNT, __GFP_ZERO, __GFP_NO_OBJ_EXT
- * allowed.
+ * allowed. Also __GFP_NOWARN and __GFP_NOMEMALLOC are allowed but added
+ * internally thus not necessary.
  * @node: node number of the target node.
  *
  * Return: pointer to the new object or NULL in case of error.
diff --git a/mm/slub.c b/mm/slub.c
index 537ea68f417b..8769083bec81 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5387,7 +5387,6 @@ EXPORT_SYMBOL(__kmalloc_noprof);
 
 void *_kmalloc_nolock_noprof(DECL_TOKEN_PARAMS(size, token), gfp_t gfp_flags, int node)
 {
-	gfp_t alloc_gfp = __GFP_NOWARN | __GFP_NOMEMALLOC | gfp_flags;
 	size_t orig_size = size;
 	unsigned int alloc_flags = SLAB_ALLOC_NOLOCK;
 	struct kmem_cache *s;
@@ -5400,7 +5399,9 @@ void *_kmalloc_nolock_noprof(DECL_TOKEN_PARAMS(size, token), gfp_t gfp_flags, in
 	};
 
 	VM_WARN_ON_ONCE(gfp_flags & ~(__GFP_ACCOUNT | __GFP_ZERO |
-				      __GFP_NO_OBJ_EXT));
+			__GFP_NO_OBJ_EXT | __GFP_NOWARN | __GFP_NOMEMALLOC));
+
+	gfp_flags |= __GFP_NOWARN | __GFP_NOMEMALLOC;
 
 	if (unlikely(!size))
 		return ZERO_SIZE_PTR;
@@ -5419,7 +5420,7 @@ void *_kmalloc_nolock_noprof(DECL_TOKEN_PARAMS(size, token), gfp_t gfp_flags, in
 retry:
 	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
 		return NULL;
-	s = kmalloc_slab(size, NULL, alloc_gfp, PASS_TOKEN_PARAM(token));
+	s = kmalloc_slab(size, NULL, gfp_flags, PASS_TOKEN_PARAM(token));
 
 	if (!(s->flags & __CMPXCHG_DOUBLE) && !kmem_cache_debug(s))
 		/*
@@ -5433,7 +5434,7 @@ void *_kmalloc_nolock_noprof(DECL_TOKEN_PARAMS(size, token), gfp_t gfp_flags, in
 		 */
 		return NULL;
 
-	ret = alloc_from_pcs(s, alloc_gfp, alloc_flags, node);
+	ret = alloc_from_pcs(s, gfp_flags, alloc_flags, node);
 	if (ret)
 		goto success;
 
@@ -5443,7 +5444,7 @@ void *_kmalloc_nolock_noprof(DECL_TOKEN_PARAMS(size, token), gfp_t gfp_flags, in
 	 * kfence_alloc. Hence call __slab_alloc_node() (at most twice)
 	 * and slab_post_alloc_hook() directly.
 	 */
-	ret = __slab_alloc_node(s, alloc_gfp, node, &ac);
+	ret = __slab_alloc_node(s, gfp_flags, node, &ac);
 
 	/*
 	 * It's possible we failed due to trylock as we preempted someone with
@@ -5456,8 +5457,8 @@ void *_kmalloc_nolock_noprof(DECL_TOKEN_PARAMS(size, token), gfp_t gfp_flags, in
 		size = s->object_size + 1;
 		/*
 		 * Another alternative is to
-		 * if (memcg) alloc_gfp &= ~__GFP_ACCOUNT;
-		 * else if (!memcg) alloc_gfp |= __GFP_ACCOUNT;
+		 * if (memcg) gfp_flags &= ~__GFP_ACCOUNT;
+		 * else if (!memcg) gfp_flags |= __GFP_ACCOUNT;
 		 * to retry from bucket of the same size.
 		 */
 		can_retry = false;
@@ -5466,9 +5467,9 @@ void *_kmalloc_nolock_noprof(DECL_TOKEN_PARAMS(size, token), gfp_t gfp_flags, in
 
 success:
 	maybe_wipe_obj_freeptr(s, ret);
-	slab_post_alloc_hook(s, alloc_gfp, 1, &ret, &ac);
+	slab_post_alloc_hook(s, gfp_flags, 1, &ret, &ac);
 
-	ret = kasan_kmalloc(s, ret, orig_size, alloc_gfp);
+	ret = kasan_kmalloc(s, ret, orig_size, gfp_flags);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(_kmalloc_nolock_noprof);

-- 
2.54.0


