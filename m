Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D21599AF2
	for <lists+cgroups@lfdr.de>; Fri, 19 Aug 2022 13:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348551AbiHSL3i (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 19 Aug 2022 07:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348356AbiHSL3h (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 19 Aug 2022 07:29:37 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337FC12AFF
        for <cgroups@vger.kernel.org>; Fri, 19 Aug 2022 04:29:35 -0700 (PDT)
Received: from SHSend.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id 27JBTQbI043766
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO);
        Fri, 19 Aug 2022 19:29:26 +0800 (CST)
        (envelope-from zhaoyang.huang@unisoc.com)
Received: from bj03382pcu.spreadtrum.com (10.0.74.65) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Fri, 19 Aug 2022 19:29:27 +0800
From:   "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <ke.wang@unisoc.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH] memcg: use root_mem_cgroup when css is inherited
Date:   Fri, 19 Aug 2022 19:29:22 +0800
Message-ID: <1660908562-17409-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.74.65]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 27JBTQbI043766
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

It is observed in android system where per-app cgroup is demanded by freezer
subsys and part of groups require memory control. The hierarchy could be simplized
as bellowing where memory charged on group B abserved while we only want have
group E's memory be controlled and B's descendants compete freely for memory.
This should be the consequences of unified hierarchy.
Under this scenario, less efficient memory reclaim is observed when comparing
with no memory control. It is believed that multi LRU scanning introduces some
of the overhead. Furthermore, page thrashing is also heavier than global LRU
which could be the consequences of partial failure of WORKINGSET mechanism as
LRU is too short to protect the active pages.

A(subtree_control = memory) - B(subtree_control = NULL) - C()
							\ D()
			    - E(subtree_control = memory) - F()
							  \ G()

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 include/linux/cgroup.h |  1 +
 kernel/cgroup/cgroup.c | 11 +++++++++++
 mm/memcontrol.c        |  5 ++++-
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 0d1ada8..747f0f4 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -136,6 +136,7 @@ extern void cgroup_post_fork(struct task_struct *p,
 
 int cgroup_parse_float(const char *input, unsigned dec_shift, s64 *v);
 
+struct cgroup *get_task_cgroup(struct task_struct *task);
 /*
  * Iteration helpers and macros.
  */
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 1779ccd..3f34c58 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1457,6 +1457,17 @@ struct cgroup *task_cgroup_from_root(struct task_struct *task,
 	return cset_cgroup_from_root(task_css_set(task), root);
 }
 
+struct cgroup *get_task_cgroup(struct task_struct *task)
+{
+	struct cgroup *src_cgrp;
+	/* find the source cgroup */
+	spin_lock_irq(&css_set_lock);
+	src_cgrp = task_cgroup_from_root(task, &cgrp_dfl_root);
+	spin_unlock_irq(&css_set_lock);
+
+	return src_cgrp;
+}
+
 /*
  * A task must hold cgroup_mutex to modify cgroups.
  *
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index abec50f..c81012b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -930,6 +930,7 @@ static __always_inline struct mem_cgroup *active_memcg(void)
 struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
 {
 	struct mem_cgroup *memcg;
+	struct cgroup *cgrp;
 
 	if (mem_cgroup_disabled())
 		return NULL;
@@ -956,9 +957,11 @@ struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
 	}
 
 	rcu_read_lock();
+	cgrp = get_task_cgroup(rcu_dereference(mm->owner));
 	do {
 		memcg = mem_cgroup_from_task(rcu_dereference(mm->owner));
-		if (unlikely(!memcg))
+		if (unlikely(!memcg)
+			|| !(cgroup_ss_mask(cgrp) & (1 << memory_cgrp_id)))
 			memcg = root_mem_cgroup;
 	} while (!css_tryget(&memcg->css));
 	rcu_read_unlock();
-- 
1.9.1

