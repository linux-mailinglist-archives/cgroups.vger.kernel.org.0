Return-Path: <cgroups+bounces-16824-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id awnbCUeJKWqzYwMAu9opvQ
	(envelope-from <cgroups+bounces-16824-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 17:56:55 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 961DA66B159
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 17:56:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="euWmhiL/";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16824-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16824-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52E7735496E4
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 15:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27417426698;
	Wed, 10 Jun 2026 15:41:58 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B1C43CEED;
	Wed, 10 Jun 2026 15:41:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106117; cv=none; b=m0YC3vFL+vAEW3slJcftcO2YKoidDewdcf+FchlyJFeG8iy4SU0dJrBrBkYquqbdj/Ampn/kRkDyQQdxxQdIuSGyOcfk3toDoJI3s1l6ChdlsQxPzBA0DjkiQ3d99cmubBrOgN7Nu1aw/Duzeisgjdj72Kk/8Xe70RepO0vVgTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106117; c=relaxed/simple;
	bh=Svx1vtCi0eqoMNa9zi5XKXmuF9MKi0bJitn7U2YLQoA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=thOB+NbFJFNqWnjM+ryhoHlifc/EcvhW0X50q45ti7pPrDBXJdN/NafTgiKG9PiHzcllnYWglKDAuF69vVA24MCaJDDSNDTn96JaqxMFtXWyL4MU9ZBVfUaVkC4ATq21+DSSy6Ru0UvpkdbuRP7Rw/XUYPm8poswOkFiQSjTOho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=euWmhiL/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9314D1F00898;
	Wed, 10 Jun 2026 15:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781106116;
	bh=rAo2TJ3mFhvqnm70uvjWd4gD385rP/fi/7KGDakhPn4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=euWmhiL/lEvXt05tpNb7MhFHmWkvYpZ58BpFYeH7WWhqmkxsGJptakcG9Tjvx5MXP
	 AAm3LKcSUpQQJ3uRGAZAz7MhaYb+6B/7dt2i0ANpYjZB9ijvCnbHhcKlGgON7+MWVI
	 4NwcuqOiBWKZ8zhi3GDUjoKO5pbpCFctoQ8etmybEEa7Fy397FfQhD2XIfcO8M4wzM
	 /XD5DmzJNSoc4ol0L8l/TniwRG9kjwNbZ02/XbK+T4rKfUP3OujCgiJ3qS5ar+BPFv
	 nt6pJkH8khzEKPIQJpqsD+JkJ15LYSaiZaCapgcPBo06od3ClLgqHJPW0UJwg58cFh
	 zHE4WI5ZLiZgQ==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Wed, 10 Jun 2026 17:40:15 +0200
Subject: [PATCH v2 13/16] mm/slab: allow __GFP_NOMEMALLOC and __GFP_NOWARN
 for kmalloc_nolock()
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-slab_alloc_flags-v2-13-7190909db118@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
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
	TAGGED_FROM(0.00)[bounces-16824-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 961DA66B159

The two flags are added internally so there's no point for warning if
they are passed by the caller as well, so allow them. This will allow
simplifying obj_ext allocation under kmalloc_nolock().

Also it's not necessary to have the extra alloc_gfp variable for adding
the two flags. The original gfp_flags parameter is not used anywhere
except for the warning. So remove alloc_gfp and directly modify and use
gfp_flags everywhere.

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
index 6845e15c148a..847cad5203b2 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5388,7 +5388,6 @@ EXPORT_SYMBOL(__kmalloc_noprof);
 
 void *_kmalloc_nolock_noprof(DECL_TOKEN_PARAMS(size, token), gfp_t gfp_flags, int node)
 {
-	gfp_t alloc_gfp = __GFP_NOWARN | __GFP_NOMEMALLOC | gfp_flags;
 	size_t orig_size = size;
 	unsigned int alloc_flags = SLAB_ALLOC_TRYLOCK;
 	struct kmem_cache *s;
@@ -5396,7 +5395,9 @@ void *_kmalloc_nolock_noprof(DECL_TOKEN_PARAMS(size, token), gfp_t gfp_flags, in
 	void *ret;
 
 	VM_WARN_ON_ONCE(gfp_flags & ~(__GFP_ACCOUNT | __GFP_ZERO |
-				      __GFP_NO_OBJ_EXT));
+			__GFP_NO_OBJ_EXT | __GFP_NOWARN | __GFP_NOMEMALLOC));
+
+	gfp_flags |= __GFP_NOWARN | __GFP_NOMEMALLOC;
 
 	if (unlikely(!size))
 		return ZERO_SIZE_PTR;
@@ -5415,7 +5416,7 @@ void *_kmalloc_nolock_noprof(DECL_TOKEN_PARAMS(size, token), gfp_t gfp_flags, in
 retry:
 	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
 		return NULL;
-	s = kmalloc_slab(size, NULL, alloc_gfp, PASS_TOKEN_PARAM(token));
+	s = kmalloc_slab(size, NULL, gfp_flags, PASS_TOKEN_PARAM(token));
 
 	if (!(s->flags & __CMPXCHG_DOUBLE) && !kmem_cache_debug(s))
 		/*
@@ -5429,7 +5430,7 @@ void *_kmalloc_nolock_noprof(DECL_TOKEN_PARAMS(size, token), gfp_t gfp_flags, in
 		 */
 		return NULL;
 
-	ret = alloc_from_pcs(s, alloc_gfp, alloc_flags, node);
+	ret = alloc_from_pcs(s, gfp_flags, alloc_flags, node);
 	if (ret)
 		goto success;
 
@@ -5445,7 +5446,7 @@ void *_kmalloc_nolock_noprof(DECL_TOKEN_PARAMS(size, token), gfp_t gfp_flags, in
 	 * kfence_alloc. Hence call __slab_alloc_node() (at most twice)
 	 * and slab_post_alloc_hook() directly.
 	 */
-	ret = __slab_alloc_node(s, alloc_gfp, node, &ac);
+	ret = __slab_alloc_node(s, gfp_flags, node, &ac);
 
 	/*
 	 * It's possible we failed due to trylock as we preempted someone with
@@ -5458,8 +5459,8 @@ void *_kmalloc_nolock_noprof(DECL_TOKEN_PARAMS(size, token), gfp_t gfp_flags, in
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
@@ -5468,9 +5469,9 @@ void *_kmalloc_nolock_noprof(DECL_TOKEN_PARAMS(size, token), gfp_t gfp_flags, in
 
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


