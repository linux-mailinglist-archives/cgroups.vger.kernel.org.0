Return-Path: <cgroups+bounces-17489-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zkAkGaZkSWrM1AAAu9opvQ
	(envelope-from <cgroups+bounces-17489-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 04 Jul 2026 21:53:10 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2D9708536
	for <lists+cgroups@lfdr.de>; Sat, 04 Jul 2026 21:53:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=MMNJdnVy;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17489-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17489-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81C073028B67
	for <lists+cgroups@lfdr.de>; Sat,  4 Jul 2026 19:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8843F30D3F8;
	Sat,  4 Jul 2026 19:52:39 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB61282F01;
	Sat,  4 Jul 2026 19:52:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783194759; cv=none; b=ZKyA4kuHeyei5ZgH2Hks5B2AHP4AfGN8dDb4IAxen2t1BvM+02eErfOSkY6dUy6IPMJUDgh1WZACqRb2SSo5sRdEsKR/QnE2iZn0+RQyzvxno6xQLx71Z8tGm9WwnKdxNOb8y7UFh6Piw3Hvmr45QYwrf120rwqG6h8TfYGT8dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783194759; c=relaxed/simple;
	bh=JhCwcu115MAGCYR9pYIwu2g8JdMZyMfQEghyJaimgfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VXeVgFLqXLyLk8Fw2OHj07vbrDhMme9zQFoeJPW1SnjKA8bfDr5r6s5QmUVxkiJKiDkoTCNyT+QLQXX2Qb9vOAqFfqVhRBNBOc8xL3F0xALdA4tPy3NdDYVjLMQceX2fMXHTw7L74XgK7MtPKvL5cT6MTVeXGzDOvOTZkL5u4zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MMNJdnVy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA5491F00A3A;
	Sat,  4 Jul 2026 19:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783194757;
	bh=9brV8EHs1XB3cVBkQXkrL51M4jRovqFzRidZQ3jum2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MMNJdnVyBHRTKj6EWDI+k2x3oNf69v/gzhhu51ZD3smWrSGYr3OdyMh0SyGvi2CHl
	 5TmaBacmSRu4idIiASQjPEBsA5zvKbOh98iHK/EOJbtY6KN/myDhAVEqIdzdGu4Ubz
	 SjPndKLwmMRW2/SnWxugSFSuvl8n+W2U8orMy4rAAIs6d6G4yoBBja4B1Xsv5gr4m0
	 GVS7gI2pxI52rtk9PyldxL8fPmI3Kq/48sVFfrOk5yWZvIZQUzYov6ozUJfTOJpZTR
	 x4J1llghKikvTO50bbnhha7vNeCzg+JVV/mzBfSb8S2MX2acoC4vb3wXQX1LnAGm8V
	 /3HPF2jrlXK5A==
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
Subject: [RFC PATCH v1 04/17] blk-throttle: protect throttle state with td lock
Date: Sun,  5 Jul 2026 03:51:11 +0800
Message-ID: <20260704195124.1375075-5-yukuai@kernel.org>
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
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17489-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:axboe@kernel.dk,m:tj@kernel.org,m:hch@lst.de,m:kbusch@kernel.org,m:sagi@grimberg.me,m:agk@redhat.com,m:bmarzins@redhat.com,m:snitzer@kernel.org,m:mpatocka@redhat.com,m:dongsheng.yang@linux.dev,m:cengku@gmail.com,m:colyli@fygo.io,m:kent.overstreet@linux.dev,m:josef@toxicpanda.com,m:yukuai@fygo.io,m:nilay@linux.ibm.com,m:linux-block@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:dm-devel@lists.linux.dev,m:linux-bcache@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[yukuai@kernel.org,cgroups@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lst.de,kernel.org,grimberg.me,redhat.com,linux.dev,gmail.com,fygo.io,toxicpanda.com,linux.ibm.com,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yukuai@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fygo.io:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EC2D9708536

From: Yu Kuai <yukuai@fygo.io>

Throttle currently uses queue_lock for both blkcg topology and its own
runtime state. This blocks moving blkg topology protection to blkcg_mutex
cleanly.

Add a throttle-private spinlock and use it for throttle service queues,
pending timers, runtime counters and config updates. Keep queue_lock only
where the current intermediate code still walks blkcg topology.

Signed-off-by: Yu Kuai <yukuai@fygo.io>
---
 block/blk-throttle.c | 87 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 67 insertions(+), 20 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index ffc3b70065d4..7bca2805404f 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -30,6 +30,9 @@ static struct workqueue_struct *kthrotld_workqueue;
 
 struct throtl_data
 {
+	/* protects throttle service queues and group runtime state */
+	spinlock_t lock;
+
 	/* service tree for active throtl groups */
 	struct throtl_service_queue service_queue;
 
@@ -346,11 +349,16 @@ static void tg_update_has_rules(struct throtl_grp *tg)
 static void throtl_pd_online(struct blkg_policy_data *pd)
 {
 	struct throtl_grp *tg = pd_to_tg(pd);
+	struct throtl_data *td = tg->td;
+	unsigned long flags;
+
+	spin_lock_irqsave(&td->lock, flags);
 	/*
 	 * We don't want new groups to escape the limits of its ancestors.
 	 * Update has_rules[] after a new group is brought online.
 	 */
 	tg_update_has_rules(tg);
+	spin_unlock_irqrestore(&td->lock, flags);
 }
 
 static void tg_release(struct rcu_head *rcu)
@@ -368,7 +376,7 @@ static void throtl_pd_free(struct blkg_policy_data *pd)
 {
 	struct throtl_grp *tg = pd_to_tg(pd);
 
-	timer_delete_sync(&tg->service_queue.pending_timer);
+	timer_shutdown_sync(&tg->service_queue.pending_timer);
 	call_rcu(&pd->rcu_head, tg_release);
 }
 
@@ -1142,9 +1150,9 @@ static void throtl_pending_timer_fn(struct timer_list *t)
 	else
 		q = td->queue;
 
-	spin_lock_irq(&q->queue_lock);
+	spin_lock_irq(&td->lock);
 
-	if (!q->root_blkg)
+	if (!READ_ONCE(q->root_blkg))
 		goto out_unlock;
 
 again:
@@ -1168,9 +1176,9 @@ static void throtl_pending_timer_fn(struct timer_list *t)
 			break;
 
 		/* this dispatch windows is still open, relax and repeat */
-		spin_unlock_irq(&q->queue_lock);
+		spin_unlock_irq(&td->lock);
 		cpu_relax();
-		spin_lock_irq(&q->queue_lock);
+		spin_lock_irq(&td->lock);
 	}
 
 	if (!dispatched)
@@ -1193,7 +1201,7 @@ static void throtl_pending_timer_fn(struct timer_list *t)
 		queue_work(kthrotld_workqueue, &td->dispatch_work);
 	}
 out_unlock:
-	spin_unlock_irq(&q->queue_lock);
+	spin_unlock_irq(&td->lock);
 }
 
 /**
@@ -1209,7 +1217,6 @@ static void blk_throtl_dispatch_work_fn(struct work_struct *work)
 	struct throtl_data *td = container_of(work, struct throtl_data,
 					      dispatch_work);
 	struct throtl_service_queue *td_sq = &td->service_queue;
-	struct request_queue *q = td->queue;
 	struct bio_list bio_list_on_stack;
 	struct bio *bio;
 	struct blk_plug plug;
@@ -1217,11 +1224,11 @@ static void blk_throtl_dispatch_work_fn(struct work_struct *work)
 
 	bio_list_init(&bio_list_on_stack);
 
-	spin_lock_irq(&q->queue_lock);
+	spin_lock_irq(&td->lock);
 	for (rw = READ; rw <= WRITE; rw++)
 		while ((bio = throtl_pop_queued(td_sq, NULL, rw)))
 			bio_list_add(&bio_list_on_stack, bio);
-	spin_unlock_irq(&q->queue_lock);
+	spin_unlock_irq(&td->lock);
 
 	if (!bio_list_empty(&bio_list_on_stack)) {
 		blk_start_plug(&plug);
@@ -1299,7 +1306,7 @@ static void tg_conf_updated(struct throtl_grp *tg, bool global)
 	rcu_read_unlock();
 
 	/*
-	 * We're already holding queue_lock and know @tg is valid.  Let's
+	 * We're already holding td->lock and know @tg is valid.  Let's
 	 * apply the new config directly.
 	 *
 	 * Restart the slices for both READ and WRITES. It might happen
@@ -1327,6 +1334,7 @@ static int blk_throtl_init(struct gendisk *disk)
 		return -ENOMEM;
 
 	INIT_WORK(&td->dispatch_work, blk_throtl_dispatch_work_fn);
+	spin_lock_init(&td->lock);
 	throtl_service_queue_init(&td->service_queue);
 
 	memflags = blk_mq_freeze_queue(disk->queue);
@@ -1381,6 +1389,7 @@ static ssize_t tg_set_conf(struct kernfs_open_file *of,
 		v = U64_MAX;
 
 	tg = blkg_to_tg(ctx.blkg);
+	spin_lock_irq(&tg->td->lock);
 	tg_update_carryover(tg);
 
 	if (is_u64)
@@ -1389,6 +1398,7 @@ static ssize_t tg_set_conf(struct kernfs_open_file *of,
 		*(unsigned int *)((void *)tg + of_cft(of)->private) = v;
 
 	tg_conf_updated(tg, false);
+	spin_unlock_irq(&tg->td->lock);
 	ret = 0;
 
 unprep:
@@ -1563,6 +1573,7 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
 		goto close_bdev;
 
 	tg = blkg_to_tg(ctx.blkg);
+	spin_lock_irq(&tg->td->lock);
 	tg_update_carryover(tg);
 
 	v[0] = tg->bps[READ];
@@ -1586,11 +1597,11 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
 		p = tok;
 		strsep(&p, "=");
 		if (!p || (sscanf(p, "%llu", &val) != 1 && strcmp(p, "max")))
-			goto unprep;
+			goto unlock;
 
 		ret = -ERANGE;
 		if (!val)
-			goto unprep;
+			goto unlock;
 
 		ret = -EINVAL;
 		if (!strcmp(tok, "rbps"))
@@ -1602,7 +1613,7 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
 		else if (!strcmp(tok, "wiops"))
 			v[3] = min_t(u64, val, UINT_MAX);
 		else
-			goto unprep;
+			goto unlock;
 	}
 
 	tg->bps[READ] = v[0];
@@ -1611,7 +1622,11 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
 	tg->iops[WRITE] = v[3];
 
 	tg_conf_updated(tg, false);
+	spin_unlock_irq(&tg->td->lock);
 	ret = 0;
+	goto unprep;
+unlock:
+	spin_unlock_irq(&tg->td->lock);
 unprep:
 	blkg_conf_unprep(&ctx);
 close_bdev:
@@ -1636,6 +1651,28 @@ static void throtl_shutdown_wq(struct request_queue *q)
 	cancel_work_sync(&td->dispatch_work);
 }
 
+static void throtl_shutdown_timers(struct request_queue *q)
+{
+	struct throtl_data *td = q->td;
+	struct blkcg_gq *blkg;
+
+	/*
+	 * blkg_destroy_all() has already offlined the policy, but blkg policy
+	 * data is freed asynchronously.  Shut down per-group timers before
+	 * freeing td, as their callbacks still dereference tg->td.
+	 */
+	mutex_lock(&q->blkcg_mutex);
+	list_for_each_entry(blkg, &q->blkg_list, q_node) {
+		struct throtl_grp *tg = blkg_to_tg(blkg);
+
+		if (tg)
+			timer_shutdown_sync(&tg->service_queue.pending_timer);
+	}
+	mutex_unlock(&q->blkcg_mutex);
+
+	timer_shutdown_sync(&td->service_queue.pending_timer);
+}
+
 static void tg_flush_bios(struct throtl_grp *tg)
 {
 	struct throtl_service_queue *sq = &tg->service_queue;
@@ -1669,7 +1706,13 @@ static void tg_flush_bios(struct throtl_grp *tg)
 
 static void throtl_pd_offline(struct blkg_policy_data *pd)
 {
-	tg_flush_bios(pd_to_tg(pd));
+	struct throtl_grp *tg = pd_to_tg(pd);
+	struct throtl_data *td = tg->td;
+	unsigned long flags;
+
+	spin_lock_irqsave(&td->lock, flags);
+	tg_flush_bios(tg);
+	spin_unlock_irqrestore(&td->lock, flags);
 }
 
 struct blkcg_policy blkcg_policy_throtl = {
@@ -1725,6 +1768,7 @@ static void tg_cancel_writeback_bios(struct throtl_grp *tg,
 void blk_throtl_cancel_bios(struct gendisk *disk)
 {
 	struct request_queue *q = disk->queue;
+	struct throtl_data *td = q->td;
 	struct cgroup_subsys_state *pos_css;
 	struct blkcg_gq *blkg;
 	struct bio_list cancel_bios[2] = { };
@@ -1734,6 +1778,7 @@ void blk_throtl_cancel_bios(struct gendisk *disk)
 		return;
 
 	spin_lock_irq(&q->queue_lock);
+	spin_lock(&td->lock);
 	/*
 	 * queue_lock is held, rcu lock is not needed here technically.
 	 * However, rcu lock is still held to emphasize that following
@@ -1752,6 +1797,7 @@ void blk_throtl_cancel_bios(struct gendisk *disk)
 		tg_cancel_writeback_bios(blkg_to_tg(blkg), cancel_bios);
 	}
 	rcu_read_unlock();
+	spin_unlock(&td->lock);
 	spin_unlock_irq(&q->queue_lock);
 
 	for (rw = READ; rw <= WRITE; rw++) {
@@ -1791,7 +1837,6 @@ static bool tg_within_limit(struct throtl_grp *tg, struct bio *bio, bool rw)
 
 bool __blk_throtl_bio(struct bio *bio)
 {
-	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
 	struct blkcg_gq *blkg = bio->bi_blkg;
 	struct throtl_qnode *qn = NULL;
 	struct throtl_grp *tg = blkg_to_tg(blkg);
@@ -1801,7 +1846,7 @@ bool __blk_throtl_bio(struct bio *bio)
 	struct throtl_data *td = tg->td;
 
 	rcu_read_lock();
-	spin_lock_irq(&q->queue_lock);
+	spin_lock_irq(&td->lock);
 	sq = &tg->service_queue;
 
 	while (true) {
@@ -1877,7 +1922,7 @@ bool __blk_throtl_bio(struct bio *bio)
 	}
 
 out_unlock:
-	spin_unlock_irq(&q->queue_lock);
+	spin_unlock_irq(&td->lock);
 
 	rcu_read_unlock();
 	return throttled;
@@ -1886,17 +1931,19 @@ bool __blk_throtl_bio(struct bio *bio)
 void blk_throtl_exit(struct gendisk *disk)
 {
 	struct request_queue *q = disk->queue;
+	struct throtl_data *td = q->td;
 
 	/*
 	 * blkg_destroy_all() already deactivate throtl policy, just check and
 	 * free throtl data.
 	 */
-	if (!q->td)
+	if (!td)
 		return;
 
-	timer_delete_sync(&q->td->service_queue.pending_timer);
+	throtl_shutdown_timers(q);
 	throtl_shutdown_wq(q);
-	kfree(q->td);
+	q->td = NULL;
+	kfree(td);
 }
 
 static int __init throtl_init(void)
-- 
2.51.0


