Return-Path: <cgroups+bounces-12032-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2C4C62802
	for <lists+cgroups@lfdr.de>; Mon, 17 Nov 2025 07:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 93ECA3500BD
	for <lists+cgroups@lfdr.de>; Mon, 17 Nov 2025 06:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B8F313E16;
	Mon, 17 Nov 2025 06:23:51 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7AA155326;
	Mon, 17 Nov 2025 06:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763360631; cv=none; b=bV0JAm3lVTPzni1FTFn/PpZoEFZ16yudMVMrgTp1P/1CmJD8m4NaIbSbnbMW7MWCuMejbJOvCkjq4dc6scBVmIs0G3qOXDFpB7Lgq5InswiisVSwWiQRAv7+q24cEL4oRHPq1+K4OgYBK1VEGdOnpnTC/i9idrJGSHHLOQm5Xb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763360631; c=relaxed/simple;
	bh=X5MJnIp5prdxlfCjz5WP+r+ArrHhZ9EQcObD9p/7MJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IXGNoZAZXwY4P+/zhO/n/1CV5SsswZYPy2BfwtLsbA9aOi6aL1WP1DIVCLW18vBAvfqbr8TspHi7sghmE76aLaQQkZYReevSFZ4mfLhhndpnFU6oTh+E/81Wq7cDffbTv3hm4K+e9b7o7WnyeyJkW0P1n4vy7B2+cBtEk7Vv64U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d8yNm3Z9wzKHMY5;
	Mon, 17 Nov 2025 14:23:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3C89C1A12E1;
	Mon, 17 Nov 2025 14:23:45 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgDH7ltvvxppJrYhBA--.52839S2;
	Mon, 17 Nov 2025 14:23:45 +0800 (CST)
Message-ID: <a16c91d9-a779-44e5-9ca6-e14e7540ed69@huaweicloud.com>
Date: Mon, 17 Nov 2025 14:23:43 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] cpuset: treate root invalid trialcs as exclusive
To: Sun Shaojie <sunshaojie@kylinos.cn>
Cc: cgroups@vger.kernel.org, hannes@cmpxchg.org,
 linux-kernel@vger.kernel.org, longman@redhat.com, mkoutny@suse.com,
 tj@kernel.org
References: <20251115093140.1121329-1-chenridong@huaweicloud.com>
 <20251117043516.1019183-1-sunshaojie@kylinos.cn>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20251117043516.1019183-1-sunshaojie@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDH7ltvvxppJrYhBA--.52839S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAr1kKFW3tw1DKrWrtr1DZFb_yoWrJryxpF
	W8GF4UJayYqryakwsFgFs2gFW3Ka1DXF17trnxGa4rGFy2qFnFkFyDt39xZa4fA39xGF18
	ZFW2vrW3WFn0yrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UK2NtUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/11/17 12:35, Sun Shaojie wrote:
> On 2025/11/15 09:31, Chen Ridong wrote:
>> A test scenario revealed inconsistent results based on operation order:
>> Scenario 1:
>> 	#cd /sys/fs/cgroup/
>> 	#mkdir A1
>> 	#mkdir B1
>> 	#echo 1-2 > B1/cpuset.cpus
>> 	#echo 0-1 > A1/cpuset.cpus
>> 	#echo root > A1/cpuset.cpus.partition
>> 	#cat A1/cpuset.cpus.partition
>> 	root invalid (Cpu list in cpuset.cpus not exclusive)
>>
>> Scenario 2:
>> 	#cd /sys/fs/cgroup/
>> 	#mkdir A1
>> 	#mkdir B1
>> 	#echo 1-2 > B1/cpuset.cpus
>> 	#echo root > A1/cpuset.cpus.partition
>> 	#echo 0-1 > A1/cpuset.cpus
>> 	#cat A1/cpuset.cpus.partition
>> 	root
>>
>> The second scenario produces an unexpected result: A1 should be marked
>> as invalid but is incorrectly recognized as valid. This occurs because
>> when validate_change is invoked, A1 (in root-invalid state) may
>> automatically transition to a valid partition, with non-exclusive state
>> checks against siblings, leading to incorrect validation.
>>
>> To fix this inconsistency, treat trialcs in root-invalid state as exclusive
>> during validation and set the corresponding exclusive flags, ensuring
>> consistent behavior regardless of operation order.
>>
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>> kernel/cgroup/cpuset.c | 19 ++++++++++++++-----
>> 1 file changed, 14 insertions(+), 5 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index daf813386260..a189f356b5f1 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -2526,6 +2526,18 @@ static void partition_cpus_change(struct cpuset *cs, struct cpuset *trialcs,
>> 	}
>> }
>>
>> +static int init_trialcs(struct cpuset *cs, struct cpuset *trialcs)
>> +{
>> +	trialcs->prs_err = PERR_NONE;
>> +	/*
>> +	 * If partition_root_state != 0, it may automatically change to a partition,
>> +	 * Therefore, we should treat trialcs as exclusive during validation
>> +	 */
>> +	if (trialcs->partition_root_state)
>> +		set_bit(CS_CPU_EXCLUSIVE, &trialcs->flags);
>> +	return compute_trialcs_excpus(trialcs, cs);
>> +}
>> +
>> /**
>>  * update_cpumask - update the cpus_allowed mask of a cpuset and all tasks in it
>>  * @cs: the cpuset to consider
>> @@ -2551,9 +2563,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>> 	if (alloc_tmpmasks(&tmp))
>> 		return -ENOMEM;
>>
>> -	compute_trialcs_excpus(trialcs, cs);
>> -	trialcs->prs_err = PERR_NONE;
>> -
>> +	init_trialcs(cs, trialcs);
>> 	retval = cpus_allowed_validate_change(cs, trialcs, &tmp);
>> 	if (retval < 0)
>> 		goto out_free;
>> @@ -2612,7 +2622,7 @@ static int update_exclusive_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>> 	 * Reject the change if there is exclusive CPUs conflict with
>> 	 * the siblings.
>> 	 */
>> -	if (compute_trialcs_excpus(trialcs, cs))
>> +	if (init_trialcs(cs, trialcs))
>> 		return -EINVAL;
>>
>> 	/*
>> @@ -2628,7 +2638,6 @@ static int update_exclusive_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>> 	if (alloc_tmpmasks(&tmp))
>> 		return -ENOMEM;
>>
>> -	trialcs->prs_err = PERR_NONE;
>> 	partition_cpus_change(cs, trialcs, &tmp);
>>
>> 	spin_lock_irq(&callback_lock);
> 
> Hi, Ridong,
> 
> Maybe, this patch does not apply to the following cases:
>  Step
>  #1> echo "root" > A1/cpuset.cpus.partition
>  #1> echo "0-1" > B1/cpuset.cpus
>  #2> echo "1-2" > A1/cpuset.cpus.exclusive  -> return error
>  It should return success here.
> 
> Please consider the following modification.
> 

If A1 will automatically change to a valid partition, I think it should return error.

Thanks.

-- 
Best regards,
Ridong


