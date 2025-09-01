Return-Path: <cgroups+bounces-9527-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 749E3B3D795
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 05:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 826D216B9C1
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 03:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92186236453;
	Mon,  1 Sep 2025 03:41:20 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFF71D86D6;
	Mon,  1 Sep 2025 03:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756698080; cv=none; b=R+FUdpOTze7IhEpBj9K0pODjRCrU0Fg63HKaKBAAiNQQmrLr9R5pVSU9zn4rhe+gSoFzdfpXhpLdUj8utOXekh96c7EEBUSYNP+H9IZObw6aFtzHK/c71Q4Sa9icpaTsMCoPKDkPlFd97P1L/2cvuOxMRFlUq3N7OEK0Dd4FAHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756698080; c=relaxed/simple;
	bh=K03xm8emqUDdQ2Z/2v0DO7MbLus3XmLP4QvPyM5H3mA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C/W0C2jLbDJ+5QS56QdHkEcnT0Ily46MI+RW7fCOv8hkfzRYrPpDRAM3ukJx0LkbDKH1aA0K2GlY6lAvTyrttPWU5tRh6wAYFjGjvOuZzUPzYPmr9aK7ucicWCCujzcet8W5Aknb0l8/6AToS2bTkzvWj5j1g7Ghh3GjB8w84i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cFZRH4lsszYQvDd;
	Mon,  1 Sep 2025 11:41:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 29A2A1A0B1B;
	Mon,  1 Sep 2025 11:41:14 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAncIzWFbVotmf1Aw--.38057S5;
	Mon, 01 Sep 2025 11:41:13 +0800 (CST)
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
Subject: [PATCH RFC v3 01/15] block: cleanup bio_issue
Date: Mon,  1 Sep 2025 11:32:06 +0800
Message-Id: <20250901033220.42982-2-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgAncIzWFbVotmf1Aw--.38057S5
X-Coremail-Antispam: 1UD129KBjvJXoW3WFWkZrWfGF4ftr13uF4Uurg_yoW7GF48pr
	4fJr93Gr93tFsrWr4kta1DA34rGrs5Cry3G398uwsaya1I9ryxJF1kZF40qFykCFZ5CFZ8
	XF18t3yYkw4Yk3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JUU9N3UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Now that bio->bi_issue is only used by io-latency to get bio issue time,
replace bio_issue with u64 time directly and remove bio_issue to make
code cleaner.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bio.c               |  2 +-
 block/blk-cgroup.h        |  2 +-
 block/blk-iolatency.c     | 14 +++----------
 block/blk.h               | 42 ---------------------------------------
 include/linux/blk_types.h |  7 ++-----
 5 files changed, 7 insertions(+), 60 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 44c43b970387..c8fce0d6e332 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -261,7 +261,7 @@ void bio_init(struct bio *bio, struct block_device *bdev, struct bio_vec *table,
 	bio->bi_private = NULL;
 #ifdef CONFIG_BLK_CGROUP
 	bio->bi_blkg = NULL;
-	bio->bi_issue.value = 0;
+	bio->issue_time_ns = 0;
 	if (bdev)
 		bio_associate_blkg(bio);
 #ifdef CONFIG_BLK_CGROUP_IOCOST
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index 81868ad86330..d73204d27d72 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -372,7 +372,7 @@ static inline void blkg_put(struct blkcg_gq *blkg)
 
 static inline void blkcg_bio_issue_init(struct bio *bio)
 {
-	bio_issue_init(&bio->bi_issue, bio_sectors(bio));
+	bio->issue_time_ns = blk_time_get_ns();
 }
 
 static inline void blkcg_use_delay(struct blkcg_gq *blkg)
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 2f8fdecdd7a9..554b191a6892 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -485,19 +485,11 @@ static void blkcg_iolatency_throttle(struct rq_qos *rqos, struct bio *bio)
 		mod_timer(&blkiolat->timer, jiffies + HZ);
 }
 
-static void iolatency_record_time(struct iolatency_grp *iolat,
-				  struct bio_issue *issue, u64 now,
-				  bool issue_as_root)
+static void iolatency_record_time(struct iolatency_grp *iolat, u64 start,
+				  u64 now, bool issue_as_root)
 {
-	u64 start = bio_issue_time(issue);
 	u64 req_time;
 
-	/*
-	 * Have to do this so we are truncated to the correct time that our
-	 * issue is truncated to.
-	 */
-	now = __bio_issue_time(now);
-
 	if (now <= start)
 		return;
 
@@ -625,7 +617,7 @@ static void blkcg_iolatency_done_bio(struct rq_qos *rqos, struct bio *bio)
 		 * submitted, so do not account for it.
 		 */
 		if (iolat->min_lat_nsec && bio->bi_status != BLK_STS_AGAIN) {
-			iolatency_record_time(iolat, &bio->bi_issue, now,
+			iolatency_record_time(iolat, bio->issue_time_ns, now,
 					      issue_as_root);
 			window_start = atomic64_read(&iolat->window_start);
 			if (now > window_start &&
diff --git a/block/blk.h b/block/blk.h
index 46f566f9b126..0268deb22268 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -680,48 +680,6 @@ static inline ktime_t blk_time_get(void)
 	return ns_to_ktime(blk_time_get_ns());
 }
 
-/*
- * From most significant bit:
- * 1 bit: reserved for other usage, see below
- * 12 bits: original size of bio
- * 51 bits: issue time of bio
- */
-#define BIO_ISSUE_RES_BITS      1
-#define BIO_ISSUE_SIZE_BITS     12
-#define BIO_ISSUE_RES_SHIFT     (64 - BIO_ISSUE_RES_BITS)
-#define BIO_ISSUE_SIZE_SHIFT    (BIO_ISSUE_RES_SHIFT - BIO_ISSUE_SIZE_BITS)
-#define BIO_ISSUE_TIME_MASK     ((1ULL << BIO_ISSUE_SIZE_SHIFT) - 1)
-#define BIO_ISSUE_SIZE_MASK     \
-	(((1ULL << BIO_ISSUE_SIZE_BITS) - 1) << BIO_ISSUE_SIZE_SHIFT)
-#define BIO_ISSUE_RES_MASK      (~((1ULL << BIO_ISSUE_RES_SHIFT) - 1))
-
-/* Reserved bit for blk-throtl */
-#define BIO_ISSUE_THROTL_SKIP_LATENCY (1ULL << 63)
-
-static inline u64 __bio_issue_time(u64 time)
-{
-	return time & BIO_ISSUE_TIME_MASK;
-}
-
-static inline u64 bio_issue_time(struct bio_issue *issue)
-{
-	return __bio_issue_time(issue->value);
-}
-
-static inline sector_t bio_issue_size(struct bio_issue *issue)
-{
-	return ((issue->value & BIO_ISSUE_SIZE_MASK) >> BIO_ISSUE_SIZE_SHIFT);
-}
-
-static inline void bio_issue_init(struct bio_issue *issue,
-				       sector_t size)
-{
-	size &= (1ULL << BIO_ISSUE_SIZE_BITS) - 1;
-	issue->value = ((issue->value & BIO_ISSUE_RES_MASK) |
-			(blk_time_get_ns() & BIO_ISSUE_TIME_MASK) |
-			((u64)size << BIO_ISSUE_SIZE_SHIFT));
-}
-
 void bdev_release(struct file *bdev_file);
 int bdev_open(struct block_device *bdev, blk_mode_t mode, void *holder,
 	      const struct blk_holder_ops *hops, struct file *bdev_file);
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 930daff207df..b8be751e16fc 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -198,10 +198,6 @@ static inline bool blk_path_error(blk_status_t error)
 	return true;
 }
 
-struct bio_issue {
-	u64 value;
-};
-
 typedef __u32 __bitwise blk_opf_t;
 
 typedef unsigned int blk_qc_t;
@@ -242,7 +238,8 @@ struct bio {
 	 * on release of the bio.
 	 */
 	struct blkcg_gq		*bi_blkg;
-	struct bio_issue	bi_issue;
+	/* Time that this bio was issued. */
+	u64			issue_time_ns;
 #ifdef CONFIG_BLK_CGROUP_IOCOST
 	u64			bi_iocost_cost;
 #endif
-- 
2.39.2


