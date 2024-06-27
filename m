Return-Path: <cgroups+bounces-3389-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 441FE91A245
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2024 11:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0BE81F21C6E
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2024 09:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD55D1386A7;
	Thu, 27 Jun 2024 09:10:22 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CFF1350FD;
	Thu, 27 Jun 2024 09:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719479422; cv=none; b=jXTrO9MnkBsXQxDBPvtqhW9o0QAtgBu/2qaTsFweuOWaVVuQhShbVdiBuSJqZjM7k5WObPEULG4sQic/JQAKmmxsXB2/SYgWjLqRXaIMUzKgg9/BQDnQ3lBBouZPSm5jEMI5G1tWsb5c5Wiw6m58xlUFQYfY8y57FBqi56MlG3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719479422; c=relaxed/simple;
	bh=9SvVfc5I/IFbkYMD/8Tc3wFejN67xcpvA4f6cUFzoNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X4hYuyBbG7xJ/T7z7qsv4RjkowMXNp2tpli+jfeUbUg1gMlB55CsdUFxNiMgpP6O8qJb9YOOc7frivjYoknm5ufrsA4CA3iQ1qWZpBD9J759pQ5ydEghc2S2mWz4B9x14zIqsVsPMiPnsSiO58KcO21JCKASyQ0LJSTqQz8lgcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4W8t7d5Yplz4f3kFF;
	Thu, 27 Jun 2024 17:10:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 9F32E1A0572;
	Thu, 27 Jun 2024 17:10:16 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP2 (Coremail) with SMTP id Syh0CgCH74R3LH1m+hvrAQ--.11947S4;
	Thu, 27 Jun 2024 17:10:16 +0800 (CST)
From: Li Lingfeng <lilingfeng@huaweicloud.com>
To: tj@kernel.org,
	josef@toxicpanda.com,
	hch@lst.de,
	axboe@kernel.dk
Cc: longman@redhat.com,
	ming.lei@redhat.com,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yangerkun@huawei.com,
	yukuai1@huaweicloud.com,
	houtao1@huawei.com,
	yi.zhang@huawei.com,
	lilingfeng@huaweicloud.com,
	lilingfeng3@huawei.com
Subject: [PATCH] blk-cgroup: don't clear stat in blkcg_reset_stats()
Date: Thu, 27 Jun 2024 17:08:56 +0800
Message-Id: <20240627090856.2345018-1-lilingfeng@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCH74R3LH1m+hvrAQ--.11947S4
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFWxZr4DGr17try7uF17KFg_yoW5JFWrpr
	WYkwnIy3yDKF4kZ3WYgay2vryF9wsYyry5JrWDWw1rKFnFyrySvF1qy395AFW5CFyIvr45
	Xr4YvrWDCw4jk3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
	JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r4j6FyUMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUAxh
	LUUUUU=
X-CM-SenderInfo: polox0xjih0w46kxt4xhlfz01xgou0bp/

From: Li Lingfeng <lilingfeng3@huawei.com>

The list corruption described in commit 6da668063279 ("blk-cgroup: fix
list corruption from resetting io stat") has no effect. It's unnecessary
to fix it.

As for cgroup v1, it does not use iostat any more after commit
ad7c3b41e86b("blk-throttle: Fix io statistics for cgroup v1"), so using
memset to clear iostat has no real effect.
As for cgroup v2, it will not call blkcg_reset_stats() to corrupt the
list.

The list of root cgroup can be used by both cgroup v1 and v2 while
non-root cgroup can't since it must be removed before switch between
cgroup v1 and v2.
So it may has effect if the list of root used by cgroup v2 was corrupted
after switching to cgroup v1, and switch back to cgroup v2 to use the
corrupted list again.
However, the root cgroup will not use the list any more after commit
ef45fe470e1e("blk-cgroup: show global disk stats in root cgroup io.stat").

Although this has no negative effect, it is not necessary. Remove the
related code.

Fixes: 6da668063279 ("blk-cgroup: fix list corruption from resetting io stat")
Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
---
 block/blk-cgroup.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 37e6cc91d576..1113c398a742 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -629,29 +629,6 @@ static void blkg_iostat_set(struct blkg_iostat *dst, struct blkg_iostat *src)
 	}
 }
 
-static void __blkg_clear_stat(struct blkg_iostat_set *bis)
-{
-	struct blkg_iostat cur = {0};
-	unsigned long flags;
-
-	flags = u64_stats_update_begin_irqsave(&bis->sync);
-	blkg_iostat_set(&bis->cur, &cur);
-	blkg_iostat_set(&bis->last, &cur);
-	u64_stats_update_end_irqrestore(&bis->sync, flags);
-}
-
-static void blkg_clear_stat(struct blkcg_gq *blkg)
-{
-	int cpu;
-
-	for_each_possible_cpu(cpu) {
-		struct blkg_iostat_set *s = per_cpu_ptr(blkg->iostat_cpu, cpu);
-
-		__blkg_clear_stat(s);
-	}
-	__blkg_clear_stat(&blkg->iostat);
-}
-
 static int blkcg_reset_stats(struct cgroup_subsys_state *css,
 			     struct cftype *cftype, u64 val)
 {
@@ -668,7 +645,6 @@ static int blkcg_reset_stats(struct cgroup_subsys_state *css,
 	 * anyway.  If you get hit by a race, retry.
 	 */
 	hlist_for_each_entry(blkg, &blkcg->blkg_list, blkcg_node) {
-		blkg_clear_stat(blkg);
 		for (i = 0; i < BLKCG_MAX_POLS; i++) {
 			struct blkcg_policy *pol = blkcg_policy[i];
 
-- 
2.31.1


