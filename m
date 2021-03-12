Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F352338B21
	for <lists+cgroups@lfdr.de>; Fri, 12 Mar 2021 12:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233814AbhCLLJU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 12 Mar 2021 06:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234070AbhCLLI4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 12 Mar 2021 06:08:56 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0521C061574;
        Fri, 12 Mar 2021 03:08:56 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id a24so11758884plm.11;
        Fri, 12 Mar 2021 03:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=mOluJ93ctbvVWP9kwZfABypMHTolG1Qs4tFru41TuAo=;
        b=bFr0Cm/ccCgxZmwTa4pB0vFfPyu5XMEI3ddSJnaMznUWusiiY7UIQUbzfiq8HDBWhA
         uqktinhBSYIaRqLr4A0rwuLt6y6chsEnKeeDRbNLQvDTvBzMKAL8wWbii+fiJHnoRR+/
         Xhs7eYwJVU1rTwE1RSm/AQ2tCwtYtAdmnZWorDE7t7rx404FpQpaVnugAtBB0SbC77L4
         btNlbT2fcP0/A7jUQ2WB3aOlG7OqpIN1asEV3oN7x4dicxEBPWYGr/mecyG58h8Fmah6
         IMmmKXDqeJNNp16nL+d67zNyc5564lqHpI4ViuSeomlaeHdXZUjUxl4/bv2lClJIsmFm
         8ZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=mOluJ93ctbvVWP9kwZfABypMHTolG1Qs4tFru41TuAo=;
        b=foq3NmSmFHvQJp2C8e6CkWx8SvSBSEaCHqEjS+dx5aMI29e6lEl4EZbXCs+1vcCmtY
         V4MG7jG9vZnsNJIaqvfmqoKQInY5q/bTO6av0mENvs90Vuny8jYcNu+MyN9pnL1p7T7C
         bieyf7qttvuqQT+LtqM0f7rV5ZfVo8H30H9c7DD1reOHJILZk7Evsj4SfL/62ACTMnXG
         jw+VyTRIoP4au5OxtjMjTDDcVTc5Y+JtS/hfE5PQ/nU6znWU5EH5L+k10s84n74LiwUj
         nVkUFBNDPsO/WOgkv+vFmwdPWaqvRxYk5YnwmB37UZ1kwrVqea6pygWREMlIYxCXG4Ps
         dmgA==
X-Gm-Message-State: AOAM532PaMpiMJbVkgD8D7BpMcf3ztAZ0VDoiJdctKHqg93XRWaIYDQw
        ORQ8aTvGztiKsbt1PVE21kQ=
X-Google-Smtp-Source: ABdhPJznG2R+fM09QMwzHhDMfoo4FDX8fWzhZYz7mPFHCKVFIOPrY0XpppoRhlQxRXhMe4z+1QISEw==
X-Received: by 2002:a17:90a:29e4:: with SMTP id h91mr13392740pjd.225.1615547336360;
        Fri, 12 Mar 2021 03:08:56 -0800 (PST)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id t5sm4942181pgl.89.2021.03.12.03.08.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Mar 2021 03:08:54 -0800 (PST)
From:   brookxu <brookxu.cn@gmail.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, tj@kernel.org
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 03/11] bfq: introduce bfq.ioprio for cgroup
Date:   Fri, 12 Mar 2021 19:08:37 +0800
Message-Id: <dfcdc7d36b8be38548c4bca931d83fef478287c6.1615527324.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1615517202.git.brookxu@tencent.com>
References: <cover.1615517202.git.brookxu@tencent.com>
In-Reply-To: <cover.1615527324.git.brookxu@tencent.com>
References: <cover.1615527324.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

Tasks in the production environment can be roughly divided into
three categories: emergency tasks, ordinary tasks and offline
tasks. Emergency tasks need to be scheduled in real time, such
as system agents. Offline tasks do not need to guarantee QoS,
but can improve system resource utilization during system idle
periods, such as background tasks. The above requirements need
to achieve IO preemption. At present, we can use weights to
simulate IO preemption, but since weights are more of a shared
concept, they cannot be simulated well. For example, the weights
of emergency tasks and ordinary tasks cannot be determined well,
offline tasks (with the same weight) actually occupy different
resources on disks with different performance, and the tail
latency caused by offline tasks cannot be well controlled. Using
ioprio's concept of preemption, we can solve the above problems
very well. Since ioprio will eventually be converted to weight,
using ioprio alone can also achieve weight isolation within the
same class. But we can still use bfq.weight to control resource,
achieving better IO Qos control.

However, currently the class of bfq_group is always be class, and
the ioprio class of the task can only be reflected in a single
cgroup. We cannot guarantee that real-time tasks in a cgroup are
scheduled in time. Therefore, we introduce bfq.ioprio, which
allows us to configure ioprio class for cgroup. In this way, we
can ensure that the real-time tasks of a cgroup can be scheduled
in time. Similarly, the processing of offline task groups can
also be simpler.

The bfq.ioprio interface now is available for cgroup v1 and cgroup
v2. Users can configure the ioprio for cgroup through this interface,
as shown below:

echo "1 2"> blkio.bfq.ioprio

The above two values respectively represent the values of ioprio
class and ioprio for cgroup. The ioprio of tasks within the cgroup
is uniformly equal to the ioprio of the cgroup. If the ioprio of
the cgroup is disabled, the ioprio of the task remains the same,
usually from io_context.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 block/bfq-cgroup.c  | 87 ++++++++++++++++++++++++++++++++++++++++++++-
 block/bfq-iosched.c |  5 +++
 block/bfq-iosched.h |  8 +++++
 block/bfq-wf2q.c    | 30 +++++++++++++---
 4 files changed, 124 insertions(+), 6 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 50d06c760194..ab4bc410e635 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -489,7 +489,7 @@ static struct bfq_group_data *cpd_to_bfqgd(struct blkcg_policy_data *cpd)
 	return cpd ? container_of(cpd, struct bfq_group_data, pd) : NULL;
 }
 
-static struct bfq_group_data *blkcg_to_bfqgd(struct blkcg *blkcg)
+struct bfq_group_data *blkcg_to_bfqgd(struct blkcg *blkcg)
 {
 	return cpd_to_bfqgd(blkcg_to_cpd(blkcg, &blkcg_policy_bfq));
 }
@@ -553,6 +553,16 @@ static void bfq_pd_init(struct blkg_policy_data *pd)
 	bfqg->bfqd = bfqd;
 	bfqg->active_entities = 0;
 	bfqg->rq_pos_tree = RB_ROOT;
+
+	bfqg->new_ioprio_class = IOPRIO_PRIO_CLASS(d->ioprio);
+	bfqg->new_ioprio = IOPRIO_PRIO_DATA(d->ioprio);
+	bfqg->ioprio_class = bfqg->new_ioprio_class;
+	bfqg->ioprio = bfqg->new_ioprio;
+
+	if (d->ioprio) {
+		entity->new_weight = bfq_ioprio_to_weight(bfqg->ioprio);
+		entity->weight = entity->new_weight;
+	}
 }
 
 static void bfq_pd_free(struct blkg_policy_data *pd)
@@ -981,6 +991,20 @@ static int bfq_io_show_weight(struct seq_file *sf, void *v)
 	return 0;
 }
 
+static int bfq_io_show_ioprio(struct seq_file *sf, void *v)
+{
+	struct blkcg *blkcg = css_to_blkcg(seq_css(sf));
+	struct bfq_group_data *bfqgd = blkcg_to_bfqgd(blkcg);
+	unsigned int val = 0;
+
+	if (bfqgd)
+		val = bfqgd->ioprio;
+
+	seq_printf(sf, "%u %lu\n", IOPRIO_PRIO_CLASS(val), IOPRIO_PRIO_DATA(val));
+
+	return 0;
+}
+
 static void bfq_group_set_weight(struct bfq_group *bfqg, u64 weight, u64 dev_weight)
 {
 	weight = dev_weight ?: weight;
@@ -1098,6 +1122,55 @@ static ssize_t bfq_io_set_weight(struct kernfs_open_file *of,
 	return bfq_io_set_device_weight(of, buf, nbytes, off);
 }
 
+static ssize_t bfq_io_set_ioprio(struct kernfs_open_file *of, char *buf,
+				 size_t nbytes, loff_t off)
+{
+	struct cgroup_subsys_state *css = of_css(of);
+	struct blkcg *blkcg = css_to_blkcg(css);
+	struct bfq_group_data *bfqgd = blkcg_to_bfqgd(blkcg);
+	struct blkcg_gq *blkg;
+	unsigned int class, data;
+	char *endp;
+
+	buf = strstrip(buf);
+
+	class = simple_strtoul(buf, &endp, 10);
+	if (*endp != ' ')
+		return -EINVAL;
+	buf = endp + 1;
+
+	data = simple_strtoul(buf, &endp, 10);
+	if ((*endp != ' ') && (*endp != '\0'))
+		return -EINVAL;
+
+	if (class > IOPRIO_CLASS_IDLE || data >= IOPRIO_BE_NR)
+		return -EINVAL;
+
+	spin_lock_irq(&blkcg->lock);
+	bfqgd->ioprio = IOPRIO_PRIO_VALUE(class, data);
+	hlist_for_each_entry(blkg, &blkcg->blkg_list, blkcg_node) {
+		struct bfq_group *bfqg = blkg_to_bfqg(blkg);
+
+		if (bfqg) {
+			if ((bfqg->ioprio_class != class) ||
+			    (bfqg->ioprio != data)) {
+				unsigned short weight;
+
+				weight = class ? bfq_ioprio_to_weight(data) :
+					BFQ_WEIGHT_LEGACY_DFL;
+
+				bfqg->new_ioprio_class = class;
+				bfqg->new_ioprio = data;
+				bfqg->entity.new_weight = weight;
+				bfqg->entity.prio_changed = 1;
+			}
+		}
+	}
+	spin_unlock_irq(&blkcg->lock);
+
+	return nbytes;
+}
+
 static int bfqg_print_rwstat(struct seq_file *sf, void *v)
 {
 	blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)), blkg_prfill_rwstat,
@@ -1264,6 +1337,12 @@ struct cftype bfq_blkcg_legacy_files[] = {
 		.seq_show = bfq_io_show_weight,
 		.write = bfq_io_set_weight,
 	},
+	{
+		.name = "bfq.ioprio",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = bfq_io_show_ioprio,
+		.write = bfq_io_set_ioprio,
+	},
 
 	/* statistics, covers only the tasks in the bfqg */
 	{
@@ -1384,6 +1463,12 @@ struct cftype bfq_blkg_files[] = {
 		.seq_show = bfq_io_show_weight,
 		.write = bfq_io_set_weight,
 	},
+	{
+		.name = "bfq.ioprio",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = bfq_io_show_ioprio,
+		.write = bfq_io_set_ioprio,
+	},
 	{} /* terminate */
 };
 
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index ec482e6641ff..f0f53d6f1f6e 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5105,7 +5105,12 @@ static void bfq_check_ioprio_change(struct bfq_io_cq *bic, struct bio *bio)
 {
 	struct bfq_data *bfqd = bic_to_bfqd(bic);
 	struct bfq_queue *bfqq;
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+	struct bfq_group_data *bfqgd = blkcg_to_bfqgd(__bio_blkcg(bio));
+	int ioprio = bfqgd->ioprio ?: bic->icq.ioc->ioprio;
+#else
 	int ioprio = bic->icq.ioc->ioprio;
+#endif
 
 	/*
 	 * This condition may trigger on a newly created bic, be sure to
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 28d85903cf66..3416a75f47da 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -867,6 +867,7 @@ struct bfq_group_data {
 	struct blkcg_policy_data pd;
 
 	unsigned int weight;
+	unsigned short ioprio;
 };
 
 /**
@@ -923,6 +924,11 @@ struct bfq_group {
 
 	int active_entities;
 
+	/* current ioprio and ioprio class */
+	unsigned short ioprio, ioprio_class;
+	/* next ioprio and ioprio class if a change is in progress */
+	unsigned short new_ioprio, new_ioprio_class;
+
 	struct rb_root rq_pos_tree;
 
 	struct bfqg_stats stats;
@@ -991,6 +997,7 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 void bfq_init_entity(struct bfq_entity *entity, struct bfq_group *bfqg);
 void bfq_bic_update_cgroup(struct bfq_io_cq *bic, struct bio *bio);
 void bfq_end_wr_async(struct bfq_data *bfqd);
+struct bfq_group_data *blkcg_to_bfqgd(struct blkcg *blkcg);
 struct bfq_group *bfq_find_set_group(struct bfq_data *bfqd,
 				     struct blkcg *blkcg);
 struct blkcg_gq *bfqg_to_blkg(struct bfq_group *bfqg);
@@ -1037,6 +1044,7 @@ extern struct blkcg_policy blkcg_policy_bfq;
 
 struct bfq_group *bfq_bfqq_to_bfqg(struct bfq_queue *bfqq);
 struct bfq_queue *bfq_entity_to_bfqq(struct bfq_entity *entity);
+unsigned int bfq_class_idx(struct bfq_entity *entity);
 unsigned int bfq_tot_busy_queues(struct bfq_data *bfqd);
 struct bfq_service_tree *bfq_entity_service_tree(struct bfq_entity *entity);
 struct bfq_entity *bfq_entity_of(struct rb_node *node);
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 276f225f9c6e..7405be960a92 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -27,12 +27,21 @@ static struct bfq_entity *bfq_root_active_entity(struct rb_root *tree)
 	return rb_entry(node, struct bfq_entity, rb_node);
 }
 
-static unsigned int bfq_class_idx(struct bfq_entity *entity)
+unsigned int bfq_class_idx(struct bfq_entity *entity)
 {
 	struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
+	unsigned short class = BFQ_DEFAULT_GRP_CLASS;
 
-	return bfqq ? bfqq->ioprio_class - 1 :
-		BFQ_DEFAULT_GRP_CLASS - 1;
+	if (bfqq)
+		class = bfqq->ioprio_class;
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+	else {
+		struct bfq_group *bfqg = bfq_entity_to_bfqg(entity);
+
+		class = bfqg->ioprio_class ?: BFQ_DEFAULT_GRP_CLASS;
+	}
+#endif
+	return class - 1;
 }
 
 unsigned int bfq_tot_busy_queues(struct bfq_data *bfqd)
@@ -767,14 +776,25 @@ __bfq_entity_update_weight_prio(struct bfq_service_tree *old_st,
 				  bfq_weight_to_ioprio(entity->orig_weight);
 		}
 
-		if (bfqq && update_class_too)
-			bfqq->ioprio_class = bfqq->new_ioprio_class;
+		if (update_class_too) {
+			if (bfqq)
+				bfqq->ioprio_class = bfqq->new_ioprio_class;
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+			else
+				bfqg->ioprio_class = bfqg->new_ioprio_class;
+#endif
+		}
 
 		/*
 		 * Reset prio_changed only if the ioprio_class change
 		 * is not pending any longer.
 		 */
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+		if ((bfqq && bfqq->ioprio_class == bfqq->new_ioprio_class) ||
+		    (!bfqq && bfqg->ioprio_class == bfqg->new_ioprio_class))
+#else
 		if (!bfqq || bfqq->ioprio_class == bfqq->new_ioprio_class)
+#endif
 			entity->prio_changed = 0;
 
 		/*
-- 
2.30.0

