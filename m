Return-Path: <cgroups+bounces-2283-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BCF8969BA
	for <lists+cgroups@lfdr.de>; Wed,  3 Apr 2024 10:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A921FB22A34
	for <lists+cgroups@lfdr.de>; Wed,  3 Apr 2024 08:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A7A6FE0A;
	Wed,  3 Apr 2024 08:58:06 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6E454675;
	Wed,  3 Apr 2024 08:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712134686; cv=none; b=kbfHn0sH9hKWp58tGeXf14CvuiiyQS6C4Fp2Vj5w/lHAhXnRfOlDAjEdj0btifoIcVDSY7f4BYF+K7YvALsKwG91degOSm3ehxRh3O535VzB+xNet0bnrFQeVqyXGUTbgUNIdFu5a6fOLp6iRKByKPr7WIPjPA1cCP1rUs51Bvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712134686; c=relaxed/simple;
	bh=WzH0xSfIPWd+YCnXQz2pzuGn0FYWidLKKiCFdrtgfFs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qHmCmwwNKg5A3zEKyumzCnjiZSQxhKPvh1ILCS9az07eVKDmEQNOLdCNS2JhZt2I0HUVDPP4ZoPvFbBgelWKsuxlXFLx8RDN/f4uCxNTSIJGrx53V3ZZvfR/wiHktSSm2jRZuvyYot6SRzE4G2OGqZFbX3GU/AWpNUQG3k8mlOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4V8dsw5gp7z17MyP;
	Wed,  3 Apr 2024 16:57:08 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 24C9F1A016F;
	Wed,  3 Apr 2024 16:58:01 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Wed, 3 Apr
 2024 16:58:00 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <longman@redhat.com>, <lizefan.x@bytedance.com>, <tj@kernel.org>,
	<hannes@cmpxchg.org>, <daniel.m.jordan@oracle.com>
CC: <peterz@infradead.org>, <cgroups@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <wangweiyang2@huawei.com>,
	<lujialin4@huawei.com>, <xiujianfeng@huawei.com>, <caixinchen1@huawei.com>,
	<chenridong@huawei.com>
Subject: [PATCH] cpuset: fix race between rebuild scheduler domains and hotplug work
Date: Wed, 3 Apr 2024 08:52:45 +0000
Message-ID: <20240403085245.335072-1-chenridong@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd100013.china.huawei.com (7.221.188.163)

When offlining cpus, it holds cpu_hotplug_lock and call
cpuset_hotplug_workfn asynchronously, which holds and releases
cpuset_mutex repeatly to update cpusets, and it will release
cpu_hotplug_lock before cpuset_hotplug_workfn finish. It means that some
interfaces like cpuset_write_resmask holding two locks may rebuild
scheduler domains when some cpusets are not refreshed, which may lead to
generate domains with offlining cpus and will panic.

As commit 406100f3da08 ("cpuset: fix race between hotplug work and later
 CPU offline")  mentioned. This problem happen in cgroup v2:

This problem can also happen in cgroup v1 pressure test, which onlines
and offlines cpus, and sets cpuset.cpus to rebuild domains with
sched_load_balance off.

smpboot: CPU 1 is now offline
BUG: unable to handle page fault for address: 0000342bad598668
PGD 0 P4D 0
Oops: 0000 [#1] PREEMPT SMP NOPTI
CPU: 54 PID: 9966 Comm: sh Kdump: loaded Tainted: G S         OE      6.8.0-rc7+ #5
Hardware name: Powerleader PR2715P3/T1DM-E2, BIOS OEM57.22 11/23/2021
RIP: 0010:sd_init+0x204/0x390
Code: 00 02 00 00 a8 80 0f 84 ad 00 00 00 41 c7 44 24 2c 6e 00 00 00 85 d2 74 2f 48 63 54 24 18 49 8b 45 20 48 8b 14 d5 60 0b 79 ab <48> 8b 04 02 49 89 84 24 10 01 00 00 f0 ff 00 49 8b 84 24 10 01 00
RSP: 0018:ffff9f90669afc18 EFLAGS: 00010206
RAX: 0000342c00e62668 RBX: 0000000000000000 RCX: 00000000ffffffa0
RDX: ffffffffac736000 RSI: 0000000000000060 RDI: ffff8b24b8143930
RBP: ffff8b24b8143920 R08: 0000000000000060 R09: ffff8b2635783670
R10: 0000000000000001 R11: 0000000000000001 R12: ffff8b24b8143800
R13: ffff8ae687511600 R14: ffffffffabc6b9b0 R15: ffff8b25c0040ea0
FS:  00007fd93c734740(0000) GS:ffff8b24bca00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000342bad598668 CR3: 00000001e0934005 CR4: 00000000007706f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <TASK>
 ? __die+0x24/0x70
 ? page_fault_oops+0x82/0x150
 ? local_clock_noinstr+0xf/0xb0
 ? exc_page_fault+0x69/0x1b0
 ? asm_exc_page_fault+0x26/0x30
 ? sd_init+0x204/0x390
 ? sd_init+0x11c/0x390
 build_sched_domains+0x171/0x640
 partition_sched_domains_locked+0x2a1/0x3c0
 rebuild_sched_domains_locked+0x14f/0x200
 update_cpumask+0x27c/0x5f0
 cpuset_write_resmask+0x423/0x530
 kernfs_fop_write_iter+0x160/0x220
 vfs_write+0x355/0x480
 ksys_write+0x69/0xf0
 do_syscall_64+0x66/0x180
 entry_SYSCALL_64_after_hwframe+0x6e/0x76
RIP: 0033:0x7fd93c4fc907
Code: 0f 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
RSP: 002b:00007fff153c7f08 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fd93c4fc907
RDX: 0000000000000002 RSI: 000055d055679900 RDI: 0000000000000001
RBP: 000055d055679900 R08: 00007fd93c5b01e0 R09: 00007fd93c5b0260
R10: 00007fd93c5b0160 R11: 0000000000000246 R12: 0000000000000002
R13: 00007fd93c5f25a0 R14: 0000000000000002 R15: 00007fd93c5f27a0

It must guarantee that cpus in domains passing to
partition_and_rebuild_sched_domains must be active. So the domains should
be checked after generate_sched_domains.

Fixes: 0ccea8feb980 ("cpuset: Make generate_sched_domains() work with partition")
Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 927bef3a598a..0e0d469c2591 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1210,6 +1210,7 @@ static void rebuild_sched_domains_locked(void)
 	cpumask_var_t *doms;
 	struct cpuset *cs;
 	int ndoms;
+	int i;
 
 	lockdep_assert_cpus_held();
 	lockdep_assert_held(&cpuset_mutex);
@@ -1251,6 +1252,12 @@ static void rebuild_sched_domains_locked(void)
 	/* Generate domain masks and attrs */
 	ndoms = generate_sched_domains(&doms, &attr);
 
+	/* guarantee no CPU offlining in doms */
+	for (i = 0; i < ndoms; ++i) {
+		if (!cpumask_subset(doms[i], cpu_active_mask))
+			return;
+	}
+
 	/* Have scheduler rebuild the domains */
 	partition_and_rebuild_sched_domains(ndoms, doms, attr);
 }
-- 
2.34.1


