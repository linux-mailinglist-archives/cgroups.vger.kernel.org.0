Return-Path: <cgroups+bounces-17277-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yLTRLZ+ZPGrspggAu9opvQ
	(envelope-from <cgroups+bounces-17277-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 04:59:43 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5124E6C2801
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 04:59:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=LHP7PtwG;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17277-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17277-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52D3230BAE27
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 02:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3199379C5C;
	Thu, 25 Jun 2026 02:57:58 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB99388377;
	Thu, 25 Jun 2026 02:57:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782356278; cv=none; b=hVTAdoXwUfqFNq40dYoX4WT2XJM7oUX1eyEPOAQgzoHAxyzVaS9MipZuOY1XNN4i4HinG9Xi+SUe0wGmznVcxAEUNNKQkZzjk9esjJjTXlUgut8vgAmAjaC9bX7oWQkumlixRo0oRHHQM0TB3qCzb1QGuqlmutQBgvKhLOh5LCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782356278; c=relaxed/simple;
	bh=uOD82C8mec8CAxZxFR+Dg5Tpq8YFbEeacD75CJlYhgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bslMnbNZiz1ATbnOYDGyNQu9jSqqqVZJ2zcZXVWK4wCwl9pdtmgmdGYnkhEWsFVdM5GhU30naD9KhcNMqpGgKJYWNVdtzOyeZ19gkNqTut+LfSNZMugyOHDuYEhElG895/GqdX98A1RThiOsW8COr3isvSfnTQJFIcZ58ptYhm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHP7PtwG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF37C1F000E9;
	Thu, 25 Jun 2026 02:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782356277;
	bh=lmva5U9/Dxf4M+P1slg0drCq2hV4wzNvCdBMuvYn+bs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LHP7PtwGgSAtCTqetMBGbF+75oAqPGSQrbBBAvo64qTLktNBmrT+d0Fj8WMFL2JHP
	 kB8hhOC4Ud/OoEcjeAG3FKKxPvLw5bicQiOrM+LZYF30ppbHSlIytWhF1xAVy4AysJ
	 ZIiDMsjhszrK/QCQecR2PCOqt506gRevF2/qMN+Ihx022OIdVhfASDN1sAAckJzr/B
	 VMV2TWZ3KUhpRrbvIeIIC0FtQ45mHUaAAFvRs68ioRqOGeoG4Gk+OXbD8n3zeEfkPz
	 62Q7eV557NCu7YMb5/XrK53KjWgb6u1UK1L35LPuJJeoCvZ5x74/pHj3YPmj1TYzz7
	 e/c7TIbqrv6cA==
From: Yu Kuai <yukuai@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>,
	Zheng Qixing <zhengqixing@huawei.com>,
	Christoph Hellwig <hch@lst.de>,
	Tang Yizhou <yizhou.tang@shopee.com>,
	Yu Kuai <yukuai@fygo.io>,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] blk-cgroup: factor policy pd teardown loop into helper
Date: Thu, 25 Jun 2026 10:57:39 +0800
Message-ID: <20260625025739.2459651-5-yukuai@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260625025739.2459651-1-yukuai@kernel.org>
References: <20260625025739.2459651-1-yukuai@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17277-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:axboe@kernel.dk,m:tj@kernel.org,m:josef@toxicpanda.com,m:zhengqixing@huawei.com,m:hch@lst.de,m:yizhou.tang@shopee.com,m:yukuai@fygo.io,m:cgroups@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[yukuai@kernel.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yukuai@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,huawei.com:email,vger.kernel.org:from_smtp,shopee.com:email,lst.de:email,fygo.io:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5124E6C2801

From: Zheng Qixing <zhengqixing@huawei.com>

Move the teardown sequence which offlines and frees per-policy
blkg_policy_data (pd) into a helper for readability.

No functional change intended.

Signed-off-by: Zheng Qixing <zhengqixing@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Tang Yizhou <yizhou.tang@shopee.com>
Signed-off-by: Yu Kuai <yukuai@fygo.io>
---
 block/blk-cgroup.c | 57 ++++++++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 30 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index d06915045bc4..0b28420c108f 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1527,10 +1527,35 @@ struct cgroup_subsys io_cgrp_subsys = {
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
+			WRITE_ONCE(blkg->pd[pol->plid], NULL);
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
@@ -1642,25 +1667,11 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
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
-			WRITE_ONCE(blkg->pd[pol->plid], NULL);
-		}
-		spin_unlock(&blkcg->lock);
-	}
+	blkcg_policy_teardown_pds(q, pol);
 	spin_unlock_irq(&q->queue_lock);
 	ret = -ENOMEM;
 	goto out;
 }
 EXPORT_SYMBOL_GPL(blkcg_activate_policy);
@@ -1675,11 +1686,10 @@ EXPORT_SYMBOL_GPL(blkcg_activate_policy);
  */
 void blkcg_deactivate_policy(struct gendisk *disk,
 			     const struct blkcg_policy *pol)
 {
 	struct request_queue *q = disk->queue;
-	struct blkcg_gq *blkg;
 	unsigned int memflags;
 
 	if (!blkcg_policy_enabled(q, pol))
 		return;
 
@@ -1688,24 +1698,11 @@ void blkcg_deactivate_policy(struct gendisk *disk,
 
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


