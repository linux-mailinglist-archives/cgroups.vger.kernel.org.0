Return-Path: <cgroups+bounces-10631-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C3CBCC457
	for <lists+cgroups@lfdr.de>; Fri, 10 Oct 2025 11:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0D0B4084A1
	for <lists+cgroups@lfdr.de>; Fri, 10 Oct 2025 09:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBF8271A7B;
	Fri, 10 Oct 2025 09:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kO7G2FBg"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E10271447;
	Fri, 10 Oct 2025 09:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760087698; cv=none; b=rV923JopNaszVoNcw8fcXbPOQWQ31WmwbC+KdwCCV6g929XhXkgS6P/k92see074ms44k3YquU4PNF5IDO8vPmqCdo9mJaamld4++a8Qm0Thb7mafen20km3VnfTZLoGxnHt047tLGT8/zFoGF2vsqQZltjrGqc/tk8aatttgpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760087698; c=relaxed/simple;
	bh=FXI5+pYneSkm/7caOF0xCjnW9F7E3AvQeBSpegaH1UQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iP1bgMZ0Gb2kwDnbKs/y733du8z6VJlWOv0gm+Xv9Lm4XwsRhZSUvocQi0FZeXD1j818hcNRR/K0PAsDsyaMa1Agwe3TgDP3ZX7wMJwrZ9S4uiu1re43qnUCvOTQrDXCX++O5y1hP1H4LG9fvQBBpHeCgGYsbaDLYjeJOxQmOxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kO7G2FBg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70962C4CEF1;
	Fri, 10 Oct 2025 09:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760087697;
	bh=FXI5+pYneSkm/7caOF0xCjnW9F7E3AvQeBSpegaH1UQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kO7G2FBg/pnq4Rnx6HcULPdfRzkOh/7PzA4V6DnYpoI6akcmuMup02rOfOArx5Q+y
	 3JbOM7z/Zjy64xwP6Rv2CwQBIkW8REUEarrbSW2kA+XK1mPrUVljeFc/3G0bSCLRSr
	 Gzn/82CCy+Tt/HiazxYIB3RLMRQoQaylNiTSjSQIye9GdQXHHGfOE6WVAJZILVjMHz
	 vTYo68OrSGJwyIIRCtKKQCvOiu3dNJDjYnYjRGxvaKvJNxRZ45WFKiQf2tP5L7JQ1y
	 AQ3sI2nR7bGgXTBg5+s1XSwXVi9gRWrC8RbWROoTr5ffLyJyrbLN8zMJ3SI4+SccOn
	 HJSsCOv3X2s3g==
From: Yu Kuai <yukuai@kernel.org>
To: axboe@kernel.dk,
	tj@kernel.org,
	linux-block@vger.kernel.org,
	cgroups@vger.kernel.org,
	nilay@linux.ibm.com,
	bvanassche@acm.org,
	ming.lei@redhat.com,
	hch@lst.de
Cc: linux-kernel@vger.kernel.org,
	Yu Kuai <yukuai3@huawei.com>
Subject: [PATCH v2 02/19] blk-cgroup: delay freeing policy data after rcu grace period
Date: Fri, 10 Oct 2025 17:14:27 +0800
Message-ID: <20251010091446.3048529-3-yukuai@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010091446.3048529-1-yukuai@kernel.org>
References: <20251010091446.3048529-1-yukuai@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yu Kuai <yukuai3@huawei.com>

Currently blkcg_print_blkgs() must be protected by rcu to iterate blkgs
from blkcg, and then prfill() must be protected by queue_lock to prevent
policy_data to be freed by deactivating policy. For consequence,
queue_lock have to be nested under rcu from blkcg_print_blkgs().

This patch delay freeing policy_data after rcu grace period, so that it's
possible to protect prfill() just with rcu lock held.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-cgroup.c    | 10 ++++++++--
 block/blk-cgroup.h    |  2 ++
 block/blk-iocost.c    | 14 ++++++++++++--
 block/blk-iolatency.c | 10 +++++++++-
 block/blk-throttle.c  | 13 +++++++++++--
 5 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 9fb9f3533150..a7e705d98751 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -548,14 +548,20 @@ static void bfq_pd_init(struct blkg_policy_data *pd)
 	bfqg->rq_pos_tree = RB_ROOT;
 }
 
-static void bfq_pd_free(struct blkg_policy_data *pd)
+static void bfqg_release(struct rcu_head *rcu)
 {
+	struct blkg_policy_data *pd =
+		container_of(rcu, struct blkg_policy_data, rcu_head);
 	struct bfq_group *bfqg = pd_to_bfqg(pd);
 
-	bfqg_stats_exit(&bfqg->stats);
 	bfqg_put(bfqg);
 }
 
+static void bfq_pd_free(struct blkg_policy_data *pd)
+{
+	call_rcu(&pd->rcu_head, bfqg_release);
+}
+
 static void bfq_pd_reset_stats(struct blkg_policy_data *pd)
 {
 	struct bfq_group *bfqg = pd_to_bfqg(pd);
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index 1cce3294634d..fd206d1fa3c9 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -140,6 +140,8 @@ struct blkg_policy_data {
 	struct blkcg_gq			*blkg;
 	int				plid;
 	bool				online;
+
+	struct rcu_head			rcu_head;
 };
 
 /*
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 5bfd70311359..3593547930cc 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -3017,6 +3017,16 @@ static void ioc_pd_init(struct blkg_policy_data *pd)
 	spin_unlock_irqrestore(&ioc->lock, flags);
 }
 
+static void iocg_release(struct rcu_head *rcu)
+{
+	struct blkg_policy_data *pd =
+		container_of(rcu, struct blkg_policy_data, rcu_head);
+	struct ioc_gq *iocg = pd_to_iocg(pd);
+
+	free_percpu(iocg->pcpu_stat);
+	kfree(iocg);
+}
+
 static void ioc_pd_free(struct blkg_policy_data *pd)
 {
 	struct ioc_gq *iocg = pd_to_iocg(pd);
@@ -3041,8 +3051,8 @@ static void ioc_pd_free(struct blkg_policy_data *pd)
 
 		hrtimer_cancel(&iocg->waitq_timer);
 	}
-	free_percpu(iocg->pcpu_stat);
-	kfree(iocg);
+
+	call_rcu(&pd->rcu_head, iocg_release);
 }
 
 static void ioc_pd_stat(struct blkg_policy_data *pd, struct seq_file *s)
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 45bd18f68541..ce25fbb8aaf6 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -1031,13 +1031,21 @@ static void iolatency_pd_offline(struct blkg_policy_data *pd)
 	iolatency_clear_scaling(blkg);
 }
 
-static void iolatency_pd_free(struct blkg_policy_data *pd)
+static void iolat_release(struct rcu_head *rcu)
 {
+	struct blkg_policy_data *pd =
+		container_of(rcu, struct blkg_policy_data, rcu_head);
 	struct iolatency_grp *iolat = pd_to_lat(pd);
+
 	free_percpu(iolat->stats);
 	kfree(iolat);
 }
 
+static void iolatency_pd_free(struct blkg_policy_data *pd)
+{
+	call_rcu(&pd->rcu_head, iolat_release);
+}
+
 static struct cftype iolatency_files[] = {
 	{
 		.name = "latency",
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 2c5b64b1a724..cb3bfdb4684a 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -360,16 +360,25 @@ static void throtl_pd_online(struct blkg_policy_data *pd)
 	tg_update_has_rules(tg);
 }
 
-static void throtl_pd_free(struct blkg_policy_data *pd)
+static void tg_release(struct rcu_head *rcu)
 {
+	struct blkg_policy_data *pd =
+		container_of(rcu, struct blkg_policy_data, rcu_head);
 	struct throtl_grp *tg = pd_to_tg(pd);
 
-	timer_delete_sync(&tg->service_queue.pending_timer);
 	blkg_rwstat_exit(&tg->stat_bytes);
 	blkg_rwstat_exit(&tg->stat_ios);
 	kfree(tg);
 }
 
+static void throtl_pd_free(struct blkg_policy_data *pd)
+{
+	struct throtl_grp *tg = pd_to_tg(pd);
+
+	timer_delete_sync(&tg->service_queue.pending_timer);
+	call_rcu(&pd->rcu_head, tg_release);
+}
+
 static struct throtl_grp *
 throtl_rb_first(struct throtl_service_queue *parent_sq)
 {
-- 
2.51.0


