Return-Path: <cgroups+bounces-9506-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DCDB3C743
	for <lists+cgroups@lfdr.de>; Sat, 30 Aug 2025 04:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C76F204573
	for <lists+cgroups@lfdr.de>; Sat, 30 Aug 2025 02:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985DE23ED5E;
	Sat, 30 Aug 2025 02:01:42 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2222822652D;
	Sat, 30 Aug 2025 02:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756519302; cv=none; b=ukH8qqEE4o2Dtrm4DeYXzQrhIQK31eoHbJ0mNjnh4o8uEp76Y/tIgE5Svcfo7uq6ze1IaULTX4SrlJofOF3euVFbyNCS1g9mrYxeMu+8Qn7HtQ/3exJ6l18un5f30vNwKYCTTWDd7DOOTsqkVdBrHEzGNXHDrboh6NMaZAsEOY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756519302; c=relaxed/simple;
	bh=6DrCquFmOPWC/rxxQamV6jVH9tC9CmR3EaJB4O/JTjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QS8mFyOwiapWh37skTVAdAoArZ5tu9cg6tt26faY2kG12V/hfCk45MYofICGTqFHyfYamRI3/5BkOyGYLU7PE8PWrLjzPVpYbtMCUnjAxg1TB6tjcBswq8RuSpd/rz9IOhZAB463E2A4FUNJKQlbiAX67xksMXBZqKyQguQuddY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cDJKG1p3hzYQv2v;
	Sat, 30 Aug 2025 10:01:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id BE2C91A092D;
	Sat, 30 Aug 2025 10:01:36 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP2 (Coremail) with SMTP id Syh0CgCn0Zh_W7Jo0wEBAw--.18073S2;
	Sat, 30 Aug 2025 10:01:36 +0800 (CST)
Message-ID: <031d83b6-bc67-4941-8c49-e1d12df74062@huaweicloud.com>
Date: Sat, 30 Aug 2025 10:01:34 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC 09/11] cpuset: refactor partition_cpus_change
To: Waiman Long <llong@redhat.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250828125631.1978176-1-chenridong@huaweicloud.com>
 <20250828125631.1978176-10-chenridong@huaweicloud.com>
 <632cd2ab-9803-4b84-8dd9-cd07fbe73c95@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <632cd2ab-9803-4b84-8dd9-cd07fbe73c95@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCn0Zh_W7Jo0wEBAw--.18073S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF4rXr4xKw13AF1kCF13XFb_yoWruw4kpF
	1kJrWUXrWUJr1Fk3yUJr17Wry5Kw1DJ3WDtrn7X3WrJFy2yr1qqF1jqws09r17Jw4xJr18
	J3WjqrsruFnrArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHDUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/8/30 4:32, Waiman Long wrote:
> On 8/28/25 8:56 AM, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> Refactor the partition_cpus_change function to handle both regular CPU
>> set updates and exclusive CPU modifications, either of which may trigger
>> partition state changes. This generalized function will also be utilized
>> for exclusive CPU updates in subsequent patches.
>>
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>>   kernel/cgroup/cpuset.c | 59 ++++++++++++++++++++++++++----------------
>>   1 file changed, 36 insertions(+), 23 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 75ad18ab40ae..e3eb87a33b12 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -2447,6 +2447,41 @@ static int acpus_validate_change(struct cpuset *cs, struct cpuset *trialcs,
>>       return retval;
>>   }
>>   +/**
>> + * partition_cpus_change - Handle partition state changes due to CPU mask updates
>> + * @cs: The target cpuset being modified
>> + * @trialcs: The trial cpuset containing proposed configuration changes
>> + * @tmp: Temporary masks for intermediate calculations
>> + *
>> + * This function handles partition state transitions triggered by CPU mask changes.
>> + * CPU modifications may cause a partition to be disabled or require state updates.
>> + */
>> +static void partition_cpus_change(struct cpuset *cs, struct cpuset *trialcs,
>> +                    struct tmpmasks *tmp)
>> +{
>> +    if (cs_is_member(cs))
>> +        return;
>> +
>> +    invalidate_cs_partition(trialcs);
>> +    if (trialcs->prs_err)
>> +        cs->prs_err = trialcs->prs_err;
>> +
>> +    if (is_remote_partition(cs)) {
>> +        if (trialcs->prs_err)
>> +            remote_partition_disable(cs, tmp);
>> +        else
>> +            remote_cpus_update(cs, trialcs->exclusive_cpus,
>> +                       trialcs->effective_xcpus, tmp);
>> +    } else {
>> +        if (trialcs->prs_err)
>> +            update_parent_effective_cpumask(cs, partcmd_invalidate,
>> +                            NULL, tmp);
>> +        else
>> +            update_parent_effective_cpumask(cs, partcmd_update,
>> +                            trialcs->effective_xcpus, tmp);
>> +    }
>> +}
>> +
>>   /**
>>    * update_cpumask - update the cpus_allowed mask of a cpuset and all tasks in it
>>    * @cs: the cpuset to consider
>> @@ -2483,29 +2518,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>>        */
>>       force = !cpumask_equal(cs->effective_xcpus, trialcs->effective_xcpus);
>>   -    invalidate_cs_partition(trialcs);
>> -    if (trialcs->prs_err)
>> -        cs->prs_err = trialcs->prs_err;
>> -
>> -    if (is_partition_valid(cs) ||
>> -       (is_partition_invalid(cs) && !trialcs->prs_err)) {
>> -        struct cpumask *xcpus = trialcs->effective_xcpus;
>> -
>> -        if (cpumask_empty(xcpus) && is_partition_invalid(cs))
>> -            xcpus = trialcs->cpus_allowed;
> 
> This if statement was added in commit 46c521bac592 ("cgroup/cpuset: Enable invalid to valid local
> partition transition") that is missing in your new partition_cpus_change() function. Have you run
> the test_cpuset_prs.sh selftest with a patched kernel to make sure that there is no test failure?
> 
> Cheers,
> Longman

Thank you Longman,

I did run the self-test for every patch, and I appreciate the test script test_cpuset_prs.sh you
provided.

The trialcs->effective_xcpus will be updated using compute_trialcs_excpus, which was introduced in
Patch 4. The corresponding logic was then added in Patch 5:

-	cpumask_and(excpus, user_xcpus(trialcs), parent->effective_xcpus);
+	/* trialcs is member, cpuset.cpus has no impact to excpus */
+	if (cs_is_member(cs))
+		cpumask_and(excpus, trialcs->exclusive_cpus,
+				parent->effective_xcpus);
+	else
+		cpumask_and(excpus, user_xcpus(trialcs), parent->effective_xcpus);
+

Therefore, as long as excpus is computed correctly, I believe this implementation can handle the
scenario appropriately.

-- 
Best regards,
Ridong


