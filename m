Return-Path: <cgroups+bounces-10774-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3F2BDE400
	for <lists+cgroups@lfdr.de>; Wed, 15 Oct 2025 13:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3DF7A4F0702
	for <lists+cgroups@lfdr.de>; Wed, 15 Oct 2025 11:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81B631A811;
	Wed, 15 Oct 2025 11:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Fw2riVTi"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6441530DD15
	for <cgroups@vger.kernel.org>; Wed, 15 Oct 2025 11:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760527443; cv=none; b=gKUJZXuUBAQF6FCbr4Ctxs0vLR973l5NDwba0XH/pPt73pHfNdaIzTYRPbaku/pVpNBw/LIBICXWA1TTiidfnvUHo4BHS7wayrBmnbnwWVyyZui0jQqDE0IxxEjgXCyGFCXTvzv6RoniCA+RkZkMTO1zb1PKAXPGVE6MYU9WkZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760527443; c=relaxed/simple;
	bh=HGc3PIJ9QBWR+uUM0HrnT2SCZ0aori4/i8KigQVlOHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ss4fluKOemdK7AUmvogY3jOPcyy4ALjTKVAFvqlsjkOrdgBc8VK/mC1fi8GaQ5FJcsVPX+Ae5sEuTMxBGZEKLMewIj+6RjpkHibdVZPj0IKqfwBUzX4SQmsoHXd/MrmyrJgs//+W6ezooD2PYlrzdy798nAflOk5gqUbHOCElL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Fw2riVTi; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8f161ba2-6d0f-4dbb-85bc-ab4bff04f24a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760527439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IwvFeOSawJO8ToN1vYMfeDPUih6SozsleVrhFjkq2dQ=;
	b=Fw2riVTiTN8NodX907zI5PJGFL25SWKPdtF7d9Qo0gNzBF6Xo4g0tGzuRY6HQhxF2hV1Ny
	Vu8jgIE07yH/sMViD71uC8imi8NU+B4S2POM/Kd+ivseb9OUbXKPZeDM14CVQTQw+N0Fm2
	u2AQf7wk+EWssayU5cjF+TS/W0ngv+Q=
Date: Wed, 15 Oct 2025 19:22:59 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3] slab: Add check for memcg_data != OBJEXTS_ALLOC_FAIL
 in folio_memcg_kmem
To: Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, Hao Ge <gehao@kylinos.cn>
References: <20251014152751.499376-1-hao.ge@linux.dev>
 <CAJuCfpGBxUmvWoe2xv2-bsF+TY4fK-m1-Z_E3OcyTiSYz5KeAA@mail.gmail.com>
 <aO9okBEZiA4pCNku@hyeyoo> <c07838ca-4e6e-4837-b99f-09fd44c7801c@suse.cz>
 <aO93GHNR_32-Pmom@hyeyoo> <6194b6ab-6b43-468d-ba78-a95594c48798@suse.cz>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <6194b6ab-6b43-468d-ba78-a95594c48798@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Vlastimil and Harry


  Thank you for your professional guidance.


On 2025/10/15 18:37, Vlastimil Babka wrote:
> On 10/15/25 12:27, Harry Yoo wrote:
>> On Wed, Oct 15, 2025 at 11:54:18AM +0200, Vlastimil Babka wrote:
>>> On 10/15/25 11:25, Harry Yoo wrote:
>>>> On Tue, Oct 14, 2025 at 09:12:43AM -0700, Suren Baghdasaryan wrote:
>>>>> On Tue, Oct 14, 2025 at 8:28 AM Hao Ge <hao.ge@linux.dev> wrote:
>>>>>> From: Hao Ge <gehao@kylinos.cn>
>>>>>>
>>>>>> Since OBJEXTS_ALLOC_FAIL and MEMCG_DATA_OBJEXTS currently share
>>>>>> the same bit position, we cannot determine whether memcg_data still
>>>>>> points to the slabobj_ext vector simply by checking
>>>>>> folio->memcg_data & MEMCG_DATA_OBJEXTS.
>>>>>>
>>>>>> If obj_exts allocation failed, slab->obj_exts is set to OBJEXTS_ALLOC_FAIL,
>>>>>> and during the release of the associated folio, the BUG check is triggered
>>>>>> because it was mistakenly assumed that a valid folio->memcg_data
>>>>>> was not cleared before freeing the folio.
>>>> nit: yesterday I was confused that this is sanity checks in buddy complaining
>>>> folio->memcg_data not being cleared, but it's actually folio_memcg_kmem()
>>>> complaining that MEMCG_OBJEXTS_DATA flag is set on non-slab folios (in
>>>> free_pages_prepare(), if PageMemcgKmem(page) -> __memcg_kmem_uncharge_page()))
>>>> So the paragraph above should be updated?

Hi Harry

We don't need to update the paragraph.

We did have cgroups running at that time, but they had no connection to 
this page.

The entry  "[ 7108.343500] memcg:1" can also be seen in the v1 logs,

Therefore, the situation at that time was indeed consistent with what I 
described above.

As discussed below, this only occurs because the OBJEXTS_ALLOC_FAIL flag

was not cleared when the slab was about to be freed.

Or have I missed anything?


>>>>
>>>> And as a side question, we clear slab->obj_exts when freeing obj_ext array,
>>>> but don't clear OBJEXTS_ALLOC_FAIL when freeing a slab? That's not good.
>>> Hm great point. We should rather make sure it's cleared always, instead of
>>> adjusting the debugging check, which shouldn't be then necessary, right?
>> Yeah folio_memcg_kmem() isn't supposed to be called on slabs anyway
>> (it's not a slab at the time we free it to buddy), so we don't have to
>> adjust the debug check.
> Great. Hao Ge, can you please send v4 that instead of adjusting the
> VM_BUG_ON modifies free_slab_obj_exts() to always clear slab->obj_exts? Thanks!


Okay, I will send v4 as soon as possible.


Thanks

Best Regards

Hao

>
>>>>>> So let's check for memcg_data != OBJEXTS_ALLOC_FAIL in folio_memcg_kmem.
>>>>>>
>>>>>> Fixes: 7612833192d5 ("slab: Reuse first bit for OBJEXTS_ALLOC_FAIL")
>>>>>> Suggested-by: Harry Yoo <harry.yoo@oracle.com>
>>>>>> Signed-off-by: Hao Ge <gehao@kylinos.cn>
>>>>> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
>>>>>
>>>>> nit: I think it would be helpful if the changelog explained why we
>>>>> need the additional check. We can have the same bit set in two
>>>>> different situations:
>>>>> 1. object extension vector allocation failure;
>>>>> 2. memcg_data pointing to a valid mem_cgroup.
>>>>> To distinguish between them, we need to check not only the bit itself
>>>>> but also the rest of this field. If the rest is NULL, we have case 1,
>>>>> otherwise case 2.
>>>> Agreed.
>>>>
>>>> In general LGTM,
>>>> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
>>>>
>>>> By the way, maybe it'd be nice to introduce a new helper function that
>>>> properly checks MEMCG_DATA_OBJEXTS flag.
>>> I thought so too at first...
>>>
>>>>> ~/slab (slab/for-next-fixes)> git grep -n MEMCG_DATA_OBJEXTS
>>>>> include/linux/memcontrol.h:337:	MEMCG_DATA_OBJEXTS = (1UL << 0),
>>>>> include/linux/memcontrol.h:344:#define __OBJEXTS_ALLOC_FAIL	MEMCG_DATA_OBJEXTS
>>>>> include/linux/memcontrol.h:358:	 * MEMCG_DATA_OBJEXTS.
>>>>> include/linux/memcontrol.h:400:	VM_BUG_ON_FOLIO(memcg_data & MEMCG_DATA_OBJEXTS, folio);
>>>>> include/linux/memcontrol.h:421:	VM_BUG_ON_FOLIO(memcg_data & MEMCG_DATA_OBJEXTS, folio);
>>>> these two,
>>>>
>>>>> include/linux/memcontrol.h:492:	if (memcg_data & MEMCG_DATA_OBJEXTS)
>>>> this,
>>>>
>>>>> include/linux/memcontrol.h:538:			(folio->memcg_data & MEMCG_DATA_OBJEXTS),
>>>>> include/linux/memcontrol.h:1491: * if MEMCG_DATA_OBJEXTS is set.
>>>>> mm/kfence/core.c:624:				 MEMCG_DATA_OBJEXTS;
>>>>> mm/page_owner.c:513:	if (memcg_data & MEMCG_DATA_OBJEXTS)
>>>> this,
>>>>
>>>>> mm/slab.h:541:	 * MEMCG_DATA_OBJEXTS bit set or be equal to OBJEXTS_ALLOC_FAIL.
>>>>> mm/slab.h:543:	VM_BUG_ON_PAGE(obj_exts && !(obj_exts & MEMCG_DATA_OBJEXTS) &&
>>>>> mm/slub.c:2137:	new_exts |= MEMCG_DATA_OBJEXTS;
>>>>> tools/mm/show_page_info.py:55:        MEMCG_DATA_OBJEXTS = prog.constant("MEMCG_DATA_OBJEXTS").value_()
>>>>> tools/mm/show_page_info.py:59:        if memcg_data & MEMCG_DATA_OBJEXTS:
>>>> and this do not look good.
>>>>
>>>> I mean technically they are fine since OBJEXTS_ALLOC_FAIL is set on
>>>> slabs only, but that's just a coincidence.
>>> And checked the the other debugging checks too. But then thought it's better
>>> that if these are not expected to see slabs, then they should not be
>>> adjusted. I don't see it as a coincidence but as intention to keep it slab
>>> specific. It will be also more future proof for the upcoming separation of
>>> struct slab from struct page.
>> Then we're intentionally using (folio->memcg_data & MEMCG_DATA_OBJEXTS) check
>> as a way to determine whether the folio is a slab (either slabobj_ext array
>> allocation succeeded or failed).
>>
>> That makes sense to me!
>>
>>>>>> ---
>>>>>> v3: Simplify the solution, per Harry's suggestion in the v1 comments
>>>>>>      Add Suggested-by: Harry Yoo <harry.yoo@oracle.com>
>>>>>> ---
>>>>>>   include/linux/memcontrol.h | 4 +++-
>>>>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>>>>>> index 873e510d6f8d..7ed15f858dc4 100644
>>>>>> --- a/include/linux/memcontrol.h
>>>>>> +++ b/include/linux/memcontrol.h
>>>>>> @@ -534,7 +534,9 @@ static inline struct mem_cgroup *get_mem_cgroup_from_objcg(struct obj_cgroup *ob
>>>>>>   static inline bool folio_memcg_kmem(struct folio *folio)
>>>>>>   {
>>>>>>          VM_BUG_ON_PGFLAGS(PageTail(&folio->page), &folio->page);
>>>>>> -       VM_BUG_ON_FOLIO(folio->memcg_data & MEMCG_DATA_OBJEXTS, folio);
>>>>>> +       VM_BUG_ON_FOLIO((folio->memcg_data != OBJEXTS_ALLOC_FAIL) &&
>>>>>> +                       (folio->memcg_data & MEMCG_DATA_OBJEXTS),
>>>>>> +                       folio);
>>>>>>          return folio->memcg_data & MEMCG_DATA_KMEM;
>>>>>>   }
>>>>>>
>>>>>> --
>>>>>> 2.25.1

