Return-Path: <cgroups+bounces-5978-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E26739F9064
	for <lists+cgroups@lfdr.de>; Fri, 20 Dec 2024 11:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C28B7A1F11
	for <lists+cgroups@lfdr.de>; Fri, 20 Dec 2024 10:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF781C07DF;
	Fri, 20 Dec 2024 10:41:38 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA07519C56D;
	Fri, 20 Dec 2024 10:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734691298; cv=none; b=WVQEBkbd0kNerq7HBxBP5/4Y/oSgpRi7kNnpaJwEzStgSHS0q2UHzhCTqUHVAVlRvYTuFIQTlfv9wKMHcpSCJcMF9OOuKq8VRGebj7bY9LTrh5qOrH9iA0BW3Wz8awwlCC6DdlHvlljyzY8MCejdDZocrE/2YnuqY+RMlC/OatE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734691298; c=relaxed/simple;
	bh=KKkwdu/8w4dLCjB5/SOcaqEIkKpra7Eb6Fb8CQY/uJw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o7ZzmLZo4K+ejSR3hjRn9p87jwFfahjerOBA3x2WwMIIUAAZNNfcTvOgA4Gh17OdLJTchfHT37010FBp/ez634sicD5/PbftJ9b9elfYNNoLq4b2gXHtX+VdZJIMarOMfZvJb0Sz+6JrbajfUoi2s81Qb19OP7nK14UAg/j8Nrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YF3qb2FPQz4f3jqs;
	Fri, 20 Dec 2024 18:41:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id C9BBD1A058E;
	Fri, 20 Dec 2024 18:41:29 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgBXt+PKSWVn5CNcFA--.50187S2;
	Fri, 20 Dec 2024 18:41:29 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: akpm@linux-foundation.org,
	mhocko@kernel.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	davidf@vimeo.com,
	vbabka@suse.cz,
	handai.szj@taobao.com,
	rientjes@google.com,
	kamezawa.hiroyu@jp.fujitsu.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	chenridong@huawei.com,
	wangweiyang2@huawei.com
Subject: [PATCH v2] memcg: fix soft lockup in the OOM process
Date: Fri, 20 Dec 2024 10:31:23 +0000
Message-Id: <20241220103123.3677988-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBXt+PKSWVn5CNcFA--.50187S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXryxGryDKF18WF45XF4Utwb_yoWrCF4kpa
	srCa1UGw4rGr15Xr12yr1j9r1fAw48ua1UJrW2qr1UAr13Kwn8JrW7Jr4Utrn5WFWaqFya
	qrn0yw48Kr4qyaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
	6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUIa0PDUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

A soft lockup issue was found in the product with about 56,000 tasks were
in the OOM cgroup, it was traversing them when the soft lockup was
triggered.

watchdog: BUG: soft lockup - CPU#2 stuck for 23s! [VM Thread:1503066]
CPU: 2 PID: 1503066 Comm: VM Thread Kdump: loaded Tainted: G
Hardware name: Huawei Cloud OpenStack Nova, BIOS
RIP: 0010:console_unlock+0x343/0x540
RSP: 0000:ffffb751447db9a0 EFLAGS: 00000247 ORIG_RAX: ffffffffffffff13
RAX: 0000000000000001 RBX: 0000000000000000 RCX: 00000000ffffffff
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000247
RBP: ffffffffafc71f90 R08: 0000000000000000 R09: 0000000000000040
R10: 0000000000000080 R11: 0000000000000000 R12: ffffffffafc74bd0
R13: ffffffffaf60a220 R14: 0000000000000247 R15: 0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2fe6ad91f0 CR3: 00000004b2076003 CR4: 0000000000360ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 vprintk_emit+0x193/0x280
 printk+0x52/0x6e
 dump_task+0x114/0x130
 mem_cgroup_scan_tasks+0x76/0x100
 dump_header+0x1fe/0x210
 oom_kill_process+0xd1/0x100
 out_of_memory+0x125/0x570
 mem_cgroup_out_of_memory+0xb5/0xd0
 try_charge+0x720/0x770
 mem_cgroup_try_charge+0x86/0x180
 mem_cgroup_try_charge_delay+0x1c/0x40
 do_anonymous_page+0xb5/0x390
 handle_mm_fault+0xc4/0x1f0

This is because thousands of processes are in the OOM cgroup, it takes a
long time to traverse all of them. As a result, this lead to soft lockup
in the OOM process.

To fix this issue, call 'cond_resched' in the 'mem_cgroup_scan_tasks'
function per 1000 iterations. For global OOM, call
'touch_softlockup_watchdog' per 1000 iterations to avoid this issue.

Fixes: 9cbb78bb3143 ("mm, memcg: introduce own oom handler to iterate only over its own threads")
Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 include/linux/oom.h | 7 +++++++
 mm/memcontrol.c     | 6 +++++-
 mm/oom_kill.c       | 7 ++++++-
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/linux/oom.h b/include/linux/oom.h
index 1e0fc6931ce9..df2d336f653d 100644
--- a/include/linux/oom.h
+++ b/include/linux/oom.h
@@ -14,6 +14,13 @@ struct notifier_block;
 struct mem_cgroup;
 struct task_struct;
 
+/* When it traverses for long time,  to prevent softlockup, call
+ * cond_resched/touch_softlockup_watchdog very 1000 iterations.
+ * The 1000 value  is not exactly right, it's used to mitigate the overhead
+ * of cond_resched/touch_softlockup_watchdog.
+ */
+#define SOFTLOCKUP_PREVENTION_LIMIT 1000
+
 enum oom_constraint {
 	CONSTRAINT_NONE,
 	CONSTRAINT_CPUSET,
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5c373d275e7a..f4c12d6e7b37 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1161,6 +1161,7 @@ void mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
 {
 	struct mem_cgroup *iter;
 	int ret = 0;
+	int i = 0;
 
 	BUG_ON(mem_cgroup_is_root(memcg));
 
@@ -1169,8 +1170,11 @@ void mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
 		struct task_struct *task;
 
 		css_task_iter_start(&iter->css, CSS_TASK_ITER_PROCS, &it);
-		while (!ret && (task = css_task_iter_next(&it)))
+		while (!ret && (task = css_task_iter_next(&it))) {
 			ret = fn(task, arg);
+			if (++i % SOFTLOCKUP_PREVENTION_LIMIT)
+				cond_resched();
+		}
 		css_task_iter_end(&it);
 		if (ret) {
 			mem_cgroup_iter_break(memcg, iter);
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 1c485beb0b93..05e613750e9b 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -44,6 +44,7 @@
 #include <linux/init.h>
 #include <linux/mmu_notifier.h>
 #include <linux/cred.h>
+#include <linux/nmi.h>
 
 #include <asm/tlb.h>
 #include "internal.h"
@@ -430,10 +431,14 @@ static void dump_tasks(struct oom_control *oc)
 		mem_cgroup_scan_tasks(oc->memcg, dump_task, oc);
 	else {
 		struct task_struct *p;
+		int i = 0;
 
 		rcu_read_lock();
-		for_each_process(p)
+		for_each_process(p) {
+			if (++i % SOFTLOCKUP_PREVENTION_LIMIT)
+				touch_softlockup_watchdog();
 			dump_task(p, oc);
+		}
 		rcu_read_unlock();
 	}
 }
-- 
2.34.1


