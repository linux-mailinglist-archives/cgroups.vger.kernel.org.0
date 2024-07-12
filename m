Return-Path: <cgroups+bounces-3650-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC7292F772
	for <lists+cgroups@lfdr.de>; Fri, 12 Jul 2024 11:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AED7F1F21FCE
	for <lists+cgroups@lfdr.de>; Fri, 12 Jul 2024 09:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2907143747;
	Fri, 12 Jul 2024 09:00:18 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B7413E02D;
	Fri, 12 Jul 2024 09:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720774818; cv=none; b=NZho6i5h34JU0WmUev56Y+rNpMZkdZxd87pvMIW1p6+on5f7Mr/RXUDeh1YQ5H0BRwv+s18/+HoAivzo4i+t8Ac1axaB9YQD4Ceu/W7wjTC13WZgSxfhZbDU5vUCl0y/mINnx3oV9ikt5Kzv5jUDjpUAMAsnOTkee1E1Ug9e+cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720774818; c=relaxed/simple;
	bh=IUjQuc+xzVDbHxpaTQ8Oy+CrD0FdWfp/rAI9b+8o2Ek=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PF3gMjh0ffLqUpGwJAhH+VNZkRRpXGcULnl3B3aOrhHdz+LiubY/N3QGBvFrVUQpAwDn3uxUubUCKAXoSW2lOtrwJGL5FuO/93AMzvXSLGuHazD9ftYwWsfpoHZWh/tMLGL4iL1/kvxQu882bwnkTzdCwWbzHyEm+8/0RrWP/0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WL55q38Mvz1T68n;
	Fri, 12 Jul 2024 16:55:27 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id 845ED140361;
	Fri, 12 Jul 2024 17:00:12 +0800 (CST)
Received: from hulk-vt.huawei.com (10.67.174.26) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 12 Jul 2024 17:00:12 +0800
From: Xiu Jianfeng <xiujianfeng@huawei.com>
To: <tj@kernel.org>, <josef@toxicpanda.com>, <axboe@kernel.dk>,
	<lizefan.x@bytedance.com>, <hannes@cmpxchg.org>
CC: <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH -next] blk-cgroup: move congestion_count to struct blkcg
Date: Fri, 12 Jul 2024 08:51:41 +0000
Message-ID: <20240712085141.3288708-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500023.china.huawei.com (7.185.36.114)

The congestion_count was introduced by commit d09d8df3a294 ("blkcg:
add generic throttling mechanism"), but since it is closely related
to the blkio subsys, it is not appropriate to put it in the struct
cgroup, so move it to struct blkcg.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
only compiling tested
---
 block/blk-cgroup.c          |  4 +++-
 block/blk-cgroup.h          | 10 ++++++----
 include/linux/cgroup-defs.h |  3 ---
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 37e6cc91d576..01d3408c2fc6 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -2183,11 +2183,13 @@ void blk_cgroup_bio_start(struct bio *bio)
 bool blk_cgroup_congested(void)
 {
 	struct cgroup_subsys_state *css;
+	struct blkcg *blkcg;
 	bool ret = false;
 
 	rcu_read_lock();
 	for (css = blkcg_css(); css; css = css->parent) {
-		if (atomic_read(&css->cgroup->congestion_count)) {
+		blkcg = css_to_blkcg(css);
+		if (atomic_read(&blkcg->congestion_count)) {
 			ret = true;
 			break;
 		}
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index bd472a30bc61..16a2fbd4adca 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -95,6 +95,8 @@ struct blkcg {
 	struct cgroup_subsys_state	css;
 	spinlock_t			lock;
 	refcount_t			online_pin;
+	/* If there is block congestion on this cgroup. */
+	atomic_t congestion_count;
 
 	struct radix_tree_root		blkg_tree;
 	struct blkcg_gq	__rcu		*blkg_hint;
@@ -374,7 +376,7 @@ static inline void blkcg_use_delay(struct blkcg_gq *blkg)
 	if (WARN_ON_ONCE(atomic_read(&blkg->use_delay) < 0))
 		return;
 	if (atomic_add_return(1, &blkg->use_delay) == 1)
-		atomic_inc(&blkg->blkcg->css.cgroup->congestion_count);
+		atomic_inc(&blkg->blkcg->congestion_count);
 }
 
 static inline int blkcg_unuse_delay(struct blkcg_gq *blkg)
@@ -399,7 +401,7 @@ static inline int blkcg_unuse_delay(struct blkcg_gq *blkg)
 	if (old == 0)
 		return 0;
 	if (old == 1)
-		atomic_dec(&blkg->blkcg->css.cgroup->congestion_count);
+		atomic_dec(&blkg->blkcg->congestion_count);
 	return 1;
 }
 
@@ -418,7 +420,7 @@ static inline void blkcg_set_delay(struct blkcg_gq *blkg, u64 delay)
 
 	/* We only want 1 person setting the congestion count for this blkg. */
 	if (!old && atomic_try_cmpxchg(&blkg->use_delay, &old, -1))
-		atomic_inc(&blkg->blkcg->css.cgroup->congestion_count);
+		atomic_inc(&blkg->blkcg->congestion_count);
 
 	atomic64_set(&blkg->delay_nsec, delay);
 }
@@ -435,7 +437,7 @@ static inline void blkcg_clear_delay(struct blkcg_gq *blkg)
 
 	/* We only want 1 person clearing the congestion count for this blkg. */
 	if (old && atomic_try_cmpxchg(&blkg->use_delay, &old, 0))
-		atomic_dec(&blkg->blkcg->css.cgroup->congestion_count);
+		atomic_dec(&blkg->blkcg->congestion_count);
 }
 
 /**
diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 293af7f8a694..ae04035b6cbe 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -539,9 +539,6 @@ struct cgroup {
 	/* used to store eBPF programs */
 	struct cgroup_bpf bpf;
 
-	/* If there is block congestion on this cgroup. */
-	atomic_t congestion_count;
-
 	/* Used to store internal freezer state */
 	struct cgroup_freezer_state freezer;
 
-- 
2.34.1


