Return-Path: <cgroups+bounces-14457-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMkwLR8voWnbqwQAu9opvQ
	(envelope-from <cgroups+bounces-14457-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 06:43:59 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE0A1B2F4D
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 06:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65CCD3083384
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 05:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E57A3DA7E9;
	Fri, 27 Feb 2026 05:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QZiHFZH/"
X-Original-To: cgroups@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD58333725;
	Fri, 27 Feb 2026 05:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772170980; cv=none; b=jdwliek1ewMccgM9CgYbsIDww6mbn1gSKQXXUu1CQWqRsHhZgItnoV65hmJWXMMarSOX4ZI1Mtc+ppRzkWvbXSSPtpMKCwWiZc9bPdI9GOIiiuE+ObRNRf8rHpVmp2YjCftQGMXc9BSsn1T2XvGCoE5Djj0aId9oxcoyNy9+3j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772170980; c=relaxed/simple;
	bh=UEFYHfqMWFpDiSnQ2ZxTCTNSUX+TOxmPK4EN9foOkkY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r1qszyLYV29PjzWZlfoks2QDiETcUVKKnhj5Rv2h8pi2ryWwwBDoQTSo1I+N+En/86Myvy6zBKeW8Cesnrqfm2o+9e7+F+mo93v/eGbyaB6YQgKV+w46tNZgNJpKk9dGoY3ax8Z6EEW7ssoXdgeA2s77HSmW5Oikn/a59YY72Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QZiHFZH/; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=3P
	V+nFQl72KJIa+ap8G2QRJx7vnWLumEZixOEyBdyH4=; b=QZiHFZH/nJwoGVezg2
	Jc40EX6AD7MmmYuL3z0mT8Ralhtk7rARLwtLodMTgpAZcYQB13WE0oy1KWkThqly
	BQzU+Lhdm7Ssydu8++48Dr5bSuDkTHG3EkHiqW0J9qSUc1PoNjgH6TRKFoete5Cs
	LWtzCn20QA7XlS3hSsPPv1mgs=
Received: from pek-lpg-core5.wrs.com (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgD3H+q_LqFpzaxOTQ--.788S2;
	Fri, 27 Feb 2026 13:42:24 +0800 (CST)
From: Robert Garcia <rob_garcia@163.com>
To: stable@vger.kernel.org,
	Han Guangjiang <hanguangjiang@lixiang.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Robert Garcia <rob_garcia@163.com>,
	Liang Jie <liangjie@lixiang.com>,
	Yu Kuai <yukuai3@huawei.com>,
	Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.12.y] blk-throttle: fix access race during throttle policy activation
Date: Fri, 27 Feb 2026 13:42:23 +0800
Message-Id: <20260227054223.1552598-1-rob_garcia@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgD3H+q_LqFpzaxOTQ--.788S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxtF4rCr1DWF4DJrWxuF1UGFg_yoWxJr45pr
	W3WF15Kr4vqFsrWF45Jw43XFWrKw4kAay5G393J3yayF4j9w18t3WrAry8ArW8AFs3GF43
	Ar4Dtr40kF1UCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UxnYwUUUUU=
X-CM-SenderInfo: 5uresw5dufxti6rwjhhfrp/xtbDAQB+6WmhLsC-HAAA3T
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14457-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.dk,163.com,lixiang.com,huawei.com,kernel.org,toxicpanda.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rob_garcia@163.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email,lixiang.com:email]
X-Rspamd-Queue-Id: EEE0A1B2F4D
X-Rspamd-Action: no action

From: Han Guangjiang <hanguangjiang@lixiang.com>

[ Upstream commit bd9fd5be6bc0836820500f68fff144609fbd85a9 ]

On repeated cold boots we occasionally hit a NULL pointer crash in
blk_should_throtl() when throttling is consulted before the throttle
policy is fully enabled for the queue. Checking only q->td != NULL is
insufficient during early initialization, so blkg_to_pd() for the
throttle policy can still return NULL and blkg_to_tg() becomes NULL,
which later gets dereferenced.

 Unable to handle kernel NULL pointer dereference
 at virtual address 0000000000000156
 ...
 pc : submit_bio_noacct+0x14c/0x4c8
 lr : submit_bio_noacct+0x48/0x4c8
 sp : ffff800087f0b690
 x29: ffff800087f0b690 x28: 0000000000005f90 x27: ffff00068af393c0
 x26: 0000000000080000 x25: 000000000002fbc0 x24: ffff000684ddcc70
 x23: 0000000000000000 x22: 0000000000000000 x21: 0000000000000000
 x20: 0000000000080000 x19: ffff000684ddcd08 x18: ffffffffffffffff
 x17: 0000000000000000 x16: ffff80008132a550 x15: 0000ffff98020fff
 x14: 0000000000000000 x13: 1fffe000d11d7021 x12: ffff000688eb810c
 x11: ffff00077ec4bb80 x10: ffff000688dcb720 x9 : ffff80008068ef60
 x8 : 00000a6fb8a86e85 x7 : 000000000000111e x6 : 0000000000000002
 x5 : 0000000000000246 x4 : 0000000000015cff x3 : 0000000000394500
 x2 : ffff000682e35e40 x1 : 0000000000364940 x0 : 000000000000001a
 Call trace:
  submit_bio_noacct+0x14c/0x4c8
  verity_map+0x178/0x2c8
  __map_bio+0x228/0x250
  dm_submit_bio+0x1c4/0x678
  __submit_bio+0x170/0x230
  submit_bio_noacct_nocheck+0x16c/0x388
  submit_bio_noacct+0x16c/0x4c8
  submit_bio+0xb4/0x210
  f2fs_submit_read_bio+0x4c/0xf0
  f2fs_mpage_readpages+0x3b0/0x5f0
  f2fs_readahead+0x90/0xe8

Tighten blk_throtl_activated() to also require that the throttle policy
bit is set on the queue:

  return q->td != NULL &&
         test_bit(blkcg_policy_throtl.plid, q->blkcg_pols);

This prevents blk_should_throtl() from accessing throttle group state
until policy data has been attached to blkgs.

Fixes: a3166c51702b ("blk-throttle: delay initialization until configuration")
Co-developed-by: Liang Jie <liangjie@lixiang.com>
Signed-off-by: Liang Jie <liangjie@lixiang.com>
Signed-off-by: Han Guangjiang <hanguangjiang@lixiang.com>
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Robert Garcia <rob_garcia@163.com>
---
 block/blk-cgroup.c   |  6 ------
 block/blk-cgroup.h   |  6 ++++++
 block/blk-throttle.c |  6 +-----
 block/blk-throttle.h | 18 +++++++++++-------
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 5a5525d10a5e..3f7cb9d891aa 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -110,12 +110,6 @@ static struct cgroup_subsys_state *blkcg_css(void)
 	return task_css(current, io_cgrp_id);
 }
 
-static bool blkcg_policy_enabled(struct request_queue *q,
-				 const struct blkcg_policy *pol)
-{
-	return pol && test_bit(pol->plid, q->blkcg_pols);
-}
-
 static void blkg_free_workfn(struct work_struct *work)
 {
 	struct blkcg_gq *blkg = container_of(work, struct blkcg_gq,
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index b9e3265c1eb3..112bf11d0fad 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -455,6 +455,12 @@ static inline bool blk_cgroup_mergeable(struct request *rq, struct bio *bio)
 		bio_issue_as_root_blkg(rq->bio) == bio_issue_as_root_blkg(bio);
 }
 
+static inline bool blkcg_policy_enabled(struct request_queue *q,
+				const struct blkcg_policy *pol)
+{
+	return pol && test_bit(pol->plid, q->blkcg_pols);
+}
+
 void blk_cgroup_bio_start(struct bio *bio);
 void blkcg_add_delay(struct blkcg_gq *blkg, u64 now, u64 delta);
 #else	/* CONFIG_BLK_CGROUP */
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 4aa66c07d2e8..bdf363868ac0 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1209,17 +1209,13 @@ static int blk_throtl_init(struct gendisk *disk)
 	INIT_WORK(&td->dispatch_work, blk_throtl_dispatch_work_fn);
 	throtl_service_queue_init(&td->service_queue);
 
-	/*
-	 * Freeze queue before activating policy, to synchronize with IO path,
-	 * which is protected by 'q_usage_counter'.
-	 */
 	blk_mq_freeze_queue(disk->queue);
 	blk_mq_quiesce_queue(disk->queue);
 
 	q->td = td;
 	td->queue = q;
 
-	/* activate policy */
+	/* activate policy, blk_throtl_activated() will return true */
 	ret = blkcg_activate_policy(disk, &blkcg_policy_throtl);
 	if (ret) {
 		q->td = NULL;
diff --git a/block/blk-throttle.h b/block/blk-throttle.h
index 1a36d1278eea..e1b5343cd43f 100644
--- a/block/blk-throttle.h
+++ b/block/blk-throttle.h
@@ -154,7 +154,13 @@ void blk_throtl_cancel_bios(struct gendisk *disk);
 
 static inline bool blk_throtl_activated(struct request_queue *q)
 {
-	return q->td != NULL;
+	/*
+	 * q->td guarantees that the blk-throttle module is already loaded,
+	 * and the plid of blk-throttle is assigned.
+	 * blkcg_policy_enabled() guarantees that the policy is activated
+	 * in the request_queue.
+	 */
+	return q->td != NULL && blkcg_policy_enabled(q, &blkcg_policy_throtl);
 }
 
 static inline bool blk_should_throtl(struct bio *bio)
@@ -162,11 +168,6 @@ static inline bool blk_should_throtl(struct bio *bio)
 	struct throtl_grp *tg;
 	int rw = bio_data_dir(bio);
 
-	/*
-	 * This is called under bio_queue_enter(), and it's synchronized with
-	 * the activation of blk-throtl, which is protected by
-	 * blk_mq_freeze_queue().
-	 */
 	if (!blk_throtl_activated(bio->bi_bdev->bd_queue))
 		return false;
 
@@ -192,7 +193,10 @@ static inline bool blk_should_throtl(struct bio *bio)
 
 static inline bool blk_throtl_bio(struct bio *bio)
 {
-
+	/*
+	 * block throttling takes effect if the policy is activated
+	 * in the bio's request_queue.
+	 */
 	if (!blk_should_throtl(bio))
 		return false;
 
-- 
2.34.1


