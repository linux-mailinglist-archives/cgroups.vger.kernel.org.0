Return-Path: <cgroups+bounces-3869-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B6F93AA3D
	for <lists+cgroups@lfdr.de>; Wed, 24 Jul 2024 02:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7F5F1C22718
	for <lists+cgroups@lfdr.de>; Wed, 24 Jul 2024 00:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1DD4A35;
	Wed, 24 Jul 2024 00:53:40 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C361028FD;
	Wed, 24 Jul 2024 00:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721782420; cv=none; b=ttIDHpTusrIjA2Rf2kIkG//68YiipPLrvm/kNni3w1L7BpNZ22Wo0DFouuSVyuUmM68Zb0+EE/AFTtxMAfbB+2lbOwFLIDwm5LkMGEoCIZeugv4U40OmmKrtOBHKatoCoqHdXTXiwUFAn0Akr3XhOZOFD0O04L28rOVKiGJ1Ne8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721782420; c=relaxed/simple;
	bh=H7Z9Sy5C9QluRaOVOhSXM/dPEdUmz4QH30oBCXALxgk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=qpxHcFKEcE5fIL7DF4XYqKyefTAgwS6CoYjsvrnV/HaMC62p+kLSJaTcQj6XvAnkeopaq7q2P4zcs2VV5cgn+FKntMh4tQHsF7GTxcULHzZLou3kah578zMuuoDIxVhKpOKOZFuHVxEGzaZDX/GzFMvyL3L+Dfb40uAzMKqtktA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WTFlQ5YmLzQmPP;
	Wed, 24 Jul 2024 08:49:22 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 8312F140485;
	Wed, 24 Jul 2024 08:53:33 +0800 (CST)
Received: from [10.67.109.79] (10.67.109.79) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Wed, 24 Jul
 2024 08:53:32 +0800
Message-ID: <a0d22f13-ac54-49b7-b22a-b319cb542cae@huawei.com>
Date: Wed, 24 Jul 2024 08:53:31 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -v2] cgroup: fix deadlock caused by cgroup_mutex and
 cpu_hotplug_lock
From: chenridong <chenridong@huawei.com>
To: <martin.lau@linux.dev>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <eddyz87@gmail.com>, <song@kernel.org>,
	<yonghong.song@linux.dev>, <john.fastabend@gmail.com>, <kpsingh@kernel.org>,
	<sdf@google.com>, <haoluo@google.com>, <jolsa@kernel.org>, <tj@kernel.org>,
	<lizefan.x@bytedance.com>, <hannes@cmpxchg.org>, <roman.gushchin@linux.dev>
CC: <bpf@vger.kernel.org>, <cgroups@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240719025232.2143638-1-chenridong@huawei.com>
Content-Language: en-US
In-Reply-To: <20240719025232.2143638-1-chenridong@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd100013.china.huawei.com (7.221.188.163)



On 2024/7/19 10:52, Chen Ridong wrote:
> We found a hung_task problem as shown below:
> 
> INFO: task kworker/0:0:8 blocked for more than 327 seconds.
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:kworker/0:0     state:D stack:13920 pid:8     ppid:2       flags:0x00004000
> Workqueue: events cgroup_bpf_release
> Call Trace:
>   <TASK>
>   __schedule+0x5a2/0x2050
>   ? find_held_lock+0x33/0x100
>   ? wq_worker_sleeping+0x9e/0xe0
>   schedule+0x9f/0x180
>   schedule_preempt_disabled+0x25/0x50
>   __mutex_lock+0x512/0x740
>   ? cgroup_bpf_release+0x1e/0x4d0
>   ? cgroup_bpf_release+0xcf/0x4d0
>   ? process_scheduled_works+0x161/0x8a0
>   ? cgroup_bpf_release+0x1e/0x4d0
>   ? mutex_lock_nested+0x2b/0x40
>   ? __pfx_delay_tsc+0x10/0x10
>   mutex_lock_nested+0x2b/0x40
>   cgroup_bpf_release+0xcf/0x4d0
>   ? process_scheduled_works+0x161/0x8a0
>   ? trace_event_raw_event_workqueue_execute_start+0x64/0xd0
>   ? process_scheduled_works+0x161/0x8a0
>   process_scheduled_works+0x23a/0x8a0
>   worker_thread+0x231/0x5b0
>   ? __pfx_worker_thread+0x10/0x10
>   kthread+0x14d/0x1c0
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork+0x59/0x70
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork_asm+0x1b/0x30
>   </TASK>
> 
> This issue can be reproduced by the following methods:
> 1. A large number of cpuset cgroups are deleted.
> 2. Set cpu on and off repeatly.
> 3. Set watchdog_thresh repeatly.
> 
> The reason for this issue is cgroup_mutex and cpu_hotplug_lock are
> acquired in different tasks, which may lead to deadlock.
> It can lead to a deadlock through the following steps:
> 1. A large number of cgroups are deleted, which will put a large
>     number of cgroup_bpf_release works into system_wq. The max_active
>     of system_wq is WQ_DFL_ACTIVE(256). When cgroup_bpf_release can not
>     get cgroup_metux, it may cram system_wq, and it will block work
>     enqueued later.
> 2. Setting watchdog_thresh will hold cpu_hotplug_lock.read and put
>     smp_call_on_cpu work into system_wq. However it may be blocked by
>     step 1.
> 3. Cpu offline requires cpu_hotplug_lock.write, which is blocked by step 2.
> 4. When a cpuset is deleted, cgroup release work is placed on
>     cgroup_destroy_wq, it will hold cgroup_metux and acquire
>     cpu_hotplug_lock.read. Acquiring cpu_hotplug_lock.read is blocked by
>     cpu_hotplug_lock.write as mentioned by step 3. Finally, it forms a
>     loop and leads to a deadlock.
> 
> cgroup_destroy_wq(step4)	cpu offline(step3)		WatchDog(step2)			system_wq(step1)
> 												......
> 								__lockup_detector_reconfigure:
> 								P(cpu_hotplug_lock.read)
> 								...
> 				...
> 				percpu_down_write:
> 				P(cpu_hotplug_lock.write)
> 												...256+ works
> 												cgroup_bpf_release:
> 												P(cgroup_mutex)
> 								smp_call_on_cpu:
> 								Wait system_wq
> ...
> css_killed_work_fn:
> P(cgroup_mutex)
> ...
> cpuset_css_offline:
> P(cpu_hotplug_lock.read)
> 
> To fix the problem, place cgroup_bpf_release works on cgroup_destroy_wq,
> which can break the loop and solve the problem. System wqs are for misc
> things which shouldn't create a large number of concurrent work items.
> If something is going to generate >WQ_DFL_ACTIVE(256) concurrent work
> items, it should use its own dedicated workqueue.
> 
> Fixes: 4bfc0bb2c60e ("bpf: decouple the lifetime of cgroup_bpf from cgroup itself")
> Link: https://lore.kernel.org/cgroups/e90c32d2-2a85-4f28-9154-09c7d320cb60@huawei.com/T/#t
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/bpf/cgroup.c             | 2 +-
>   kernel/cgroup/cgroup-internal.h | 1 +
>   kernel/cgroup/cgroup.c          | 2 +-
>   3 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 8ba73042a239..a611a1274788 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -334,7 +334,7 @@ static void cgroup_bpf_release_fn(struct percpu_ref *ref)
>   	struct cgroup *cgrp = container_of(ref, struct cgroup, bpf.refcnt);
>   
>   	INIT_WORK(&cgrp->bpf.release_work, cgroup_bpf_release);
> -	queue_work(system_wq, &cgrp->bpf.release_work);
> +	queue_work(cgroup_destroy_wq, &cgrp->bpf.release_work);
>   }
>   
>   /* Get underlying bpf_prog of bpf_prog_list entry, regardless if it's through
> diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
> index 520b90dd97ec..9e57f3e9316e 100644
> --- a/kernel/cgroup/cgroup-internal.h
> +++ b/kernel/cgroup/cgroup-internal.h
> @@ -13,6 +13,7 @@
>   extern spinlock_t trace_cgroup_path_lock;
>   extern char trace_cgroup_path[TRACE_CGROUP_PATH_LEN];
>   extern void __init enable_debug_cgroup(void);
> +extern struct workqueue_struct *cgroup_destroy_wq;
>   
>   /*
>    * cgroup_path() takes a spin lock. It is good practice not to take
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index e32b6972c478..3317e03fe2fb 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -124,7 +124,7 @@ DEFINE_PERCPU_RWSEM(cgroup_threadgroup_rwsem);
>    * destruction work items don't end up filling up max_active of system_wq
>    * which may lead to deadlock.
>    */
> -static struct workqueue_struct *cgroup_destroy_wq;
> +struct workqueue_struct *cgroup_destroy_wq;
>   
>   /* generate an array of cgroup subsystem pointers */
>   #define SUBSYS(_x) [_x ## _cgrp_id] = &_x ## _cgrp_subsys,

Friendly ping.

