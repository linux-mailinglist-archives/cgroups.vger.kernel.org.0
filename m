Return-Path: <cgroups+bounces-5066-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C397399473C
	for <lists+cgroups@lfdr.de>; Tue,  8 Oct 2024 13:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F49FB2823D
	for <lists+cgroups@lfdr.de>; Tue,  8 Oct 2024 11:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918191DF263;
	Tue,  8 Oct 2024 11:33:35 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CA61DED43;
	Tue,  8 Oct 2024 11:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728387215; cv=none; b=hmln0J1ioyOf5xfCYVFEiGOSpLXjgeJPGVH3/DBBzyLCGeVTUsiRRnWtGIey3y5viHQhSw8E/leUOum3wT2kS0ZqY+feS4xJ0SPOHXEgRpxzH3WqYDGEG//nIyMW7i62VrpaaZiZoZNp36p4rQiuI2c7MLL0fsNeqR6aK1kq2lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728387215; c=relaxed/simple;
	bh=RqOTbdHbZuHecrT14ISFxPP5hZYegFPJXSurQtdWtHg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IwYCLNZcyZiCxFTeArYlVlspnw82Vpsv0SlxeZ/rPE0G9AiugoepDdjNOs8WqD8yIQ40jRWXmw3uihuil5LYb7JHVejDX5PahzYUuMWSScY6bckf+HpA+g/cyr8D1+oCi0g+mGqcddJp5g0HViP3bLCcNSaveka0r/mIB2A4UP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XNDRC15hJz4f3kvX;
	Tue,  8 Oct 2024 19:33:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id AE0F51A08FC;
	Tue,  8 Oct 2024 19:33:28 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgAnqMRuGAVnI_ERDg--.13677S3;
	Tue, 08 Oct 2024 19:33:28 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	tj@kernel.org,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	roman.gushchin@linux.dev,
	mkoutny@suse.com
Cc: bpf@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chenridong@huawei.com
Subject: [PATCH v6 1/3] cgroup/bpf: use a dedicated workqueue for cgroup bpf destruction
Date: Tue,  8 Oct 2024 11:24:56 +0000
Message-Id: <20241008112458.49387-2-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008112458.49387-1-chenridong@huaweicloud.com>
References: <20241008112458.49387-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAnqMRuGAVnI_ERDg--.13677S3
X-Coremail-Antispam: 1UD129KBjvJXoWxKr45AFy7ur47Jry8Xw1rtFb_yoW7Kr18pr
	Z8Aw15tw48Wr4q9rWUtayYqryFka1Fqr1UAr97Jw1Iyr43Xrs8ZF929ryYvF98GF9ayF13
	ZFyYvrW5Ka4jv3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxV
	W8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j7jjgU
	UUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

A hung_task problem shown below was found:

INFO: task kworker/0:0:8 blocked for more than 327 seconds.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
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

To fix the problem, place cgroup_bpf_release works on a dedicated
workqueue which can break the loop and solve the problem. System wqs are
for misc things which shouldn't create a large number of concurrent work
items. If something is going to generate >WQ_DFL_ACTIVE(256) concurrent
work items, it should use its own dedicated workqueue.

Fixes: 4bfc0bb2c60e ("bpf: decouple the lifetime of cgroup_bpf from cgroup itself")
Link: https://lore.kernel.org/cgroups/e90c32d2-2a85-4f28-9154-09c7d320cb60@huawei.com/T/#t
Tested-by: Vishal Chourasia <vishalc@linux.ibm.com>
Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/bpf/cgroup.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index e7113d700b87..025d7e2214ae 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -24,6 +24,23 @@
 DEFINE_STATIC_KEY_ARRAY_FALSE(cgroup_bpf_enabled_key, MAX_CGROUP_BPF_ATTACH_TYPE);
 EXPORT_SYMBOL(cgroup_bpf_enabled_key);
 
+/*
+ * cgroup bpf destruction makes heavy use of work items and there can be a lot
+ * of concurrent destructions.  Use a separate workqueue so that cgroup bpf
+ * destruction work items don't end up filling up max_active of system_wq
+ * which may lead to deadlock.
+ */
+static struct workqueue_struct *cgroup_bpf_destroy_wq;
+
+static int __init cgroup_bpf_wq_init(void)
+{
+	cgroup_bpf_destroy_wq = alloc_workqueue("cgroup_bpf_destroy", 0, 1);
+	if (!cgroup_bpf_destroy_wq)
+		panic("Failed to alloc workqueue for cgroup bpf destroy.\n");
+	return 0;
+}
+core_initcall(cgroup_bpf_wq_init);
+
 /* __always_inline is necessary to prevent indirect call through run_prog
  * function pointer.
  */
@@ -334,7 +351,7 @@ static void cgroup_bpf_release_fn(struct percpu_ref *ref)
 	struct cgroup *cgrp = container_of(ref, struct cgroup, bpf.refcnt);
 
 	INIT_WORK(&cgrp->bpf.release_work, cgroup_bpf_release);
-	queue_work(system_wq, &cgrp->bpf.release_work);
+	queue_work(cgroup_bpf_destroy_wq, &cgrp->bpf.release_work);
 }
 
 /* Get underlying bpf_prog of bpf_prog_list entry, regardless if it's through
-- 
2.34.1


