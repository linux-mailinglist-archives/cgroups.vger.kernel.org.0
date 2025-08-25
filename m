Return-Path: <cgroups+bounces-9363-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE26B3336A
	for <lists+cgroups@lfdr.de>; Mon, 25 Aug 2025 02:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 370737ACF73
	for <lists+cgroups@lfdr.de>; Mon, 25 Aug 2025 00:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C522D200112;
	Mon, 25 Aug 2025 00:52:32 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CB67081C;
	Mon, 25 Aug 2025 00:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756083152; cv=none; b=COqnc4tdiP2pvae7aFLjPN66/rlHoMi0wgvPPwyr5cSkeoa1K1ol6KqGtQZqUfYz5WF+ExAfksjUmfW3EmjzVw0r0Cg2LEOHSxreDW9HDl7DLSHNYzewdsc5v+GAl5xrqVXshwCNGkkKc56rmlXLosneRC7BbWeE/wxKTbcNJfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756083152; c=relaxed/simple;
	bh=eR+0UlJHgVRlInzosX/W0UU2V0Hl86UYTCNUVWzoaHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TKM2sTEgsKRm839MD+mo6xj7ArauteV1AUDzFK32Dr+gljbhT6BIBQQ56ib8e2M9UuwF+03pLWU7ytroxYKhr/Ea/MT8njSPSvf98LkkXve+OQors3kMmxvxKkNkPSGlt/ncpcrq3t0Y2ImXiLEtPPXHye4tLq7NCS5Rrzx5Bfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c9C1c6RkxzKHMSl;
	Mon, 25 Aug 2025 08:52:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 7B7C01A1A0F;
	Mon, 25 Aug 2025 08:52:20 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP1 (Coremail) with SMTP id cCh0CgDHhXvDs6to1mLDAA--.34254S2;
	Mon, 25 Aug 2025 08:52:20 +0800 (CST)
Message-ID: <abec1bda-82bf-430e-9747-5aa4fa6ccacd@huaweicloud.com>
Date: Mon, 25 Aug 2025 08:52:18 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v4 2/3] cpuset: separate tmpmasks and cpuset
 allocation logic
To: Waiman Long <llong@redhat.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250818064141.1334859-1-chenridong@huaweicloud.com>
 <20250818064141.1334859-3-chenridong@huaweicloud.com>
 <0b918f11-d850-4cdb-b9af-ffa436b8fd1e@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <0b918f11-d850-4cdb-b9af-ffa436b8fd1e@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHhXvDs6to1mLDAA--.34254S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tF4kCFyfuw1ktw4ktF1xGrg_yoW8uF4xpF
	ZIgFy5t3y5Kr1xGa43X3Z7WF1S9a18tF1DK3WDtryFvFWak3W0gF1DZa4FqF1UAFykuF15
	JF90vF429a4kAFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUymb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
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
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UK2NtUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/8/25 1:05, Waiman Long wrote:
> 
> On 8/18/25 2:41 AM, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> The original alloc_cpumasks() served dual purposes: allocating cpumasks
>> for both temporary masks (tmpmasks) and cpuset structures. This patch:
>>
>> 1. Decouples these allocation paths for better code clarity
>> 2. Introduces dedicated alloc_tmpmasks() and dup_or_alloc_cpuset()
>>     functions
>> 3. Maintains symmetric pairing:
>>     - alloc_tmpmasks() ↔ free_tmpmasks()
>>     - dup_or_alloc_cpuset() ↔ free_cpuset()
>>
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>>   kernel/cgroup/cpuset.c | 128 ++++++++++++++++++++++-------------------
>>   1 file changed, 69 insertions(+), 59 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index aebda14cc67f..d5588a1fef60 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -411,51 +411,46 @@ static void guarantee_online_mems(struct cpuset *cs, nodemask_t *pmask)
>>   }
>>     /**
>> - * alloc_cpumasks - allocate three cpumasks for cpuset
>> - * @cs:  the cpuset that have cpumasks to be allocated.
>> - * @tmp: the tmpmasks structure pointer
>> - * Return: 0 if successful, -ENOMEM otherwise.
>> + * alloc_cpumasks - Allocate an array of cpumask variables
>> + * @pmasks: Pointer to array of cpumask_var_t pointers
>> + * @size: Number of cpumasks to allocate
>>    *
>> - * Only one of the two input arguments should be non-NULL.
>> + * Allocates @size cpumasks and initializes them to empty. Returns 0 on
>> + * success, -ENOMEM on allocation failure. On failure, any previously
>> + * allocated cpumasks are freed.
> 
> The convention for the kernel-doc is to have a "Return:" tag if the function has a returned value.
> That "Return:" tag is deleted by this change. Your description does describe the returned value and
> no test robot failure was reported. Other than that, the rest of the patch looks good to me.
> 
> Cheers,
> Longman
> 

Thank you Longman, will update.

-- 
Best regards,
Ridong


