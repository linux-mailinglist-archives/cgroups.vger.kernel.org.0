Return-Path: <cgroups+bounces-3304-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31456914E06
	for <lists+cgroups@lfdr.de>; Mon, 24 Jun 2024 15:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CE6CB23C44
	for <lists+cgroups@lfdr.de>; Mon, 24 Jun 2024 13:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECCE13D60E;
	Mon, 24 Jun 2024 13:10:58 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438F613BAFA;
	Mon, 24 Jun 2024 13:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719234658; cv=none; b=imMz4LsgcHLZEQ4a7uhufFLgfPzTlbgNul8yUTE0gjnlI3kNQxbLazHjPlxFL6bBAdNiRg0/A25dxxl4zzg1zHi7tNo/q0BTPqNP2Bd3ft77HI3eDdt5T1Mnxf6Sx0eswXlob6ucKysIAT0kNM8rcfLcMZWAR5lPvZ9rxjri5B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719234658; c=relaxed/simple;
	bh=HtblSTw1nKDAHfs2ii6UyHOamhA9qGV0kkZxWsC7jWY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GmM/wXHtMxHm+J9m4NF8p10ylNO4AEth8nvrpuvrnwtFHAdFQerQclMa8LE8ftxE67nbftjQYhbY6/Va5uRq1Zan7SWmiQjCxtnXk6Q54GhNMCosp3KjpSGhey+Z502ohcYmzmfpeeYGz/qk0d349TjkMp4e+0HQ+8KsrS4m/14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4W77cZ26MHz4f3m78;
	Mon, 24 Jun 2024 21:10:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 5680E1A0572;
	Mon, 24 Jun 2024 21:10:50 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP2 (Coremail) with SMTP id Syh0CgB334RZcHlmcrLaAA--.31654S4;
	Mon, 24 Jun 2024 21:10:50 +0800 (CST)
From: Li Lingfeng <lilingfeng@huaweicloud.com>
To: tj@kernel.org,
	josef@toxicpanda.com,
	hch@lst.de,
	axboe@kernel.dk
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yangerkun@huawei.com,
	yukuai1@huaweicloud.com,
	houtao1@huawei.com,
	yi.zhang@huawei.com,
	lilingfeng@huaweicloud.com,
	lilingfeng3@huawei.com
Subject: [PATCH] block: cancel all throttled bios when deleting the cgroup
Date: Mon, 24 Jun 2024 21:09:40 +0800
Message-Id: <20240624130940.3751791-1-lilingfeng@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgB334RZcHlmcrLaAA--.31654S4
X-Coremail-Antispam: 1UD129KBjvJXoWxWr4xWF47tryrZrWUKr13twb_yoWrJFWxpr
	WfuFyYkw1Utr9I9r4agr4UJFWSq395XrWag397Ga1ayrWIyw1jqF1kZa4rXFWrJF93Cr4a
	vF45tr48WF18W37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	fUF9a9DUUUU
X-CM-SenderInfo: polox0xjih0w46kxt4xhlfz01xgou0bp/

From: Li Lingfeng <lilingfeng3@huawei.com>

When a process migrates to another cgroup and the original cgroup is deleted,
the restrictions of throttled bios cannot be removed. If the restrictions
are set too low, it will take a long time to complete these bios.

Refer to the process of deleting a disk to remove the restrictions and
issue bios when deleting the cgroup.

References:
https://lore.kernel.org/r/20220318130144.1066064-4-ming.lei@redhat.com

Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
---
 block/blk-throttle.c | 68 ++++++++++++++++++++++++++++----------------
 1 file changed, 44 insertions(+), 24 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index c1bf73f8c75d..a0e5b28951ca 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1534,6 +1534,42 @@ static void throtl_shutdown_wq(struct request_queue *q)
 	cancel_work_sync(&td->dispatch_work);
 }
 
+static void tg_cancel_bios(struct throtl_grp *tg)
+{
+	struct throtl_service_queue *sq = &tg->service_queue;
+
+	if (tg->flags & THROTL_TG_CANCELING)
+		return;
+	/*
+	 * Set the flag to make sure throtl_pending_timer_fn() won't
+	 * stop until all throttled bios are dispatched.
+	 */
+	tg->flags |= THROTL_TG_CANCELING;
+
+	/*
+	 * Do not dispatch cgroup without THROTL_TG_PENDING or cgroup
+	 * will be inserted to service queue without THROTL_TG_PENDING
+	 * set in tg_update_disptime below. Then IO dispatched from
+	 * child in tg_dispatch_one_bio will trigger double insertion
+	 * and corrupt the tree.
+	 */
+	if (!(tg->flags & THROTL_TG_PENDING))
+		return;
+
+	/*
+	 * Update disptime after setting the above flag to make sure
+	 * throtl_select_dispatch() won't exit without dispatching.
+	 */
+	tg_update_disptime(tg);
+
+	throtl_schedule_pending_timer(sq, jiffies + 1);
+}
+
+static void throtl_pd_offline(struct blkg_policy_data *pd)
+{
+	tg_cancel_bios(pd_to_tg(pd));
+}
+
 struct blkcg_policy blkcg_policy_throtl = {
 	.dfl_cftypes		= throtl_files,
 	.legacy_cftypes		= throtl_legacy_files,
@@ -1541,6 +1577,7 @@ struct blkcg_policy blkcg_policy_throtl = {
 	.pd_alloc_fn		= throtl_pd_alloc,
 	.pd_init_fn		= throtl_pd_init,
 	.pd_online_fn		= throtl_pd_online,
+	.pd_offline_fn		= throtl_pd_offline,
 	.pd_free_fn		= throtl_pd_free,
 };
 
@@ -1561,32 +1598,15 @@ void blk_throtl_cancel_bios(struct gendisk *disk)
 	 */
 	rcu_read_lock();
 	blkg_for_each_descendant_post(blkg, pos_css, q->root_blkg) {
-		struct throtl_grp *tg = blkg_to_tg(blkg);
-		struct throtl_service_queue *sq = &tg->service_queue;
-
-		/*
-		 * Set the flag to make sure throtl_pending_timer_fn() won't
-		 * stop until all throttled bios are dispatched.
-		 */
-		tg->flags |= THROTL_TG_CANCELING;
-
 		/*
-		 * Do not dispatch cgroup without THROTL_TG_PENDING or cgroup
-		 * will be inserted to service queue without THROTL_TG_PENDING
-		 * set in tg_update_disptime below. Then IO dispatched from
-		 * child in tg_dispatch_one_bio will trigger double insertion
-		 * and corrupt the tree.
+		 * disk_release will call pd_offline_fn to cancel bios.
+		 * However, disk_release can't be called if someone get
+		 * the refcount of device and issued bios which are
+		 * inflight after del_gendisk.
+		 * Cancel bios here to ensure no bios are inflight after
+		 * del_gendisk.
 		 */
-		if (!(tg->flags & THROTL_TG_PENDING))
-			continue;
-
-		/*
-		 * Update disptime after setting the above flag to make sure
-		 * throtl_select_dispatch() won't exit without dispatching.
-		 */
-		tg_update_disptime(tg);
-
-		throtl_schedule_pending_timer(sq, jiffies + 1);
+		tg_cancel_bios(blkg_to_tg(blkg));
 	}
 	rcu_read_unlock();
 	spin_unlock_irq(&q->queue_lock);
-- 
2.31.1


