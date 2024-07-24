Return-Path: <cgroups+bounces-3879-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDAF93B01C
	for <lists+cgroups@lfdr.de>; Wed, 24 Jul 2024 13:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB0ED282FE5
	for <lists+cgroups@lfdr.de>; Wed, 24 Jul 2024 11:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47032156967;
	Wed, 24 Jul 2024 11:09:36 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail115-24.sinamail.sina.com.cn (mail115-24.sinamail.sina.com.cn [218.30.115.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011A62595
	for <cgroups@vger.kernel.org>; Wed, 24 Jul 2024 11:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721819376; cv=none; b=fGkGsUQDmBdah+SVzS/PDQHraNDiJrPXjE4urAXUWosQ6mUa4/IwHAdGlYEmLRxnr3RaGDHx1MMKR+5a2q9RGD4rJEWHhPzWUomP4TBpJz8HX4OWY9vBQW6g7nBTVlOiAguVG0t3GqIJwH8qVvq3WVrwhab5RczkPgFOQ3gqVDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721819376; c=relaxed/simple;
	bh=oCBu+tALEqoFMR5TeQaavc+3AeBXIoz+D/GHlEzjLAA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ApjlqzKmPYcCC5CCKcF2IYEnlAxtjJpuYthXN48WjU01kS5BfQDD5upsvakjR1NN/+v5QvDjBQV4LVi7og/De0cH5IUD4+sZiBlscW+UOhmq0tedF+USmUJclelq4VG+A29LA4jiLzi8ouh3Jz/3RUsqwBA8iU/oQ6xeom+rhvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.65.159])
	by sina.com (10.185.250.22) with ESMTP
	id 66A0E0B90000162A; Wed, 24 Jul 2024 19:08:44 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3186927602718
X-SMAIL-UIID: 236FD2331CA04DD1A0CDFFA64C3113AA-20240724-190844-1
From: Hillf Danton <hdanton@sina.com>
To: Chen Ridong <chenridong@huawei.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
	tj@kernel.org,
	bpf@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -v2] cgroup: fix deadlock caused by cgroup_mutex and cpu_hotplug_lock
Date: Wed, 24 Jul 2024 19:08:34 +0800
Message-Id: <20240724110834.2010-1-hdanton@sina.com>
In-Reply-To: <20240719025232.2143638-1-chenridong@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 19 Jul 2024 02:52:32 +0000 Chen Ridong <chenridong@huawei.com>
> We found a hung_task problem as shown below:
> 
> INFO: task kworker/0:0:8 blocked for more than 327 seconds.
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:kworker/0:0     state:D stack:13920 pid:8     ppid:2       flags:0x00004000
> Workqueue: events cgroup_bpf_release
> Call Trace:
>  <TASK>
>  __schedule+0x5a2/0x2050
>  ? find_held_lock+0x33/0x100
>  ? wq_worker_sleeping+0x9e/0xe0
>  schedule+0x9f/0x180
>  schedule_preempt_disabled+0x25/0x50
>  __mutex_lock+0x512/0x740
>  ? cgroup_bpf_release+0x1e/0x4d0
>  ? cgroup_bpf_release+0xcf/0x4d0
>  ? process_scheduled_works+0x161/0x8a0
>  ? cgroup_bpf_release+0x1e/0x4d0
>  ? mutex_lock_nested+0x2b/0x40
>  ? __pfx_delay_tsc+0x10/0x10
>  mutex_lock_nested+0x2b/0x40
>  cgroup_bpf_release+0xcf/0x4d0
>  ? process_scheduled_works+0x161/0x8a0
>  ? trace_event_raw_event_workqueue_execute_start+0x64/0xd0
>  ? process_scheduled_works+0x161/0x8a0
>  process_scheduled_works+0x23a/0x8a0
>  worker_thread+0x231/0x5b0
>  ? __pfx_worker_thread+0x10/0x10
>  kthread+0x14d/0x1c0
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork+0x59/0x70
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork_asm+0x1b/0x30
>  </TASK>
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
>    number of cgroup_bpf_release works into system_wq. The max_active
>    of system_wq is WQ_DFL_ACTIVE(256). When cgroup_bpf_release can not
>    get cgroup_metux, it may cram system_wq, and it will block work
>    enqueued later.
> 2. Setting watchdog_thresh will hold cpu_hotplug_lock.read and put
>    smp_call_on_cpu work into system_wq. However it may be blocked by
>    step 1.
> 3. Cpu offline requires cpu_hotplug_lock.write, which is blocked by step 2.
> 4. When a cpuset is deleted, cgroup release work is placed on
>    cgroup_destroy_wq, it will hold cgroup_metux and acquire
>    cpu_hotplug_lock.read. Acquiring cpu_hotplug_lock.read is blocked by
>    cpu_hotplug_lock.write as mentioned by step 3. Finally, it forms a
>    loop and leads to a deadlock.
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
	worker_thread()
	manage_workers()
	maybe_create_worker()
	create_worker() // has nothing to do with WQ_DFL_ACTIVE
	process_scheduled_works()

Given idle worker created independent of WQ_DFL_ACTIVE before handling
work item, no deadlock could rise in your scenario above.

