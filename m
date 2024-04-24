Return-Path: <cgroups+bounces-2685-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0458AFD78
	for <lists+cgroups@lfdr.de>; Wed, 24 Apr 2024 02:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36F661C21F25
	for <lists+cgroups@lfdr.de>; Wed, 24 Apr 2024 00:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C574A32;
	Wed, 24 Apr 2024 00:57:05 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B21F3C30;
	Wed, 24 Apr 2024 00:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713920225; cv=none; b=fmpRh7mcCPetSXjBXJoFsn3T6Kd6d4+G0n/HE83sOlmiW6CGGgqXjXuX2L+AbmyIgEMyP2PZCzRaCAxaPTuYhWqp+isdSoCpUg/WYqgZGPDBuLAscJ4F8vCjZo6E4JEGeLt5fHVUbCrgaWMo/vVMHeVLf4Z6sE0kZzsJ16leDoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713920225; c=relaxed/simple;
	bh=JrppL5ptzNVHIWPonIbowmK1NS+YtvtmSsy9A8cO/0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KsP6Rb9cBrCrLUNq/f3D+164U2cORKg9I5AbPASjVwg4Wi4sDsetRRDw7C6TPnfXSxQrNSV+CpHY86niRWJ8khUp3BYvbhLbAgUoJnS2Y13RUeBCgAjcq0TOWPbmCdGfWagwtRLp36CHK3Mhcjr5rOVnitKKLyikmfmTjg5p3T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VPL8k1dp5zvPrq;
	Wed, 24 Apr 2024 08:53:58 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id 61F67180A9C;
	Wed, 24 Apr 2024 08:56:59 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Apr 2024 08:56:59 +0800
Message-ID: <a94e7b2f-0c22-f9bd-236c-d542958b6934@huawei.com>
Date: Wed, 24 Apr 2024 08:56:47 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH -next] cgroup/cpuset: Statically initialize more members
 of top_cpuset
Content-Language: en-US
To: Klara Modin <klarasmodin@gmail.com>, <longman@redhat.com>,
	<lizefan.x@bytedance.com>, <tj@kernel.org>, <hannes@cmpxchg.org>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240420094616.1028540-1-xiujianfeng@huawei.com>
 <f2edf788-6ff3-43b1-9445-ac237e7910ac@gmail.com>
From: xiujianfeng <xiujianfeng@huawei.com>
In-Reply-To: <f2edf788-6ff3-43b1-9445-ac237e7910ac@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500023.china.huawei.com (7.185.36.114)



On 2024/4/24 3:21, Klara Modin wrote:
> Hi,
> 
> On 2024-04-20 11:46, Xiu Jianfeng wrote:
>> Initializing top_cpuset.relax_domain_level and setting
>> CS_SCHED_LOAD_BALANCE to top_cpuset.flags in cpuset_init() could be
>> completed at the time of top_cpuset definition by compiler.
>>
>> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
>> ---
>>   kernel/cgroup/cpuset.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index d8d3439eda4e..e70008a1d86a 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -369,8 +369,9 @@ static inline void notify_partition_change(struct
>> cpuset *cs, int old_prs)
>>     static struct cpuset top_cpuset = {
>>       .flags = ((1 << CS_ONLINE) | (1 << CS_CPU_EXCLUSIVE) |
>> -          (1 << CS_MEM_EXCLUSIVE)),
>> +          (1 << CS_MEM_EXCLUSIVE) | (1 < CS_SCHED_LOAD_BALANCE)),
> 
> You dropped a '<' for the bitwise shift, this causes bad cpu utilization
> for me.

Oops, that's bad, I'm sorry for that!

> 
>>       .partition_root_state = PRS_ROOT,
>> +    .relax_domain_level = -1,
>>       .remote_sibling = LIST_HEAD_INIT(top_cpuset.remote_sibling),
>>   };
>>   @@ -4309,8 +4310,6 @@ int __init cpuset_init(void)
>>       nodes_setall(top_cpuset.effective_mems);
>>         fmeter_init(&top_cpuset.fmeter);
>> -    set_bit(CS_SCHED_LOAD_BALANCE, &top_cpuset.flags);
>> -    top_cpuset.relax_domain_level = -1;
>>       INIT_LIST_HEAD(&remote_children);
>>         BUG_ON(!alloc_cpumask_var(&cpus_attach, GFP_KERNEL));
> 
> Kind regards,
> Klara Modin

