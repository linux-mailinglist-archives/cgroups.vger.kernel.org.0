Return-Path: <cgroups+bounces-257-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EE07E615B
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 01:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E7492812DF
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 00:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AEA7E4;
	Thu,  9 Nov 2023 00:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMtTE/fx"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F48383;
	Thu,  9 Nov 2023 00:25:28 +0000 (UTC)
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65622268D;
	Wed,  8 Nov 2023 16:25:28 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id 41be03b00d2f7-5bdc185c449so219684a12.0;
        Wed, 08 Nov 2023 16:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699489528; x=1700094328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+vLMcQqPa9/uA9h+Ooe3B/NT+SKXukU8inBObWmrPM=;
        b=DMtTE/fxZKcO0Pu4KdZbzOyX4CRAGb7abzyRvRYcIS2rhep/xGRNBVn10foSlKfPOC
         g2Z2vcQ8WOuZLVzknRhmP10XPPrf3ARuHeF3zFOjq36ZlukrT4eOBxwWA0ujx86yRfsr
         cpD1f5kH+/yzkGFQHRHPaoqQ/NPpYLd+wfcwF0vvDRO1n7ZBx8CW4gNUlxSlSvdjKnWn
         fxX3/tASSkkap531Gx4TxVTeSommGgZJttLtCIUylNqXJT6aYBgvPg5GB6cSRqj5CgfN
         rtRLb4oOc/ssnpRf9ErrRtTdZ6mcN3lUuRrZkX7jgtXetx4Z95o5vGuJYgSha6DCcGr1
         obIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699489528; x=1700094328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x+vLMcQqPa9/uA9h+Ooe3B/NT+SKXukU8inBObWmrPM=;
        b=DaulEHck6Sljv37jBF4U4VDdydWg7AtuwwO9ZKl+kxJl8m/52gQ/yw5wQneNvEPfVh
         M7rLjoYIdTLFWVvR/PAqOTQ12C1i0kJQE8lPLZaYgSE7Z1s0uJvD8fWXQRyEKj9NSGeA
         3i+eJp7Jp8H2fC8DpWqNNkfK6pfkGBJ/tQNrUyhQUEFQzG0k0eZnaslVC4tpHqIMrj0D
         boLPG4v9anBceZ7J26WPWMqwKkBciKesrs2B4OgB8OQU7/iSNeuU0D+4hiWdvQMygw52
         2vl0cvHzUjj3gfbKI/KtVxvPrK33Nu1vXaE+MJKuu3v2goQoU+oSD1CVQtwxIa38m9vk
         kLvQ==
X-Gm-Message-State: AOJu0YxViwmZlFPYwwjYLzzv1BOcq0JCu7tlufZUIY8bK50rr7jsCi+C
	QhTZtMc07E/l24Ic2EW/5qdNUgQU+lJl
X-Google-Smtp-Source: AGHT+IFJa3XqHfr7w43VvBJ++JO55x37+essItDkdmOarWpBCb4W6tU0UNUrxGBma9nAsrqSWjotag==
X-Received: by 2002:a05:6a20:7f93:b0:180:f0ed:2992 with SMTP id d19-20020a056a207f9300b00180f0ed2992mr2006580pzj.51.1699489527665;
        Wed, 08 Nov 2023 16:25:27 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id b10-20020a170902a9ca00b001bc21222e34sm2219073plr.285.2023.11.08.16.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 16:25:27 -0800 (PST)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: linux-kernel@vger.kernel.org
Cc: linux-cxl@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	ying.huang@intel.com,
	akpm@linux-foundation.org,
	mhocko@kernel.org,
	tj@kernel.org,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	corbet@lwn.net,
	roman.gushchin@linux.dev,
	shakeelb@google.com,
	muchun.song@linux.dev,
	Gregory Price <gregory.price@memverge.com>
Subject: [RFC PATCH v4 1/3] mm/memcontrol: implement memcg.interleave_weights
Date: Wed,  8 Nov 2023 19:25:15 -0500
Message-Id: <20231109002517.106829-2-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231109002517.106829-1-gregory.price@memverge.com>
References: <20231109002517.106829-1-gregory.price@memverge.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create an RCU-protected array of unsigned char[MAX_NUMNODES] where
interleave weights can be stored.  The intent of these weights are
to be used by mempolicy to implement weighted interleave for
bandwidth optimization.

Node weights assigned via cgroup/memory.interleave_weights

Example: Set a 3:1 weighting ratio for nodes 0 and 1 respectively.
  echo 0:3 > cgroup/memory.interleave_weights
  echo 1:1 > cgroup/memory.interleave_weights

Example output:
  cat cgroup/memory.interleave_weights
  0:3,1:1

Child cgroups inherit parent interleave weights and may override them.

To revert weights to inheriting from the parent, write "-1:0"

Example:
  echo -1:0 > cgroup/memory.interleave_weights

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 include/linux/memcontrol.h |  31 +++++++
 mm/memcontrol.c            | 172 +++++++++++++++++++++++++++++++++++++
 2 files changed, 203 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index e4e24da16d2c..338a9dcda446 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -21,6 +21,8 @@
 #include <linux/vmstat.h>
 #include <linux/writeback.h>
 #include <linux/page-flags.h>
+#include <linux/numa.h>
+#include <linux/nodemask.h>
 
 struct mem_cgroup;
 struct obj_cgroup;
@@ -167,6 +169,15 @@ struct mem_cgroup_thresholds {
 	struct mem_cgroup_threshold_ary *spare;
 };
 
+/* For mempolicy information */
+struct mem_cgroup_mempolicy {
+	/*
+	 * When interleaving is applied, do allocations on each node by the
+	 * weight value.  Size is always MAX_NUMNODES. Protected by RCU.
+	 */
+	unsigned char *il_weights;
+};
+
 /*
  * Remember four most recent foreign writebacks with dirty pages in this
  * cgroup.  Inode sharing is expected to be uncommon and, even if we miss
@@ -265,6 +276,12 @@ struct mem_cgroup {
 	/* thresholds for mem+swap usage. RCU-protected */
 	struct mem_cgroup_thresholds memsw_thresholds;
 
+	/* protect the mempolicy settings */
+	struct mutex mempolicy_lock;
+
+	/* mempolicy defaults for tasks */
+	struct mem_cgroup_mempolicy mempolicy;
+
 	/* For oom notifier event fd */
 	struct list_head oom_notify;
 
@@ -1159,6 +1176,12 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 						gfp_t gfp_mask,
 						unsigned long *total_scanned);
 
+
+unsigned char mem_cgroup_get_il_weight(unsigned int nid);
+
+unsigned int mem_cgroup_get_il_weights(nodemask_t *nodes,
+				       unsigned char *weights);
+
 #else /* CONFIG_MEMCG */
 
 #define MEM_CGROUP_ID_SHIFT	0
@@ -1591,6 +1614,14 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 {
 	return 0;
 }
+
+static unsigned char mem_cgroup_get_il_weight(unsigned int nid) { return 0; }
+
+static unsigned int mem_cgroup_get_il_weights(nodemask_t *nodes,
+					      unsigned char *weights)
+{
+	return 0;
+}
 #endif /* CONFIG_MEMCG */
 
 static inline void __inc_lruvec_kmem_state(void *p, enum node_stat_item idx)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5b009b233ab8..67e8c1767471 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5319,6 +5319,7 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 	INIT_WORK(&memcg->high_work, high_work_func);
 	INIT_LIST_HEAD(&memcg->oom_notify);
 	mutex_init(&memcg->thresholds_lock);
+	mutex_init(&memcg->mempolicy_lock);
 	spin_lock_init(&memcg->move_lock);
 	vmpressure_init(&memcg->vmpressure);
 	INIT_LIST_HEAD(&memcg->event_list);
@@ -7896,6 +7897,176 @@ static struct cftype zswap_files[] = {
 };
 #endif /* CONFIG_MEMCG_KMEM && CONFIG_ZSWAP */
 
+unsigned char mem_cgroup_get_il_weight(unsigned int nid)
+{
+	struct mem_cgroup *memcg;
+	unsigned char weight = 0;
+	unsigned char *weights;
+
+	rcu_read_lock();
+	memcg = mem_cgroup_from_task(current);
+	while (!mem_cgroup_is_root(memcg)) {
+		weights = rcu_dereference(memcg->mempolicy.il_weights);
+		if (weights) {
+			weight = weights[nid];
+			break;
+		}
+		memcg = parent_mem_cgroup(memcg);
+	}
+	rcu_read_unlock();
+
+	return weight;
+}
+
+unsigned int mem_cgroup_get_il_weights(nodemask_t *nodes,
+				       unsigned char *weights)
+{
+	struct mem_cgroup *memcg;
+	unsigned char *memcg_weights;
+	unsigned int nid;
+	unsigned int total = 0;
+	unsigned char weight;
+
+	rcu_read_lock();
+	memcg = mem_cgroup_from_task(current);
+	while (memcg && !mem_cgroup_is_root(memcg)) {
+		memcg_weights = rcu_dereference(memcg->mempolicy.il_weights);
+		if (!memcg_weights) {
+			memcg = parent_mem_cgroup(memcg);
+			continue;
+		}
+
+		for_each_node_mask(nid, *nodes) {
+			weight = memcg_weights[nid];
+			weights[nid] = weight ? weight : 1;
+			total += weights[nid];
+		}
+		break;
+	}
+	rcu_read_unlock();
+
+	return total;
+}
+
+static int mpol_ilw_show(struct seq_file *m, void *v)
+{
+	struct mem_cgroup *memcg;
+	unsigned char *weights;
+	unsigned int nid;
+	unsigned int count = 0;
+
+	rcu_read_lock();
+	memcg = mem_cgroup_from_seq(m);
+
+	while (memcg && !mem_cgroup_is_root(memcg)) {
+		weights = rcu_dereference(memcg->mempolicy.il_weights);
+		if (weights)
+			break;
+		memcg = parent_mem_cgroup(memcg);
+	}
+	for_each_node(nid) {
+		seq_printf(m, "%s%d:%d", (count++ ? "," : ""), nid,
+			   weights ? weights[nid] : 1);
+	}
+	seq_putc(m, '\n');
+	rcu_read_unlock();
+
+	return 0;
+}
+
+static ssize_t mpol_ilw_write(struct kernfs_open_file *of, char *buf,
+			      size_t nbytes, loff_t off)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+	struct mem_cgroup *pmcg;
+	unsigned char *new_weights = NULL, *old_weights = NULL;
+	int node;
+	unsigned char weight;
+	ssize_t ret;
+	char *sep = memchr(buf, ':', nbytes);
+	bool parent_weights = false;
+
+	if (!sep || sep == buf || sep == (buf + nbytes - 1))
+		return -EINVAL;
+	*sep = '\0';
+
+	ret = kstrtoint(buf, 10, &node);
+	if (ret)
+		return ret;
+
+	ret = kstrtou8(sep + 1, 10, &weight);
+	if (ret)
+		return ret;
+
+	/*
+	 * if value is -1:0, clear weights and set pointer to NULL
+	 * this allows the parent cgroup settings to take over
+	 */
+	if (node == -1 && weight == 0)
+		goto set_weights;
+	else if (node < 0)
+		return -EINVAL;
+	else if (node >= MAX_NUMNODES || weight == 0)
+		return -EINVAL;
+
+	new_weights = kzalloc(sizeof(unsigned char)*MAX_NUMNODES, GFP_KERNEL);
+	if (!new_weights)
+		return -ENOMEM;
+set_weights:
+	/* acquire mutex and readlock so we can read from parents if needed */
+	mutex_lock(&memcg->mempolicy_lock);
+	rcu_read_lock();
+	old_weights = rcu_dereference(memcg->mempolicy.il_weights);
+
+	/* If we're clearing the weights, don't bother looking at old ones */
+	if (!new_weights)
+		goto swap_weights;
+
+	/* Check for parent weights to inherit */
+	pmcg = memcg;
+	while (!old_weights) {
+		pmcg = parent_mem_cgroup(pmcg);
+
+		if (!pmcg || mem_cgroup_is_root(pmcg))
+			break;
+		old_weights = rcu_dereference(pmcg->mempolicy.il_weights);
+		parent_weights = true;
+	}
+
+	/* Copy the old weights or default all nodes to 1 */
+	if (old_weights)
+		memcpy(new_weights, old_weights,
+		       sizeof(unsigned char)*MAX_NUMNODES);
+	else
+		memset(new_weights, 1,
+		       sizeof(unsigned char)*MAX_NUMNODES);
+	new_weights[node] = weight;
+
+swap_weights:
+	rcu_assign_pointer(memcg->mempolicy.il_weights, new_weights);
+
+	rcu_read_unlock();
+	synchronize_rcu();
+
+	/* If we are inheriting weights from the parent, do not free */
+	if (old_weights && !parent_weights)
+		kfree(old_weights);
+
+	mutex_unlock(&memcg->mempolicy_lock);
+
+	return nbytes;
+}
+
+static struct cftype mempolicy_files[] = {
+	{
+		.name = "interleave_weights",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = mpol_ilw_show,
+		.write = mpol_ilw_write,
+	},
+	{ }	/* terminate */
+};
+
 static int __init mem_cgroup_swap_init(void)
 {
 	if (mem_cgroup_disabled())
@@ -7906,6 +8077,7 @@ static int __init mem_cgroup_swap_init(void)
 #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
 	WARN_ON(cgroup_add_dfl_cftypes(&memory_cgrp_subsys, zswap_files));
 #endif
+	WARN_ON(cgroup_add_dfl_cftypes(&memory_cgrp_subsys, mempolicy_files));
 	return 0;
 }
 subsys_initcall(mem_cgroup_swap_init);
-- 
2.39.1


