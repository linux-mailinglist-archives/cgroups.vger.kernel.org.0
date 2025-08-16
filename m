Return-Path: <cgroups+bounces-9240-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FC9B28935
	for <lists+cgroups@lfdr.de>; Sat, 16 Aug 2025 02:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A644C5A82D0
	for <lists+cgroups@lfdr.de>; Sat, 16 Aug 2025 00:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AC42904;
	Sat, 16 Aug 2025 00:23:14 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B369A38B;
	Sat, 16 Aug 2025 00:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755303794; cv=none; b=Le4pO/LeD0coYyP+HnEZJSxA/4cH+dWBIGdfaP69KLWvU3LXFl3VIHzSue4Q+u70FUaNOB3g6TjZ3KrB8glstcBEj3jc2pm80ONDKP+djPejgaD/sDG3w0PVWk4xoncg6YoDazowbGjAY2kHPfzyzNiFkMps9pEBucw9b2zblC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755303794; c=relaxed/simple;
	bh=UMLbRctQ+cTPntRvhQJfLLnfVWo2nOf0W9To+b646lI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mxyKhui/mOF5LtByFbRHVD36a2kdGf8t4WS/eNz+k8QO7BLSrA4vE88n1GFwy6kIWir+EDzqTCLfhNsQk5MDji+qsKm1ZknJTTYbqkGhKxVN/xpZJVKhbsDVeXiBSMA2ZfLUQAQja/LVIgTG0PLv/grxNGBcoM7/+gIeFxgLXQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c3fp64gLczYQv12;
	Sat, 16 Aug 2025 08:23:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 3F6491A07BB;
	Sat, 16 Aug 2025 08:23:09 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP2 (Coremail) with SMTP id Syh0CgDX5LZsz59oR9MTDw--.29195S2;
	Sat, 16 Aug 2025 08:23:09 +0800 (CST)
Message-ID: <7b2a1645-6271-4f90-acea-cb12ba10cf81@huaweicloud.com>
Date: Sat, 16 Aug 2025 08:23:08 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [-next v2 4/4] cpuset: add helpers for cpus read and cpuset_mutex
 locks
To: Waiman Long <llong@redhat.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com, christophe.jaillet@wanadoo.fr
References: <20250813082904.1091651-1-chenridong@huaweicloud.com>
 <20250813082904.1091651-5-chenridong@huaweicloud.com>
 <e0ac3594-deab-455c-9c2f-495b4e4422e2@redhat.com>
 <750ac0bd-42f9-47fa-8274-0ff4e4a7fa3d@huaweicloud.com>
 <93e37ccf-8ac8-40f5-840f-2f221f58131e@redhat.com>
 <d09c4e49-8a3a-49b9-9f63-0b39a4bea45f@redhat.com>
 <c88c6e2e-5988-405c-a037-651a8800ba83@huaweicloud.com>
 <820ec990-9695-46d0-ae95-2c0eda66bf9c@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <820ec990-9695-46d0-ae95-2c0eda66bf9c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgDX5LZsz59oR9MTDw--.29195S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXryfJFWkWF1rtrWDZr1fWFg_yoWrJw1rpF
	1kGFy7JrWUJr1xuw1avw1rXry8tw1UKa1UXrn8JF18ZF9FvF1avr1UWFnIgry5Kr4xGr1U
	ZF9ruw43uryDJrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUOBMKDUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/8/16 3:13, Waiman Long wrote:
> On 8/13/25 11:58 PM, Chen Ridong wrote:
>>
>> On 2025/8/14 11:27, Waiman Long wrote:
>>> On 8/13/25 11:13 PM, Waiman Long wrote:
>>>> On 8/13/25 8:44 PM, Chen Ridong wrote:
>>>>> On 2025/8/14 4:09, Waiman Long wrote:
>>>>>> On 8/13/25 4:29 AM, Chen Ridong wrote:
>>>>>>> From: Chen Ridong <chenridong@huawei.com>
>>>>>>>
>>>>>>> cpuset: add helpers for cpus_read_lock and cpuset_mutex
>>>>>>>
>>>>>>> Replace repetitive locking patterns with new helpers:
>>>>>>> - cpus_read_cpuset_lock()
>>>>>>> - cpus_read_cpuset_unlock()
>>>>>>>
>>>>>>> This makes the code cleaner and ensures consistent lock ordering.
>>>>>>>
>>>>>>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>>>>>>> ---
>>>>>>>     kernel/cgroup/cpuset-internal.h |  2 ++
>>>>>>>     kernel/cgroup/cpuset-v1.c       | 12 +++------
>>>>>>>     kernel/cgroup/cpuset.c          | 48 +++++++++++++++------------------
>>>>>>>     3 files changed, 28 insertions(+), 34 deletions(-)
>>>>>>>
>>>>>>> diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
>>>>>>> index 75b3aef39231..6fb00c96044d 100644
>>>>>>> --- a/kernel/cgroup/cpuset-internal.h
>>>>>>> +++ b/kernel/cgroup/cpuset-internal.h
>>>>>>> @@ -276,6 +276,8 @@ int cpuset_update_flag(cpuset_flagbits_t bit, struct cpuset *cs, int
>>>>>>> turning_on)
>>>>>>>     ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
>>>>>>>                         char *buf, size_t nbytes, loff_t off);
>>>>>>>     int cpuset_common_seq_show(struct seq_file *sf, void *v);
>>>>>>> +void cpus_read_cpuset_lock(void);
>>>>>>> +void cpus_read_cpuset_unlock(void);
>>>>>> The names are not intuitive. I would prefer just extend the cpuset_lock/unlock to include
>>>>>> cpus_read_lock/unlock and we use cpuset_lock/unlock consistently in the cpuset code. Also,
>>>>>> there is
>>>>>> now no external user of cpuset_lock/unlock, we may as well remove them from
>>>>>> include/linux/cpuset.h.
>>>>>>
>>>>>> Cheers,
>>>>>> Longman
>>>>> I like the idea and have considered it.
>>>>> However, I noticed that cpuset_locked is being used in __sched_setscheduler.
>>>> Right, I overloooked the cpuset_lock() call in kernel/sched/syscall.c. So we can't remove it from
>>>> include/linux/cpuset.h.
>>>>
>>>> This call is invoked to ensure cpusets information is stable. However, it doesn't hurt if the
>>>> cpus_read_lock() is also acquired as a result. Alternatively, we can use a name like
>>>> cpuset_full_lock() to include cpus_read_lock().
>>> I have a correction. According to commit d74b27d63a8b ("cgroup/cpuset: Change cpuset_rwsem and
>>> hotplug lock order") , sched_scheduler() can be called while holding cpus_hotplug_lock. So we should
>>> keep cpuset_lock() as it is.
>>>
>>> Cheers,
>>> Longman
>> Thank you Longman, this is very helpful.
>>
>> I had considered whether we can add cpus_read_lock() to the cpuset_lock, but based on your
>> explanation, I now understand this approach would not work.
>>
>> For clarity, would it be acceptable to rename:
>> cpus_read_cpuset_lock() -> cpuset_full_lock()
>> cpus_read_cpuset_unlock() -> cpuset_full_unlock()
> 
> Yes, that is what I want to see. Note that taking both cpus_read_lock() and cpuset_mutex are needed
> to modify cpuset data. Taking just cpuset_mutex will prevent other from making changes to the cpuset
> data, but is not enough to make modification.
> 
> Cheers,
> Longman
> 
>>

See, I will add the comments to clarify how to use these helpers.

-- 
Best regards,
Ridong


