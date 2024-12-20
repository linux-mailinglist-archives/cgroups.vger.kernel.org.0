Return-Path: <cgroups+bounces-5974-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A209F8ADA
	for <lists+cgroups@lfdr.de>; Fri, 20 Dec 2024 05:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36A8D7A2381
	for <lists+cgroups@lfdr.de>; Fri, 20 Dec 2024 04:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147276A33B;
	Fri, 20 Dec 2024 04:07:52 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9583214;
	Fri, 20 Dec 2024 04:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734667671; cv=none; b=CS5JkSa5r9eBWT0x9ROQl7h9+ZCE6IEzECMkkqPaoklksTF0WqCwlBDbCDNooZ7LEnUpMcN3jx1ght4fx3czhpQNmU8KFOnr3bkkM3tadOoVEV+HJ4Dkt4ZYHLRJhau3NnPwJdJD9dFEz29ZqMeimfeKkuWQOycSKuxfeTZ2BMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734667671; c=relaxed/simple;
	bh=zSISzR/qx/NgWraMuwe30F3SNrhRM9ntxto7RmkcBZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pFXWL2yIBiZRbUsAD8QQfFpLmT5lLlfI9qJGio/kCOkaRWTFjo6EKYEbZ3Ece14Vgpgtq6VyBy2Wd5NudY6fze0jv0tpnleCcg0QAszsJD9QfaPxPEvMtc6hVgggIpmG4rQfUmx2vMH4P0bdfiulU9TfUEVYBg7h/STK4qfycho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4YDv2b3xx2zhZWm;
	Fri, 20 Dec 2024 12:05:11 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 91FA7140154;
	Fri, 20 Dec 2024 12:07:45 +0800 (CST)
Received: from [10.67.109.79] (10.67.109.79) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Fri, 20 Dec
 2024 12:07:44 +0800
Message-ID: <cafb38a5-0832-4af4-a3b2-cca32ce63d10@huawei.com>
Date: Fri, 20 Dec 2024 12:07:44 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cgroup/cpuset: remove kernfs active break
To: Waiman Long <llong@redhat.com>, Chen Ridong <chenridong@huaweicloud.com>,
	<tj@kernel.org>, <hannes@cmpxchg.org>, <mkoutny@suse.com>,
	<roman.gushchin@linux.dev>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, <wangweiyang2@huawei.com>
References: <20241220013106.3603227-1-chenridong@huaweicloud.com>
 <5c48f188-0059-46a2-9ccd-aad6721d96bb@redhat.com>
Content-Language: en-US
From: chenridong <chenridong@huawei.com>
In-Reply-To: <5c48f188-0059-46a2-9ccd-aad6721d96bb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd100013.china.huawei.com (7.221.188.163)



On 2024/12/20 10:55, Waiman Long wrote:
> On 12/19/24 8:31 PM, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> A warning was found:
>>
>> WARNING: CPU: 10 PID: 3486953 at fs/kernfs/file.c:828
>> CPU: 10 PID: 3486953 Comm: rmdir Kdump: loaded Tainted: G
>> RIP: 0010:kernfs_should_drain_open_files+0x1a1/0x1b0
>> RSP: 0018:ffff8881107ef9e0 EFLAGS: 00010202
>> RAX: 0000000080000002 RBX: ffff888154738c00 RCX: dffffc0000000000
>> RDX: 0000000000000007 RSI: 0000000000000004 RDI: ffff888154738c04
>> RBP: ffff888154738c04 R08: ffffffffaf27fa15 R09: ffffed102a8e7180
>> R10: ffff888154738c07 R11: 0000000000000000 R12: ffff888154738c08
>> R13: ffff888750f8c000 R14: ffff888750f8c0e8 R15: ffff888154738ca0
>> FS:  00007f84cd0be740(0000) GS:ffff8887ddc00000(0000)
>> knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 0000555f9fbe00c8 CR3: 0000000153eec001 CR4: 0000000000370ee0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> Call Trace:
>>   kernfs_drain+0x15e/0x2f0
>>   __kernfs_remove+0x165/0x300
>>   kernfs_remove_by_name_ns+0x7b/0xc0
>>   cgroup_rm_file+0x154/0x1c0
>>   cgroup_addrm_files+0x1c2/0x1f0
>>   css_clear_dir+0x77/0x110
>>   kill_css+0x4c/0x1b0
>>   cgroup_destroy_locked+0x194/0x380
>>   cgroup_rmdir+0x2a/0x140
> Were you using cgroup v1 or v2 when this warning happened?

I was using cgroup v1.

>>
>> It can be explained by:
>> rmdir                 echo 1 > cpuset.cpus
>>                 kernfs_fop_write_iter // active=0
>> cgroup_rm_file
>> kernfs_remove_by_name_ns    kernfs_get_active // active=1
>> __kernfs_remove                      // active=0x80000002
>> kernfs_drain            cpuset_write_resmask
>> wait_event
>> //waiting (active == 0x80000001)
>>                 kernfs_break_active_protection
>>                 // active = 0x80000001
>> // continue
>>                 kernfs_unbreak_active_protection
>>                 // active = 0x80000002
>> ...
>> kernfs_should_drain_open_files
>> // warning occurs
>>                 kernfs_put_active
>>
>> This warning is caused by 'kernfs_break_active_protection' when it is
>> writing to cpuset.cpus, and the cgroup is removed concurrently.
>>
>> The commit 3a5a6d0c2b03 ("cpuset: don't nest cgroup_mutex inside
>> get_online_cpus()") made cpuset_hotplug_workfn asynchronous, which grabs
>> the cgroup_mutex. To avoid deadlock. the commit 76bb5ab8f6e3 ("cpuset:
>> break kernfs active protection in cpuset_write_resmask()") added
>> 'kernfs_break_active_protection' in the cpuset_write_resmask. This could
>> lead to this warning.
>>
>> After the commit 2125c0034c5d ("cgroup/cpuset: Make cpuset hotplug
>> processing synchronous"), the cpuset_write_resmask no longer needs to
>> wait the hotplug to finish, which means that cpuset_write_resmask won't
>> grab the cgroup_mutex. So the deadlock doesn't exist anymore. Therefore,
>> remove kernfs_break_active_protection operation in the
>> 'cpuset_write_resmask'
> 
> The hotplug operation itself is now being done synchronously, but task
> transfer (cgroup_transfer_tasks()) because of lacking online CPUs is
> still being done asynchronously. So kernfs_break_active_protection()
> will still be needed for cgroup v1.
> 
> Cheers,
> Longman
> 
> 

Thank you, Longman.
IIUC, The commit 2125c0034c5d ("cgroup/cpuset: Make cpuset hotplug
processing synchronous") deleted the 'flush_work(&cpuset_hotplug_work)'
in the cpuset_write_resmask. And I do not see any process within the
cpuset_write_resmask that will grab cgroup_mutex, except for
'flush_work(&cpuset_hotplug_work)'.

Although cgroup_transfer_tasks() is asynchronous, the
cpuset_write_resmask will not wait any work that will grab cgroup_mutex.
Consequently, the deadlock does not exist anymore.

Did I miss something?

Best regards
Ridong

