Return-Path: <cgroups+bounces-10911-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B87BF4B2A
	for <lists+cgroups@lfdr.de>; Tue, 21 Oct 2025 08:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D062118C3ADB
	for <lists+cgroups@lfdr.de>; Tue, 21 Oct 2025 06:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962CC23536C;
	Tue, 21 Oct 2025 06:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QM6xEaXQ"
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A281D516C
	for <cgroups@vger.kernel.org>; Tue, 21 Oct 2025 06:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761027753; cv=none; b=O+80YKTQT2vvN7UlaO71n3D4qZe/+kyWfry2OKcTtbgmgw6YJYf8lD8VlZe6qZephgEqYSVZi1Ct+jLtEWnbgWFgDJxvWdV7j/4pm6dXX7t46O+BPx7YJPSO4ehDEwpzY6hpO2MpB+CZ+e2g1Cjal653TK2HoeQq8C8RoeeuPDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761027753; c=relaxed/simple;
	bh=AiqnwMg6the0BOJCguJhMYcR5lWRjxYHtVkxqf9l0tw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DfQDs/TSW4Xs4mfOJ06aaAQOQzhczhviUhlJu3ez5DtPwP5vARliaApCky14AB3kXfaTZbEuqDzdCe5tDgy99878eQU/2G0ILNK2xH8l4PWUwzkLfX2oPbLAfUUBgAXevLhdlXl4Vyr0h5ItMz7twFRKBEQ0SKj+Qh51EOMH5s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QM6xEaXQ; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3acbf7df-b890-4679-bbbe-959bd45fdef3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761027739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kya1JAQmVRbw00lv1IpjiwWxKFwn52KaWMDi202LPPQ=;
	b=QM6xEaXQ1k9fTRzqU35722oyvtkjOhFRFUn6hv7F15sVNnUzXmeTTn2sd0kuiqZ03eqLb3
	yeUPqfOeX+rbw3/za/8SnDe/EQgKFudCqn0bA8eG/3HY1aYPpOdEgHLGz3PCveOq0oGoVK
	1/6Xk2/3qrqGrJgsLddULhG7FS2cUmc=
Date: Tue, 21 Oct 2025 14:21:55 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 4/4] mm: thp: reparent the split queue during memcg
 offline
To: Harry Yoo <harry.yoo@oracle.com>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 david@redhat.com, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 lance.yang@linux.dev, akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1760509767.git.zhengqi.arch@bytedance.com>
 <645f537dee489faa45e611d303bf482a06f0ece7.1760509767.git.zhengqi.arch@bytedance.com>
 <aPcjnKAapap5jrK-@hyeyoo>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <aPcjnKAapap5jrK-@hyeyoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 10/21/25 2:09 PM, Harry Yoo wrote:
> On Wed, Oct 15, 2025 at 02:35:33PM +0800, Qi Zheng wrote:
>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>
>> Similar to list_lru, the split queue is relatively independent and does
>> not need to be reparented along with objcg and LRU folios (holding
>> objcg lock and lru lock). So let's apply the similar mechanism as list_lru
>> to reparent the split queue separately when memcg is offine.
>>
>> This is also a preparation for reparenting LRU folios.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> Acked-by: Zi Yan <ziy@nvidia.com>
>> Reviewed-by: Muchun Song <muchun.song@linux.dev>
>> Acked-by: David Hildenbrand <david@redhat.com>
>> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
>> ---
> 
> Looks good to me,
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

Thanks.

> 
> with a question:
> 
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index e850bc10da3e2..9323039418201 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -1117,8 +1117,19 @@ static struct deferred_split *split_queue_lock(int nid, struct mem_cgroup *memcg
>>   {
>>   	struct deferred_split *queue;
>>   
>> +retry:
>>   	queue = memcg_split_queue(nid, memcg);
>>   	spin_lock(&queue->split_queue_lock);
>> +	/*
>> +	 * There is a period between setting memcg to dying and reparenting
>> +	 * deferred split queue, and during this period the THPs in the deferred
>> +	 * split queue will be hidden from the shrinker side.
>> +	 */
> 
> You mean it will be hidden if the shrinker bit is not set for the node
> in the parent memcg, right?

Look at the following situation:

CPU 0                   CPU 1
-----                   -----

set CSS_DYING
                         deferred_split_scan
                             /*
                              * See CSS_DYING, and return the parent
                              * memcg's ds_queue. But the pages on the
                              * child memcg's ds_queue has not yet been
                              * reparented to the parent memcg, that is,
                              * it is hidden.
                              */
                         --> ds_queue = split_queue_lock_irqsave()

reparent_deferred_split_queue

Thanks,
Qi

> 


