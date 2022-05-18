Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B5A52B364
	for <lists+cgroups@lfdr.de>; Wed, 18 May 2022 09:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbiERHOV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 May 2022 03:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbiERHOT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 May 2022 03:14:19 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319FB106567;
        Wed, 18 May 2022 00:14:10 -0700 (PDT)
Received: from kwepemi100022.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4L33y210S2zCsjB;
        Wed, 18 May 2022 15:09:14 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100022.china.huawei.com (7.221.188.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 18 May 2022 15:14:08 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 18 May
 2022 15:14:08 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <tj@kernel.org>, <axboe@kernel.dk>, <ming.lei@redhat.com>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH -next v2 1/2] blk-throttle: fix that io throttle can only work for single bio
Date:   Wed, 18 May 2022 15:27:50 +0800
Message-ID: <20220518072751.1188163-2-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220518072751.1188163-1-yukuai3@huawei.com>
References: <20220518072751.1188163-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

commit 9f5ede3c01f9 ("block: throttle split bio in case of iops limit")
introduce a new problem, for example:

[root@localhost ~]# echo "8:0 1024" > /sys/fs/cgroup/blkio/blkio.throttle.write_bps_device
[root@localhost ~]# echo $$ > /sys/fs/cgroup/blkio/cgroup.procs
[root@localhost ~]# dd if=/dev/zero of=/dev/sda bs=10k count=1 oflag=direct &
[1] 620
[root@localhost ~]# dd if=/dev/zero of=/dev/sda bs=10k count=1 oflag=direct &
[2] 626
[root@localhost ~]# 1+0 records in
1+0 records out
10240 bytes (10 kB, 10 KiB) copied, 10.0038 s, 1.0 kB/s1+0 records in
1+0 records out

10240 bytes (10 kB, 10 KiB) copied, 9.23076 s, 1.1 kB/s
-> the second bio is issued after 10s instead of 20s.

This is because if some bios are already queued, current bio is queued
directly and the flag 'BIO_THROTTLED' is set. And later, when former
bios are dispatched, this bio will be dispatched without waiting at all,
this is due to tg_with_in_bps_limit() return 0 for this bio.

In order to fix the problem, don't skip flaged bio in
tg_with_in_bps_limit(), and for the problem that split bio can be
double accounted, compensate the over-accounting in __blk_throtl_bio().

Fixes: 9f5ede3c01f9 ("block: throttle split bio in case of iops limit")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-throttle.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 447e1b8722f7..6f69859eae23 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -811,7 +811,7 @@ static bool tg_with_in_bps_limit(struct throtl_grp *tg, struct bio *bio,
 	unsigned int bio_size = throtl_bio_data_size(bio);
 
 	/* no need to throttle if this bio's bytes have been accounted */
-	if (bps_limit == U64_MAX || bio_flagged(bio, BIO_THROTTLED)) {
+	if (bps_limit == U64_MAX) {
 		if (wait)
 			*wait = 0;
 		return true;
@@ -921,11 +921,8 @@ static void throtl_charge_bio(struct throtl_grp *tg, struct bio *bio)
 	unsigned int bio_size = throtl_bio_data_size(bio);
 
 	/* Charge the bio to the group */
-	if (!bio_flagged(bio, BIO_THROTTLED)) {
-		tg->bytes_disp[rw] += bio_size;
-		tg->last_bytes_disp[rw] += bio_size;
-	}
-
+	tg->bytes_disp[rw] += bio_size;
+	tg->last_bytes_disp[rw] += bio_size;
 	tg->io_disp[rw]++;
 	tg->last_io_disp[rw]++;
 
@@ -2121,6 +2118,21 @@ bool __blk_throtl_bio(struct bio *bio)
 			tg->last_low_overflow_time[rw] = jiffies;
 		throtl_downgrade_check(tg);
 		throtl_upgrade_check(tg);
+
+		/*
+		 * re-entered bio has accounted bytes already, so try to
+		 * compensate previous over-accounting. However, if new
+		 * slice is started, just forget it.
+		 */
+		if (bio_flagged(bio, BIO_THROTTLED)) {
+			unsigned int bio_size = throtl_bio_data_size(bio);
+
+			if (tg->bytes_disp[rw] >= bio_size)
+				tg->bytes_disp[rw] -= bio_size;
+			if (tg->last_bytes_disp[rw] > bio_size)
+				tg->last_bytes_disp[rw] -= bio_size;
+		}
+
 		/* throtl is FIFO - if bios are already queued, should queue */
 		if (sq->nr_queued[rw])
 			break;
-- 
2.31.1

