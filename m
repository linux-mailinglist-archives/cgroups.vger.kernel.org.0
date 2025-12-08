Return-Path: <cgroups+bounces-12286-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE06CABF2A
	for <lists+cgroups@lfdr.de>; Mon, 08 Dec 2025 04:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DEE503053B13
	for <lists+cgroups@lfdr.de>; Mon,  8 Dec 2025 03:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7B42FB612;
	Mon,  8 Dec 2025 03:10:47 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7540524DCF9;
	Mon,  8 Dec 2025 03:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765163447; cv=none; b=dBhkDQ5H4ns+3fhvqLYdEpC5+mwmVMMlmJl4/NpWsd55w23xOmQR23mdKb1oxPAcSVcHxfZN0qrJBSmfUQXj0GmBM0vaVGCa4uOpv4pmPjcODPKJGDRvhAS6Zkz2TwesQBrb1Fy1yHtTSJyZq4gILLylKYjp/tZWIZgi+cw4Qw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765163447; c=relaxed/simple;
	bh=nPTveDZeHNuLSNMhGxJ5EcXwhGBWpYyN20InKHAHIy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mA9p90adkW+N2lic5/awH+MWAtTkMQR6rbTkml8nhtOYxEtuIECMMKxtBU0DNUxkDdeXV3WaAeCBOeyATXhBNbb+FOpPrw2ISIbdsvS+IOKvMcpMWVSqTz0QjQwVcrTUDiHxj7INYAdSQbWcW7eDR4D2YOYeLNqEbnTbwXQ4638=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dPn5h4pgxzKHMMV;
	Mon,  8 Dec 2025 11:09:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 136EA1A193F;
	Mon,  8 Dec 2025 11:10:41 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgA3YZ6tQTZpBrb2Aw--.58034S2;
	Mon, 08 Dec 2025 11:10:38 +0800 (CST)
Message-ID: <c0c69863-52f8-44ed-8d85-97531caf4dea@huaweicloud.com>
Date: Mon, 8 Dec 2025 11:10:36 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH -next 1/2] mm/mglru: use mem_cgroup_iter for global
 reclaim
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: akpm@linux-foundation.org, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, david@kernel.org, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, corbet@lwn.net, hannes@cmpxchg.org,
 roman.gushchin@linux.dev, muchun.song@linux.dev, yuzhao@google.com,
 zhengqi.arch@bytedance.com, linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, lujialin4@huawei.com,
 chenridong@huawei.com
References: <20251204123124.1822965-1-chenridong@huaweicloud.com>
 <20251204123124.1822965-2-chenridong@huaweicloud.com>
 <tvrspnhlo7x7gpjc4nn7f73b2qoyphkpaxlcnnn4fsxciv6bks@3dibvbs7u5do>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <tvrspnhlo7x7gpjc4nn7f73b2qoyphkpaxlcnnn4fsxciv6bks@3dibvbs7u5do>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgA3YZ6tQTZpBrb2Aw--.58034S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGFW8uF15tFWkur1DGrW8tFb_yoW7Jry8pF
	Z3Ja4Sk3yrJr1agFnIqF4q9a4Yvw4Ikr13JryYvw1xAF9IqryFvr12krW0yrWUAry8ur1x
	XFWYvw1ru3yjyFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/12/5 6:29, Shakeel Butt wrote:
> Hi Chen,
> 
> On Thu, Dec 04, 2025 at 12:31:23PM +0000, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> The memcg LRU was originally introduced for global reclaim to enhance
>> scalability. However, its implementation complexity has led to performance
>> regressions when dealing with a large number of memory cgroups [1].
>>
>> As suggested by Johannes [1], this patch adopts mem_cgroup_iter with
>> cookie-based iteration for global reclaim, aligning with the approach
>> already used in shrink_node_memcgs. This simplification removes the
>> dedicated memcg LRU tracking while maintaining the core functionality.
>>
>> It performed a stress test based on Zhao Yu's methodology [2] on a
>> 1 TB, 4-node NUMA system. The results are summarized below:
>>
>> 					memcg LRU    memcg iter
>> stddev(pgsteal) / mean(pgsteal)            91.2%         75.7%
>> sum(pgsteal) / sum(requested)             216.4%        230.5%
>>
>> The new implementation demonstrates a significant improvement in
>> fairness, reducing the standard deviation relative to the mean by
>> 15.5 percentage points. While the reclaim accuracy shows a slight
>> increase in overscan (from 85086871 to 90633890, 6.5%).
>>
>> The primary benefits of this change are:
>> 1. Simplified codebase by removing custom memcg LRU infrastructure
>> 2. Improved fairness in memory reclaim across multiple cgroups
>> 3. Better performance when creating many memory cgroups
>>
>> [1] https://lore.kernel.org/r/20251126171513.GC135004@cmpxchg.org
>> [2] https://lore.kernel.org/r/20221222041905.2431096-7-yuzhao@google.com
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> 
> Thanks a lot of this awesome work.
> 
>> ---
>>  mm/vmscan.c | 117 ++++++++++++++++------------------------------------
>>  1 file changed, 36 insertions(+), 81 deletions(-)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index fddd168a9737..70b0e7e5393c 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -4895,27 +4895,14 @@ static bool try_to_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
>>  	return nr_to_scan < 0;
>>  }
>>  
>> -static int shrink_one(struct lruvec *lruvec, struct scan_control *sc)
>> +static void shrink_one(struct lruvec *lruvec, struct scan_control *sc)
>>  {
>> -	bool success;
>>  	unsigned long scanned = sc->nr_scanned;
>>  	unsigned long reclaimed = sc->nr_reclaimed;
>> -	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
>>  	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
>> +	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
>>  
>> -	/* lru_gen_age_node() called mem_cgroup_calculate_protection() */
>> -	if (mem_cgroup_below_min(NULL, memcg))
>> -		return MEMCG_LRU_YOUNG;
>> -
>> -	if (mem_cgroup_below_low(NULL, memcg)) {
>> -		/* see the comment on MEMCG_NR_GENS */
>> -		if (READ_ONCE(lruvec->lrugen.seg) != MEMCG_LRU_TAIL)
>> -			return MEMCG_LRU_TAIL;
>> -
>> -		memcg_memory_event(memcg, MEMCG_LOW);
>> -	}
>> -
>> -	success = try_to_shrink_lruvec(lruvec, sc);
>> +	try_to_shrink_lruvec(lruvec, sc);
>>  
>>  	shrink_slab(sc->gfp_mask, pgdat->node_id, memcg, sc->priority);
>>  
>> @@ -4924,86 +4911,55 @@ static int shrink_one(struct lruvec *lruvec, struct scan_control *sc)
>>  			   sc->nr_reclaimed - reclaimed);
>>  
>>  	flush_reclaim_state(sc);
> 
> Unrealted to your patch but why this flush_reclaim_state() is at
> different place from the non-MGLRU code path?
> 

Thank you Shakeel for you reply.

IIUC, I think adding flush_reclaim_state here makes sense. Currently, shrink_one is only used for
root-level reclaim in gen-LRU, and flush_reclaim_state is only relevant during root reclaim.
Flushing after each lruvec is shrunk could help the reclaim loop terminate earlier, as
sc->nr_reclaimed += current->reclaim_state->reclaimed; may reach nr_to_reclaim sooner.

That said, I'm also wondering whether we should apply flush_reclaim_state for every iteration in
non-MGLLU reclaim as well. For non-root reclaim, it should be negligible since it effectively does
nothing. But for root-level reclaim under non-MGLRU, it might similarly help stop the iteration earlier.

>> -
>> -	if (success && mem_cgroup_online(memcg))
>> -		return MEMCG_LRU_YOUNG;
>> -
>> -	if (!success && lruvec_is_sizable(lruvec, sc))
>> -		return 0;
>> -
>> -	/* one retry if offlined or too small */
>> -	return READ_ONCE(lruvec->lrugen.seg) != MEMCG_LRU_TAIL ?
>> -	       MEMCG_LRU_TAIL : MEMCG_LRU_YOUNG;
>>  }
>>  
>>  static void shrink_many(struct pglist_data *pgdat, struct scan_control *sc)
> 
> This function kind of become very similar to shrink_node_memcgs()
> function other than shrink_one vs shrink_lruvec. Can you try to combine
> them and see if it looks not-ugly? Otherwise the code looks good to me.
> 

Will try to.

-- 
Best regards,
Ridong


