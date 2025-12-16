Return-Path: <cgroups+bounces-12377-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CD9CC2EB4
	for <lists+cgroups@lfdr.de>; Tue, 16 Dec 2025 13:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F013F303262A
	for <lists+cgroups@lfdr.de>; Tue, 16 Dec 2025 12:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A4C350D60;
	Tue, 16 Dec 2025 12:34:52 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07702DA74C;
	Tue, 16 Dec 2025 12:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765888492; cv=none; b=QOjPSrOGDcPRDCbKZIY8KCFIUt9kt1oJU50CmaNw2UQB9Nh76DspjohC3xhyneVH16Ev+r3ysOQVIjT1XDhe7Xmqf7J4g6d3INyw+6DVrDQVRViyhc29X3KXyg1z9Gv9srmq4gBRUrF/kW9xw24hNhrEwwD2mbuq5cMZof+hdrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765888492; c=relaxed/simple;
	bh=Ws+CoaAeuvsCHc8PWCEMKX/yvbX3GDPDVhiyIqM/HiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UcG+qJvsPMe4tXjaFMByPJmQOaqg7RaxIhdHJSj2OL8VeA0Il083ABvDtLg5FV8IGIVmn4HxE+Uu27AvGjX8W4b2btri1RWJ5d2LLjjC4wYYDTYe+J94Em/maA8AzkmBcWcekP3e7yD+SqoKb+zfNlFdGj0xUJZZCI14CGe3HyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dVxFm75HNzKHMP4;
	Tue, 16 Dec 2025 20:34:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8D09140571;
	Tue, 16 Dec 2025 20:34:44 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgCHNvfhUUFpcimUAQ--.7655S2;
	Tue, 16 Dec 2025 20:34:42 +0800 (CST)
Message-ID: <476fcde5-d54d-4b15-9870-844b3b8c700a@huaweicloud.com>
Date: Tue, 16 Dec 2025 20:34:40 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v3 2/2] memcg: remove mem_cgroup_size()
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, muchun.song@linux.dev, akpm@linux-foundation.org,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 david@kernel.org, zhengqi.arch@bytedance.com, lorenzo.stoakes@oracle.com,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com
References: <20251211013019.2080004-1-chenridong@huaweicloud.com>
 <20251211013019.2080004-3-chenridong@huaweicloud.com>
 <o3hmzratjkcxms3ylnjiuashclllf7mvz6ttkfrz4lybdiwhhp@yeo5my374trx>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <o3hmzratjkcxms3ylnjiuashclllf7mvz6ttkfrz4lybdiwhhp@yeo5my374trx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHNvfhUUFpcimUAQ--.7655S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tF4kCFW8Wr18Kw13Wry8Krg_yoW8KryUpF
	nFka47ta15Zryjyr4Iv34Yva48tw48t34UG347Gr18X3srWrn5tF9Fka40gFy8CF93AF17
	ZF15uws7A3y2k3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
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
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	jIksgUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/12/16 0:28, Michal Koutný wrote:
> Hi Ridong.
> 
> On Thu, Dec 11, 2025 at 01:30:19AM +0000, Chen Ridong <chenridong@huaweicloud.com> wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> The mem_cgroup_size helper is used only in apply_proportional_protection
>> to read the current memory usage. Its semantics are unclear and
>> inconsistent with other sites, which directly call page_counter_read for
>> the same purpose.
>>
>> Remove this helper and get its usage via mem_cgroup_protection for
>> clarity. Additionally, rename the local variable 'cgroup_size' to 'usage'
>> to better reflect its meaning.
>>
>> No functional changes intended.
>>
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> 
> Why does mem_cgroup_calculate_protection "calculate" usage for its
> callers? Couldn't you just the change source in
> apply_proportional_protection()?
> 
> Thanks,
> Michal
> 

I apologize for missing this message earlier.

In my v2 patch, I was reading the usage directly:

+		unsigned long usage = page_counter_read(&memcg->memory);

This works fine when CONFIG_MEMCG=y, but fails to compile when memory cgroups are disabled. To
handle this, I initially added #ifdef CONFIG_MEMCG guards.

Following Johannes's suggestion, I have now moved this logic into mem_cgroup_protection() to
eliminate the #ifdef and keep the code cleaner.

Discussion:
https://lore.kernel.org/all/20251210163634.GB643576@cmpxchg.org/

>> @@ -2485,7 +2485,6 @@ static unsigned long apply_proportional_protection(struct mem_cgroup *memcg,
>>  		 * again by how much of the total memory used is under
>>  		 * hard protection.
>>  		 */
>> -		unsigned long cgroup_size = mem_cgroup_size(memcg);
> +		unsigned long cgroup_size = page_counter_read(memcg);
> 
>>  		unsigned long protection;
>>  
>>  		/* memory.low scaling, make sure we retry before OOM */
>> @@ -2497,9 +2496,9 @@ static unsigned long apply_proportional_protection(struct mem_cgroup *memcg,
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

-- 
Best regards,
Ridong


