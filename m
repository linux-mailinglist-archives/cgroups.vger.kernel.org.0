Return-Path: <cgroups+bounces-8718-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76397B034FC
	for <lists+cgroups@lfdr.de>; Mon, 14 Jul 2025 05:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BC0317441A
	for <lists+cgroups@lfdr.de>; Mon, 14 Jul 2025 03:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B1E1E1C3F;
	Mon, 14 Jul 2025 03:37:09 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682E9CA6B;
	Mon, 14 Jul 2025 03:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752464229; cv=none; b=NnAVzQ9zz1LqhSZqtueone0gY12biXX5kSXnVdG2Dn22bN3RLlYEi88l9XnzIzRIwpsmcYsgth2W0t7pbDbOH8N+KZAEJvLk6Dqw74fCBAQHTI9IuzvttYF1tX5BJfykmjVW1Or2ItLb7Q0NIgo7CxzJTxFd1BFxJ/RFjeOEkTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752464229; c=relaxed/simple;
	bh=DXHCOru+M/97RL2tFgyVmxU+UDrWr8Bn+LpS9gK8fsI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dw8jjS7YOBUNPUDunLqdMpH6N5nLsL/TlVXfejk1SrS8Vn+weKxiO2bxbVQRODERDhSd7YWbCq04fWwl/wXYwY5vgsTU/LbReKznT5GwgIK5g36E678Jjs3Qb4tJqSN3bWr0Z8kTc2LBxUy3fO9LObBxOWnZlhKPMtk1N4tvGSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bgSg45dwHzKHMTK;
	Mon, 14 Jul 2025 11:37:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 56A521A1062;
	Mon, 14 Jul 2025 11:37:03 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP3 (Coremail) with SMTP id _Ch0CgCHAdxTe3Rozz_HAA--.22573S2;
	Mon, 14 Jul 2025 11:37:03 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	peterz@infradead.org
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH next] cpuset: fix warning when attaching tasks with offline CPUs
Date: Mon, 14 Jul 2025 03:23:11 +0000
Message-Id: <20250714032311.3570157-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgCHAdxTe3Rozz_HAA--.22573S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uFWkuF47Gr1xGFWDAr48Crg_yoW5Jr1DpF
	Wak3WUtw45WF1UC39rG3y2gFy0gan5GF47J3Z3Kw1rJFWfCF1j93W7twn8XryrtrW3u3WY
	vF90vr4jgasFy3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

A kernel warning was observed in the cpuset migration path:

    WARNING: CPU: 3 PID: 123 at kernel/cgroup/cpuset.c:3130
    cgroup_migrate_execute+0x8df/0xf30
    Call Trace:
     cgroup_transfer_tasks+0x2f3/0x3b0
     cpuset_migrate_tasks_workfn+0x146/0x3b0
     process_one_work+0x5ba/0xda0
     worker_thread+0x788/0x1220

The issue can be reliably reproduced with:

    # Setup test cpuset
    mkdir /sys/fs/cgroup/cpuset/test
    echo 2-3 > /sys/fs/cgroup/cpuset/test/cpuset.cpus
    echo 0 > /sys/fs/cgroup/cpuset/test/cpuset.mems

    # Start test process
    sleep 100 &
    pid=$!
    echo $pid > /sys/fs/cgroup/cpuset/test/cgroup.procs
    taskset -p 0xC $pid  # Bind to CPUs 2-3

    # Take CPUs offline
    echo 0 > /sys/devices/system/cpu/cpu3/online
    echo 0 > /sys/devices/system/cpu/cpu2/online

Root cause analysis:
When tasks are migrated to top_cpuset due to CPUs going offline,
cpuset_attach_task() sets the CPU affinity using cpus_attach which
is initialized from cpu_possible_mask. This mask may include offline
CPUs. When __set_cpus_allowed_ptr() computes the intersection between:
1. cpus_attach (possible CPUs, may include offline)
2. p->user_cpus_ptr (original user-set mask)
The resulting new_mask may contain only offline CPUs, causing the
operation to fail.

The fix changes cpus_attach initialization to use cpu_active_mask
instead of cpu_possible_mask, ensuring we only consider online CPUs
when setting the new affinity. This prevents the scenario where
the intersection would result in an invalid CPU set.

Fixes: da019032819a ("sched: Enforce user requested affinity")
Reported-by: Yang Lijin <yanglijin@huawei.com>
Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index f74d04429a29..5401adbdffa6 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3121,7 +3121,7 @@ static void cpuset_attach_task(struct cpuset *cs, struct task_struct *task)
 	if (cs != &top_cpuset)
 		guarantee_active_cpus(task, cpus_attach);
 	else
-		cpumask_andnot(cpus_attach, task_cpu_possible_mask(task),
+		cpumask_andnot(cpus_attach, cpu_active_mask,
 			       subpartitions_cpus);
 	/*
 	 * can_attach beforehand should guarantee that this doesn't
-- 
2.34.1


