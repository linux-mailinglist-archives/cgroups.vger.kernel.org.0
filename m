Return-Path: <cgroups+bounces-12328-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB7CCB45CB
	for <lists+cgroups@lfdr.de>; Thu, 11 Dec 2025 01:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9C453300093F
	for <lists+cgroups@lfdr.de>; Thu, 11 Dec 2025 00:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C97E2222D0;
	Thu, 11 Dec 2025 00:43:38 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6468176ADE;
	Thu, 11 Dec 2025 00:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765413818; cv=none; b=D++ziKxWBg+q86P0l15+64ccj2ImYXR6949gMW3Fdaz95LIKsCawJrkPawpjukhwCcp0/0MMDNZqRj3SCyZCSCqyzpTS0dwAjjhrwJal0uq83vZOLO7PCIwHBsuQaxDbnDa/SihcxHrjkEESEsgXn8Uru3PlzaogMrMslnnTcIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765413818; c=relaxed/simple;
	bh=Sp1JtYU+ta8HbEjRIFh/Uzr1XWq2rUianePyu70WoTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n61UAaJUWlQZ5ckNBhFvvMZZ4pZLzoCmWzMl4xcmtN4T3LIM74kptnFG5gIDQ721eN/15UKXawkmRmxcudLhAIQo40Lgg+rVb22MXqmPCJjRpM9Z5AbXA3SzPvcnoT7T7r4v+tD7TVyRVI4ORfaRodR+2Aq64nnqkd9bPg/3Uao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dRYhQ70j2zKHMLZ;
	Thu, 11 Dec 2025 08:42:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id C57BA1A14D3;
	Thu, 11 Dec 2025 08:43:31 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP2 (Coremail) with SMTP id Syh0CgAH5k+yEzpp071GBQ--.40689S2;
	Thu, 11 Dec 2025 08:43:31 +0800 (CST)
Message-ID: <66201b4a-44a5-4221-810a-897699425195@huaweicloud.com>
Date: Thu, 11 Dec 2025 08:43:29 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2 2/2] memcg: remove mem_cgroup_size()
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, akpm@linux-foundation.org, axelrasmussen@google.com,
 yuanchu@google.com, weixugc@google.com, david@kernel.org,
 zhengqi.arch@bytedance.com, lorenzo.stoakes@oracle.com,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com
References: <20251210071142.2043478-1-chenridong@huaweicloud.com>
 <20251210071142.2043478-3-chenridong@huaweicloud.com>
 <20251210163634.GB643576@cmpxchg.org>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20251210163634.GB643576@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgAH5k+yEzpp071GBQ--.40689S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tF4kCFW8Wr18Kw13Wry8Krg_yoW8Kw4xpF
	yvyay7Kw4aqry5Kr1Yv3sYva4Fvw48ta45try7Gr1IqwnIgr1rtF9Fy3W8Wry5CF93XF17
	Za90gws7Cw42kFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/12/11 0:36, Johannes Weiner wrote:
> On Wed, Dec 10, 2025 at 07:11:42AM +0000, Chen Ridong wrote:
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
> 
> +1
> 
> I don't think the helper adds much.
> 
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
>> @@ -2485,7 +2486,7 @@ static unsigned long apply_proportional_protection(struct mem_cgroup *memcg,
>>  		 * again by how much of the total memory used is under
>>  		 * hard protection.
>>  		 */
>> -		unsigned long cgroup_size = mem_cgroup_size(memcg);
>> +		unsigned long usage = page_counter_read(&memcg->memory);
>>  		unsigned long protection;
>>  
>>  		/* memory.low scaling, make sure we retry before OOM */
>> @@ -2497,9 +2498,9 @@ static unsigned long apply_proportional_protection(struct mem_cgroup *memcg,
>>  		}
>>  
>>  		/* Avoid TOCTOU with earlier protection check */
>> -		cgroup_size = max(cgroup_size, protection);
>> +		usage = max(usage, protection);
>>  
>> -		scan -= scan * protection / (cgroup_size + 1);
>> +		scan -= scan * protection / (usage + 1);
>>  
>>  		/*
>>  		 * Minimally target SWAP_CLUSTER_MAX pages to keep
>> @@ -2508,6 +2509,7 @@ static unsigned long apply_proportional_protection(struct mem_cgroup *memcg,
>>  		 */
>>  		scan = max(scan, SWAP_CLUSTER_MAX);
>>  	}
>> +#endif
> 
> To avoid the ifdef, how about making it
> 
> 	bool mem_cgroup_protection(root, memcg, &min, &low, &usage)
> 
> and branch the scaling on that return value. The compiler should be
> able to eliminate the entire branch in the !CONFIG_MEMCG case. And it
> keeps a cleaner split between memcg logic and reclaim logic.

Much better, will update.

-- 
Best regards,
Ridong


