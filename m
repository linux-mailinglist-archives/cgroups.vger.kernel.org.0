Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB0571140F9
	for <lists+cgroups@lfdr.de>; Thu,  5 Dec 2019 13:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729438AbfLEMqC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Dec 2019 07:46:02 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7640 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729290AbfLEMqC (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 5 Dec 2019 07:46:02 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 96EE551B0A0F4371FE58;
        Thu,  5 Dec 2019 20:45:59 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Thu, 5 Dec 2019
 20:45:49 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     <linux-block@vger.kernel.org>, <tj@kernel.org>
CC:     <paolo.valente@linaro.org>, <axboe@kernel.dk>,
        <cgroups@vger.kernel.org>, <houtao1@huawei.com>
Subject: [PATCH] bfq-iosched: Ensure bio->bi_blkg is valid before using it
Date:   Thu, 5 Dec 2019 20:53:11 +0800
Message-ID: <20191205125311.40616-1-houtao1@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

bio->bi_blkg will be NULL when the issue of the request
has bypassed the block layer as shown in the following oops:

 Internal error: Oops: 96000005 [#1] SMP
 CPU: 17 PID: 2996 Comm: scsi_id Not tainted 5.4.0 #4
 Call trace:
  percpu_counter_add_batch+0x38/0x4c8
  bfqg_stats_update_legacy_io+0x9c/0x280
  bfq_insert_requests+0xbac/0x2190
  blk_mq_sched_insert_request+0x288/0x670
  blk_execute_rq_nowait+0x140/0x178
  blk_execute_rq+0x8c/0x140
  sg_io+0x604/0x9c0
  scsi_cmd_ioctl+0xe38/0x10a8
  scsi_cmd_blk_ioctl+0xac/0xe8
  sd_ioctl+0xe4/0x238
  blkdev_ioctl+0x590/0x20e0
  block_ioctl+0x60/0x98
  do_vfs_ioctl+0xe0/0x1b58
  ksys_ioctl+0x80/0xd8
  __arm64_sys_ioctl+0x40/0x78
  el0_svc_handler+0xc4/0x270

so ensure its validity before using it.

Fixes: fd41e60331b1 ("bfq-iosched: stop using blkg->stat_bytes and ->stat_ios")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 block/bfq-cgroup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index cea0ae12f937..e1419edde2ec 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -351,6 +351,9 @@ void bfqg_stats_update_legacy_io(struct request_queue *q, struct request *rq)
 {
 	struct bfq_group *bfqg = blkg_to_bfqg(rq->bio->bi_blkg);
 
+	if (!bfqg)
+		return;
+
 	blkg_rwstat_add(&bfqg->stats.bytes, rq->cmd_flags, blk_rq_bytes(rq));
 	blkg_rwstat_add(&bfqg->stats.ios, rq->cmd_flags, 1);
 }
-- 
2.22.0

