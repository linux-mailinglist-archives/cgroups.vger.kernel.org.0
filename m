Return-Path: <cgroups+bounces-17845-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fzlABMtdV2rsKQEAu9opvQ
	(envelope-from <cgroups+bounces-17845-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 12:15:39 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7383C75CD63
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 12:15:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=lGHDqt5V;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17845-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17845-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1260930DF44D
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 10:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94D243E488;
	Wed, 15 Jul 2026 10:11:26 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9057243F4BE;
	Wed, 15 Jul 2026 10:11:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784110286; cv=none; b=GU2xHX4TKJ8BoAiJazN1unYUubBffC6Ta5B4oI80izDUtekIDlwqaO3sfi1TB5pfzHa+HOeZyMbDNDmGPHt/4h+YSfPYod8CAaGMfhc0JoZ2frT683FMNqlSX3iPBK/BwxJqsoBoFzYmGYWPtTlpFZqoXGB1qi/YtEhafVOBvXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784110286; c=relaxed/simple;
	bh=O0CIznq26Ds2kUKsMvzrT8Dx5jQK5mnuzi2ty7qEc0g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HW/ggma22lmkTOrelZPYw1j+J6MWy4hpqDc6QB0duZRkDedNEHHOBYHVNwYWPqqv5ima3xBY3r60wgnGXi8xK+ASNFaJT0thW++rX0EERbqK217BDJBE16lym8fRISY2vYZma5MmRU3w/Y2ESXuI2FejRYbmQuOMIYxB+MGsfR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lGHDqt5V; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831751F00A3A;
	Wed, 15 Jul 2026 10:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784110285;
	bh=sxiKNmbJD7zBEkDQUyHwImzWMYztIT9SravkSnuQT8g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=lGHDqt5VwPjEwT8kk2s3Ys3pWyu6FyVPdbFgHVC0vlQvErAZH6PxAPutt7waAvKb1
	 sPYK5/rI9F0AP/MopFYh0hscAsBpuqgr9stRYMtsJLwEx5cZFa2CqqG2BtumyMr4RQ
	 /hdyfFlwdEVyK6CqDt6Aw3di232txGDH7dTfQYIH4cBQr03QpcwYOFZFhSRChqb3QA
	 oKJxtdn3g/R09HDdzGF+jWLF6W1mxKlW5KU5aG4hwofplZUCD62EZib4C+NScRzNck
	 jrdi2vF5fS7y4GuXcuUiRVEi3CLpi8hW41rXZHlemscDJhmv5TF+l4h6MGNDHxZNbj
	 BMiRwr9Ga9v0g==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Wed, 15 Jul 2026 12:10:52 +0200
Subject: [PATCH RFC 12/12] mm/slab: stop allocating objcg pointers when
 unnecessary
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-b4-objext_split-v1-12-9a49c4ccf4c3@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
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
	TAGGED_FROM(0.00)[bounces-17845-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7383C75CD63

Start using the slab_needs_objcg() helper to calculate slabobj_ext size.
Caches that we know to never need objcg pointers (currently
KMALLOC_NORMAL caches) will thus stop wasting memory on them when memory
allocation profiling is enabled.

For things to work properly, we need to also add slab_needs_objcg()
checks to mem_cgroup_from_obj_slab() and memcg_slab_free_hook(), because
when obj_exts array exists for a slab only due to mem_alloc profiling,
we would otherwise attempt to access a non-existing objcg pointer in
that slab.

The function __memcg_slab_post_alloc_hook() should not be possible to
call for a slab where slab_needs_objcg() is false, but add a DEBUG_VM
check there to prevent breaking this assumption accidentally.

Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 mm/memcontrol.c |  6 ++++++
 mm/slab.h       | 12 ++++++++++--
 mm/slub.c       |  3 +++
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6303a2b1a9d0..09659722ec85 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2871,6 +2871,9 @@ struct mem_cgroup *mem_cgroup_from_obj_slab(struct slab *slab, void *p)
 	if (!obj_exts)
 		return NULL;
 
+	if (!slab_needs_objcg(slab))
+		return NULL;
+
 	get_slab_obj_exts(obj_exts);
 	obj_ext = slab_obj_ext(slab->slab_cache, slab, obj_exts, p);
 	objcg = *slab_obj_ext_objcgp(obj_ext);
@@ -3581,6 +3584,9 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 
 		slab = virt_to_slab(p[i]);
 
+		if (IS_ENABLED(CONFIG_DEBUG_VM) && WARN_ON_ONCE(!slab_needs_objcg(slab)))
+			continue;
+
 		if (!slab_obj_exts(slab) &&
 		    alloc_slab_obj_exts(slab, s, flags, slab_alloc_flags)) {
 			continue;
diff --git a/mm/slab.h b/mm/slab.h
index 948d075cdbef..072cc2506756 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -622,7 +622,15 @@ static inline size_t static_obj_ext_size(void)
 
 static inline size_t slab_obj_ext_size(struct slab *slab)
 {
-	return static_obj_ext_size();
+	size_t sz = 0;
+
+	if (slab_needs_objcg(slab))
+		sz += 1;
+
+	if (slab_obj_ext_has_codetag())
+		sz += 1;
+
+	return sizeof(struct slabobj_ext) * sz;
 }
 
 #ifdef CONFIG_SLAB_OBJ_EXT
@@ -741,7 +749,7 @@ static inline struct obj_cgroup **slab_obj_ext_objcgp(struct slabobj_ext *obj_ex
 static inline union codetag_ref *
 slab_obj_ext_codetag_ref(struct slab *slab, struct slabobj_ext *obj_ext)
 {
-	if (IS_ENABLED(CONFIG_MEMCG))
+	if (slab_needs_objcg(slab))
 		obj_ext += 1;
 
 	return &obj_ext->_ctref;
diff --git a/mm/slub.c b/mm/slub.c
index 771d73abacb6..09c4931e5435 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2503,6 +2503,9 @@ void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
 	if (likely(!obj_exts))
 		return;
 
+	if (!slab_needs_objcg(slab))
+		return;
+
 	get_slab_obj_exts(obj_exts);
 	__memcg_slab_free_hook(s, slab, p, objects, obj_exts);
 	put_slab_obj_exts(obj_exts);

-- 
2.55.0


