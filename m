Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD7253B179
	for <lists+cgroups@lfdr.de>; Thu,  2 Jun 2022 04:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbiFBByk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Jun 2022 21:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232950AbiFBByj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Jun 2022 21:54:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A75BC29B2D3
        for <cgroups@vger.kernel.org>; Wed,  1 Jun 2022 18:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654134876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=krg4xzAgfamwYF1F/rhaXbuzS4T74775dwOrPwxuSlc=;
        b=J8JHd7f7IOKFLw2Tc4ecJSYi43kvubo0nEaRTLoZZtSlMkljqWi9fyI/j+l6Bxgg+CmbgG
        //CQgPTxC2eR7AaQqbo01j3Iv22fyjmNxJEvoq8qIC9mw5qKMSVDZG1MWEANTaHJ+aeIj1
        xhrvYR9kXQiM4efcLM4GZ7pK8IeLKWE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-251-H95KER2SMi-vmLV86JRF8w-1; Wed, 01 Jun 2022 21:54:35 -0400
X-MC-Unique: H95KER2SMi-vmLV86JRF8w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E82E83C0D19D;
        Thu,  2 Jun 2022 01:54:34 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.82])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 83C2D40E80E0;
        Thu,  2 Jun 2022 01:54:34 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v4 2/2] blk-cgroup: Optimize blkcg_rstat_flush()
Date:   Wed,  1 Jun 2022 21:54:19 -0400
Message-Id: <20220602015419.99168-1-longman@redhat.com>
In-Reply-To: <20220601211824.89626-1-longman@redhat.com>
References: <20220601211824.89626-1-longman@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

For a system with many CPUs and block devices, the time to do
blkcg_rstat_flush() from cgroup_rstat_flush() can be rather long. It
can be especially problematic as interrupt is disabled during the flush.
It was reported that it might take seconds to complete in some extreme
cases leading to hard lockup messages.

As it is likely that not all the percpu blkg_iostat_set's has been
updated since the last flush, those stale blkg_iostat_set's don't need
to be flushed in this case. This patch optimizes blkcg_rstat_flush()
by keeping a lockless list of recently updated blkg_iostat_set's in a
newly added percpu blkcg->lhead pointer.

The blkg_iostat_set is added to the lockless list on the update side
in blk_cgroup_bio_start(). It is removed from the lockless list when
flushed in blkcg_rstat_flush(). Due to racing, it is possible that
blk_iostat_set's in the lockless list may have no new IO stats to be
flushed. To protect against destruction of blkg, a percpu reference is
gotten when putting into the lockless list and put back when removed.

A blkg_iostat_set can determine if it is in a lockless list by checking
the content of its lnode.next pointer which will be non-NULL when in
a lockless list. This requires the presence of a special llist_last
sentinel node to be put at the end of the lockless list.

When booting up an instrumented test kernel with this patch on a
2-socket 96-thread system with cgroup v2, out of the 2051 calls to
cgroup_rstat_flush() after bootup, 1788 of the calls were exited
immediately because of empty lockless list. After an all-cpu kernel
build, the ratio became 6295424/6340513. That was more than 99%.

Signed-off-by: Waiman Long <longman@redhat.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 block/blk-cgroup.c | 84 ++++++++++++++++++++++++++++++++++++++++++----
 block/blk-cgroup.h |  9 +++++
 2 files changed, 87 insertions(+), 6 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index acd9b0aa8dc8..1b74df5f2710 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -59,6 +59,56 @@ static struct workqueue_struct *blkcg_punt_bio_wq;
 
 #define BLKG_DESTROY_BATCH_SIZE  64
 
+/*
+ * lnode.next of the last entry in a lockless list is NULL. To enable us to
+ * use lnode.next as a boolean flag to indicate its presence in a lockless
+ * list, we have to make it non-NULL for all. This is done by using a
+ * sentinel node at the end of the lockless list. All the percpu lhead's
+ * are initialized to point to that sentinel node as being empty.
+ */
+static struct llist_node llist_last;
+
+static bool blkcg_llist_empty(struct llist_head *lhead)
+{
+	return lhead->first == &llist_last;
+}
+
+static void init_blkcg_llists(struct blkcg *blkcg)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		per_cpu_ptr(blkcg->lhead, cpu)->first = &llist_last;
+}
+
+static struct llist_node *fetch_delete_blkcg_llist(struct llist_head *lhead)
+{
+	return xchg(&lhead->first, &llist_last);
+}
+
+static struct llist_node *fetch_delete_lnode_next(struct llist_node *lnode)
+{
+	struct llist_node *next = READ_ONCE(lnode->next);
+	struct blkcg_gq *blkg = llist_entry(lnode, struct blkg_iostat_set,
+					    lnode)->blkg;
+
+	WRITE_ONCE(lnode->next, NULL);
+	percpu_ref_put(&blkg->refcnt);
+	return next;
+}
+
+/*
+ * The retrieved blkg_iostat_set is immediately marked as not in the
+ * lockless list by clearing its node->next pointer. It could be put
+ * back into the list by a parallel update before the iostat's are
+ * finally flushed including probably the new update.
+ */
+#define blkcg_llist_for_each_entry_safe(pos, node, nxt)			\
+	for (; (node != &llist_last) &&					\
+	       (pos = llist_entry(node, struct blkg_iostat_set, lnode),	\
+		nxt = fetch_delete_lnode_next(node), true);		\
+		node = nxt)
+
 /**
  * blkcg_css - find the current css
  *
@@ -236,8 +286,10 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct request_queue *q,
 	blkg->blkcg = blkcg;
 
 	u64_stats_init(&blkg->iostat.sync);
-	for_each_possible_cpu(cpu)
+	for_each_possible_cpu(cpu) {
 		u64_stats_init(&per_cpu_ptr(blkg->iostat_cpu, cpu)->sync);
+		per_cpu_ptr(blkg->iostat_cpu, cpu)->blkg = blkg;
+	}
 
 	for (i = 0; i < BLKCG_MAX_POLS; i++) {
 		struct blkcg_policy *pol = blkcg_policy[i];
@@ -852,17 +904,23 @@ static void blkg_iostat_sub(struct blkg_iostat *dst, struct blkg_iostat *src)
 static void blkcg_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 {
 	struct blkcg *blkcg = css_to_blkcg(css);
-	struct blkcg_gq *blkg;
+	struct llist_head *lhead = per_cpu_ptr(blkcg->lhead, cpu);
+	struct llist_node *lnode, *lnext;
+	struct blkg_iostat_set *bisc;
 
 	/* Root-level stats are sourced from system-wide IO stats */
 	if (!cgroup_parent(css->cgroup))
 		return;
 
+	if (blkcg_llist_empty(lhead))
+		return;
+
 	rcu_read_lock();
 
-	hlist_for_each_entry_rcu(blkg, &blkcg->blkg_list, blkcg_node) {
+	lnode = fetch_delete_blkcg_llist(lhead);
+	blkcg_llist_for_each_entry_safe(bisc, lnode, lnext) {
+		struct blkcg_gq *blkg = bisc->blkg;
 		struct blkcg_gq *parent = blkg->parent;
-		struct blkg_iostat_set *bisc = per_cpu_ptr(blkg->iostat_cpu, cpu);
 		struct blkg_iostat cur, delta;
 		unsigned long flags;
 		unsigned int seq;
@@ -1192,6 +1250,11 @@ blkcg_css_alloc(struct cgroup_subsys_state *parent_css)
 		}
 	}
 
+	blkcg->lhead = alloc_percpu_gfp(struct llist_head, GFP_KERNEL);
+	if (!blkcg->lhead)
+		goto free_blkcg;
+	init_blkcg_llists(blkcg);
+
 	for (i = 0; i < BLKCG_MAX_POLS ; i++) {
 		struct blkcg_policy *pol = blkcg_policy[i];
 		struct blkcg_policy_data *cpd;
@@ -1233,7 +1296,8 @@ blkcg_css_alloc(struct cgroup_subsys_state *parent_css)
 	for (i--; i >= 0; i--)
 		if (blkcg->cpd[i])
 			blkcg_policy[i]->cpd_free_fn(blkcg->cpd[i]);
-
+	free_percpu(blkcg->lhead);
+free_blkcg:
 	if (blkcg != &blkcg_root)
 		kfree(blkcg);
 unlock:
@@ -1997,6 +2061,7 @@ static int blk_cgroup_io_type(struct bio *bio)
 
 void blk_cgroup_bio_start(struct bio *bio)
 {
+	struct blkcg *blkcg = bio->bi_blkg->blkcg;
 	int rwd = blk_cgroup_io_type(bio), cpu;
 	struct blkg_iostat_set *bis;
 	unsigned long flags;
@@ -2015,9 +2080,16 @@ void blk_cgroup_bio_start(struct bio *bio)
 	}
 	bis->cur.ios[rwd]++;
 
+	if (!READ_ONCE(bis->lnode.next)) {
+		struct llist_head *lhead = per_cpu_ptr(blkcg->lhead, cpu);
+
+		llist_add(&bis->lnode, lhead);
+		percpu_ref_get(&bis->blkg->refcnt);
+	}
+
 	u64_stats_update_end_irqrestore(&bis->sync, flags);
 	if (cgroup_subsys_on_dfl(io_cgrp_subsys))
-		cgroup_rstat_updated(bio->bi_blkg->blkcg->css.cgroup, cpu);
+		cgroup_rstat_updated(blkcg->css.cgroup, cpu);
 	put_cpu();
 }
 
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index d4de0a35e066..2c36362a332e 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -18,6 +18,7 @@
 #include <linux/cgroup.h>
 #include <linux/kthread.h>
 #include <linux/blk-mq.h>
+#include <linux/llist.h>
 
 struct blkcg_gq;
 struct blkg_policy_data;
@@ -43,6 +44,8 @@ struct blkg_iostat {
 
 struct blkg_iostat_set {
 	struct u64_stats_sync		sync;
+	struct llist_node		lnode;
+	struct blkcg_gq		       *blkg;
 	struct blkg_iostat		cur;
 	struct blkg_iostat		last;
 };
@@ -97,6 +100,12 @@ struct blkcg {
 	struct blkcg_policy_data	*cpd[BLKCG_MAX_POLS];
 
 	struct list_head		all_blkcgs_node;
+
+	/*
+	 * List of updated percpu blkg_iostat_set's since the last flush.
+	 */
+	struct llist_head __percpu	*lhead;
+
 #ifdef CONFIG_BLK_CGROUP_FC_APPID
 	char                            fc_app_id[FC_APPID_LEN];
 #endif
-- 
2.31.1

