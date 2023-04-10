Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE1E6DC2CE
	for <lists+cgroups@lfdr.de>; Mon, 10 Apr 2023 04:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjDJCvc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 9 Apr 2023 22:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjDJCvb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 9 Apr 2023 22:51:31 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA6130F9
        for <cgroups@vger.kernel.org>; Sun,  9 Apr 2023 19:51:04 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id c10-20020a17090abf0a00b0023d1bbd9f9eso6190886pjs.0
        for <cgroups@vger.kernel.org>; Sun, 09 Apr 2023 19:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1681095064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rJOefRQrozTqAzaaP0k/ueE5wQvUaa1yyg3cUW9q0RM=;
        b=JOtB5P+MButyoMf9OTRe1POvR1FUCeEkPzDMZv8Bf65mSDeY3ESN4yjsOLA9st3qAm
         gYuvCr+rS8xZMdOSRNr+GQiBa95YINrW/NhmzXZEaYVvfvgUypoGq2TxvcpODn7tXZm1
         88riwOcwh8sXn9EAAiAyjSqpkMvYmbzM8vHEcIb4T9o3IuYX5BYw5DICpMXbolHP6rGi
         78Ux6vpGXbjJ7OHnMmCz7XwApLtcLuHnJ1RVGVWtH7Yw1rD49Pm8v4cn74JVV49M9Zde
         K0QxZfdvJ5ZB6P21qLX9CaZ5CVljB8y33KUQrPL8DMN+OrDzqAXM5j/RrvwNYvB8BamF
         Jcxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681095064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rJOefRQrozTqAzaaP0k/ueE5wQvUaa1yyg3cUW9q0RM=;
        b=UDhsR/QM1VzAYP5rWJB84vGFnEz2sldFCewC2EBS7fvun7zV8kWh6EbtJK+GXCx0Aw
         LLj18rXKvGib23GmvRg/wBnfJM6nXDcpXHFxURKQmMxrbltMYSQGKc88THgZYySLIfTo
         IV7h/CPK88ZMQ5HNdMuvRskLbubSFvjQmbKBZAPxKludI4v7i+qnflFMeytO1knhHiZ+
         o0JGryOyAfCa1BQhsmaZiimiHQQHMNMiCxgoDXhkFp35ZCZ1MIlS4wFrbianCpC7O+Mp
         3xKVNNytsdRx3SjAgv8U1Yv0A2ZoM9Q6vpyq52vvyJ6RcrlhjWWN/ZcU+YTNXLBEuRF2
         Td1g==
X-Gm-Message-State: AAQBX9eUlap9r3efTjFwsdOE2pN4Qbb2mrSkKi3+FtGv9I4UY3vl0p70
        H6+mJbBlwfmORncY4BB7Blio5A==
X-Google-Smtp-Source: AKy350Yf2yL+hcn31obOfvgDB7o8eZAIg8yZihoYaCUkEzKXDRgpjBnJf850MT7CeXE2kvA0SURqjw==
X-Received: by 2002:a17:902:e88c:b0:19f:35df:5d60 with SMTP id w12-20020a170902e88c00b0019f35df5d60mr12188126plg.22.1681095064232;
        Sun, 09 Apr 2023 19:51:04 -0700 (PDT)
Received: from C02FT5A6MD6R.bytedance.net ([139.177.225.224])
        by smtp.gmail.com with ESMTPSA id jh19-20020a170903329300b00199193e5ea1sm6544674plb.61.2023.04.09.19.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Apr 2023 19:51:03 -0700 (PDT)
From:   Gang Li <ligang.bdlg@bytedance.com>
To:     Waiman Long <longman@redhat.com>, Michal Hocko <mhocko@suse.com>
Cc:     Gang Li <ligang.bdlg@bytedance.com>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, rientjes@google.com,
        Zefan Li <lizefan.x@bytedance.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] mm: oom: introduce cpuset oom
Date:   Mon, 10 Apr 2023 10:50:55 +0800
Message-Id: <20230410025056.22103-1-ligang.bdlg@bytedance.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Cpusets constrain the CPU and Memory placement of tasks.
`CONSTRAINT_CPUSET` type in oom  has existed for a long time, but
has never been utilized.

When a process in cpuset which constrain memory placement triggers
oom, it may kill a completely irrelevant process on other numa nodes,
which will not release any memory for this cpuset.

We can easily achieve node aware oom by using `CONSTRAINT_CPUSET` and
selecting victim from all cpusets with the same mems_allowed as the
current cpuset.

Example:

Create two processes named mem_on_node0 and mem_on_node1 constrained
by cpusets respectively. These two processes alloc memory on their
own node. Now node0 has run out of memory, OOM will be invokled by
mem_on_node0.

Before this patch:

Since `CONSTRAINT_CPUSET` do nothing, the victim will be selected from
the entire system. Therefore, the OOM is highly likely to kill
mem_on_node1, which will not free any memory for mem_on_node0. This
is a useless kill.

```
[ 2786.519080] mem_on_node0 invoked oom-killer
[ 2786.885738] [  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name
[ 2787.181724] [  13432]     0 13432   787016   786745  6344704        0             0 mem_on_node1
[ 2787.189115] [  13457]     0 13457   787002   785504  6340608        0             0 mem_on_node0
[ 2787.216534] oom-kill:constraint=CONSTRAINT_CPUSET,nodemask=(null),cpuset=test,mems_allowed=0
[ 2787.229991] Out of memory: Killed process 13432 (mem_on_node1)
```

After this patch:

The victim will be selected only in all cpusets that have the same
mems_allowed as the cpuset that invoked oom. This will prevent
useless kill and protect innocent victims.

```
[  395.922444] mem_on_node0 invoked oom-killer
[  396.239777] [  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name
[  396.246128] [   2614]     0  2614  1311294  1144192  9224192        0             0 mem_on_node0
[  396.252655] oom-kill:constraint=CONSTRAINT_CPUSET,nodemask=(null),cpuset=test,mems_allowed=0
[  396.264068] Out of memory: Killed process 2614 (mem_on_node0)
```

Suggested-by: Michal Hocko <mhocko@suse.com>
Cc: <cgroups@vger.kernel.org>
Cc: <linux-mm@kvack.org>
Cc: <rientjes@google.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Zefan Li <lizefan.x@bytedance.com>
Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
---
Changes in v3:
- Provide more details about the use case, testing, implementation.
- Document the userspace visible change in Documentation.
- Rename cpuset_cgroup_scan_tasks() to cpuset_scan_tasks() and add
  a doctext comment about its purpose and how it should be used.
- Take cpuset_rwsem to ensure that cpusets are stable.

Changes in v2:
- https://lore.kernel.org/all/20230404115509.14299-1-ligang.bdlg@bytedance.com/
- Select victim from all cpusets with the same mems_allowed as the current cpuset.
  (David Rientjes <rientjes@google.com>)

v1:
- https://lore.kernel.org/all/20220921064710.89663-1-ligang.bdlg@bytedance.com/
- Introduce cpuset oom.
---
 .../admin-guide/cgroup-v1/cpusets.rst         | 14 +++++-
 include/linux/cpuset.h                        |  6 +++
 kernel/cgroup/cpuset.c                        | 44 +++++++++++++++++++
 mm/oom_kill.c                                 |  4 ++
 4 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/cpusets.rst b/Documentation/admin-guide/cgroup-v1/cpusets.rst
index 5d844ed4df69..d686cd47e91d 100644
--- a/Documentation/admin-guide/cgroup-v1/cpusets.rst
+++ b/Documentation/admin-guide/cgroup-v1/cpusets.rst
@@ -25,7 +25,8 @@ Written by Simon.Derr@bull.net
      1.6 What is memory spread ?
      1.7 What is sched_load_balance ?
      1.8 What is sched_relax_domain_level ?
-     1.9 How do I use cpusets ?
+     1.9 What is cpuset oom ?
+     1.10 How do I use cpusets ?
    2. Usage Examples and Syntax
      2.1 Basic Usage
      2.2 Adding/removing cpus
@@ -607,8 +608,17 @@ If your situation is:
  - The latency is required even it sacrifices cache hit rate etc.
    then increasing 'sched_relax_domain_level' would benefit you.
 
+1.9 What is cpuset oom ?
+--------------------------
+If there is no available memory to allocate on the nodes specified by
+cpuset.mems, then an OOM (Out-Of-Memory) will be invoked.
+
+Since the victim selection is a heuristic algorithm, we cannot select
+the "perfect" victim. Therefore, currently, the victim will be selected
+from all the cpusets that have the same mems_allowed as the cpuset
+which invoked OOM.
 
-1.9 How do I use cpusets ?
+1.10 How do I use cpusets ?
 --------------------------
 
 In order to minimize the impact of cpusets on critical kernel
diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 980b76a1237e..75465bf58f74 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -171,6 +171,8 @@ static inline void set_mems_allowed(nodemask_t nodemask)
 	task_unlock(current);
 }
 
+int cpuset_scan_tasks(int (*fn)(struct task_struct *, void *), void *arg);
+
 #else /* !CONFIG_CPUSETS */
 
 static inline bool cpusets_enabled(void) { return false; }
@@ -287,6 +289,10 @@ static inline bool read_mems_allowed_retry(unsigned int seq)
 	return false;
 }
 
+static inline int cpuset_scan_tasks(int (*fn)(struct task_struct *, void *), void *arg)
+{
+	return 0;
+}
 #endif /* !CONFIG_CPUSETS */
 
 #endif /* _LINUX_CPUSET_H */
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index bc4dcfd7bee5..4c51225568aa 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -4013,6 +4013,50 @@ void cpuset_print_current_mems_allowed(void)
 	rcu_read_unlock();
 }
 
+/**
+ * cpuset_scan_tasks - specify the oom scan range
+ * @fn: callback function to select oom victim
+ * @arg: argument for callback function, usually a pointer to struct oom_control
+ *
+ * Description: This function is used to specify the oom scan range. Return 0 if
+ * no task is selected, otherwise return 1. The selected task will be stored in
+ * arg->chosen. Thins function can only be called in select_bad_process()
+ * while oc->onstraint == CONSTRAINT_CPUSET.
+ *
+ * The selection algorithm is heuristic, therefore requires constant iteration
+ * based on user feedback. Currently, we just iterate through all cpusets with
+ * the same mems_allowed as the current cpuset.
+ */
+int cpuset_scan_tasks(int (*fn)(struct task_struct *, void *), void *arg)
+{
+	int ret = 0;
+	struct css_task_iter it;
+	struct task_struct *task;
+	struct cpuset *cs;
+	struct cgroup_subsys_state *pos_css;
+
+	/*
+	 * Situation gets complex with overlapping nodemasks in different cpusets.
+	 * TODO: Maybe we should calculate the "distance" between different mems_allowed.
+	 *
+	 * But for now, let's make it simple. Just iterate through all cpusets
+	 * with the same mems_allowed as the current cpuset.
+	 */
+	cpuset_read_lock();
+	rcu_read_lock();
+	cpuset_for_each_descendant_pre(cs, pos_css, &top_cpuset) {
+		if (nodes_equal(cs->mems_allowed, task_cs(current)->mems_allowed)) {
+			css_task_iter_start(&(cs->css), CSS_TASK_ITER_PROCS, &it);
+			while (!ret && (task = css_task_iter_next(&it)))
+				ret = fn(task, arg);
+			css_task_iter_end(&it);
+		}
+	}
+	rcu_read_unlock();
+	cpuset_read_unlock();
+	return ret;
+}
+
 /*
  * Collection of memory_pressure is suppressed unless
  * this flag is enabled by writing "1" to the special
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 044e1eed720e..228257788d9e 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -367,6 +367,8 @@ static void select_bad_process(struct oom_control *oc)
 
 	if (is_memcg_oom(oc))
 		mem_cgroup_scan_tasks(oc->memcg, oom_evaluate_task, oc);
+	else if (oc->constraint == CONSTRAINT_CPUSET)
+		cpuset_scan_tasks(oom_evaluate_task, oc);
 	else {
 		struct task_struct *p;
 
@@ -427,6 +429,8 @@ static void dump_tasks(struct oom_control *oc)
 
 	if (is_memcg_oom(oc))
 		mem_cgroup_scan_tasks(oc->memcg, dump_task, oc);
+	else if (oc->constraint == CONSTRAINT_CPUSET)
+		cpuset_scan_tasks(dump_task, oc);
 	else {
 		struct task_struct *p;
 
-- 
2.20.1
