Return-Path: <cgroups+bounces-12576-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B9CCD4DD5
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 08:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3530A300B992
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 07:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDD93081B8;
	Mon, 22 Dec 2025 07:27:35 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BE11E492D;
	Mon, 22 Dec 2025 07:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766388455; cv=none; b=MWOrEm94kgGsLIfajQFqWhavCidWlQjT5lFwZyVBT1xAdbike2tWbnuJOVKmh5Uzb9F3Hgqur12VulABvpS8oz0gawwhodSgzyV2quE/rvgFjb1m8mi6jU1alKPB08M12EsqiHuPSC/1RyLtbd/JlXSFS2U2vW7ky0AnjI5lCx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766388455; c=relaxed/simple;
	bh=5RxYdpaqx8bdYpbBuqMBvxeJUTuUZ6peKKfCmicpdyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nOeX15fxULiWq4zhfW5r0Aaa8LDl18xDmduX0QvGHT6QIhUJ3IrWkP8lmFdIcd/kNDf8TvqpQcLxmjc7zov209waiUCHXEIjBeWTBWnPTkRQ2LYka30rCH64s4/8XNHDOgTmKACCP5STNC9fFqvKbpgGRWCsefHnQEHh7PzXZ6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dZV7z2XPWzYQtmL;
	Mon, 22 Dec 2025 15:26:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 4354B4056C;
	Mon, 22 Dec 2025 15:27:30 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgBH9vbe8khpLNxBBA--.13985S2;
	Mon, 22 Dec 2025 15:27:28 +0800 (CST)
Message-ID: <702b6c0b-5e65-4f55-9a2f-4d07c3a84e39@huaweicloud.com>
Date: Mon, 22 Dec 2025 15:27:26 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 1/5] mm/mglru: use mem_cgroup_iter for global
 reclaim
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: akpm@linux-foundation.org, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, david@kernel.org, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, corbet@lwn.net, hannes@cmpxchg.org,
 roman.gushchin@linux.dev, muchun.song@linux.dev, zhengqi.arch@bytedance.com,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, lujialin4@huawei.com, zhongjinji@honor.com
References: <20251209012557.1949239-1-chenridong@huaweicloud.com>
 <20251209012557.1949239-2-chenridong@huaweicloud.com>
 <gkudpvytcc3aa5yjaigwtkyyyglmvnnqngrexfuqiv2mzxj5cn@e7rezszexd7l>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <gkudpvytcc3aa5yjaigwtkyyyglmvnnqngrexfuqiv2mzxj5cn@e7rezszexd7l>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBH9vbe8khpLNxBBA--.13985S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XF1kGrW7JF4DXrWrZFy8AFb_yoWxZw4kpF
	Z3Ja1akr4rJFyagr1SqF4q9a4Fyw48Jr43Jr1xt3WfArnxtryrKr42kr18uFyDCrWrur1x
	JFyYyw1DWayjvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



On 2025/12/22 11:12, Shakeel Butt wrote:
> On Tue, Dec 09, 2025 at 01:25:53AM +0000, Chen Ridong wrote:
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
>> It performed a stress test based on Yu Zhao's methodology [2] on a
>> 1 TB, 4-node NUMA system. The results are summarized below:
>>
>> 	pgsteal:
>> 						memcg LRU    memcg iter
>> 	stddev(pgsteal) / mean(pgsteal)		106.03%		93.20%
>> 	sum(pgsteal) / sum(requested)		98.10%		99.28%
>>
>> 	workingset_refault_anon:
>> 						memcg LRU    memcg iter
>> 	stddev(refault) / mean(refault)		193.97%		134.67%
>> 	sum(refault)				1963229		2027567
>>
>> The new implementation shows a clear fairness improvement, reducing the
>> standard deviation relative to the mean by 12.8 percentage points. The
>> pgsteal ratio is also closer to 100%. Refault counts increased by 3.2%
>> (from 1,963,229 to 2,027,567).
>>
>> The primary benefits of this change are:
>> 1. Simplified codebase by removing custom memcg LRU infrastructure
>> 2. Improved fairness in memory reclaim across multiple cgroups
>> 3. Better performance when creating many memory cgroups
>>
>> [1] https://lore.kernel.org/r/20251126171513.GC135004@cmpxchg.org
>> [2] https://lore.kernel.org/r/20221222041905.2431096-7-yuzhao@google.com
>> Suggested-by: Johannes Weiner <hannes@cmxpchg.org>
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> Acked-by: Johannes Weiner <hannes@cmxpchg.org>
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
>>  {
>> -	int op;
>> -	int gen;
>> -	int bin;
>> -	int first_bin;
>> -	struct lruvec *lruvec;
>> -	struct lru_gen_folio *lrugen;
>> +	struct mem_cgroup *target = sc->target_mem_cgroup;
>> +	struct mem_cgroup_reclaim_cookie reclaim = {
>> +		.pgdat = pgdat,
>> +	};
>> +	struct mem_cgroup_reclaim_cookie *cookie = &reclaim;
> 
> Please keep the naming same as shrink_node_memcgs i.e. use 'partial'
> here.
> 

Thank you, will update.

>>  	struct mem_cgroup *memcg;
>> -	struct hlist_nulls_node *pos;
>>  
>> -	gen = get_memcg_gen(READ_ONCE(pgdat->memcg_lru.seq));
>> -	bin = first_bin = get_random_u32_below(MEMCG_NR_BINS);
>> -restart:
>> -	op = 0;
>> -	memcg = NULL;
>> -
>> -	rcu_read_lock();
>> +	if (current_is_kswapd() || sc->memcg_full_walk)
>> +		cookie = NULL;
>>  
>> -	hlist_nulls_for_each_entry_rcu(lrugen, pos, &pgdat->memcg_lru.fifo[gen][bin], list) {
>> -		if (op) {
>> -			lru_gen_rotate_memcg(lruvec, op);
>> -			op = 0;
>> -		}
>> +	memcg = mem_cgroup_iter(target, NULL, cookie);
>> +	while (memcg) {
> 
> Please use the do-while loop same as shrink_node_memcgs and then change
> the goto next below to continue similar to shrink_node_memcgs.
> 

Will update.

>> +		struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
>>  
>> -		mem_cgroup_put(memcg);
>> -		memcg = NULL;
>> +		cond_resched();
>>  
>> -		if (gen != READ_ONCE(lrugen->gen))
>> -			continue;
>> +		mem_cgroup_calculate_protection(target, memcg);
>>  
>> -		lruvec = container_of(lrugen, struct lruvec, lrugen);
>> -		memcg = lruvec_memcg(lruvec);
>> +		if (mem_cgroup_below_min(target, memcg))
>> +			goto next;
>>  
>> -		if (!mem_cgroup_tryget(memcg)) {
>> -			lru_gen_release_memcg(memcg);
>> -			memcg = NULL;
>> -			continue;
>> +		if (mem_cgroup_below_low(target, memcg)) {
>> +			if (!sc->memcg_low_reclaim) {
>> +				sc->memcg_low_skipped = 1;
>> +				goto next;
>> +			}
>> +			memcg_memory_event(memcg, MEMCG_LOW);
>>  		}
>>  
>> -		rcu_read_unlock();
>> +		shrink_one(lruvec, sc);
>>  
>> -		op = shrink_one(lruvec, sc);
>> -
>> -		rcu_read_lock();
>> -
>> -		if (should_abort_scan(lruvec, sc))
>> +		if (should_abort_scan(lruvec, sc)) {
>> +			if (cookie)
>> +				mem_cgroup_iter_break(target, memcg);
>>  			break;
> 
> This seems buggy as we may break the loop without calling
> mem_cgroup_iter_break(). I think for kswapd the cookie will be NULL and
> if should_abort_scan() returns true, we will break the loop without
> calling mem_cgroup_iter_break() and will leak a reference to memcg.
> 

Thank you for catching that—my mistake.

This also brings up another point: In kswapd, the traditional LRU iterates through all memcgs, but
stops for the generational LRU (GENLRU) when should_abort_scan is met (i.e., enough pages are
reclaimed or the watermark is satisfied). Shouldn't both behave consistently?

Perhaps we should add should_abort_scan(lruvec, sc) in shrink_node_memcgs for the traditional LRU as
well?

-- 
Best regards,
Ridong


