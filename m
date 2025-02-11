Return-Path: <cgroups+bounces-6504-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B67F6A309EB
	for <lists+cgroups@lfdr.de>; Tue, 11 Feb 2025 12:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B57BB7A119D
	for <lists+cgroups@lfdr.de>; Tue, 11 Feb 2025 11:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793A21F8AC0;
	Tue, 11 Feb 2025 11:29:55 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB5C26BD9A;
	Tue, 11 Feb 2025 11:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739273395; cv=none; b=dY5PlnfEg2kb7aJjaDoOP/Pwb21z3DF7JAqpFiF0E+IBrd6e2EOr5W4W6I+SfAsxAUXN+SvfxM7Tinb5NES7F8mVOZOi3ACpHcb2wRrBStBtc7/Mkgn5pYDWhxo+v6eKjEvVkjR3Ka3xjqjTedVff4TOOLpex5owMzccd/0Sacg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739273395; c=relaxed/simple;
	bh=FLOu/pI7z3ZO2PxU3I4TJKJo2y1oKoRHc8iwNZcTOJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kHyKcOc3vuhHa3mNHq7p9HDC0LktffzRBIWJ1ZwLpoUJv6STqOjyO83WErY0hEBKOpdnBzH7Vuqt7XZ9XJL8bKSgY1EloisBTcqPz9ZDcdP8YMPtfInnRw8snGAcn2a3PLa/EdYnXtaceDSVfQ6WZWL5GsieKI3fQm9bp0PabmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YsfNd58NFz4f3kvm;
	Tue, 11 Feb 2025 19:29:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 648701A0D28;
	Tue, 11 Feb 2025 19:29:44 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP4 (Coremail) with SMTP id gCh0CgDnSF2mNKtnDpMpDg--.53537S2;
	Tue, 11 Feb 2025 19:29:44 +0800 (CST)
Message-ID: <10f34835-b604-4fbe-8bca-8f7d762d4419@huaweicloud.com>
Date: Tue, 11 Feb 2025 19:29:42 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] memcg: avoid dead loop when setting memory.max
To: Michal Hocko <mhocko@suse.com>
Cc: hannes@cmpxchg.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, akpm@linux-foundation.org, cgroups@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, chenridong@huawei.com,
 wangweiyang2@huawei.com
References: <20250211081819.33307-1-chenridong@huaweicloud.com>
 <Z6sSOC0YWWZLMhtO@tiehlicka>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <Z6sSOC0YWWZLMhtO@tiehlicka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDnSF2mNKtnDpMpDg--.53537S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr48Kr1fAry7CF4kJw4ruFg_yoW7Jr1UpF
	93X3WUKF48Jr4kXrsFvF10gr15Aan7CFy7JryxWr1fZasxG3Wjyr1UKw45XryDJr1Fvr4S
	vF1qqw1xtw4qyaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/2/11 17:02, Michal Hocko wrote:
> On Tue 11-02-25 08:18:19, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> A softlockup issue was found with stress test:
>>  watchdog: BUG: soft lockup - CPU#27 stuck for 26s! [migration/27:181]
>>  CPU: 27 UID: 0 PID: 181 Comm: migration/27 6.14.0-rc2-next-20250210 #1
>>  Stopper: multi_cpu_stop <- stop_machine_from_inactive_cpu
>>  RIP: 0010:stop_machine_yield+0x2/0x10
>>  RSP: 0000:ff4a0dcecd19be48 EFLAGS: 00000246
>>  RAX: ffffffff89c0108f RBX: ff4a0dcec03afe44 RCX: 0000000000000000
>>  RDX: ff1cdaaf6eba5808 RSI: 0000000000000282 RDI: ff1cda80c1775a40
>>  RBP: 0000000000000001 R08: 00000011620096c6 R09: 7fffffffffffffff
>>  R10: 0000000000000001 R11: 0000000000000100 R12: ff1cda80c1775a40
>>  R13: 0000000000000000 R14: 0000000000000001 R15: ff4a0dcec03afe20
>>  FS:  0000000000000000(0000) GS:ff1cdaaf6eb80000(0000)
>>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>  CR2: 0000000000000000 CR3: 00000025e2c2a001 CR4: 0000000000773ef0
>>  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>  PKRU: 55555554
>>  Call Trace:
>>   multi_cpu_stop+0x8f/0x100
>>   cpu_stopper_thread+0x90/0x140
>>   smpboot_thread_fn+0xad/0x150
>>   kthread+0xc2/0x100
>>   ret_from_fork+0x2d/0x50
>>
>> The stress test involves CPU hotplug operations and memory control group
>> (memcg) operations. The scenario can be described as follows:
>>
>>  echo xx > memory.max 	cache_ap_online			oom_reaper
>>  (CPU23)						(CPU50)
>>  xx < usage		stop_machine_from_inactive_cpu
>>  for(;;)			// all active cpus
>>  trigger OOM		queue_stop_cpus_work
>>  // waiting oom_reaper
>>  			multi_cpu_stop(migration/xx)
>>  			// sync all active cpus ack
>>  			// waiting cpu23 ack
>>  			// CPU50 loops in multi_cpu_stop
>>  							waiting cpu50
>>
>> Detailed explanation:
>> 1. When the usage is larger than xx, an OOM may be triggered. If the
>>    process does not handle with ths kill signal immediately, it will loop
>>    in the memory_max_write.
> 
> Do I get it right that the issue is that mem_cgroup_out_of_memory which
> doesn't have any cond_resched so it cannot yield to stopped kthread?
> oom itself cannot make any progress because the oom victim is blocked as
> per 3).
> 

Yes, the same task was evaluated as the victim, which is blocked as
described in point 3). Consequently, the operation returned oc->chosen =
(void *)-1UL in the oom_evaluate_task function, and no cond_resched()
was invoked.

for(;;) {
...
mem_cgroup_out_of_memory
  out_of_memory
    select_bad_process
      oom_evaluate_task
	oc->chosen = (void *)-1UL;
  return !!oc->chosen;
}

>> 2. When cache_ap_online is triggered, the multi_cpu_stop is queued to the
>>    active cpus. Within the multi_cpu_stop function,  it attempts to
>>    synchronize the CPU states. However, the CPU23 didn't acknowledge
>>    because it is stuck in a loop within the for(;;).
>> 3. The oom_reaper process is blocked because CPU50 is in a loop, waiting
>>    for CPU23 to acknowledge the synchronization request.
>> 4. Finally, it formed cyclic dependency and lead to softlockup and dead
>>    loop.
>>
>> To fix this issue, add cond_resched() in the memory_max_write, so that
>> it will not block migration task.
> 
> My first question was why this is not a problem in other
> allocation/charge paths but this one is different because it doesn't
> ever try to reclaim after MAX_RECLAIM_RETRIES reclaim rounds.
> We do have scheduling points in the reclaim path which are no longer
> triggered after we hit oom situation in this case.
> 
> I was thinking about having a guranteed cond_resched when oom killer
> fails to find a victim but it seems the simplest fix for this particular
> corner case is to add cond_resched as you did here. Hopefully we will
> get rid of it very soon when !PREEMPT is removed.
> 
> Btw. this could be a problem on a single CPU machine even without CPU
> hotplug as the oom repear won't run until memory_max_write yields the
> cpu.
> 
>> Fixes: b6e6edcfa405 ("mm: memcontrol: reclaim and OOM kill when shrinking memory.max below usage")
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> 

Thank you very much.

Best regards,
Ridong

>> ---
>>  mm/memcontrol.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 8d21c1a44220..16f3bdbd37d8 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -4213,6 +4213,7 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
>>  		memcg_memory_event(memcg, MEMCG_OOM);
>>  		if (!mem_cgroup_out_of_memory(memcg, GFP_KERNEL, 0))
>>  			break;
>> +		cond_resched();
>>  	}
>>  
>>  	memcg_wb_domain_size_changed(memcg);
>> -- 
>> 2.34.1
> 


