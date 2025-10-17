Return-Path: <cgroups+bounces-10835-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09138BE61B5
	for <lists+cgroups@lfdr.de>; Fri, 17 Oct 2025 04:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71FA75E06CB
	for <lists+cgroups@lfdr.de>; Fri, 17 Oct 2025 02:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1C023A564;
	Fri, 17 Oct 2025 02:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WMC7+Kml"
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E97638DD8
	for <cgroups@vger.kernel.org>; Fri, 17 Oct 2025 02:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760668466; cv=none; b=rOKtJbPh9hscowRPa5ryUoWEQnCK8HaW6u66AItJ0fWzr64rD8nijdSY0PQkHPwpoP2rQiP+PydUSb3jF/Gz2JJ6tJWGXfPDdX0wPc4+7TceDqq5WLNEaF+RJWEeZCH1dmST/24R/5hpsd7xaFj6ijVZUtaAowIN3Yh7o4F2dUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760668466; c=relaxed/simple;
	bh=INxo/u80iNP+uzH1S3xqUqKsXSwTE91zTNcdGcX5TN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l2aY3EDCda9REhijzDo/JCMI8nDizf7OIZZppfHPCm6VOgZLG7V8qMLadVTzu6ylgVD9YjAsCp/7wAEdsTUWE1rO+MQxtWt75eNV59W5HMH9+QDlxfUs6T9IPEvezkW3Fgbbj60Jdc9AApIqvqm5HXA5/Z2V/IspJeNHVRmxkb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WMC7+Kml; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0c263545-9b22-43b8-b919-3613ecc15553@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760668452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IbO5pn8l4Y/yw529hagzahAyjhXmntVuhxc4yNmU1u4=;
	b=WMC7+KmlXtDn9J4nhg8GF3Fm7UZt5r8Z4BaRv4R6V+R0nrHNDGd1t6lgC57DEWPq98Cmdb
	y6XwFfBLXRhCkOM0Z9IESnjfmJ5GxY2Y7ukcw94YcmNwT4HfreVnVwIAw0zMwWN9QrXFOg
	2zTZiKCh8Sxd9VSVJNBi4ynxmA16p14=
Date: Fri, 17 Oct 2025 10:33:57 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 3/4] mm: thp: use folio_batch to handle THP splitting
 in deferred_split_scan()
To: Wei Yang <richard.weiyang@gmail.com>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 david@redhat.com, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 harry.yoo@oracle.com, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev,
 akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>,
 Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1760509767.git.zhengqi.arch@bytedance.com>
 <4f5d7a321c72dfe65e0e19a3f89180d5988eae2e.1760509767.git.zhengqi.arch@bytedance.com>
 <20251017004611.ccjq2343v43mimqq@master>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <20251017004611.ccjq2343v43mimqq@master>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 10/17/25 8:46 AM, Wei Yang wrote:
> On Wed, Oct 15, 2025 at 02:35:32PM +0800, Qi Zheng wrote:
>> From: Muchun Song <songmuchun@bytedance.com>
>>
>> The maintenance of the folio->_deferred_list is intricate because it's
>> reused in a local list.
>>
>> Here are some peculiarities:
>>
>>    1) When a folio is removed from its split queue and added to a local
>>       on-stack list in deferred_split_scan(), the ->split_queue_len isn't
>>       updated, leading to an inconsistency between it and the actual
>>       number of folios in the split queue.
>>
>>    2) When the folio is split via split_folio() later, it's removed from
>>       the local list while holding the split queue lock. At this time,
>>       the lock is not needed as it is not protecting anything.
>>
>>    3) To handle the race condition with a third-party freeing or migrating
>>       the preceding folio, we must ensure there's always one safe (with
>>       raised refcount) folio before by delaying its folio_put(). More
>>       details can be found in commit e66f3185fa04 ("mm/thp: fix deferred
>>       split queue not partially_mapped"). It's rather tricky.
>>
>> We can use the folio_batch infrastructure to handle this clearly. In this
>> case, ->split_queue_len will be consistent with the real number of folios
>> in the split queue. If list_empty(&folio->_deferred_list) returns false,
>> it's clear the folio must be in its split queue (not in a local list
>> anymore).
>>
>> In the future, we will reparent LRU folios during memcg offline to
>> eliminate dying memory cgroups, which requires reparenting the split queue
>> to its parent first. So this patch prepares for using
>> folio_split_queue_lock_irqsave() as the memcg may change then.
>>
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> Reviewed-by: Zi Yan <ziy@nvidia.com>
>> Acked-by: David Hildenbrand <david@redhat.com>
>> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> 
> Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

Thanks.

> 
> One nit below
> 
>> ---
> [...]
>> @@ -4239,38 +4245,27 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>> 		}
>> 		folio_unlock(folio);
>> next:
>> +		if (did_split || !folio_test_partially_mapped(folio))
>> +			continue;
>> 		/*
>> -		 * split_folio() removes folio from list on success.
>> 		 * Only add back to the queue if folio is partially mapped.
>> 		 * If thp_underused returns false, or if split_folio fails
>> 		 * in the case it was underused, then consider it used and
>> 		 * don't add it back to split_queue.
>> 		 */
>> -		if (did_split) {
>> -			; /* folio already removed from list */
>> -		} else if (!folio_test_partially_mapped(folio)) {
>> -			list_del_init(&folio->_deferred_list);
>> -			removed++;
>> -		} else {
>> -			/*
>> -			 * That unlocked list_del_init() above would be unsafe,
>> -			 * unless its folio is separated from any earlier folios
>> -			 * left on the list (which may be concurrently unqueued)
>> -			 * by one safe folio with refcount still raised.
>> -			 */
>> -			swap(folio, prev);
>> +		fqueue = folio_split_queue_lock_irqsave(folio, &flags);
>> +		if (list_empty(&folio->_deferred_list)) {
>> +			list_add_tail(&folio->_deferred_list, &fqueue->split_queue);
>> +			fqueue->split_queue_len++;
>> 		}
>> -		if (folio)
>> -			folio_put(folio);
>> +		split_queue_unlock_irqrestore(fqueue, flags);
>> 	}
>> +	folios_put(&fbatch);
>>
>> -	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
>> -	list_splice_tail(&list, &ds_queue->split_queue);
>> -	ds_queue->split_queue_len -= removed;
>> -	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
>> -
>> -	if (prev)
>> -		folio_put(prev);
>> +	if (sc->nr_to_scan && !list_empty(&ds_queue->split_queue)) {
> 
> Maybe we can use ds_queue->split_queue_len instead?

Maybe not, checking whether the linked list is empty before traversing
it is more natural, and the overhead of the two methods is not much
different.

> 
>> +		cond_resched();
>> +		goto retry;
>> +	}
>>
>> 	/*
>> 	 * Stop shrinker if we didn't split any page, but the queue is empty.
>> -- 
>> 2.20.1
>>
> 


