Return-Path: <cgroups+bounces-13167-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E828DD1CAA1
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 07:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D4F63011FB7
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 06:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57FD36BCCA;
	Wed, 14 Jan 2026 06:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sDrtDcU6"
X-Original-To: cgroups@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DAB34FF79
	for <cgroups@vger.kernel.org>; Wed, 14 Jan 2026 06:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768371959; cv=none; b=XuP0+fX3iqOp4dNggYHqkALDXSssmY3Q4gTmS9yGh8sI/NC2M8u1Eh0ArjDicpVCThyVn8gV8LMM5QO4IYImM4s6A4jL4nCTtMFHGtF9BBHsrxBW0WKkbv2kfFwHwZy3R7r+3e5cfyoOyd7mjHKvemCRWxeAaLNaygSGB+XUihc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768371959; c=relaxed/simple;
	bh=bb+3b86akibUjzH3JdPZOMMX77r06BU07GEI2D4CDe0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NaIFYg6n2qFoAVLCNUM+m5v8G31It2ovWp2fK4zU2dkNA0t7VRy3f87IOtp4c3b1qBxXBUvHUjVDkaFTpEzVN7DuGQ6bW6OVNCJheh5LyaB4Kc1fCsE+4ZBrkEJEfGUUhriKqSHvy2V2v/N9njTQnLFoxQO9DHOEA0INoRuCDzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sDrtDcU6; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3d8dd14c-d3a7-4cae-99e3-10ebe4ad52aa@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768371949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IFFYK3SE7r2jMbbMc8V7DFpSaOQnml1wlEvXbwdqn0w=;
	b=sDrtDcU6+9FNmrn80sPQ0xpW9+mgxv3nW9uh9blN+4oe8m5pKHBBbepifPRNQIAzUCFlHt
	CR4rAUx1rUe1a3w1eTQRFumSat5ztHxZ9Fb9IqVGEduxYj4DSgXBpGW0y7/bm4lAc3Dhg8
	9eg0V0X6+Xv/jOpaN6RTcaQETl/FM2M=
Date: Wed, 14 Jan 2026 14:25:36 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v6 4/4] mm: thp: reparent the split queue during memcg
 offline
To: Harry Yoo <harry.yoo@oracle.com>, Chris Mason <clm@meta.com>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 david@redhat.com, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 lance.yang@linux.dev, akpm@linux-foundation.org, richard.weiyang@gmail.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>
References: <8703f907c4d1f7e8a2ef2bfed3036a84fa53028b.1762762324.git.zhengqi.arch@bytedance.com>
 <20260113220046.2274684-1-clm@meta.com> <aWcrVRT_RjxdjoN7@hyeyoo>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <aWcrVRT_RjxdjoN7@hyeyoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 1/14/26 1:36 PM, Harry Yoo wrote:
> On Tue, Jan 13, 2026 at 02:00:43PM -0800, Chris Mason wrote:
>> On Mon, 10 Nov 2025 16:17:58 +0800 Qi Zheng <qi.zheng@linux.dev> wrote:
>>
>>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>>
>>> Similar to list_lru, the split queue is relatively independent and does
>>> not need to be reparented along with objcg and LRU folios (holding
>>> objcg lock and lru lock). So let's apply the similar mechanism as list_lru
>>> to reparent the split queue separately when memcg is offine.
>>>
>>
>> Hi everyone,
>>
>> I'm running all of the MM commits since v6.18 through the AI patch review
>> tools, and this one was flagged.  I'm much less confident in this report,
>> AI tends to get these races wrong:
>>
>> [AI review output]
>>
>>> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>>> index b0c6a4635c67b..cc6db20d7dca0 100644
>>> --- a/include/linux/memcontrol.h
>>> +++ b/include/linux/memcontrol.h
>>> @@ -1775,6 +1775,12 @@ static inline void count_objcg_events(struct obj_cgroup *objcg,
>>>   bool mem_cgroup_node_allowed(struct mem_cgroup *memcg, int nid);
>>>
>>>   void mem_cgroup_show_protected_memory(struct mem_cgroup *memcg);
>>> +
>>> +static inline bool memcg_is_dying(struct mem_cgroup *memcg)
>>> +{
>>> +	return memcg ? css_is_dying(&memcg->css) : false;
>>> +}
>>
>> [ ... ]
>>
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 13684e5376e82..d17d3810a882c 100644
>>
>> [ ... ]
>>
>>> @@ -1129,8 +1140,14 @@ split_queue_lock_irqsave(int nid, struct mem_cgroup *memcg, unsigned long *flags
>>>   {
>>>   	struct deferred_split *queue;
>>>
>>> +retry:
>>>   	queue = memcg_split_queue(nid, memcg);
>>>   	spin_lock_irqsave(&queue->split_queue_lock, *flags);
>>> +	if (unlikely(memcg_is_dying(memcg))) {
>>> +		spin_unlock_irqrestore(&queue->split_queue_lock, *flags);
>>> +		memcg = parent_mem_cgroup(memcg);
>>> +		goto retry;
>>> +	}
>>>
>>>   	return queue;
>>>   }
>>
>> There appears to be a race window that can cause split_queue_len counter
>> mismatch. Between the time CSS_DYING is set (in kill_css()) and when
>> reparent_deferred_split_queue() actually runs (asynchronously in
>> css_offline), folios can be unqueued via __folio_unqueue_deferred_split().
>>
>> In this scenario:
>>    __folio_unqueue_deferred_split()
>>      -> folio_split_queue_lock_irqsave()
>>         -> split_queue_lock_irqsave() sees memcg_is_dying() == true
>>         -> returns parent's queue (locked)
>>      -> ds_queue->split_queue_len-- decrements parent's counter
>>      -> list_del_init() removes folio from child's list
>>
>> The folio is correctly removed from the child's list (list_del_init is
>> self-referential), but the wrong queue's counter is decremented.
> 
> Good point. Sounds pretty possible to me?
> 
> I don't think there's anything that prevents it from unqueued
> before it's reparented.
> 
>> If the parent queue was empty (split_queue_len == 0), this would cause an
>> unsigned long underflow to ULONG_MAX.
> 
> Although the accounting mismatch will only persist until
> reparent_deferred_split_queue() reparents the deferred split queue.

This period is very short, and the only thing affected should be
deferred_split_count(), but it does not cause a system error.

So I think maybe we can leave it unrepaired.

> 
> Ideally this should be fixed by checking if the folio has been
> reparented after acquiring the split queue lock, but since we don't reparent
> LRU pages yet ... do we need a band-aid before then?
> 
> Do we want to have is_dying property in the split queue as it was in v2? [1]
> [1] https://lore.kernel.org/linux-mm/55370bda7b2df617033ac12116c1712144bb7591.1758618527.git.zhengqi.arch@bytedance.com
> 
>> Could this be addressed by checking that the folio is actually in the
>> queue being unlocked, perhaps by verifying the list head matches before
>> decrementing split_queue_len?
> 
>> [ ... ]
>>
>>> @@ -3920,6 +3920,7 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
>>>   	zswap_memcg_offline_cleanup(memcg);
>>>
>>>   	memcg_offline_kmem(memcg);
>>> +	reparent_deferred_split_queue(memcg);
>>
>> The race window exists because CSS_DYING is set in kill_css() before
>> css_offline() callbacks run asynchronously. The comment in split_queue_lock
>> mentions that THPs will be "hidden from the shrinker side" during this
>> period, but does not address the counter accounting issue when folios
>> are unqueued.
> 


