Return-Path: <cgroups+bounces-6076-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7BBA06A4A
	for <lists+cgroups@lfdr.de>; Thu,  9 Jan 2025 02:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D0533A4C2E
	for <lists+cgroups@lfdr.de>; Thu,  9 Jan 2025 01:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4BD3B192;
	Thu,  9 Jan 2025 01:30:13 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EE6FC0B;
	Thu,  9 Jan 2025 01:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736386213; cv=none; b=hwG87Z4NWD2xiclqZBwe23Npoxee5kfQAX3eSm1RS2BUBBw+C/EAi5Dda8s+jglD6/xf6qMh6GlK6uw/Lj8pTsXnfoFLuyjJ5mXBlrxFDynkBfYh8Ve+S9kdwOk2turNVdPERAz1DhEeo1+vmQTAFOupTBJqcJGee3IPhl2yyhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736386213; c=relaxed/simple;
	bh=6dD3fiyYsZR/I/0hGbyHgNmxqsEMvTd37g7oceypAGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ffzvZT1jYXKjgjlj+LClx+ic/BVGxQmIdekelRFsqb9XKT1f5V7nuZZ2BdxgKOVoeHMIXB/AAYf6iMQzFMk/PdupWoDuaLsLykNz8Gu6vexDRSLOFE9bWQpOV2sOALpGLNya6ur4a12jv1seuH/6cBP7uz7uCuhwzsNxTA2fg3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YT6dw5WsGz4f3kFM;
	Thu,  9 Jan 2025 09:29:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id EFB791A1402;
	Thu,  9 Jan 2025 09:30:00 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP3 (Coremail) with SMTP id _Ch0CgDXKcSXJn9nwJ22AQ--.1400S2;
	Thu, 09 Jan 2025 09:30:00 +0800 (CST)
Message-ID: <9250b4e8-8ef8-4a85-af24-14a34cc72e3b@huaweicloud.com>
Date: Thu, 9 Jan 2025 09:29:59 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cgroup/cpuset: remove kernfs active break
To: Tejun Heo <tj@kernel.org>, Waiman Long <longman@redhat.com>
Cc: longman@redhat.com, hannes@cmpxchg.org, mkoutny@suse.com,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250106081904.721655-1-chenridong@huaweicloud.com>
 <Z37Qxd79eLqzYpZU@slm.duckdns.org>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <Z37Qxd79eLqzYpZU@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgDXKcSXJn9nwJ22AQ--.1400S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr45KF4xKry5tF4xGF45ZFb_yoWrWryfpF
	45CF1jkr48Ar1UCw4DJF18Zr18twsrAFWUJr1xWr10va4Uuw1vyryxWr45WrWDJr43Z3y2
	y3ZFqw10qw1UCw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7IJmUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/1/9 3:23, Tejun Heo wrote:
> On Mon, Jan 06, 2025 at 08:19:04AM +0000, Chen Ridong wrote:
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
>> FS:  00007f84cd0be740(0000) GS:ffff8887ddc00000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 0000555f9fbe00c8 CR3: 0000000153eec001 CR4: 0000000000370ee0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> Call Trace:
>>  kernfs_drain+0x15e/0x2f0
>>  __kernfs_remove+0x165/0x300
>>  kernfs_remove_by_name_ns+0x7b/0xc0
>>  cgroup_rm_file+0x154/0x1c0
>>  cgroup_addrm_files+0x1c2/0x1f0
>>  css_clear_dir+0x77/0x110
>>  kill_css+0x4c/0x1b0
>>  cgroup_destroy_locked+0x194/0x380
>>  cgroup_rmdir+0x2a/0x140
>>
>> It can be explained by:
>> rmdir 				echo 1 > cpuset.cpus
>> 				kernfs_fop_write_iter // active=0
>> cgroup_rm_file
>> kernfs_remove_by_name_ns	kernfs_get_active // active=1
>> __kernfs_remove					  // active=0x80000002
>> kernfs_drain			cpuset_write_resmask
>> wait_event
>> //waiting (active == 0x80000001)
>> 				kernfs_break_active_protection
>> 				// active = 0x80000001
>> // continue
>> 				kernfs_unbreak_active_protection
>> 				// active = 0x80000002
>> ...
>> kernfs_should_drain_open_files
>> // warning occurs
>> 				kernfs_put_active
>>
>> This warning is caused by 'kernfs_break_active_protection' when it is
>> writing to cpuset.cpus, and the cgroup is removed concurrently.
>>
>> The commit 3a5a6d0c2b03 ("cpuset: don't nest cgroup_mutex inside
>> get_online_cpus()") made cpuset_hotplug_workfn asynchronous, This change
>> involves calling flush_work(), which can create a multiple processes
>> circular locking dependency that involve cgroup_mutex, potentially leading
>> to a deadlock. To avoid deadlock. the commit 76bb5ab8f6e3 ("cpuset: break
>> kernfs active protection in cpuset_write_resmask()") added
>> 'kernfs_break_active_protection' in the cpuset_write_resmask. This could
>> lead to this warning.
>>
>> After the commit 2125c0034c5d ("cgroup/cpuset: Make cpuset hotplug
>> processing synchronous"), the cpuset_write_resmask no longer needs to
>> wait the hotplug to finish, which means that concurrent hotplug and cpuset
>> operations are no longer possible. Therefore, the deadlock doesn't exist
>> anymore and it does not have to 'break active protection' now. To fix this
>> warning, just remove kernfs_break_active_protection operation in the
>> 'cpuset_write_resmask'.
>>
>> Fixes: 76bb5ab8f6e3 ("cpuset: break kernfs active protection in cpuset_write_resmask()")
>> Reported-by: Ji Fa <jifa@huawei.com>
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> 
> Applied to cgroup/for-6.13-fixes.
> 
> Thanks.
> 

Hi, Tj and Longman, I am sorry, the fix tag is not exactly right. I just
failed to reproduce this issue at the version 5.10, and I found this
warning was added with the commit bdb2fd7fc56e ("kernfs: Skip
kernfs_drain_open_files() more aggressively"), which is at version 6.1.
I believe it should both fix  bdb2fd7fc56e ("kernfs: Skip
kernfs_drain_open_files() more aggressively") and 76bb5ab8f6e3 ("cpuset:
break kernfs active protection in cpuset_write_resmask()"). Should I
resend a new patch?

Best regards,
Ridong



