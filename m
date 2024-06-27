Return-Path: <cgroups+bounces-3403-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3F891A931
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2024 16:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88CC1281B78
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2024 14:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB4C13C821;
	Thu, 27 Jun 2024 14:27:33 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CC713A259;
	Thu, 27 Jun 2024 14:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719498453; cv=none; b=P2b5Q6pTSKfaHCHIS7BcPC4DV/EtNbKE9kciQ7GeQ4mYLTqbDC1hsJrI/cTnpsV1GbkxGVnMTAmA7Y9OpL6Pm1Td7jRSygfvD/OsGX8l0wzAVQXaGY7+9e0+ei36lqCWuhlp24oWjghGALK7u9ZzAVbF2uGH9j0rDbv9nV2DsdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719498453; c=relaxed/simple;
	bh=+hA94nBp0Z2NOG+7XiSePdvJo4tjMM+AEioEA4rngWg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q5Sovy3ud5FOXaNwllGJgskTuDSHHUDvvY2qGGfEt/fgaQIELq5resOK+n3pS40MvFHwvTXDTgsjML3xGd4+mjTufcePF2Q3rOFV0ApISLMlPcFouIGEbQjkH2zIZmw1z+ajoIWAQJazN37Elcjr0aO91UGPEbp8Bl5CmEo2SOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4W919h10fwz4f3jt1;
	Thu, 27 Jun 2024 22:27:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 478F21A0189;
	Thu, 27 Jun 2024 22:27:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP2 (Coremail) with SMTP id Syh0CgBXwIXNdn1mUQAAAg--.25162S4;
	Thu, 27 Jun 2024 22:27:27 +0800 (CST)
From: Li Lingfeng <lilingfeng@huaweicloud.com>
To: tj@kernel.org,
	josef@toxicpanda.com,
	hch@lst.de,
	axboe@kernel.dk,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yangerkun@huawei.com,
	yukuai1@huaweicloud.com,
	houtao1@huawei.com,
	yi.zhang@huawei.com,
	lilingfeng@huaweicloud.com,
	lilingfeng3@huawei.com
Subject: [PATCH v2] block: flush all throttled bios when deleting the cgroup
Date: Thu, 27 Jun 2024 22:26:06 +0800
Message-Id: <20240627142606.3709394-1-lilingfeng@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBXwIXNdn1mUQAAAg--.25162S4
X-Coremail-Antispam: 1UD129KBjvJXoWxWr4xWF48Gw1xGry3tr47urg_yoWrWF4rpr
	WS9a4Ykw1Dtr9I9r4agr45JFWSva95XrWav397Ca1ayrWxtw1jqF9Yva48XFWrJFn3Cr4Y
	vr15tr18uF18G37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUF9
	a9DUUUU
X-CM-SenderInfo: polox0xjih0w46kxt4xhlfz01xgou0bp/

From: Li Lingfeng <lilingfeng3@huawei.com>

When a process migrates to another cgroup and the original cgroup is deleted,
the restrictions of throttled bios cannot be removed. If the restrictions
are set too low, it will take a long time to complete these bios.

Refer to the process of deleting a disk to remove the restrictions and
issue bios when deleting the cgroup.

This makes difference on the behavior of throttled bios:
Before: the limit of the throttled bios can't be changed and the bios will
complete under this limit;
Now: the limit will be canceled and the throttled bios will be flushed
immediately.

References:
https://lore.kernel.org/r/20220318130144.1066064-4-ming.lei@redhat.com

Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
---
  v1->v2:
    Use "flush" instead of "cancel";
    Add description of the affect of throttled bios.
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
2.39.2


