Return-Path: <cgroups+bounces-13133-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF572D16CE9
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 07:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B3D6305784F
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 06:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021BE36A036;
	Tue, 13 Jan 2026 06:20:05 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13538368299;
	Tue, 13 Jan 2026 06:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768285204; cv=none; b=hfqTyrpKLdBd9w0JsyIPrKOYAKj/BvgNMRMwYamx0Gatjr5vTnJsxn05fGdHXNOMGPZcHN5/Vu9/poJYnx6OB6qrjh8WkiAyJlVQkot5u4+757D5e2gBAPjv9Q3x1RTFKt4w7mRwTI9Rrp3e8DDFGh9kHcTQWdDXqfTvABorYkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768285204; c=relaxed/simple;
	bh=wx4cpTYZq4R2Lg3UHzFa6muooui+M6LU1lPYFBrJ5Ms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o81vp8s/t9zG1mFMBeNV/RikOvbWGYjtgaVsbqM/ipIPN28jZNviCZmMJ0hMahlksqgUiutjMztw0G1z4VQ22WxOPlV2re3GFKzqYGd1uwpSWkzfMuGiZIU4JCKgmBdWdVQgsJbBrpCDQdBRuX8hGndMqh8SBjgtP08GLelSUI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dqzbH1kkwzKHMWK;
	Tue, 13 Jan 2026 14:18:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 510B140539;
	Tue, 13 Jan 2026 14:19:41 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP4 (Coremail) with SMTP id gCh0CgC3ZPX642VpuTeEDg--.370S7;
	Tue, 13 Jan 2026 14:19:41 +0800 (CST)
From: Zheng Qixing <zhengqixing@huaweicloud.com>
To: tj@kernel.org,
	josef@toxicpanda.com,
	axboe@kernel.dk,
	yukuai3@huawei.com,
	hch@infradead.org
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mkoutny@suse.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	houtao1@huawei.com,
	zhengqixing@huawei.com
Subject: [PATCH v2 3/3] blk-cgroup: factor policy pd teardown loop into helper
Date: Tue, 13 Jan 2026 14:10:35 +0800
Message-Id: <20260113061035.1902522-4-zhengqixing@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260113061035.1902522-1-zhengqixing@huaweicloud.com>
References: <20260113061035.1902522-1-zhengqixing@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgC3ZPX642VpuTeEDg--.370S7
X-Coremail-Antispam: 1UD129KBjvJXoWxGr45Gw4rur4xWrW8WF4rZrb_yoW5CF18pF
	43Kry3Ar92yr4Dua1UWw1UZrZIga1rKw4UA3yxCa9akr47trnxX3Wqv3ykZFWfAFZrWF45
	uF48t3yakr4UC3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7
	AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
	WUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU
	oApnDUUUU
X-CM-SenderInfo: x2kh0wptl0x03j6k3tpzhluzxrxghudrp/

From: Zheng Qixing <zhengqixing@huawei.com>

Move the teardown sequence which offlines and frees per-policy
blkg_policy_data (pd) into a helper for readability.

No functional change intended.

Signed-off-by: Zheng Qixing <zhengqixing@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Yu Kuai <yukuai@fnnas.com>
---
 block/blk-cgroup.c | 58 +++++++++++++++++++++-------------------------
 1 file changed, 27 insertions(+), 31 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 5dbc107eec53..78227ab0c1d7 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1559,6 +1559,31 @@ struct cgroup_subsys io_cgrp_subsys = {
 };
 EXPORT_SYMBOL_GPL(io_cgrp_subsys);
 
+/*
+ * Tear down per-blkg policy data for @pol on @q.
+ */
+static void blkcg_policy_teardown_pds(struct request_queue *q,
+				      const struct blkcg_policy *pol)
+{
+	struct blkcg_gq *blkg;
+
+	list_for_each_entry(blkg, &q->blkg_list, q_node) {
+		struct blkcg *blkcg = blkg->blkcg;
+		struct blkg_policy_data *pd;
+
+		spin_lock(&blkcg->lock);
+		pd = blkg->pd[pol->plid];
+		if (pd) {
+			if (pd->online && pol->pd_offline_fn)
+				pol->pd_offline_fn(pd);
+			pd->online = false;
+			pol->pd_free_fn(pd);
+			blkg->pd[pol->plid] = NULL;
+		}
+		spin_unlock(&blkcg->lock);
+	}
+}
+
 /**
  * blkcg_activate_policy - activate a blkcg policy on a gendisk
  * @disk: gendisk of interest
@@ -1673,21 +1698,7 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 enomem:
 	/* alloc failed, take down everything */
 	spin_lock_irq(&q->queue_lock);
-	list_for_each_entry(blkg, &q->blkg_list, q_node) {
-		struct blkcg *blkcg = blkg->blkcg;
-		struct blkg_policy_data *pd;
-
-		spin_lock(&blkcg->lock);
-		pd = blkg->pd[pol->plid];
-		if (pd) {
-			if (pd->online && pol->pd_offline_fn)
-				pol->pd_offline_fn(pd);
-			pd->online = false;
-			pol->pd_free_fn(pd);
-			blkg->pd[pol->plid] = NULL;
-		}
-		spin_unlock(&blkcg->lock);
-	}
+	blkcg_policy_teardown_pds(q, pol);
 	spin_unlock_irq(&q->queue_lock);
 	ret = -ENOMEM;
 	goto out;
@@ -1706,7 +1717,6 @@ void blkcg_deactivate_policy(struct gendisk *disk,
 			     const struct blkcg_policy *pol)
 {
 	struct request_queue *q = disk->queue;
-	struct blkcg_gq *blkg;
 	unsigned int memflags;
 
 	if (!blkcg_policy_enabled(q, pol))
@@ -1717,22 +1727,8 @@ void blkcg_deactivate_policy(struct gendisk *disk,
 
 	mutex_lock(&q->blkcg_mutex);
 	spin_lock_irq(&q->queue_lock);
-
 	__clear_bit(pol->plid, q->blkcg_pols);
-
-	list_for_each_entry(blkg, &q->blkg_list, q_node) {
-		struct blkcg *blkcg = blkg->blkcg;
-
-		spin_lock(&blkcg->lock);
-		if (blkg->pd[pol->plid]) {
-			if (blkg->pd[pol->plid]->online && pol->pd_offline_fn)
-				pol->pd_offline_fn(blkg->pd[pol->plid]);
-			pol->pd_free_fn(blkg->pd[pol->plid]);
-			blkg->pd[pol->plid] = NULL;
-		}
-		spin_unlock(&blkcg->lock);
-	}
-
+	blkcg_policy_teardown_pds(q, pol);
 	spin_unlock_irq(&q->queue_lock);
 	mutex_unlock(&q->blkcg_mutex);
 
-- 
2.39.2


