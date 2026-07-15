Return-Path: <cgroups+bounces-17835-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /6pHK8BcV2qRKQEAu9opvQ
	(envelope-from <cgroups+bounces-17835-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 12:11:12 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2401575CC93
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 12:11:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=U+TsQ7mv;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17835-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17835-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 567CC30117B7
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 10:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7541343B6D0;
	Wed, 15 Jul 2026 10:10:55 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CAB43B6DE;
	Wed, 15 Jul 2026 10:10:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784110255; cv=none; b=HA/W2gTZxtbC2n6nwHsdbpsVqrsUYSgAWs+sxoOGRUd2D3eQYB6lUwjAH2Jg563fmGRsm3MVx7o0aq7dihvgH+WlvdvGL2Ef+CBE9ZCzrsTKrmD0Ty/P2/C1kgMLCt0c3roI7Yr5EC1fSGRk5sdsvvZYT78BLaTIRKSaNLbW5Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784110255; c=relaxed/simple;
	bh=uGyMHKNxgN1D5nK6Ig3/QLKOBnKctCHDvEjNMMoaiWg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ewZMdhPjUDkZuhJFA0YnD6VF68o/EywdMuAqlvDUUHF+/lou1hhTWCFq+UZGrR28zBC1H0SbCJc6zD7bGumAQMA10oLMwclwKyQIUMi8vRredO1J9Q/dVjFcm1u24232w/k2wzbd1+a6HUVyXNWI81UehXiUxaE8WETfuqxhy7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+TsQ7mv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BFAA1F00A3A;
	Wed, 15 Jul 2026 10:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784110253;
	bh=mYcfDPC5eqMJoGRcXKwqOJ+dQiUJ7iaZsQUAOpeN25Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=U+TsQ7mvqJoL/byybbcUpGpAEnF1qYGMAQ0WC1Z8s8XBzlN8LmrJ/6WMh4UCAubEI
	 9lWnQh06X6f8DE/UvYiaTigf60+Gqt46cMUvwllTdqfPQI3x6XMES5KC4vdhIa1AHr
	 qORtW3JtdPXh5/8jflldbh9HYALipwCMztuInIeJpopRq5krzh2jH9qY3mkuLVvXm2
	 r7QEE3v8ot6kjYBboyyCX6hiwOLXXGUZveX8c15ckpT4oBmrc7KASfe+PzXQ5Z7lIE
	 p0EPcRWnwmvJDQ/ksrNtfNu+Vyy3/l8OB0TD1kWrQFObKadMeAzlxlWBy7ACMy06up
	 4tGu2/eQpzAvg==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Wed, 15 Jul 2026 12:10:42 +0200
Subject: [PATCH RFC 02/12] mm/slab: remove objs_per_slab()
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260715-b4-objext_split-v1-2-9a49c4ccf4c3@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
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
	TAGGED_FROM(0.00)[bounces-17835-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2401575CC93

The function has an unused kmem_cache argument and almost nothing uses
it anyway; doing slab->objects is simpler. Remove it with the last two
users. KUNIT_EXPECT_EQ() needs a cast to avoid "error: ‘typeof’ applied
to a bit-field" but we don't need to keep a wrapper just for that.

Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 mm/kfence/kfence_test.c | 2 +-
 mm/slab.h               | 6 ------
 mm/slub.c               | 3 +--
 3 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
index de2d0f7d62b1..9867c03ef0ae 100644
--- a/mm/kfence/kfence_test.c
+++ b/mm/kfence/kfence_test.c
@@ -295,7 +295,7 @@ static void *test_alloc(struct kunit *test, size_t size, gfp_t gfp, enum allocat
 			 * memcg accounting works correctly.
 			 */
 			KUNIT_EXPECT_EQ(test, obj_to_index(s, slab, alloc), 0U);
-			KUNIT_EXPECT_EQ(test, objs_per_slab(s, slab), 1);
+			KUNIT_EXPECT_EQ(test, ((unsigned int)slab->objects), 1);
 
 			if (policy == ALLOCATE_ANY)
 				return alloc;
diff --git a/mm/slab.h b/mm/slab.h
index f5e336b6b6b0..01535e1e2d3c 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -330,12 +330,6 @@ static inline unsigned int obj_to_index(const struct kmem_cache *cache,
 	return __obj_to_index(cache, slab_address(slab), obj);
 }
 
-static inline int objs_per_slab(const struct kmem_cache *cache,
-				const struct slab *slab)
-{
-	return slab->objects;
-}
-
 /*
  * State of the slab allocator.
  *
diff --git a/mm/slub.c b/mm/slub.c
index a4be70d080fb..9e25f2dce7a6 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2127,7 +2127,6 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 			gfp_t gfp, unsigned int alloc_flags)
 {
 	const bool allow_spin = alloc_flags_allow_spinning(alloc_flags);
-	unsigned int objects = objs_per_slab(s, slab);
 	bool new_slab = alloc_flags & SLAB_ALLOC_NEW_SLAB;
 	unsigned long new_exts;
 	unsigned long old_exts;
@@ -2183,7 +2182,7 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 #endif
 retry:
 	old_exts = READ_ONCE(slab->obj_exts);
-	handle_failed_objexts_alloc(old_exts, vec, objects);
+	handle_failed_objexts_alloc(old_exts, vec, slab->objects);
 
 	if (new_slab) {
 		/*

-- 
2.55.0


