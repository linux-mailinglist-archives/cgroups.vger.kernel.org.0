Return-Path: <cgroups+bounces-6023-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B68A00235
	for <lists+cgroups@lfdr.de>; Fri,  3 Jan 2025 02:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B53787A1AEA
	for <lists+cgroups@lfdr.de>; Fri,  3 Jan 2025 01:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADE7148FF2;
	Fri,  3 Jan 2025 01:09:17 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE94D8F64;
	Fri,  3 Jan 2025 01:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735866557; cv=none; b=Upa0a3sCpDk0I7JR1jwoFmTygRTu6L0Vkh3rwCRCz/4ZAAroWrsf0EvMXZzAibAfLv/NP3wA4rFItT3hDzlynywzlrGIoOfncuqjkVvX+ZVrWyE/8S5aEM8nAa3pZylqsgH/BhabQGPx09IPzlQsKuYpV2a2nfyee8R3gQdjAm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735866557; c=relaxed/simple;
	bh=eh5+5OzFiyshmnHoeNKIWq2bMOcOAps/54moC65dJ3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o7SXMAHD0CZgfNcqdCr6ej/CkUXbypjqfCTHjE/Za/BFl6IwThj38HkN/VeSATmTm2or+Oj9Rmqp8VYl0plaYVymmn1e/+CsxVfCXtp2PsISqD9NTz5l5fTzwH6oO9Rm2UcerCt3GstnbncRyPc6KGMXCCxukktiGUnCTtpPlY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YPQSf3tZ8z4f3jJ5;
	Fri,  3 Jan 2025 09:08:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 87BDE1A185E;
	Fri,  3 Jan 2025 09:09:10 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP4 (Coremail) with SMTP id gCh0CgC33YG1OHdn7dKNGQ--.36224S2;
	Fri, 03 Jan 2025 09:09:10 +0800 (CST)
Message-ID: <479a9cb3-6992-4c01-ab66-7a2755659ba5@huaweicloud.com>
Date: Fri, 3 Jan 2025 09:09:09 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cgroup/cpuset: remove kernfs active break
To: Waiman Long <llong@redhat.com>, chenridong <chenridong@huawei.com>,
 tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, roman.gushchin@linux.dev
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, wangweiyang2@huawei.com
References: <20241220013106.3603227-1-chenridong@huaweicloud.com>
 <5c48f188-0059-46a2-9ccd-aad6721d96bb@redhat.com>
 <cafb38a5-0832-4af4-a3b2-cca32ce63d10@huawei.com>
 <61b5749b-3e75-4cf6-9acb-23b63f78d859@redhat.com>
 <d3ebff6a-9866-40e2-a1ff-07bd77d20187@huaweicloud.com>
 <5cb32477-7346-4417-a49e-de2b7dda7401@redhat.com>
 <ffa385b8-861f-4779-b3f0-462468193cf1@huaweicloud.com>
 <0ab514d5-6611-4a6f-82ff-e71eb8af5f5d@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <0ab514d5-6611-4a6f-82ff-e71eb8af5f5d@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgC33YG1OHdn7dKNGQ--.36224S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuFW8KFW7CF18Cr1rCw1ftFb_yoW3WF4rpF
	1kGF1UKrWrGr18Cr4Utr1UXryUtw47Aa4UXr1kJF10yrWqvr1jvr17Xr4qgryDJr4fJr12
	yr15J342vr1UAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/1/2 23:38, Waiman Long wrote:
> 
> On 12/22/24 9:12 PM, Chen Ridong wrote:
>>
>> On 2024/12/20 23:13, Waiman Long wrote:
>>> On 12/20/24 1:11 AM, Chen Ridong wrote:
>>>> On 2024/12/20 12:16, Waiman Long wrote:
>>>>> On 12/19/24 11:07 PM, chenridong wrote:
>>>>>> On 2024/12/20 10:55, Waiman Long wrote:
>>>>>>> On 12/19/24 8:31 PM, Chen Ridong wrote:
>>>>>>>> From: Chen Ridong <chenridong@huawei.com>
>>>>>>>>
>>>>>>>> A warning was found:
>>>>>>>>
>>>>>>>> WARNING: CPU: 10 PID: 3486953 at fs/kernfs/file.c:828
>>>>>>>> CPU: 10 PID: 3486953 Comm: rmdir Kdump: loaded Tainted: G
>>>>>>>> RIP: 0010:kernfs_should_drain_open_files+0x1a1/0x1b0
>>>>>>>> RSP: 0018:ffff8881107ef9e0 EFLAGS: 00010202
>>>>>>>> RAX: 0000000080000002 RBX: ffff888154738c00 RCX: dffffc0000000000
>>>>>>>> RDX: 0000000000000007 RSI: 0000000000000004 RDI: ffff888154738c04
>>>>>>>> RBP: ffff888154738c04 R08: ffffffffaf27fa15 R09: ffffed102a8e7180
>>>>>>>> R10: ffff888154738c07 R11: 0000000000000000 R12: ffff888154738c08
>>>>>>>> R13: ffff888750f8c000 R14: ffff888750f8c0e8 R15: ffff888154738ca0
>>>>>>>> FS:  00007f84cd0be740(0000) GS:ffff8887ddc00000(0000)
>>>>>>>> knlGS:0000000000000000
>>>>>>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>>>>> CR2: 0000555f9fbe00c8 CR3: 0000000153eec001 CR4: 0000000000370ee0
>>>>>>>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>>>>>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>>>>>>> Call Trace:
>>>>>>>>      kernfs_drain+0x15e/0x2f0
>>>>>>>>      __kernfs_remove+0x165/0x300
>>>>>>>>      kernfs_remove_by_name_ns+0x7b/0xc0
>>>>>>>>      cgroup_rm_file+0x154/0x1c0
>>>>>>>>      cgroup_addrm_files+0x1c2/0x1f0
>>>>>>>>      css_clear_dir+0x77/0x110
>>>>>>>>      kill_css+0x4c/0x1b0
>>>>>>>>      cgroup_destroy_locked+0x194/0x380
>>>>>>>>      cgroup_rmdir+0x2a/0x140
>>>>>>> Were you using cgroup v1 or v2 when this warning happened?
>>>>>> I was using cgroup v1.
>>>>> Thanks for the confirmation.
>>>>>>>> It can be explained by:
>>>>>>>> rmdir                 echo 1 > cpuset.cpus
>>>>>>>>                    kernfs_fop_write_iter // active=0
>>>>>>>> cgroup_rm_file
>>>>>>>> kernfs_remove_by_name_ns    kernfs_get_active // active=1
>>>>>>>> __kernfs_remove                      // active=0x80000002
>>>>>>>> kernfs_drain            cpuset_write_resmask
>>>>>>>> wait_event
>>>>>>>> //waiting (active == 0x80000001)
>>>>>>>>                    kernfs_break_active_protection
>>>>>>>>                    // active = 0x80000001
>>>>>>>> // continue
>>>>>>>>                    kernfs_unbreak_active_protection
>>>>>>>>                    // active = 0x80000002
>>>>>>>> ...
>>>>>>>> kernfs_should_drain_open_files
>>>>>>>> // warning occurs
>>>>>>>>                    kernfs_put_active
>>>>>>>>
>>>>>>>> This warning is caused by 'kernfs_break_active_protection' when
>>>>>>>> it is
>>>>>>>> writing to cpuset.cpus, and the cgroup is removed concurrently.
>>>>>>>>
>>>>>>>> The commit 3a5a6d0c2b03 ("cpuset: don't nest cgroup_mutex inside
>>>>>>>> get_online_cpus()") made cpuset_hotplug_workfn asynchronous, which
>>>>>>>> grabs
>>>>>>>> the cgroup_mutex. To avoid deadlock. the commit 76bb5ab8f6e3
>>>>>>>> ("cpuset:
>>>>>>>> break kernfs active protection in cpuset_write_resmask()") added
>>>>>>>> 'kernfs_break_active_protection' in the cpuset_write_resmask. This
>>>>>>>> could
>>>>>>>> lead to this warning.
>>>>>>>>
>>>>>>>> After the commit 2125c0034c5d ("cgroup/cpuset: Make cpuset hotplug
>>>>>>>> processing synchronous"), the cpuset_write_resmask no longer
>>>>>>>> needs to
>>>>>>>> wait the hotplug to finish, which means that cpuset_write_resmask
>>>>>>>> won't
>>>>>>>> grab the cgroup_mutex. So the deadlock doesn't exist anymore.
>>>>>>>> Therefore,
>>>>>>>> remove kernfs_break_active_protection operation in the
>>>>>>>> 'cpuset_write_resmask'
>>>>>>> The hotplug operation itself is now being done synchronously, but
>>>>>>> task
>>>>>>> transfer (cgroup_transfer_tasks()) because of lacking online CPUs is
>>>>>>> still being done asynchronously. So kernfs_break_active_protection()
>>>>>>> will still be needed for cgroup v1.
>>>>>>>
>>>>>>> Cheers,
>>>>>>> Longman
>>>>>>>
>>>>>>>
>>>>>> Thank you, Longman.
>>>>>> IIUC, The commit 2125c0034c5d ("cgroup/cpuset: Make cpuset hotplug
>>>>>> processing synchronous") deleted the
>>>>>> 'flush_work(&cpuset_hotplug_work)'
>>>>>> in the cpuset_write_resmask. And I do not see any process within the
>>>>>> cpuset_write_resmask that will grab cgroup_mutex, except for
>>>>>> 'flush_work(&cpuset_hotplug_work)'.
>>>>>>
>>>>>> Although cgroup_transfer_tasks() is asynchronous, the
>>>>>> cpuset_write_resmask will not wait any work that will grab
>>>>>> cgroup_mutex.
>>>>>> Consequently, the deadlock does not exist anymore.
>>>>>>
>>>>>> Did I miss something?
>>>>> Right. The flush_work() call is still needed for a different work
>>>>> function. cpuset_write_resmask() will not need to grab
>>>>> cgroup_mutex, but
>>>>> the asynchronously executed cgroup_transfer_tasks() will. I will
>>>>> work on
>>>>> a patch to fix that issue.
>>>>>
>>>>> Cheers,
>>>>> Longman
>>>> If flush_work() is added back, this warning still exists. Do you have a
>>>> idea to fix this warning?
>>> I was wrong. The flush_work() call isn't needed in this case and we
>>> shouldn't need to break kernfs protection. However, your patch
>>> description isn't quite right.
>>>
>>>> After the commit 2125c0034c5d ("cgroup/cpuset: Make cpuset hotplug
>>>> processing synchronous"), the cpuset_write_resmask no longer needs to
>>>> wait the hotplug to finish, which means that cpuset_write_resmask won't
>>>> grab the cgroup_mutex. So the deadlock doesn't exist anymore.
>>> cpuset_write_resmask() never needs to grab the cgroup_mutex. The act of
>>> calling flush_work() can create a multiple processes circular locking
>>> dependency that involve cgroup_mutex which can cause a deadlock. After
>>> making cpuset hotplug synchronous, concurrent hotplug and cpuset
>>> operations are no longer possible. However, concurrent task transfer out
>>> of a previously empty CPU cpuset and adding CPU back to that cpuset is
>>> possible. This will result in what the comment said "keep removing tasks
>>> added
>>> after execution capability is restored". That should be rare though and
>>> we should probably add a check in cgroup_transfer_tasks() to detect such
>>> a case and break out of it.
>>>
>>> Cheers,
>>> Longman
>> Hi, Longman, sorry the confused message. Do you mean this patch is
>> acceptable if I update the message?
> Sorry for the late reply. Yes, the patch is acceptable, but the patch
> description isn't quite right. Please sent out a v2.

Thank you, I will update.

Best regards,
Ridong

>>
>> I don't think we need to add a check in the cgroup_transfer_tasks
>> function. Because no process(except for writing cpuset.cpus, which has
>> been reoved) will need 'kn->active' to involve cgroup_transfer_tasks now.
> 
> I agree that we don't need to add a check in cgroup_transfer_tasks().
> 
> Cheers,
> Longman
> 


