Return-Path: <cgroups+bounces-17221-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4GryM7SAO2qrYwgAu9opvQ
	(envelope-from <cgroups+bounces-17221-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 09:01:08 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D626BBFA0
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 09:01:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ZK1Pq3mD;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17221-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17221-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 15C23311F48A
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 06:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0919F395ADA;
	Wed, 24 Jun 2026 06:46:54 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41F03955EA;
	Wed, 24 Jun 2026 06:46:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782283613; cv=none; b=mm1k4VFh7KLasTXbGfuOJ0QZz0OVclqkJnNJqRlazkJdbvwnoz5aaaNQCIv/I3kHBwxBpDN2xXHZ2B/3BDxEpd+FKKP30/S4Hlog41EjcmAl0h984FH4Y5HR3ZCd4RsDl4wQuEOHEjM9ryUObPjoLJb7i47Wfpf2uL3Xm88/jTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782283613; c=relaxed/simple;
	bh=/Ir0nJeoylt70qoJtP0XcnKBijF9YDuvk20DSPkgma0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YoAjl9gjH7ZP3ud9Vh/hR/hqMUHXn1JZg6caGo3dx4lgAutHYvp+M6j6WE/W143Au3AS146gPhg9nzoS/ShfKcbvF+OflCXkkL+r6CZm2eTFsvTPNQwTnsR4buJgwhTw4fOgRWDJCBiqZdpBHhfWHIl98x8ny6Ly38JpEFepKZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZK1Pq3mD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8321F00A3A;
	Wed, 24 Jun 2026 06:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782283612;
	bh=/jhyEzLhlRY3W/q9WunOA1TaDwZ+p7tN5yujXEUTAzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZK1Pq3mDY6kEI1rYWo5je+TQovD7OsaypfFpW/KIyKYUdCX1LTn9eRjIuyAEYNdqg
	 8fiJvOUvixBPjjCdzcpJzkroEWHIvDd6eIrucaOc0sZGieVWuPZdFMwz+9d22uDTud
	 Fw0AOjVPBJgNrKoOIP3sP+rGw2LyaXEGkVAYQe6m17tT1yC6x7g2CxA6GDXAU1Jm5v
	 ZFm3Zx8NYpDekEp5Xz7x5s0fTUxMOC6yht6+n6t8+AC5Ro7wzIpxUFv9SjfXvtVp5f
	 8Mq4PqAbDinicYyGxJ5s4KAE+kWnsqtJ0LZsq0SdOKCv/pdC7YeylnMb2GeNmcxWkZ
	 9U9Z+I9rw9c0w==
From: Yu Kuai <yukuai@kernel.org>
To: Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Zheng Qixing <zhengqixing@huawei.com>,
	Christoph Hellwig <hch@lst.de>,
	Tang Yizhou <yizhou.tang@shopee.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Ming Lei <ming.lei@redhat.com>,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] blk-cgroup: factor policy pd teardown loop into helper
Date: Wed, 24 Jun 2026 14:46:25 +0800
Message-ID: <20260624064625.1743650-7-yukuai@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260624064625.1743650-1-yukuai@kernel.org>
References: <20260624064625.1743650-1-yukuai@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [5.84 / 15.00];
	URIBL_BLACK(7.50)[fygo.io:email];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17221-lists,cgroups=lfdr.de];
	FORGED_SENDER(0.00)[yukuai@kernel.org,cgroups@vger.kernel.org];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20260515];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:tj@kernel.org,m:josef@toxicpanda.com,m:axboe@kernel.dk,m:zhengqixing@huawei.com,m:hch@lst.de,m:yizhou.tang@shopee.com,m:nilay@linux.ibm.com,m:ming.lei@redhat.com,m:cgroups@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,body];
	FORWARDED(0.00)[lists@lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yukuai@kernel.org,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114:c];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,fygo.io:email,shopee.com:email,vger.kernel.org:from_smtp,lst.de:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 54D626BBFA0

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
index 2538d8105e6c..e5e95be4fbc0 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1526,10 +1526,35 @@ struct cgroup_subsys io_cgrp_subsys = {
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
@@ -1641,25 +1666,11 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
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
@@ -1674,11 +1685,10 @@ EXPORT_SYMBOL_GPL(blkcg_activate_policy);
  */
 void blkcg_deactivate_policy(struct gendisk *disk,
 			     const struct blkcg_policy *pol)
 {
 	struct request_queue *q = disk->queue;
-	struct blkcg_gq *blkg;
 	unsigned int memflags;
 
 	if (!blkcg_policy_enabled(q, pol))
 		return;
 
@@ -1687,24 +1697,11 @@ void blkcg_deactivate_policy(struct gendisk *disk,
 
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


