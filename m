Return-Path: <cgroups+bounces-4337-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08804955616
	for <lists+cgroups@lfdr.de>; Sat, 17 Aug 2024 09:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4CE9285CC9
	for <lists+cgroups@lfdr.de>; Sat, 17 Aug 2024 07:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DD513D63E;
	Sat, 17 Aug 2024 07:15:40 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA79412CDB0;
	Sat, 17 Aug 2024 07:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723878940; cv=none; b=rofx1H4Hwj73QU3PNctJKtc9grK26XWLPNBgyp1Azewb3uuufJBvNAIMbmjuY3/xVOe3aII+kghNK7f8olkx4f9HAgImjsoVQki7Gwb0sC2WxCZoXYebV/ibm6hldw+wI4V8XA8Z/slSBvAzLaYzdNU28nvePJf3NB+yJCHjJNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723878940; c=relaxed/simple;
	bh=cpQ/dTQaaeMXokaHetPUTehUGKoy4+4Sq9ThDX5zTLI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ef+8sXiEM0gpIp0QSaMc66ZxarWDLwgaZtGCYI4Alj4D9dE3F199DF97EKdJ3euldthQlus4W04CSCadDOEBUY+zvssZGDo8RiUTYcLBe2WvLVBFP2ll/ciM12tT6PbLxdyPAY3qcSjO/RupM7UZG6KqHlbtoFoXDefbFbKjIMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Wm99g3pNJz4f3jHn;
	Sat, 17 Aug 2024 15:15:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 751E51A058E;
	Sat, 17 Aug 2024 15:15:33 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCXv4USTsBmTQm0Bw--.39374S4;
	Sat, 17 Aug 2024 15:15:32 +0800 (CST)
From: Li Lingfeng <lilingfeng@huaweicloud.com>
To: tj@kernel.org,
	josef@toxicpanda.com,
	hch@lst.de,
	mkoutny@suse.com,
	axboe@kernel.dk
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com,
	houtao1@huawei.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	yukuai3@huawei.com,
	lilingfeng@huaweicloud.com,
	lilingfeng3@huawei.com
Subject: [PATCH v3] block: flush all throttled bios when deleting the cgroup
Date: Sat, 17 Aug 2024 15:11:08 +0800
Message-Id: <20240817071108.1919729-1-lilingfeng@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXv4USTsBmTQm0Bw--.39374S4
X-Coremail-Antispam: 1UD129KBjvJXoWxWr4xWF48Gw47WF1kCFWDXFb_yoWrAF1DpF
	WS9a45Cw1DJr90kr4agr1UJFWSv395XrWag397GayayrWxtw1jqF9YvFy8XFWrJFn3Cr4Y
	vr45tr1xuF18G37anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUQID7UUUUU=
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
[1] https://lore.kernel.org/r/20220318130144.1066064-4-ming.lei@redhat.com
[2] https://lore.kernel.org/all/da861d63-58c6-3ca0-2535-9089993e9e28@huaweicloud.com/

Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
---
  v2->v3:
    Change "tg_cancel_bios" to "tg_flush_bios";
    Add reference of v2 to describe the background.
 block/blk-throttle.c | 68 ++++++++++++++++++++++++++++----------------
 1 file changed, 44 insertions(+), 24 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 6943ec720f39..cf7f4912c57a 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1526,6 +1526,42 @@ static void throtl_shutdown_wq(struct request_queue *q)
 	cancel_work_sync(&td->dispatch_work);
 }
 
+static void tg_flush_bios(struct throtl_grp *tg)
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
+	tg_flush_bios(pd_to_tg(pd));
+}
+
 struct blkcg_policy blkcg_policy_throtl = {
 	.dfl_cftypes		= throtl_files,
 	.legacy_cftypes		= throtl_legacy_files,
@@ -1533,6 +1569,7 @@ struct blkcg_policy blkcg_policy_throtl = {
 	.pd_alloc_fn		= throtl_pd_alloc,
 	.pd_init_fn		= throtl_pd_init,
 	.pd_online_fn		= throtl_pd_online,
+	.pd_offline_fn		= throtl_pd_offline,
 	.pd_free_fn		= throtl_pd_free,
 };
 
@@ -1553,32 +1590,15 @@ void blk_throtl_cancel_bios(struct gendisk *disk)
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
+		tg_flush_bios(blkg_to_tg(blkg));
 	}
 	rcu_read_unlock();
 	spin_unlock_irq(&q->queue_lock);
-- 
2.39.2


