Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF89A2F60FC
	for <lists+cgroups@lfdr.de>; Thu, 14 Jan 2021 13:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbhANMSx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 Jan 2021 07:18:53 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10657 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbhANMSx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 14 Jan 2021 07:18:53 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DGjx012GHz15t0F;
        Thu, 14 Jan 2021 20:17:08 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.498.0; Thu, 14 Jan 2021
 20:18:03 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <tj@kernel.org>, <axboe@kernel.dk>, <paolo.valente@linaro.org>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH] bfq: don't check active group if bfq.weight is not changed
Date:   Thu, 14 Jan 2021 20:24:26 +0800
Message-ID: <20210114122426.603813-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <b4163392-0462-ff6f-b958-1f96f33d69e6@huawei.com>
References: <b4163392-0462-ff6f-b958-1f96f33d69e6@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Now the group scheduling in BFQ depends on the check of active group,
but in most cases group scheduling is not used and the checking
of active group will cause bfq_asymmetric_scenario() and its caller
bfq_better_to_idle() to always return true, so the throughput
will be impacted if the workload doesn't need idle (e.g. random rw)

To fix that, adding check in bfq_io_set_weight_legacy() and
bfq_pd_init() to check whether or not group scheduling is used
(a non-default weight is used). If not, there is no need
to check active group.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-cgroup.c  | 14 ++++++++++++--
 block/bfq-iosched.c |  8 +++-----
 block/bfq-iosched.h | 19 +++++++++++++++++++
 3 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index b791e2041e49..b4ac42c4bd9f 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -505,12 +505,18 @@ static struct blkcg_policy_data *bfq_cpd_alloc(gfp_t gfp)
 	return &bgd->pd;
 }
 
+static inline int bfq_dft_weight(void)
+{
+	return cgroup_subsys_on_dfl(io_cgrp_subsys) ?
+	       CGROUP_WEIGHT_DFL : BFQ_WEIGHT_LEGACY_DFL;
+
+}
+
 static void bfq_cpd_init(struct blkcg_policy_data *cpd)
 {
 	struct bfq_group_data *d = cpd_to_bfqgd(cpd);
 
-	d->weight = cgroup_subsys_on_dfl(io_cgrp_subsys) ?
-		CGROUP_WEIGHT_DFL : BFQ_WEIGHT_LEGACY_DFL;
+	d->weight = bfq_dft_weight();
 }
 
 static void bfq_cpd_free(struct blkcg_policy_data *cpd)
@@ -554,6 +560,9 @@ static void bfq_pd_init(struct blkg_policy_data *pd)
 	bfqg->bfqd = bfqd;
 	bfqg->active_entities = 0;
 	bfqg->rq_pos_tree = RB_ROOT;
+
+	if (entity->new_weight != bfq_dft_weight())
+		bfqd_enable_active_group_check(bfqd);
 }
 
 static void bfq_pd_free(struct blkg_policy_data *pd)
@@ -1013,6 +1022,7 @@ static void bfq_group_set_weight(struct bfq_group *bfqg, u64 weight, u64 dev_wei
 		 */
 		smp_wmb();
 		bfqg->entity.prio_changed = 1;
+		bfqd_enable_active_group_check(bfqg->bfqd);
 	}
 }
 
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 9e4eb0fc1c16..1b695de1df95 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -699,11 +699,8 @@ static bool bfq_asymmetric_scenario(struct bfq_data *bfqd,
 		(bfqd->busy_queues[0] && bfqd->busy_queues[2]) ||
 		(bfqd->busy_queues[1] && bfqd->busy_queues[2]);
 
-	return varied_queue_weights || multiple_classes_busy
-#ifdef CONFIG_BFQ_GROUP_IOSCHED
-	       || bfqd->num_groups_with_pending_reqs > 0
-#endif
-		;
+	return varied_queue_weights || multiple_classes_busy ||
+	       bfqd_has_active_group(bfqd);
 }
 
 /*
@@ -6472,6 +6469,7 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 
 	bfqd->queue_weights_tree = RB_ROOT_CACHED;
 	bfqd->num_groups_with_pending_reqs = 0;
+	bfqd->check_active_group = false;
 
 	INIT_LIST_HEAD(&bfqd->active_list);
 	INIT_LIST_HEAD(&bfqd->idle_list);
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 703895224562..216509013012 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -524,6 +524,8 @@ struct bfq_data {
 
 	/* true if the device is non rotational and performs queueing */
 	bool nonrot_with_queueing;
+	/* true if need to check num_groups_with_pending_reqs */
+	bool check_active_group;
 
 	/*
 	 * Maximum number of requests in driver in the last
@@ -1066,6 +1068,17 @@ static inline void bfq_pid_to_str(int pid, char *str, int len)
 }
 
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
+static inline void bfqd_enable_active_group_check(struct bfq_data *bfqd)
+{
+	cmpxchg_relaxed(&bfqd->check_active_group, false, true);
+}
+
+static inline bool bfqd_has_active_group(struct bfq_data *bfqd)
+{
+	return bfqd->check_active_group &&
+	       bfqd->num_groups_with_pending_reqs > 0;
+}
+
 struct bfq_group *bfqq_group(struct bfq_queue *bfqq);
 
 #define bfq_log_bfqq(bfqd, bfqq, fmt, args...)	do {			\
@@ -1085,6 +1098,12 @@ struct bfq_group *bfqq_group(struct bfq_queue *bfqq);
 } while (0)
 
 #else /* CONFIG_BFQ_GROUP_IOSCHED */
+static inline void bfqd_enable_active_group_check(struct bfq_data *bfqd) {}
+
+static inline bool bfqd_has_active_group(struct bfq_data *bfqd)
+{
+	return false;
+}
 
 #define bfq_log_bfqq(bfqd, bfqq, fmt, args...) do {	\
 	char pid_str[MAX_PID_STR_LENGTH];	\
-- 
2.25.4

