Return-Path: <cgroups+bounces-13501-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WG2FLX8Fe2maAgIAu9opvQ
	(envelope-from <cgroups+bounces-13501-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 29 Jan 2026 08:00:15 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A5BAC602
	for <lists+cgroups@lfdr.de>; Thu, 29 Jan 2026 08:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41D7B3019802
	for <lists+cgroups@lfdr.de>; Thu, 29 Jan 2026 07:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFF534F48C;
	Thu, 29 Jan 2026 07:00:12 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69A02D6E55;
	Thu, 29 Jan 2026 07:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769670012; cv=none; b=b43Js38+m+nWDdBtzJN44aVJINLddETMS72ccjZGIpmGJXd4OsXLMFsXzGyB2K95JlvEuNgchAwYZ4i1LyOIeowgj0vMgITOWF+cNBsOFO6mJaw8wuimfUusqTteA0R8wjFCBfNNwDSoSG+vBn7qMZDd03pACi8OpMNezWeCzH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769670012; c=relaxed/simple;
	bh=rXxW1bN9b6Jaemw7/SvNEFPf8TPUNHeXBZKigIgq5Rs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uhRBxEY2pp6NT0yQFf2cezkNkxcg+uVknTQI3MZvoHBLXLT7FnFFRZfZEUCeDtokmc4tl/WzFcbRFCW8tdEu7c2yUMtM4IPUuAdiLkzdCm3dQp2UH19m2s+tKtk/X3+1tZ17yVlyR7W28a4RAaBAAsw6ZBBw//7ylaveu31VhVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4f1ql92v65zKHMJn;
	Thu, 29 Jan 2026 14:59:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 124A74056B;
	Thu, 29 Jan 2026 15:00:03 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgD3XHxrBXtpbDbAFQ--.25084S2;
	Thu, 29 Jan 2026 15:00:02 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	chenridong@huaweicloud.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com
Subject: [PATCH -next] cpuset: fix overlap of partition effective CPUs
Date: Thu, 29 Jan 2026 06:45:16 +0000
Message-Id: <20260129064516.210203-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgD3XHxrBXtpbDbAFQ--.25084S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCF43tFWUKr1rGrWrAryfXrb_yoWrGFWUpF
	y5GF4xCr4Fqr15C3yDtFyxWr1rta1kAa15twsrGw1rJa43C3Wq9F1Uta9xZFyUGr9xCF1a
	qrn8Zr40qFyDAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUr2-eDU
	UUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[huaweicloud.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13501-lists,cgroups=lfdr.de];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenridong@huaweicloud.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.992];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huaweicloud.com:mid]
X-Rspamd-Queue-Id: D5A5BAC602
X-Rspamd-Action: no action

From: Chen Ridong <chenridong@huawei.com>

A warning was detect:

 WARNING: kernel/cgroup/cpuset.c:825 at rebuild_sched_domains_locked
 Modules linked in:
 CPU: 12 UID: 0 PID: 681 Comm: rmdir  6.19.0-rc6-next-20260121+
 RIP: 0010:rebuild_sched_domains_locked+0x309/0x4b0
 RSP: 0018:ffffc900019bbd28 EFLAGS: 00000202
 RAX: ffff888104413508 RBX: 0000000000000008 RCX: ffff888104413510
 RDX: ffff888109b5f400 RSI: 000000000000ffcf RDI: 0000000000000001
 RBP: 0000000000000002 R08: ffff888104413508 R09: 0000000000000002
 R10: ffff888104413508 R11: 0000000000000001 R12: ffff888104413500
 R13: 0000000000000002 R14: ffffc900019bbd78 R15: 0000000000000000
 FS:  00007fe274b8d740(0000) GS:ffff8881b6b3c000(0000) knlGS:
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007fe274c98b50 CR3: 00000001047a9000 CR4: 00000000000006f0
 Call Trace:
  <TASK>
  update_prstate+0x1c7/0x580
  cpuset_css_killed+0x2f/0x50
  kill_css+0x32/0x180
  cgroup_destroy_locked+0xa7/0x200
  cgroup_rmdir+0x28/0x100
  kernfs_iop_rmdir+0x4c/0x80
  vfs_rmdir+0x12c/0x280
  filename_rmdir+0x19e/0x200
  __x64_sys_rmdir+0x23/0x40
  do_syscall_64+0x6b/0x390

It can be reproduced by steps:

  # cd /sys/fs/cgroup/
  # mkdir A1
  # mkdir B1
  # mkdir C1
  # echo 1-3 > A1/cpuset.cpus
  # echo root > A1/cpuset.cpus.partition
  # echo 3-5 > B1/cpuset.cpus
  # echo root > B1/cpuset.cpus.partition
  # echo 6 > C1/cpuset.cpus
  # echo root > C1/cpuset.cpus.partition
  # rmdir A1/
  # rmdir C1/

Both A1 and B1 were initially configured with CPU 3, which was exclusively
assigned to A1's partition. When A1 was removed, CPU 3 was returned to the
root pool. However, B1 incorrectly regained access to CPU 3 when
update_cpumasks_hier was triggered during C1's removal, which also updated
sibling configurations.

The update_sibling_cpumasks function was called to synchronize siblings'
effective CPUs due to changes in their parent's effective CPUs. However,
parent effective CPU changes should not affect partition-effective CPUs.

To fix this issue, update_cpumasks_hier should only be invoked when the
sibling is not a valid partition in the update_sibling_cpumasks.

Fixes: 2a3602030d80 ("cgroup/cpuset: Don't invalidate sibling partitions on cpuset.cpus conflict")
Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index cf67d3524c75..31ba74044155 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2227,27 +2227,20 @@ static void update_sibling_cpumasks(struct cpuset *parent, struct cpuset *cs,
 	 * It is possible a change in parent's effective_cpus
 	 * due to a change in a child partition's effective_xcpus will impact
 	 * its siblings even if they do not inherit parent's effective_cpus
-	 * directly.
+	 * directly. It should not impact valid partition.
 	 *
 	 * The update_cpumasks_hier() function may sleep. So we have to
 	 * release the RCU read lock before calling it.
 	 */
 	rcu_read_lock();
 	cpuset_for_each_child(sibling, pos_css, parent) {
-		if (sibling == cs)
+		if (sibling == cs || is_partition_valid(sibling))
 			continue;
-		if (!is_partition_valid(sibling)) {
-			compute_effective_cpumask(tmp->new_cpus, sibling,
-						  parent);
-			if (cpumask_equal(tmp->new_cpus, sibling->effective_cpus))
-				continue;
-		} else if (is_remote_partition(sibling)) {
-			/*
-			 * Change in a sibling cpuset won't affect a remote
-			 * partition root.
-			 */
+
+		compute_effective_cpumask(tmp->new_cpus, sibling,
+					  parent);
+		if (cpumask_equal(tmp->new_cpus, sibling->effective_cpus))
 			continue;
-		}
 
 		if (!css_tryget_online(&sibling->css))
 			continue;
-- 
2.34.1


