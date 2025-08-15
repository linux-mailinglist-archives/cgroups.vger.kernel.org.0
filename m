Return-Path: <cgroups+bounces-9211-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D95F3B27E42
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 12:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D8BB1D04F0B
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 10:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DBC2FF16B;
	Fri, 15 Aug 2025 10:29:04 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613BD1B042E;
	Fri, 15 Aug 2025 10:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755253744; cv=none; b=ZTgFUfN2chAsPxwr9X6V9vkGmY7c5/vFGzd50426C0h3ynN0s4SPl285SvoorOHCCitYiRoF875KIpuPRNFM4zB505Fh20FluJbtSJoJdw5FIoguiLGS/tgRzr9tvY+NYa26zJthGpWlqqSOuyT+Tn7hKbwO9HgG+S2zg8EvjmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755253744; c=relaxed/simple;
	bh=mD27JDoCb4TgmvxvILEg83bBulEzprsOZXpmnCkvJjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MRxgV2ePi+Ev+bK/lp4taURZ0yhBRRdoiwsNqY3EF5dsNm49JN74NFX9tYAi12SQM5pIwDyn9Lcz260hpP7yHNbFbi4/2bQKYpsuxPLW5E7wVfuWwrDV1895S8+TabN3aeC4gqv14OujBChUYzMZbzJ0w7/TNN9EE2Qqs2vZgzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c3JHb3FZ9zYQv2c;
	Fri, 15 Aug 2025 18:28:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 1002A1A07BB;
	Fri, 15 Aug 2025 18:28:58 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP3 (Coremail) with SMTP id _Ch0CgBn39nlC59oLZTDDg--.64825S2;
	Fri, 15 Aug 2025 18:28:55 +0800 (CST)
Message-ID: <afc95938-0eb5-427b-a2dd-a7eccf54d891@huaweicloud.com>
Date: Fri, 15 Aug 2025 18:28:53 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 -next] cgroup: remove offline draining in root
 destruction to avoid hung_tasks
To: Hillf Danton <hdanton@sina.com>
Cc: Michal Koutny <mkoutny@suse.com>, tj@kernel.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, lujialin4@huawei.com, chenridong@huawei.com,
 gaoyingjie@uniontech.com
References: <20250722112733.4113237-1-chenridong@huaweicloud.com>
 <kfqhgb2qq2zc6aipz5adyrqh7mghd6bjumuwok3ie7bq4vfuat@lwejtfevzyzs>
 <7f36d0c7-3476-4bc6-b66e-48496a8be514@huaweicloud.com>
 <20250815024020.4579-1-hdanton@sina.com>
 <20250815100213.4599-1-hdanton@sina.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20250815100213.4599-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBn39nlC59oLZTDDg--.64825S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuF47AF1kuw1UXrWfZFW5KFg_yoW5Zw48pF
	WrA3WYvF4rGr17C3yvva1jga4ftFs3Xw47Xr1fWw1rJF4qvr92qa10kFWYkF1rArn7Cry2
	ya1avwnxGa4jyF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/8/15 18:02, Hillf Danton wrote:
> On Fri, 15 Aug 2025 15:29:56 +0800 Chen Ridong wrote:
>> On 2025/8/15 10:40, Hillf Danton wrote:
>>> On Fri, Jul 25, 2025 at 09:42:05AM +0800, Chen Ridong <chenridong@huaweicloud.com> wrote:
>>>>> On Tue, Jul 22, 2025 at 11:27:33AM +0000, Chen Ridong <chenridong@huaweicloud.com> wrote:
>>>>>> CPU0                            CPU1
>>>>>> mount perf_event                umount net_prio
>>>>>> cgroup1_get_tree                cgroup_kill_sb
>>>>>> rebind_subsystems               // root destruction enqueues
>>>>>> 				// cgroup_destroy_wq
>>>>>> // kill all perf_event css
>>>>>>                                 // one perf_event css A is dying
>>>>>>                                 // css A offline enqueues cgroup_destroy_wq
>>>>>>                                 // root destruction will be executed first
>>>>>>                                 css_free_rwork_fn
>>>>>>                                 cgroup_destroy_root
>>>>>>                                 cgroup_lock_and_drain_offline
>>>>>>                                 // some perf descendants are dying
>>>>>>                                 // cgroup_destroy_wq max_active = 1
>>>>>>                                 // waiting for css A to die
>>>>>>
>>>>>> Problem scenario:
>>>>>> 1. CPU0 mounts perf_event (rebind_subsystems)
>>>>>> 2. CPU1 unmounts net_prio (cgroup_kill_sb), queuing root destruction work
>>>>>> 3. A dying perf_event CSS gets queued for offline after root destruction
>>>>>> 4. Root destruction waits for offline completion, but offline work is
>>>>>>    blocked behind root destruction in cgroup_destroy_wq (max_active=1)
>>>>>
>>>>> What's concerning me is why umount of net_prio hierarhy waits for
>>>>> draining of the default hierachy? (Where you then run into conflict with
>>>>> perf_event that's implicit_on_dfl.)
>>>>>
>>> /*
>>>  * cgroup destruction makes heavy use of work items and there can be a lot
>>>  * of concurrent destructions.  Use a separate workqueue so that cgroup
>>>  * destruction work items don't end up filling up max_active of system_wq
>>>  * which may lead to deadlock.
>>>  */
>>>
>>> If task hung could be reliably reproduced, it is right time to cut
>>> max_active off for cgroup_destroy_wq according to its comment.
>>
>> Hi Danton,
>>
>> Thank you for your feedback.
>>
>> While modifying max_active could be a viable solution, I’m unsure whether it might introduce other
>> side effects. Instead, I’ve proposed an alternative approach in v3 of the patch, which I believe
>> addresses the issue more comprehensively.
>>
> Given your reproducer [1], it is simple to test with max_active cut.
> 
> I do not think v3 is a correct fix frankly because it leaves the root cause
> intact. Nor is it cgroup specific even given high concurrency in destruction.
> 
> [1] https://lore.kernel.org/lkml/39e05402-40c7-4631-a87b-8e3747ceddc6@huaweicloud.com/

Hi Danton,

Thank you for your reply.
To clarify, when you mentioned "cut max_active off", did you mean setting max_active of
cgroup_destroy_wq to 1?

Note that cgroup_destroy_wq already has max_active=1 as inited:

```cgroup_destroy_wq = alloc_workqueue("cgroup_destroy", 0, 1);```

The v3 changes prevent subsystem root destruction from being blocked by unrelated subsystem offline
events. Since root destruction should only proceed after all descendants are destroyed, it shouldn't
be blocked by children offline events. My testing with the reproducer confirms this fixes the issue
I encountered.

-- 
Best regards,
Ridong


