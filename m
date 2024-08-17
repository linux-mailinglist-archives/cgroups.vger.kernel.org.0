Return-Path: <cgroups+bounces-4339-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA679556D5
	for <lists+cgroups@lfdr.de>; Sat, 17 Aug 2024 11:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC79EB21E67
	for <lists+cgroups@lfdr.de>; Sat, 17 Aug 2024 09:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13F01494BF;
	Sat, 17 Aug 2024 09:41:14 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB6D14600F;
	Sat, 17 Aug 2024 09:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723887674; cv=none; b=tkGWm+L1h8thLl5+Y/zks4BCThr2WpQMaDvGjpECn35UIn4r7OJzH2cjsgJ8brqf5oWD9KhLgZb9a/0CA7RWTZZ2FW8hBYi1LuHdJAvPIBHeiVxs4mY5820c1AlkEIrIK2fz77xWTNVMUCebRh3sxDJVpAYpCpgv/njsqlDEz5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723887674; c=relaxed/simple;
	bh=e/6eO58p0hU4BqE/P+CYc0FUTo4UyWBoKSiNKG6ov9k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OnKlicAsUHYTZ+AoBXFFtieV2iLXHHAO5Kr/1ZFkQKTRH3N6+JABEzN82IfxUqE2LEQYLBr9jwXoH9eYqMfdUz2Rv9wq7Jq2XrpyDFezj/wKn+OFhifbZyeZSNto0yi4D0MJHqU7frW5cLZlzowMK85QTmZpjg97ecpg83Ztbc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WmDJG34lqz2Cmhg;
	Sat, 17 Aug 2024 17:36:14 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 393A81401E9;
	Sat, 17 Aug 2024 17:41:10 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Sat, 17 Aug
 2024 17:41:09 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <martin.lau@linux.dev>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <eddyz87@gmail.com>, <song@kernel.org>,
	<yonghong.song@linux.dev>, <john.fastabend@gmail.com>, <kpsingh@kernel.org>,
	<sdf@google.com>, <haoluo@google.com>, <jolsa@kernel.org>, <tj@kernel.org>,
	<lizefan.x@bytedance.com>, <hannes@cmpxchg.org>, <roman.gushchin@linux.dev>
CC: <bpf@vger.kernel.org>, <cgroups@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/1] cgroup: fix deadlock caused by cgroup_mutex and cpu_hotplug_lock
Date: Sat, 17 Aug 2024 09:33:34 +0000
Message-ID: <20240817093334.6062-2-chenridong@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240817093334.6062-1-chenridong@huawei.com>
References: <20240817093334.6062-1-chenridong@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd100013.china.huawei.com (7.221.188.163)

We found a hung_task problem as shown below:

INFO: task kworker/0:0:8 blocked for more than 327 seconds.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:0     state:D stack:13920 pid:8     ppid:2       flags:0x00004000
Workqueue: events cgroup_bpf_release
Call Trace:
 <TASK>
 __schedule+0x5a2/0x2050
 ? find_held_lock+0x33/0x100
 ? wq_worker_sleeping+0x9e/0xe0
 schedule+0x9f/0x180
 schedule_preempt_disabled+0x25/0x50
 __mutex_lock+0x512/0x740
 ? cgroup_bpf_release+0x1e/0x4d0
 ? cgroup_bpf_release+0xcf/0x4d0
 ? process_scheduled_works+0x161/0x8a0
 ? cgroup_bpf_release+0x1e/0x4d0
 ? mutex_lock_nested+0x2b/0x40
 ? __pfx_delay_tsc+0x10/0x10
 mutex_lock_nested+0x2b/0x40
 cgroup_bpf_release+0xcf/0x4d0
 ? process_scheduled_works+0x161/0x8a0
 ? trace_event_raw_event_workqueue_execute_start+0x64/0xd0
 ? process_scheduled_works+0x161/0x8a0
 process_scheduled_works+0x23a/0x8a0
 worker_thread+0x231/0x5b0
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x14d/0x1c0
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x59/0x70
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1b/0x30
 </TASK>

This issue can be reproduced by the following pressuse test:
1. A large number of cpuset cgroups are deleted.
2. Set cpu on and off repeatly.
3. Set watchdog_thresh repeatly.
The scripts can be obtained at LINK mentioned above the signature.

The reason for this issue is cgroup_mutex and cpu_hotplug_lock are
acquired in different tasks, which may lead to deadlock.
It can lead to a deadlock through the following steps:
1. A large number of cpusets are deleted asynchronously, which puts a
   large number of cgroup_bpf_release works into system_wq. The max_active
   of system_wq is WQ_DFL_ACTIVE(256). Consequently, all active works are
   cgroup_bpf_release works, and many cgroup_bpf_release works will be put
   into inactive queue. As illustrated in the diagram, there are 256 (in
   the acvtive queue) + n (in the inactive queue) works.
2. Setting watchdog_thresh will hold cpu_hotplug_lock.read and put
   smp_call_on_cpu work into system_wq. However step 1 has already filled
   system_wq, 'sscs.work' is put into inactive queue. 'sscs.work' has
   to wait until the works that were put into the inacvtive queue earlier
   have executed (n cgroup_bpf_release), so it will be blocked for a while.
3. Cpu offline requires cpu_hotplug_lock.write, which is blocked by step 2.
4. Cpusets that were deleted at step 1 put cgroup_release works into
   cgroup_destroy_wq. They are competing to get cgroup_mutex all the time.
   When cgroup_metux is acqured by work at css_killed_work_fn, it will
   call cpuset_css_offline, which needs to acqure cpu_hotplug_lock.read.
   However, cpuset_css_offline will be blocked for step 3.
5. At this moment, there are 256 works in active queue that are
   cgroup_bpf_release, they are attempting to acquire cgroup_mutex, and as
   a result, all of them are blocked. Consequently, sscs.work can not be
   executed. Ultimately, this situation leads to four processes being
   blocked, forming a deadlock.

system_wq(step1)		WatchDog(step2)			cpu offline(step3)	cgroup_destroy_wq(step4)
...
2000+ cgroups deleted asyn
256 actives + n inactives
				__lockup_detector_reconfigure
				P(cpu_hotplug_lock.read)
				put sscs.work into system_wq
256 + n + 1(sscs.work)
sscs.work wait to be executed
				warting sscs.work finish
								percpu_down_write
								P(cpu_hotplug_lock.write)
								...blocking...
											css_killed_work_fn
											P(cgroup_mutex)
											cpuset_css_offline
											P(cpu_hotplug_lock.read)
											...blocking...
256 cgroup_bpf_release
mutex_lock(&cgroup_mutex);
..blocking...

To fix the problem, place cgroup_bpf_release works on cgroup_destroy_wq,
which can break the loop and solve the problem. System wqs are for misc
things which shouldn't create a large number of concurrent work items.
If something is going to generate >WQ_DFL_ACTIVE(256) concurrent work
items, it should use its own dedicated workqueue.

Fixes: 4bfc0bb2c60e ("bpf: decouple the lifetime of cgroup_bpf from cgroup itself")
Link: https://lore.kernel.org/cgroups/e90c32d2-2a85-4f28-9154-09c7d320cb60@huawei.com/T/#t
Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/bpf/cgroup.c             | 2 +-
 kernel/cgroup/cgroup-internal.h | 1 +
 kernel/cgroup/cgroup.c          | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 8ba73042a239..a611a1274788 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -334,7 +334,7 @@ static void cgroup_bpf_release_fn(struct percpu_ref *ref)
 	struct cgroup *cgrp = container_of(ref, struct cgroup, bpf.refcnt);
 
 	INIT_WORK(&cgrp->bpf.release_work, cgroup_bpf_release);
-	queue_work(system_wq, &cgrp->bpf.release_work);
+	queue_work(cgroup_destroy_wq, &cgrp->bpf.release_work);
 }
 
 /* Get underlying bpf_prog of bpf_prog_list entry, regardless if it's through
diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index c964dd7ff967..17ac19bc8106 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -13,6 +13,7 @@
 extern spinlock_t trace_cgroup_path_lock;
 extern char trace_cgroup_path[TRACE_CGROUP_PATH_LEN];
 extern void __init enable_debug_cgroup(void);
+extern struct workqueue_struct *cgroup_destroy_wq;
 
 /*
  * cgroup_path() takes a spin lock. It is good practice not to take
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 75058fbf4450..77fa9ed69c86 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -124,7 +124,7 @@ DEFINE_PERCPU_RWSEM(cgroup_threadgroup_rwsem);
  * destruction work items don't end up filling up max_active of system_wq
  * which may lead to deadlock.
  */
-static struct workqueue_struct *cgroup_destroy_wq;
+struct workqueue_struct *cgroup_destroy_wq;
 
 /* generate an array of cgroup subsystem pointers */
 #define SUBSYS(_x) [_x ## _cgrp_id] = &_x ## _cgrp_subsys,
-- 
2.34.1


