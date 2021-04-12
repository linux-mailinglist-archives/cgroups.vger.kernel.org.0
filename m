Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67AD935CED9
	for <lists+cgroups@lfdr.de>; Mon, 12 Apr 2021 18:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243614AbhDLQvH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Apr 2021 12:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345710AbhDLQrr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Apr 2021 12:47:47 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979CEC06138F
        for <cgroups@vger.kernel.org>; Mon, 12 Apr 2021 09:46:17 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id l123so9544363pfl.8
        for <cgroups@vger.kernel.org>; Mon, 12 Apr 2021 09:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bDoQ3MWY51K+4LEtjGvv0G7/nxtenaGHylfq6YF5/1o=;
        b=ayZNQFloBbIQ3ueLQOPlazrJ+0pQkvp5QezIAsQn0KsnK3+TXY0Lrdz/VcBHxlCUA6
         mgs2tdQRVWg1gYE6JfuUdHDSNW1k2tdjTIiJRC56Rh3FRfXybB3whhvAeIG/128NUD3E
         5XoNAqgmIRou4+OL5cwjF5KfcVT1MKlcgE/Nbrgvz4Bulf5hBrGMV/y99FisZvH+Dhws
         CjxyvBSLOP6xRF+3KiW2V1giBEh2QaqGYXGpPR7pNeab3cBiBHZEDYMdVeFGmvklnQHo
         NLw3gvoyXg6xqkikrFOo70JHvtOEOjm//U5FryTHx2NCqtt6JKwj2P9Of4ZaFOCmqxXB
         BcDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bDoQ3MWY51K+4LEtjGvv0G7/nxtenaGHylfq6YF5/1o=;
        b=s8e7EBcIAkEySwdoGIzhy08fVNYMqvcUWLUhTDLeKBPHuLodwOeFxP3PjJ/NkM4Tj0
         QZstn8uRAoZgymoxdeBk2uH1DmrIbySxo7OjCRzOFQOzoD0ca68AURxUaPCedQftFVc/
         JMFF/0yFA4bzCvWHUVHsWQF8/COhHxufutDEwD7pP3X0CVKbm5o8ENkazXB6voXXkl9x
         TYFj+xU2y86Ym1Id4J243/L2iU3At6/2/QvsL0kCbHA6PKeZ/toxSr+TwX/CiTjXmxoT
         GEE5YntdgtWw9qBYr/3UJFYYNScg/3MMPRiwoLb5BDXt2/pN0FsaJjIjLSiPz0qINKUf
         K7iw==
X-Gm-Message-State: AOAM5334zZ831NV1wbvefJQ9sjUcFgsxU7ZZLsEl3VYD2KwIDafB+/+g
        W1AUwXm8nJcyn7O5MpqU3MA=
X-Google-Smtp-Source: ABdhPJzKnY9C2mvpxwcEgqsFMqhH6Nn8T8fLad48gtqXg/5lxW6jq3ekzJFZIX9DzcyLA6l7ozsE0Q==
X-Received: by 2002:a63:3752:: with SMTP id g18mr27250724pgn.388.1618245976990;
        Mon, 12 Apr 2021 09:46:16 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id s20sm8317350pfh.144.2021.04.12.09.46.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Apr 2021 09:46:16 -0700 (PDT)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        christian@brauner.io
Cc:     cgroups@vger.kernel.org, benbjiang@tencent.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        linussli@tencent.com, herberthbli@tencent.com,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Haiwei Li <gerryhwli@tencent.com>
Subject: [RFC v2 2/2] memcg: introduce prioritized oom in memcg
Date:   Tue, 13 Apr 2021 00:46:08 +0800
Message-Id: <3e77b72f9b2c8ebf66b5617216d7f8b33547c8ff.1618219939.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1618219939.git.yuleixzhang@tencent.com>
References: <cover.1618219939.git.yuleixzhang@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

In current implementation when memcg oom happens it will select
victim from the memcg hierarchy, with the assistant of priority
attribute in the first patch, it will be able to select the
victim in memcg with the order from low to high priority,
and try the best to keep the high priority tasks survived from oom.

A new trigger memory.use_priority_oom is introduced to contorl
the enabling of the policy. And for global oom it will check the
memory.use_priority_oom setting in root memcg, by default this
is disabled.

Signed-off-by: Haiwei Li <gerryhwli@tencent.com>
Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
---
 include/linux/memcontrol.h | 38 +++++++++++++++
 include/linux/oom.h        |  1 +
 mm/memcontrol.c            | 99 +++++++++++++++++++++++++++++++++++++-
 mm/oom_kill.c              |  6 +--
 4 files changed, 139 insertions(+), 5 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0c04d39a7..68e1acf64 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -27,6 +27,7 @@ struct obj_cgroup;
 struct page;
 struct mm_struct;
 struct kmem_cache;
+struct oom_control;
 
 /* Cgroup-specific page state, on top of universal node page state */
 enum memcg_stat_item {
@@ -253,6 +254,9 @@ struct mem_cgroup {
 	bool		oom_lock;
 	int		under_oom;
 
+	/* memcg priority */
+	bool use_priority_oom;
+
 	int	swappiness;
 	/* OOM-Killer disable */
 	int		oom_kill_disable;
@@ -812,6 +816,24 @@ static inline bool mem_cgroup_online(struct mem_cgroup *memcg)
 	return !!(memcg->css.flags & CSS_ONLINE);
 }
 
+/*
+ * memcg priority
+ */
+void mem_cgroup_select_bad_process(struct oom_control *oc);
+
+void mem_cgroup_oom_select_bad_process(struct oom_control *oc);
+
+static inline bool root_memcg_use_priority_oom(void)
+{
+	if (mem_cgroup_disabled())
+		return false;
+
+	if (root_mem_cgroup->use_priority_oom)
+		return true;
+
+	return false;
+}
+
 /*
  * For memory reclaim.
  */
@@ -1262,6 +1284,22 @@ static inline bool mem_cgroup_online(struct mem_cgroup *memcg)
 	return true;
 }
 
+/*
+ * memcg priority
+ */
+static inline void mem_cgroup_select_bad_process(struct oom_control *oc)
+{
+}
+
+static inline void mem_cgroup_oom_select_bad_process(struct oom_control *oc)
+{
+}
+
+static inline bool root_memcg_use_priority_oom(void)
+{
+	return false;
+}
+
 static inline
 unsigned long mem_cgroup_get_zone_lru_size(struct lruvec *lruvec,
 		enum lru_list lru, int zone_idx)
diff --git a/include/linux/oom.h b/include/linux/oom.h
index 2db9a1432..a47e455ab 100644
--- a/include/linux/oom.h
+++ b/include/linux/oom.h
@@ -121,6 +121,7 @@ extern int unregister_oom_notifier(struct notifier_block *nb);
 extern bool oom_killer_disable(signed long timeout);
 extern void oom_killer_enable(void);
 
+extern int oom_evaluate_task(struct task_struct *task, void *arg);
 extern struct task_struct *find_lock_task_mm(struct task_struct *p);
 
 /* sysctls */
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e064ac0d8..30c8aae17 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1284,8 +1284,6 @@ int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
 	struct mem_cgroup *iter;
 	int ret = 0;
 
-	BUG_ON(memcg == root_mem_cgroup);
-
 	for_each_mem_cgroup_tree(iter, memcg) {
 		struct css_task_iter it;
 		struct task_struct *task;
@@ -1302,6 +1300,73 @@ int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
 	return ret;
 }
 
+int mem_cgroup_select_victim(struct cgroup_subsys_state *css, struct oom_control *oc)
+{
+	struct css_task_iter it;
+	struct task_struct *task;
+	int ret = 0;
+
+	css_task_iter_start(css, CSS_TASK_ITER_PROCS, &it);
+	while (!ret && (task = css_task_iter_next(&it)))
+		ret = oom_evaluate_task(task, oc);
+	css_task_iter_end(&it);
+
+	return ret;
+}
+
+void mem_cgroup_priority_select_task(struct oom_control *oc)
+{
+	struct cgroup_subsys_state *chosen = NULL;
+	struct mem_cgroup *memcg, *chosen_memcg, *iter;
+	int chosen_priority = -1;
+	int ret = 0;
+
+	memcg = oc->memcg;
+	if (!memcg)
+		memcg = root_mem_cgroup;
+
+	for_each_mem_cgroup_tree(iter, memcg) {
+		struct cgroup_subsys_state *css = &iter->css;
+		int prio = cgroup_priority(css);
+
+		if (prio < chosen_priority)
+			continue;
+
+		else if (prio > chosen_priority || !chosen) {
+			chosen_priority = prio;
+			chosen_memcg = iter;
+			chosen = css;
+		} else {
+			/* equal priority check memory usage */
+			if (do_memsw_account()) {
+				if (page_counter_read(&iter->memsw) <=
+					page_counter_read(&chosen_memcg->memsw))
+					continue;
+			} else if (page_counter_read(&iter->memory) <=
+				page_counter_read(&chosen_memcg->memory))
+				continue;
+			chosen = css;
+		}
+		ret = mem_cgroup_select_victim(chosen, oc);
+		if (!ret && oc->chosen)
+			chosen_memcg = iter;
+	}
+}
+
+void mem_cgroup_oom_select_bad_process(struct oom_control *oc)
+{
+	struct mem_cgroup *memcg;
+
+	memcg = oc->memcg;
+	if (!memcg)
+		memcg = root_mem_cgroup;
+
+	if (memcg->use_priority_oom)
+		mem_cgroup_priority_select_task(oc);
+	else
+		mem_cgroup_scan_tasks(memcg, oom_evaluate_task, oc);
+}
+
 #ifdef CONFIG_DEBUG_VM
 void lruvec_memcg_debug(struct lruvec *lruvec, struct page *page)
 {
@@ -3544,6 +3609,26 @@ static int mem_cgroup_hierarchy_write(struct cgroup_subsys_state *css,
 	return -EINVAL;
 }
 
+static u64 mem_cgroup_priority_oom_read(struct cgroup_subsys_state *css,
+					struct cftype *cft)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
+
+	return memcg->use_priority_oom;
+}
+
+static int mem_cgroup_priority_oom_write(struct cgroup_subsys_state *css,
+					struct cftype *cft, u64 val)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
+
+	if (val > 1)
+		return -EINVAL;
+
+	memcg->use_priority_oom = val;
+	return 0;
+}
+
 static unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap)
 {
 	unsigned long val;
@@ -4991,6 +5076,11 @@ static struct cftype mem_cgroup_legacy_files[] = {
 		.write_u64 = mem_cgroup_hierarchy_write,
 		.read_u64 = mem_cgroup_hierarchy_read,
 	},
+	{
+		.name = "use_priority_oom",
+		.write_u64 = mem_cgroup_priority_oom_write,
+		.read_u64 = mem_cgroup_priority_oom_read,
+	},
 	{
 		.name = "cgroup.event_control",		/* XXX: for compat */
 		.write = memcg_write_event_control,
@@ -6463,6 +6553,11 @@ static struct cftype memory_files[] = {
 		.seq_show = memory_max_show,
 		.write = memory_max_write,
 	},
+	{
+		.name = "use_priority_oom",
+		.write_u64 = mem_cgroup_priority_oom_write,
+		.read_u64 = mem_cgroup_priority_oom_read,
+	},
 	{
 		.name = "events",
 		.flags = CFTYPE_NOT_ON_ROOT,
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 9efaf430c..d5484f157 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -307,7 +307,7 @@ static enum oom_constraint constrained_alloc(struct oom_control *oc)
 	return CONSTRAINT_NONE;
 }
 
-static int oom_evaluate_task(struct task_struct *task, void *arg)
+int oom_evaluate_task(struct task_struct *task, void *arg)
 {
 	struct oom_control *oc = arg;
 	long points;
@@ -367,8 +367,8 @@ static void select_bad_process(struct oom_control *oc)
 {
 	oc->chosen_points = LONG_MIN;
 
-	if (is_memcg_oom(oc))
-		mem_cgroup_scan_tasks(oc->memcg, oom_evaluate_task, oc);
+	if (is_memcg_oom(oc) || root_memcg_use_priority_oom())
+		mem_cgroup_oom_select_bad_process(oc);
 	else {
 		struct task_struct *p;
 
-- 
2.28.0

