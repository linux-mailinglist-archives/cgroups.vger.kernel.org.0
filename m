Return-Path: <cgroups+bounces-9503-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82EE5B3C71A
	for <lists+cgroups@lfdr.de>; Sat, 30 Aug 2025 03:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B61EF1C253CA
	for <lists+cgroups@lfdr.de>; Sat, 30 Aug 2025 01:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F25A19E967;
	Sat, 30 Aug 2025 01:27:24 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAA82745E;
	Sat, 30 Aug 2025 01:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756517244; cv=none; b=doNMwZf59BFVfB5BmfwpeX/Eqx8HbdcSXX1Anj45ahTm8Vpw07cNtKj8DQwfU5En2P+fbGFSnQAiaKPhBOzFYf2mePNi4hq0CHv7yyAh/gl2MPZsiovNXloEaoDDK/or4YwvYiB8gD+vTH5xRlV1u4R9iTevR1AFzylVHlQOCRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756517244; c=relaxed/simple;
	bh=aDo6Fjd/X/YV7eJhAdtW4j6kYtHK2oCfo42qFBC+uBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mDpvpVJe+D77DzQ1j6e6b3sJ3AS6lyoU7R5XAfKyqxb6bIchUQkIXS159b1zx1/dOjsxCWtf2WJz0sjVFzTguqr0LLFDFRL4rXzP5CD81XL/KoCqojqrI68QFAqrL/hzisEVr+XczKJwK9GxJN6cVdyAkw805HKNQyvoaCSS/BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cDHYg2byWzYQtxb;
	Sat, 30 Aug 2025 09:27:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id D94FB1A0AD8;
	Sat, 30 Aug 2025 09:27:17 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP1 (Coremail) with SMTP id cCh0CgB3Nnx0U7Jo8Pn4Ag--.41207S2;
	Sat, 30 Aug 2025 09:27:17 +0800 (CST)
Message-ID: <27beb9ee-114f-4071-88e5-cb8889826a53@huaweicloud.com>
Date: Sat, 30 Aug 2025 09:27:15 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC 06/11] cpuset: introduce cpus_excl_conflict and
 mems_excl_conflict helpers
To: Waiman Long <llong@redhat.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250828125631.1978176-1-chenridong@huaweicloud.com>
 <20250828125631.1978176-7-chenridong@huaweicloud.com>
 <be3275f5-a825-42bd-bf36-3d92387d0b50@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <be3275f5-a825-42bd-bf36-3d92387d0b50@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgB3Nnx0U7Jo8Pn4Ag--.41207S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr45CF1DGw1rWr1rtw15XFb_yoW5ZF15pF
	WrCFW7Ca4Ygr1fCw4akr1kWrZY9w48t3WDJF1kXF1rJrW7GF1jvrn5XwnI9F15Jr48Gw15
	JF9rXw4S9Fn8JrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/8/30 3:29, Waiman Long wrote:
> 
> On 8/28/25 8:56 AM, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> This patch adds cpus_excl_conflict() and mems_excl_conflict() helper
>> functions to improve code readability and maintainability. The exclusive
>> conflict checking follows these rules:
>>
>> 1. If either cpuset has the 'exclusive' flag set, their user_xcpus must
>>     not have any overlap.
>> 2. If both cpusets are non-exclusive, their 'cpuset.cpus.exclusive' values
>>     must not intersect.
> Do you mean "both cpusets are exclusive"?

Thank you Longman.

I meant that neither of the two cpusets has the "exclusive" flag set. Case 1 already handles
situations where one or both cpusets have the exclusive flag enabled.

>> 3. The 'cpuset.cpus' of one cpuset must not form a subset of another
>>     cpuset's 'cpuset.cpus.exclusive'.
>>
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>>   kernel/cgroup/cpuset.c | 62 ++++++++++++++++++++++--------------------
>>   1 file changed, 32 insertions(+), 30 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 5dd1e9552000..5cfc53fe717c 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -584,6 +584,35 @@ static inline bool cpusets_are_exclusive(struct cpuset *cs1, struct cpuset *cs2)
>>       return true;
>>   }
>>   +static inline bool cpus_excl_conflict(struct cpuset *cs1, struct cpuset *cs2)
>> +{
>> +    /* One is exclusive, they must be exclusive */
> The comment is hard to understand. Basically, if one cpuset has exclusive flag set (a v1 feature),
> they must be exclusive wrt each other.

My apologies for the earlier comment.

To quote your remark:
  "Basically, if one cpuset has the exclusive flag set (a v1 feature), they must be exclusive with
wrt to each other."

That is exactly what I meant. Although cpuset v2 does not expose a user interface to explicitly set
the exclusive flag, the flag will still be set internally when a partition is enabled with
update_partition_exclusive_flag function.

>> +    if (is_cpu_exclusive(cs1) || is_cpu_exclusive(cs2))
>> +        return !cpusets_are_exclusive(cs1, cs2);
>> +
>> +    /* Exclusive_cpus can not have intersects*/
> Grammatical mistake, better wording - "exclusive_cpus cannot intersect"
>> +    if (cpumask_intersects(cs1->exclusive_cpus, cs2->exclusive_cpus))
>> +        return true;
>> +
>> +    /* One cpus_allowed can not be a subset of another's cpuset.effective_cpus */
> "cpus_allowed of one cpuset cannot be a subset of another cpuset's exclusive_cpus"

Will update with next version.

>> +    if (!cpumask_empty(cs1->cpus_allowed) &&
>> +        cpumask_subset(cs1->cpus_allowed, cs2->exclusive_cpus))
>> +        return true;
>> +
>> +    if (!cpumask_empty(cs2->cpus_allowed) &&
>> +        cpumask_subset(cs2->cpus_allowed, cs1->exclusive_cpus))
>> +        return true;
>> +
>> +    return false;
>> +}
>> +
> Cheers,
> Longman

-- 
Best regards,
Ridong


