Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3EE9496AC2
	for <lists+cgroups@lfdr.de>; Sat, 22 Jan 2022 08:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbiAVHyO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 22 Jan 2022 02:54:14 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:30293 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiAVHyO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 22 Jan 2022 02:54:14 -0500
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JgpQW0Vhnzbjk7;
        Sat, 22 Jan 2022 15:53:23 +0800 (CST)
Received: from dggpeml500018.china.huawei.com (7.185.36.186) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 22 Jan 2022 15:54:10 +0800
Received: from [10.67.111.186] (10.67.111.186) by
 dggpeml500018.china.huawei.com (7.185.36.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 22 Jan 2022 15:54:10 +0800
Message-ID: <12975f48-0419-9c34-8751-c3d3fca4f7b3@huawei.com>
Date:   Sat, 22 Jan 2022 15:54:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH] cgroup/cpuset: Fix a race between cpuset_attach() and cpu
 hotplug
To:     Waiman Long <longman@redhat.com>, <linux-kernel@vger.kernel.org>,
        <cgroups@vger.kernel.org>
CC:     <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
        <matthltc@us.ibm.com>, <bblum@google.com>, <menage@google.com>,
        <akpm@linux-foundation.org>, <mkoutny@suse.com>,
        <zhaogongyi@huawei.com>
References: <20220121101210.84926-1-zhangqiao22@huawei.com>
 <a166a39f-aa9f-95af-3f3f-f4e17e7c3305@redhat.com>
From:   Zhang Qiao <zhangqiao22@huawei.com>
In-Reply-To: <a166a39f-aa9f-95af-3f3f-f4e17e7c3305@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.186]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500018.china.huawei.com (7.185.36.186)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2022/1/21 20:43, Waiman Long 写道:
> On 1/21/22 05:12, Zhang Qiao wrote:
>> As previously discussed(https://lkml.org/lkml/2022/1/20/51),
>> cpuset_attach() is affected with similar cpu hotplug race,
>> as follow scenario:
>>
>>       cpuset_attach()                cpu hotplug
>>      ---------------------------            ----------------------
>>      down_write(cpuset_rwsem)
>>      guarantee_online_cpus() // (load cpus_attach)
>>                     sched_cpu_deactivate
>>                       set_cpu_active()
>>                       // will change cpu_active_mask
>>      set_cpus_allowed_ptr(cpus_attach)
>>        __set_cpus_allowed_ptr_locked()
>>         // (if the intersection of cpus_attach and
>>           cpu_active_mask is empty, will return -EINVAL)
>>      up_write(cpuset_rwsem)
>>
>> To avoid races such as described above, protect cpuset_attach() call
>> with cpu_hotplug_lock.
>>
>> Fixes: be367d099270 ("cgroups: let ss->can_attach and ss->attach do whole threadgroups at a time")
>> Reported-by: Zhao Gongyi <zhaogongyi@huawei.com>
>> Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
>> ---
>>   kernel/cgroup/cpuset.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index dc653ab26e50..0af5725cc1df 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -2252,6 +2252,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
>>       cgroup_taskset_first(tset, &css);
>>       cs = css_cs(css);
>>
>> +    cpus_read_lock();
>>       percpu_down_write(&cpuset_rwsem);
>>
>>       guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
>> @@ -2305,6 +2306,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
>>           wake_up(&cpuset_attach_wq);
>>
>>       percpu_up_write(&cpuset_rwsem);
>> +    cpus_read_unlock();
>>   }
>>
>>   /* The various types of files and directories in a cpuset file system */
>> -- 
>> 2.18.0
> 
> The locking sequence looks right.
> 
> Acked-by: Waiman Long <longman@redhat.com>
> 
Thanks for your review!

Regards,
Qiao
.

> .
