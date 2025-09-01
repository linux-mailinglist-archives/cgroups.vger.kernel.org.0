Return-Path: <cgroups+bounces-9538-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CDCB3D7C3
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 05:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F6BD3BE05D
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 03:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A5621CC47;
	Mon,  1 Sep 2025 03:41:30 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FBC272E54;
	Mon,  1 Sep 2025 03:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756698090; cv=none; b=QLw8kS64vxzcmdelwb1+S5EvPr98ODVdNDkm50jm/CudB7vnjenOdeVtAfbh2ZZ/xWRZ0QsNWQS3CtdaYJBu9ds2kqGEuTJHB0vKpRFqLjmoHI1h2C6ov63Hg+OsPKFDI9ADOCPyf1CuLioCO+a0ltmyxGIETXiy0HdLfQOo8tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756698090; c=relaxed/simple;
	bh=6Js8xUDCsiCrU0WAd+jMh68/VDp7mtMXprOynREbPG0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DowEjfXHWyFapsiNRDpknjm/WnhTm+bWdlvo/H2kUJh/TXgLpw3z1naEu6JlH0o+dzQMgWiU9WV9/xgprONhDcmEM3j9AKeCaVHfW2iLewopcTVvClshvgxsqcrdyTxrl3ACE/COT6BeHLohITL2V1+bDZCY+mWnSWuwoaNHXD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cFZRV69nZzKHMdm;
	Mon,  1 Sep 2025 11:41:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A36FB1A0FE6;
	Mon,  1 Sep 2025 11:41:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAncIzWFbVotmf1Aw--.38057S18;
	Mon, 01 Sep 2025 11:41:24 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: hch@infradead.org,
	colyli@kernel.org,
	hare@suse.de,
	dlemoal@kernel.org,
	tieren@fnnas.com,
	axboe@kernel.dk,
	tj@kernel.org,
	josef@toxicpanda.com,
	song@kernel.org,
	kmo@daterainc.com,
	satyat@google.com,
	ebiggers@google.com,
	neil@brown.name,
	akpm@linux-foundation.org
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-raid@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH RFC v3 14/15] block: fix disordered IO in the case recursive split
Date: Mon,  1 Sep 2025 11:32:19 +0800
Message-Id: <20250901033220.42982-15-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250901033220.42982-1-yukuai1@huaweicloud.com>
References: <20250901033220.42982-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAncIzWFbVotmf1Aw--.38057S18
X-Coremail-Antispam: 1UD129KBjvJXoW3AryrZr13CF1UGryrCrWfKrg_yoW3JF1xpr
	4UKw1Ykr4DKF47Gw4DJF4293WftFykCr45CFW5C3y3AFsYvrnFq3W7Aa40ya98ArW8WrW5
	A3WkKrnF9w42va7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUma14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6r
	xdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsG
	vfC2KfnxnUUI43ZEXa7sRRtCztUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Currently, split bio will be chained to original bio, and original bio
will be resubmitted to the tail of current->bio_list, waiting for
split bio to be issued. However, if split bio get split again, the IO
order will be messed up, for example, in raid456 IO will first be
split by max_sector from md_submit_bio(), and then later be split
again by chunksize for internal handling:

For example, assume max_sectors is 1M, and chunksize is 512k

1) issue a 2M IO:

bio issuing: 0+2M
current->bio_list: NULL

2) md_submit_bio() split by max_sector:

bio issuing: 0+1M
current->bio_list: 1M+1M

3) chunk_aligned_read() split by chunksize:

bio issuing: 0+512k
current->bio_list: 1M+1M -> 512k+512k

4) after first bio issued, __submit_bio_noacct() will contuine issuing
next bio:

bio issuing: 1M+1M
current->bio_list: 512k+512k
bio issued: 0+512k

5) chunk_aligned_read() split by chunksize:

bio issuing: 1M+512k
current->bio_list: 512k+512k -> 1536k+512k
bio issued: 0+512k

6) no split afterwards, finally the issue order is:

0+512k -> 1M+512k -> 512k+512k -> 1536k+512k

This behaviour will cause large IO read on raid456 endup to be small
discontinuous IO in underlying disks. Fix this problem by placing split
bio to the head of current->bio_list.

Test script: test on 8 disk raid5 with 64k chunksize
dd if=/dev/md0 of=/dev/null bs=4480k iflag=direct

Test results:
Before this patch
1) iostat results:
Device            r/s     rMB/s   rrqm/s  %rrqm r_await rareq-sz  aqu-sz  %util
md0           52430.00   3276.87     0.00   0.00    0.62    64.00   32.60  80.10
sd*           4487.00    409.00  2054.00  31.40    0.82    93.34    3.68  71.20
2) blktrace G stage:
  8,0    0   486445    11.357392936   843  G   R 14071424 + 128 [dd]
  8,0    0   486451    11.357466360   843  G   R 14071168 + 128 [dd]
  8,0    0   486454    11.357515868   843  G   R 14071296 + 128 [dd]
  8,0    0   486468    11.357968099   843  G   R 14072192 + 128 [dd]
  8,0    0   486474    11.358031320   843  G   R 14071936 + 128 [dd]
  8,0    0   486480    11.358096298   843  G   R 14071552 + 128 [dd]
  8,0    0   486490    11.358303858   843  G   R 14071808 + 128 [dd]
3) io seek for sdx:
Noted io seek is the result from blktrace D stage, statistic of:
ABS((offset of next IO) - (offset + len of previous IO))

Read|Write seek
cnt 55175, zero cnt 25079
    >=(KB) .. <(KB)     : count       ratio |distribution                            |
         0 .. 1         : 25079       45.5% |########################################|
         1 .. 2         : 0            0.0% |                                        |
         2 .. 4         : 0            0.0% |                                        |
         4 .. 8         : 0            0.0% |                                        |
         8 .. 16        : 0            0.0% |                                        |
        16 .. 32        : 0            0.0% |                                        |
        32 .. 64        : 12540       22.7% |#####################                   |
        64 .. 128       : 2508         4.5% |#####                                   |
       128 .. 256       : 0            0.0% |                                        |
       256 .. 512       : 10032       18.2% |#################                       |
       512 .. 1024      : 5016         9.1% |#########                               |

After this patch:
1) iostat results:
Device            r/s     rMB/s   rrqm/s  %rrqm r_await rareq-sz  aqu-sz  %util
md0           87965.00   5271.88     0.00   0.00    0.16    61.37   14.03  90.60
sd*           6020.00    658.44  5117.00  45.95    0.44   112.00    2.68  86.50
2) blktrace G stage:
  8,0    0   206296     5.354894072   664  G   R 7156992 + 128 [dd]
  8,0    0   206305     5.355018179   664  G   R 7157248 + 128 [dd]
  8,0    0   206316     5.355204438   664  G   R 7157504 + 128 [dd]
  8,0    0   206319     5.355241048   664  G   R 7157760 + 128 [dd]
  8,0    0   206333     5.355500923   664  G   R 7158016 + 128 [dd]
  8,0    0   206344     5.355837806   664  G   R 7158272 + 128 [dd]
  8,0    0   206353     5.355960395   664  G   R 7158528 + 128 [dd]
  8,0    0   206357     5.356020772   664  G   R 7158784 + 128 [dd]
3) io seek for sdx
Read|Write seek
cnt 28644, zero cnt 21483
    >=(KB) .. <(KB)     : count       ratio |distribution                            |
         0 .. 1         : 21483       75.0% |########################################|
         1 .. 2         : 0            0.0% |                                        |
         2 .. 4         : 0            0.0% |                                        |
         4 .. 8         : 0            0.0% |                                        |
         8 .. 16        : 0            0.0% |                                        |
        16 .. 32        : 0            0.0% |                                        |
        32 .. 64        : 7161        25.0% |##############                          |

BTW, this looks like a long term problem from day one, and large
sequential IO read is pretty common case like video playing.

And even with this patch, in this test case IO is merged to at most 128k
is due to block layer plug limit BLK_PLUG_FLUSH_SIZE, increase such
limit can get even better performance. However, we'll figure out how to do
this properly later.

Fixes: d89d87965dcb ("When stacked block devices are in-use (e.g. md or dm), the recursive calls")
Reported-by: Tie Ren <tieren@fnnas.com>
Closes: https://lore.kernel.org/all/7dro5o7u5t64d6bgiansesjavxcuvkq5p2pok7dtwkav7b7ape@3isfr44b6352/
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-core.c     | 21 ++++++++++++++-------
 block/blk-throttle.c |  2 +-
 block/blk.h          |  2 +-
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index ea194a1a5b2c..6ca3c45f421c 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -725,7 +725,7 @@ static void __submit_bio_noacct_mq(struct bio *bio)
 	current->bio_list = NULL;
 }
 
-void submit_bio_noacct_nocheck(struct bio *bio)
+void submit_bio_noacct_nocheck(struct bio *bio, bool split)
 {
 	blk_cgroup_bio_start(bio);
 	blkcg_bio_issue_init(bio);
@@ -745,12 +745,16 @@ void submit_bio_noacct_nocheck(struct bio *bio)
 	 * to collect a list of requests submited by a ->submit_bio method while
 	 * it is active, and then process them after it returned.
 	 */
-	if (current->bio_list)
-		bio_list_add(&current->bio_list[0], bio);
-	else if (!bdev_test_flag(bio->bi_bdev, BD_HAS_SUBMIT_BIO))
+	if (current->bio_list) {
+		if (split && !bdev_is_zoned(bio->bi_bdev))
+			bio_list_add_head(&current->bio_list[0], bio);
+		else
+			bio_list_add(&current->bio_list[0], bio);
+	} else if (!bdev_test_flag(bio->bi_bdev, BD_HAS_SUBMIT_BIO)) {
 		__submit_bio_noacct_mq(bio);
-	else
+	} else {
 		__submit_bio_noacct(bio);
+	}
 }
 
 static blk_status_t blk_validate_atomic_write_op_size(struct request_queue *q,
@@ -770,6 +774,9 @@ void submit_split_bio_noacct(struct bio *bio)
 {
 	might_sleep();
 
+	/* This helper should only be called from submit_bio context */
+	WARN_ON_ONCE(!current->bio_list);
+
 	if (should_fail_bio(bio)) {
 		bio_io_error(bio);
 		return;
@@ -778,7 +785,7 @@ void submit_split_bio_noacct(struct bio *bio)
 	if (blk_throtl_bio(bio))
 		return;
 
-	submit_bio_noacct_nocheck(bio);
+	submit_bio_noacct_nocheck(bio, true);
 }
 
 /**
@@ -887,7 +894,7 @@ void submit_bio_noacct(struct bio *bio)
 
 	if (blk_throtl_bio(bio))
 		return;
-	submit_bio_noacct_nocheck(bio);
+	submit_bio_noacct_nocheck(bio, false);
 	return;
 
 not_supported:
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 397b6a410f9e..ead7b0eb4846 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1224,7 +1224,7 @@ static void blk_throtl_dispatch_work_fn(struct work_struct *work)
 	if (!bio_list_empty(&bio_list_on_stack)) {
 		blk_start_plug(&plug);
 		while ((bio = bio_list_pop(&bio_list_on_stack)))
-			submit_bio_noacct_nocheck(bio);
+			submit_bio_noacct_nocheck(bio, false);
 		blk_finish_plug(&plug);
 	}
 }
diff --git a/block/blk.h b/block/blk.h
index 68bf637ab7ca..a7207eea7a84 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -55,7 +55,7 @@ bool __blk_freeze_queue_start(struct request_queue *q,
 			      struct task_struct *owner);
 int __bio_queue_enter(struct request_queue *q, struct bio *bio);
 void submit_split_bio_noacct(struct bio *bio);
-void submit_bio_noacct_nocheck(struct bio *bio);
+void submit_bio_noacct_nocheck(struct bio *bio, bool split);
 void bio_await_chain(struct bio *bio);
 
 static inline bool blk_try_enter_queue(struct request_queue *q, bool pm)
-- 
2.39.2


