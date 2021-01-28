Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC52E306B8A
	for <lists+cgroups@lfdr.de>; Thu, 28 Jan 2021 04:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbhA1DWz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Jan 2021 22:22:55 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:45447 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229563AbhA1DWx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Jan 2021 22:22:53 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UN6KA9h_1611804128;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UN6KA9h_1611804128)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 28 Jan 2021 11:22:08 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     axboe@kernel.dk, tj@kernel.org
Cc:     joseph.qi@linux.alibaba.com, baolin.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] blk-cgroup: Use cond_resched() when destroy blkgs
Date:   Thu, 28 Jan 2021 11:22:00 +0800
Message-Id: <8e8a0c4644d5eb01b7f79ec9b67c2b240f4a6434.1611798287.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On !PREEMPT kernel, we can get below softlockup when doing stress
testing with creating and destroying block cgroup repeatly. The
reason is it may take a long time to acquire the queue's lock in
the loop of blkcg_destroy_blkgs(), or the system can accumulate a
huge number of blkgs in pathological cases. We can add a need_resched()
check on each loop and release locks and do cond_resched() if true
to avoid this issue, since the blkcg_destroy_blkgs() is not called
from atomic contexts.

[ 4757.010308] watchdog: BUG: soft lockup - CPU#11 stuck for 94s!
[ 4757.010698] Call trace:
[ 4757.010700]  blkcg_destroy_blkgs+0x68/0x150
[ 4757.010701]  cgwb_release_workfn+0x104/0x158
[ 4757.010702]  process_one_work+0x1bc/0x3f0
[ 4757.010704]  worker_thread+0x164/0x468
[ 4757.010705]  kthread+0x108/0x138

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
Changes from v1:
 - Add might_sleep() in blkcg_destroy_blkgs().
 - Add an explicitly need_resched() check before releasing lock.
 - Add some comments.
---
 block/blk-cgroup.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 3465d6e..94eeed7 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1016,6 +1016,8 @@ static void blkcg_css_offline(struct cgroup_subsys_state *css)
  */
 void blkcg_destroy_blkgs(struct blkcg *blkcg)
 {
+	might_sleep();
+
 	spin_lock_irq(&blkcg->lock);
 
 	while (!hlist_empty(&blkcg->blkg_list)) {
@@ -1031,6 +1033,17 @@ void blkcg_destroy_blkgs(struct blkcg *blkcg)
 			cpu_relax();
 			spin_lock_irq(&blkcg->lock);
 		}
+
+		/*
+		 * Given that the system can accumulate a huge number
+		 * of blkgs in pathological cases, check to see if we
+		 * need to rescheduling to avoid softlockup.
+		 */
+		if (need_resched()) {
+			spin_unlock_irq(&blkcg->lock);
+			cond_resched();
+			spin_lock_irq(&blkcg->lock);
+		}
 	}
 
 	spin_unlock_irq(&blkcg->lock);
-- 
1.8.3.1

