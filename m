Return-Path: <cgroups+bounces-3534-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC783926D11
	for <lists+cgroups@lfdr.de>; Thu,  4 Jul 2024 03:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 513CDB21705
	for <lists+cgroups@lfdr.de>; Thu,  4 Jul 2024 01:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F410C4C92;
	Thu,  4 Jul 2024 01:22:59 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DF92581;
	Thu,  4 Jul 2024 01:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720056179; cv=none; b=ehmknusudEfRy0STnSFxmHhIn0kcTFHoCB7NB+uRoqu/q46Xp/NYLziCjOnG5yojOvFwqGy15vy8Ljb2gTnN3dMtHTcwt0r9qU//KxRDfLGYrpmblk92Jg/b/ITb3IYyo9gOKGtRWQGc3SnS0g8dSLZLQmEZ2oyHU/n5AJ1Gvpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720056179; c=relaxed/simple;
	bh=z+w4ejaoa+jghlDzxCLRQpJ0z/PaKPH1ol2ALavecW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ttfijmjbWDIq5mLjL/m+j0bsdgub18oB4EzCWzLkfNHlN2idFevahqqfROh4I2/6WCF4QCU2+XzNkXsAyf2rXP3D8ScDOUn7mfUzoa+n1XuukitoGD0drnxiboK77AdFRDz4/h1odcxFFnSi1rFZQrJRF1OPmPj3NhSHq2lC7wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WDzL922mTzxTrD;
	Thu,  4 Jul 2024 09:18:25 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 70A6D14011A;
	Thu,  4 Jul 2024 09:22:53 +0800 (CST)
Received: from [10.67.109.79] (10.67.109.79) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 4 Jul
 2024 09:22:52 +0800
Message-ID: <73b9ebd0-74ac-4c2c-a85c-5bd66d4c2f7c@huawei.com>
Date: Thu, 4 Jul 2024 09:22:52 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 -next] cgroup/rstat: add force idle show helper
To: Waiman Long <longman@redhat.com>, <tj@kernel.org>,
	<lizefan.x@bytedance.com>, <hannes@cmpxchg.org>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240704005007.1400414-1-chenridong@huawei.com>
 <55c508cf-9bc0-49a5-a286-8a9f3ff55220@redhat.com>
Content-Language: en-US
From: chenridong <chenridong@huawei.com>
In-Reply-To: <55c508cf-9bc0-49a5-a286-8a9f3ff55220@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd100013.china.huawei.com (7.221.188.163)



On 2024/7/4 9:14, Waiman Long wrote:
> 
> On 7/3/24 20:50, Chen Ridong wrote:
>> In the function cgroup_base_stat_cputime_show, there are five
>> instances of #ifdef, which makes the code not concise.
>> To address this, add the function cgroup_force_idle_show
>> to make the code more succinct.
>>
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>>   kernel/cgroup/rstat.c | 36 ++++++++++++++++--------------------
>>   1 file changed, 16 insertions(+), 20 deletions(-)
>>
>> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
>> index fb8b49437573..1568558e36e5 100644
>> --- a/kernel/cgroup/rstat.c
>> +++ b/kernel/cgroup/rstat.c
>> @@ -594,49 +594,45 @@ static void root_cgroup_cputime(struct 
>> cgroup_base_stat *bstat)
>>       }
>>   }
>> +
>> +static void cgroup_force_idle_show(struct seq_file *seq, struct 
>> cgroup_base_stat *bstat)
>> +{
>> +#ifdef CONFIG_SCHED_CORE
>> +    u64 forceidle_time = bstat->forceidle_sum;
>> +
>> +    do_div(forceidle_time, NSEC_PER_USEC);
>> +    seq_printf(seq, "core_sched.force_idle_usec %llu\n", 
>> forceidle_time);
>> +#endif
>> +}
>> +
>>   void cgroup_base_stat_cputime_show(struct seq_file *seq)
>>   {
>>       struct cgroup *cgrp = seq_css(seq)->cgroup;
>>       u64 usage, utime, stime;
>> -    struct cgroup_base_stat bstat;
>> -#ifdef CONFIG_SCHED_CORE
>> -    u64 forceidle_time;
>> -#endif
>>       if (cgroup_parent(cgrp)) {
>>           cgroup_rstat_flush_hold(cgrp);
>>           usage = cgrp->bstat.cputime.sum_exec_runtime;
>>           cputime_adjust(&cgrp->bstat.cputime, &cgrp->prev_cputime,
>>                      &utime, &stime);
>> -#ifdef CONFIG_SCHED_CORE
>> -        forceidle_time = cgrp->bstat.forceidle_sum;
>> -#endif
>>           cgroup_rstat_flush_release(cgrp);
>>       } else {
>> -        root_cgroup_cputime(&bstat);
>> -        usage = bstat.cputime.sum_exec_runtime;
>> -        utime = bstat.cputime.utime;
>> -        stime = bstat.cputime.stime;
>> -#ifdef CONFIG_SCHED_CORE
>> -        forceidle_time = bstat.forceidle_sum;
>> -#endif
>> +        root_cgroup_cputime(&cgrp->bstat);
>> +        usage = cgrp->bstat.cputime.sum_exec_runtime;
>> +        utime = cgrp->bstat.cputime.utime;
>> +        stime = cgrp->bstat.cputime.stime;
> 
> Just a simple comment saying that you are reusing the root cgroup bstat 
> which is otherwise not being used will help readability.
> 
> Other than that, the change LGTM.
Thank you, Longman. I will do that.

Regards,
Ridong
> 
> Cheers,
> Longman
> 
>>       }
>>       do_div(usage, NSEC_PER_USEC);
>>       do_div(utime, NSEC_PER_USEC);
>>       do_div(stime, NSEC_PER_USEC);
>> -#ifdef CONFIG_SCHED_CORE
>> -    do_div(forceidle_time, NSEC_PER_USEC);
>> -#endif
>>       seq_printf(seq, "usage_usec %llu\n"
>>              "user_usec %llu\n"
>>              "system_usec %llu\n",
>>              usage, utime, stime);
>> -#ifdef CONFIG_SCHED_CORE
>> -    seq_printf(seq, "core_sched.force_idle_usec %llu\n", 
>> forceidle_time);
>> -#endif
>> +    cgroup_force_idle_show(seq, &cgrp->bstat);
>>   }
>>   /* Add bpf kfuncs for cgroup_rstat_updated() and 
>> cgroup_rstat_flush() */
> 
> 

