Return-Path: <cgroups+bounces-10438-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1018B9E088
	for <lists+cgroups@lfdr.de>; Thu, 25 Sep 2025 10:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E1353B696F
	for <lists+cgroups@lfdr.de>; Thu, 25 Sep 2025 08:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9815272E42;
	Thu, 25 Sep 2025 08:25:53 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA5F155C88;
	Thu, 25 Sep 2025 08:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758788753; cv=none; b=n1ZHuRdFu/lFBiwRLfsdav2HscB0tYBE3Un7m+Onto0OX+UVCSKzEDnBhc6UWSTUjaqI/RmeLFgpWe3ReRYsvwZSj0vfcK+Ki31A0eUvFPhxR/6biRC+gQ+nnF51iOWtBLE5NlcpwTYSImdiVX2Y9ucyI0Nh9L/a/wgjEetqIAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758788753; c=relaxed/simple;
	bh=mXGsszJJe36fU64TgCYFXsuq3tNRAsaLRo1fTAjlDpk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dpcJpu7HEM/FEiOu+U/ifBMk8rJJbSkHylUqxC86V2PrXd6WdoT4MT5K7qc52xch4f96chBOiBOb61ZY4jbxlg2UOpvsqvtpcF7sRzGAxfLOOJ/bu11ftZhvBREpgiMZHmQ+cv0IwirbjueJ31tvNqzQMWn2RH6aPv4P+5Na38M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cXRcP04KczKHN6Y;
	Thu, 25 Sep 2025 16:25:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D44B71A0C69;
	Thu, 25 Sep 2025 16:25:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCna2OH_NRodTcIAw--.12615S8;
	Thu, 25 Sep 2025 16:25:48 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: tj@kernel.org,
	ming.lei@redhat.com,
	nilay@linux.ibm.com,
	hch@lst.de,
	josef@toxicpanda.com,
	axboe@kernel.dk,
	akpm@linux-foundation.org,
	vgoyal@redhat.com
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH 04/10] blk-cgroup: don't nest queue_lock under blkcg->lock in blkcg_destroy_blkgs()
Date: Thu, 25 Sep 2025 16:15:19 +0800
Message-Id: <20250925081525.700639-5-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250925081525.700639-1-yukuai1@huaweicloud.com>
References: <20250925081525.700639-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCna2OH_NRodTcIAw--.12615S8
X-Coremail-Antispam: 1UD129KBjvJXoWxGw48ZryUJFyUtr4fKF4Uurg_yoW5GFW8pF
	sxWw4ayrW8KryI9wsIgF9rX3yS9a18Kr15J3yxWw4fGr4jqrnxWF1UC3ykZFWfJFWxJrs0
	vrWUtr95Cr4UAwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjTRNdb1DUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

The correct lock order is q->queue_lock before blkcg->lock, and in order
to prevent deadlock from blkcg_destroy_blkgs(), trylock is used for
q->queue_lock while blkcg->lock is already held, this is hacky.

Hence refactor blkcg_destroy_blkgs(), by holding blkcg->lock to get the
first blkg and release it, then hold q->queue_lock and blkcg->lock in
the correct order to destroy blkg. This is super cold path, it's fine to
grab and release locks.

Also prepare to convert protecting blkcg with blkcg_mutex instead of
queue_lock.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-cgroup.c | 45 ++++++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 53a64bfe4a24..795efb5ccb5e 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1283,6 +1283,21 @@ struct list_head *blkcg_get_cgwb_list(struct cgroup_subsys_state *css)
  *    This finally frees the blkcg.
  */
 
+static struct blkcg_gq *blkcg_get_first_blkg(struct blkcg *blkcg)
+{
+	struct blkcg_gq *blkg = NULL;
+
+	spin_lock_irq(&blkcg->lock);
+	if (!hlist_empty(&blkcg->blkg_list)) {
+		blkg = hlist_entry(blkcg->blkg_list.first, struct blkcg_gq,
+				   blkcg_node);
+		blkg_get(blkg);
+	}
+	spin_unlock_irq(&blkcg->lock);
+
+	return blkg;
+}
+
 /**
  * blkcg_destroy_blkgs - responsible for shooting down blkgs
  * @blkcg: blkcg of interest
@@ -1296,32 +1311,24 @@ struct list_head *blkcg_get_cgwb_list(struct cgroup_subsys_state *css)
  */
 static void blkcg_destroy_blkgs(struct blkcg *blkcg)
 {
-	might_sleep();
+	struct blkcg_gq *blkg;
 
-	spin_lock_irq(&blkcg->lock);
+	might_sleep();
 
-	while (!hlist_empty(&blkcg->blkg_list)) {
-		struct blkcg_gq *blkg = hlist_entry(blkcg->blkg_list.first,
-						struct blkcg_gq, blkcg_node);
+	while ((blkg = blkcg_get_first_blkg(blkcg))) {
 		struct request_queue *q = blkg->q;
 
-		if (need_resched() || !spin_trylock(&q->queue_lock)) {
-			/*
-			 * Given that the system can accumulate a huge number
-			 * of blkgs in pathological cases, check to see if we
-			 * need to rescheduling to avoid softlockup.
-			 */
-			spin_unlock_irq(&blkcg->lock);
-			cond_resched();
-			spin_lock_irq(&blkcg->lock);
-			continue;
-		}
+		spin_lock_irq(&q->queue_lock);
+		spin_lock(&blkcg->lock);
 
 		blkg_destroy(blkg);
-		spin_unlock(&q->queue_lock);
-	}
 
-	spin_unlock_irq(&blkcg->lock);
+		spin_unlock(&blkcg->lock);
+		spin_unlock_irq(&q->queue_lock);
+
+		blkg_put(blkg);
+		cond_resched();
+	}
 }
 
 /**
-- 
2.39.2


