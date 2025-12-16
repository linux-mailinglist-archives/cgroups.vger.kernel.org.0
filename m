Return-Path: <cgroups+bounces-12370-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B74ACC06DA
	for <lists+cgroups@lfdr.de>; Tue, 16 Dec 2025 02:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 453B6301FFAC
	for <lists+cgroups@lfdr.de>; Tue, 16 Dec 2025 01:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1242230BEC;
	Tue, 16 Dec 2025 01:14:53 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD9F22B8C5;
	Tue, 16 Dec 2025 01:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765847693; cv=none; b=GDvSciJeKM3gBHZ8kZMgsPJnUpmRy7XBnf02A79XxHP8cSNa4rBT0FOpkq+iGzPLGfbIaq0UT77LecywXCVnhNm1bnEeuNTaVowSx5Um2zShJ+UeyJo/36wsCBwl87IDfW8xn+5yVLZOEBArBMB5edVT84yP7756YA/vF7F0/rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765847693; c=relaxed/simple;
	bh=NMVbv7FdsZnXUmzrzVHbU4yRVN2zeUQRFwVSQDn9b9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jqNytA+tS5Wa1WKuY9Rt/BH3D/Wa/NMHGltNhFC0UJeAdYtrNks9mzFi6sD/6OWDNE6It7/E2N94GYmxv3G1qnyb0NvY2k8rdyvQN9vaE5wjqWU1OxM37s21CuE1yJk8Q/LNlO5Y7GxRkJp2e4B2ylZufH6gjljOtBxcJerlXQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dVf8v0tSRzYQtmN;
	Tue, 16 Dec 2025 09:14:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7CE441A06E1;
	Tue, 16 Dec 2025 09:14:47 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgAniPiFskBpmppbAQ--.30924S2;
	Tue, 16 Dec 2025 09:14:47 +0800 (CST)
Message-ID: <6c69c4d9-f154-4ad3-93c8-907fa4f98b27@huaweicloud.com>
Date: Tue, 16 Dec 2025 09:14:45 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 3/5] mm/mglru: extend shrink_one for both lrugen and
 non-lrugen
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: akpm@linux-foundation.org, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, david@kernel.org, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, corbet@lwn.net, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, muchun.song@linux.dev, zhengqi.arch@bytedance.com,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, lujialin4@huawei.com, zhongjinji@honor.com
References: <20251209012557.1949239-1-chenridong@huaweicloud.com>
 <20251209012557.1949239-4-chenridong@huaweicloud.com>
 <20251215211357.GF905277@cmpxchg.org>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20251215211357.GF905277@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAniPiFskBpmppbAQ--.30924S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJw18ZFykuw4rtrW5AF1DJrb_yoWrur45pa
	9xJFyjyayrArnIgr9aqF4UW34a9w48Jr1xJryDur1rCF9aqFyrKw17CrW8urWUZr9Y9r13
	Ary2qw17Ww4jvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



On 2025/12/16 5:13, Johannes Weiner wrote:
> On Tue, Dec 09, 2025 at 01:25:55AM +0000, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> Currently, flush_reclaim_state is placed differently between
>> shrink_node_memcgs and shrink_many. shrink_many (only used for gen-LRU)
>> calls it after each lruvec is shrunk, while shrink_node_memcgs calls it
>> only after all lruvecs have been shrunk.
>>
>> This patch moves flush_reclaim_state into shrink_node_memcgs and calls it
>> after each lruvec. This unifies the behavior and is reasonable because:
>>
>> 1. flush_reclaim_state adds current->reclaim_state->reclaimed to
>>    sc->nr_reclaimed.
>> 2. For non-MGLRU root reclaim, this can help stop the iteration earlier
>>    when nr_to_reclaim is reached.
>> 3. For non-root reclaim, the effect is negligible since flush_reclaim_state
>>    does nothing in that case.
>>
>> After moving flush_reclaim_state into shrink_node_memcgs, shrink_one can be
>> extended to support both lrugen and non-lrugen paths. It will call
>> try_to_shrink_lruvec for lrugen root reclaim and shrink_lruvec otherwise.
>>
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>>  mm/vmscan.c | 57 +++++++++++++++++++++--------------------------------
>>  1 file changed, 23 insertions(+), 34 deletions(-)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 584f41eb4c14..795f5ebd9341 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -4758,23 +4758,7 @@ static bool try_to_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
>>  	return nr_to_scan < 0;
>>  }
>>  
>> -static void shrink_one(struct lruvec *lruvec, struct scan_control *sc)
>> -{
>> -	unsigned long scanned = sc->nr_scanned;
>> -	unsigned long reclaimed = sc->nr_reclaimed;
>> -	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
>> -	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
>> -
>> -	try_to_shrink_lruvec(lruvec, sc);
>> -
>> -	shrink_slab(sc->gfp_mask, pgdat->node_id, memcg, sc->priority);
>> -
>> -	if (!sc->proactive)
>> -		vmpressure(sc->gfp_mask, memcg, false, sc->nr_scanned - scanned,
>> -			   sc->nr_reclaimed - reclaimed);
>> -
>> -	flush_reclaim_state(sc);
>> -}
>> +static void shrink_one(struct lruvec *lruvec, struct scan_control *sc);
>>  
>>  static void shrink_many(struct pglist_data *pgdat, struct scan_control *sc)
>>  {
>> @@ -5760,6 +5744,27 @@ static inline bool should_continue_reclaim(struct pglist_data *pgdat,
>>  	return inactive_lru_pages > pages_for_compaction;
>>  }
>>  
>> +static void shrink_one(struct lruvec *lruvec, struct scan_control *sc)
>> +{
>> +	unsigned long scanned = sc->nr_scanned;
>> +	unsigned long reclaimed = sc->nr_reclaimed;
>> +	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
>> +	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
>> +
>> +	if (lru_gen_enabled() && root_reclaim(sc))
>> +		try_to_shrink_lruvec(lruvec, sc);
>> +	else
>> +		shrink_lruvec(lruvec, sc);
> 

Hi Johannes, thank you for your reply.

> Yikes. So we end up with:
> 
> shrink_node_memcgs()
>   shrink_one()
>     if lru_gen_enabled && root_reclaim(sc)
>       try_to_shrink_lruvec(lruvec, sc)
>     else
>       shrink_lruvec()
>         if lru_gen_enabled && !root_reclaim(sc)
>           lru_gen_shrink_lruvec(lruvec, sc)
>             try_to_shrink_lruvec()
> 
> I think it's doing too much at once. Can you get it into the following
> shape:
> 

You're absolutely right. This refactoring is indeed what patch 5/5 implements.

With patch 5/5 applied, the flow becomes:

shrink_node_memcgs()
    shrink_one()
        if lru_gen_enabled
	    lru_gen_shrink_lruvec  --> symmetric with else shrink_lruvec()
		if (root_reclaim(sc))  --> handle root reclaim.
		    try_to_shrink_lruvec()
		else
		    ...
		    try_to_shrink_lruvec()
	else
	    shrink_lruvec()

This matches the structure you described.

One note: shrink_one() is also called from lru_gen_shrink_node() when memcg is disabled, so I
believe it makes sense to keep this helper.

> shrink_node_memcgs()
>   for each memcg:
>     if lru_gen_enabled:
>       lru_gen_shrink_lruvec()
>     else
>       shrink_lruvec()
> 

Regarding the patch split, I currently kept patch 3/5 and 5/5 separate to make the changes clearer
in each step. Would you prefer that I merge patch 3/5 with patch 5/5, so the full refactoring
appears in one patch?

Looking forward to your guidance.

> and handle the differences in those two functions? Then look for
> overlap one level down, and so forth.

-- 
Best regards,
Ridong


