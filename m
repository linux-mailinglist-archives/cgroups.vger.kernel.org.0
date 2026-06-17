Return-Path: <cgroups+bounces-17043-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KcrNJiWxMmq73gUAu9opvQ
	(envelope-from <cgroups+bounces-17043-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 16:37:25 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C06469A97B
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 16:37:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=IcHt3Y0P;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17043-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17043-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9946330F5191
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 14:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3437540B360;
	Wed, 17 Jun 2026 14:37:06 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4613DB300;
	Wed, 17 Jun 2026 14:37:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781707026; cv=none; b=ciasqjyXvbS+r9PunThhrgo8kcg2z0g2jV47Sv8pceIQt/oZ5rBpGhUB5P5zhXkdOvGCxSfMqyNJylXydTqOM/L4ScnQ/WstrB+t7vof0bfE7sTgz+/4dcPVo49M2SvTedemj/9NKrrzA7t2JsEdU0COP7nIi/Wf8yVRwaGkgJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781707026; c=relaxed/simple;
	bh=q0XAVA1HHCpriLNnEZ5hJgBPnz8e6cCzLZ2diM9TKZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QnuAKrdpjAY5jpDNpWzeS3xKulFInnXw2IxLD24k7ThgbHwi+LQMtc79ncPULEbuVsULmJ+g2XodcQNCjGwbavs4nqIhkBULyGjbBM8rx5mG8FvCxkBv4AhKka+OyyrRYfq8YkZOwGIMeC0u5C1D/rMw0LuJcdlppPL1bMP6wEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcHt3Y0P; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA2B1F00A3A;
	Wed, 17 Jun 2026 14:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781707024;
	bh=1K7NdwWrShKdIgD+8OvjC8OfnEWC3QHLcX5exYj1THI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=IcHt3Y0PPyWEmxddWmKgfJU/e4Yw/MO27OJ7f4o1fS1EolxhseUUSqYF8iWgMlOdl
	 SLVbKiYVS9Duyfw0e1s1Q7lwrJ98twNMQKNB9PfA5rzqOLG+XgCJGlezC2z2H88MG6
	 P9apbRVSKmAJ+bx/kYzGpBYNaLae3XeeQv6s4XHbPGDK31wkUep/7n2SdsPHjZeJ7g
	 mBQ6bDPcTBJrj61zubrd4G+KXjFcZDfwcwYVbdrQWBgyYTfqO26e9YKzI4w1isGdOg
	 WPBLE8bM1RoD3g05soaZHOdU/KViE3adlqRjC+MLaOjH/H0AWDtEBjq1BHjsQzr65M
	 KyOPKxc05SWew==
Message-ID: <26c29e4b-09b1-424a-b4e4-3358aac20115@kernel.org>
Date: Wed, 17 Jun 2026 16:36:58 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/15] mm/slab: remove __GFP_NO_OBJ_EXT usage from
 alloc_slab_obj_exts()
Content-Language: en-US
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
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <20260615-slab_alloc_flags-v3-0-ce1146d140fb@kernel.org>
 <20260615-slab_alloc_flags-v3-14-ce1146d140fb@kernel.org>
 <78b67a9b-44e5-4649-957a-9d42bfaa098e@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <78b67a9b-44e5-4649-957a-9d42bfaa098e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
	FORGED_RECIPIENTS(0.00)[m:harry@kernel.org,m:hao.li@linux.dev,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:surenb@google.com,m:ast@kernel.org,m:akpm@linux-foundation.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:shakeel.butt@linux.dev,m:glider@google.com,m:elver@google.com,m:dvyukov@google.com,m:kasan-dev@googlegroups.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[vbabka@kernel.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-17043-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4C06469A97B

On 6/17/26 15:56, Harry Yoo wrote:
> 
> 
> On 6/15/26 8:54 PM, Vlastimil Babka (SUSE) wrote:
>> __GFP_NO_OBJ_EXT has limited scope within the slab allocator itself and
>> gfp flags are a scarce resource, unlike slab's alloc_flags.
>> 
>> Introduce SLAB_ALLOC_NO_RECURSE alloc flag that has the same intent as
>> __GFP_NO_OBJ_EXT but a more generic name, meaning that a kmalloc()
>> family function should not recurse into another kmalloc*() for the
>> purposes of allocating auxiliary structures (obj_ext arrays or sheaves).
>> 
>> First, replace the __GFP_NO_OBJ_EXT for allocating obj_ext arrays in
>> alloc_slab_obj_exts(). Make use of the newly added kmalloc_flags()
>> function, where we can pass alloc_flags with SLAB_ALLOC_NO_RECURSE
>> added. This will also pass through SLAB_ALLOC_NOLOCK so we don't need
>> to special case kmalloc_nolock() anymore.
>> 
>> Note that until now the kmalloc_nolock() ignored the incoming gfp flags
>> and hardcoded __GFP_ZERO | __GFP_NO_OBJ_EXT. But it's correct to pass on
>> the incoming gfp flags (only augmented with __GFP_ZERO), because if
>> alloc_flags contain SLAB_ALLOC_NOLOCK, the incoming gfp flags have to
>> be also compatible with it. However, we might have added __GFP_THISNODE
>> for opportunistic slab allocation, as pointed out by Hao Li, and
>> __GFP_COMP by allocate_slab() as pointed out by Shengming Hu. Solve this
>> by adding both flags to OBJCGS_CLEAR_MASK as it makes sense to strip
>> them anyway for non-kmalloc_nolock() allocations of sheaves or obj_ext
>> arrays as well.
>> 
>> To avoid recursion of sheaf -> obj_ext -> sheaf -> ... allocations at
>> this patch, until the next patch converts sheaves to
>> SLAB_ALLOC_NO_RECURSE, use both gfp and alloc_flags for obj_ext. The
>> next patch will remove the gfp part.
>> 
>> Link: https://patch.msgid.link/20260610-slab_alloc_flags-v2-15-7190909db118@kernel.org
>> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
>> ---
> 
> Looks good to me,
> Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>

Thanks!
 
> With some comments below.
> 
> I was worried that perhaps replacing SLAB_ALLOC_NO_RECURSE with
> __GFP_NO_OBJ_EXT will create a cycle of
> 
> alloc_slab_obj_exts(SLAB_ALLOC_DEFAULT)
> -> kmalloc_flags(SLAB_ALLOC_NO_RECURSE)
> -> alloc_from_pcs(SLAB_ALLOC_NO_RECURSE)
> -> refill_objects(SLAB_ALLOC_DEFAULT)
> -> new_slab(SLAB_ALLOC_DEFAULT)
> -> account_slab(SLAB_ALLOC_DEFAULT)
> -> alloc_slab_obj_exts(SLAB_ALLOC_DEFAULT)
> 
> with __GFP_NO_OBJ_EXT, it would have been passed to refill_objects(),
> but SLAB_ALLOC_NO_RECURSE is not. However this cycle does not exist
> because alloc_slab_obj_exts() clears __GFP_ACCOUNT (as part of
> OBJCG_CLEAR_MASK) and memory profiling itself does not invoke
> alloc_slab_obj_exts() when allocating new slabs if SLAB_ACCOUNT is not
> set (which is interesting, by the way).

Hm yeah I think we should propagate alloc_flags to refill_objects() etc, to 
avoid later surprise. But can be done as a later cleanup.
 
> Also alloc_slab_obj_exts() propagating SLAB_ALLOC_NEW_SLAB to
> kmalloc_flags() is little bit confusing because it does not have any
> effect due to SLAB_ALLOC_NO_RECURSE.

OK let's address this one by this fixup:

diff --git a/mm/slub.c b/mm/slub.c
index fc5b8c85b690..dc4b4ae874ce 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2164,6 +2164,7 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 {
 	const bool allow_spin = alloc_flags_allow_spinning(alloc_flags);
 	unsigned int objects = objs_per_slab(s, slab);
+	bool new_slab = alloc_flags & SLAB_ALLOC_NEW_SLAB;
 	unsigned long new_exts;
 	unsigned long old_exts;
 	struct slabobj_ext *vec;
@@ -2173,6 +2174,7 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 	/* Prevent recursive extension vector allocation */
 	gfp |= __GFP_NO_OBJ_EXT;
 	alloc_flags |= SLAB_ALLOC_NO_RECURSE;
+	alloc_flags &= ~SLAB_ALLOC_NEW_SLAB;
 
 	sz = obj_exts_alloc_size(s, slab, gfp);
 
@@ -2203,7 +2205,7 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 	old_exts = READ_ONCE(slab->obj_exts);
 	handle_failed_objexts_alloc(old_exts, vec, objects);
 
-	if (alloc_flags & SLAB_ALLOC_NEW_SLAB) {
+	if (new_slab) {
 		/*
 		 * If the slab is brand new and nobody can yet access its
 		 * obj_exts, no synchronization is required and obj_exts can


