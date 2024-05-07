Return-Path: <cgroups+bounces-2823-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A65988BE454
	for <lists+cgroups@lfdr.de>; Tue,  7 May 2024 15:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AB611F27557
	for <lists+cgroups@lfdr.de>; Tue,  7 May 2024 13:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C3515ECFC;
	Tue,  7 May 2024 13:31:45 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187F216C45B;
	Tue,  7 May 2024 13:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715088705; cv=none; b=XEUQlKqYqefET9OgKgQGIhN/huhtMDK5LSKS/XfwVh/BOX6B8kTA3XGqLBuZF6i52sg+FC6hFwygmu4pKBdgUJlAtBEYA0x+08hbbRQq1BkomoqKvX3r205Wwauje+eIdjxAVQk9T/MDqScQIk+2g7FuUvP675vgIu3TP0tOtQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715088705; c=relaxed/simple;
	bh=Z3Oh7sCEytYAY+1dl6YfvZQmJ7dlWmL4kQ0K0NhJyGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Vp7p4L9eF0ZRWGLWYt+V3VDMp0bG6ZmZvxCnIqcrIcabIEBWKct2NJI9TDXa0/iA9R0i+OGYjZyw4BM7c/K4kX3lDspM2i7QMbU6zvJwAr1W0a9KP8gedfellJbwrUbg5eK00cycgviqe8FU8Q0Re2FWEJiw6V1em85o3pYdCg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VYfH32hTsztT4H;
	Tue,  7 May 2024 21:28:15 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id 7EE801800C9;
	Tue,  7 May 2024 21:31:40 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 21:31:40 +0800
Message-ID: <10484734-13e6-4c56-d7dc-6c4cf74bd8de@huawei.com>
Date: Tue, 7 May 2024 21:31:39 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 -next] mm: memcg: make alloc_mem_cgroup_per_node_info()
 return bool
Content-Language: en-US
To: Michal Hocko <mhocko@suse.com>
CC: <hannes@cmpxchg.org>, <roman.gushchin@linux.dev>,
	<shakeel.butt@linux.dev>, <muchun.song@linux.dev>,
	<akpm@linux-foundation.org>, <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20240507110832.1128370-1-xiujianfeng@huawei.com>
 <ZjooSnQ_vS30EXCT@tiehlicka>
From: xiujianfeng <xiujianfeng@huawei.com>
In-Reply-To: <ZjooSnQ_vS30EXCT@tiehlicka>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500023.china.huawei.com (7.185.36.114)



On 2024/5/7 21:10, Michal Hocko wrote:
> On Tue 07-05-24 11:08:32, Xiu Jianfeng wrote:
>> Currently alloc_mem_cgroup_per_node_info() returns 1 if failed,
>> make it return bool, false for failure and true for success.
> 
> This describes what the patch does rather than why it is doing that.
> The former is clear from the diff while the motivation for this change
> is unclear. I would propose something like:
> 
> alloc_mem_cgroup_per_node_info() returns int that doesn't map to any
> errno error code. The only existing caller doesn't really need an error
> code so change the the function to return bool (true on success) because
> this is slightly less confusing and more consistent with the other code.

Thanks, it looks much better now.

> 
>> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> 
> With changelog clarified feel free to add
> Acked-by: Michal Hocko <mhocko@suse.com>
> 
>> ---
>>  mm/memcontrol.c | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index d11536ef59ef..69d70feb8e68 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -5653,13 +5653,13 @@ struct mem_cgroup *mem_cgroup_get_from_ino(unsigned long ino)
>>  }
>>  #endif
>>  
>> -static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
>> +static bool alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
>>  {
>>  	struct mem_cgroup_per_node *pn;
>>  
>>  	pn = kzalloc_node(sizeof(*pn), GFP_KERNEL, node);
>>  	if (!pn)
>> -		return 1;
>> +		return false;
>>  
>>  	pn->lruvec_stats = kzalloc_node(sizeof(struct lruvec_stats), GFP_KERNEL,
>>  					node);
>> @@ -5675,11 +5675,11 @@ static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
>>  	pn->memcg = memcg;
>>  
>>  	memcg->nodeinfo[node] = pn;
>> -	return 0;
>> +	return true;
>>  fail:
>>  	kfree(pn->lruvec_stats);
>>  	kfree(pn);
>> -	return 1;
>> +	return false;
>>  }
>>  
>>  static void free_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
>> @@ -5751,7 +5751,7 @@ static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
>>  	}
>>  
>>  	for_each_node(node)
>> -		if (alloc_mem_cgroup_per_node_info(memcg, node))
>> +		if (!alloc_mem_cgroup_per_node_info(memcg, node))
>>  			goto fail;
>>  
>>  	if (memcg_wb_domain_init(memcg, GFP_KERNEL))
>> -- 
>> 2.34.1
>>
> 

