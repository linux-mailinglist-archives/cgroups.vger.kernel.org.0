Return-Path: <cgroups+bounces-13357-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMsbMG3gcWk+MgAAu9opvQ
	(envelope-from <cgroups+bounces-13357-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 22 Jan 2026 09:31:41 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACEE631A3
	for <lists+cgroups@lfdr.de>; Thu, 22 Jan 2026 09:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 938624EA3ED
	for <lists+cgroups@lfdr.de>; Thu, 22 Jan 2026 08:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DF43A8FFC;
	Thu, 22 Jan 2026 08:23:59 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D531387571;
	Thu, 22 Jan 2026 08:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769070239; cv=none; b=VZJuCrqLdCohsy5mNMJw/lWaRGAnen1PZQBcuIZuoMGd4fr7fqdllLBsl3rdK7mp5lCXpIWVVraKbI4psO05TM/u9Jb9DKZtQV5cDJn99KannBif+Vo2Krfrl1gqcbpkuyo4CFxj3ob6lv6C+Dogzye/ZsCCQVr13tKq9O/6kyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769070239; c=relaxed/simple;
	bh=KeR0mtRBkemEe9lFkcHfvvhoSzV2DtQIP1WbTL40zG4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pV05b0yAulkG2Jnt8QQP6VxHntw427hhK+OMcc1h31TZZABydl/BxGd9bI9hyxhhED8kUmyVulZx/8ycNrusMXyhgYCqb5Ml39i+d4AfwUv0Zrb6W5LnVKOZ2OV8HrYqoCpfEFUr3sLDVG9kMV7sd+VL25B/CrJNwzjUg+trK4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dxYwt4RgzzYQtdy;
	Thu, 22 Jan 2026 16:23:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7E4F04058A;
	Thu, 22 Jan 2026 16:23:53 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgDnR_iO3nFpXALGEg--.27614S2;
	Thu, 22 Jan 2026 16:23:53 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	chenridong@huaweicloud.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	frederic@kernel.org
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com
Subject: [PATCH -next] sched/isolation: Use static_branch_enable_cpuslocked() on housekeeping_update
Date: Thu, 22 Jan 2026 08:09:02 +0000
Message-Id: <20260122080902.2312721-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnR_iO3nFpXALGEg--.27614S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAryxWF4xJw43tF43ZF4fKrg_yoW5Zr1kpF
	y3W34xJr4UKry0ka90vw4jkry0gwsrJry7G3s3Gw1rXF12vF10yFy09Fnaqr9Y9r93CF15
	ZFZ09w4agr4DA37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjTRNJ5oDUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.24 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[chenridong@huaweicloud.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	TAGGED_FROM(0.00)[bounces-13357-lists,cgroups=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,huaweicloud.com:mid]
X-Rspamd-Queue-Id: 1ACEE631A3
X-Rspamd-Action: no action

From: Chen Ridong <chenridong@huawei.com>

The warning is observed:

 WARNING: possible recursive locking detected
 6.19.0-rc6-next-20260121 #1046 Not tainted
 --------------------------------------------
 test_cpuset_prs/686 is trying to acquire lock:
 (cpu_hotplug_lock){++++}-{0:0}, at: static_key_enable+0xd/0x20

 but task is already holding lock:
 (cpu_hotplug_lock){++++}-{0:0}, at: cpuset_partition_write+0x72/0x10

 other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(cpu_hotplug_lock);
   lock(cpu_hotplug_lock);

  *** DEADLOCK ***

  May be due to missing lock nesting notation

 stack backtrace:
 CPU: 11 UID: 0 PID: 686 Comm: test_cpuset_prs  6.19.0-rc6-next-20260121 #1
 Call Trace:
  <TASK>
  dump_stack_lvl+0x82/0xd0
  print_deadlock_bug+0x288/0x3c0
  __lock_acquire+0x1506/0x27f0
  lock_acquire+0xc8/0x2d0
  ? static_key_enable+0xd/0x20
  cpus_read_lock+0x3b/0xd0
  ? static_key_enable+0xd/0x20
  static_key_enable+0xd/0x20
  housekeeping_update+0xe7/0x1b0
  update_prstate+0x3f2/0x580
  cpuset_partition_write+0x98/0x100
  kernfs_fop_write_iter+0x14e/0x200
  vfs_write+0x367/0x510
  ksys_write+0x66/0xe0
  do_syscall_64+0x6b/0x390
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
 RIP: 0033:0x7f824cf8c887

The commit 7109b22e6581 ("cpuset: Update HK_TYPE_DOMAIN cpumask from
cpuset") introduced housekeeping_update, which calls static_branch_enable
while cpu_read_lock() is held. Since static_key_enable itself also acquires
cpu_read_lock, this leads to a lockdep warning. To resolve this issue,
replace the call to static_key_enable with static_branch_enable_cpuslocked.

Fixes: 7109b22e6581 ("cpuset: Update HK_TYPE_DOMAIN cpumask from cpuset")
Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c   | 2 --
 kernel/sched/isolation.c | 4 +++-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 392ce795656d..a26ccff55bb7 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1308,8 +1308,6 @@ static void update_isolation_cpumasks(void)
 	if (!isolated_cpus_updating)
 		return;
 
-	lockdep_assert_cpus_held();
-
 	ret = housekeeping_update(isolated_cpus);
 	WARN_ON_ONCE(ret < 0);
 
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index ef152d401fe2..3b725d39c06e 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -123,6 +123,8 @@ int housekeeping_update(struct cpumask *isol_mask)
 	struct cpumask *trial, *old = NULL;
 	int err;
 
+	lockdep_assert_cpus_held();
+
 	trial = kmalloc(cpumask_size(), GFP_KERNEL);
 	if (!trial)
 		return -ENOMEM;
@@ -134,7 +136,7 @@ int housekeeping_update(struct cpumask *isol_mask)
 	}
 
 	if (!housekeeping.flags)
-		static_branch_enable(&housekeeping_overridden);
+		static_branch_enable_cpuslocked(&housekeeping_overridden);
 
 	if (housekeeping.flags & HK_FLAG_DOMAIN)
 		old = housekeeping_cpumask_dereference(HK_TYPE_DOMAIN);
-- 
2.34.1


