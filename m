Return-Path: <cgroups+bounces-3896-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D6393C102
	for <lists+cgroups@lfdr.de>; Thu, 25 Jul 2024 13:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42ACF282A76
	for <lists+cgroups@lfdr.de>; Thu, 25 Jul 2024 11:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19439199246;
	Thu, 25 Jul 2024 11:40:24 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B7F16D4C3;
	Thu, 25 Jul 2024 11:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721907623; cv=none; b=lL1V/8KbqsGxycLtPzqexYhvQJUKrA4wcETRZ6vij5UQk9nbRB6Kl7RuOU+0N748I5yS9sf6GzoVg7pYFlAf2ugzOjirFuEXUTe4zjQVhBanlCTdSy3EKuNOqYQt58qf9yVORAarPWmdGdopxl14V4n5iaeiKRdaiuXzupCPCP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721907623; c=relaxed/simple;
	bh=x/jTSeOOMzGPoBXYqDy5bsmeArwSYudVrZXlX+289Yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kj6CN1HwIJT4pOVmPaeynAjrybi6tSzilEjDzDqo8lvFvGYGSQV5mkpazhQXZerm4wkwU9aWlHzBojmfrXSJUmPL5lNez2q4pftXgjm1gVDgg9tu+m6X+ZsdX3IyIScNewZiH65niKgReaPAwByfKaG25Bx0GcOV50k3GGEUDFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WV84t68h0z1HFVZ;
	Thu, 25 Jul 2024 19:37:34 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 2F56F140259;
	Thu, 25 Jul 2024 19:40:17 +0800 (CST)
Received: from [10.67.109.79] (10.67.109.79) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 25 Jul
 2024 19:40:16 +0800
Message-ID: <de6958aa-27f8-4baa-b76d-88266d009f81@huawei.com>
Date: Thu, 25 Jul 2024 19:40:15 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] cgroup/cpuset: add dec_attach_in_progress helper
To: Kamalesh Babulal <kamalesh.babulal@oracle.com>, <tj@kernel.org>,
	<lizefan.x@bytedance.com>, <hannes@cmpxchg.org>, <longman@redhat.com>,
	<adityakali@google.com>, <sergeh@kernel.org>, <mkoutny@suse.com>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240725015551.2221867-1-chenridong@huawei.com>
 <e5c92f54-d767-4e71-9f57-9352923bd3e7@oracle.com>
Content-Language: en-US
From: chenridong <chenridong@huawei.com>
In-Reply-To: <e5c92f54-d767-4e71-9f57-9352923bd3e7@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd100013.china.huawei.com (7.221.188.163)



On 2024/7/25 19:01, Kamalesh Babulal wrote:
> 
> 
> On 7/25/24 7:25 AM, Chen Ridong wrote:
>> There are several functions to decrease attach_in_progress, and they
>> will wake up cpuset_attach_wq when attach_in_progress is zero. So,
>> add a helper to make it concise.
>>
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>>   kernel/cgroup/cpuset.c | 28 +++++++++++++++-------------
>>   1 file changed, 15 insertions(+), 13 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index d4322619e59a..c241845694ac 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -490,6 +490,17 @@ static inline void check_insane_mems_config(nodemask_t *nodes)
>>   	}
>>   }
>>   
>> +/*
>> + * decrease cs->attach_in_progress.
>> + * wake_up cpuset_attach_wq if cs->attach_in_progress==0.
> 
> In the description, adding locking constraint of cpuset_mutex would be helpful.
> Something like "cpuset_mutex must be held by the caller."
> 
Thank you, I will to that.
>> + */
>> +static inline void dec_attach_in_progress(struct cpuset *cs)
>> +{
>> +	cs->attach_in_progress--;
>> +	if (!cs->attach_in_progress)
>> +		wake_up(&cpuset_attach_wq);
>> +}
>> +
>>   /*
>>    * Cgroup v2 behavior is used on the "cpus" and "mems" control files when
>>    * on default hierarchy or when the cpuset_v2_mode flag is set by mounting
>> @@ -3421,9 +3432,7 @@ static void cpuset_cancel_attach(struct cgroup_taskset *tset)
>>   	cs = css_cs(css);
>>   
>>   	mutex_lock(&cpuset_mutex);
>> -	cs->attach_in_progress--;
>> -	if (!cs->attach_in_progress)
>> -		wake_up(&cpuset_attach_wq);
>> +	dec_attach_in_progress(cs);
>>   
>>   	if (cs->nr_migrate_dl_tasks) {
>>   		int cpu = cpumask_any(cs->effective_cpus);
>> @@ -3538,9 +3547,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
>>   		reset_migrate_dl_data(cs);
>>   	}
>>   
>> -	cs->attach_in_progress--;
>> -	if (!cs->attach_in_progress)
>> -		wake_up(&cpuset_attach_wq);
>> +	dec_attach_in_progress(cs);
>>   
>>   	mutex_unlock(&cpuset_mutex);
>>   }
>> @@ -4284,9 +4291,7 @@ static void cpuset_cancel_fork(struct task_struct *task, struct css_set *cset)
>>   		return;
>>   
>>   	mutex_lock(&cpuset_mutex);
>> -	cs->attach_in_progress--;
>> -	if (!cs->attach_in_progress)
>> -		wake_up(&cpuset_attach_wq);
>> +	dec_attach_in_progress(cs);
>>   	mutex_unlock(&cpuset_mutex);
>>   }
>>   
>> @@ -4319,10 +4324,7 @@ static void cpuset_fork(struct task_struct *task)
>>   	guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
>>   	cpuset_attach_task(cs, task);
>>   
>> -	cs->attach_in_progress--;
>> -	if (!cs->attach_in_progress)
>> -		wake_up(&cpuset_attach_wq);
>> -
>> +	dec_attach_in_progress(cs);
>>   	mutex_unlock(&cpuset_mutex);
>>   }
>>   
> 

