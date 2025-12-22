Return-Path: <cgroups+bounces-12570-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B42CD4AC7
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 05:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DD9C6300AE84
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 04:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B128518DF80;
	Mon, 22 Dec 2025 04:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g6v2xQ7M"
X-Original-To: cgroups@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65011186284
	for <cgroups@vger.kernel.org>; Mon, 22 Dec 2025 04:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766376016; cv=none; b=N6c63ZH7FE3MVlFXTB9C9T4wtGIqgKWcLb+RkxsPs+kaF8+i3TUhUWizZ3/e5PAGoJNg7Uw8Eh7mBpgK2yAS3bInPIAc+wPA0Z1mZVoz/4VjEC4+CEbmIMWJvh9dGMVHp3LCOZ0p/4N7AZbizoL22pRlf3ty2PyorPBMNtvZg78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766376016; c=relaxed/simple;
	bh=OZlhHKFf880tmiATXAQnfD66GEEFlZE910pDgOiP98s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fR+oINIlDqAqqZRZWLkp+8tJphTTvT4NvyEn2nm0neP+vav2K2PAretmp2mzXu+1skfROpXAv63sBAKFocqvzIm4tlaTanW0xIpIGLbuFbfj5CTus7JoKQER06thpfflg2PaMYj3yEs1wWd24J178o+U0yOhFtgjSuWviRpKhrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g6v2xQ7M; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <646b9414-baf6-4278-b4df-5f4abeca5e67@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766375996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oMAUFbvixYMyej2RaSYfA1urQk5c5I28T+hhpcsE9H0=;
	b=g6v2xQ7M8QO66aigU0pLALSMnoZMrAa0ibLD6yQBpo955FlVEJHREynjUrmcTOE07I8f0P
	kpM7NEgztyVHuj9o+us7wsmmttYuoj6+q3bQ6rdT/yygYGfMGCeh5Mgad3knDvZ3QfhA0T
	Y6t6WGSMh9/TudxQzDc1wnao7Oa/uWg=
Date: Mon, 22 Dec 2025 11:59:46 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 27/28] mm: memcontrol: eliminate the problem of dying
 memory cgroup for LRU folios
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: hughd@google.com, mhocko@suse.com, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, muchun.song@linux.dev, david@kernel.org,
 lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com,
 imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 chenridong@huaweicloud.com, mkoutny@suse.com, akpm@linux-foundation.org,
 hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
 lance.yang@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>,
 Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <c08f964513f9eb6a04f80f1a900e3494a99b7e0d.1765956026.git.zhengqi.arch@bytedance.com>
 <aUQKdZsMclicBDYx@cmpxchg.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <aUQKdZsMclicBDYx@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 12/18/25 10:06 PM, Johannes Weiner wrote:
> On Wed, Dec 17, 2025 at 03:27:51PM +0800, Qi Zheng wrote:
>> From: Muchun Song <songmuchun@bytedance.com>
>>
>> Pagecache pages are charged at allocation time and hold a reference
>> to the original memory cgroup until reclaimed. Depending on memory
>> pressure, page sharing patterns between different cgroups and cgroup
>> creation/destruction rates, many dying memory cgroups can be pinned
>> by pagecache pages, reducing page reclaim efficiency and wasting
>> memory. Converting LRU folios and most other raw memory cgroup pins
>> to the object cgroup direction can fix this long-living problem.
> 
> This is already in the coverletter. Please describe here what the
> patch itself does. IOW, now that everything is set up, switch
> folio->memcg_data pointers to objcgs, update the accessors, and
> execute reparenting on cgroup death.

Got it, will do.

> 
>> Finally, folio->memcg_data of LRU folios and kmem folios will always
>> point to an object cgroup pointer. The folio->memcg_data of slab
>> folios will point to an vector of object cgroups.
> 
>> @@ -223,22 +223,55 @@ static inline void __memcg_reparent_objcgs(struct mem_cgroup *src,
>>   
>>   static inline void reparent_locks(struct mem_cgroup *src, struct mem_cgroup *dst)
>>   {
>> +	int nid, nest = 0;
>> +
>>   	spin_lock_irq(&objcg_lock);
>> +	for_each_node(nid) {
>> +		spin_lock_nested(&mem_cgroup_lruvec(src,
>> +				 NODE_DATA(nid))->lru_lock, nest++);
>> +		spin_lock_nested(&mem_cgroup_lruvec(dst,
>> +				 NODE_DATA(nid))->lru_lock, nest++);
>> +	}
>>   }
> 
> Looks okay to me. If this should turn out to be a scalability problem
> in practice, we can make objcgs per-node, and then reparent lru/objcg
> pairs on a per-node basis without nesting locks.
> 
>>   static inline void reparent_unlocks(struct mem_cgroup *src, struct mem_cgroup *dst)
>>   {
>> +	int nid;
>> +
>> +	for_each_node(nid) {
>> +		spin_unlock(&mem_cgroup_lruvec(dst, NODE_DATA(nid))->lru_lock);
>> +		spin_unlock(&mem_cgroup_lruvec(src, NODE_DATA(nid))->lru_lock);
>> +	}
>>   	spin_unlock_irq(&objcg_lock);
>>   }
>>   
>> +static void memcg_reparent_lru_folios(struct mem_cgroup *src,
>> +				      struct mem_cgroup *dst)
>> +{
>> +	if (lru_gen_enabled())
>> +		lru_gen_reparent_memcg(src, dst);
>> +	else
>> +		lru_reparent_memcg(src, dst);
>> +}
>> +
>>   static void memcg_reparent_objcgs(struct mem_cgroup *src)
>>   {
>>   	struct obj_cgroup *objcg = rcu_dereference_protected(src->objcg, true);
>>   	struct mem_cgroup *dst = parent_mem_cgroup(src);
>>   
>> +retry:
>> +	if (lru_gen_enabled())
>> +		max_lru_gen_memcg(dst);
>> +
>>   	reparent_locks(src, dst);
>> +	if (lru_gen_enabled() && !recheck_lru_gen_max_memcg(dst)) {
>> +		reparent_unlocks(src, dst);
>> +		cond_resched();
>> +		goto retry;
>> +	}
>>   
>>   	__memcg_reparent_objcgs(src, dst);
>> +	memcg_reparent_lru_folios(src, dst);
> 
> Please inline memcg_reparent_lru_folios() here, to keep the lru vs
> lrugen switching as "flat" as possible:
> 
> 	if (lru_gen_enabled()) {
> 		if (!recheck_lru_gen_max_memcgs(parent)) {
> 			reparent_unlocks(memcg, parent);
> 			cond_resched();
> 			goto retry;
> 		}
> 		lru_gen_reparent_memcg(memcg, parent);
> 	} else {
> 		lru_reparent_memcg(memcg, parent);
> 	}

Looks better, will change to this style.

> 
>> @@ -989,6 +1022,8 @@ struct mem_cgroup *get_mem_cgroup_from_current(void)
>>   /**
>>    * get_mem_cgroup_from_folio - Obtain a reference on a given folio's memcg.
>>    * @folio: folio from which memcg should be extracted.
>> + *
>> + * The folio and objcg or memcg binding rules can refer to folio_memcg().
> 
>        See folio_memcg() for folio->objcg/memcg binding rules.

OK, will do.



