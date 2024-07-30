Return-Path: <cgroups+bounces-3939-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D3B94058A
	for <lists+cgroups@lfdr.de>; Tue, 30 Jul 2024 04:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A5C41F22065
	for <lists+cgroups@lfdr.de>; Tue, 30 Jul 2024 02:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C8B57CB5;
	Tue, 30 Jul 2024 02:55:13 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A58CA6F;
	Tue, 30 Jul 2024 02:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722308113; cv=none; b=BqZKPMsp6fNmKDC37H9We5IwaNg+P9wLAosmkuOFt0O05aggT4dYlDyuwoo2bKdcsO8Vd9YTg6oRvffNSTStB2dWzQT+vMVUPPlGLRf9gtQjqjGOMr1ttcE375Q0mqNJcrLRTh0iHJ0+c/6Eu5FIPP3LkjQTGW8iZzumRyvuJAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722308113; c=relaxed/simple;
	bh=ggTULUx/cgLYPQgUXYAYMtqgXzl0s0ytU7ZJQllJKWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ioGKoNU1bu5UmKZutM42u/Lx7Bxb4qMh00UdMo9qx5ykmUinQzOURQCUWeDbEQCJqISoM60l0FbnQICaikDKCgHQAPeUrKCi/I9ULzc7r0VDXPmBMbRfm1iu50+iNuehLYMstpvXZz4V3220UoHA3tX7w4j9lECfc0mUzjgAQl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WY08n2SdwzQn9M;
	Tue, 30 Jul 2024 10:50:49 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id D020E140417;
	Tue, 30 Jul 2024 10:55:06 +0800 (CST)
Received: from [10.67.109.79] (10.67.109.79) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Tue, 30 Jul
 2024 10:55:06 +0800
Message-ID: <425f1151-14e6-43f6-810e-efe95f6f401e@huawei.com>
Date: Tue, 30 Jul 2024 10:55:05 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/cpuset: fix panic caused by partcmd_update
To: Waiman Long <longman@redhat.com>, <tj@kernel.org>,
	<lizefan.x@bytedance.com>, <hannes@cmpxchg.org>, <adityakali@google.com>,
	<sergeh@kernel.org>
CC: <bpf@vger.kernel.org>, <cgroups@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240730015316.2324188-1-chenridong@huawei.com>
 <0ba00b7c-5292-4242-b648-4ca8d4a457c6@redhat.com>
Content-Language: en-US
From: chenridong <chenridong@huawei.com>
In-Reply-To: <0ba00b7c-5292-4242-b648-4ca8d4a457c6@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd100013.china.huawei.com (7.221.188.163)



On 2024/7/30 10:34, Waiman Long wrote:
> On 7/29/24 21:53, Chen Ridong wrote:
>> We find a bug as below:
>> BUG: unable to handle page fault for address: 00000003
>> PGD 0 P4D 0
>> Oops: 0000 [#1] PREEMPT SMP NOPTI
>> CPU: 3 PID: 358 Comm: bash Tainted: G        W I        6.6.0-10893-g60d6
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/4
>> RIP: 0010:partition_sched_domains_locked+0x483/0x600
>> Code: 01 48 85 d2 74 0d 48 83 05 29 3f f8 03 01 f3 48 0f bc c2 89 c0 48 9
>> RSP: 0018:ffffc90000fdbc58 EFLAGS: 00000202
>> RAX: 0000000100000003 RBX: ffff888100b3dfa0 RCX: 0000000000000000
>> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000002fe80
>> RBP: ffff888100b3dfb0 R08: 0000000000000001 R09: 0000000000000000
>> R10: ffffc90000fdbcb0 R11: 0000000000000004 R12: 0000000000000002
>> R13: ffff888100a92b48 R14: 0000000000000000 R15: 0000000000000000
>> FS:  00007f44a5425740(0000) GS:ffff888237d80000(0000) knlGS:0000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 0000000100030973 CR3: 000000010722c000 CR4: 00000000000006e0
>> Call Trace:
>>   <TASK>
>>   ? show_regs+0x8c/0xa0
>>   ? __die_body+0x23/0xa0
>>   ? __die+0x3a/0x50
>>   ? page_fault_oops+0x1d2/0x5c0
>>   ? partition_sched_domains_locked+0x483/0x600
>>   ? search_module_extables+0x2a/0xb0
>>   ? search_exception_tables+0x67/0x90
>>   ? kernelmode_fixup_or_oops+0x144/0x1b0
>>   ? __bad_area_nosemaphore+0x211/0x360
>>   ? up_read+0x3b/0x50
>>   ? bad_area_nosemaphore+0x1a/0x30
>>   ? exc_page_fault+0x890/0xd90
>>   ? __lock_acquire.constprop.0+0x24f/0x8d0
>>   ? __lock_acquire.constprop.0+0x24f/0x8d0
>>   ? asm_exc_page_fault+0x26/0x30
>>   ? partition_sched_domains_locked+0x483/0x600
>>   ? partition_sched_domains_locked+0xf0/0x600
>>   rebuild_sched_domains_locked+0x806/0xdc0
>>   update_partition_sd_lb+0x118/0x130
>>   cpuset_write_resmask+0xffc/0x1420
>>   cgroup_file_write+0xb2/0x290
>>   kernfs_fop_write_iter+0x194/0x290
>>   new_sync_write+0xeb/0x160
>>   vfs_write+0x16f/0x1d0
>>   ksys_write+0x81/0x180
>>   __x64_sys_write+0x21/0x30
>>   x64_sys_call+0x2f25/0x4630
>>   do_syscall_64+0x44/0xb0
>>   entry_SYSCALL_64_after_hwframe+0x78/0xe2
>> RIP: 0033:0x7f44a553c887
>>
>> It can be reproduced with cammands:
>> cd /sys/fs/cgroup/
>> mkdir test
>> cd test/
>> echo +cpuset > ../cgroup.subtree_control
>> echo root > cpuset.cpus.partition
>> echo 0-3 > cpuset.cpus // 3 is nproc
> What do you mean by "3 is nproc"? Are there only 3 CPUs in the system? 
> What are the value of /sys/fs/cgroup/cpuset.cpu*?
Yes, I tested it with qemu, only 3 cpus are available.
# cat /sys/fs/cgroup/cpuset.cpus.effective
0-3
This case is taking all cpus away from root, test should fail to be a 
valid root, it should not rebuild scheduling domains.

>>
>> This issue is caused by the incorrect rebuilding of scheduling domains.
>> In this scenario, test/cpuset.cpus.partition should be an invalid root
>> and should not trigger the rebuilding of scheduling domains. When calling
>> update_parent_effective_cpumask with partcmd_update, if newmask is not
>> null, it should recheck newmask whether there are cpus is available
>> for parect/cs that has tasks.
>>
>> Fixes: 0c7f293efc87 ("cgroup/cpuset: Add 
>> cpuset.cpus.exclusive.effective for v2")
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>>   kernel/cgroup/cpuset.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 40ec4abaf440..a9b6d56eeffa 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -1991,6 +1991,8 @@ static int 
>> update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>>               part_error = PERR_CPUSEMPTY;
>>               goto write_error;
>>           }
>> +        /* Check newmask again, whether cpus are available for 
>> parent/cs */
>> +        nocpu |= tasks_nocpu_error(parent, cs, newmask);
>>           /*
>>            * partcmd_update with newmask:
> 
> The code change looks reasonable to me. However, I would like to know 
> more about the reproduction steps.
> 
> Cheers,
> Longman
> 
> 

