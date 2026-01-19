Return-Path: <cgroups+bounces-13307-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B16E7D39D13
	for <lists+cgroups@lfdr.de>; Mon, 19 Jan 2026 04:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 10B6E3008D52
	for <lists+cgroups@lfdr.de>; Mon, 19 Jan 2026 03:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CDE22156C;
	Mon, 19 Jan 2026 03:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K4oPwNFi"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493AA18D636
	for <cgroups@vger.kernel.org>; Mon, 19 Jan 2026 03:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768793804; cv=none; b=hD/q730OWovqMBGfHmnH/NRsgNWkagScBvjUK1z428SjI483eKPFOVyAOjI+pCYXk3lYsMOMP7Ap//u/JGBnCDhZaApjAAcY2LJSpVMMOYihvKyUIFdP9UajX7nEgSvI/9L/P9JAHK7EOOJm1crZLAgLkigN/i4dlNoS+lJ3ttM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768793804; c=relaxed/simple;
	bh=A1ZStKDHX8PC9kUyERRAj1N4wlpejudu7jYMGVigurg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tQWeturymVEjGx0siba/ldE5Sn7lKjIvIA6Za//2OTQe1JeAFDfVEh+XMk5fahaCXYN6YmNWQo2eZC8Dyq5I0OikyX78cu2gPPlswBbr/d4OmdQpDh4oLxGPymi8y5PFVUFGLNfO4W/TcNnpWpPrWKV+P+kDO79mddqrH+Lt9hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K4oPwNFi; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5a18658e-2076-4cbf-bc53-5b6e99c1035f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768793800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zjUkuAvDq1kbP7Yz/kqOd0wZArWceBOYUbLr4Pg1vNY=;
	b=K4oPwNFiGFyV+NJw8nAVDM3CJA8PoBCifJDZPx/uLBRBFo+8Qmj7a30s9y4H3X5t8xkNgL
	pzljrwvHFb6sOYYSokqdt4hp5Phu4hiR+XFrsv+DLJXgwdd9cw6Mw9oGdzn7lz1kWd488L
	U66g/pBHYQmdIXzkKIFueEgnOYtxk78=
Date: Mon, 19 Jan 2026 11:36:24 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 28/30 fix 1/2] mm: memcontrol: fix
 lruvec_stats->state_local reparenting
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, muchun.song@linux.dev, david@kernel.org,
 lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com,
 yosry.ahmed@linux.dev, imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 chenridong@huaweicloud.com, mkoutny@suse.com, akpm@linux-foundation.org,
 hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
 lance.yang@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
References: <b11a0bde9fe18673a61a79398f226ad7cb04a894.1768389889.git.zhengqi.arch@bytedance.com>
 <e5afd1b5ae95d70f82433b9b4e13201342d16707.1768473427.git.zhengqi.arch@bytedance.com>
 <ifcth3hxyrwmmeo3nejettdtkw2ndxdjbylszmhq3vohuhsncl@k23pew6gywko>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <ifcth3hxyrwmmeo3nejettdtkw2ndxdjbylszmhq3vohuhsncl@k23pew6gywko>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 1/18/26 11:22 AM, Shakeel Butt wrote:
> On Thu, Jan 15, 2026 at 06:41:38PM +0800, Qi Zheng wrote:
>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   include/linux/memcontrol.h |  2 --
>>   mm/memcontrol-v1.c         |  8 --------
>>   mm/memcontrol-v1.h         |  5 ++++-
>>   mm/memcontrol.c            | 19 ++++++++-----------
>>   4 files changed, 12 insertions(+), 22 deletions(-)
>>
>> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>> index 1fe554eec1e25..e0b84b109b7ac 100644
>> --- a/include/linux/memcontrol.h
>> +++ b/include/linux/memcontrol.h
>> @@ -944,8 +944,6 @@ bool memcg_vm_event_item_valid(enum vm_event_item idx);
>>   unsigned long lruvec_page_state(struct lruvec *lruvec, enum node_stat_item idx);
>>   unsigned long lruvec_page_state_local(struct lruvec *lruvec,
>>   				      enum node_stat_item idx);
>> -void reparent_memcg_lruvec_state_local(struct mem_cgroup *memcg,
>> -				       struct mem_cgroup *parent, int idx);
>>   
>>   void mem_cgroup_flush_stats(struct mem_cgroup *memcg);
>>   void mem_cgroup_flush_stats_ratelimited(struct mem_cgroup *memcg);
>> diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
>> index 03b924920d6a5..daf9bad8c45ea 100644
>> --- a/mm/memcontrol-v1.c
>> +++ b/mm/memcontrol-v1.c
>> @@ -1909,14 +1909,6 @@ void reparent_memcg1_state_local(struct mem_cgroup *memcg, struct mem_cgroup *pa
>>   		reparent_memcg_state_local(memcg, parent, memcg1_stats[i]);
>>   }
>>   
>> -void reparent_memcg1_lruvec_state_local(struct mem_cgroup *memcg, struct mem_cgroup *parent)
>> -{
>> -	int i;
>> -
>> -	for (i = 0; i < ARRAY_SIZE(memcg1_stats); i++)
>> -		reparent_memcg_lruvec_state_local(memcg, parent, memcg1_stats[i]);
>> -}
>> -
>>   void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
>>   {
>>   	unsigned long memory, memsw;
>> diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
>> index 45528195d3578..5b1188f3d4173 100644
>> --- a/mm/memcontrol-v1.h
>> +++ b/mm/memcontrol-v1.h
>> @@ -75,7 +75,6 @@ void memcg1_uncharge_batch(struct mem_cgroup *memcg, unsigned long pgpgout,
>>   
>>   void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s);
>>   void reparent_memcg1_state_local(struct mem_cgroup *memcg, struct mem_cgroup *parent);
>> -void reparent_memcg1_lruvec_state_local(struct mem_cgroup *memcg, struct mem_cgroup *parent);
>>   
>>   void memcg1_account_kmem(struct mem_cgroup *memcg, int nr_pages);
>>   static inline bool memcg1_tcpmem_active(struct mem_cgroup *memcg)
>> @@ -116,6 +115,10 @@ static inline void memcg1_uncharge_batch(struct mem_cgroup *memcg,
>>   
>>   static inline void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s) {}
>>   
>> +static inline void reparent_memcg1_state_local(struct mem_cgroup *memcg, struct mem_cgroup *parent)
>> +{
>> +}
>> +
>>   static inline void memcg1_account_kmem(struct mem_cgroup *memcg, int nr_pages) {}
>>   static inline bool memcg1_tcpmem_active(struct mem_cgroup *memcg) { return false; }
>>   static inline bool memcg1_charge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages,
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 7333a37830051..b7b35143d4d2d 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -225,13 +225,13 @@ static inline struct obj_cgroup *__memcg_reparent_objcgs(struct mem_cgroup *memc
>>   	return objcg;
>>   }
>>   
>> -#ifdef CONFIG_MEMCG_V1
>> +static void reparent_memcg_lruvec_state_local(struct mem_cgroup *memcg,
>> +					      struct mem_cgroup *parent, int idx);
>>   static void __mem_cgroup_flush_stats(struct mem_cgroup *memcg, bool force);
>>   
>>   static inline void reparent_state_local(struct mem_cgroup *memcg, struct mem_cgroup *parent)
>>   {
> 
> No reparenting local stats for v2.

It seems that lruvec_stats->state_local (non-hierarchical) needs to be
relocated in both v1 and v2.

> 
>> -	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
>> -		return;
>> +	int i;
>>   
>>   	synchronize_rcu();
>>   
>> @@ -239,13 +239,10 @@ static inline void reparent_state_local(struct mem_cgroup *memcg, struct mem_cgr
>>   
>>   	/* The following counts are all non-hierarchical and need to be reparented. */
>>   	reparent_memcg1_state_local(memcg, parent);
>> -	reparent_memcg1_lruvec_state_local(memcg, parent);
>> -}
>> -#else
>> -static inline void reparent_state_local(struct mem_cgroup *memcg, struct mem_cgroup *parent)
>> -{
>> +
>> +	for (i = 0; i < NR_LRU_LISTS; i++)
>> +		reparent_memcg_lruvec_state_local(memcg, parent, i);
>>   }
>> -#endif
>>   
>>   static inline void reparent_locks(struct mem_cgroup *memcg, struct mem_cgroup *parent)
>>   {
>> @@ -510,8 +507,8 @@ unsigned long lruvec_page_state_local(struct lruvec *lruvec,
>>   	return x;
>>   }
>>   
>> -void reparent_memcg_lruvec_state_local(struct mem_cgroup *memcg,
>> -				       struct mem_cgroup *parent, int idx)
>> +static void reparent_memcg_lruvec_state_local(struct mem_cgroup *memcg,
>> +					      struct mem_cgroup *parent, int idx)
>>   {
>>   	int i = memcg_stats_index(idx);
>>   	int nid;
>> -- 
>> 2.20.1
>>


