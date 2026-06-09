Return-Path: <cgroups+bounces-16783-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mw/QAkElKGok/AIAu9opvQ
	(envelope-from <cgroups+bounces-16783-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 09 Jun 2026 16:37:53 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67637661355
	for <lists+cgroups@lfdr.de>; Tue, 09 Jun 2026 16:37:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=mbwVx9+Z;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16783-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16783-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9671F311267E
	for <lists+cgroups@lfdr.de>; Tue,  9 Jun 2026 14:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7B6343897;
	Tue,  9 Jun 2026 14:28:38 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852EC342173;
	Tue,  9 Jun 2026 14:28:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015318; cv=none; b=V76r74RwwaQsck3ojoT40czZfjhEQ2DQ35ZlA8lDYOOOBhw0LD3ZuaxO81DUX0p3uHCMy9uM8RhdwHd/eSp/qlvx5ZN/xdLtmH99RuqfG1B3Yv9sPw/KCIu5NKm2dLFsnphOdPv7TYka00F4OGLIGDqATyZ0H/8bBQg/kiGDW+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015318; c=relaxed/simple;
	bh=uB6FI5sHv9duj2rUMo6jfNMlJ5jDCGMOWn62ZKD+INQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r0z30iMqNDFia7+oKetYNL8aPdpTDMWq11T3n2KGh+okXbnhBcpm7JMjfaNWCcwOjKwbI/B7ELxsJyWl7gwoW+bg5Exayd+eiADleUOdvWVYPTXZxk/toxQcSawsqvswkf6YY3C1dzjAioy0wfmDHFJYk6PvJ8VV0DVSZVlVArA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mbwVx9+Z; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C3ED1F00893;
	Tue,  9 Jun 2026 14:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781015317;
	bh=CY2fUp5PiAtg9rniwGH2er3NWoe7Vb+yrNQdtxoj72I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=mbwVx9+Z463LZ40UMQRWkQlL0L/+2YidxpL9w4bR8UzoDWOVy3aJTaH5pM8EsZGjT
	 VCjkxPahOd3Sp/KgsS5f2i6/X2u9vnl4gxm6hnGbIdaoEO41jBjmY6FVK0VA9zu/gD
	 PBC54hhYy6a3GYeXaA+n1X9XxTTj/y/s1wfWEbZAL1+v+M576tyY53rW1srzxG6jDg
	 DDEgmwyGIdjhsQmKGlXQ7zFzf6xGL77VvSFTgFPMd+He+CfxpSBnabQs/vFqq4Z5UN
	 2KMfpOgKZM1FfIEQBwn0KACrJrn1fF/iaKFlKG2RQ1htzlSJmGlDrOUePY5AKEHxjG
	 ERvXCo3+dTlsg==
Message-ID: <fe1bd73b-d956-442f-8c4f-f5f62587346e@kernel.org>
Date: Tue, 9 Jun 2026 16:28:31 +0200
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
To: Usama Arif <usama.arif@linux.dev>
Cc: Harry Yoo <harry@kernel.org>, hao.ge@linux.dev, Hao Li
 <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
 David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Suren Baghdasaryan <surenb@google.com>, Alexei Starovoitov <ast@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <20260609133534.3548059-1-usama.arif@linux.dev>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <20260609133534.3548059-1-usama.arif@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:usama.arif@linux.dev,m:harry@kernel.org,m:hao.ge@linux.dev,m:hao.li@linux.dev,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:surenb@google.com,m:ast@kernel.org,m:akpm@linux-foundation.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:shakeel.butt@linux.dev,m:glider@google.com,m:elver@google.com,m:dvyukov@google.com,m:kasan-dev@googlegroups.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[vbabka@kernel.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-16783-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 67637661355

On 6/9/26 15:35, Usama Arif wrote:
> On Tue, 09 Jun 2026 11:17:45 +0200 "Vlastimil Babka (SUSE)" <vbabka@kernel.org> wrote:
> 
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
>> 
> 
> Hello Valstimil!
> 
> I think memory allocation profiling uses __GFP_NO_OBJ_EXT, and I dont see
> it being removed in the series (hopefully I didnt miss it).
> 
> Adding Hao Ge in CC who did this in the commit:
> mm/alloc_tag: replace fixed-size early PFN array with dynamic linked list

Thanks for the heads up. I missed it because my series is based on
slab/for-next and that commit is in mm-unstable. My patch 15 actually
modifies the TODO comment that is meanwhile resolved by Hao Ge's patch.

Which means my patch 15/15 can't be used as-is, and at worst I will drop it.
But I'd encourage Hao Ge with Suren to find some way to avoid the gfp flag
usage too, because it's now quite a niche use case (preventing false
positive CONFIG_MEM_ALLOC_PROFILING_DEBUG warnings, IIUC?) to take a
valuable gfp flag bit, IMHO.

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
>> 
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
>> 
>> 


