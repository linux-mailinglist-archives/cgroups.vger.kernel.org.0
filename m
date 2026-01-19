Return-Path: <cgroups+bounces-13305-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A2ADCD39CC1
	for <lists+cgroups@lfdr.de>; Mon, 19 Jan 2026 04:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FC483005FEE
	for <lists+cgroups@lfdr.de>; Mon, 19 Jan 2026 03:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C90922156C;
	Mon, 19 Jan 2026 03:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OskWVJCa"
X-Original-To: cgroups@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796011A3164
	for <cgroups@vger.kernel.org>; Mon, 19 Jan 2026 03:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768793090; cv=none; b=soS6aRpteRBACqyDxdYMB1mBv2rMGPuLUhRra8bSXGLZtkaEch4fXLKgY42SLuH31qLK0mA3bEUr1QzQysf61xyfabwA9xN1GshyQdTbhKtwy3QO2XSGxdEp1dcaHYnqKnZCaXJim8qlW+O3yqNI8nzHjWOlGWC5uGTMbj6SkXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768793090; c=relaxed/simple;
	bh=jzXsGxtT70+MWEo53uhk4O3ogtfSqP+0Oy7gA2WYtZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dULo6v21S13mw9qVmdHZ5GbNUkA2cduNUhhknMQWqy1e4qvs7blYqWCvrIRJaqKsV3TFzK0ou380yoTMBQDPYT2ZNz2ZHPJeHafj2jA+p227ObUMh9Pnfbtw7Pbu5gTBVOewWH2aubAeeIZ4gnlp1gLpDXqiQYZgXycco9KuNrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OskWVJCa; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4d666f52-1494-4a93-b541-b02b46a887e3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768793086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/u7bgCCXQygRKXDqWsDO9xgbjYn7erHByh7PdAeVAHI=;
	b=OskWVJCaxAXJlAIn800rXjaLTv7UE7fT/d6va/GzZJ7d2syED6eSb5Xu1Z+9EZAk+4B0YH
	aGRijvZNaPzjg5K3vMcPaLahpdM1ZodPqVONh11wLhj/ivSymTcMcUFdLdJW8RlqcdxYzT
	7mos5S1EPq9w+NQZx/lxjE/iGikc11g=
Date: Mon, 19 Jan 2026 11:24:22 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 25/30] mm: vmscan: prepare for reparenting traditional
 LRU folios
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
References: <cover.1768389889.git.zhengqi.arch@bytedance.com>
 <3adb367000706f9ef681b34d0a2b0eb34c494c84.1768389889.git.zhengqi.arch@bytedance.com>
 <6hlbucao3tfp2bxyaekcrvhqclji4hyhq4wen4sccc2qcdr6x2@rtmqrfwfsy4s>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <6hlbucao3tfp2bxyaekcrvhqclji4hyhq4wen4sccc2qcdr6x2@rtmqrfwfsy4s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 1/18/26 9:11 AM, Shakeel Butt wrote:
> On Wed, Jan 14, 2026 at 07:32:52PM +0800, Qi Zheng wrote:
>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>
> [...]
>> --- a/mm/swap.c
>> +++ b/mm/swap.c
>> @@ -1090,6 +1090,43 @@ void folio_batch_remove_exceptionals(struct folio_batch *fbatch)
>>   	fbatch->nr = j;
>>   }
>>   
> 
> Why not define the following two functions in memcontrol.c?

Ah, Because Johannes previously suggested [1] putting it in swap.c:

```
Lastly, vmscan.c is the reclaim policy. Mechanical LRU shuffling like
this is better placed in mm/swap.c.
```

[1]. https://lore.kernel.org/all/aUQCfdnoLQDLoVyg@cmpxchg.org/

> 
>> +#ifdef CONFIG_MEMCG
>> +static void lruvec_reparent_lru(struct lruvec *child_lruvec,
>> +				struct lruvec *parent_lruvec,
>> +				enum lru_list lru, int nid)
>> +{
>> +	int zid;
>> +	struct zone *zone;
>> +
>> +	if (lru != LRU_UNEVICTABLE)
>> +		list_splice_tail_init(&child_lruvec->lists[lru], &parent_lruvec->lists[lru]);
>> +
>> +	for_each_managed_zone_pgdat(zone, NODE_DATA(nid), zid, MAX_NR_ZONES - 1) {
>> +		unsigned long size = mem_cgroup_get_zone_lru_size(child_lruvec, lru, zid);
>> +
>> +		mem_cgroup_update_lru_size(parent_lruvec, lru, zid, size);
>> +	}
>> +}
>> +
>> +void lru_reparent_memcg(struct mem_cgroup *memcg, struct mem_cgroup *parent)
>> +{
>> +	int nid;
>> +
>> +	for_each_node(nid) {
>> +		enum lru_list lru;
>> +		struct lruvec *child_lruvec, *parent_lruvec;
>> +
>> +		child_lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(nid));
>> +		parent_lruvec = mem_cgroup_lruvec(parent, NODE_DATA(nid));
>> +		parent_lruvec->anon_cost += child_lruvec->anon_cost;
>> +		parent_lruvec->file_cost += child_lruvec->file_cost;
>> +
>> +		for_each_lru(lru)
>> +			lruvec_reparent_lru(child_lruvec, parent_lruvec, lru, nid);
>> +	}
>> +}
>> +#endif
>> +
> 
> 


