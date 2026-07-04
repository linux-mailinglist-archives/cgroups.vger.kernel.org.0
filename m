Return-Path: <cgroups+bounces-17501-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id E6WdDKZnSWrf1QAAu9opvQ
	(envelope-from <cgroups+bounces-17501-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 04 Jul 2026 22:05:58 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F61708638
	for <lists+cgroups@lfdr.de>; Sat, 04 Jul 2026 22:05:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=W9t8sfih;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17501-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17501-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23BCB3030EA6
	for <lists+cgroups@lfdr.de>; Sat,  4 Jul 2026 19:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFAE3264E2;
	Sat,  4 Jul 2026 19:54:47 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0800218592;
	Sat,  4 Jul 2026 19:54:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783194887; cv=none; b=a5KDbHhFcnAb6sIIHZD7ptEMHtpxrHvDArcDbvEPm/B9p/ebGO61kbI/z138re1/FAKO+qFwflxy03mnKp9e/WqYNET4cSfcB1l84L8u+xkFVyQz2VtW28xPntxHhmgB9bb6kctCCAI60GapyBFtkYEnTBQ0vcZdFP68f7RfQas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783194887; c=relaxed/simple;
	bh=EgeW/2HUTU1L/CMgTORmink2PHRSy2jnHAzgA30/0fY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MxwnsQZuoEvEgrh8jplJQTTDWNBK/kGLr9A7Gs7UdxQviet/g08Ip1q+w93Fo1tOwBgv1HKVQ1Wa4IGcALto9YSLApR7h+bqmwftJq/t7OQtYQ5vHRB3fFZIil3Vbxee11MpRB/HEOEVMLLaH/QviHftTsdvRykpL1rqy6LEyY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9t8sfih; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BDEE1F00A3A;
	Sat,  4 Jul 2026 19:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783194885;
	bh=SHO/IKf0hf1vom6GLxEm19lohgGlQ1ire0BZCZ/aIWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W9t8sfihz9GssvPct9Dv85gL7LLLw2/KSFVhIKfwBB0g7sVAG2FzGMdDNcZ6uVzhV
	 78J+lYT74B00WF1vYAS6f4DfpW5wUH+rBaF3uzuQ+VYOsJGiQ6BFqV4hv43vlQwY9Y
	 5lRazO7TWEm36RsIM5lobSacZyZJvyTwFbdAODeH/cKc5NEUK9H6cy/Kh8T1uLun5J
	 6ByZoMwh2tvc5cuA1C22nnZ1Y/ZEm2dTx+2AkaOg4Ngmix9XzVdg2LFlYlaBjbfH6P
	 VN+L4E+CAYzuuDb+F7CM0bOKR0HJhR5yUzeC7JtjV2Rgg2UtRx1MuL4WZlqr4W/BIj
	 qoynwfas9hn5g==
From: Yu Kuai <yukuai@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alasdair Kergon <agk@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Dongsheng Yang <dongsheng.yang@linux.dev>,
	Zheng Gu <cengku@gmail.com>,
	Coly Li <colyli@fygo.io>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Josef Bacik <josef@toxicpanda.com>,
	Yu Kuai <yukuai@fygo.io>,
	Nilay Shroff <nilay@linux.ibm.com>,
	linux-block@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	dm-devel@lists.linux.dev,
	linux-bcache@vger.kernel.org
Subject: [RFC PATCH v1 16/17] blk-cgroup: allocate blkgs in blkg_create
Date: Sun,  5 Jul 2026 03:51:23 +0800
Message-ID: <20260704195124.1375075-17-yukuai@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260704195124.1375075-1-yukuai@kernel.org>
References: <20260704195124.1375075-1-yukuai@kernel.org>
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
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20260515];
	TAGGED_FROM(0.00)[bounces-17501-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:axboe@kernel.dk,m:tj@kernel.org,m:hch@lst.de,m:kbusch@kernel.org,m:sagi@grimberg.me,m:agk@redhat.com,m:bmarzins@redhat.com,m:snitzer@kernel.org,m:mpatocka@redhat.com,m:dongsheng.yang@linux.dev,m:cengku@gmail.com,m:colyli@fygo.io,m:kent.overstreet@linux.dev,m:josef@toxicpanda.com,m:yukuai@fygo.io,m:nilay@linux.ibm.com,m:linux-block@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:dm-devel@lists.linux.dev,m:linux-bcache@vger.kernel.org,s:lists@lfdr.de];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER(0.00)[yukuai@kernel.org,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lst.de,kernel.org,grimberg.me,redhat.com,linux.dev,gmail.com,fygo.io,toxicpanda.com,linux.ibm.com,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yukuai@kernel.org,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fygo.io:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 80F61708638

From: Yu Kuai <yukuai@fygo.io>

After radix tree preloading is gone, callers no longer need to allocate a
blkg before entering blkg_create(). Move allocation into blkg_create() and
pass the desired GFP mask instead.

Use GFP_NOIO for runtime and config blkg creation so slow paths can sleep
without recursing into IO reclaim, keep GFP_KERNEL for root blkg setup, and
use GFP_ATOMIC when nowait bio association creates a missing blkg after a
successful q->blkcg_mutex trylock.

Signed-off-by: Yu Kuai <yukuai@fygo.io>
---
 block/blk-cgroup.c | 89 ++++++++++------------------------------------
 1 file changed, 18 insertions(+), 71 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index b99ab8d67798..ddc9073d7ab9 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -371,14 +371,10 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct gendisk *disk,
 	return NULL;
 }
 
-/*
- * If @new_blkg is %NULL, this function tries to allocate a new one as
- * necessary using %GFP_NOWAIT.  @new_blkg is always consumed on return.
- */
 static struct blkcg_gq *blkg_create(struct blkcg *blkcg, struct gendisk *disk,
-				    struct blkcg_gq *new_blkg)
+				    gfp_t gfp_mask)
 {
-	struct blkcg_gq *blkg;
+	struct blkcg_gq *blkg = NULL;
 	int i, ret;
 
 	lockdep_assert_held(&disk->queue->blkcg_mutex);
@@ -389,15 +385,11 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg, struct gendisk *disk,
 		goto err_free_blkg;
 	}
 
-	/* allocate */
-	if (!new_blkg) {
-		new_blkg = blkg_alloc(blkcg, disk, GFP_NOWAIT);
-		if (unlikely(!new_blkg)) {
-			ret = -ENOMEM;
-			goto err_free_blkg;
-		}
+	blkg = blkg_alloc(blkcg, disk, gfp_mask);
+	if (unlikely(!blkg)) {
+		ret = -ENOMEM;
+		goto err_free_blkg;
 	}
-	blkg = new_blkg;
 
 	/* link parent */
 	if (blkcg_parent(blkcg)) {
@@ -447,8 +439,8 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg, struct gendisk *disk,
 	return ERR_PTR(ret);
 
 err_free_blkg:
-	if (new_blkg)
-		blkg_free(new_blkg);
+	if (blkg)
+		blkg_free(blkg);
 	return ERR_PTR(ret);
 }
 
@@ -505,7 +497,7 @@ static struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
 		}
 		rcu_read_unlock();
 
-		blkg = blkg_create(pos, disk, NULL);
+		blkg = blkg_create(pos, disk, GFP_NOIO);
 		if (IS_ERR(blkg)) {
 			blkg = ret_blkg;
 			break;
@@ -858,7 +850,6 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 	while (true) {
 		struct blkcg *pos = blkcg;
 		struct blkcg *parent;
-		struct blkcg_gq *new_blkg;
 
 		parent = blkcg_parent(blkcg);
 		rcu_read_lock();
@@ -868,14 +859,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 		}
 		rcu_read_unlock();
 
-		new_blkg = blkg_alloc(pos, disk, GFP_NOIO);
-		if (unlikely(!new_blkg)) {
-			ret = -ENOMEM;
-			goto fail_unlock;
-		}
-
 		if (!blkcg_policy_enabled(q, pol)) {
-			blkg_free(new_blkg);
 			ret = -EOPNOTSUPP;
 			goto fail_unlock;
 		}
@@ -883,10 +867,8 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 		rcu_read_lock();
 		blkg = blkg_lookup(pos, q);
 		rcu_read_unlock();
-		if (blkg) {
-			blkg_free(new_blkg);
-		} else {
-			blkg = blkg_create(pos, disk, new_blkg);
+		if (!blkg) {
+			blkg = blkg_create(pos, disk, GFP_NOIO);
 			if (IS_ERR(blkg)) {
 				ret = PTR_ERR(blkg);
 				goto fail_unlock;
@@ -1436,7 +1418,7 @@ void blkg_init_queue(struct request_queue *q)
 int blkcg_init_disk(struct gendisk *disk)
 {
 	struct request_queue *q = disk->queue;
-	struct blkcg_gq *new_blkg, *blkg;
+	struct blkcg_gq *blkg;
 
 	/*
 	 * If the queue is shared across disk rebind (e.g., SCSI), the
@@ -1450,13 +1432,9 @@ int blkcg_init_disk(struct gendisk *disk)
 	 */
 	wait_var_event(&q->root_blkg, !READ_ONCE(q->root_blkg));
 
-	new_blkg = blkg_alloc(&blkcg_root, disk, GFP_KERNEL);
-	if (!new_blkg)
-		return -ENOMEM;
-
 	/* Make sure the root blkg exists. */
 	mutex_lock(&q->blkcg_mutex);
-	blkg = blkg_create(&blkcg_root, disk, new_blkg);
+	blkg = blkg_create(&blkcg_root, disk, GFP_KERNEL);
 	if (IS_ERR(blkg))
 		goto err_unlock;
 	q->root_blkg = blkg;
@@ -1559,8 +1537,7 @@ static void blkg_free_policy_data(struct blkcg_gq *blkg,
 int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 {
 	struct request_queue *q = disk->queue;
-	struct blkg_policy_data *pd_prealloc = NULL;
-	struct blkcg_gq *blkg, *pinned_blkg = NULL;
+	struct blkcg_gq *blkg;
 	unsigned int memflags;
 	int ret;
 
@@ -1578,7 +1555,6 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 	if (queue_is_mq(q))
 		memflags = blk_mq_freeze_queue(q);
 
-retry:
 	mutex_lock(&q->blkcg_mutex);
 
 	/* blkg_list is pushed at the head, reverse walk to initialize parents first */
@@ -1590,34 +1566,9 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 		if (hlist_unhashed(&blkg->blkcg_node))
 			continue;
 
-		/* If prealloc matches, use it; otherwise try GFP_NOWAIT. */
-		if (blkg == pinned_blkg) {
-			pd = pd_prealloc;
-			pd_prealloc = NULL;
-		} else {
-			pd = pol->pd_alloc_fn(disk, blkg->blkcg, GFP_NOWAIT);
-		}
-
-		if (!pd) {
-			/*
-			 * GFP_NOWAIT failed.  Free the existing one and
-			 * prealloc for @blkg w/ GFP_KERNEL.
-			 */
-			if (pinned_blkg)
-				blkg_put(pinned_blkg);
-			blkg_get(blkg);
-			pinned_blkg = blkg;
-
-			mutex_unlock(&q->blkcg_mutex);
-
-			if (pd_prealloc)
-				pol->pd_free_fn(pd_prealloc);
-			pd_prealloc = pol->pd_alloc_fn(disk, blkg->blkcg,
-						       GFP_KERNEL);
-			if (pd_prealloc)
-				goto retry;
+		pd = pol->pd_alloc_fn(disk, blkg->blkcg, GFP_NOIO);
+		if (!pd)
 			goto enomem;
-		}
 
 		spin_lock_irq(&blkg->blkcg->lock);
 
@@ -1642,15 +1593,10 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 	mutex_unlock(&q->blkcg_mutex);
 	if (queue_is_mq(q))
 		blk_mq_unfreeze_queue(q, memflags);
-	if (pinned_blkg)
-		blkg_put(pinned_blkg);
-	if (pd_prealloc)
-		pol->pd_free_fn(pd_prealloc);
 	return ret;
 
 enomem:
 	/* alloc failed, take down everything */
-	mutex_lock(&q->blkcg_mutex);
 	list_for_each_entry(blkg, &q->blkg_list, q_node)
 		blkg_free_policy_data(blkg, pol);
 	ret = -ENOMEM;
@@ -2080,7 +2026,8 @@ static inline struct blkcg_gq *blkg_tryget_closest(struct bio *bio,
 		if (!preemptible() || !mutex_trylock(&q->blkcg_mutex))
 			return NULL;
 
-		blkg = blkg_lookup_create(blkcg, bio->bi_bdev->bd_disk);
+		blkg = blkg_lookup_create(blkcg, bio->bi_bdev->bd_disk,
+					  GFP_ATOMIC);
 		if (blkg)
 			blkg = blkg_lookup_tryget(blkg);
 		mutex_unlock(&q->blkcg_mutex);
-- 
2.51.0


