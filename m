Return-Path: <cgroups+bounces-9243-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B91B28995
	for <lists+cgroups@lfdr.de>; Sat, 16 Aug 2025 03:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F14107BC2A0
	for <lists+cgroups@lfdr.de>; Sat, 16 Aug 2025 01:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F927262F;
	Sat, 16 Aug 2025 01:27:09 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BE7211C;
	Sat, 16 Aug 2025 01:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755307628; cv=none; b=q7To6KN4iqBYBKrZEWle3pzPAJK2vH1RC5L5A8zE3SJVMBV2H09vim1Mbo5x5ilLv+3JpSpkkpcF9wVoqvcKedHlbxWwoc3As4HOb6gVNv+Z2LzN06Yicop1FUrZLeJ8UhPDgFQGQlWubZuB8nuwfU/7RxNwbqwjAZDj/hfdBD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755307628; c=relaxed/simple;
	bh=GUFUcyVxdKyGWgZMZ/8Thb7FAEThCuA7j8wmTyvfCDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tWSi4jLHuTqJ4g+wjaLoFUw9cxu0bcUyBVOWRyWLVckFI6V7zx6mA4Ndzg5sGk3+cKv/dNbWrBVmlEiWviyrJ74d6IyohWtZIevGgCFwJWvOLNfM3eM53cSsmqcgEoXegd3/eGCNMOyl9XbGraoBPRng9LfYQu6f6fsOH4XaX10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c3hCq54glzKHLy9;
	Sat, 16 Aug 2025 09:27:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 0CCC31A018D;
	Sat, 16 Aug 2025 09:27:03 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP3 (Coremail) with SMTP id _Ch0CgC3fNdk3p9ootEIDw--.39096S2;
	Sat, 16 Aug 2025 09:27:02 +0800 (CST)
Message-ID: <33990c53-5d7a-4f15-81b4-661c7bb96937@huaweicloud.com>
Date: Sat, 16 Aug 2025 09:26:59 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cgroup: cgroup: drain specific subsystems when
 mounting/destroying a root
To: Tejun Heo <tj@kernel.org>
Cc: hannes@cmpxchg.org, mkoutny@suse.com, lizefan@huawei.com,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, lujialin4@huawei.com,
 chenridong@huawei.com, hdanton@sina.com
References: <20250815070518.1255842-1-chenridong@huaweicloud.com>
 <aJ9yBuDnUu2jIgYT@slm.duckdns.org>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <aJ9yBuDnUu2jIgYT@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgC3fNdk3p9ootEIDw--.39096S2
X-Coremail-Antispam: 1UD129KBjvJXoWxurW5Ww1kAr1UGw47AF1kKrg_yoW5tF1xpF
	Z8Cw1Utw4rtr429FWvqa40qa4FqFs7Xw4UXryfG3y7ta17Wr9FqF4IyFyjvF1DCFnrC347
	ZrWFyw1rur1qyaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/8/16 1:44, Tejun Heo wrote:
> Hello, Chen.
> 
> On Fri, Aug 15, 2025 at 07:05:18AM +0000, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> A hung task can occur during [1] LTP cgroup testing when repeatedly
>> mounting/unmounting perf_event and net_prio controllers with
>> systemd.unified_cgroup_hierarchy=1. The hang manifests in
>> cgroup_lock_and_drain_offline() during root destruction.
>>
>> Related case:
>> cgroup_fj_function_perf_event cgroup_fj_function.sh perf_event
>> cgroup_fj_function_net_prio cgroup_fj_function.sh net_prio
>>
>> Call Trace:
>> 	cgroup_lock_and_drain_offline+0x14c/0x1e8
>> 	cgroup_destroy_root+0x3c/0x2c0
>> 	css_free_rwork_fn+0x248/0x338
>> 	process_one_work+0x16c/0x3b8
>> 	worker_thread+0x22c/0x3b0
>> 	kthread+0xec/0x100
>> 	ret_from_fork+0x10/0x20
>>
>> Root Cause:
>>
>> CPU0                            CPU1
>> mount perf_event                umount net_prio
>> cgroup1_get_tree                cgroup_kill_sb
>> rebind_subsystems               // root destruction enqueues
>> 				// cgroup_destroy_wq
>> // kill all perf_event css
>>                                 // one perf_event css A is dying
>>                                 // css A offline enqueues cgroup_destroy_wq
>>                                 // root destruction will be executed first
>>                                 css_free_rwork_fn
>>                                 cgroup_destroy_root
>>                                 cgroup_lock_and_drain_offline
>>                                 // some perf descendants are dying
>>                                 // cgroup_destroy_wq max_active = 1
>>                                 // waiting for css A to die
>>
>> Problem scenario:
>> 1. CPU0 mounts perf_event (rebind_subsystems)
>> 2. CPU1 unmounts net_prio (cgroup_kill_sb), queuing root destruction work
>> 3. A dying perf_event CSS gets queued for offline after root destruction
>> 4. Root destruction waits for offline completion, but offline work is
>>    blocked behind root destruction in cgroup_destroy_wq (max_active=1)
> 
> Thanks for the analysis, so this is caused by css free path waiting for css
> offline.
> 
>> Solution:
>> Introduce ss_mask for cgroup_lock_and_drain_offline() to selectively drain
>> specific subsystems rather than all subsystems.
>>
>> There are two primary scenarios requiring offline draining:
>> 1. Root Operations - Draining all subsystems in cgrp_dfl_root when mounting
>>    or destroying a cgroup root
>> 2. Draining specific cgroup when modifying cgroup.subtree_control or
>>    cgroup.threads
>>
>> For case 1 (Root Operations), it only need to drain the specific subsystem
>> being mounted/destroyed, not all subsystems. The rationale for draining
>> cgrp_dfl_root is explained in [2].
>>
>> For case 2, it's enough to drain subsystems enabled in the cgroup. Since
>> other subsystems cannot have descendants in this cgroup, adding ss_mask
>> should not have a hurt.
> 
> Hmm... this seems a bit fragile. Would splitting cgroup_destroy_wq into two
> separate workqueues - e.g. cgroup_offline_wq and cgroup_free_wq - work?
> 
> Thanks.
> 

Hi Tj,

I've tested that adding a dedicated cgroup_offline_wq workqueue for CSS offline operations, which
could resolve the current issue.

Going further, I propose we split cgroup_destroy_wq into three specialized workqueues to better
match the destruction lifecycle:
cgroup_offline_wq - Handles offline operations
cgroup_release_wq - Manages resource release
cgroup_free_wq - Performs final memory freeing

This explicit separation would clearly delineate responsibilities for each workqueue.

What are your thoughts on this approach, Tejun?

-- 
Best regards,
Ridong


