Return-Path: <cgroups+bounces-5141-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF129A05E1
	for <lists+cgroups@lfdr.de>; Wed, 16 Oct 2024 11:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C8E91F2196C
	for <lists+cgroups@lfdr.de>; Wed, 16 Oct 2024 09:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7223205139;
	Wed, 16 Oct 2024 09:45:16 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E150D1B3926;
	Wed, 16 Oct 2024 09:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729071916; cv=none; b=KdQ1ncQMFOKHqPvI7RtPka4HI6bBCpTePlrjygeIFqNKBFqe5/rz3Wkql82LZVdXuCMB5BA3WWzDsf1bm9cZGogD/29F8B5V96fIUkWg5f9whb+I0wCcNvTGTMJ98046wfpDAFHZiSqgxRQYD25MBF3nvJK6Iq9mz30a2T+g/7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729071916; c=relaxed/simple;
	bh=+B6ATd+WMR3YPHa5+k9fe+PBfG77jRROqs/SGLmugxU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FGq0ycrSV+C2xTxAlVKyMMbg/F2zCAp9rM6v14skY+3itIJZll5uTxHuKs8JlknPBvmp8CARN2HbUz5axM7kWf8RdJpCP9yJQ8bsSEMqJpPM9yEPsouN2/kwVgzPb+Eh7ZL3gcHJY2R2H85ZxJ7g5BkxYfuCYjiG5vnnd38by3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XT5fN3G5Jz4f3nTD;
	Wed, 16 Oct 2024 17:44:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 59CFE1A08FC;
	Wed, 16 Oct 2024 17:45:02 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgBXjMgRiw9nmMP7EA--.33330S2;
	Wed, 16 Oct 2024 17:45:02 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: tj@kernel.org,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	longman@redhat.com,
	mkoutny@suse.com,
	john.fastabend@gmail.com,
	roman.gushchin@linux.dev,
	quanyang.wang@windriver.com,
	ast@kernel.org
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	chenridong@huawei.com,
	wangweiyang2@huawei.com
Subject: [PATCH] cgroup/bpf: fix NULL pointer dereference at cgroup_bpf_offline
Date: Wed, 16 Oct 2024 09:36:33 +0000
Message-Id: <20241016093633.670555-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXjMgRiw9nmMP7EA--.33330S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGry3tr1xCrWkKF4DKw43Awb_yoW5ZFykpr
	4UGw1UKw4rGr1DAF4jya40qF10kan3Z3WUGryxJr4kAF17Xw1jqr9FvFWUZryUCF47Kr1U
	Ja15Ar48K34Utw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
	tVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU1OzVUUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

Kernel fault injection test reports NULL pointer dereference as follows:
BUG: kernel NULL pointer dereference, address: 0000000000000010
PGD 0 P4D 0
Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
CPU: 7 UID: 0 PID: 1611 Comm: umount Tainted: G        W       6.12.0-rc2
Tainted: [W]=WARN
RIP: 0010:__percpu_ref_switch_mode+0x30/0x320
RSP: 0018:ffffc90001f9be28 EFLAGS: 00000002
RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000001
RDX: 0000000000000001 RSI: ffffffff82c12d18 RDI: ffff88810753a7d8
RBP: ffff88810f3a0888 R08: 0000000000000001 R09: 00000000000c0000
R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000010 CR3: 0000000111edc000 CR4: 00000000000006f0
Call Trace:
  percpu_ref_kill_and_confirm+0x3a/0x90
  cgroup_kill_sb+0x61/0x190
  deactivate_locked_super+0x35/0xa0
  cleanup_mnt+0x100/0x160
  task_work_run+0x5c/0x90
  syscall_exit_to_user_mode+0x1bc/0x1d0
  do_syscall_64+0x74/0x140
  entry_SYSCALL_64_after_hwframe+0x76/0x7e

A warning was also found in dmesg when the bug occurs,
WARNING: CPU: 5 PID: 1554 at kernel/cgroup/cgroup.c:2144
Call Trace:
  ? cgroup_setup_root+0x39c/0x440
  cgroup1_get_tree+0x38f/0x860
  ? cgroup1_get_tree+0x71/0x860
  vfs_get_tree+0x2c/0x100
  path_mount+0x2e3/0xb90
  __x64_sys_mount+0x19f/0x200
  do_syscall_64+0x68/0x140
  entry_SYSCALL_64_after_hwframe+0x76/0x7e

As mentioned above, when cgroup_bpf_inherit returns an error in
cgroup_setup_root, cgrp->bpf.refcnt has been exited. If cgrp->bpf.refcnt is
killed again in the cgroup_kill_sb function, the data of cgrp->bpf.refcnt
may have become NULL, leading to NULL pointer dereference.

To fix this issue, goto err when cgroup_bpf_inherit returns an error.
Additionally, if cgroup_bpf_inherit returns an error after rebinding
subsystems, the root_cgrp->self.refcnt is exited, which leads to
cgroup1_root_to_use return 1 (restart) when subsystems is  mounted next.
This is due to a failure trying to get the refcnt(the root is root_cgrp,
without rebinding back to cgrp_dfl_root). So move the call to
cgroup_bpf_inherit above rebind_subsystems in the cgroup_setup_root.

Fixes: 04f8ef5643bc ("cgroup: Fix memory leak caused by missing cgroup_bpf_offline")
Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cgroup.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 5886b95c6eae..8a0cbf95cc57 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2136,12 +2136,13 @@ int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask)
 	if (ret)
 		goto destroy_root;
 
-	ret = rebind_subsystems(root, ss_mask);
+	ret = cgroup_bpf_inherit(root_cgrp);
 	if (ret)
 		goto exit_stats;
 
-	ret = cgroup_bpf_inherit(root_cgrp);
-	WARN_ON_ONCE(ret);
+	ret = rebind_subsystems(root, ss_mask);
+	if (ret)
+		goto exit_stats;
 
 	trace_cgroup_setup_root(root);
 
-- 
2.34.1


