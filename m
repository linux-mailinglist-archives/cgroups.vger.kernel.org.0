Return-Path: <cgroups+bounces-3220-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8B690C25C
	for <lists+cgroups@lfdr.de>; Tue, 18 Jun 2024 05:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DF251C21A91
	for <lists+cgroups@lfdr.de>; Tue, 18 Jun 2024 03:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB0119DF40;
	Tue, 18 Jun 2024 03:18:50 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3A51E4A1;
	Tue, 18 Jun 2024 03:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718680730; cv=none; b=nipu2xBRQhK2Y+X0fPY4YDtcYu/3xwJmi1Lkbuxsm83z2itx7MFcHfYjiiZ4PsZXneDhEJohNoha9zaSej6ZuL2b1FHFQ1MAyYzAr9bq+de99t8wroTgMWTZAQqvpBbpHnOOoHusp3w6krjeKgSgLwl6qmR6qLHWPlQt1Ym2xtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718680730; c=relaxed/simple;
	bh=LOjXU7KK/APac/FwqT39JdQc8LBfPrxyolvIwG8s1aE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rXtYQ1H6733U8OHjlQ2KaxXDtKYKm1p/yl/JXvK2PpjCsJ+cx0oAxtKoMykrKGa0dzq4tIW/uNq3Ma2eBll35iKC7uDIfo/6xljuXBNiHmBgaEomhH9sCpNgbyNEr4/l2sAc8xJq/AVnb2euXqCh1iDIhuynXRILNfzge2zWnfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4W3Bm56djYz4f3jYM;
	Tue, 18 Jun 2024 11:18:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 4384D1A016E;
	Tue, 18 Jun 2024 11:18:40 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCXAQ+N_HBmFJj8AA--.12964S5;
	Tue, 18 Jun 2024 11:18:39 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	tj@kernel.org,
	gregkh@linuxfoundation.org,
	bvanassche@acm.org,
	hch@infradead.org,
	josef@toxicpanda.com,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH RFC v2 1/7] blk-cgroup: add a new helper pr_cont_blkg_path()
Date: Tue, 18 Jun 2024 11:17:45 +0800
Message-Id: <20240618031751.3470464-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240618031751.3470464-1-yukuai1@huaweicloud.com>
References: <20240618031751.3470464-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXAQ+N_HBmFJj8AA--.12964S5
X-Coremail-Antispam: 1UD129KBjvJXoW7ur4xXrWkXw13Jw4rXFWDurg_yoW8ZFW3pa
	9rWr1Yk342gFsav3WFga42q34Fya1vgrWft393X3yYkr17Jr1fZF10yr4kC3yrZF4ayrs8
	XryFyry8Kr1jkw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU4T5dUUUUU
	=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

To print blkg path in iocost, and prepare to build iocost as kernel
module.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-cgroup.c | 6 ++++++
 block/blk-cgroup.h | 1 +
 block/blk-iocost.c | 2 +-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 37e6cc91d576..4da70fc7775e 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -2196,5 +2196,11 @@ bool blk_cgroup_congested(void)
 	return ret;
 }
 
+void pr_cont_blkg_path(struct blkcg_gq *blkg)
+{
+	return pr_cont_cgroup_path(blkg->blkcg->css.cgroup);
+}
+EXPORT_SYMBOL_GPL(pr_cont_blkg_path);
+
 module_param(blkcg_debug_stats, bool, 0644);
 MODULE_PARM_DESC(blkcg_debug_stats, "True if you want debug stats, false if not");
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index 90b3959d88cf..25833221a12b 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -220,6 +220,7 @@ int blkg_conf_open_bdev(struct blkg_conf_ctx *ctx);
 int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 		   struct blkg_conf_ctx *ctx);
 void blkg_conf_exit(struct blkg_conf_ctx *ctx);
+void pr_cont_blkg_path(struct blkcg_gq *blkg);
 
 /**
  * bio_issue_as_root_blkg - see if this bio needs to be issued as root blkg
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 690ca99dfaca..ca72a62bc9c0 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1954,7 +1954,7 @@ static void transfer_surpluses(struct list_head *surpluses, struct ioc_now *now)
 				 iocg->hweight_donating <= 1 ||
 				 iocg->hweight_after_donation == 0)) {
 			pr_warn("iocg: invalid donation weights in ");
-			pr_cont_cgroup_path(iocg_to_blkg(iocg)->blkcg->css.cgroup);
+			pr_cont_blkg_path(iocg_to_blkg(iocg));
 			pr_cont(": active=%u donating=%u after=%u\n",
 				iocg->hweight_active, iocg->hweight_donating,
 				iocg->hweight_after_donation);
-- 
2.39.2


