Return-Path: <cgroups+bounces-3359-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38738916A67
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 16:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B8A91C230D9
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 14:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6790716D33A;
	Tue, 25 Jun 2024 14:29:54 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5126416C68B;
	Tue, 25 Jun 2024 14:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719325794; cv=none; b=sl2OJ76IhOzR26h2+aBu2ZHvTab2Y5Bd9PPfO1akSf57/ePnxlu85HQCLyKXICaSmDoWJnaoe7syCxx0PqNnMyDRFf8RE+NXXWdamflF4FwhkrYFe+XfZBvaPombmHqzq8s+dAbyGRKTzU56p/LtDa7OyhfHuoGnMRHIh5yKnBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719325794; c=relaxed/simple;
	bh=3RVvHeyAWipkeVyMwWIsWzeZ9VvPaM9h3uVyhNJkd/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XGHmzUyYdwwJn4J+1zeNLU5hF8egu9wjqtIczR2kvHGQZ5j/ZYZw8siFbHcy30a+x2Wss6GIGfjQZtafpe1iSefI5NzI87SEfGx5tJYm009QHnnfe/a5HqaV3v08ugyBwVdfDxXNnj6ELb11o0ZGkpnl5u+1Bhng+1RGb+Sh9bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4W7nHg0Vvxzddj8;
	Tue, 25 Jun 2024 22:28:15 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 8F05F180085;
	Tue, 25 Jun 2024 22:29:48 +0800 (CST)
Received: from [10.67.109.79] (10.67.109.79) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Tue, 25 Jun
 2024 22:29:47 +0800
Message-ID: <b5f49ae4-a905-4c64-8918-83aa53d3dbcd@huawei.com>
Date: Tue, 25 Jun 2024 22:29:47 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] cgroup: fix uaf when proc_cpuset_show
To: Waiman Long <longman@redhat.com>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
	<mkoutny@suse.com>
CC: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<bpf@vger.kernel.org>, <cgroups@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240622113814.120907-1-chenridong@huawei.com>
 <19648b9c-6df7-45cd-a5ae-624a3e4d860f@redhat.com>
 <52f72d1d-602e-4dca-85a3-adade925b056@huawei.com>
 <71a9cc3a-1b58-4051-984b-dd4f18dabf84@redhat.com>
 <8f83ecb3-4afa-4e0b-be37-35b168eb3c7c@huawei.com>
 <ee30843f-2579-4dcf-9688-6541fd892678@redhat.com>
 <3322ce46-78a1-45c5-ad07-a982dec21c8e@huawei.com>
 <gke4hn67e2js2wcia4gopr6u26uy5epwpu7r6sepjwvp5eetql@nuwvwzg2k4dy>
 <920bbfaa-bb76-4aa1-bd07-9a552e3bfdf2@huawei.com>
 <80e87513-aa48-4548-893e-ed339690c941@redhat.com>
Content-Language: en-US
From: chenridong <chenridong@huawei.com>
In-Reply-To: <80e87513-aa48-4548-893e-ed339690c941@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd100013.china.huawei.com (7.221.188.163)


On 2024/6/25 22:16, Waiman Long wrote:
> On 6/25/24 10:11, chenridong wrote:
>>
>>
>> On 2024/6/25 18:10, Michal Koutný wrote:
>>> Hello.
>>>
>>> On Tue, Jun 25, 2024 at 11:12:20AM GMT, 
>>> chenridong<chenridong@huawei.com>  wrote:
>>>> I am considering whether the cgroup framework has a method to fix this
>>>> issue, as other subsystems may also have the same underlying problem.
>>>> Since the root css will not be released, but the css->cgrp will be
>>>> released.
>>> <del>First part is already done in
>>>     d23b5c5777158 ("cgroup: Make operations on the cgroup root_list 
>>> RCU safe")
>>> second part is that</del>
>>> you need to take RCU read lock and check for NULL, similar to
>>>     9067d90006df0 ("cgroup: Eliminate the need for cgroup_mutex in 
>>> proc_cgroup_show()")
>>>
>>> Does that make sense to you?
>>>
>>> A Fixes: tag would be nice, it seems at least
>>>     a79a908fd2b08 ("cgroup: introduce cgroup namespaces")
>>> played some role. (Here the RCU lock is not for cgroup_roots list 
>>> but to
>>> preserve the root cgrp itself css_free_rwork_fn/cgroup_destroy_root.
>>>
>>> HTH,
>>> Michal
>>
>> Thank you, Michal, that is a good idea. Do you mean as below?
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>>
>> index c12b9fdb22a4..2ce0542067f1 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -5051,10 +5051,17 @@ int proc_cpuset_show(struct seq_file *m, 
>> struct pid_namespace *ns,
>>         if (!buf)
>>                 goto out;
>>
>> +       rcu_read_lock();
>> +       spin_lock_irq(&css_set_lock);
>>         css = task_get_css(tsk, cpuset_cgrp_id);
>> -       retval = cgroup_path_ns(css->cgroup, buf, PATH_MAX,
>> - current->nsproxy->cgroup_ns);
>> +
>> +       retval = cgroup_path_ns_locked(css->cgroup, buf, PATH_MAX,
>> +               current->nsproxy->cgroup_ns);
>>         css_put(css);
>> +
>> +       spin_unlock_irq(&css_set_lock);
>> +       cgroup_unlock();
>> +
>>         if (retval == -E2BIG)
>>                 retval = -ENAMETOOLONG;
>>
>>         if (retval < 0)
>>
> That should work. However, I would suggest that you take 
> task_get_css() and css_put() outside of the critical section. The 
> task_get_css() is a while loop that may take a while to execute and 
> you don't want run it with interrupt disabled.
>
> Cheers,
> Longman
>
>
>
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -5050,11 +5050,18 @@ int proc_cpuset_show(struct seq_file *m, struct 
pid_namespace *ns,
         buf = kmalloc(PATH_MAX, GFP_KERNEL);
         if (!buf)
                 goto out;
-
         css = task_get_css(tsk, cpuset_cgrp_id);
-       retval = cgroup_path_ns(css->cgroup, buf, PATH_MAX,
-                               current->nsproxy->cgroup_ns);
+
+       rcu_read_lock();
+       spin_lock_irq(&css_set_lock);
+
+       retval = cgroup_path_ns_locked(css->cgroup, buf, PATH_MAX,
+               current->nsproxy->cgroup_ns);
+
+       spin_unlock_irq(&css_set_lock);
+       rcu_read_unlock();
         css_put(css);
+
         if (retval == -E2BIG)
                 retval = -ENAMETOOLONG;

         if (retval < 0)


Yeah, that looks good, i will test for a while. I will send a new patch 
if no other problem occurs.

Thank you.

Regards,
Ridong



