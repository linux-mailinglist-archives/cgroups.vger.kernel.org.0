Return-Path: <cgroups+bounces-13630-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKC5KYWtgWn0IQMAu9opvQ
	(envelope-from <cgroups+bounces-13630-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 03 Feb 2026 09:10:45 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1ECD6093
	for <lists+cgroups@lfdr.de>; Tue, 03 Feb 2026 09:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E17D530FDD74
	for <lists+cgroups@lfdr.de>; Tue,  3 Feb 2026 08:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839AF392C53;
	Tue,  3 Feb 2026 08:06:27 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3B62DF6F6;
	Tue,  3 Feb 2026 08:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770105987; cv=none; b=J25bwA0CXVC88o50YuU5EvUrwrfxEQNUArTFQXz1+83iYH228+Yt3OIfCDiUEjeZ9zVp2whdUDDtfC30xVRd+bproXetyEEU4bQGhwEp2C/wNA6MftSZYZetlK95NyECdm44ZJrVIauqqaivWdWX/iiaVKTTf8GGFKGp+cWDMJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770105987; c=relaxed/simple;
	bh=+wpQzCeDzydQyFBHE0dTG91SeK/rd+bFq5EYPKkSwSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jHNmo28cKTpkrcd1kp/3RX+3/nqY1nZJVKiO+xhCMulHaA06K9Vfm+CvPg+PF/Kuu+VogHM8FJg4uM7JWZdM0CpWxcpxFpgvKyo0SA0Flbs/3Emug1xMPC2g+zQ1YsgNMZsg5KnLhAXcLYVJ2b5m05jR+nnNW8xFoDTKgcPn5Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 478C1C4AF09;
	Tue,  3 Feb 2026 08:06:24 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: tj@kernel.org,
	josef@toxicpanda.com,
	axboe@kernel.dk
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai@fnnas.com,
	zhengqixing@huawei.com,
	mkoutny@suse.com,
	hch@infradead.org,
	ming.lei@redhat.com,
	nilay@linux.ibm.com
Subject: [PATCH v2 6/7] blk-cgroup: allocate pds before freezing queue in blkcg_activate_policy()
Date: Tue,  3 Feb 2026 16:06:01 +0800
Message-ID: <20260203080602.726505-7-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260203080602.726505-1-yukuai@fnnas.com>
References: <20260203080602.726505-1-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13630-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[fnnas.com];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FROM_NEQ_ENVFROM(0.00)[yukuai@fnnas.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fnnas.com:mid,fnnas.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2B1ECD6093
X-Rspamd-Action: no action

Some policies like iocost and iolatency perform percpu allocation in
pd_alloc_fn(). Percpu allocation with queue frozen can cause deadlock
because percpu memory reclaim may issue IO.

Now that q->blkg_list is protected by blkcg_mutex, restructure
blkcg_activate_policy() to allocate all pds before freezing the queue:
1. Allocate all pds with GFP_KERNEL before freezing the queue
2. Freeze the queue
3. Initialize and online all pds

Note: Future work is to remove all queue freezing before
blkcg_activate_policy() to fix the deadlocks thoroughly.

Signed-off-by: Yu Kuai <yukuai@fnnas.com>
---
 block/blk-cgroup.c | 90 +++++++++++++++++-----------------------------
 1 file changed, 32 insertions(+), 58 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 0206050f81ea..7fcb216917d0 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1606,8 +1606,7 @@ static void blkcg_policy_teardown_pds(struct request_queue *q,
 int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 {
 	struct request_queue *q = disk->queue;
-	struct blkg_policy_data *pd_prealloc = NULL;
-	struct blkcg_gq *blkg, *pinned_blkg = NULL;
+	struct blkcg_gq *blkg;
 	unsigned int memflags;
 	int ret;
 
@@ -1622,90 +1621,65 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 	if (WARN_ON_ONCE(!pol->pd_alloc_fn || !pol->pd_free_fn))
 		return -EINVAL;
 
-	if (queue_is_mq(q))
-		memflags = blk_mq_freeze_queue(q);
-
+	/*
+	 * Allocate all pds before freezing queue. Some policies like iocost
+	 * and iolatency do percpu allocation in pd_alloc_fn(), which can
+	 * deadlock with queue frozen because percpu memory reclaim may issue
+	 * IO. blkcg_mutex protects q->blkg_list iteration.
+	 */
 	mutex_lock(&q->blkcg_mutex);
-retry:
-	spin_lock_irq(&q->queue_lock);
-
-	/* blkg_list is pushed at the head, reverse walk to initialize parents first */
 	list_for_each_entry_reverse(blkg, &q->blkg_list, q_node) {
 		struct blkg_policy_data *pd;
 
-		if (blkg->pd[pol->plid])
-			continue;
+		/* Skip dying blkg */
 		if (hlist_unhashed(&blkg->blkcg_node))
 			continue;
 
-		/* If prealloc matches, use it; otherwise try GFP_NOWAIT */
-		if (blkg == pinned_blkg) {
-			pd = pd_prealloc;
-			pd_prealloc = NULL;
-		} else {
-			pd = pol->pd_alloc_fn(disk, blkg->blkcg,
-					      GFP_NOWAIT);
-		}
-
+		pd = pol->pd_alloc_fn(disk, blkg->blkcg, GFP_KERNEL);
 		if (!pd) {
-			/*
-			 * GFP_NOWAIT failed.  Free the existing one and
-			 * prealloc for @blkg w/ GFP_KERNEL.
-			 */
-			if (pinned_blkg)
-				blkg_put(pinned_blkg);
-			blkg_get(blkg);
-			pinned_blkg = blkg;
-
-			spin_unlock_irq(&q->queue_lock);
-
-			if (pd_prealloc)
-				pol->pd_free_fn(pd_prealloc);
-			pd_prealloc = pol->pd_alloc_fn(disk, blkg->blkcg,
-						       GFP_KERNEL);
-			if (pd_prealloc)
-				goto retry;
-			else
-				goto enomem;
+			ret = -ENOMEM;
+			goto err_teardown;
 		}
 
-		spin_lock(&blkg->blkcg->lock);
-
 		pd->blkg = blkg;
 		pd->plid = pol->plid;
+		pd->online = false;
 		blkg->pd[pol->plid] = pd;
+	}
 
+	/* Now freeze queue and initialize/online all pds */
+	if (queue_is_mq(q))
+		memflags = blk_mq_freeze_queue(q);
+
+	spin_lock_irq(&q->queue_lock);
+	list_for_each_entry_reverse(blkg, &q->blkg_list, q_node) {
+		struct blkg_policy_data *pd = blkg->pd[pol->plid];
+
+		/* Skip dying blkg */
+		if (hlist_unhashed(&blkg->blkcg_node))
+			continue;
+
+		spin_lock(&blkg->blkcg->lock);
 		if (pol->pd_init_fn)
 			pol->pd_init_fn(pd);
-
 		if (pol->pd_online_fn)
 			pol->pd_online_fn(pd);
 		pd->online = true;
-
 		spin_unlock(&blkg->blkcg->lock);
 	}
 
 	__set_bit(pol->plid, q->blkcg_pols);
-	ret = 0;
-
 	spin_unlock_irq(&q->queue_lock);
-out:
-	mutex_unlock(&q->blkcg_mutex);
+
 	if (queue_is_mq(q))
 		blk_mq_unfreeze_queue(q, memflags);
-	if (pinned_blkg)
-		blkg_put(pinned_blkg);
-	if (pd_prealloc)
-		pol->pd_free_fn(pd_prealloc);
-	return ret;
+	mutex_unlock(&q->blkcg_mutex);
+	return 0;
 
-enomem:
-	/* alloc failed, take down everything */
-	spin_lock_irq(&q->queue_lock);
+err_teardown:
 	blkcg_policy_teardown_pds(q, pol);
-	spin_unlock_irq(&q->queue_lock);
-	ret = -ENOMEM;
-	goto out;
+	mutex_unlock(&q->blkcg_mutex);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(blkcg_activate_policy);
 
-- 
2.51.0


