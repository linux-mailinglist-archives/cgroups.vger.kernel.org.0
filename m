Return-Path: <cgroups+bounces-17121-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id x25eOEy4OGr2ggcAu9opvQ
	(envelope-from <cgroups+bounces-17121-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 22 Jun 2026 06:21:32 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AB06AC7FC
	for <lists+cgroups@lfdr.de>; Mon, 22 Jun 2026 06:21:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=UXztHqAS;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17121-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17121-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5527300A744
	for <lists+cgroups@lfdr.de>; Mon, 22 Jun 2026 04:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A12D352038;
	Mon, 22 Jun 2026 04:21:19 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6DB352029
	for <cgroups@vger.kernel.org>; Mon, 22 Jun 2026 04:21:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782102079; cv=none; b=SGvuvcNN3zfF35yDyIjoDRUNvaLP1OoNXDqmC6B3bKCosLpAC+xf/FVwCT5xbvviBYLVHywHkyHcB5GBSdQPifzLc9wbIbPx4e4k44JxLExSBaU6Au+fk4OMVQ82D9xzVf1/VPKxv6dWlhS/Z51agwiKy9jVwkPxo9PTa/ZW1LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782102079; c=relaxed/simple;
	bh=yYlDQ/l+zs/b9e8m9s4LMjZbs6vWiIES70Ut+w5bpAU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S/ky98ar6OivVCSOQ66xgxIODMdCBja3HICGdYvFEivd+/v1kTPSxuPuME24ICLaZbm6hKvIfY/z+H8PeOvGVKm0GjDANoZ14O5DmdOqcQyk936h/RtwN8iy7mZuGFofwYF6d9Cf0DOuUTQUYnYZa4YtQiWQqSoMPSCEw3xjtyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UXztHqAS; arc=none smtp.client-ip=91.218.175.189
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782102065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GcqR2qNPO+w7lc6EUo9e2BGGPvGaEH+heJynYFHN+iM=;
	b=UXztHqAS6SHwAXxG289gYezYczzuhIi/DRFRs+pWipno4EENd97BVP8FqwO4v1UsVWTYzG
	U7ydREZStW2gD2ALRcUrMl8ljgM0HBFYHIT5WvEhKDV9s2SCAUqLRZdHvsv55Yo3Pklv7W
	f+AECjdUvZ+RKKrXV+nxXNhMGXy2FFw=
From: Kaitao Cheng <kaitao.cheng@linux.dev>
To: Yu Kuai <yukuai@fygo.io>,
	Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	"Richard Russon (FlatCap)" <ldm@flatcap.org>,
	Jonathan Derrick <jonathan.derrick@linux.dev>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-ntfs-dev@lists.sourceforge.net,
	Kaitao Cheng <chengkaitao@kylinos.cn>
Subject: [PATCH v3 4/7] block: Use mutable list iterators
Date: Mon, 22 Jun 2026 12:19:59 +0800
Message-ID: <20260622041959.30981-1-kaitao.cheng@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17121-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kaitao.cheng@linux.dev,cgroups@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:yukuai@fygo.io,m:axboe@kernel.dk,m:tj@kernel.org,m:josef@toxicpanda.com,m:ldm@flatcap.org,m:jonathan.derrick@linux.dev,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-ntfs-dev@lists.sourceforge.net,m:chengkaitao@kylinos.cn,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kaitao.cheng@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,linux.dev:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 52AB06AC7FC

From: Kaitao Cheng <chengkaitao@kylinos.cn>

The safe list iterators require callers to provide a temporary cursor
even when the cursor is only used by the iterator itself.  The mutable
iterator variants keep the same removal-safe traversal semantics while
allowing those internal cursors to be hidden from the call sites.

Convert block users of list, hlist and llist safe iterators to the new
mutable helpers.  Drop the now-unused temporary cursor variables where
the loop body does not inspect or reset them.

This is a mechanical cleanup with no intended change in traversal order
or list mutation behavior.

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
---
 block/bfq-iosched.c    | 17 +++++++----------
 block/blk-cgroup.c     | 12 ++++++------
 block/blk-flush.c      |  4 ++--
 block/blk-iocost.c     | 18 +++++++++---------
 block/blk-mq.c         |  8 ++++----
 block/blk-throttle.c   |  4 ++--
 block/kyber-iosched.c  |  4 ++--
 block/partitions/ldm.c |  8 ++++----
 block/sed-opal.c       |  4 ++--
 9 files changed, 38 insertions(+), 41 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 141c602d5e85..78e32ba0553d 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1209,9 +1209,8 @@ static int bfqq_process_refs(struct bfq_queue *bfqq)
 static void bfq_reset_burst_list(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 {
 	struct bfq_queue *item;
-	struct hlist_node *n;
 
-	hlist_for_each_entry_safe(item, n, &bfqd->burst_list, burst_list_node)
+	hlist_for_each_entry_mutable(item, &bfqd->burst_list, burst_list_node)
 		hlist_del_init(&item->burst_list_node);
 
 	/*
@@ -1236,7 +1235,6 @@ static void bfq_add_to_burst(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 
 	if (bfqd->burst_size == bfqd->bfq_large_burst_thresh) {
 		struct bfq_queue *pos, *bfqq_item;
-		struct hlist_node *n;
 
 		/*
 		 * Enough queues have been activated shortly after each
@@ -1260,8 +1258,8 @@ static void bfq_add_to_burst(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 		 * belonging to a large burst. So the burst list is not
 		 * needed any more. Remove it.
 		 */
-		hlist_for_each_entry_safe(pos, n, &bfqd->burst_list,
-					  burst_list_node)
+		hlist_for_each_entry_mutable(pos, &bfqd->burst_list,
+					     burst_list_node)
 			hlist_del_init(&pos->burst_list_node);
 	} else /*
 		* Burst not yet large: add bfqq to the burst list. Do
@@ -5330,7 +5328,6 @@ static struct request *bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
 void bfq_put_queue(struct bfq_queue *bfqq)
 {
 	struct bfq_queue *item;
-	struct hlist_node *n;
 	struct bfq_group *bfqg = bfqq_group(bfqq);
 
 	bfq_log_bfqq(bfqq->bfqd, bfqq, "put_queue: %p %d", bfqq, bfqq->ref);
@@ -5391,8 +5388,8 @@ void bfq_put_queue(struct bfq_queue *bfqq)
 		hlist_del_init(&bfqq->woken_list_node);
 
 	/* reset waker for all queues in woken list */
-	hlist_for_each_entry_safe(item, n, &bfqq->woken_list,
-				  woken_list_node) {
+	hlist_for_each_entry_mutable(item, &bfqq->woken_list,
+				     woken_list_node) {
 		item->waker_bfqq = NULL;
 		hlist_del_init(&item->woken_list_node);
 	}
@@ -7141,13 +7138,13 @@ static void bfq_depth_updated(struct request_queue *q)
 static void bfq_exit_queue(struct elevator_queue *e)
 {
 	struct bfq_data *bfqd = e->elevator_data;
-	struct bfq_queue *bfqq, *n;
+	struct bfq_queue *bfqq;
 	unsigned int actuator;
 
 	hrtimer_cancel(&bfqd->idle_slice_timer);
 
 	spin_lock_irq(&bfqd->lock);
-	list_for_each_entry_safe(bfqq, n, &bfqd->idle_list, bfqq_list)
+	list_for_each_entry_mutable(bfqq, &bfqd->idle_list, bfqq_list)
 		bfq_deactivate_bfqq(bfqd, bfqq, false, false);
 	spin_unlock_irq(&bfqd->lock);
 
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 3093c1c03902..ced900019f2e 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -997,7 +997,7 @@ static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu)
 {
 	struct llist_head *lhead = per_cpu_ptr(blkcg->lhead, cpu);
 	struct llist_node *lnode;
-	struct blkg_iostat_set *bisc, *next_bisc;
+	struct blkg_iostat_set *bisc;
 	unsigned long flags;
 
 	rcu_read_lock();
@@ -1017,17 +1017,17 @@ static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu)
 	/*
 	 * Iterate only the iostat_cpu's queued in the lockless list.
 	 */
-	llist_for_each_entry_safe(bisc, next_bisc, lnode, lnode) {
+	llist_for_each_entry_mutable(bisc, lnode, lnode) {
 		struct blkcg_gq *blkg = bisc->blkg;
 		struct blkcg_gq *parent = blkg->parent;
 		struct blkg_iostat cur;
 		unsigned int seq;
 
 		/*
-		 * Order assignment of `next_bisc` from `bisc->lnode.next` in
-		 * llist_for_each_entry_safe and clearing `bisc->lqueued` for
-		 * avoiding to assign `next_bisc` with new next pointer added
-		 * in blk_cgroup_bio_start() in case of re-ordering.
+		 * Order the iterator's internal `bisc->lnode.next` load before
+		 * clearing `bisc->lqueued`, so the iterator can't pick up a new
+		 * next pointer added in blk_cgroup_bio_start() in case of
+		 * re-ordering.
 		 *
 		 * The pair barrier is implied in llist_add() in blk_cgroup_bio_start().
 		 */
diff --git a/block/blk-flush.c b/block/blk-flush.c
index 403a46c86411..20654c2103f2 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -204,7 +204,7 @@ static enum rq_end_io_ret flush_end_io(struct request *flush_rq,
 {
 	struct request_queue *q = flush_rq->q;
 	struct list_head *running;
-	struct request *rq, *n;
+	struct request *rq;
 	unsigned long flags = 0;
 	struct blk_flush_queue *fq = blk_get_flush_queue(flush_rq->mq_ctx);
 
@@ -243,7 +243,7 @@ static enum rq_end_io_ret flush_end_io(struct request *flush_rq,
 	fq->flush_running_idx ^= 1;
 
 	/* and push the waiting requests to the next stage */
-	list_for_each_entry_safe(rq, n, running, queuelist) {
+	list_for_each_entry_mutable(rq, running, queuelist) {
 		unsigned int seq = blk_flush_cur_seq(rq);
 
 		BUG_ON(seq != REQ_FSEQ_PREFLUSH && seq != REQ_FSEQ_POSTFLUSH);
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 563cc7dcf348..2ca18e52bc13 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1718,7 +1718,7 @@ static void iocg_flush_stat_leaf(struct ioc_gq *iocg, struct ioc_now *now)
 static void iocg_flush_stat(struct list_head *target_iocgs, struct ioc_now *now)
 {
 	LIST_HEAD(inner_walk);
-	struct ioc_gq *iocg, *tiocg;
+	struct ioc_gq *iocg;
 
 	/* flush leaves and build inner node walk list */
 	list_for_each_entry(iocg, target_iocgs, active_list) {
@@ -1727,7 +1727,7 @@ static void iocg_flush_stat(struct list_head *target_iocgs, struct ioc_now *now)
 	}
 
 	/* keep flushing upwards by walking the inner list backwards */
-	list_for_each_entry_safe_reverse(iocg, tiocg, &inner_walk, walk_list) {
+	list_for_each_entry_mutable_reverse(iocg, &inner_walk, walk_list) {
 		iocg_flush_stat_upward(iocg);
 		list_del_init(&iocg->walk_list);
 	}
@@ -1848,7 +1848,7 @@ static void transfer_surpluses(struct list_head *surpluses, struct ioc_now *now)
 {
 	LIST_HEAD(over_hwa);
 	LIST_HEAD(inner_walk);
-	struct ioc_gq *iocg, *tiocg, *root_iocg;
+	struct ioc_gq *iocg, *root_iocg;
 	u32 after_sum, over_sum, over_target, gamma;
 
 	/*
@@ -1884,7 +1884,7 @@ static void transfer_surpluses(struct list_head *surpluses, struct ioc_now *now)
 		over_target = 0;
 	}
 
-	list_for_each_entry_safe(iocg, tiocg, &over_hwa, walk_list) {
+	list_for_each_entry_mutable(iocg, &over_hwa, walk_list) {
 		if (over_target)
 			iocg->hweight_after_donation =
 				div_u64((u64)iocg->hweight_after_donation *
@@ -2055,7 +2055,7 @@ static void transfer_surpluses(struct list_head *surpluses, struct ioc_now *now)
 	}
 
 	/* walk list should be dissolved after use */
-	list_for_each_entry_safe(iocg, tiocg, &inner_walk, walk_list)
+	list_for_each_entry_mutable(iocg, &inner_walk, walk_list)
 		list_del_init(&iocg->walk_list);
 }
 
@@ -2166,9 +2166,9 @@ static void ioc_forgive_debts(struct ioc *ioc, u64 usage_us_sum, int nr_debtors,
 static int ioc_check_iocgs(struct ioc *ioc, struct ioc_now *now)
 {
 	int nr_debtors = 0;
-	struct ioc_gq *iocg, *tiocg;
+	struct ioc_gq *iocg;
 
-	list_for_each_entry_safe(iocg, tiocg, &ioc->active_iocgs, active_list) {
+	list_for_each_entry_mutable(iocg, &ioc->active_iocgs, active_list) {
 		if (!waitqueue_active(&iocg->waitq) && !iocg->abs_vdebt &&
 		    !iocg->delay && !iocg_is_idle(iocg))
 			continue;
@@ -2234,7 +2234,7 @@ static int ioc_check_iocgs(struct ioc *ioc, struct ioc_now *now)
 static void ioc_timer_fn(struct timer_list *timer)
 {
 	struct ioc *ioc = container_of(timer, struct ioc, timer);
-	struct ioc_gq *iocg, *tiocg;
+	struct ioc_gq *iocg;
 	struct ioc_now now;
 	LIST_HEAD(surpluses);
 	int nr_debtors, nr_shortages = 0, nr_lagging = 0;
@@ -2378,7 +2378,7 @@ static void ioc_timer_fn(struct timer_list *timer)
 	commit_weights(ioc);
 
 	/* surplus list should be dissolved after use */
-	list_for_each_entry_safe(iocg, tiocg, &surpluses, surplus_list)
+	list_for_each_entry_mutable(iocg, &surpluses, surplus_list)
 		list_del_init(&iocg->surplus_list);
 
 	/*
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 88cb5acc4f39..2daed45ad4e7 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1216,9 +1216,9 @@ EXPORT_SYMBOL_GPL(blk_mq_end_request_batch);
 static void blk_complete_reqs(struct llist_head *list)
 {
 	struct llist_node *entry = llist_reverse_order(llist_del_all(list));
-	struct request *rq, *next;
+	struct request *rq;
 
-	llist_for_each_entry_safe(rq, next, entry, ipi_list)
+	llist_for_each_entry_mutable(rq, entry, ipi_list)
 		rq->q->mq_ops->complete(rq);
 }
 
@@ -4383,14 +4383,14 @@ static int blk_mq_alloc_ctxs(struct request_queue *q)
  */
 void blk_mq_release(struct request_queue *q)
 {
-	struct blk_mq_hw_ctx *hctx, *next;
+	struct blk_mq_hw_ctx *hctx;
 	unsigned long i;
 
 	queue_for_each_hw_ctx(q, hctx, i)
 		WARN_ON_ONCE(hctx && list_empty(&hctx->hctx_list));
 
 	/* all hctx are in .unused_hctx_list now */
-	list_for_each_entry_safe(hctx, next, &q->unused_hctx_list, hctx_list) {
+	list_for_each_entry_mutable(hctx, &q->unused_hctx_list, hctx_list) {
 		list_del_init(&hctx->hctx_list);
 		kobject_put(&hctx->kobj);
 	}
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 47052ba21d1b..1dd4901f00f3 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1686,10 +1686,10 @@ static void tg_cancel_writeback_bios(struct throtl_grp *tg,
 	tg->flags |= THROTL_TG_CANCELING;
 
 	for (rw = READ; rw <= WRITE; rw++) {
-		struct throtl_qnode *qn, *tmp;
+		struct throtl_qnode *qn;
 		unsigned int nr_bios = 0;
 
-		list_for_each_entry_safe(qn, tmp, &sq->queued[rw], node) {
+		list_for_each_entry_mutable(qn, &sq->queued[rw], node) {
 			struct bio *bio;
 
 			while ((bio = bio_list_pop(&qn->bios_iops))) {
diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index 971818bcdc9d..1a509666b861 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -578,9 +578,9 @@ static void kyber_insert_requests(struct blk_mq_hw_ctx *hctx,
 				  blk_insert_t flags)
 {
 	struct kyber_hctx_data *khd = hctx->sched_data;
-	struct request *rq, *next;
+	struct request *rq;
 
-	list_for_each_entry_safe(rq, next, rq_list, queuelist) {
+	list_for_each_entry_mutable(rq, rq_list, queuelist) {
 		unsigned int sched_domain = kyber_sched_domain(rq->cmd_flags);
 		struct kyber_ctx_queue *kcq = &khd->kcqs[rq->mq_ctx->index_hw[hctx->type]];
 		struct list_head *head = &kcq->rq_list[sched_domain];
diff --git a/block/partitions/ldm.c b/block/partitions/ldm.c
index c0bdcae58a3e..459f72f2148a 100644
--- a/block/partitions/ldm.c
+++ b/block/partitions/ldm.c
@@ -1285,11 +1285,11 @@ static bool ldm_frag_add (const u8 *data, int size, struct list_head *frags)
  */
 static void ldm_frag_free (struct list_head *list)
 {
-	struct list_head *item, *tmp;
+	struct list_head *item;
 
 	BUG_ON (!list);
 
-	list_for_each_safe (item, tmp, list)
+	list_for_each_mutable(item, list)
 		kfree (list_entry (item, struct frag, list));
 }
 
@@ -1400,11 +1400,11 @@ static bool ldm_get_vblks(struct parsed_partitions *state, unsigned long base,
  */
 static void ldm_free_vblks (struct list_head *lh)
 {
-	struct list_head *item, *tmp;
+	struct list_head *item;
 
 	BUG_ON (!lh);
 
-	list_for_each_safe (item, tmp, lh)
+	list_for_each_mutable(item, lh)
 		kfree (list_entry (item, struct vblk, list));
 }
 
diff --git a/block/sed-opal.c b/block/sed-opal.c
index 79b290d9458a..5bf9ebce8452 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -2573,10 +2573,10 @@ static int check_opal_support(struct opal_dev *dev)
 static void clean_opal_dev(struct opal_dev *dev)
 {
 
-	struct opal_suspend_data *suspend, *next;
+	struct opal_suspend_data *suspend;
 
 	mutex_lock(&dev->dev_lock);
-	list_for_each_entry_safe(suspend, next, &dev->unlk_lst, node) {
+	list_for_each_entry_mutable(suspend, &dev->unlk_lst, node) {
 		list_del(&suspend->node);
 		kfree(suspend);
 	}
-- 
2.43.0


