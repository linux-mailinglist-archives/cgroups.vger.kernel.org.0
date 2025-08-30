Return-Path: <cgroups+bounces-9505-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95846B3C723
	for <lists+cgroups@lfdr.de>; Sat, 30 Aug 2025 03:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42B162023F6
	for <lists+cgroups@lfdr.de>; Sat, 30 Aug 2025 01:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD26220687;
	Sat, 30 Aug 2025 01:42:28 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7366B2566;
	Sat, 30 Aug 2025 01:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756518148; cv=none; b=U+CgmYyPw33W/dSl78RiN2xvBhubVR4A0kWzTYeKEhCPkgvltMNf9Vzi1FylWTHaQfwe3dt1hQOJx1WB6rU0V/VB1uf7Mm7ghljQlS7jrzb4yx6uO4aTQo5JyD56YAjEDDiv2Jma02lnAJi68qOSYL58vg9D0uoUrhxO63nTmG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756518148; c=relaxed/simple;
	bh=MjTt9+U7lCqfiZS5v2c1l/PnAOCQeabw3AkqhR/A5nw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gt3PAL3eluAVBJ4VTN58PAkzOtxGinbr5EpgX79wxjB7R0nCjAhaCoaPXw4FNC0cl7dphk4q3Egh/tYQw2Jk6fGj/wK6ff2dWfCSb+lM02er8ycn60M2y+EpoE/Mdi/976kvJXT+zr8qhc39+BSCWzNQ0MmOExtDCLJGkrf7YtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cDHv41F08zYQv8y;
	Sat, 30 Aug 2025 09:42:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id A8BA31A0D83;
	Sat, 30 Aug 2025 09:42:22 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP2 (Coremail) with SMTP id Syh0CgCn0Zj9VrJotn7_Ag--.13956S2;
	Sat, 30 Aug 2025 09:42:22 +0800 (CST)
Message-ID: <c665908a-6591-4c9d-93c0-0e69dc831495@huaweicloud.com>
Date: Sat, 30 Aug 2025 09:42:20 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC 08/11] cpuset: refactor acpus_validate_change
To: Waiman Long <llong@redhat.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250828125631.1978176-1-chenridong@huaweicloud.com>
 <20250828125631.1978176-9-chenridong@huaweicloud.com>
 <ca3bcede-2289-4e51-a2db-0da75d85fcbc@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <ca3bcede-2289-4e51-a2db-0da75d85fcbc@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCn0Zj9VrJotn7_Ag--.13956S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tF4kCFW8Gr1fGry8Cr45KFg_yoW8uw48pF
	WrGFW5J3y5Xr1xC3ZxJ34kWryagws7t3WUKwnIqa4rJF9FkF1q9r1DXa9Ygry3JrW8GF4U
	J3ZFvwsa9Fyvy37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
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



On 2025/8/30 4:12, Waiman Long wrote:
> On 8/28/25 8:56 AM, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> Refactor acpus_validate_change to handle the special case where
>> cpuset.cpus can be set even when violating partition sibling CPU
>> exclusivity rules. This differs from the general validation logic in
>> validate_change. Add a wrapper function to properly handle this
>> exceptional case.
>>
>> Since partition invalidation status can be determined by trialcs->prs_err,
>> the local variable 'bool invalidate' can be removed.
>>
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>>   kernel/cgroup/cpuset.c | 83 +++++++++++++++++++++++-------------------
>>   1 file changed, 45 insertions(+), 38 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 71190f142700..75ad18ab40ae 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -2410,43 +2410,11 @@ static bool invalidate_cs_partition(struct cpuset *cs)
>>       return false;
>>   }
>>   -/**
>> - * update_cpumask - update the cpus_allowed mask of a cpuset and all tasks in it
>> - * @cs: the cpuset to consider
>> - * @trialcs: trial cpuset
>> - * @buf: buffer of cpu numbers written to this cpuset
>> - */
>> -static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>> -              const char *buf)
>> +static int acpus_validate_change(struct cpuset *cs, struct cpuset *trialcs,
>> +                    struct tmpmasks *tmp)
> 
> What does "acpu" stand for? I suppose it means cpus_allowed. I will suggest to use a more
> descriptive name even if it is longer. I did use xcpus for exclusive_cpus, but 'x' is a seldomly
> used English alphabet that can associate with exclusive_cpus rather easily, but 'a' is not.
> 
> Cheers,
> Longman
> 

Thanks Longman,

The term acpus refers to cpus_allowed.

My original naming convention was intended as follows:

acpus  --> cpus_allowed (allowed cpus)
ecpus  --> effective_cpus
xcpus  --> exclusive_cpus
excpus --> effective_xcpus

-- 
Best regards,
Ridong


