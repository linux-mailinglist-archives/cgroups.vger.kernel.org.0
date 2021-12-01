Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 059DE464EDA
	for <lists+cgroups@lfdr.de>; Wed,  1 Dec 2021 14:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243020AbhLANiW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Dec 2021 08:38:22 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:54398 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242170AbhLANiV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Dec 2021 08:38:21 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8E9D8212BD;
        Wed,  1 Dec 2021 13:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638365699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=gurDmUOafm3mwOpNX64OhGslotUnt78gPkPeCT6HfLU=;
        b=oLNPDyr4cZPTn/7wSizXWoot7t9fLYYZY+wQNL/k3OpyoHQHKPYPrZMZVvtgRewhnP9awj
        niy1HZA8gAbSJ/XP/CsLjhi8ts3p6lvFRhFmlAjS7G6BRxt5xjgMnhDAyu7MNmSFrV+D4s
        9Dbta182v/xIa+JqCZluY/5aKCWZKRM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638365699;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=gurDmUOafm3mwOpNX64OhGslotUnt78gPkPeCT6HfLU=;
        b=Dh7RbBk7SvQ6+xL0cqaCEtg11oqsRYtMJ+u+zcZER1VOc7qOT/eZF+UO7TS7LmngHbPVom
        3rkGCKSXLpj2dfDQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 73298A3B81;
        Wed,  1 Dec 2021 13:34:59 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3508E1E1494; Wed,  1 Dec 2021 14:34:56 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        fvogt@suse.de, Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        Jan Kara <jack@suse.cz>, stable@vger.kernel.org,
        Fabian Vogt <fvogt@suse.com>
Subject: [PATCH] bfq: Fix use-after-free with cgroups
Date:   Wed,  1 Dec 2021 14:34:39 +0100
Message-Id: <20211201133439.3309-1-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12070; h=from:subject; bh=2R7rNGuET/rLWpMpWD51onEfSay6CK66QeUzkaAAJWk=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBhp3npUCyJlVrzIGGOH8eTPz6DDaJr713I8cXrpGxr zXn8ZMCJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYad56QAKCRCcnaoHP2RA2do8CA CZ512YYEl6bjWA2ZPF7JdyH9uNhlGWKfmiLp9n4Khi3/+xLxWjPRdZPHUrm570acietow3UXVMDiED pM1Iseu2dhSNs+bhA1UxQiipXJJKLLY756M3UZKG7xkO89RsXdSEobFffVZUdA5zgeSVKedB5VnjRG aow6u4kUt2kNregLSYKAEqSxVEQqkzggsVb/8685Uuk2k4gP4sdBKs7AdIJJGx6DsL7Dkw4/SIDPha fHye2z4iPylgPhr0WIii1ZcPDbZ7SMqQ11y9kgjn+RW5bZoOMF3gwUEi61VZj98OAOSkc0JY8xolHi tH+NjZLu/2GiIKi7sp0S9iNPFF/s9L
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

BFQ started crashing with 5.15-based kernels like:

BUG: KASAN: use-after-free in rb_erase (lib/rbtree.c:262 lib/rbtr
Read of size 8 at addr ffff888008193098 by task bash/1472

CPU: 0 PID: 1472 Comm: bash Tainted: G            E     5.15.2-0.
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1
Call Trace:
rb_erase (lib/rbtree.c:262 lib/rbtree.c:445)
bfq_idle_extract (block/bfq-wf2q.c:356)
bfq_put_idle_entity (block/bfq-wf2q.c:660)
bfq_bfqq_served (block/bfq-wf2q.c:833)
bfq_dispatch_request (block/bfq-iosched.c:4870 block/bfq-iosched.
__blk_mq_do_dispatch_sched (block/blk-mq-sched.c:150)
__blk_mq_sched_dispatch_requests (block/blk-mq-sched.c:215 block/
blk_mq_sched_dispatch_requests (block/blk-mq-sched.c:360)
blk_mq_sched_insert_requests (include/linux/percpu-refcount.h:174
blk_mq_flush_plug_list (include/linux/list.h:282 block/blk-mq.c:1
blk_flush_plug_list (block/blk-core.c:1722)
blk_finish_plug (block/blk-core.c:1745 block/blk-core.c:1739)
read_pages (include/linux/list.h:282 mm/readahead.c:152)
page_cache_ra_unbounded (mm/readahead.c:212 (discriminator 2))
filemap_fault (mm/filemap.c:2982 mm/filemap.c:3074)
__do_fault (mm/memory.c:3858)
__handle_mm_fault (mm/memory.c:4182 mm/memory.c:4310 mm/memory.c:
handle_mm_fault (mm/memory.c:4801)

After some analysis we've found out that the culprit of the problem is
that some task is reparented from cgroup G to the root cgroup and G is
offlined. But a bfq_queue in task's IO context still points to G as its
parent and thus when task submits more IO, G is inserted into service
trees. Once the task exits and bfq_queue is destroyed, the last
reference to G is dropped as well and G is freed but it is still linked
from service trees causing use-after-free issues sometime later.

Fix the problem by tracking all bfq_queues that point to a particular
cgroup as their parent and reparent them when the cgroup is going
offline.

CC: stable@vger.kernel.org
Fixes: e21b7a0b9887 ("block, bfq: add full hierarchical scheduling and cgroups support")
Tested-by: Fabian Vogt <fvogt@suse.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/bfq-cgroup.c  | 100 ++++++--------------------------------------
 block/bfq-iosched.c |  54 ++++++++++++------------
 block/bfq-iosched.h |   6 +++
 3 files changed, 47 insertions(+), 113 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 24a5c5329bcd..519e6291e98e 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -666,6 +666,7 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 		bfq_deactivate_bfqq(bfqd, bfqq, false, false);
 	else if (entity->on_st_or_in_serv)
 		bfq_put_idle_entity(bfq_entity_service_tree(entity), entity);
+	hlist_del(&bfqq->children_node);
 	bfqg_and_blkg_put(bfqq_group(bfqq));
 
 	if (entity->parent &&
@@ -678,6 +679,7 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 	entity->sched_data = &bfqg->sched_data;
 	/* pin down bfqg and its associated blkg  */
 	bfqg_and_blkg_get(bfqg);
+	hlist_add_head(&bfqq->children_node, &bfqg->children);
 
 	if (bfq_bfqq_busy(bfqq)) {
 		if (unlikely(!bfqd->nonrot_with_queueing))
@@ -810,68 +812,13 @@ void bfq_bic_update_cgroup(struct bfq_io_cq *bic, struct bio *bio)
 	rcu_read_unlock();
 }
 
-/**
- * bfq_flush_idle_tree - deactivate any entity on the idle tree of @st.
- * @st: the service tree being flushed.
- */
-static void bfq_flush_idle_tree(struct bfq_service_tree *st)
-{
-	struct bfq_entity *entity = st->first_idle;
-
-	for (; entity ; entity = st->first_idle)
-		__bfq_deactivate_entity(entity, false);
-}
-
-/**
- * bfq_reparent_leaf_entity - move leaf entity to the root_group.
- * @bfqd: the device data structure with the root group.
- * @entity: the entity to move, if entity is a leaf; or the parent entity
- *	    of an active leaf entity to move, if entity is not a leaf.
- */
-static void bfq_reparent_leaf_entity(struct bfq_data *bfqd,
-				     struct bfq_entity *entity,
-				     int ioprio_class)
+static void bfq_reparent_children(struct bfq_data *bfqd, struct bfq_group *bfqg)
 {
 	struct bfq_queue *bfqq;
-	struct bfq_entity *child_entity = entity;
-
-	while (child_entity->my_sched_data) { /* leaf not reached yet */
-		struct bfq_sched_data *child_sd = child_entity->my_sched_data;
-		struct bfq_service_tree *child_st = child_sd->service_tree +
-			ioprio_class;
-		struct rb_root *child_active = &child_st->active;
-
-		child_entity = bfq_entity_of(rb_first(child_active));
-
-		if (!child_entity)
-			child_entity = child_sd->in_service_entity;
-	}
-
-	bfqq = bfq_entity_to_bfqq(child_entity);
-	bfq_bfqq_move(bfqd, bfqq, bfqd->root_group);
-}
-
-/**
- * bfq_reparent_active_queues - move to the root group all active queues.
- * @bfqd: the device data structure with the root group.
- * @bfqg: the group to move from.
- * @st: the service tree to start the search from.
- */
-static void bfq_reparent_active_queues(struct bfq_data *bfqd,
-				       struct bfq_group *bfqg,
-				       struct bfq_service_tree *st,
-				       int ioprio_class)
-{
-	struct rb_root *active = &st->active;
-	struct bfq_entity *entity;
-
-	while ((entity = bfq_entity_of(rb_first(active))))
-		bfq_reparent_leaf_entity(bfqd, entity, ioprio_class);
+	struct hlist_node *next;
 
-	if (bfqg->sched_data.in_service_entity)
-		bfq_reparent_leaf_entity(bfqd,
-					 bfqg->sched_data.in_service_entity,
-					 ioprio_class);
+	hlist_for_each_entry_safe(bfqq, next, &bfqg->children, children_node)
+		bfq_bfqq_move(bfqd, bfqq, bfqd->root_group);
 }
 
 /**
@@ -897,38 +844,17 @@ static void bfq_pd_offline(struct blkg_policy_data *pd)
 		goto put_async_queues;
 
 	/*
-	 * Empty all service_trees belonging to this group before
-	 * deactivating the group itself.
+	 * Reparent all bfqqs under this bfq group. This will also empty all
+	 * service_trees belonging to this group before deactivating the group
+	 * itself.
 	 */
+	bfq_reparent_children(bfqd, bfqg);
+
 	for (i = 0; i < BFQ_IOPRIO_CLASSES; i++) {
 		st = bfqg->sched_data.service_tree + i;
 
-		/*
-		 * It may happen that some queues are still active
-		 * (busy) upon group destruction (if the corresponding
-		 * processes have been forced to terminate). We move
-		 * all the leaf entities corresponding to these queues
-		 * to the root_group.
-		 * Also, it may happen that the group has an entity
-		 * in service, which is disconnected from the active
-		 * tree: it must be moved, too.
-		 * There is no need to put the sync queues, as the
-		 * scheduler has taken no reference.
-		 */
-		bfq_reparent_active_queues(bfqd, bfqg, st, i);
-
-		/*
-		 * The idle tree may still contain bfq_queues
-		 * belonging to exited task because they never
-		 * migrated to a different cgroup from the one being
-		 * destroyed now. In addition, even
-		 * bfq_reparent_active_queues() may happen to add some
-		 * entities to the idle tree. It happens if, in some
-		 * of the calls to bfq_bfqq_move() performed by
-		 * bfq_reparent_active_queues(), the queue to move is
-		 * empty and gets expired.
-		 */
-		bfq_flush_idle_tree(st);
+		WARN_ON_ONCE(!RB_EMPTY_ROOT(&st->active));
+		WARN_ON_ONCE(!RB_EMPTY_ROOT(&st->idle));
 	}
 
 	__bfq_deactivate_entity(entity, false);
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index fec18118dc30..8f33f6b91d05 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5163,6 +5163,7 @@ void bfq_put_queue(struct bfq_queue *bfqq)
 	if (bfqq->bfqd && bfqq->bfqd->last_completed_rq_bfqq == bfqq)
 		bfqq->bfqd->last_completed_rq_bfqq = NULL;
 
+	hlist_del(&bfqq->children_node);
 	kmem_cache_free(bfq_pool, bfqq);
 	bfqg_and_blkg_put(bfqg);
 }
@@ -5337,8 +5338,9 @@ static void bfq_check_ioprio_change(struct bfq_io_cq *bic, struct bio *bio)
 		bfq_set_next_ioprio_data(bfqq, bic);
 }
 
-static void bfq_init_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq,
-			  struct bfq_io_cq *bic, pid_t pid, int is_sync)
+static void bfq_init_bfqq(struct bfq_data *bfqd, struct bfq_group *bfqg,
+			  struct bfq_queue *bfqq, struct bfq_io_cq *bic,
+			  pid_t pid, int is_sync)
 {
 	u64 now_ns = ktime_get_ns();
 
@@ -5347,6 +5349,7 @@ static void bfq_init_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 	INIT_HLIST_NODE(&bfqq->burst_list_node);
 	INIT_HLIST_NODE(&bfqq->woken_list_node);
 	INIT_HLIST_HEAD(&bfqq->woken_list);
+	hlist_add_head(&bfqq->children_node, &bfqg->children);
 
 	bfqq->ref = 0;
 	bfqq->bfqd = bfqd;
@@ -5600,8 +5603,7 @@ static struct bfq_queue *bfq_get_queue(struct bfq_data *bfqd,
 				     bfqd->queue->node);
 
 	if (bfqq) {
-		bfq_init_bfqq(bfqd, bfqq, bic, current->pid,
-			      is_sync);
+		bfq_init_bfqq(bfqd, bfqg, bfqq, bic, current->pid, is_sync);
 		bfq_init_entity(&bfqq->entity, bfqg);
 		bfq_log_bfqq(bfqd, bfqq, "allocated");
 	} else {
@@ -6908,6 +6910,7 @@ static void bfq_exit_queue(struct elevator_queue *e)
 
 	hrtimer_cancel(&bfqd->idle_slice_timer);
 
+	hlist_del(&bfqd->oom_bfqq.children_node);
 	/* release oom-queue reference to root group */
 	bfqg_and_blkg_put(bfqd->root_group);
 
@@ -6959,28 +6962,6 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 	q->elevator = eq;
 	spin_unlock_irq(&q->queue_lock);
 
-	/*
-	 * Our fallback bfqq if bfq_find_alloc_queue() runs into OOM issues.
-	 * Grab a permanent reference to it, so that the normal code flow
-	 * will not attempt to free it.
-	 */
-	bfq_init_bfqq(bfqd, &bfqd->oom_bfqq, NULL, 1, 0);
-	bfqd->oom_bfqq.ref++;
-	bfqd->oom_bfqq.new_ioprio = BFQ_DEFAULT_QUEUE_IOPRIO;
-	bfqd->oom_bfqq.new_ioprio_class = IOPRIO_CLASS_BE;
-	bfqd->oom_bfqq.entity.new_weight =
-		bfq_ioprio_to_weight(bfqd->oom_bfqq.new_ioprio);
-
-	/* oom_bfqq does not participate to bursts */
-	bfq_clear_bfqq_just_created(&bfqd->oom_bfqq);
-
-	/*
-	 * Trigger weight initialization, according to ioprio, at the
-	 * oom_bfqq's first activation. The oom_bfqq's ioprio and ioprio
-	 * class won't be changed any more.
-	 */
-	bfqd->oom_bfqq.entity.prio_changed = 1;
-
 	bfqd->queue = q;
 
 	INIT_LIST_HEAD(&bfqd->dispatch);
@@ -7059,6 +7040,27 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 		goto out_free;
 	bfq_init_root_group(bfqd->root_group, bfqd);
 	bfq_init_entity(&bfqd->oom_bfqq.entity, bfqd->root_group);
+	/*
+	 * Our fallback bfqq if bfq_find_alloc_queue() runs into OOM issues.
+	 * Grab a permanent reference to it, so that the normal code flow
+	 * will not attempt to free it.
+	 */
+	bfq_init_bfqq(bfqd, bfqd->root_group, &bfqd->oom_bfqq, NULL, 1, 0);
+	bfqd->oom_bfqq.ref++;
+	bfqd->oom_bfqq.new_ioprio = BFQ_DEFAULT_QUEUE_IOPRIO;
+	bfqd->oom_bfqq.new_ioprio_class = IOPRIO_CLASS_BE;
+	bfqd->oom_bfqq.entity.new_weight =
+		bfq_ioprio_to_weight(bfqd->oom_bfqq.new_ioprio);
+
+	/* oom_bfqq does not participate to bursts */
+	bfq_clear_bfqq_just_created(&bfqd->oom_bfqq);
+
+	/*
+	 * Trigger weight initialization, according to ioprio, at the
+	 * oom_bfqq's first activation. The oom_bfqq's ioprio and ioprio
+	 * class won't be changed any more.
+	 */
+	bfqd->oom_bfqq.entity.prio_changed = 1;
 
 	wbt_disable_default(q);
 	return 0;
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index a73488eec8a4..a1984959d6be 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -292,6 +292,9 @@ struct bfq_queue {
 
 	/* node for active/idle bfqq list inside parent bfqd */
 	struct list_head bfqq_list;
+	/* Member of parent's bfqg children list */
+	struct hlist_node children_node;
+
 
 	/* associated @bfq_ttime struct */
 	struct bfq_ttime ttime;
@@ -929,6 +932,9 @@ struct bfq_group {
 	struct bfq_entity entity;
 	struct bfq_sched_data sched_data;
 
+	/* bfq_queues under this entity */
+	struct hlist_head children;
+
 	void *bfqd;
 
 	struct bfq_queue *async_bfqq[2][IOPRIO_NR_LEVELS];
-- 
2.26.2

