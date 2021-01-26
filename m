Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCB9303FE8
	for <lists+cgroups@lfdr.de>; Tue, 26 Jan 2021 15:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404558AbhAZNfi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 26 Jan 2021 08:35:38 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:55212 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404592AbhAZNe2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 26 Jan 2021 08:34:28 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UMzR8Xr_1611668024;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UMzR8Xr_1611668024)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 26 Jan 2021 21:33:44 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     axboe@kernel.dk, tj@kernel.org
Cc:     joseph.qi@linux.alibaba.com, baolin.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] blk-cgroup: Use cond_resched() when destroy blkgs
Date:   Tue, 26 Jan 2021 21:33:25 +0800
Message-Id: <8f4fb91ced02e58ef425189c83214086f1154a0c.1611664710.git.baolin.wang@linux.alibaba.com>
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
the loop of blkcg_destroy_blkgs(), thus we can use cond_resched()
instead of cpu_relax() to avoid this issue, since the
blkcg_destroy_blkgs() is not called from atomic contexts.

[ 4757.010308] watchdog: BUG: soft lockup - CPU#11 stuck for 94s!
[ 4757.010698] Call trace:
[ 4757.010700]  blkcg_destroy_blkgs+0x68/0x150
[ 4757.010701]  cgwb_release_workfn+0x104/0x158
[ 4757.010702]  process_one_work+0x1bc/0x3f0
[ 4757.010704]  worker_thread+0x164/0x468
[ 4757.010705]  kthread+0x108/0x138

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 block/blk-cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 3465d6e..af7c0ce 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1028,7 +1028,7 @@ void blkcg_destroy_blkgs(struct blkcg *blkcg)
 			spin_unlock(&q->queue_lock);
 		} else {
 			spin_unlock_irq(&blkcg->lock);
-			cpu_relax();
+			cond_resched();
 			spin_lock_irq(&blkcg->lock);
 		}
 	}
-- 
1.8.3.1

