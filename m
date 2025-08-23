Return-Path: <cgroups+bounces-9343-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 284D6B325C4
	for <lists+cgroups@lfdr.de>; Sat, 23 Aug 2025 02:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B0F65A7E42
	for <lists+cgroups@lfdr.de>; Sat, 23 Aug 2025 00:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761031BC2A;
	Sat, 23 Aug 2025 00:23:45 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F3B393DDC;
	Sat, 23 Aug 2025 00:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755908625; cv=none; b=shAVirzJm5rV3JNmNv/aPSyWoQcvMf8hev6gIWdtFM+T8bjfllIWldDGv8U9jRCkSgjj6YYT1eBCSIkKU8h8SDmT13L/nJLBIkXwYfOignjSOgD12FjC4XgKx5FRWaEBnALkHHNjHfX6YJ6aQ0m91+Pu+SfEJXc16BJt8j50exU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755908625; c=relaxed/simple;
	bh=84dGkgR+bo2AbRNubUUia47JmMAYmHIIoylmE2TkvDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KrpyWYLw+Ahn0Qx9Aa7i2yG6q9xcezf+dYAlsS+36tvYBpwhrlqLKeHJG90xZjFfXJv0vmQ1D0UAW1ln8q+RUVwJtnOdnyXhbKavH78UJfTYjTWSsXODBjmT/Y/aOA4sk7q0AgIeH2pY/tmoRhVN6unM9ZYxNBLiGXM9AK3Ztf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c7yTM1PdrzKHLxZ;
	Sat, 23 Aug 2025 08:23:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id B10CE1A0359;
	Sat, 23 Aug 2025 08:23:34 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP3 (Coremail) with SMTP id _Ch0CgBHwNoGCqloNYgUEg--.7432S2;
	Sat, 23 Aug 2025 08:23:34 +0800 (CST)
Message-ID: <1cf4c031-fb21-4986-9356-92f69697d491@huaweicloud.com>
Date: Sat, 23 Aug 2025 08:23:34 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] kernfs: Fix UAF in polling when open file is
 released
To: Tejun Heo <tj@kernel.org>
Cc: gregkh@linuxfoundation.org, hannes@cmpxchg.org, mkoutny@suse.com,
 peterz@infradead.org, zhouchengming@bytedance.com,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, lujialin4@huawei.com,
 chenridong@huawei.com, libaokun1@huawei.com
References: <20250822070715.1565236-1-chenridong@huaweicloud.com>
 <20250822070715.1565236-2-chenridong@huaweicloud.com>
 <aKitBb4VNmeaObi8@slm.duckdns.org>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <aKitBb4VNmeaObi8@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgBHwNoGCqloNYgUEg--.7432S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr48tFy3CFy8tFW3tF1DZFb_yoW5WFWDpa
	98CF15K3ykXryUAw4IqF1093W8tayxJFWxtFn7Kr9ava43Kryvy3WI9r15XFykArsxJr47
	t3ZIk34jyw45AaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUOB
	MKDUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/8/23 1:46, Tejun Heo wrote:
> On Fri, Aug 22, 2025 at 07:07:14AM +0000, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> A use-after-free (UAF) vulnerability was identified in the PSI (Pressure
>> Stall Information) monitoring mechanism:
>>
>> BUG: KASAN: slab-use-after-free in psi_trigger_poll+0x3c/0x140
>> Read of size 8 at addr ffff3de3d50bd308 by task systemd/1
>>
>> psi_trigger_poll+0x3c/0x140
>> cgroup_pressure_poll+0x70/0xa0
>> cgroup_file_poll+0x8c/0x100
>> kernfs_fop_poll+0x11c/0x1c0
>> ep_item_poll.isra.0+0x188/0x2c0
>>
>> Allocated by task 1:
>> cgroup_file_open+0x88/0x388
>> kernfs_fop_open+0x73c/0xaf0
>> do_dentry_open+0x5fc/0x1200
>> vfs_open+0xa0/0x3f0
>> do_open+0x7e8/0xd08
>> path_openat+0x2fc/0x6b0
>> do_filp_open+0x174/0x368
>>
>> Freed by task 8462:
>> cgroup_file_release+0x130/0x1f8
>> kernfs_drain_open_files+0x17c/0x440
>> kernfs_drain+0x2dc/0x360
>> kernfs_show+0x1b8/0x288
>> cgroup_file_show+0x150/0x268
>> cgroup_pressure_write+0x1dc/0x340
>> cgroup_file_write+0x274/0x548
>>
>> Reproduction Steps:
>> 1. Open test/cpu.pressure and establish epoll monitoring
>> 2. Disable monitoring: echo 0 > test/cgroup.pressure
>> 3. Re-enable monitoring: echo 1 > test/cgroup.pressure
>>
>> The race condition occurs because:
>> 1. When cgroup.pressure is disabled (echo 0 > cgroup.pressure), it:
>>    - Releases PSI triggers via cgroup_file_release()
>>    - Frees of->priv through kernfs_drain_open_files()
>> 2. While epoll still holds reference to the file and continues polling
>> 3. Re-enabling (echo 1 > cgroup.pressure) accesses freed of->priv
>>
>> epolling			disable/enable cgroup.pressure
>> fd=open(cpu.pressure)
>> while(1)
>> ...
>> epoll_wait
>> kernfs_fop_poll
>> kernfs_get_active = true	echo 0 > cgroup.pressure
>> ...				cgroup_file_show
>> 				kernfs_show
>> 				// inactive kn
>> 				kernfs_drain_open_files
>> 				cft->release(of);
>> 				kfree(ctx);
>> 				...
>> kernfs_get_active = false
>> 				echo 1 > cgroup.pressure
>> 				kernfs_show
>> 				kernfs_activate_one(kn);
>> kernfs_fop_poll
>> kernfs_get_active = true
>> cgroup_file_poll
>> psi_trigger_poll
>> // UAF
>> ...
>> end: close(fd)
>>
>> To address this issue, introduce kernfs_get_active_of() for kernfs open
>> files to obtain active references. This function will fail if the open file
>> has been released. Replace kernfs_get_active() with kernfs_get_active_of()
>> to prevent further operations on released file descriptors.
>>
>> Fixes: 34f26a15611a ("sched/psi: Per-cgroup PSI accounting disable/re-enable interface")
>> Reported-by: Zhang Zhaotian <zhangzhaotian@huawei.com>
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> 
> Acked-by: Tejun Heo <tj@kernel.org>
> 
> Thanks.
> 

Thanks

-- 
Best regards,
Ridong


