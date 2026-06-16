Return-Path: <cgroups+bounces-16992-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eUdAO+TxMGqLZAUAu9opvQ
	(envelope-from <cgroups+bounces-16992-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 16 Jun 2026 08:49:08 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E9668CA3F
	for <lists+cgroups@lfdr.de>; Tue, 16 Jun 2026 08:49:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b="MdK/JqCQ";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16992-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16992-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF9213077AD0
	for <lists+cgroups@lfdr.de>; Tue, 16 Jun 2026 06:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A99A2E6116;
	Tue, 16 Jun 2026 06:48:40 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3848030568D
	for <cgroups@vger.kernel.org>; Tue, 16 Jun 2026 06:48:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781592519; cv=none; b=RL1IxDLMLrVBMx5q4s/K0YaQ0CzlDUpDSUggYJFO/KYpAgw+5GD0WWyWHDSEtJnfxUoTCHNbgW29O+lyy/VZJK0/Clv6d6Qs6HcJJeL/ZT2RYrzNd84SiHZbP+/+PL5vbroB2ptE6yMuhYnCN+ch9ZZbOS/na9Bms52JGcyP088=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781592519; c=relaxed/simple;
	bh=yeZHRnVAYWPkBzMIpgiJh2j36EusBJ2gbiAHmLLv79c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rq2difXBPyzmN8SsJRPBcmL+fb1W8ZdnqEPPFaS6xUkZCKIa0WmifqlmSazA0zGMXPEOeIiqn+bCNbfvvoRukJ6fuNH5xHTiHv8N5BK4j2iSgg8StvxfxZCPH6R8qvTrJporUIZuJ6KihsVedtOuBaUlk/YBmNaSvxIZ9Yd7Yc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MdK/JqCQ; arc=none smtp.client-ip=91.218.175.171
Message-ID: <3632c317-dc9d-44b9-ac42-6c425fa30c85@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781592516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xHdtkkItU3gH8oHxOsFbFsxlcX/uGhOaYYC6rlwBfEw=;
	b=MdK/JqCQz9lCRylJZZHD5mXiZT/k6TYe39nKy2YqkVsOKvFJn/pFKaGEuVST3+Wi0POHxm
	tcRwVMGm3alaJTwY1r3Yt2PX7Jrtv8K+Rv5C/sKDvnI94DkXjfaXJi1kIRX4lk6v9CkhBl
	HByQG2GlG78axVvNkVHujAATm7cnZHE=
Date: Tue, 16 Jun 2026 14:47:55 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 15/16] mm/slab: remove __GFP_NO_OBJ_EXT usage from
 alloc_slab_obj_exts()
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Hao Li <hao.li@linux.dev>
Cc: Harry Yoo <harry@kernel.org>, Christoph Lameter <cl@gentwo.org>,
 David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <20260610-slab_alloc_flags-v2-0-7190909db118@kernel.org>
 <20260610-slab_alloc_flags-v2-15-7190909db118@kernel.org>
 <aiurbPx1SISBarBy@fedora> <49f1bf1e-fcaf-48fa-a7b1-f8ee78b19762@kernel.org>
 <aivpob0Zgnbc4AG4@fedora>
 <CAJuCfpFNftMYw0XoHyN1QAWfm7NYmeuY1T_NGbYy8boGO48MOg@mail.gmail.com>
 <e17e628e-0633-4c5e-a9f9-ea68a4ca09df@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <e17e628e-0633-4c5e-a9f9-ea68a4ca09df@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vbabka@kernel.org,m:surenb@google.com,m:hao.li@linux.dev,m:harry@kernel.org,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:ast@kernel.org,m:akpm@linux-foundation.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:shakeel.butt@linux.dev,m:glider@google.com,m:elver@google.com,m:dvyukov@google.com,m:kasan-dev@googlegroups.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[hao.ge@linux.dev,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-16992-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:dkim,linux.dev:email,linux.dev:mid,linux.dev:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 57E9668CA3F

Hi Vlastimil and Suren

On 2026/6/15 19:11, Vlastimil Babka (SUSE) wrote:
> On 6/15/26 07:38, Suren Baghdasaryan wrote:
>> On Fri, Jun 12, 2026 at 4:30 AM Hao Li <hao.li@linux.dev> wrote:
>>> On Fri, Jun 12, 2026 at 12:17:45PM +0200, Vlastimil Babka (SUSE) wrote:
>>>> On 6/12/26 08:54, Hao Li wrote:
>>>>> On Wed, Jun 10, 2026 at 05:40:17PM +0200, Vlastimil Babka (SUSE) wrote:
>>>>>> __GFP_NO_OBJ_EXT has limited scope within the slab allocator itself and
>>>>>> gfp flags are a scarce resource, unlike slab's alloc_flags.
>>>>>>
>>>>>> Introduce SLAB_ALLOC_NO_RECURSE alloc flag that has the same intent as
>>>>>> __GFP_NO_OBJ_EXT but a more generic name, meaning that a kmalloc()
>>>>>> family function should not recurse into another kmalloc*() for the
>>>>>> purposes of allocating auxiliary structures (obj_ext arrays or sheaves).
>>>>>>
>>>>>> First, replace the __GFP_NO_OBJ_EXT for allocating obj_ext arrays in
>>>>>> alloc_slab_obj_exts(). Make use of the newly added kmalloc_flags()
>>>>>> function, where we can pass alloc_flags with SLAB_ALLOC_NO_RECURSE
>>>>>> added. This will also pass through SLAB_ALLOC_TRYLOCK so we don't need
>>>>>> to special case kmalloc_nolock() anymore.
>>>>>>
>>>>>> Note that until now the kmalloc_nolock() ignored the incoming gfp flags
>>>>>> and hardcoded __GFP_ZERO | __GFP_NO_OBJ_EXT. But it's correct to pass on
>>>>>> the incoming gfp flags (only augmented with __GFP_ZERO), because if
>>>>>> alloc_flags contain SLAB_ALLOC_TRYLOCK, the incoming gfp flags have to
>>>>>> be also compatible with it.
>>>>>>
>>>>>> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
>>>>>> ---
>>>>>>   mm/slab.h |  1 +
>>>>>>   mm/slub.c | 13 +++++--------
>>>>>>   2 files changed, 6 insertions(+), 8 deletions(-)
>>>>>>
>>>>>> diff --git a/mm/slab.h b/mm/slab.h
>>>>>> index 45bfcfb35a9c..509f330654b8 100644
>>>>>> --- a/mm/slab.h
>>>>>> +++ b/mm/slab.h
>>>>>> @@ -21,6 +21,7 @@
>>>>>>   #define SLAB_ALLOC_DEFAULT        0x00 /* no flags */
>>>>>>   #define SLAB_ALLOC_TRYLOCK        0x01 /* a kmalloc_nolock() allocation */
>>>>>>   #define SLAB_ALLOC_NEW_SLAB       0x02 /* a flag for alloc_slab_obj_exts() */
>>>>>> +#define SLAB_ALLOC_NO_RECURSE     0x04 /* prevent kmalloc() recursion */
>>>>>>
>>>>>>   static inline bool alloc_flags_allow_spinning(const unsigned int alloc_flags)
>>>>>>   {
>>>>>> diff --git a/mm/slub.c b/mm/slub.c
>>>>>> index cbb38bd01e46..7dfbd0251aa2 100644
>>>>>> --- a/mm/slub.c
>>>>>> +++ b/mm/slub.c
>>>>>> @@ -2167,15 +2167,12 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
>>>>>>
>>>>>>     gfp &= ~OBJCGS_CLEAR_MASK;
>>>>>>     /* Prevent recursive extension vector allocation */
>>>>>> -  gfp |= __GFP_NO_OBJ_EXT;
>>>>>> +  alloc_flags |= SLAB_ALLOC_NO_RECURSE;
>>>>>>
>>>>>>     sz = obj_exts_alloc_size(s, slab, gfp);
>>>>>>
>>>>> For the original calls to kmalloc_nolock and kmalloc_node, I notice a difference:
>>>>>
>>>>>> -  if (unlikely(!allow_spin))
>>>>>> -          vec = kmalloc_nolock(sz, __GFP_ZERO | __GFP_NO_OBJ_EXT,
>>>>>> -                               slab_nid(slab));
>>>>> kmalloc_nolock completely discarded `gfp` flags.
>>>>>
>>>>>> -  else
>>>>>> -          vec = kmalloc_node(sz, gfp | __GFP_ZERO, slab_nid(slab));
>>>>> while kmalloc_node preserved and passed it along.
>>>>>
>>>>>> +  /* This will use kmalloc_nolock() if alloc_flags say so */
>>>>>> +  vec = kmalloc_flags(sz, gfp | __GFP_ZERO, alloc_flags, slab_nid(slab));
>>>>> Now both paths are merged into kmalloc_flags, the gfp flags are
>>>>> unconditionally carried through. It seems this might carry some unwanted flags.
>>>>>
>>>>> I traced the call path and found that ___slab_alloc sets the __GFP_THISNODE
>>>>> for trynode_flags. If this flag propagates all the way into
>>>>> kmalloc_flags->...->__kmalloc_nolock_noprof, it will trigger the
>>>>> VM_WARN_ON_ONCE warning. Maybe we need to strip the original gfp if
>>>>> `!allow_spin`.
>>>> Thanks. This should do the job in a more generic way I hope?
>>>>
>>> Yeah, this is more elegant.
>>>
>>>> diff --git a/mm/slub.c b/mm/slub.c
>>>> index f9b8dc56bb57..0bf53f70c9be 100644
>>>> --- a/mm/slub.c
>>>> +++ b/mm/slub.c
>>>> @@ -2047,12 +2047,15 @@ static inline void dec_slabs_node(struct kmem_cache *s, int node,
>>>>   #endif /* CONFIG_SLUB_DEBUG */
>>>>
>>>>   /*
>>>> - * The allocated objcg pointers array is not accounted directly.
>>>> + * The allocated objcg pointers array or sheaf is not accounted directly.
>>>>    * Moreover, it should not come from DMA buffer and is not readily
>>>> - * reclaimable. So those GFP bits should be masked off.
>>>> + * reclaimable. Node restriction for the parent allocation also should
>>>> + * not apply to the slab's internal objects.
>>>> + * So those GFP bits should be masked off.
>>>>    */
>>>>   #define OBJCGS_CLEAR_MASK      (__GFP_DMA | __GFP_RECLAIMABLE | \
>>>> -                               __GFP_ACCOUNT | __GFP_NOFAIL)
>>>> +                               __GFP_ACCOUNT | __GFP_NOFAIL |
>>>> +                               __GFP_THISNODE )
>>> Good idea! Both code and comments make sense to me.
>> Makes sense. I see
>> https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git/log/?h=slab/for-next
>> already implementing this and also keeping __GFP_NO_OBJ_EXT and
>> SLAB_ALLOC_NO_RECURSE both used. That version looks good to me, so
>> I'll wait for v3.
> OK.
>
>> At the end of this series, we end up with no users of __GFP_NO_OBJ_EXT
>> but we still keep it defined. I'm guessing you leave it because of the
>> new patch [1] which aliases __GFP_NO_OBJ_EXT? I will have to make that
> Yeah.
>
>> mechanism work without a GFP flag, possibly using a similar approach.
>> CC'ing Hao Ge to be in the loop of these changes. I'll work with him
>> on aliminating that __GFP_NO_OBJ_EXT alias.

Glad to work with you on this.

I'm still figuring out a proper solution.

Once I make some progress, I'll start a separate mail

thread for this to avoid disturbing too many people.

Thanks

Best Regards

Hao

> Good, then we can remove the flag completely.
>
>> [1] https://lore.kernel.org/all/20260604024008.46592-1-hao.ge@linux.dev/
>>
>>>>   #ifdef CONFIG_SLAB_OBJ_EXT
>>>>
>>>>
>>> --
>>> Thanks,
>>> Hao

