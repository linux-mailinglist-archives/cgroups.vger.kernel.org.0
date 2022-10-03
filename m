Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500EE5F32DC
	for <lists+cgroups@lfdr.de>; Mon,  3 Oct 2022 17:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbiJCPqB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 Oct 2022 11:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiJCPpj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 3 Oct 2022 11:45:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2AA2C139
        for <cgroups@vger.kernel.org>; Mon,  3 Oct 2022 08:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664811935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u5dBR2FTG7JSHGy9Zrb4XaMiPPO3H7N8toXYMh3ofio=;
        b=BE5KsujgFufhpy4NkYSSC1mc2Cbr2QbgORsrahpUxS/MSRZdB5F/zyVLhurmMWDkUVIFss
        OlOBDoVq/YwxA64QyxhS8WFDLrYQ7xD7FdNeUeSgH1GGrg/qgp4cjQ/AHUzoR84Ncszhlz
        2eSdeIaDRGP0T5PEYyji+mSxcq6O+S4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-392-p33vXtAmPc64F4BmCFGstg-1; Mon, 03 Oct 2022 11:45:32 -0400
X-MC-Unique: p33vXtAmPc64F4BmCFGstg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 370491C06EEB;
        Mon,  3 Oct 2022 15:45:32 +0000 (UTC)
Received: from llong.com (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DAD212027063;
        Mon,  3 Oct 2022 15:45:31 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v7 3/3] blk-cgroup: Optimize blkcg_rstat_flush()
Date:   Mon,  3 Oct 2022 11:44:59 -0400
Message-Id: <20221003154459.207538-4-longman@redhat.com>
In-Reply-To: <20221003154459.207538-1-longman@redhat.com>
References: <20221003154459.207538-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

The blkg_iostat_set is added to a sentinel lockless list on the update
side in blk_cgroup_bio_start(). It is removed from the sentinel lockless
list when flushed in blkcg_rstat_flush(). Due to racing, it is possible
that blk_iostat_set's in the lockless list may have no new IO stats to
be flushed, but that is OK.

To protect against destruction of blkg, a percpu reference is gotten
when putting into the lockless list and put back when removed.

A blkg_iostat_set can determine if it is in a lockless list by checking
the content of its lnode.next pointer which will be non-NULL when in
a sentinel lockless list.

When booting up an instrumented test kernel with this patch on a
2-socket 96-thread system with cgroup v2, out of the 2051 calls to
cgroup_rstat_flush() after bootup, 1788 of the calls were exited
immediately because of empty lockless list. After an all-cpu kernel
build, the ratio became 6295424/6340513. That was more than 99%.

Signed-off-by: Waiman Long <longman@redhat.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 block/blk-cgroup.c | 73 ++++++++++++++++++++++++++++++++++++++++++----
 block/blk-cgroup.h |  9 ++++++
 2 files changed, 76 insertions(+), 6 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 946592249795..f1f580c46190 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -59,6 +59,37 @@ static struct workqueue_struct *blkcg_punt_bio_wq;
 
 #define BLKG_DESTROY_BATCH_SIZE  64
 
+/*
+ * Lockless lists for tracking IO stats update
+ *
+ * New IO stats are stored in the percpu iostat_cpu within blkcg_gq (blkg).
+ * There are multiple blkg's (one for each block device) attached to each
+ * blkcg. The rstat code keeps track of which cpu has IO stats updated,
+ * but it doesn't know which blkg has the updated stats. If there are many
+ * block devices in a system, the cost of iterating all the blkg's to flush
+ * out the IO stats can be high. To reduce such overhead, a set of percpu
+ * lockless lists (lhead) per blkcg are used to track the set of recently
+ * updated iostat_cpu's since the last flush. An iostat_cpu will be put
+ * onto the lockless list on the update side [blk_cgroup_bio_start()] if
+ * not there yet and then removed when being flushed [blkcg_rstat_flush()].
+ * References to blkg are gotten and then put back in the process to
+ * protect against blkg removal.
+ *
+ * Return: 0 if successful or -ENOMEM if allocation fails.
+ */
+static int init_blkcg_sllists(struct blkcg *blkcg)
+{
+	int cpu;
+
+	blkcg->lhead = alloc_percpu_gfp(struct llist_head, GFP_KERNEL);
+	if (!blkcg->lhead)
+		return -ENOMEM;
+
+	for_each_possible_cpu(cpu)
+		init_sllist_head(per_cpu_ptr(blkcg->lhead, cpu));
+	return 0;
+}
+
 /**
  * blkcg_css - find the current css
  *
@@ -236,8 +267,10 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct request_queue *q,
 	blkg->blkcg = blkcg;
 
 	u64_stats_init(&blkg->iostat.sync);
-	for_each_possible_cpu(cpu)
+	for_each_possible_cpu(cpu) {
 		u64_stats_init(&per_cpu_ptr(blkg->iostat_cpu, cpu)->sync);
+		per_cpu_ptr(blkg->iostat_cpu, cpu)->blkg = blkg;
+	}
 
 	for (i = 0; i < BLKCG_MAX_POLS; i++) {
 		struct blkcg_policy *pol = blkcg_policy[i];
@@ -864,7 +897,9 @@ static void blkcg_iostat_update(struct blkcg_gq *blkg, struct blkg_iostat *cur,
 static void blkcg_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 {
 	struct blkcg *blkcg = css_to_blkcg(css);
-	struct blkcg_gq *blkg;
+	struct llist_head *lhead = per_cpu_ptr(blkcg->lhead, cpu);
+	struct llist_node *lnode;
+	struct blkg_iostat_set *bisc, *next_bisc;
 
 	/* Root-level stats are sourced from system-wide IO stats */
 	if (!cgroup_parent(css->cgroup))
@@ -872,9 +907,16 @@ static void blkcg_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 
 	rcu_read_lock();
 
-	hlist_for_each_entry_rcu(blkg, &blkcg->blkg_list, blkcg_node) {
+	lnode = sllist_del_all(lhead);
+	if (!lnode)
+		goto out;
+
+	/*
+	 * Iterate only the iostat_cpu's queued in the lockless list.
+	 */
+	sllist_for_each_entry_safe(bisc, next_bisc, lnode, lnode) {
+		struct blkcg_gq *blkg = bisc->blkg;
 		struct blkcg_gq *parent = blkg->parent;
-		struct blkg_iostat_set *bisc = per_cpu_ptr(blkg->iostat_cpu, cpu);
 		struct blkg_iostat cur;
 		unsigned int seq;
 
@@ -890,8 +932,10 @@ static void blkcg_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 		if (parent && parent->parent)
 			blkcg_iostat_update(parent, &blkg->iostat.cur,
 					    &blkg->iostat.last);
+		percpu_ref_put(&blkg->refcnt);
 	}
 
+out:
 	rcu_read_unlock();
 }
 
@@ -1170,6 +1214,7 @@ static void blkcg_css_free(struct cgroup_subsys_state *css)
 
 	mutex_unlock(&blkcg_pol_mutex);
 
+	free_percpu(blkcg->lhead);
 	kfree(blkcg);
 }
 
@@ -1189,6 +1234,9 @@ blkcg_css_alloc(struct cgroup_subsys_state *parent_css)
 			goto unlock;
 	}
 
+	if (init_blkcg_sllists(blkcg))
+		goto free_blkcg;
+
 	for (i = 0; i < BLKCG_MAX_POLS ; i++) {
 		struct blkcg_policy *pol = blkcg_policy[i];
 		struct blkcg_policy_data *cpd;
@@ -1229,7 +1277,8 @@ blkcg_css_alloc(struct cgroup_subsys_state *parent_css)
 	for (i--; i >= 0; i--)
 		if (blkcg->cpd[i])
 			blkcg_policy[i]->cpd_free_fn(blkcg->cpd[i]);
-
+	free_percpu(blkcg->lhead);
+free_blkcg:
 	if (blkcg != &blkcg_root)
 		kfree(blkcg);
 unlock:
@@ -1990,6 +2039,7 @@ static int blk_cgroup_io_type(struct bio *bio)
 
 void blk_cgroup_bio_start(struct bio *bio)
 {
+	struct blkcg *blkcg = bio->bi_blkg->blkcg;
 	int rwd = blk_cgroup_io_type(bio), cpu;
 	struct blkg_iostat_set *bis;
 	unsigned long flags;
@@ -2008,9 +2058,20 @@ void blk_cgroup_bio_start(struct bio *bio)
 	}
 	bis->cur.ios[rwd]++;
 
+	/*
+	 * If the iostat_cpu isn't in a lockless list, put it into the
+	 * list to indicate that a stat update is pending.
+	 */
+	if (!READ_ONCE(bis->lnode.next)) {
+		struct llist_head *lhead = this_cpu_ptr(blkcg->lhead);
+
+		sllist_add(&bis->lnode, lhead);
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
index d2724d1dd7c9..0968b6c8ea12 100644
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

