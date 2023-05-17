Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF297061BC
	for <lists+cgroups@lfdr.de>; Wed, 17 May 2023 09:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjEQHwi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 17 May 2023 03:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjEQHwg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 17 May 2023 03:52:36 -0400
X-Greylist: delayed 353 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 17 May 2023 00:52:35 PDT
Received: from out-25.mta1.migadu.com (out-25.mta1.migadu.com [IPv6:2001:41d0:203:375::19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC961701
        for <cgroups@vger.kernel.org>; Wed, 17 May 2023 00:52:34 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684309598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=lYjBqehqUWvSOXsymQqye+/pd2/QBGQCCztad22+z+8=;
        b=xoTnZwWNmd3UbNaJGG6QcrcKvZ9D6Y2wAV+JUnjezWa4UelfUEdPIBQafZcvTy7KHUldTM
        bM1INjvJvYZLf9gXTym6Jo/bj1JaB+q65jnCK1R1PhB9E8zrAfGG6WuLr2RhHVV7hEpA3Z
        O9KPdv9m2VcMDAydOH+hSzKxDVaPLTM=
From:   Qi Zheng <qi.zheng@linux.dev>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        muchun.song@linux.dev, Qi Zheng <zhengqi.arch@bytedance.com>,
        Zhao Gongyi <zhaogongyi@bytedance.com>
Subject: [PATCH] cgroup: fix missing cpus_read_{lock,unlock}() in cgroup_transfer_tasks()
Date:   Wed, 17 May 2023 07:45:45 +0000
Message-Id: <20230517074545.2045035-1-qi.zheng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Qi Zheng <zhengqi.arch@bytedance.com>

The commit 4f7e7236435c ("cgroup: Fix threadgroup_rwsem <-> cpus_read_lock()
deadlock") fixed the deadlock between cgroup_threadgroup_rwsem and
cpus_read_lock() by introducing cgroup_attach_{lock,unlock}() and removing
cpus_read_{lock,unlock}() from cpuset_attach(). But cgroup_transfer_tasks()
was missed and not handled, which will cause th following warning:

 WARNING: CPU: 0 PID: 589 at kernel/cpu.c:526 lockdep_assert_cpus_held+0x32/0x40
 CPU: 0 PID: 589 Comm: kworker/1:4 Not tainted 6.4.0-rc2-next-20230517 #50
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
 Workqueue: events cpuset_hotplug_workfn
 RIP: 0010:lockdep_assert_cpus_held+0x32/0x40
 <...>
 Call Trace:
  <TASK>
  cpuset_attach+0x40/0x240
  cgroup_migrate_execute+0x452/0x5e0
  ? _raw_spin_unlock_irq+0x28/0x40
  cgroup_transfer_tasks+0x1f3/0x360
  ? find_held_lock+0x32/0x90
  ? cpuset_hotplug_workfn+0xc81/0xed0
  cpuset_hotplug_workfn+0xcb1/0xed0
  ? process_one_work+0x248/0x5b0
  process_one_work+0x2b9/0x5b0
  worker_thread+0x56/0x3b0
  ? process_one_work+0x5b0/0x5b0
  kthread+0xf1/0x120
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork+0x1f/0x30
  </TASK>

So just use the cgroup_attach_{lock,unlock}() helper to fix it.

Fixes: 4f7e7236435c ("cgroup: Fix threadgroup_rwsem <-> cpus_read_lock() deadlock")
Reported-by: Zhao Gongyi <zhaogongyi@bytedance.com>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 kernel/cgroup/cgroup-v1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index aeef06c465ef..5407241dbb45 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -108,7 +108,7 @@ int cgroup_transfer_tasks(struct cgroup *to, struct cgroup *from)
 
 	cgroup_lock();
 
-	percpu_down_write(&cgroup_threadgroup_rwsem);
+	cgroup_attach_lock(true);
 
 	/* all tasks in @from are being moved, all csets are source */
 	spin_lock_irq(&css_set_lock);
@@ -144,7 +144,7 @@ int cgroup_transfer_tasks(struct cgroup *to, struct cgroup *from)
 	} while (task && !ret);
 out_err:
 	cgroup_migrate_finish(&mgctx);
-	percpu_up_write(&cgroup_threadgroup_rwsem);
+	cgroup_attach_unlock(true);
 	cgroup_unlock();
 	return ret;
 }
-- 
2.30.2

