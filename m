Return-Path: <cgroups+bounces-12081-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D38F6C6D361
	for <lists+cgroups@lfdr.de>; Wed, 19 Nov 2025 08:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E3F5535CED8
	for <lists+cgroups@lfdr.de>; Wed, 19 Nov 2025 07:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EFD2566E9;
	Wed, 19 Nov 2025 07:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l3SMmJV7"
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C03C2E0407
	for <cgroups@vger.kernel.org>; Wed, 19 Nov 2025 07:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763538189; cv=none; b=t5OVTjsUZxuikgYInhl3IJBKbmnLLZFCrlc7AEOJHvh5Fp1Fv+32JjYlJIiD3LLf/RnindrWB1iKFS9NPQ8NRqbk3eZFKMtmINiNpzx/N1u3M3YKBF2t4u4bwZbrsK7xZSUJ+n+IaA8QX8W6cFhKOp0qisgGTralVtO5nset1q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763538189; c=relaxed/simple;
	bh=vBlhwB9uH6UZ/hN/r8t5S1orQpa2gP51uqcQEPSBRZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AZqGowsWRjd1neUtU4fc9fT2gjDJmoPq1rN5Y/CBM24rzel3+m4PcG5aZdFX2GeaZHaHIkVLv80vmmuPwn4R9lnuwLcW0zFZNkrAkhhlsShlm67Bh55GWzcT7C4HZAUkUcBwr6PY7nx2fj8mAu76dUVo2QGxMsYg6Lc61do9oZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l3SMmJV7; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <938180ff-7e24-4d73-87d5-fca4bbaa4ced@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763538184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1I7cA2fVYEnU5tKmvwQ5dB4/kePKxlMyfJS/i/M6zD8=;
	b=l3SMmJV7Df/YlzQosv4zjnQtzbyfuENKua4z6s08PbQodhAK/In9ZUM9Y4NRbSBMPVkJWa
	1sExjcueECfivNB8hdidZd1kutWfWzzwrDPl+CgFixJsdFwbKXBqpujVjgPrjI/JsEU0qa
	gDayA0fLuY27pEbzURnI6Awwg70OeaE=
Date: Wed, 19 Nov 2025 15:42:51 +0800
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
 <a64d9d17-1706-4936-8742-8ee5bc4988ab@linux.dev> <aR1wmdn013bblCN_@hyeyoo>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <aR1wmdn013bblCN_@hyeyoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 11/19/25 3:24 PM, Harry Yoo wrote:
> On Tue, Nov 18, 2025 at 08:11:04PM +0800, Qi Zheng wrote:
>>
>>
>> On 11/18/25 7:28 PM, Qi Zheng wrote:
>>> Hi Harry,
>>>
>>> On 11/17/25 5:17 PM, Harry Yoo wrote:
>>>> On Tue, Oct 28, 2025 at 09:58:19PM +0800, Qi Zheng wrote:
>>>>> From: Muchun Song <songmuchun@bytedance.com>
>>>>>
>>>>> Memory cgroup functions such as get_mem_cgroup_from_folio() and
>>>>> get_mem_cgroup_from_mm() return a valid memory cgroup pointer,
>>>>> even for the root memory cgroup. In contrast, the situation for
>>>>> object cgroups has been different.
>>>>>
>>>>> Previously, the root object cgroup couldn't be returned because
>>>>> it didn't exist. Now that a valid root object cgroup exists, for
>>>>> the sake of consistency, it's necessary to align the behavior of
>>>>> object-cgroup-related operations with that of memory cgroup APIs.
>>>>>
>>>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>>>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>>>> ---
>>>>>    include/linux/memcontrol.h | 29 +++++++++++++++++-------
>>>>>    mm/memcontrol.c            | 45 ++++++++++++++++++++------------------
>>>>>    mm/percpu.c                |  2 +-
>>>>>    3 files changed, 46 insertions(+), 30 deletions(-)
>>>>>
>>>>> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>>>>> index 6185d8399a54e..9fdbd4970021d 100644
>>>>> --- a/include/linux/memcontrol.h
>>>>> +++ b/include/linux/memcontrol.h
>>>>> @@ -332,6 +332,7 @@ struct mem_cgroup {
>>>>>    #define MEMCG_CHARGE_BATCH 64U
>>>>>    extern struct mem_cgroup *root_mem_cgroup;
>>>>> +extern struct obj_cgroup *root_obj_cgroup;
>>>>>    enum page_memcg_data_flags {
>>>>>        /* page->memcg_data is a pointer to an slabobj_ext vector */
>>>>> @@ -549,6 +550,11 @@ static inline bool
>>>>> mem_cgroup_is_root(struct mem_cgroup *memcg)
>>>>>        return (memcg == root_mem_cgroup);
>>>>>    }
>>>>> +static inline bool obj_cgroup_is_root(const struct obj_cgroup *objcg)
>>>>> +{
>>>>> +    return objcg == root_obj_cgroup;
>>>>> +}
>>>>
>>>> After reparenting, an objcg may satisfy objcg->memcg == root_mem_cgroup
>>>> while objcg != root_obj_cgroup. Should they be considered as
>>>> root objcgs?
>>>
>>> Indeed, it's pointless to charge to root_mem_cgroup (objcg->memcg).
>>>
>>> So it should be:
>>>
>>> static inline bool obj_cgroup_is_root(const struct obj_cgroup *objcg)
>>> {
>>>       return (objcg == root_obj_cgroup) || (objcg->memcg ==
>>> root_mem_cgroup);
>>> }
>>
>> Oh, we can't do that because we still need to consider this objcg when
>> uncharging. Some pages may be charged before reparenting.
> 
> Ouch, right. We don't know if it's charged before reparenting and so
> it can break statistics in a few places if we skip uncharging it after
> repareting.

Right.

> 
> And I think we don't charge new pages to objcgs that satisfy
> (objcg->memcg == root_mem_cgroup) && (objcg != root_obj_cgroup)
> after they're reparented anyway...

The charge and uncharge operations must be symmetrical, so we cannot
control the charge operation independently.

Otherwise:

charge
======

if ((objcg->memcg == root_mem_cgroup))
	skip charge this page

uncharge
========

we can't decide whether to skip this page.

Thanks,
Qi


> 


