Return-Path: <cgroups+bounces-6034-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A69CA002AF
	for <lists+cgroups@lfdr.de>; Fri,  3 Jan 2025 03:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A54BD1883D09
	for <lists+cgroups@lfdr.de>; Fri,  3 Jan 2025 02:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2800A153BD7;
	Fri,  3 Jan 2025 02:22:47 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B2728E8;
	Fri,  3 Jan 2025 02:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735870967; cv=none; b=m/+VR/ISIqEf4X0c7PALHqdHAIdWN6BUH9AvtWU2o73rLKOHaM6hK5dV/t3s91a1TQL0o71f5ugvJzcC78Sc4U1XpTgIrbg5K8ealJ2ZjjWxtEniyE+UpGHrox/TODQGMpL0qYHkE/IT6J2f3ksijLQU4xlyWuHM+oQ45KP4XRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735870967; c=relaxed/simple;
	bh=Lndl1TH8Q7cKgpkINXNw96lhj+AlocwSiTQNlkteB50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e9IuhWD8yHAYSGdLJcRj28mtca+U5NnBcoXRgqtsNNgsjpUIX9VhEqX3lJgo9ywDxnFCk2DDm35J/savUwe6+GvcIuPssfoST3xh8pggL4SZDSSSFfxLy6GHQvNSYKEX/kjPCjb43ODeL3b7s8Ridd0ATQxaJCNzuq55HdTRRDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YPS5M1zcXz4f3jMy;
	Fri,  3 Jan 2025 10:22:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 455741A0EF3;
	Fri,  3 Jan 2025 10:22:35 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP1 (Coremail) with SMTP id cCh0CgCHMbPpSXdnS2P4GA--.44915S2;
	Fri, 03 Jan 2025 10:22:35 +0800 (CST)
Message-ID: <6bdac218-a18a-4cb5-b10e-c369d90b502c@huaweicloud.com>
Date: Fri, 3 Jan 2025 10:22:33 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cgroup/cpuset: remove kernfs active break
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, longman@redhat.com,
 roman.gushchin@linux.dev, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, chenridong@huawei.com,
 wangweiyang2@huawei.com
References: <20241220013106.3603227-1-chenridong@huaweicloud.com>
 <6zxqs3ms52uvgsyryubna64xy5a6zxogssomsgiyhzishwmfbd@lylwjd6cdkli>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <6zxqs3ms52uvgsyryubna64xy5a6zxogssomsgiyhzishwmfbd@lylwjd6cdkli>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCHMbPpSXdnS2P4GA--.44915S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJw45KrWDKrykXr13XrW8JFb_yoW5uF4DpF
	yvkFy3KFs7Jr1UC39rJr4xZ34Yq397JFW7Xw13GwnYvaya93Wvy34UWFs8ZrWjgrs8trWY
	vay2q390q3W5Cw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/1/3 0:02, Michal Koutný wrote:
> On Fri, Dec 20, 2024 at 01:31:06AM +0000, Chen Ridong <chenridong@huaweicloud.com> wrote:
>> RIP: 0010:kernfs_should_drain_open_files+0x1a1/0x1b0
> 
> I assume it's this
> 	WARN_ON_ONCE(atomic_read(&kn->active) != KN_DEACTIVATED_BIAS);
> 
Right.

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
> 
> Thanks for this breakdown.
> 
>> To avoid deadlock. the commit 76bb5ab8f6e3 ("cpuset:
>> break kernfs active protection in cpuset_write_resmask()") added
>> 'kernfs_break_active_protection' in the cpuset_write_resmask. This could
>> lead to this warning.
> 
> The deadlock cycle included cpuset_hotplug_work and since that was
> removed in the said commit, there shouldn't be same deadlock possible.
> 
> Ridong, have you run your patch with CONFIG_LOCKDEP to check that
> eventuality?
> 

Yes, I tested.

>> After the commit 2125c0034c5d ("cgroup/cpuset: Make cpuset hotplug
>> processing synchronous"), the cpuset_write_resmask no longer needs to
>> wait the hotplug to finish, which means that cpuset_write_resmask won't
>> grab the cgroup_mutex. So the deadlock doesn't exist anymore. Therefore,
>> remove kernfs_break_active_protection operation in the
>> 'cpuset_write_resmask'
>>
>> Fixes: 76bb5ab8f6e3 ("cpuset: break kernfs active protection in cpuset_write_resmask()")
> 
> This commit alone isn't sufficient to cause the warning you observed,
> right?

I think the commit 76bb5ab8f6e3 ("cpuset: break kernfs active protection
in cpuset_write_resmask()") is causing the warning I observed.

This warning was observed when removing a cpuset cgroup and writing to
cpuset.cpus concurrently. Unlike the cgroup_kn_lock_live functions,
which break active protection and grab the cgroup_mutex immediately to
avoid concurrent removal, writing to 'cpuset_write_resmask' cannot avoid
concurrent removal of the cgroup directory. Therefore, this could cause
the warning.

> As I read kernfs_break_active_protection() comment, I don't see cpuset
> code violating its conditions:
> a) it's broken/unbroken from withing a kernfs file operation handler,
> b) it pins the needed struct cpuset independently of kernfs_node (it's
>    ok to be removed)
> 
I am not sure if it is safe to call
kernfs_unbreak_active_protection(atomic_inc(&kn->active)); after the
'kn' has been removed. I don't know much about this. However, I have not
seen any Use-After-Free (UAF) issues so far.

I would be grateful if you could provide more information.

Best regards
Ridong

> All in all -- I think the particular break/unbreak pair is unncecessary
> nowadays and the warning implemented with hiding/showing kernfs files
> didn't take temporary breakage into account (only based on quick
> searching and vague memories).
> 
> Thanks,
> Michal


