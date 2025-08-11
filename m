Return-Path: <cgroups+bounces-9063-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1ACFB1FDAA
	for <lists+cgroups@lfdr.de>; Mon, 11 Aug 2025 04:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 658463B98E3
	for <lists+cgroups@lfdr.de>; Mon, 11 Aug 2025 02:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736EF70823;
	Mon, 11 Aug 2025 02:17:57 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18178BE49;
	Mon, 11 Aug 2025 02:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754878677; cv=none; b=tVN1QNBpqUbesLxFZt0Bzxwkcc/x3DtqeMQmuCpi/75XlAtE0zgz9ZPoItPuWC2ovW2GvwiZWb8Qurn9pfmpW74vREPmZkKWyEpGDRUNJJK1N6KM5qw1vYxV81GTdywBVM0srEMGeRFRiee6hGKDDNT84SQSve+1dAYkbviPcpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754878677; c=relaxed/simple;
	bh=moEu+OXMYZ6tB+ZL+4Ft1Hex1l38CiVrcQWgI/qg1Ps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j6yvEcbSO93Tbwc/j2Jw3aZ3kfhDuLrCoYE2No8K7uYKtEMJWzcylWCiQIojZOjRcyKe7CvJoO1FLJzQay+o1D4GGmqu8xedPBvcdPN3pPLMGFCJE4HlgmU4B/jOi2vjkOZ9t7vnohyHMc28HMpjxO/NJlFv5ZzlPMfBxn2n+Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c0dZn26xQzYQv0L;
	Mon, 11 Aug 2025 10:17:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E08E41A07BD;
	Mon, 11 Aug 2025 10:17:51 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP4 (Coremail) with SMTP id gCh0CgB3Pg_NUplos4AcDQ--.33067S2;
	Mon, 11 Aug 2025 10:17:51 +0800 (CST)
Message-ID: <d8e0960c-b6fe-49f8-ad85-91973d97a476@huaweicloud.com>
Date: Mon, 11 Aug 2025 10:17:49 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 2/4] cpuset: add helpers for cpuset related locks
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: bsegall@google.com, cgroups@vger.kernel.org, chenridong@huawei.com,
 dietmar.eggemann@arm.com, hannes@cmpxchg.org, juri.lelli@redhat.com,
 linux-kernel@vger.kernel.org, longman@redhat.com, lujialin4@huawei.com,
 mgorman@suse.de, mingo@redhat.com, mkoutny@suse.com, peterz@infradead.org,
 rostedt@goodmis.org, tj@kernel.org, vincent.guittot@linaro.org,
 vschneid@redhat.com
References: <20250808092515.764820-1-chenridong@huaweicloud.com>
 <20250808092515.764820-3-chenridong@huaweicloud.com>
 <30dd9cb7-8471-400e-b293-a1a52921a5f3@wanadoo.fr>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <30dd9cb7-8471-400e-b293-a1a52921a5f3@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3Pg_NUplos4AcDQ--.33067S2
X-Coremail-Antispam: 1UD129KBjvJXoWxur4rWF1UXrW8Gw4kGF4UJwb_yoW5ZF15pF
	1kGFyfJFW5Ar1ku34UWw4Uury8tws5Ga1UGFn5Ja4rAw12yFnFvF1DWr90gr1Ykr4xGF4j
	vFsF939a9a4DArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
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
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/8/9 23:56, Christophe JAILLET wrote:
> Le 08/08/2025 à 11:25, Chen Ridong a écrit :
>> From: Chen Ridong <chenridong-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
>>
>> Add guard_cpus_read_and_cpuset and guard_cpuset helpers for cpuset, which
>> will be user for subsequent patched to make code concise;
>>
>> Signed-off-by: Chen Ridong <chenridong-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
>> ---
>>   include/linux/cpuset.h          |  1 +
>>   kernel/cgroup/cpuset-internal.h |  2 ++
>>   kernel/cgroup/cpuset.c          | 11 +++++++++++
>>   3 files changed, 14 insertions(+)
>>
>> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
>> index 2ddb256187b5..6153de28acf0 100644
>> --- a/include/linux/cpuset.h
>> +++ b/include/linux/cpuset.h
>> @@ -74,6 +74,7 @@ extern void inc_dl_tasks_cs(struct task_struct *task);
>>   extern void dec_dl_tasks_cs(struct task_struct *task);
>>   extern void cpuset_lock(void);
>>   extern void cpuset_unlock(void);
>> +extern void guard_cpuset(void);
>>   extern void cpuset_cpus_allowed(struct task_struct *p, struct cpumask *mask);
>>   extern bool cpuset_cpus_allowed_fallback(struct task_struct *p);
>>   extern bool cpuset_cpu_is_isolated(int cpu);
>> diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
>> index 75b3aef39231..084e19fe33d5 100644
>> --- a/kernel/cgroup/cpuset-internal.h
>> +++ b/kernel/cgroup/cpuset-internal.h
>> @@ -277,6 +277,8 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
>>                       char *buf, size_t nbytes, loff_t off);
>>   int cpuset_common_seq_show(struct seq_file *sf, void *v);
>>   +void guard_cpus_read_and_cpuset(void);
>> +
>>   /*
>>    * cpuset-v1.c
>>    */
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index cf7cd2255265..f6cdb5cdffe8 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -260,6 +260,17 @@ void cpuset_unlock(void)
>>       mutex_unlock(&cpuset_mutex);
>>   }
>>   +void guard_cpuset(void)
>> +{
>> +    guard(mutex)(&cpuset_mutex);
>> +}
>> +
>> +void guard_cpus_read_and_cpuset(void)
>> +{
>> +    guard(cpus_read_lock)();
>> +    guard(mutex)(&cpuset_mutex);
>> +}
>> +
> 
> Not sure that it works like that.
> 
> I think that these 2 functions are just no-op because whatever is "garded", it will be release when
> the function exits.
> 
> So, if correct, all this serie does is removing some existing synchronisation mechanism.
> 
> Do I miss something obvious?
> 
> CJ
> 

Thank you for catching this issue. You're absolutely right - I made a critical mistake in the guard
function implementation.

After further investigation, I realized that when I ran the self-tests with CONFIG_LOCKDEP disabled,
I missed the lock protection warnings that would have revealed this problem earlier. Had Lockdep
been enabled, it would have immediately flagged the incorrect locking behavior.

Please ignore this patch series, Thanks.

Best regards,
Ridong



