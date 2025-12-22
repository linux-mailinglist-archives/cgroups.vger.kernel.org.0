Return-Path: <cgroups+bounces-12571-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FB5CD4AD3
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 05:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA7AC300760D
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 04:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5A12FDC22;
	Mon, 22 Dec 2025 04:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V6/uE91c"
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A5F18DF80
	for <cgroups@vger.kernel.org>; Mon, 22 Dec 2025 04:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766376148; cv=none; b=VnVrAPxSjhvZ2V+svGGsSsy2pX86en10k376Vwk939IxF00JpOLvTEyk9PZbQwBGYiGGE5QZ4ybb61lBg3WAaNRPWXs2MqjVGyD8EcwtAdUEbaAiiyh1jIkv1L4/nSddOdvKTjwDu/nS0Nj66xyLLAEEA5+yqjScDFPH8r0OMnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766376148; c=relaxed/simple;
	bh=2wMOnGongRa/kyIn7SUV+xFRVFlozB+L4nxPmlBfVRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hOFTuQyCsjseW+W6fZAtwoH/qZzXDEVLzGq8uGAQ63nRp6/kGrDibuQx7K+Sji4/bAODnt+4Ije6hUvbKZ6q/tdmInJh4qFJHgYftGdcSjgW6xrQu9AWMjXni7QgMAx8j50X0211cWH7KWSOZ9sTWR3dUly0ZS2xijGsjdJ0FBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V6/uE91c; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <59867ffa-7e5d-442f-8e8e-79d5512e03c1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766376139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E8FBk6lNZ9dRAmbI0dX/dkHT+ceGlZUbr6C5gAhuy3k=;
	b=V6/uE91cWY683In/e2wrMi2y7uYHTGMMTqM5DDPH8wgIwEsn0MWLF49vXKTFwmbN/vX4VP
	vh6AkuxI9K0XZy+np0SqpvJzBANodlUdtPWSfsqXrpMFNdXnexFC9B1Vc+fyhE9Is5DBUT
	AjEW6lareQy166USAQATDXjHm/cvKHg=
Date: Mon, 22 Dec 2025 12:02:11 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 15/28] mm: memcontrol: prevent memory cgroup release in
 mem_cgroup_swap_full()
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, muchun.song@linux.dev, david@kernel.org,
 lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com,
 imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 chenridong@huaweicloud.com, mkoutny@suse.com, akpm@linux-foundation.org,
 hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
 lance.yang@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>,
 Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <4dd1fb48ef4367e0932dbe7265d876bd95880808.1765956025.git.zhengqi.arch@bytedance.com>
 <hvta76slujbvyb4av4cgipcevd7jctjrq2tmyw2pwpynfpjytg@ihr3aqp2brzq>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <hvta76slujbvyb4av4cgipcevd7jctjrq2tmyw2pwpynfpjytg@ihr3aqp2brzq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 12/20/25 9:05 AM, Shakeel Butt wrote:
> On Wed, Dec 17, 2025 at 03:27:39PM +0800, Qi Zheng wrote:
>> From: Muchun Song <songmuchun@bytedance.com>
>>
>> In the near future, a folio will no longer pin its corresponding
>> memory cgroup. To ensure safety, it will only be appropriate to
>> hold the rcu read lock or acquire a reference to the memory cgroup
>> returned by folio_memcg(), thereby preventing it from being released.
>>
>> In the current patch, the rcu read lock is employed to safeguard
>> against the release of the memory cgroup in mem_cgroup_swap_full().
>>
>> This serves as a preparatory measure for the reparenting of the
>> LRU pages.
>>
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
>> ---
>>   mm/memcontrol.c | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 131f940c03fa0..f2c891c1f49d5 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -5267,17 +5267,21 @@ bool mem_cgroup_swap_full(struct folio *folio)
>>   	if (do_memsw_account())
>>   		return false;
>>   
>> -	memcg = folio_memcg(folio);
>> -	if (!memcg)
>> +	if (!folio_memcg_charged(folio))
>>   		return false;
>>   
>> +	rcu_read_lock();
>> +	memcg = folio_memcg(folio);
>>   	for (; !mem_cgroup_is_root(memcg); memcg = parent_mem_cgroup(memcg)) {
>>   		unsigned long usage = page_counter_read(&memcg->swap);
>>   
>>   		if (usage * 2 >= READ_ONCE(memcg->swap.high) ||
>> -		    usage * 2 >= READ_ONCE(memcg->swap.max))
>> +		    usage * 2 >= READ_ONCE(memcg->swap.max)) {
>> +			rcu_read_unlock();
>>   			return true;
>> +		}
>>   	}
>> +	rcu_read_unlock();
>>   
>>   	return false;
>>   }
> 
> How about the following?
> 
> 
>   bool mem_cgroup_swap_full(struct folio *folio)
>   {
>   	struct mem_cgroup *memcg;
> +	bool ret = false;
>   
>   	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
>   
>   	if (vm_swap_full())
>   		return true;
> -	if (do_memsw_account())
> -		return false;
>   
> -	if (!folio_memcg_charged(folio))
> -		return false;
> +	if (do_memsw_account() || !folio_memcg_charged(folio))
> +		return ret;
>   
>   	rcu_read_lock();
>   	memcg = folio_memcg(folio);
> @@ -5277,13 +5276,13 @@ bool mem_cgroup_swap_full(struct folio *folio)
>   
>   		if (usage * 2 >= READ_ONCE(memcg->swap.high) ||
>   		    usage * 2 >= READ_ONCE(memcg->swap.max)) {
> -			rcu_read_unlock();
> -			return true;
> +			ret = true;
> +			break;
>   		}
>   	}
>   	rcu_read_unlock();
>   
> -	return false;
> +	return ret;
>   }

LGTM, will do.

>   
> 
> Anyways LGTM.
> 
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

Thanks!



