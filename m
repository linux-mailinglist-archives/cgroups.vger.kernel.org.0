Return-Path: <cgroups+bounces-16610-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MmKoAsAuIGoiyQAAu9opvQ
	(envelope-from <cgroups+bounces-16610-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 15:40:16 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 761CC638288
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 15:40:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16610-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16610-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=fygo.io (policy=quarantine);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0994231840D7
	for <lists+cgroups@lfdr.de>; Wed,  3 Jun 2026 13:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E2D326924;
	Wed,  3 Jun 2026 13:28:14 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB4B48124B;
	Wed,  3 Jun 2026 13:28:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780493294; cv=none; b=vCX0rsTDJEmWp/z67QKEYCx3lYtaD1tGLRZ5uHFNUn3xBUd4StXxfqqQmR52Z8H0oQOySU9oQYVg8IszKdKR/N+ndlAUK2JZi0tpKRPxg02FUYHJViERDysKEZXp4Uk0zlFCKuuwXnUn2Wrlwg0uBf5iHlLkwmoA5G8IUho/sP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780493294; c=relaxed/simple;
	bh=XqpEPvX8NJrnkxm1dggQtpiLAF+Fa7ePz9pr8gbnEA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a7870rURQ7KE380q9iWaFcROUJ+TFlyi2Z4PjaEdDXrsCP++Wi5iKua4+HqhMv3I0DPtM0S2pWt2ov2CF+6pMB/onFDUvqICNoW6z21SOFf7+1+WI6Ntvm0jHnX9EfZbePu5nM1HsmXtsvnIRpmuzRO+6Eal5IzZR991WDOfF1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 862AC1F00893;
	Wed,  3 Jun 2026 13:28:07 +0000 (UTC)
From: Yu Kuai <yukuai@fygo.io>
To: Jens Axboe <axboe@kernel.dk>
Cc: Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Ming Lei <tom.leiming@gmail.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Bart Van Assche <bvanassche@acm.org>,
	linux-block@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] blk-cgroup: factor policy pd teardown loop into helper
Date: Wed,  3 Jun 2026 21:27:45 +0800
Message-ID: <b23df513de562739af61fa61ba80ef5e8059a636.1780492756.git.yukuai@fygo.io>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1780492756.git.yukuai@fygo.io>
References: <cover.1780492756.git.yukuai@fygo.io>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[fygo.io : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16610-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,toxicpanda.com,gmail.com,linux.ibm.com,acm.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:axboe@kernel.dk,m:tj@kernel.org,m:josef@toxicpanda.com,m:tom.leiming@gmail.com,m:nilay@linux.ibm.com,m:bvanassche@acm.org,m:linux-block@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:tomleiming@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[yukuai@fygo.io,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yukuai@fygo.io,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email,vger.kernel.org:from_smtp,fygo.io:mid,fygo.io:from_mime,fygo.io:email,lst.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 761CC638288

From: Zheng Qixing <zhengqixing@huawei.com>

Move the teardown sequence which offlines and frees per-policy
blkg_policy_data (pd) into a helper for readability.

No functional change intended.

Signed-off-by: Zheng Qixing <zhengqixing@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Yu Kuai <yukuai@fygo.io>
Signed-off-by: Yu Kuai <yukuai@fygo.io>
---
 block/blk-cgroup.c | 57 ++++++++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 30 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index b479a9796fb3..c75b2a103bbc 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1575,10 +1575,35 @@ struct cgroup_subsys io_cgrp_subsys = {
 	.depends_on = 1 << memory_cgrp_id,
 #endif
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
  * @pol: blkcg policy to activate
  *
@@ -1690,25 +1715,11 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 	return ret;
 
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
 }
 EXPORT_SYMBOL_GPL(blkcg_activate_policy);
@@ -1723,11 +1734,10 @@ EXPORT_SYMBOL_GPL(blkcg_activate_policy);
  */
 void blkcg_deactivate_policy(struct gendisk *disk,
 			     const struct blkcg_policy *pol)
 {
 	struct request_queue *q = disk->queue;
-	struct blkcg_gq *blkg;
 	unsigned int memflags;
 
 	if (!blkcg_policy_enabled(q, pol))
 		return;
 
@@ -1736,24 +1746,11 @@ void blkcg_deactivate_policy(struct gendisk *disk,
 
 	mutex_lock(&q->blkcg_mutex);
 	spin_lock_irq(&q->queue_lock);
 
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
 
 	if (queue_is_mq(q))
 		blk_mq_unfreeze_queue(q, memflags);
-- 
2.51.0


