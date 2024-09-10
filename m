Return-Path: <cgroups+bounces-4781-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D03F797269A
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 03:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F32C51C2252D
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 01:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48DC4204B;
	Tue, 10 Sep 2024 01:31:52 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D2A5695;
	Tue, 10 Sep 2024 01:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725931912; cv=none; b=rqvBoXL/fJw0TEoLjLK1gKdycYFxFN2I+H+WMKsT7U2WH1FY/6Wa6UW13awJsSEhvTsUkzE9wHEQnBou/oCsgetgaSZgjVWx1V4K3fNcbEYZd2HPTuguyIVn8iIfRKFr8z3TtXoDwgmq4FN+1L46H/BaDinmeRt3bRBCO8unJO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725931912; c=relaxed/simple;
	bh=S7Z1cGFHh5sWS+TsBJHRcmpg3hVPKg/xmER13R9dUE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=toISx8iRFRcQq+7kOMXZZ1da7k8DAzU6nYRpy/+eAspuIFrJ82hhcpXgTwQRgY8r+YzJpSRHBiFEJ/3xkpzw6MLm6WyIRXF389pg9dPN9tovpsSHD/dXRsDTYFXyFe8CGX6vSMkiwtmIGaupQpx2tO8893nYhhikWWncMdOdKq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4X2mPs0kTwz4f3kvh;
	Tue, 10 Sep 2024 09:31:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 4061F1A07B6;
	Tue, 10 Sep 2024 09:31:45 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP4 (Coremail) with SMTP id gCh0CgCXzMh9od9mInePAw--.1036S2;
	Tue, 10 Sep 2024 09:31:43 +0800 (CST)
Message-ID: <07501c67-3b18-48e3-8929-e773d8d6920f@huaweicloud.com>
Date: Tue, 10 Sep 2024 09:31:41 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] cgroup: fix deadlock caused by cgroup_mutex and
 cpu_hotplug_lock
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Chen Ridong <chenridong@huawei.com>
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
 lizefan.x@bytedance.com, hannes@cmpxchg.org, roman.gushchin@linux.dev,
 bpf@vger.kernel.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240817093334.6062-1-chenridong@huawei.com>
 <20240817093334.6062-2-chenridong@huawei.com>
 <kz6e3oadkmrl7elk6z765t2hgbcqbd2fxvb2673vbjflbjxqck@suy4p2mm7dvw>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <kz6e3oadkmrl7elk6z765t2hgbcqbd2fxvb2673vbjflbjxqck@suy4p2mm7dvw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXzMh9od9mInePAw--.1036S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Jw4UtFWUJw1rGF45uF1fCrg_yoWxGF17pr
	s0vw1UKF48Wr1v9ayvgayaqFWFkw4vgF47JFZ5Jw1jyrW3Xr12vr129r4YvFZ7Gr93Zrn0
	vay3Zr90gas8trJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
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



On 2024/9/9 22:19, Michal Koutný wrote:
> On Sat, Aug 17, 2024 at 09:33:34AM GMT, Chen Ridong <chenridong@huawei.com> wrote:
>> The reason for this issue is cgroup_mutex and cpu_hotplug_lock are
>> acquired in different tasks, which may lead to deadlock.
>> It can lead to a deadlock through the following steps:
>> 1. A large number of cpusets are deleted asynchronously, which puts a
>>     large number of cgroup_bpf_release works into system_wq. The max_active
>>     of system_wq is WQ_DFL_ACTIVE(256). Consequently, all active works are
>>     cgroup_bpf_release works, and many cgroup_bpf_release works will be put
>>     into inactive queue. As illustrated in the diagram, there are 256 (in
>>     the acvtive queue) + n (in the inactive queue) works.
>> 2. Setting watchdog_thresh will hold cpu_hotplug_lock.read and put
>>     smp_call_on_cpu work into system_wq. However step 1 has already filled
>>     system_wq, 'sscs.work' is put into inactive queue. 'sscs.work' has
>>     to wait until the works that were put into the inacvtive queue earlier
>>     have executed (n cgroup_bpf_release), so it will be blocked for a while.
>> 3. Cpu offline requires cpu_hotplug_lock.write, which is blocked by step 2.
>> 4. Cpusets that were deleted at step 1 put cgroup_release works into
>>     cgroup_destroy_wq. They are competing to get cgroup_mutex all the time.
>>     When cgroup_metux is acqured by work at css_killed_work_fn, it will
>>     call cpuset_css_offline, which needs to acqure cpu_hotplug_lock.read.
>>     However, cpuset_css_offline will be blocked for step 3.
>> 5. At this moment, there are 256 works in active queue that are
>>     cgroup_bpf_release, they are attempting to acquire cgroup_mutex, and as
>>     a result, all of them are blocked. Consequently, sscs.work can not be
>>     executed. Ultimately, this situation leads to four processes being
>>     blocked, forming a deadlock.
>>
>> system_wq(step1)		WatchDog(step2)			cpu offline(step3)	cgroup_destroy_wq(step4)
>> ...
>> 2000+ cgroups deleted asyn
>> 256 actives + n inactives
>> 				__lockup_detector_reconfigure
>> 				P(cpu_hotplug_lock.read)
>> 				put sscs.work into system_wq
>> 256 + n + 1(sscs.work)
>> sscs.work wait to be executed
>> 				warting sscs.work finish
>> 								percpu_down_write
>> 								P(cpu_hotplug_lock.write)
>> 								...blocking...
>> 											css_killed_work_fn
>> 											P(cgroup_mutex)
>> 											cpuset_css_offline
>> 											P(cpu_hotplug_lock.read)
>> 											...blocking...
>> 256 cgroup_bpf_release
>> mutex_lock(&cgroup_mutex);
>> ..blocking...
> 
> Thanks, Ridong, for laying this out.
> Let me try to extract the core of the deps above.
> 
> The correct lock ordering is: cgroup_mutex then cpu_hotplug_lock.
> However, the smp_call_on_cpu() under cpus_read_lock may lead to
> a deadlock (ABBA over those two locks).
> 

That's right.

> This is OK
> 	thread T					system_wq worker
> 	
> 	  						lock(cgroup_mutex) (II)
> 							...
> 							unlock(cgroup_mutex)
> 	down(cpu_hotplug_lock.read)
> 	smp_call_on_cpu
> 	  queue_work_on(cpu, system_wq, scss) (I)
> 							scss.func
> 	  wait_for_completion(scss)
> 	up(cpu_hotplug_lock.read)
> 
> However, there is no ordering between (I) and (II) so they can also happen
> in opposite
> 
> 	thread T					system_wq worker
> 	
> 	down(cpu_hotplug_lock.read)
> 	smp_call_on_cpu
> 	  queue_work_on(cpu, system_wq, scss) (I)
> 	  						lock(cgroup_mutex)  (II)
> 							...
> 							unlock(cgroup_mutex)
> 							scss.func
> 	  wait_for_completion(scss)
> 	up(cpu_hotplug_lock.read)
> 
> And here the thread T + system_wq worker effectively call
> cpu_hotplug_lock and cgroup_mutex in the wrong order. (And since they're
> two threads, it won't be caught by lockdep.)
> 
> By that reasoning any holder of cgroup_mutex on system_wq makes system
> susceptible to a deadlock (in presence of cpu_hotplug_lock waiting
> writers + cpuset operations). And the two work items must meet in same
> worker's processing hence probability is low (zero?) with less than
> WQ_DFL_ACTIVE items.
> 
> (And more generally, any lock that is ordered before cpu_hotplug_lock
> should not be taken in system_wq work functions. Or at least such works
> items should not saturate WQ_DFL_ACTIVE workers.)
> 
> Wrt other uses of cgroup_mutex, I only see
>    bpf_map_free_in_work
>      queue_work(system_unbound_wq)
>        bpf_map_free_deferred
>          ops->map_free == cgroup_storage_map_free
>            cgroup_lock()
> which is safe since it uses a different workqueue than system_wq.
> 
>> To fix the problem, place cgroup_bpf_release works on cgroup_destroy_wq,
>> which can break the loop and solve the problem.
> 
> Yes, it moves the problematic cgroup_mutex holder away from system_wq
> and cgroup_destroy_wq could not cause similar problems because there are
> no explicit waiter for particular work items or its flushing.
> 
> 
>> System wqs are for misc things which shouldn't create a large number
>> of concurrent work items.  If something is going to generate
>>> WQ_DFL_ACTIVE(256) concurrent work
>> items, it should use its own dedicated workqueue.
> 
> Actually, I'm not sure (because I lack workqueue knowledge) if producing
> less than WQ_DFL_ACTIVE work items completely eliminates the chance of
> two offending work items producing the wrong lock ordering.
> 

If producing less than WQ_DFL_ACTIVE work items, it won't lead to a 
deadlock. Because scss.func can be executed and doesn't have to wait for 
work that holds cgroup_mutex to be completed. Therefore, the probability 
is low and this issue can only be reproduced under pressure test.

> 
>> Fixes: 4bfc0bb2c60e ("bpf: decouple the lifetime of cgroup_bpf from cgroup itself")
> 
> I'm now indifferent whether this is needed (perhaps in the sense it is
> the _latest_ of multiple changes that contributed to possibility of this
> deadlock scenario).
> 
> 
>> Link: https://lore.kernel.org/cgroups/e90c32d2-2a85-4f28-9154-09c7d320cb60@huawei.com/T/#t
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>>   kernel/bpf/cgroup.c             | 2 +-
>>   kernel/cgroup/cgroup-internal.h | 1 +
>>   kernel/cgroup/cgroup.c          | 2 +-
>>   3 files changed, 3 insertions(+), 2 deletions(-)
> 
> I have convinved myself now that you can put
> 
> Reviewed-by: Michal Koutný <mkoutny@suse.com>
> 
> Regards,
> Michal

Thank you very much.

Best Regards,
Ridong


