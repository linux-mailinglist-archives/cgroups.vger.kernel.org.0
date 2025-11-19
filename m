Return-Path: <cgroups+bounces-12079-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 845BFC6CF85
	for <lists+cgroups@lfdr.de>; Wed, 19 Nov 2025 07:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B57B83441AA
	for <lists+cgroups@lfdr.de>; Wed, 19 Nov 2025 06:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9F5318133;
	Wed, 19 Nov 2025 06:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m8baIxmI"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A07272E63;
	Wed, 19 Nov 2025 06:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763534513; cv=none; b=StipNwahljMOlQ7uhLL/NaK/o1pMD7cH4bATXa6gUbom5aHYcsg5jjP3l0ndjdzRuyTqoEWchXHQOLeQzc1pKHTkLSmbsBPc9vIyaq0swIUsF7rhLyA3X63yEXPm8Xn4NUWvZd729EGWlkW0P9gTv811smkWXY4ghUKf/KGdk3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763534513; c=relaxed/simple;
	bh=mNV+aJIeDcgd/U6ctkCqlc64C1l0+xuJne7AH00q7yQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iL//Y5mPsC4M3sXOAErYNsWTUPxAH55eGhO5u6t/d2Hrs4nAqMW7ZZo6/yTSUp7MxkXny7xfQcUPrtPZ2PKR9hjRGP1jKlMa8c12VAsdcxXyH2sKTFZ19xw2ivb/ctodgbyVHjJgL2gBCs+7FHjdgXp12le9DQhhKAEuKbnWOA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m8baIxmI; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e323f903-d366-41c0-a20e-6d743865d984@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763534508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tF+DaTtHEKwuWpwk2dCWacezPhWqck0SR+2rBvFOiOI=;
	b=m8baIxmI7QMgoHM7OyRydLDKuOkXFxqDUbkf6IAICv71rdpk5TnrHK6y1bmuGu7FtOzyvI
	/EyLsvriaV6pgXd8TI7njevCzDSFezw8k5asnaayRJOzSzFpUh4dUDwbgYnd2GyzWY14dQ
	9M9Yji7LwyvLUz/9QDvc7ArkVkKWUL8=
Date: Wed, 19 Nov 2025 14:40:44 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 06/26] mm: memcontrol: return root object cgroup for
 root memory cgroup
To: Harry Yoo <harry.yoo@oracle.com>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 david@redhat.com, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>,
 Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1761658310.git.zhengqi.arch@bytedance.com>
 <5e9743f291e7ca7b8f052775e993090ed66cfa80.1761658310.git.zhengqi.arch@bytedance.com>
 <aRroO9ypxvHsAjug@hyeyoo> <e5edc1b6-4c63-42c7-91ab-f1a28cb0b50d@linux.dev>
 <aRxingFU0OKRnv8E@hyeyoo>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <aRxingFU0OKRnv8E@hyeyoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 11/18/25 8:12 PM, Harry Yoo wrote:
> On Tue, Nov 18, 2025 at 07:28:41PM +0800, Qi Zheng wrote:
>> Hi Harry,
>>
>> On 11/17/25 5:17 PM, Harry Yoo wrote:
>>> On Tue, Oct 28, 2025 at 09:58:19PM +0800, Qi Zheng wrote:
>>>> From: Muchun Song <songmuchun@bytedance.com>
>>>>
>>>> Memory cgroup functions such as get_mem_cgroup_from_folio() and
>>>> get_mem_cgroup_from_mm() return a valid memory cgroup pointer,
>>>> even for the root memory cgroup. In contrast, the situation for
>>>> object cgroups has been different.
>>>>
>>>> Previously, the root object cgroup couldn't be returned because
>>>> it didn't exist. Now that a valid root object cgroup exists, for
>>>> the sake of consistency, it's necessary to align the behavior of
>>>> object-cgroup-related operations with that of memory cgroup APIs.
>>>>
>>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>>> ---
>>>>    include/linux/memcontrol.h | 29 +++++++++++++++++-------
>>>>    mm/memcontrol.c            | 45 ++++++++++++++++++++------------------
>>>>    mm/percpu.c                |  2 +-
>>>>    3 files changed, 46 insertions(+), 30 deletions(-)
>>>>
>>>> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>>>> index 6185d8399a54e..9fdbd4970021d 100644
>>>> --- a/include/linux/memcontrol.h
>>>> +++ b/include/linux/memcontrol.h
>>>> @@ -332,6 +332,7 @@ struct mem_cgroup {
>>>>    #define MEMCG_CHARGE_BATCH 64U
>>>>    extern struct mem_cgroup *root_mem_cgroup;
>>>> +extern struct obj_cgroup *root_obj_cgroup;
>>>>    enum page_memcg_data_flags {
>>>>    	/* page->memcg_data is a pointer to an slabobj_ext vector */
>>>> @@ -549,6 +550,11 @@ static inline bool mem_cgroup_is_root(struct mem_cgroup *memcg)
>>>>    	return (memcg == root_mem_cgroup);
>>>>    }
>>>> +static inline bool obj_cgroup_is_root(const struct obj_cgroup *objcg)
>>>> +{
>>>> +	return objcg == root_obj_cgroup;
>>>> +}
>>>
>>> After reparenting, an objcg may satisfy objcg->memcg == root_mem_cgroup
>>> while objcg != root_obj_cgroup. Should they be considered as
>>> root objcgs?
>>
>> Indeed, it's pointless to charge to root_mem_cgroup (objcg->memcg).
>>
>> So it should be:
>>
>> static inline bool obj_cgroup_is_root(const struct obj_cgroup *objcg)
>> {
>> 	return (objcg == root_obj_cgroup) || (objcg->memcg == root_mem_cgroup);
>> }
>>
> 
> Thanks and tomorrow I'll try to review if will be correct ;)
> 
>>>>    static inline bool mem_cgroup_disabled(void)
>>>>    {
>>>>    	return !cgroup_subsys_enabled(memory_cgrp_subsys);
>>>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>>>> index 2afd7f99ca101..d484b632c790f 100644
>>>> --- a/mm/memcontrol.c
>>>> +++ b/mm/memcontrol.c
>>>> @@ -2871,7 +2865,7 @@ int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order)
>>>>    	int ret = 0;
>>>>    	objcg = current_obj_cgroup();
>>>> -	if (objcg) {
>>>> +	if (!obj_cgroup_is_root(objcg)) {
>>>
>>> Now that we support the page and slab allocators support allocating memory
>>> in NMI contexts (on some archs), current_obj_cgroup() can return NULL
>>> if (IS_ENABLED(CONFIG_MEMCG_NMI_UNSAFE) && in_nmi()) returns true
>>> (then it leads to a NULL-pointer-deref bug).
>>>
>>> But IIUC this is applied to kmem charging only (as they use this_cpu ops
>>> for stats update), and we don't have to apply the same restriction to
>>> charging LRU pages with objcg.
>>>
>>> Maybe Shakeel has more insight on this.
>>>
>>> Link: https://lore.kernel.org/all/20250519063142.111219-1-shakeel.butt@linux.dev
>>
>> Thanks for this information, and it seems there's nothing wrong here.
> 
> I mean at least we should not introduce a NULL-pointer-deref bug in
> __memcg_kmem_charge_page(), by assuming objcg returned by
> current_obj_cgroup() is non-NULL?
> 
> 1. Someone allocates non-slab kmem in an NMI context (in_nmi() == true),
>     calling __memcg_kmem_charge_page().
> 2. current_obj_cgruop() returns NULL because the architectures
>     has CONFIG_MEMCG_NMI_UNSAFE and it's in an NMI context.
> 3. obj_cgroup_is_root() returns false since
>     objcg (NULL) != root_obj_cgroup
> 4. we pass NULL to obj_cgroup_charge_pages().
> 5. obj_cgroup_charge_pages() calls get_mem_cgroup_from_objcg(),
>     dereference objcg->memcg (! a NULL-pointer-deref).

Oh, indeed. After adding MEMCG_NMI_UNSAFE, we should first check
if objcg is NULL.

Thanks!

> 
>> Thanks,
>> Qi
>>
>>>
> 


