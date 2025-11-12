Return-Path: <cgroups+bounces-11849-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2E8C507A8
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 05:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C73264E8EF9
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 04:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD772C0F62;
	Wed, 12 Nov 2025 04:07:17 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758762820DB;
	Wed, 12 Nov 2025 04:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762920437; cv=none; b=qEUmiljW22B64gGJz2kSbxHMa+lR7Z5K1h/r56lcgvUOWZSsB2ZUu3Qb8Jt7ZsqZiWkTKZDrBCZUgBhuqV1+GJSi/5K8vgaMohUr78CfQLJcUZX+szBPLw4ryO15j1uvag5gEXdw1IEWbmQupYU61OTyRNAe/hmJrCpULbdJCCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762920437; c=relaxed/simple;
	bh=cScFm02nwlwZeY8pfG80ctyyXNzrHj/7vnVK1zAfUq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O2w1DODw0tvHI4jDFTStYYSBiMcSo/bF7PJFC4r2DQnvoW4VAvwN/Swbr7AwRfLkSChbLr/K9fhzW2Z6qN1orWbBaSlBbbX18hlDwepfORRYPdx4Ak9Ya3sWs5rOg/kqHwGgtQvekaCB6lO/U9ohiGpItKuDqaH03qyP6HYNusk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d5qbK2FWszYQtGx;
	Wed, 12 Nov 2025 12:06:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 24D311A1A7E;
	Wed, 12 Nov 2025 12:07:05 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgDnDlznBxRp4ajLAQ--.10098S2;
	Wed, 12 Nov 2025 12:07:05 +0800 (CST)
Message-ID: <6e2e4f6a-a6a0-47b1-b037-c52f0c786018@huaweicloud.com>
Date: Wed, 12 Nov 2025 12:07:03 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] cpuset: Treat tasks in attaching process as
 populated
To: Waiman Long <llong@redhat.com>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, lujialin4@huawei.com, chenridong@huawei.com
References: <20251111132632.950430-1-chenridong@huaweicloud.com>
 <dpo6yfx7tb6b3vgayxnqgxwighrl7ds6teaatii5us2a6dqmnw@ioipae3evzo4>
 <fed9367d-19bd-4df0-b59d-8cb5a624ef34@redhat.com>
 <sebxxc2px767l447xr7cmkvlsewvdiazp7ksee3u2hlqaka522@egghgtj4oowf>
 <a4e61aa0-5c1f-490e-9cae-5e478ba809ee@redhat.com>
 <86361412-7de0-46bc-9188-a32b634e43a3@huaweicloud.com>
 <3019dd82-5388-427f-8618-30b5d8b06fd8@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <3019dd82-5388-427f-8618-30b5d8b06fd8@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnDlznBxRp4ajLAQ--.10098S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF4rCr4kXw43AFy8Cry8Krg_yoWrWF1DpF
	WUWF17tws0yw12kws7K3WIq3WSv3srKF45Xr95JryrAasxWr1Fvr12yFWF9Fyjgrn7GrWj
	vFW5XryxWa4qyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



On 2025/11/12 10:21, Waiman Long wrote:
> On 11/11/25 8:58 PM, Chen Ridong wrote:
>>
>> On 2025/11/12 4:35, Waiman Long wrote:
>>> On 11/11/25 2:25 PM, Michal Koutný wrote:
>>>> On Tue, Nov 11, 2025 at 10:16:33AM -0500, Waiman Long <llong@redhat.com> wrote:
>>>>> For internal helper like this one, we may not really need that as
>>>>> almost all the code in cpuset.c are within either a cpuset_mutex or
>>>>> callback_lock critical sections. So I am fine with or without it.
>>>> OK, cpuset_mutex and callback_lock are close but cgroup_is_populated()
>>>> that caught my eye would also need cgroup_mutex otherwise "the result
>>>> can only be used as a hint" (quote from cgroup.h).
>>>>
>>>> Or is it safe to assume that cpuset_mutex inside cpuset_attach() is
>>>> sufficient to always (incl. exits) ensure stability of
>>>> cgroup_is_populated() result?
>>>>
>>>> Anyway, I'd find some clarifications in the commit message or the
>>>> surrounding code about this helpful. (Judgment call, whether with a
>>>> lockdep macro. My opinion is -- why not.)
>>> For attach_in_progress, it is protected by the cpuset_mutex. So it may make sense to add a
>>> lockdep_assert_held() for that.
>>>
>> Will add.
>>
>>> You are right that there are problems WRT the stability of cgroup_is_populated() value.
>>>
>>> I think "cgrp->nr_populated_csets + cs->attach_in_progress" should be almost stable for the cgroup
>>> itself with cpuset_mutex, but there can be a small timing window after cpuset_attach(), but before
>>> the stat is updated where the sum is 0, but there are actually tasks in the cgroup.
>>>
>> Do you mean there’s a small window after ss->attach (i.e., cpuset_attach) where
>> cgrp->nr_populated_csets + cs->attach_in_progress could be 0?
>>
>> If I understand correctly:
>>
>> ss->can_attach: cs->attach_in_progress++, sum > 0
>> css_set_move_task->css_set_update_populated: cgrp->nr_populated_csets++, sum > 0
>> ss->attach->cpuset_attach: cs->attach_in_progress--, sum > 0
>>
>> What exactly is the small window you’re referring to where the sum equals 0?
> Yes, the nr_populated_csets is incremented before calling cpuset_attach(). I think I had mixed up
> the ordering. Thanks for the clarification.
>>
>>> For "cgrp->nr_populated_domain_children + cgrp->nr_populated_threaded_children", it also has the
>>> problem that the sum can be 0 but there are attach_in_progress set in one or more of the child
>>> cgroups. So even with this patch, we can't guarantee 100% that there can be no task in the partition
>>> even if it has empty effective_cpus. It is only a problem for nested local partitions though as
>>> remote partitions are not allowed to exhaust all the CPUs from root cgroup.
>>>
>>> We should probably document that limitation to warn users if they try to create nested local
>>> partitions where the parent partition root of the child partitions has empty effective_cpus.
>>>
>> Hmm, but it was what the commit e2d59900d936 ("cgroup/cpuset: Allow no-task partition to have empty
>> cpuset.cpus.effective") allowed, and it makes sense.
> 
> This commit will allow user to not waste a CPU if users want to set up a nested local partitions
> where there is no task in some intermediate levels. One way to address this gap is to iterate down
> the cpuset hierarchy to check if any of its attach_in_progress count is set. So it is a solvable
> problem.
> 

Yes, the modification needed is to replace cpuset_for_each_child with cpuset_for_each_descendant_pre
in partition_is_populated.

> There is also a flip side where cgroup_is_populated() returns a non-zero value, but the tasks are
> actively being moved away. This false positive is less a problem even though it can cause a failure
> in distributing out all the CPUs to child partitions. The users can retry and it should work the
> second time.
> 

Agree. This is a short-lived state, and it’s difficult to determine if any tasks are in the
partition during this period. Users should retry.

-- 
Best regards,
Ridong


