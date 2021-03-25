Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84D3A348995
	for <lists+cgroups@lfdr.de>; Thu, 25 Mar 2021 07:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbhCYG6R (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Mar 2021 02:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhCYG6G (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 Mar 2021 02:58:06 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845D8C06174A;
        Wed, 24 Mar 2021 23:58:06 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id q6-20020a17090a4306b02900c42a012202so515070pjg.5;
        Wed, 24 Mar 2021 23:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=qGY1Kg03OXm+zTrKJxIt7fh+GQW7rx9ophC48RACBkY=;
        b=PoYH9mvvnNVP6JWfNmsb2+qrlA/hCF7KHUSTenHZAmBvsPTqOvBuDDCsnw1wPmJ1Hr
         OulmyZxgzFhqw4Sx4zsfbaxf9AyYeztixpIxuLBArjwbo44KzlIn8KzyI62F2xG2ko0v
         ePyKldQ7FrMl6L0d+0pezfUWXUFKG8FobZFowyQbUPIYUwQA1RT8YbnGZrlZYEi5aLMv
         ZfT88AN6rB+HwgcZYr2pT+8wubQqAyf6wNmte1JZYwQjjp+bn0fungHuko/G564LEUT2
         l+8qruqdcHSg+PvAWtlxO6NYaqx8mBJxitS0KLV6IZpehlba4uzp8pOWntMzviwVvQKH
         zclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=qGY1Kg03OXm+zTrKJxIt7fh+GQW7rx9ophC48RACBkY=;
        b=aI9yhs2n4XXWk0LrbPExpnhXWtV87KDSVJuzKFvUCxVA752S3f9jJRz3oxxGrG4+6V
         jCJTJ5o3VBknJTVC/1/LMP5oMZIoy/1BRXu1Nn0M3rd71+J+euzz9hOgJrfh6Qx8mCPh
         h+6UeJlumort8MKw+rE54O2fUHCrQwtSIaY5icEnALe6gIl++21VDa4OirtZ32/OzjOe
         O7z1C68yKQiQC+XPD+kEZIAoNCnwx6sYkJ1B/W2+H9rhOmkXmVhtCn9hl/SynMf4A5VR
         wBMBoS1vBokr/3kwUPwNuzTzE2iRkAYH6MTG/OM5xuIxHedsWcvKXy5V10sxRm0u9Fnl
         SJvA==
X-Gm-Message-State: AOAM531CYrpiONX1PLQxLmiW1hRQRR4+onSSJHICftzei+IvV+doDtGq
        +YIdiy1SyS9yJTDVpG1IrhE=
X-Google-Smtp-Source: ABdhPJw04yBK4UaDzd1Vbp01UwkPzY8TdFQS7h3R96jrtqqmvsUOAyc5GD8XTkAUlKTSR+88Cga1dQ==
X-Received: by 2002:a17:90a:5b0b:: with SMTP id o11mr7207647pji.150.1616655486151;
        Wed, 24 Mar 2021 23:58:06 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id x19sm4470202pfc.152.2021.03.24.23.58.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Mar 2021 23:58:05 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, tj@kernel.org
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 03/14] bfq: introduce bfq.ioprio for cgroup
Date:   Thu, 25 Mar 2021 14:57:47 +0800
Message-Id: <b14c6ac8feeb919815a99c48a9ef8b8fb2ed8569.1616649216.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1616649216.git.brookxu@tencent.com>
References: <cover.1616649216.git.brookxu@tencent.com>
In-Reply-To: <cover.1616649216.git.brookxu@tencent.com>
References: <cover.1616649216.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

Now the ioprio class of all groups is CLASS_BE, which is not very
friendly to the container scene. Therefore, we introduce the bfq.ioprio
interface to allow users to configure the ioprio class and ioprio of
the group, which can meet more priority requirements.

The bfq.ioprio interface now is available for cgroup v1 and cgroup
v2. Users can configure the ioprio for cgroup through this interface,
as shown below:

echo "1 2"> blkio.bfq.ioprio

The above two values respectively represent the values of ioprio
class and ioprio for cgroup. When necessary, we can disable this
feature by:

echo "0 0" > bfq.ioprio.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 block/bfq-cgroup.c  | 87 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 block/bfq-iosched.h |  8 +++++
 block/bfq-wf2q.c    | 30 +++++++++++++++---
 3 files changed, 119 insertions(+), 6 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 50d06c7..ab4bc41 100644
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
 
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 28d8590..3416a75 100644
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
@@ -1037,6 +1044,7 @@ struct bfq_group *bfq_find_set_group(struct bfq_data *bfqd,
 
 struct bfq_group *bfq_bfqq_to_bfqg(struct bfq_queue *bfqq);
 struct bfq_queue *bfq_entity_to_bfqq(struct bfq_entity *entity);
+unsigned int bfq_class_idx(struct bfq_entity *entity);
 unsigned int bfq_tot_busy_queues(struct bfq_data *bfqd);
 struct bfq_service_tree *bfq_entity_service_tree(struct bfq_entity *entity);
 struct bfq_entity *bfq_entity_of(struct rb_node *node);
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 276f225..7405be9 100644
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
@@ -767,14 +776,25 @@ struct bfq_service_tree *
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
1.8.3.1

