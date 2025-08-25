Return-Path: <cgroups+bounces-9375-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF72B33B83
	for <lists+cgroups@lfdr.de>; Mon, 25 Aug 2025 11:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45637486600
	for <lists+cgroups@lfdr.de>; Mon, 25 Aug 2025 09:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D202D6625;
	Mon, 25 Aug 2025 09:45:37 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0619A2D29CE;
	Mon, 25 Aug 2025 09:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756115137; cv=none; b=IUzeGOCitqrU6w5svB1lTDlY0OlFTtNwD+VqeGF4xUOxvyJM9rvBgdvvugeWiquPB26FaN6CoczhZvTnYJBRHfChe4c05I3lngizdSE9ZcP68ukCMx5MwYI+qONpjhHAf8aJCVbMcAOuo7WfgXNspzad2xEjHoUXyAmYh2Wh03A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756115137; c=relaxed/simple;
	bh=/NBSlyyO/P3lBhNkPHs4fzj3VCj2TiugBxOZZh4+1oM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NziQtVNs3/vWk4Z++7/KB7K7PN1XnW2HfKRCxMc+25fJq2BrPZR37HiUP/B7aFHpKtx5CkdyszsJYzCEHY3wBy054Oq9qCz4f0VCOpDfdcWVz6zdcqCTpp9cA166BfveNMilUJ366maTFwKENb/ut/Hkau+dUzhAvjlNstr7ALU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c9Qrr2X3fzKHNJ3;
	Mon, 25 Aug 2025 17:45:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E70011A08F9;
	Mon, 25 Aug 2025 17:45:31 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAXYIy1MKxonJnxAA--.44975S11;
	Mon, 25 Aug 2025 17:45:31 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: hch@infradead.org,
	colyli@kernel.org,
	hare@suse.de,
	tieren@fnnas.com,
	axboe@kernel.dk,
	tj@kernel.org,
	josef@toxicpanda.com,
	song@kernel.org,
	yukuai3@huawei.com,
	akpm@linux-foundation.org,
	neil@brown.name
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-raid@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH RFC 7/7] block: fix disordered IO in the case recursive split
Date: Mon, 25 Aug 2025 17:37:00 +0800
Message-Id: <20250825093700.3731633-8-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250825093700.3731633-1-yukuai1@huaweicloud.com>
References: <20250825093700.3731633-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXYIy1MKxonJnxAA--.44975S11
X-Coremail-Antispam: 1UD129KBjvJXoW3AryrZr13CF1UGryrCrWfKrg_yoWfWw47pr
	Wagw1akr4DGF4Sgws7JF4293Wft3WkCr4UCay5C393JFsY9r1Dt3WDAa40vas8ArWrGrWU
	XF1kKry7Ww42va7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0pRiF4iUUUUU=
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
2) io seek for sdx
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
limit and cat get even better performance. However, we'll figure out
how to do this properly later.

Fixes: d89d87965dcb ("When stacked block devices are in-use (e.g. md or dm), the recursive calls")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-core.c     | 54 ++++++++++++++++++++++++++++----------------
 block/blk-merge.c    |  2 +-
 block/blk-throttle.c |  2 +-
 block/blk.h          |  3 ++-
 4 files changed, 39 insertions(+), 22 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 4201504158a1..cfb2179cc91e 100644
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
+		if (split)
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
@@ -765,16 +769,7 @@ static blk_status_t blk_validate_atomic_write_op_size(struct request_queue *q,
 	return BLK_STS_OK;
 }
 
-/**
- * submit_bio_noacct - re-submit a bio to the block device layer for I/O
- * @bio:  The bio describing the location in memory and on the device.
- *
- * This is a version of submit_bio() that shall only be used for I/O that is
- * resubmitted to lower level drivers by stacking block drivers.  All file
- * systems and other upper level users of the block layer should use
- * submit_bio() instead.
- */
-void submit_bio_noacct(struct bio *bio)
+static bool submit_bio_check(struct bio *bio)
 {
 	struct block_device *bdev = bio->bi_bdev;
 	struct request_queue *q = bdev_get_queue(bdev);
@@ -869,19 +864,40 @@ void submit_bio_noacct(struct bio *bio)
 		goto not_supported;
 	}
 
-	if (blk_throtl_bio(bio))
-		return;
-	submit_bio_noacct_nocheck(bio);
-	return;
+	return !blk_throtl_bio(bio);
 
 not_supported:
 	status = BLK_STS_NOTSUPP;
 end_io:
 	bio->bi_status = status;
 	bio_endio(bio);
+	return false;
+}
+
+/**
+ * submit_bio_noacct - re-submit a bio to the block device layer for I/O
+ * @bio:  The bio describing the location in memory and on the device.
+ *
+ * This is a version of submit_bio() that shall only be used for I/O that is
+ * resubmitted to lower level drivers by stacking block drivers.  All file
+ * systems and other upper level users of the block layer should use
+ * submit_bio() instead.
+ */
+void submit_bio_noacct(struct bio *bio)
+{
+	if (submit_bio_check(bio))
+		submit_bio_noacct_nocheck(bio, false);
 }
 EXPORT_SYMBOL(submit_bio_noacct);
 
+void submit_split_bio_noacct(struct bio *bio)
+{
+	WARN_ON_ONCE(!current->bio_list);
+
+	if (submit_bio_check(bio))
+		submit_bio_noacct_nocheck(bio, true);
+}
+
 static void bio_set_ioprio(struct bio *bio)
 {
 	/* Nobody set ioprio so far? Initialize it based on task's nice value */
diff --git a/block/blk-merge.c b/block/blk-merge.c
index c45d5e43e172..934bbafe0462 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -138,7 +138,7 @@ struct bio *bio_submit_split(struct bio *bio, int split_sectors,
 	bio_chain(split, bio);
 	trace_block_split(split, bio->bi_iter.bi_sector);
 	WARN_ON_ONCE(bio_zone_write_plugging(bio));
-	submit_bio_noacct(bio);
+	submit_split_bio_noacct(bio);
 	return split;
 
 error:
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
index 46f566f9b126..d804a49c6313 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -54,7 +54,8 @@ bool blk_queue_start_drain(struct request_queue *q);
 bool __blk_freeze_queue_start(struct request_queue *q,
 			      struct task_struct *owner);
 int __bio_queue_enter(struct request_queue *q, struct bio *bio);
-void submit_bio_noacct_nocheck(struct bio *bio);
+void submit_bio_noacct_nocheck(struct bio *bio, bool split);
+void submit_split_bio_noacct(struct bio *bio);
 void bio_await_chain(struct bio *bio);
 
 static inline bool blk_try_enter_queue(struct request_queue *q, bool pm)
-- 
2.39.2


