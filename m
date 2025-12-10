Return-Path: <cgroups+bounces-12322-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38274CB273D
	for <lists+cgroups@lfdr.de>; Wed, 10 Dec 2025 09:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79F9E3018989
	for <lists+cgroups@lfdr.de>; Wed, 10 Dec 2025 08:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32702DEA90;
	Wed, 10 Dec 2025 08:42:18 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA2A263F5E;
	Wed, 10 Dec 2025 08:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765356138; cv=none; b=QNgJ3Qd/99QuqhvW6kwD5CLVSsFwjWRog+wKYQfLMVB+yPmVMFwfNPInQptjtc6wBejxLP1hpslMCbgclEtZZvXXHW2r6s2KEK3GItWKJ/CyZYzeOf69PrMqVCggekir9JXAtJDoQ9NCZoJLr7zhPES1JXSjbLkk6T9+k2Jhvu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765356138; c=relaxed/simple;
	bh=FH4VIS3DuaKBb89fzHLlBkstNpXh24dwJBR5sodEUAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X5VQoSrvGKj2Yh8GCxfKbH42YpRwycPqpem/M8lxp7tRNhCIw7scxAtPT60WmGdFcR9B2GL1NAvMwiVa5/c8dvWpLfzM1VV9EeROTjac/WIroNdphBtgr8CAqEv/cBaFyH8cbs7ZRmeHzNstPEr7nffb4w0tRfMrEQKOhBVELX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dR8MD29qwzKHMn4;
	Wed, 10 Dec 2025 16:41:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 17BC31A084D;
	Wed, 10 Dec 2025 16:42:12 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP2 (Coremail) with SMTP id Syh0CgBXOFJiMjlpL9n3BA--.10261S2;
	Wed, 10 Dec 2025 16:42:11 +0800 (CST)
Message-ID: <48f734fa-531a-4b3f-9c96-02dd342d41d2@huaweicloud.com>
Date: Wed, 10 Dec 2025 16:42:09 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2 2/2] memcg: remove mem_cgroup_size()
To: Michal Hocko <mhocko@suse.com>
Cc: hannes@cmpxchg.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, akpm@linux-foundation.org, axelrasmussen@google.com,
 yuanchu@google.com, weixugc@google.com, david@kernel.org,
 zhengqi.arch@bytedance.com, lorenzo.stoakes@oracle.com,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com
References: <20251210071142.2043478-1-chenridong@huaweicloud.com>
 <20251210071142.2043478-3-chenridong@huaweicloud.com>
 <aTkp1tIIiw8Nti10@tiehlicka>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <aTkp1tIIiw8Nti10@tiehlicka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBXOFJiMjlpL9n3BA--.10261S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tF4kCFW8Wr18Kw13Wry8Krg_yoW8ur1UpF
	Wvka45ta15Ary3Jw1Sv348Z3sYv3y0qay5Jry7Cr1fZwsIqrn5tFy2k3WvqryUCF9xZFyI
	vayY9an3Cw429aUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	UQ6p9UUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/12/10 16:05, Michal Hocko wrote:
> On Wed 10-12-25 07:11:42, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> The mem_cgroup_size helper is used only in apply_proportional_protection
>> to read the current memory usage. Its semantics are unclear and
>> inconsistent with other sites, which directly call page_counter_read for
>> the same purpose.
>>
>> Remove this helper and replace its usage with page_counter_read for
>> clarity. Additionally, rename the local variable 'cgroup_size' to 'usage'
>> to better reflect its meaning.
>>
>> This change is safe because page_counter_read() is only called when memcg
>> is enabled in the apply_proportional_protection.
>>
>> No functional changes intended.
> 
> I would prefer to keep the code as is. 
> 

I find the mem_cgroup_size() function name misleading—it suggests counting the number of memory
cgroups, but it actually returns the current memory usage.

When looking for a clearer alternative, I found mem_cgroup_usage(), which is only called by v1. This
raised the question of whether mem_cgroup_size() is truly necessary. Moreover, I noticed other code
locations simply call page_counter_read() directly to obtain current usage.

> Btw.
> [...]
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 670fe9fae5ba..fe48d0376e7c 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -2451,6 +2451,7 @@ static inline void calculate_pressure_balance(struct scan_control *sc,
>>  static unsigned long apply_proportional_protection(struct mem_cgroup *memcg,
>>  		struct scan_control *sc, unsigned long scan)
>>  {
>> +#ifdef CONFIG_MEMCG
>>  	unsigned long min, low;
>>  
>>  	mem_cgroup_protection(sc->target_mem_cgroup, memcg, &min, &low);
> [...]
>> @@ -2508,6 +2509,7 @@ static unsigned long apply_proportional_protection(struct mem_cgroup *memcg,
>>  		 */
>>  		scan = max(scan, SWAP_CLUSTER_MAX);
>>  	}
>> +#endif
>>  	return scan;
>>  }
> 
> This returns a random garbage for !CONFIG_MEMCG, doesn't it?
> 

-- 
Best regards,
Ridong


