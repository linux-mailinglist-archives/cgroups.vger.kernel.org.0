Return-Path: <cgroups+bounces-10643-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A50BCC4AF
	for <lists+cgroups@lfdr.de>; Fri, 10 Oct 2025 11:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EC8EA4FCDC2
	for <lists+cgroups@lfdr.de>; Fri, 10 Oct 2025 09:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3679A2749EA;
	Fri, 10 Oct 2025 09:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="furPqr22"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F28274B53;
	Fri, 10 Oct 2025 09:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760087733; cv=none; b=OIxJNOsaXgs/0g3LsrcfkoUs13rgdKI+wU7U809e3cJBj2zEt7lIpgqFaenDOl5ghzdcPDmh9TuwJZEEu7TgNYqUNNbVGaT/dKf4Td2dS9MZ4jU7OvypSFXK0xR/189D7Qq4rbqgsrphI62ri3XfRvh0MqUQKfz8RSiusWi0Y4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760087733; c=relaxed/simple;
	bh=gKnwCpOoqD8n4UeyhgqRcCPLvd7xwvT4lg/c/NGhF6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jGkfAEJNXzYsIAXCpi6GPlANrUnbcJlV5IHyPuQUOB4hldtQcHDVUxV6c9N1v05F/Ed9PjR487G1KuRzoTbnowMqx4K6O6VlAPODWdKbpovTCzKJsDVd2K6uaqchCZ5sRHlQbWJ1DyUJ+SK6zNJC4wSItNQmBCXUto+j/nNqurI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=furPqr22; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D2AC4CEF1;
	Fri, 10 Oct 2025 09:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760087732;
	bh=gKnwCpOoqD8n4UeyhgqRcCPLvd7xwvT4lg/c/NGhF6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=furPqr22+3mA4la5f2HPFFCM6upF21kpWnV2YKOIoKBMFfPtL8vpcwCOvanJE9KPm
	 MgjJY5187rnC1xd1786BaDM8N6la0OrFEied4EUzlXJUU6V/xbNA1dfFj7wY8s8M4i
	 2SpK3Yy1sc7srD0MhB1kkMS4dgNKFAMihx+BwSjEhMIIdqjlejKV3hdVa+wOOarYiX
	 tIuQL+jSAay1+EM/pVp6zqPbgR+ABBIRBebZ5nuxRBUlQj5AkKEE+Z4ivgMryKQP3B
	 cPhGhGoNZGFlAwGI4G2eOuWEgMgBEZJPxbVORpNcL6OCN4eOLacUFxKuO4wAFDwDpa
	 XrhmxxKBrQGlA==
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
Subject: [PATCH v2 14/19] blk-cgroup: factor out a helper __blkg_activate_policy()
Date: Fri, 10 Oct 2025 17:14:39 +0800
Message-ID: <20251010091446.3048529-15-yukuai@kernel.org>
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

Currently bfq policy is activated by initializing elevator, while others
are activated by cgroupfs configuration. factor out a helper that
blkcg_mutex is alread held to prepare use new helpers blkg_conf{start,
end} for policys other than bfq.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-cgroup.c | 31 +++----------------------------
 block/blk-cgroup.h | 34 +++++++++++++++++++++++++++++++++-
 2 files changed, 36 insertions(+), 29 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 63089ae269cb..4b7324c1d0d5 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1562,32 +1562,14 @@ struct cgroup_subsys io_cgrp_subsys = {
 };
 EXPORT_SYMBOL_GPL(io_cgrp_subsys);
 
-/**
- * blkcg_activate_policy - activate a blkcg policy on a gendisk
- * @disk: gendisk of interest
- * @pol: blkcg policy to activate
- *
- * Activate @pol on @disk.  Requires %GFP_KERNEL context.  @disk goes through
- * bypass mode to populate its blkgs with policy_data for @pol.
- *
- * Activation happens with @disk bypassed, so nobody would be accessing blkgs
- * from IO path.  Update of each blkg is protected by both queue and blkcg
- * locks so that holding either lock and testing blkcg_policy_enabled() is
- * always enough for dereferencing policy data.
- *
- * The caller is responsible for synchronizing [de]activations and policy
- * [un]registerations.  Returns 0 on success, -errno on failure.
- */
-int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
+int __blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 {
 	struct request_queue *q = disk->queue;
 	struct blkg_policy_data *pd_prealloc = NULL;
 	struct blkcg_gq *blkg, *pinned_blkg = NULL;
-	unsigned int memflags;
 	int ret;
 
-	if (blkcg_policy_enabled(q, pol))
-		return 0;
+	lockdep_assert_held(&q->blkcg_mutex);
 
 	/*
 	 * Policy is allowed to be registered without pd_alloc_fn/pd_free_fn,
@@ -1597,10 +1579,6 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 	if (WARN_ON_ONCE(!pol->pd_alloc_fn || !pol->pd_free_fn))
 		return -EINVAL;
 
-	if (queue_is_mq(q))
-		memflags = blk_mq_freeze_queue(q);
-	mutex_lock(&q->blkcg_mutex);
-
 	/* blkg_list is pushed at the head, reverse walk to initialize parents first */
 	list_for_each_entry_reverse(blkg, &q->blkg_list, q_node) {
 		struct blkg_policy_data *pd;
@@ -1640,9 +1618,6 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 	ret = 0;
 
 out:
-	mutex_unlock(&q->blkcg_mutex);
-	if (queue_is_mq(q))
-		blk_mq_unfreeze_queue(q, memflags);
 	if (pinned_blkg)
 		blkg_put(pinned_blkg);
 	if (pd_prealloc)
@@ -1670,7 +1645,7 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 	ret = -ENOMEM;
 	goto out;
 }
-EXPORT_SYMBOL_GPL(blkcg_activate_policy);
+EXPORT_SYMBOL_GPL(__blkcg_activate_policy);
 
 /**
  * blkcg_deactivate_policy - deactivate a blkcg policy on a gendisk
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index e7868989befb..c3d16d52c275 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -200,7 +200,7 @@ void blkcg_exit_disk(struct gendisk *disk);
 /* Blkio controller policy registration */
 int blkcg_policy_register(struct blkcg_policy *pol);
 void blkcg_policy_unregister(struct blkcg_policy *pol);
-int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol);
+int __blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol);
 void blkcg_deactivate_policy(struct gendisk *disk,
 			     const struct blkcg_policy *pol);
 
@@ -465,6 +465,38 @@ static inline bool blkcg_policy_enabled(struct request_queue *q,
 	return pol && test_bit(pol->plid, q->blkcg_pols);
 }
 
+/**
+ * blkcg_activate_policy - activate a blkcg policy on a gendisk
+ * @disk: gendisk of interest
+ * @pol: blkcg policy to activate
+ *
+ * Activate @pol on @disk.  Requires %GFP_KERNEL context.  @disk goes through
+ * bypass mode to populate its blkgs with policy_data for @pol.
+ *
+ * Activation happens with @disk bypassed, so nobody would be accessing blkgs
+ * from IO path.  Update of each blkg is protected by both queue and blkcg
+ * locks so that holding either lock and testing blkcg_policy_enabled() is
+ * always enough for dereferencing policy data.
+ *
+ * The caller is responsible for synchronizing [de]activations and policy
+ * [un]registerations.  Returns 0 on success, -errno on failure.
+ */
+static inline int blkcg_activate_policy(struct gendisk *disk,
+					const struct blkcg_policy *pol)
+{
+	struct request_queue *q = disk->queue;
+	int ret;
+
+	if (blkcg_policy_enabled(q, pol))
+		return 0;
+
+	mutex_lock(&q->blkcg_mutex);
+	ret = __blkcg_activate_policy(disk, pol);
+	mutex_unlock(&q->blkcg_mutex);
+
+	return ret;
+}
+
 void blk_cgroup_bio_start(struct bio *bio);
 void blkcg_add_delay(struct blkcg_gq *blkg, u64 now, u64 delta);
 #else	/* CONFIG_BLK_CGROUP */
-- 
2.51.0


