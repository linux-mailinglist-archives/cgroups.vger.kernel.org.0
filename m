Return-Path: <cgroups+bounces-9736-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A67D4B44F27
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 09:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE79EAA18EB
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 07:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B192FC881;
	Fri,  5 Sep 2025 07:16:12 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C462F8BC3;
	Fri,  5 Sep 2025 07:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757056572; cv=none; b=GmpzeyYZPln+cnNXurJ1TPJA//KBZmhXqXcHPXwDhSyLwgH6/6fOS4tGHeKJ4VFugvF4Xh18mKHWzyAjqNhPffCSoJCpHgHYa7pcoAhSsQ5t7wiygW5fN5tIrqkMlaznIqHC0iPuVycIAo2MaYvb72PJtA4U4qvNUuWg/+KYmgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757056572; c=relaxed/simple;
	bh=qleFEQn6SYWCK8leKmPVLb1YXdX1XI0KjF+1+V4lqTU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eYUZPM/oLh2bZILCdbRU6r/OMZdcyJFA6hLbJ6c9Zfs2OeeMY8nfqOUXjib4RKFMKFDNYhxT7WQCvaHuBxIOGVQyBHU/jryRocf4U6LbQANa8pTPQY22xI9oYepho4N161qJmYZe8grWxc9AdRqq20hCk6NUp+ALm7wB0MksK8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cJ71P5nchzYQv7n;
	Fri,  5 Sep 2025 15:16:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 4D0191A19BB;
	Fri,  5 Sep 2025 15:16:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAncIwkjrpowYbQBQ--.23573S19;
	Fri, 05 Sep 2025 15:16:03 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: hch@infradead.org,
	colyli@kernel.org,
	hare@suse.de,
	dlemoal@kernel.org,
	tieren@fnnas.com,
	bvanassche@acm.org,
	axboe@kernel.dk,
	tj@kernel.org,
	josef@toxicpanda.com,
	song@kernel.org,
	yukuai3@huawei.com,
	satyat@google.com,
	ebiggers@google.com,
	kmo@daterainc.com,
	akpm@linux-foundation.org,
	neil@brown.name
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-raid@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH for-6.18/block 15/16] block: fix reordered IO in the case recursive split
Date: Fri,  5 Sep 2025 15:06:42 +0800
Message-Id: <20250905070643.2533483-16-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250905070643.2533483-1-yukuai1@huaweicloud.com>
References: <20250905070643.2533483-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAncIwkjrpowYbQBQ--.23573S19
X-Coremail-Antispam: 1UD129KBjvJXoW3Ary7Kw1UJF48tFyfAry5urg_yoW3XrW7pr
	W7Kw15CrsFgF47Xr4kJFW29F1fta4DCr4rGay5C3yfAFsY9rnFq3ZrAa40ya95ArWrWrW5
	Z3WkKr9Fgw4I9a7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7
	AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wr
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x
	07jIPfQUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Currently, split bio will be chained to original bio, and original bio
will be resubmitted to the tail of current->bio_list, waiting for
split bio to be issued. However, if split bio get split again, the IO
order will be messed up. This problem, on the one hand, will cause
performance degradation, especially for mdraid will large IO size; on
the other hand, will cause write errors for zoned block devices[1].

For example, in raid456 IO will first be split by max_sector from
md_submit_bio(), and then later be split again by chunksize for internal
handling:

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

[1] https://lore.kernel.org/all/e40b076d-583d-406b-b223-005910a9f46f@acm.org/
Fixes: d89d87965dcb ("When stacked block devices are in-use (e.g. md or dm), the recursive calls")
Reported-by: Tie Ren <tieren@fnnas.com>
Closes: https://lore.kernel.org/all/7dro5o7u5t64d6bgiansesjavxcuvkq5p2pok7dtwkav7b7ape@3isfr44b6352/
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-core.c     | 16 ++++++++++------
 block/blk-merge.c    |  2 +-
 block/blk-throttle.c |  2 +-
 block/blk.h          |  2 +-
 4 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 1021a09c5958..dd39ff651095 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -725,7 +725,7 @@ static void __submit_bio_noacct_mq(struct bio *bio)
 	current->bio_list = NULL;
 }
 
-void submit_bio_noacct_nocheck(struct bio *bio)
+void submit_bio_noacct_nocheck(struct bio *bio, bool split)
 {
 	blk_cgroup_bio_start(bio);
 
@@ -744,12 +744,16 @@ void submit_bio_noacct_nocheck(struct bio *bio)
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
@@ -870,7 +874,7 @@ void submit_bio_noacct(struct bio *bio)
 
 	if (blk_throtl_bio(bio))
 		return;
-	submit_bio_noacct_nocheck(bio);
+	submit_bio_noacct_nocheck(bio, false);
 	return;
 
 not_supported:
diff --git a/block/blk-merge.c b/block/blk-merge.c
index c411045fcf03..77488f11a944 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -134,7 +134,7 @@ struct bio *bio_submit_split_bioset(struct bio *bio, unsigned int split_sectors,
 	if (should_fail_bio(bio))
 		bio_io_error(bio);
 	else if (!blk_throtl_bio(bio))
-		submit_bio_noacct_nocheck(bio);
+		submit_bio_noacct_nocheck(bio, true);
 
 	return split;
 }
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
index 18cc3c2afdd4..d9efc8693aa4 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -54,7 +54,7 @@ bool blk_queue_start_drain(struct request_queue *q);
 bool __blk_freeze_queue_start(struct request_queue *q,
 			      struct task_struct *owner);
 int __bio_queue_enter(struct request_queue *q, struct bio *bio);
-void submit_bio_noacct_nocheck(struct bio *bio);
+void submit_bio_noacct_nocheck(struct bio *bio, bool split);
 void bio_await_chain(struct bio *bio);
 
 static inline bool blk_try_enter_queue(struct request_queue *q, bool pm)
-- 
2.39.2


