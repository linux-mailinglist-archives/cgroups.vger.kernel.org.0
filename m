Return-Path: <cgroups+bounces-12463-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6981BCC9E92
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 01:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E125F3026517
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 00:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0D421E0BA;
	Thu, 18 Dec 2025 00:38:10 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8131A21B196;
	Thu, 18 Dec 2025 00:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766018290; cv=none; b=joA2UOT8a7PB8byk8vKovdlKjU+CH+g6cRFoRpKcsCrAnaFppqyv4S3xQO0Op1HzOW0O5AjKB7NV1V4bb0knzr5Ib7N7UtdKHno8g3LyQvyDbt6YY0t8SCF1VjRbhe5qCbGc4GMfWSCDMEO2j1zPt43WGCVs/AYr84i8wy1NZKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766018290; c=relaxed/simple;
	bh=dYumc4+EuSmPInG3sfVI8Hjhc6C3ZpvYfqwTrwTM0BQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RU/UFRc7JJeqEC7Oykhq7JOoj1waXMTyJTcfPbLJVfNM0U9tECsK3fyyWj/JBb8bCyybKRlxlmGgTsu4P54QSU4E/Qc5gJDrcx6gopj4eZX00bFSXDbFch+CJlNenDzPsf0Y3G1yPWLJRAfprZBWRK167r1FJ8S9s36l75Ns3vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dWsFp6FGxzKHML8;
	Thu, 18 Dec 2025 08:37:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id B885940574;
	Thu, 18 Dec 2025 08:38:00 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP2 (Coremail) with SMTP id Syh0CgAXMH_oTENpZuc+Ag--.6114S2;
	Thu, 18 Dec 2025 08:38:00 +0800 (CST)
Message-ID: <c9168f74-3e24-4902-bb06-c512a5e96669@huaweicloud.com>
Date: Thu, 18 Dec 2025 08:37:59 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 1/6] cpuset: add assert_cpuset_lock_held helper
To: Waiman Long <llong@redhat.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com
References: <20251217084942.2666405-1-chenridong@huaweicloud.com>
 <20251217084942.2666405-2-chenridong@huaweicloud.com>
 <198cec94-6d2c-46c0-a46a-9ab810deb7e0@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <198cec94-6d2c-46c0-a46a-9ab810deb7e0@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAXMH_oTENpZuc+Ag--.6114S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr48Cr1rWr43Zr1xuF1fXrb_yoW5GryDpF
	1vkFyUJayYyFyv9a4UX3yUuFyFgwnYk3W5JFnYqa4FyFyaqF129F1kXr90gr15Jw4xGF1j
	yFZF9w4a9F1DArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbiF4tUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/12/18 1:02, Waiman Long wrote:
> On 12/17/25 3:49 AM, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> Add assert_cpuset_lock_held() to allow other subsystems to verify that
>> cpuset_mutex is held.
> 
> Sorry, I should have added the "lockdep_" prefix when I mentioned adding this helper function to be
> consistent with the others. Could you update the patch to add that?
> 

Thank you.

I was tangled on whether to add the lockdep_ prefix, since lockdep_assert_cpus_held has it. But I
named it as you suggested originally. I'll update the patch accordingly.

> 
>>
>> Suggested-by: Waiman Long <longman@redhat.com>
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>>   include/linux/cpuset.h | 2 ++
>>   kernel/cgroup/cpuset.c | 5 +++++
>>   2 files changed, 7 insertions(+)
>>
>> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
>> index a98d3330385c..af0e76d10476 100644
>> --- a/include/linux/cpuset.h
>> +++ b/include/linux/cpuset.h
>> @@ -74,6 +74,7 @@ extern void inc_dl_tasks_cs(struct task_struct *task);
>>   extern void dec_dl_tasks_cs(struct task_struct *task);
>>   extern void cpuset_lock(void);
>>   extern void cpuset_unlock(void);
>> +extern void assert_cpuset_lock_held(void);
>>   extern void cpuset_cpus_allowed_locked(struct task_struct *p, struct cpumask *mask);
>>   extern void cpuset_cpus_allowed(struct task_struct *p, struct cpumask *mask);
>>   extern bool cpuset_cpus_allowed_fallback(struct task_struct *p);
>> @@ -195,6 +196,7 @@ static inline void inc_dl_tasks_cs(struct task_struct *task) { }
>>   static inline void dec_dl_tasks_cs(struct task_struct *task) { }
>>   static inline void cpuset_lock(void) { }
>>   static inline void cpuset_unlock(void) { }
>> +static inline void assert_cpuset_lock_held(void) { }
>>     static inline void cpuset_cpus_allowed_locked(struct task_struct *p,
>>                       struct cpumask *mask)
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index fea577b4016a..a5ad124ea1cf 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -271,6 +271,11 @@ void cpuset_unlock(void)
>>       mutex_unlock(&cpuset_mutex);
>>   }
>>   +void assert_cpuset_lock_held(void)
>> +{
>> +    lockdep_assert_held(&cpuset_mutex);
>> +}
>> +
>>   /**
>>    * cpuset_full_lock - Acquire full protection for cpuset modification
>>    *
> 

-- 
Best regards,
Ridong


