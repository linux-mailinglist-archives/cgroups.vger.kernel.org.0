Return-Path: <cgroups+bounces-9504-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9623EB3C71B
	for <lists+cgroups@lfdr.de>; Sat, 30 Aug 2025 03:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39831A2544A
	for <lists+cgroups@lfdr.de>; Sat, 30 Aug 2025 01:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDA542AA9;
	Sat, 30 Aug 2025 01:33:14 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9CF3D81;
	Sat, 30 Aug 2025 01:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756517594; cv=none; b=en4hGWbGhuvfEmH60hB9cdvw5Qw4eatOh7FmuXPzzKBPoFF4+cZWaKbPhvXvNM2WkO4mpkNLKnSjSji5V5vV13ALFh1GAma7pOExTUnPvEr6WLkNcbIuIxCLC9b+a6cTWJSdqCPPjk4ogUGvYS1a4cZIKo2+njU0Uxbm2J6CwQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756517594; c=relaxed/simple;
	bh=WtouB6kLx+CK3flf2J2HhJ/oLoJEhX/07/hc1g9A2Z0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KzlYoftXK7ZI76mFJazWb6fWu4vk7qLebplGzcw6Wvg/mZPpsi8JE9WCAlodnnbh4z/BpwYx5o73ytuCu8PMSjYzWSTpeRUyqwUyImr0S4NjQ1C3SsShkm3yR28tuKIiodLMR4Gs3gLhQgBg8CiBdwEcasWDJrPbpnkVtc+j3VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cDHhR50rtzYQv8j;
	Sat, 30 Aug 2025 09:33:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 386181A0FAB;
	Sat, 30 Aug 2025 09:33:10 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP2 (Coremail) with SMTP id Syh0CgBXgJfVVLJoRcP+Ag--.16804S2;
	Sat, 30 Aug 2025 09:33:10 +0800 (CST)
Message-ID: <5d0f67d9-07fc-4e09-903a-dfc26c9f4a87@huaweicloud.com>
Date: Sat, 30 Aug 2025 09:33:09 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC 07/11] cpuset: refactor out
 invalidate_cs_partition
To: Waiman Long <llong@redhat.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250828125631.1978176-1-chenridong@huaweicloud.com>
 <20250828125631.1978176-8-chenridong@huaweicloud.com>
 <98eb72df-2897-413e-8c01-7d688ad58810@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <98eb72df-2897-413e-8c01-7d688ad58810@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBXgJfVVLJoRcP+Ag--.16804S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tF4kCFyfKw48KF4UJr1UZFb_yoW8Wr4xpF
	W5KayYy3y5KF47uas3XayxWF15Kws7J3WUJrsxJw1xJrnFv3WqkF1qywnxXryxJF93Gr17
	J3W5uFsI9a45Z3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbiF4tUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/8/30 3:56, Waiman Long wrote:
> 
> On 8/28/25 8:56 AM, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> Refactor the invalidate_cs_partition function to handle cpuset partition
>> invalidation when modifying cpuset.cpus. This refactoring also makes the
>> function reusable for handling cpuset.cpus.exclusive updates in subsequent
>> patches.
>>
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>>   kernel/cgroup/cpuset.c | 49 +++++++++++++++++++++++++++++++-----------
>>   1 file changed, 36 insertions(+), 13 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 5cfc53fe717c..71190f142700 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -2376,6 +2376,40 @@ static int parse_cpulist(const char *buf, struct cpumask *out_mask)
>>       return 0;
>>   }
>>   +/**
>> + * invalidate_cs_partition - Validate and mark the validity of a cpuset partition configuration
> 
> The function name has "invalidate", but the description uses validate. It is confusing.
> 
> My suggestion
> 
>   validate_partition - Check the validity of a cpuset partition configuration
> 
>   Return 0 if valid, a non-zero prs_errcode otherwise
> 
> Cheers,
> Longman

Thank you Longman,

I originally used that name for a local value 'invalidated' within update_cpumask. However, since
subsequent patches have removed the invalidated, validate_partition would be a much more appropriate
name. I will update it accordingly.

-- 
Best regards,
Ridong


