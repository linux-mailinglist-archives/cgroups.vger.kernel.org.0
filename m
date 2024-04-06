Return-Path: <cgroups+bounces-2353-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F37CC89A9A8
	for <lists+cgroups@lfdr.de>; Sat,  6 Apr 2024 10:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8C0A1F2239B
	for <lists+cgroups@lfdr.de>; Sat,  6 Apr 2024 08:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E8828DD2;
	Sat,  6 Apr 2024 08:09:16 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A5022F02;
	Sat,  6 Apr 2024 08:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712390956; cv=none; b=EPkhY8v6rzbdp4pwrtBWwKRj3xLvd0wOSB1r72qs96kfpPfEJGgrobqQbRsYvBireicl1UwwK22DDQfEsDDZekxUmnBeYbbF5WJlMU+TF9NpM5lSvN0V5//sjm8/fGl8XCK3RQmlOSl5z5WdEUdFuc2LHa/muYBWJqfYFlnoUpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712390956; c=relaxed/simple;
	bh=RGeLpQq1tNqBVU02itqj6kS9o7uyCx/gUkBGHq49FmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E2bmnZnw6XL5Gp8Or9SnYmybqvFAK7I/ttnQNnXliUq2OZNt6VRZ2A9fNZo6fVQjRQMtMfAaQ4DJic/WZB2McHQ1qEbCFDf1dI4/wpLjHi2Mo61x7HPyadWOipqnzMxDQys6N1nbTFgRkxY6bNow+rwhZGiABHNZgwLZXqNz9v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VBSg316Nlz4f3lVx;
	Sat,  6 Apr 2024 16:09:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 9C4B91A016E;
	Sat,  6 Apr 2024 16:09:11 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgDHlxAjAxFmnZTkJA--.2125S7;
	Sat, 06 Apr 2024 16:09:11 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	chenhuacai@kernel.org,
	tj@kernel.org,
	josef@toxicpanda.com,
	jhs@mojatatu.com,
	svenjoac@gmx.de,
	raven@themaw.net,
	pctammela@mojatatu.com,
	yukuai3@huawei.com,
	qde@naccy.de,
	zhaotianrui@loongson.cn
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	cgroups@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH RFC v2 3/6] blk-throttle: expand tg_conf_updated() to return if any tg has rules
Date: Sat,  6 Apr 2024 16:00:56 +0800
Message-Id: <20240406080059.2248314-4-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240406080059.2248314-1-yukuai1@huaweicloud.com>
References: <20240406080059.2248314-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHlxAjAxFmnZTkJA--.2125S7
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr47Kr4xtry3ur17GryDJrb_yoW5Jr48pF
	yUAa1UJw4DZFs09rsxJr1qgFWFqan7Zryaq393Ww4rtr4aqwnYgFn0vryruayrAF93uF4x
	ZrsrtrWYkF109FDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
	CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUojjgUUUU
	U
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

There are no functional changes yet, prepare to destroy blk-throttle
when it's disabled.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-throttle.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index acb2758f45ef..b371442131fe 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -320,9 +320,10 @@ static void throtl_pd_init(struct blkg_policy_data *pd)
  * This doesn't require walking up to the top of the hierarchy as the
  * parent's has_rules[] is guaranteed to be correct.
  */
-static void tg_update_has_rules(struct throtl_grp *tg)
+static bool tg_update_has_rules(struct throtl_grp *tg)
 {
 	struct throtl_grp *parent_tg = sq_to_tg(tg->service_queue.parent_sq);
+	bool has_rules = false;
 	int rw;
 
 	for (rw = READ; rw <= WRITE; rw++) {
@@ -332,7 +333,11 @@ static void tg_update_has_rules(struct throtl_grp *tg)
 		tg->has_rules_bps[rw] =
 			(parent_tg && parent_tg->has_rules_bps[rw]) ||
 			tg_bps_limit(tg, rw) != U64_MAX;
+		if (tg->has_rules_iops[rw] || tg->has_rules_bps[rw])
+			has_rules = true;
 	}
+
+	return has_rules;
 }
 
 static void throtl_pd_online(struct blkg_policy_data *pd)
@@ -1163,11 +1168,12 @@ static int tg_print_conf_uint(struct seq_file *sf, void *v)
 	return 0;
 }
 
-static void tg_conf_updated(struct throtl_grp *tg, bool global)
+static bool tg_conf_updated(struct throtl_grp *tg, bool global)
 {
 	struct throtl_service_queue *sq = &tg->service_queue;
 	struct cgroup_subsys_state *pos_css;
 	struct blkcg_gq *blkg;
+	bool has_rules = false;
 
 	throtl_log(&tg->service_queue,
 		   "limit change rbps=%llu wbps=%llu riops=%u wiops=%u",
@@ -1187,7 +1193,8 @@ static void tg_conf_updated(struct throtl_grp *tg, bool global)
 		struct throtl_grp *this_tg = blkg_to_tg(blkg);
 		struct throtl_grp *parent_tg;
 
-		tg_update_has_rules(this_tg);
+		if (tg_update_has_rules(this_tg))
+			has_rules = true;
 		/* ignore root/second level */
 		if (!cgroup_subsys_on_dfl(io_cgrp_subsys) || !blkg->parent ||
 		    !blkg->parent->parent)
@@ -1211,6 +1218,8 @@ static void tg_conf_updated(struct throtl_grp *tg, bool global)
 		tg_update_disptime(tg);
 		throtl_schedule_next_dispatch(sq->parent_sq, true);
 	}
+
+	return has_rules;
 }
 
 static int blk_throtl_init(struct gendisk *disk)
-- 
2.39.2


