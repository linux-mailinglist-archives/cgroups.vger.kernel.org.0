Return-Path: <cgroups+bounces-14593-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMQmBp3hp2mrlAAAu9opvQ
	(envelope-from <cgroups+bounces-14593-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 04 Mar 2026 08:39:09 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 025911FBB40
	for <lists+cgroups@lfdr.de>; Wed, 04 Mar 2026 08:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 43411303DA37
	for <lists+cgroups@lfdr.de>; Wed,  4 Mar 2026 07:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E033C372EEE;
	Wed,  4 Mar 2026 07:38:29 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B683E36DA10;
	Wed,  4 Mar 2026 07:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772609909; cv=none; b=j90V6ge3NtrPhbfwUJZK7Mqm7fZSaopXEtHUltP+M4PCwvzwBOuXXFpIhk/gUcvYriw2BvyygQz6Ze69hBCv+SfQXSk/kIeUcvqrzAYuD51xpWEM74SyzXc7s7d50hlYOiEZIPk00eHxmLHeVbk1KYyxCgzS4yd2fYqElMgP/4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772609909; c=relaxed/simple;
	bh=1a00pmprAMpOcZecOaCGFQeMRGnRmri34kTsVuS/N9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rc4HO4CsMP6YCNyRHZI2XwF4xjycOBX+C/g29Ko/eZaa7Y226wpPFDeXNksKgLtVQZgUxHydqIUgvcSjHiPaL0Rmg1CoRRKsxR2/uFnTvLmHvlcm7RqziyVrXkDY5TB5GJv9a9gapyop0KJK+RmPcHYi5oFxVaPEXmyG7bVz+KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE8FC19425;
	Wed,  4 Mar 2026 07:38:27 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zheng Qixing <zhengqixing@huawei.com>,
	Ming Lei <ming.lei@redhat.com>,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v3 6/7] blk-cgroup: allocate pds before freezing queue in blkcg_activate_policy()
Date: Wed,  4 Mar 2026 15:38:07 +0800
Message-ID: <20260304073809.3438679-7-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260304073809.3438679-1-yukuai@fnnas.com>
References: <20260304073809.3438679-1-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 025911FBB40
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14593-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[fnnas.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FROM_NEQ_ENVFROM(0.00)[yukuai@fnnas.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fnnas.com:mid,fnnas.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
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
 block/blk-cgroup.c | 95 +++++++++++++++++-----------------------------
 1 file changed, 35 insertions(+), 60 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 0206050f81ea..1620be75f124 100644
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
+
+	/* Now freeze queue and initialize/online all pds */
+	if (queue_is_mq(q))
+		memflags = blk_mq_freeze_queue(q);
 
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
 
@@ -1726,18 +1700,19 @@ void blkcg_deactivate_policy(struct gendisk *disk,
 	if (!blkcg_policy_enabled(q, pol))
 		return;
 
+	/* Same locking order as blkcg_activate_policy(): mutex -> freeze */
+	mutex_lock(&q->blkcg_mutex);
 	if (queue_is_mq(q))
 		memflags = blk_mq_freeze_queue(q);
 
-	mutex_lock(&q->blkcg_mutex);
 	spin_lock_irq(&q->queue_lock);
 	__clear_bit(pol->plid, q->blkcg_pols);
 	blkcg_policy_teardown_pds(q, pol);
 	spin_unlock_irq(&q->queue_lock);
-	mutex_unlock(&q->blkcg_mutex);
 
 	if (queue_is_mq(q))
 		blk_mq_unfreeze_queue(q, memflags);
+	mutex_unlock(&q->blkcg_mutex);
 }
 EXPORT_SYMBOL_GPL(blkcg_deactivate_policy);
 
-- 
2.51.0


