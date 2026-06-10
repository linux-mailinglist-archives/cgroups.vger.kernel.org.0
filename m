Return-Path: <cgroups+bounces-16806-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id W/FIL2xwKWq6WwMAu9opvQ
	(envelope-from <cgroups+bounces-16806-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 16:10:52 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B2366A205
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 16:10:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=IZ27F55V;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16806-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-16806-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 669363004272
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 14:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D83C3A75A2;
	Wed, 10 Jun 2026 14:04:23 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E2C33CEA8;
	Wed, 10 Jun 2026 14:04:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781100263; cv=none; b=bVtdsRXfRM0M2FdpFQjUhVH7nCmS24qHhSgx4amxuew8o19DgedHiepzRTyVCGagFdWjZgvM/m9fPau0ySgCtAtP+4pw/OWrh+sg8qXcmgYr/xl8tvLQ6Ubxywqwiv5Sl926xMeukTG/WGhB10KwTqIhhfbkXWwK5Uf2iXljeo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781100263; c=relaxed/simple;
	bh=ZAgIGcFyTgo8OZNINn6R1wPxSuL5Cv9V5+N3MRgOtMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GG5qT8adHXhHpnDtNwLVep7jfcm23zIRr/TLT2iollOGVzXp22Adz9C8d8ZiYd44fYaF8K4Htgqd2sAOVlXz/Syi7fznGPY2FZFt/uGSFDyZr2JceauocPbhhYbQJHj0qFbLDTLJZ+Y++yH0lhP4Tlg+I/ThBmhgVEnxVkAMMAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZ27F55V; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ABCA1F00893;
	Wed, 10 Jun 2026 14:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781100261;
	bh=9WoSNkxkAmlgrYK5pk3MND8Naa2H15fz8ABwUK5IjXY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=IZ27F55VADckRYY8xgm9G5m7RFOh2m9iXBN76hocpR5kABCo/Zw5kokS0S0fDpLQ0
	 KJgYVhRktms9A04Hk8JU+nckrcqwjF6KJ48y6aVWsnm1d4uZQAZySgDlcnks8S2BWW
	 6p5JD5TN71HgBEjB+R+DtiwcRKSuQItBNxwQ39BzIxjca54eGqrzJezOV/29By0atf
	 LqcA+37V9reCSYLZtZAoba7+Xh37l8cs6/DsqkviPtq9mCoxSSUW/WH5FpgvqUKLTy
	 yX2oOVDSjX8LKFuerQvVIa4B2SHx8gqYv9blvJFStIapgiVRDTZM0PCq5YBldO9/gc
	 N/mUHucPZyDtQ==
Message-ID: <0b9dce0f-f2a8-4b52-9c06-600eb13d4a7c@kernel.org>
Date: Wed, 10 Jun 2026 16:04:16 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 00/15] mm/slab: introduce alloc_flags and
 slab_alloc_context
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
References: <20260609-slab_alloc_flags-v1-0-2bf4a4b9b526@kernel.org>
 <e650e125-5f6c-4de7-88b5-9da666bb0a4e@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <e650e125-5f6c-4de7-88b5-9da666bb0a4e@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-16806-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 15B2366A205

On 6/10/26 15:46, Harry Yoo wrote:
> 
> 
> On 6/9/26 6:17 PM, Vlastimil Babka (SUSE) wrote:
>> This series is based on slab/for-next. If all goes well, it would
>> hopefully go to slab/for-next soon after the 7.2 merge window, so any
>> other work can be based on it to avoid conflicts, as it touches a lot
>> parts of slab.
>> 
>> Git: https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=b4/slab_alloc_flags
>> 
>> The slab implementation currently relies on gfp flags to convey
>> some context information internally:
>> 
>> - The absence of both __GFP_RECLAIM flags is interpreted as "cannot spin
>>   on locks", and intended to be used by kmalloc_nolock(). But false
>>   positives are possible e.g. during early boot where gfp_allowed_mask
>>   clears __GFP_RECLAIM from all allocations. This leads to unnecessary
>>   allocation failures and workarounds such as fd3634312a04 ("debugobject:
>>   Make it work with deferred page initialization - again").
>> 
>> - __GFP_NO_OBJ_EXT exists and takes up valuable bit in the gfp flags
>>   space, only to prevent recursive kmalloc() allocations for obj_ext
>>   arrays and sheaves.
> 
> [ Cc'ing Vishal and Matthew as it's somewhat relevant to memdescs... ]
> 
> When the page allocator starts allocateing slab objects,
> we still need a way to avoid recursion for obj_ext arrays and sheaves
> (by passing SLAB_ALLOC_NO_RECURSE).
> 
> Looking at kmalloc_flags(), probably we'll end up introducing a separate
> gfp type for slab-specific flags?

What do you mean by separate gfp type?

> Hmm but SLAB_ALLOC_* flags are defined in mm/slab.h and kmalloc_flags()
> is defined in include/linux/slab.h. Do yo intend to restrict the slab
> alloc flags to MM only?

Yeah I don't expect users outside MM. If a valid one appears, we can move
it. I should try moving kmalloc_flags() to mm/slab.h as well, unless there's
some header dependency issue that will prevent it.

>> The page allocator uses its internal alloc_flags to convey various
>> context information, including ALLOC_TRYLOCK (meaning "cannot spin").
>> This series copies that concept for the slab allocator, with its own
>> slab-specific internal flags:
>> 
>> - SLAB_ALLOC_DEFAULT - no extra flags (the value is 0), but explicit
>> - SLAB_ALLOC_TRYLOCK - do not spin on locks (used by kmalloc_nolock())
>> - SLAB_ALLOC_NEW_SLAB - replacing existing 'bool new_slab' parameter
>> 			for allocating obj_ext arrays
>> - SLAB_ALLOC_NO_RECURSE - replacing usage of __GFP_NO_OBJ_EXT
>> 
>> To reduce the amount of parameters in various internal functions, we
>> additionally introduce slab_alloc_context (also inspired by page
>> allocator's alloc_context) for passing a number of existing arguments
>> and the new alloc_flags:
>> 
>> /* Structure holding extra parameters for slab allocations */
>> struct slab_alloc_context {
>> 	unsigned long caller_addr;
>> 	unsigned long orig_size;
>> 	unsigned int alloc_flags;
>> 	struct list_lru *lru;
>> };
> 
> Perhaps beyond the scope of the patchset, but I wonder if we could have
> something like struct slab_alloc_context but for kmalloc callers to
> simplify {PASS,DECL}_KMALLOC_PARAMS().
> 
> Something like:
> 
> struct kmalloc_params {
> #ifdef CONFIG_SLAB_BUCKETS
> 	kmem_buckets *b;
> #endif
> #ifdef CONFIG_KMALLOC_PARTITION_CACHES
> 	kmalloc_token_t token;
> #endif
> };
> 
> The idea is to move optional kmalloc parameters (depending on config)
> into a single struct, instead of using the macros.
> 
> void *__kmalloc_node(size_t size, gfp_t flags, int node,
> 		     unsigned long caller,
> 		     struct kmalloc_params params);
> 
> void *kmalloc_node() {
>     /* ... snip ...*/
>     struct kmalloc_params params = KMALLOC_PARAMS(params.b, params.token);
>     return __kmalloc_node(size, flags, node, _RET_IP_, params);
> }
> 
> The compiler should optimize away unused fields based on the config.
> 
> Per System V AMD64 ABI, the compiler will use registers to pass the
> struct, as long as the struct size does not exceed 16 bytes.
> (Otherwise it will be passed on stack).

Hm but does this work on all architectures, and are we doing this somewhere
(for structures larger than a native word) already?
Also Marco noted earlier that gcc won't optimize away the struct if it
becomes zero-sized:

https://lore.kernel.org/all/CANpmjNO1aNm3mKphDGWasK_NUfVY8q4K9GCjyREZFqrOu9WLcw@mail.gmail.com/

>> This also replaces the existing struct partial_context.
>> 
>> The last necessary piece is kmalloc_flags() which can take the
>> alloc_flags in addition to gfp flags and is intended for the recursive
>> allocations of sheaves and obj_ext arrays, so that both
>> SLAB_ALLOC_TRYLOCK and SLAB_ALLOC_NO_RECURSE can be communicated.
>> Internally it decides between kmalloc_nolock() and normal kmalloc()
>> depending SLAB_ALLOC_TRYLOCK.
>> 
>> The rest of the series is gradually expanding the usage of both
>> alloc_flags and slab_alloc_context as necessary, with bits of
>> refactoring. Then, __GFP_NO_OBJ_EXT is removed completely.
>> 
>> Note that some usage of gfpflags_allow_spinning() relying on absence of
>> __GFP_RECLAIM remains outside of slab (and page allocator) in memcg,
>> page_owner and stackdepot code. These can thus yield false-positive
>> decisions that spinning is not allowed, but should not result in
>> important allocations failing anymore.
>> 
>> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
>> ---
>> Vlastimil Babka (SUSE) (15):
>>       mm/slab: always zero only requested size on alloc
>>       mm/slab: stop inlining __slab_alloc_node()
>>       mm/slab: introduce slab_alloc_context
>>       mm/slab: introduce alloc_flags and SLAB_ALLOC_TRYLOCK
>>       mm/slab: add alloc_flags to slab_alloc_context
>>       mm/slab: replace struct partial_context with slab_alloc_context
>>       mm/slab: pass alloc_flags to new slab allocation
>>       mm/slab: pass alloc_flags through slab_post_alloc_hook() chain
>>       mm/slab: replace slab_alloc_node() parameters with slab_alloc_context
>>       mm/slab: allow kmem_cache_alloc_bulk() with any gfp flags
>>       mm/slab: pass slab_alloc_context to __do_kmalloc_node()
>>       mm/slab: introduce kmalloc_flags()
>>       mm/slab: remove __GFP_NO_OBJ_EXT usage from alloc_slab_obj_exts()
>>       mm/slab: replace __GFP_NO_OBJ_EXT with SLAB_ALLOC_NO_RECURSE for sheaves
>>       mm: remove the __GFP_NO_OBJ_EXT flag
>> 
>>  include/linux/gfp_types.h       |   7 -
>>  include/linux/slab.h            |  14 +-
>>  include/trace/events/mmflags.h  |  10 +-
>>  lib/alloc_tag.c                 |   2 +-
>>  mm/kfence/core.c                |   6 +-
>>  mm/memcontrol.c                 |   5 +-
>>  mm/slab.h                       |  16 +-
>>  mm/slub.c                       | 423 ++++++++++++++++++++++++----------------
>>  tools/include/linux/gfp_types.h |   7 -
>>  9 files changed, 288 insertions(+), 202 deletions(-)
>> ---
>> base-commit: 500b2c9755301742bdbb61249511ac11a4665dae
>> change-id: 20260601-slab_alloc_flags-25c782b0c57c
>> 
>> Best regards,
>> --  
>> Vlastimil Babka (SUSE) <vbabka@kernel.org>
> 


