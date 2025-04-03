Return-Path: <cgroups+bounces-7313-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D94A79B40
	for <lists+cgroups@lfdr.de>; Thu,  3 Apr 2025 07:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DF477A2237
	for <lists+cgroups@lfdr.de>; Thu,  3 Apr 2025 05:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26DF19CD1B;
	Thu,  3 Apr 2025 05:27:46 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D59619C574;
	Thu,  3 Apr 2025 05:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743658066; cv=none; b=M9y8HergMIVmRaYMKqK8XtXfHeuleGj3c9K4EKy4wgQdA7SU9IbasKqzLgBRi4RRzC9+ytyPHb1+71bDb1gC8Q6jRfdLulllRiNtF6bAWoVSQcSjpyZdgoaDNO+2GNn5c+qdhe51Nw6aiN1PviDgfsJV+Q7Vik6I2gNixhWiyBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743658066; c=relaxed/simple;
	bh=3n7/O/hI64y0dcXn/LxVhsp8wYm7Enb+Q+8pWQDRVE0=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=gQqAuSYbKi7z47wqzmwSz6DXhtubmqTlyqevmXndQFC8iu9aKPVy0TFl8AtRiUzuLKxpYd0EeL5VP6WXiZ8eAPxa/v9VxOs1snz2vZS5+f9QIgMB3VC0jXRi2iUdxo+KZmJmm3wCl5UAfTNOSHdrn72pFCG1py+PgjZt1JTYkcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4ZSqxX6HLHz51SYK;
	Thu,  3 Apr 2025 13:27:28 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 5335RNj9042170;
	Thu, 3 Apr 2025 13:27:23 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 3 Apr 2025 13:27:25 +0800 (CST)
Date: Thu, 3 Apr 2025 13:27:25 +0800 (CST)
X-Zmail-TransId: 2afb67ee1c3d005-634bb
X-Mailer: Zmail v1.0
Message-ID: <202504031327254709KjF9LmE5S0XFQdI6rxlu@zte.com.cn>
In-Reply-To: <20250403132534636XLwK7CWiCj1J4-FENz0vk@zte.com.cn>
References: 20250403132534636XLwK7CWiCj1J4-FENz0vk@zte.com.cn
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <xu.xin16@zte.com.cn>
Cc: <akpm@linux-foundation.org>, <mhocko@kernel.org>, <hannes@cmpxchg.org>,
        <roman.gushchin@linux.dev>, <muchun.song@linux.dev>,
        <shakeel.butt@linux.dev>, <cgroups@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <yang.yang29@zte.com.cn>, <chen.haonan2@zte.com.cn>,
        <wang.yaxin@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHQgMS82XSBtZW1jb250cm9sOiByZW5hbWUgbWVtX2Nncm91cF9zY2FuX3Rhc2tzKCnCoMKg?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 5335RNj9042170
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67EE1C40.009/4ZSqxX6HLHz51SYK

From: xu xin <xu.xin16@zte.com.cn>

Current Issue:
==============
The function mem_cgroup_scan_tasks in memcontrol.c has a naming ambiguity.
While its name suggests it only iterates through processes belonging to
the current memcgroup, it actually scans all descendant cgroups under the
subtree rooted at this memcgroup. This discrepancy can cause confusion
for developers relying on the semantic meaning of the function name.

Resolution:
=========
Renaming: We have renamed the original function to
**mem_cgroup_tree_scan_tasks** to explicitly reflect its subtree-traversal
behavior.

A subsequent patch will introduce a new mem_cgroup_scan_tasks function that
strictly iterates processes only within the current memcgroup, aligning its
behavior with its name.

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 include/linux/memcontrol.h | 4 ++--
 mm/memcontrol.c            | 4 ++--
 mm/oom_kill.c              | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 53364526d877..232cea80e71f 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -795,7 +795,7 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *,
 				   struct mem_cgroup *,
 				   struct mem_cgroup_reclaim_cookie *);
 void mem_cgroup_iter_break(struct mem_cgroup *, struct mem_cgroup *);
-void mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
+void mem_cgroup_tree_scan_tasks(struct mem_cgroup *memcg,
 			   int (*)(struct task_struct *, void *), void *arg);

 static inline unsigned short mem_cgroup_id(struct mem_cgroup *memcg)
@@ -1289,7 +1289,7 @@ static inline void mem_cgroup_iter_break(struct mem_cgroup *root,
 {
 }

-static inline void mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
+static inline void mem_cgroup_tree_scan_tasks(struct mem_cgroup *memcg,
 		int (*fn)(struct task_struct *, void *), void *arg)
 {
 }
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 421740f1bcdc..9af30fbfe819 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1151,7 +1151,7 @@ static void invalidate_reclaim_iterators(struct mem_cgroup *dead_memcg)
 }

 /**
- * mem_cgroup_scan_tasks - iterate over tasks of a memory cgroup hierarchy
+ * mem_cgroup_tree_scan_tasks - iterate over tasks of a memory cgroup hierarchy
  * @memcg: hierarchy root
  * @fn: function to call for each task
  * @arg: argument passed to @fn
@@ -1163,7 +1163,7 @@ static void invalidate_reclaim_iterators(struct mem_cgroup *dead_memcg)
  *
  * This function must not be called for the root memory cgroup.
  */
-void mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
+void mem_cgroup_tree_scan_tasks(struct mem_cgroup *memcg,
 			   int (*fn)(struct task_struct *, void *), void *arg)
 {
 	struct mem_cgroup *iter;
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 25923cfec9c6..af3b8407fb08 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -367,7 +367,7 @@ static void select_bad_process(struct oom_control *oc)
 	oc->chosen_points = LONG_MIN;

 	if (is_memcg_oom(oc))
-		mem_cgroup_scan_tasks(oc->memcg, oom_evaluate_task, oc);
+		mem_cgroup_tree_scan_tasks(oc->memcg, oom_evaluate_task, oc);
 	else {
 		struct task_struct *p;

@@ -428,7 +428,7 @@ static void dump_tasks(struct oom_control *oc)
 	pr_info("[  pid  ]   uid  tgid total_vm      rss rss_anon rss_file rss_shmem pgtables_bytes swapents oom_score_adj name\n");

 	if (is_memcg_oom(oc))
-		mem_cgroup_scan_tasks(oc->memcg, dump_task, oc);
+		mem_cgroup_tree_scan_tasks(oc->memcg, dump_task, oc);
 	else {
 		struct task_struct *p;
 		int i = 0;
@@ -1056,7 +1056,7 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
 	if (oom_group) {
 		memcg_memory_event(oom_group, MEMCG_OOM_GROUP_KILL);
 		mem_cgroup_print_oom_group(oom_group);
-		mem_cgroup_scan_tasks(oom_group, oom_kill_memcg_member,
+		mem_cgroup_tree_scan_tasks(oom_group, oom_kill_memcg_member,
 				      (void *)message);
 		mem_cgroup_put(oom_group);
 	}
-- 
2.15.2

