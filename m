Return-Path: <cgroups+bounces-10488-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD5FBA83A5
	for <lists+cgroups@lfdr.de>; Mon, 29 Sep 2025 09:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7103217B2A8
	for <lists+cgroups@lfdr.de>; Mon, 29 Sep 2025 07:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8841D24E4A8;
	Mon, 29 Sep 2025 07:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VYslHZ0S"
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1486417597;
	Mon, 29 Sep 2025 07:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759130577; cv=none; b=faCZ0TMQKFcwvN+fyqpFE4UHkwm8A0Ls9VBI8h2K7aZ+x5lVh+J8ZwfQUxtWBwd50WmI4S7qaJ1vL/pvx4LZrp//nmBO3zzd0ldI481DifUu6m0kiKsUOZBw863PzZS4/CkWhbn6c+VZy8e/tnT1W23hC3efzk6Lj3YnzPc/Txo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759130577; c=relaxed/simple;
	bh=z0uyGD9TI7NjyR6EscLXUCdMtXCaxiwqf3TMav1S77k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kG+4yxM+g4Uo7W2I1rLS3KNZgDrJZFaX+T/mXSjKIXsUl2LmafW2WA5mJsy8UO/aXe1J/vuzWdrVpq4qtO1HaPfo9cpt9yF64vgTLUq+wmrSj0We8u9UDb+q9/MqOkZeDh/rEqrE1wtYBdrlH56bmcCUAJLnMhzM6FzZ1YpneMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VYslHZ0S; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <08a4f0b2-1735-4e3b-9f61-d55e45e8ec86@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759130571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=496tR+1nCfJ5pMJ3flSASce4X+8Hs2xr9YohPB9v6U8=;
	b=VYslHZ0SqUSQSRUI8LkqSa1EC3AisZePf4ZJzWMHfC02EaHIkI9ZXeUF/4HzNIL3jIrqe2
	mbsc9HhAiRNJUl7tBA0kVCnsbte9jCiKP3iRYGU8CW6aw/citZryM34Od2wQMQvxN/28Qn
	g3LWMqieR6IJpupFArem/kJUcklhqn0=
Date: Mon, 29 Sep 2025 15:22:33 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 4/4] mm: thp: reparent the split queue during memcg
 offline
To: Muchun Song <muchun.song@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, david@redhat.com,
 lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 lance.yang@linux.dev, akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1759056506.git.zhengqi.arch@bytedance.com>
 <2ddd0c184829e65c5b3afa34e93599783e7af3d4.1759056506.git.zhengqi.arch@bytedance.com>
 <2EC0CBCD-73FD-400A-921A-EAB45B21ACB8@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <2EC0CBCD-73FD-400A-921A-EAB45B21ACB8@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 9/29/25 2:20 PM, Muchun Song wrote:
> 
> 
>> On Sep 28, 2025, at 19:45, Qi Zheng <qi.zheng@linux.dev> wrote:
>>
>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>
>> Similar to list_lru, the split queue is relatively independent and does
>> not need to be reparented along with objcg and LRU folios (holding
>> objcg lock and lru lock). So let's apply the same mechanism as list_lru
>> to reparent the split queue separately when memcg is offine.
>>
>> This is also a preparation for reparenting LRU folios.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>> include/linux/huge_mm.h |  4 ++++
>> mm/huge_memory.c        | 46 +++++++++++++++++++++++++++++++++++++++++
>> mm/memcontrol.c         |  1 +
>> 3 files changed, 51 insertions(+)
>>
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index f327d62fc9852..0c211dcbb0ec1 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -417,6 +417,9 @@ static inline int split_huge_page(struct page *page)
>> 	return split_huge_page_to_list_to_order(page, NULL, ret);
>> }
>> void deferred_split_folio(struct folio *folio, bool partially_mapped);
>> +#ifdef CONFIG_MEMCG
>> +void reparent_deferred_split_queue(struct mem_cgroup *memcg);
>> +#endif
>>
>> void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
>> 		unsigned long address, bool freeze);
>> @@ -611,6 +614,7 @@ static inline int try_folio_split(struct folio *folio, struct page *page,
>> }
>>
>> static inline void deferred_split_folio(struct folio *folio, bool partially_mapped) {}
>> +static inline void reparent_deferred_split_queue(struct mem_cgroup *memcg) {}
>> #define split_huge_pmd(__vma, __pmd, __address) \
>> 	do { } while (0)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index bb32091e3133e..5fc0caca71de0 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -1094,9 +1094,22 @@ static struct deferred_split *folio_split_queue_lock(struct folio *folio)
>> 	struct deferred_split *queue;
>>
>> 	memcg = folio_memcg(folio);
>> +retry:
>> 	queue = memcg ? &memcg->deferred_split_queue :
>> 			&NODE_DATA(folio_nid(folio))->deferred_split_queue;
>> 	spin_lock(&queue->split_queue_lock);
>> + 	/*
>> +	 * Notice:
>> +	 * 1. The memcg could be NULL if cgroup_disable=memory is set.
>> +	 * 2. There is a period between setting CSS_DYING and reparenting
>> +	 *    deferred split queue, and during this period the THPs in the
>> +	 *    deferred split queue will be hidden from the shrinker side.

The shrinker side can find this deferred split queue by traversing
memcgs, so we should check CSS_DYING after we acquire child
split_queue_lock in :

deferred_split_scan
--> spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
     if (css_is_dying(&memcg->css))
     --> retry to get parent split_queue_lock

So during this period, we use parent split_queue_lock to protect
child deferred split queue. It's a little weird, but it's safe.

>> +	 */
>> + 	if (unlikely(memcg && css_is_dying(&memcg->css))) {
>> + 		spin_unlock(&queue->split_queue_lock);
>> + 		memcg = parent_mem_cgroup(memcg);
>> + 		goto retry;
>> + 	}
>>
>> 	return queue;
>> }
>> @@ -1108,9 +1121,15 @@ folio_split_queue_lock_irqsave(struct folio *folio, unsigned long *flags)
>> 	struct deferred_split *queue;
>>
>> 	memcg = folio_memcg(folio);
>> +retry:
>> 	queue = memcg ? &memcg->deferred_split_queue :
>> 			&NODE_DATA(folio_nid(folio))->deferred_split_queue;
>> 	spin_lock_irqsave(&queue->split_queue_lock, *flags);
>> + 		if (unlikely(memcg && css_is_dying(&memcg->css))) {
>> + 		spin_unlock_irqrestore(&queue->split_queue_lock, *flags);
>> + 		memcg = parent_mem_cgroup(memcg);
>> + 		goto retry;
>> + 	}
>>
>> 	return queue;
>> }
>> @@ -4275,6 +4294,33 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>> 	return split;
>> }
>>
>> +#ifdef CONFIG_MEMCG
>> +void reparent_deferred_split_queue(struct mem_cgroup *memcg)
>> +{
>> + 	struct mem_cgroup *parent = parent_mem_cgroup(memcg);
>> + 	struct deferred_split *ds_queue = &memcg->deferred_split_queue;
>> + 	struct deferred_split *parent_ds_queue = &parent->deferred_split_queue;
>> + 	int nid;
>> +
>> + 	spin_lock_irq(&ds_queue->split_queue_lock);
>> + 	spin_lock_nested(&parent_ds_queue->split_queue_lock, SINGLE_DEPTH_NESTING);
>> +
>> + 	if (!ds_queue->split_queue_len)
>> + 		goto unlock;
>> +
>> + 	list_splice_tail_init(&ds_queue->split_queue, &parent_ds_queue->split_queue);
>> + 	parent_ds_queue->split_queue_len += ds_queue->split_queue_len;
>> + 	ds_queue->split_queue_len = 0;
>> +
>> + 	for_each_node(nid)
>> + 		set_shrinker_bit(parent, nid, shrinker_id(deferred_split_shrinker));
>> +
>> +unlock:
>> + 	spin_unlock(&parent_ds_queue->split_queue_lock);
>> + 	spin_unlock_irq(&ds_queue->split_queue_lock);
>> +}
>> +#endif
>> +
>> #ifdef CONFIG_DEBUG_FS
>> static void split_huge_pages_all(void)
>> {
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index e090f29eb03bd..d03da72e7585d 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -3887,6 +3887,7 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
>> 	zswap_memcg_offline_cleanup(memcg);
>>
>> 	memcg_offline_kmem(memcg);
>> + 	reparent_deferred_split_queue(memcg);
> 
> Since the dying flag of a memcg is not set under split_queue_lock,
> two threads holding different split_queue_locks (e.g., one for the
> parent memcg and one for the child) can concurrently manipulate the
> same split-queue list of a folio. I think we should take the same

If we ensure that we will check CSS_DYING every time we take the
split_queue_lock, then the lock protecting deferred split queue
must be the same lock.

To be more clear, consider the following case:

CPU0              CPU1              CPU2

                   folio_split_queue_lock
                   --> get child queue and lock

set CSS_DYING

                                     deferred_split_scan
                   unlock child queue lock
                                     --> acquire child queue lock
                                         ***WE SHOULD CHECK CSS_DYING 
HERE***
	

reparent spilt queue

The deferred_split_scan() is problematic now, I will fix it as follow:

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 5fc0caca71de0..9f1f61e7e0c8e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4208,6 +4208,7 @@ static unsigned long deferred_split_scan(struct 
shrinker *shrink,
         struct folio *folio, *next;
         int split = 0, i;
         struct folio_batch fbatch;
+       struct mem_cgroup *memcg;

  #ifdef CONFIG_MEMCG
         if (sc->memcg)
@@ -4217,6 +4218,11 @@ static unsigned long deferred_split_scan(struct 
shrinker *shrink,
         folio_batch_init(&fbatch);
  retry:
         spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
+       if (sc->memcg && css_is_dying(&sc->memcg->css)) {
+               spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
+               memcg = parent_mem_cgroup(sc->memcg);
+ 
spin_lock_irqsave(&memcg->deferred_split_queue.split_queue_lock, flags);
+       }
         /* Take pin on all head pages to avoid freeing them under us */
         list_for_each_entry_safe(folio, next, &ds_queue->split_queue,
                                                         _deferred_list) {

Of course I'll add helper functions and do some cleanup.

Thanks,
Qi


> solution like list_lru does to fix this.
> 
> Muchun,
> Thanks.
> 
> 
>> 	reparent_shrinker_deferred(memcg);
>> 	wb_memcg_offline(memcg);
>> 	lru_gen_offline_memcg(memcg);
>> -- 
>> 2.20.1
>>
> 


