Return-Path: <cgroups+bounces-16798-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id o7lSG8IgKWqBRAMAu9opvQ
	(envelope-from <cgroups+bounces-16798-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 10:30:58 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8BD6672E2
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 10:30:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=V5VqP0g0;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16798-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-16798-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F15353014680
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 08:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741A83ACF1D;
	Wed, 10 Jun 2026 08:30:42 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD26A3ACEE0
	for <cgroups@vger.kernel.org>; Wed, 10 Jun 2026 08:30:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781080242; cv=none; b=BjNE8Tf+gwtPzSuttPCtynadA9cDUQmF7e1kCVimg7ErNyddG77y8tcqWBg39XHTf7UJDzN/H0h6r0eqDw9zPBdHc1A6wqh3WWrw1oF8t3TaCgCzuzCT5nfsLA7XXH0FBxPSQ3jxp3ytbfINkIxFTLLFDD33w0F3XagXSi2Pl28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781080242; c=relaxed/simple;
	bh=cu42RRbLiM8L0VLdlcCAQdo8B2+vi35iBa5fbg6t6o8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bhm/hhnlLx1tQAEZR+xhdowHFGLWiJr3Eyw91sCp9nQewqI/XwXuQy0kmT2KwqtWLBOag/DoC0Wzc1DhctICZ7kucIg5vaesHefbvetskdbxjP4L2LjcpCZ9j11Cr21JWhHSdgMW9ugO7gERSZFliOouc/lJPzHRh9uDUC9mPI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V5VqP0g0; arc=none smtp.client-ip=91.218.175.183
Message-ID: <104171fa-6a1c-43b0-a6c4-f71f54129d88@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781080237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UyYAKG2WDoLAbE1LWkheGa6RjXvXcPLoe7XXaMCnGK8=;
	b=V5VqP0g0/2QVtPLYQCSiV719xuD7bOb3CpvhN+0IMKIh/j5Y/g3qYhAVH2bW/olN69GYBR
	EJuAtb1QASKglqFL4XeS/eWvX0P+oCQWoqP2kbIJVGWzUcxp7YJYLzyTuWA//bCOuiJwNU
	3qIkjmrDd9VEF33VtktPcvQCTv2VPks=
Date: Wed, 10 Jun 2026 16:29:53 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RFC 00/15] mm/slab: introduce alloc_flags and
 slab_alloc_context
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
 Usama Arif <usama.arif@linux.dev>
Cc: Harry Yoo <harry@kernel.org>, Hao Li <hao.li@linux.dev>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Suren Baghdasaryan <surenb@google.com>, Alexei Starovoitov <ast@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <20260609133534.3548059-1-usama.arif@linux.dev>
 <fe1bd73b-d956-442f-8c4f-f5f62587346e@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <fe1bd73b-d956-442f-8c4f-f5f62587346e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vbabka@kernel.org,m:usama.arif@linux.dev,m:harry@kernel.org,m:hao.li@linux.dev,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:surenb@google.com,m:ast@kernel.org,m:akpm@linux-foundation.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:shakeel.butt@linux.dev,m:glider@google.com,m:elver@google.com,m:dvyukov@google.com,m:kasan-dev@googlegroups.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[hao.ge@linux.dev,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-16798-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hao.ge@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AF8BD6672E2

Hi Vlastimil and Usama

On 2026/6/9 22:28, Vlastimil Babka (SUSE) wrote:
> On 6/9/26 15:35, Usama Arif wrote:
>> On Tue, 09 Jun 2026 11:17:45 +0200 "Vlastimil Babka (SUSE)"<vbabka@kernel.org>  wrote:
>>
>>> This series is based on slab/for-next. If all goes well, it would
>>> hopefully go to slab/for-next soon after the 7.2 merge window, so any
>>> other work can be based on it to avoid conflicts, as it touches a lot
>>> parts of slab.
>>>
>>> Git:https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=b4/slab_alloc_flags
>>>
>>> The slab implementation currently relies on gfp flags to convey
>>> some context information internally:
>>>
>>> - The absence of both __GFP_RECLAIM flags is interpreted as "cannot spin
>>>    on locks", and intended to be used by kmalloc_nolock(). But false
>>>    positives are possible e.g. during early boot where gfp_allowed_mask
>>>    clears __GFP_RECLAIM from all allocations. This leads to unnecessary
>>>    allocation failures and workarounds such as fd3634312a04 ("debugobject:
>>>    Make it work with deferred page initialization - again").
>>>
>>> - __GFP_NO_OBJ_EXT exists and takes up valuable bit in the gfp flags
>>>    space, only to prevent recursive kmalloc() allocations for obj_ext
>>>    arrays and sheaves.
>>>
>> Hello Valstimil!
>>
>> I think memory allocation profiling uses __GFP_NO_OBJ_EXT, and I dont see
>> it being removed in the series (hopefully I didnt miss it).
>>
>> Adding Hao Ge in CC who did this in the commit:
>> mm/alloc_tag: replace fixed-size early PFN array with dynamic linked list


Thanks for the CC. I'm now aware of this.


> Thanks for the heads up. I missed it because my series is based on
> slab/for-next and that commit is in mm-unstable. My patch 15 actually
> modifies the TODO comment that is meanwhile resolved by Hao Ge's patch.
>
> Which means my patch 15/15 can't be used as-is, and at worst I will drop it.
> But I'd encourage Hao Ge with Suren to find some way to avoid the gfp flag
> usage too, because it's now quite a niche use case (preventing false
> positive CONFIG_MEM_ALLOC_PROFILING_DEBUG warnings, IIUC?) to take a
> valuable gfp flag bit, IMHO.


I previously used __GFP_NO_OBJ_EXT because it serves the same purpose as 
in slab.

We use it here to prevent recursion within the page allocator.

I hadn't anticipated that __GFP_NO_OBJ_EXT would be removed so soon.

I agree with you. Since slab no longer uses it, retaining this GFP flag 
solely for debug is indeed costly.

I've also been thinking about possible solutions today. Since we are 
working in the page allocation path,

we need to take various race conditions into consideration.

For instance, what if an interrupt is triggered inside page_alloc, which 
then invokes page_alloc again?

I'm not sure if such a scenario exists in practice, but I believe we 
still need to account for it.

I would highly appreciate it if anyone could share their ideas.

I've made a note of this.

Would it make sense to hold off on merging patch 15/15 for now?

We can always include it in a later cycle once we have a proper 
replacement for the

memory allocation profilingside. Thanks Best Regards Hao

>>> The page allocator uses its internal alloc_flags to convey various
>>> context information, including ALLOC_TRYLOCK (meaning "cannot spin").
>>> This series copies that concept for the slab allocator, with its own
>>> slab-specific internal flags:
>>>
>>> - SLAB_ALLOC_DEFAULT - no extra flags (the value is 0), but explicit
>>> - SLAB_ALLOC_TRYLOCK - do not spin on locks (used by kmalloc_nolock())
>>> - SLAB_ALLOC_NEW_SLAB - replacing existing 'bool new_slab' parameter
>>> 			for allocating obj_ext arrays
>>> - SLAB_ALLOC_NO_RECURSE - replacing usage of __GFP_NO_OBJ_EXT
>>>
>>> To reduce the amount of parameters in various internal functions, we
>>> additionally introduce slab_alloc_context (also inspired by page
>>> allocator's alloc_context) for passing a number of existing arguments
>>> and the new alloc_flags:
>>>
>>> /* Structure holding extra parameters for slab allocations */
>>> struct slab_alloc_context {
>>> 	unsigned long caller_addr;
>>> 	unsigned long orig_size;
>>> 	unsigned int alloc_flags;
>>> 	struct list_lru *lru;
>>> };
>>>
>>> This also replaces the existing struct partial_context.
>>>
>>> The last necessary piece is kmalloc_flags() which can take the
>>> alloc_flags in addition to gfp flags and is intended for the recursive
>>> allocations of sheaves and obj_ext arrays, so that both
>>> SLAB_ALLOC_TRYLOCK and SLAB_ALLOC_NO_RECURSE can be communicated.
>>> Internally it decides between kmalloc_nolock() and normal kmalloc()
>>> depending SLAB_ALLOC_TRYLOCK.
>>>
>>> The rest of the series is gradually expanding the usage of both
>>> alloc_flags and slab_alloc_context as necessary, with bits of
>>> refactoring. Then, __GFP_NO_OBJ_EXT is removed completely.
>>>
>>> Note that some usage of gfpflags_allow_spinning() relying on absence of
>>> __GFP_RECLAIM remains outside of slab (and page allocator) in memcg,
>>> page_owner and stackdepot code. These can thus yield false-positive
>>> decisions that spinning is not allowed, but should not result in
>>> important allocations failing anymore.
>>>
>>> Signed-off-by: Vlastimil Babka (SUSE)<vbabka@kernel.org>
>>> ---
>>> Vlastimil Babka (SUSE) (15):
>>>        mm/slab: always zero only requested size on alloc
>>>        mm/slab: stop inlining __slab_alloc_node()
>>>        mm/slab: introduce slab_alloc_context
>>>        mm/slab: introduce alloc_flags and SLAB_ALLOC_TRYLOCK
>>>        mm/slab: add alloc_flags to slab_alloc_context
>>>        mm/slab: replace struct partial_context with slab_alloc_context
>>>        mm/slab: pass alloc_flags to new slab allocation
>>>        mm/slab: pass alloc_flags through slab_post_alloc_hook() chain
>>>        mm/slab: replace slab_alloc_node() parameters with slab_alloc_context
>>>        mm/slab: allow kmem_cache_alloc_bulk() with any gfp flags
>>>        mm/slab: pass slab_alloc_context to __do_kmalloc_node()
>>>        mm/slab: introduce kmalloc_flags()
>>>        mm/slab: remove __GFP_NO_OBJ_EXT usage from alloc_slab_obj_exts()
>>>        mm/slab: replace __GFP_NO_OBJ_EXT with SLAB_ALLOC_NO_RECURSE for sheaves
>>>        mm: remove the __GFP_NO_OBJ_EXT flag
>>>
>>>   include/linux/gfp_types.h       |   7 -
>>>   include/linux/slab.h            |  14 +-
>>>   include/trace/events/mmflags.h  |  10 +-
>>>   lib/alloc_tag.c                 |   2 +-
>>>   mm/kfence/core.c                |   6 +-
>>>   mm/memcontrol.c                 |   5 +-
>>>   mm/slab.h                       |  16 +-
>>>   mm/slub.c                       | 423 ++++++++++++++++++++++++----------------
>>>   tools/include/linux/gfp_types.h |   7 -
>>>   9 files changed, 288 insertions(+), 202 deletions(-)
>>> ---
>>> base-commit: 500b2c9755301742bdbb61249511ac11a4665dae
>>> change-id: 20260601-slab_alloc_flags-25c782b0c57c
>>>
>>> Best regards,
>>> --
>>> Vlastimil Babka (SUSE)<vbabka@kernel.org>

