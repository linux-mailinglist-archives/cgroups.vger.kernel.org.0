Return-Path: <cgroups+bounces-10156-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F582B58FDE
	for <lists+cgroups@lfdr.de>; Tue, 16 Sep 2025 10:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 745D17A2080
	for <lists+cgroups@lfdr.de>; Tue, 16 Sep 2025 08:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77A421CFFD;
	Tue, 16 Sep 2025 08:01:38 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DC11DF248;
	Tue, 16 Sep 2025 08:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758009698; cv=none; b=X40Wyr59airSf2GuJ0zTXeND6qmMShWHHsd4QFXHWnmRtK/uuxX50FPl1bw28rlz53AD2CPXFphOKqwr8EQJSMwjTJQHnOk3UAiIjzkBSPL3vYe6T7m02JbTn2CRCTSqCmIXvpuj5dBNzxyXiO9p597kuPxRdnH8o6/mewZje0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758009698; c=relaxed/simple;
	bh=ICLWho/ALKDbzDiA97i7BlUx49nCLovGVo0s2m8jwo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NfUl831otYnz/xMy+F5cLcRbUBa29Ljn9ctswJASlNAwNjrBDeOf76cEGBzy3CCS4dJGVUha94joMEqMhFu/OhHFpg+Alk4uf8nrySTrtKGL2S+8Lgng2tkp6GCsXaLbPBTGrZ9xSuofl2Y2bZIiqPAdw04VSZ5Ro+nXr1Rq8j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cQvVh0QxyzKHMbc;
	Tue, 16 Sep 2025 16:01:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id AF45F1A1D07;
	Tue, 16 Sep 2025 16:01:32 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP2 (Coremail) with SMTP id Syh0CgDnD5dcGclo7nueCg--.51242S2;
	Tue, 16 Sep 2025 16:01:32 +0800 (CST)
Message-ID: <3fbd1880-4065-4e08-852d-c98316e245ab@huaweicloud.com>
Date: Tue, 16 Sep 2025 16:01:31 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC -v2 09/11] cpuset: refactor
 partition_cpus_change
To: Waiman Long <llong@redhat.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250909033233.2731579-1-chenridong@huaweicloud.com>
 <20250909033233.2731579-10-chenridong@huaweicloud.com>
 <3815a523-a6d1-4612-8ec8-b955694a5792@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <3815a523-a6d1-4612-8ec8-b955694a5792@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgDnD5dcGclo7nueCg--.51242S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtr15JryruFykZrWkWr1Dtrb_yoW7uF4fpF
	1kJrWUXrWUJr1rKw4UJr1DZ34Utr1DJ3WDtrnrXF1rJF12vr1qqF1UX34q9r17Jr48Jr18
	JF1UXrsruF9rArUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



On 2025/9/16 3:34, Waiman Long wrote:
> On 9/8/25 11:32 PM, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> Refactor the partition_cpus_change function to handle both regular CPU
>> set updates and exclusive CPU modifications, either of which may trigger
>> partition state changes. This generalized function will also be utilized
>> for exclusive CPU updates in subsequent patches.
>>
>> With the introduction of compute_trialcs_excpus in a previous patch,
>> the trialcs->effective_xcpus field is now consistently computed and
>> maintained. Consequently, the legacy logic which assigned
>> **trialcs->allowed_cpus to a local 'xcpus' variable** when
>> trialcs->effective_xcpus was empty has been removed.
>>
>> This removal is safe because when trialcs is not a partition member,
>> trialcs->effective_xcpus is now correctly populated with the intersection
>> of user_xcpus and the parent's effective_xcpus. This calculation inherently
>> covers the scenario previously handled by the removed code.
>>
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>>   kernel/cgroup/cpuset.c | 66 +++++++++++++++++++++++++-----------------
>>   1 file changed, 40 insertions(+), 26 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 6aa93bd9d5dd..de61520f1e44 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -2453,6 +2453,45 @@ static int cpus_allowed_validate_change(struct cpuset *cs, struct cpuset
>> *trialc
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
>> +    enum prs_errcode prs_err;
>> +
>> +    if (cs_is_member(cs))
>> +        return;
>> +
>> +    prs_err = validate_partition(cs, trialcs);
>> +    if (prs_err) {
>> +        trialcs->prs_err = prs_err;
>> +        cs->prs_err = prs_err;
>> +    }
> 
> The assignment can be simplified into
> 
>     trialcs->prs_err = cs->prs_err = prs_err;
> 

Thank you, will update.

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
>> @@ -2466,7 +2505,6 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>>       struct tmpmasks tmp;
>>       bool force = false;
>>       int old_prs = cs->partition_root_state;
>> -    enum prs_errcode prs_err;
>>         retval = parse_cpuset_cpulist(buf, trialcs->cpus_allowed);
>>       if (retval < 0)
>> @@ -2491,31 +2529,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>>        */
>>       force = !cpumask_equal(cs->effective_xcpus, trialcs->effective_xcpus);
>>   -    prs_err = validate_partition(cs, trialcs);
>> -    if (prs_err) {
>> -        trialcs->prs_err = prs_err;
>> -        cs->prs_err = prs_err;
>> -    }
>> -
>> -    if (is_partition_valid(cs) ||
>> -       (is_partition_invalid(cs) && !trialcs->prs_err)) {
>> -        struct cpumask *xcpus = trialcs->effective_xcpus;
>> -
>> -        if (cpumask_empty(xcpus) && is_partition_invalid(cs))
>> -            xcpus = trialcs->cpus_allowed;
>> -
>> -        /*
>> -         * Call remote_cpus_update() to handle valid remote partition
>> -         */
>> -        if (is_remote_partition(cs))
>> -            remote_cpus_update(cs, NULL, xcpus, &tmp);
>> -        else if (trialcs->prs_err)
>> -            update_parent_effective_cpumask(cs, partcmd_invalidate,
>> -                            NULL, &tmp);
>> -        else
>> -            update_parent_effective_cpumask(cs, partcmd_update,
>> -                            xcpus, &tmp);
>> -    }
>> +    partition_cpus_change(cs, trialcs, &tmp);
>>         spin_lock_irq(&callback_lock);
>>       cpumask_copy(cs->cpus_allowed, trialcs->cpus_allowed);
> Reviewed-by: Waiman Long <longman@redhat.com>

-- 
Best regards,
Ridong


