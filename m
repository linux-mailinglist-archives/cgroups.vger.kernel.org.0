Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72AA77BC834
	for <lists+cgroups@lfdr.de>; Sat,  7 Oct 2023 16:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343974AbjJGODU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 7 Oct 2023 10:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343934AbjJGODU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 7 Oct 2023 10:03:20 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013E9BF;
        Sat,  7 Oct 2023 07:03:18 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c88b46710bso15851165ad.1;
        Sat, 07 Oct 2023 07:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696687398; x=1697292198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MkiSkPJNlBcvA6l1NV7Ut81Ds5KMxgHRuVtA5iQDQsI=;
        b=cs8JY3EimbuWuvf4U8SkPXEl7a/GolsviKZrx2EpFy4Uo2ktVZ+r3z6x21t+1Wlq+v
         SQhJA2TPyKzab+nf2D7nmE9hWpfgYEEy+iLLmMNDLOKGFwI6trR8OWtfiNMV5Ehw9GhH
         gq8cK+vAtBZFZawwCkDL66kcQqQsXhlLHBC40v6pI8ELjZEyVOdvYh6GS+fPs+3gFRgx
         i2ahi04fSVXk8ICbVa9MLp3PDrndfiF2Sk2NN9JapvgBu8eLRmkDUOXhBC92sDZcjCCr
         XWjnb5iGoDAOM+S8T0IBEwobNj1eGNyOSxJTz5dp3G4MXzAW0kHXFWY0mh0HtQIvKZ5b
         4AOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696687398; x=1697292198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MkiSkPJNlBcvA6l1NV7Ut81Ds5KMxgHRuVtA5iQDQsI=;
        b=EbNAE2HZ2oVekCcUjWrAQGm2Z8lfWsZRdEAIIz7Q5VCCesWmC9xzQTSfQYK4dqKm3q
         FeyckhYAnOLf98GYfNKLT92z8o6HxaTYFnjhUPQfetIVmJ5dzivPtOjz7jLZtYYhrBiM
         1X1o6kbMP399JmthsERttD5GwHd7U+D5RYwQ00pMINkgJl3B0c+7m2AE07tQhXol+X5P
         wxSJspvAuI11dg7rJsgnjfAVuylrM+RTPkeaGCOrOuxzU3se8QWC1fHarYsOdjxr0p/f
         XJXXwDxAvAPehOKIw8JnlSIHITLQJy+qH287tbRs7g5tV7RurrYbdwpH+OmRg9Dj7TeJ
         BPAg==
X-Gm-Message-State: AOJu0YxETiB4tvWGN7fP3wVTVyJinFGpOpscVtecOOJv86NmBlk/Dt4m
        /kCeWTyD6ScD3AeDpYzCINg=
X-Google-Smtp-Source: AGHT+IFp1QBFglX6sgNBthLjSggy2Qb0y5OJgEH+4nXhgW0J6vvd+IMzpex1q4E2TiCX2lYtihQZHA==
X-Received: by 2002:a17:903:41c1:b0:1c6:30d1:7214 with SMTP id u1-20020a17090341c100b001c630d17214mr11696784ple.55.1696687398305;
        Sat, 07 Oct 2023 07:03:18 -0700 (PDT)
Received: from vultr.guest ([45.77.191.53])
        by smtp.gmail.com with ESMTPSA id l13-20020a170902f68d00b001c0a414695dsm5897550plg.62.2023.10.07.07.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 07:03:17 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, yosryahmed@google.com,
        mkoutny@suse.com, sinquersw@gmail.com
Cc:     cgroups@vger.kernel.org, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 2/8] cgroup: Add new helpers for cgroup1 hierarchy
Date:   Sat,  7 Oct 2023 14:02:58 +0000
Message-Id: <20231007140304.4390-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231007140304.4390-1-laoar.shao@gmail.com>
References: <20231007140304.4390-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Two new helpers are added for cgroup1 hierarchy:

- task_cgroup1_id_within_hierarchy
  Retrieves the associated cgroup ID of a task within a specific cgroup1
  hierarchy. The cgroup1 hierarchy is identified by its hierarchy ID.
- task_ancestor_cgroup1_id_within_hierarchy
  Retrieves the associated ancestor cgroup ID of a task whithin a
  specific cgroup1 hierarchy. The specific ancestor level is determined by
  its ancestor level.

These helper functions have been added to facilitate the tracing of tasks
within a particular container or cgroup in BPF programs. It's important to
note that these helpers are designed specifically for cgroup1.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/cgroup.h          |  9 ++++-
 kernel/cgroup/cgroup-internal.h |  2 -
 kernel/cgroup/cgroup-v1.c       | 67 +++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+), 3 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index b307013b9c6c..65bde6eb41ef 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -71,6 +71,8 @@ struct css_task_iter {
 extern struct file_system_type cgroup_fs_type;
 extern struct cgroup_root cgrp_dfl_root;
 extern struct css_set init_css_set;
+extern struct list_head cgroup_roots;
+extern spinlock_t css_set_lock;
 
 #define SUBSYS(_x) extern struct cgroup_subsys _x ## _cgrp_subsys;
 #include <linux/cgroup_subsys.h>
@@ -159,6 +161,8 @@ void css_task_iter_start(struct cgroup_subsys_state *css, unsigned int flags,
 			 struct css_task_iter *it);
 struct task_struct *css_task_iter_next(struct css_task_iter *it);
 void css_task_iter_end(struct css_task_iter *it);
+struct cgroup *task_cgroup_from_root(struct task_struct *task,
+				     struct cgroup_root *root);
 
 /**
  * css_for_each_child - iterate through children of a css
@@ -388,7 +392,6 @@ static inline void cgroup_unlock(void)
  * as locks used during the cgroup_subsys::attach() methods.
  */
 #ifdef CONFIG_PROVE_RCU
-extern spinlock_t css_set_lock;
 #define task_css_set_check(task, __c)					\
 	rcu_dereference_check((task)->cgroups,				\
 		rcu_read_lock_sched_held() ||				\
@@ -855,4 +858,8 @@ static inline void cgroup_bpf_put(struct cgroup *cgrp) {}
 
 #endif /* CONFIG_CGROUP_BPF */
 
+u64 task_cgroup1_id_within_hierarchy(struct task_struct *tsk, int hierarchy_id);
+u64 task_ancestor_cgroup1_id_within_hierarchy(struct task_struct *tsk, int hierarchy_id,
+					      int ancestor_level);
+
 #endif /* _LINUX_CGROUP_H */
diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index c56071f150f2..2c32a80c1334 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -164,9 +164,7 @@ struct cgroup_mgctx {
 #define DEFINE_CGROUP_MGCTX(name)						\
 	struct cgroup_mgctx name = CGROUP_MGCTX_INIT(name)
 
-extern spinlock_t css_set_lock;
 extern struct cgroup_subsys *cgroup_subsys[];
-extern struct list_head cgroup_roots;
 
 /* iterate across the hierarchies */
 #define for_each_root(root)						\
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index c487ffef6652..18064de0a883 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -1263,6 +1263,73 @@ int cgroup1_get_tree(struct fs_context *fc)
 	return ret;
 }
 
+/**
+ * task_cgroup_id_within_hierarchy - Retrieves the associated cgroup ID from
+ * a task within a specific cgroup1 hierarchy.
+ * @task: The task to be tested
+ * @hierarchy_id: The hierarchy ID of a cgroup1
+ *
+ * We limit it to cgroup1 only.
+ */
+u64 task_cgroup1_id_within_hierarchy(struct task_struct *tsk, int hierarchy_id)
+{
+	struct cgroup_root *root;
+	struct cgroup *cgrp;
+	u64 cgid = 0;
+
+	spin_lock_irq(&css_set_lock);
+	list_for_each_entry(root, &cgroup_roots, root_list) {
+		/* cgroup1 only*/
+		if (root == &cgrp_dfl_root)
+			continue;
+		if (root->hierarchy_id != hierarchy_id)
+			continue;
+		cgrp = task_cgroup_from_root(tsk, root);
+		WARN_ON_ONCE(!cgrp);
+		cgid = cgroup_id(cgrp);
+		break;
+	}
+	spin_unlock_irq(&css_set_lock);
+	return cgid;
+}
+
+/**
+ * task_ancestor_cgroup_id_within_hierarchy - Retrieves the associated ancestor
+ * cgroup ID from a task within a specific cgroup1 hierarchy.
+ * @task: The task to be tested
+ * @hierarchy_id: The hierarchy ID of a cgroup1
+ * @ancestor_level: level of ancestor to find starting from root
+ *
+ * We limit it to cgroup1 only.
+ */
+u64 task_ancestor_cgroup1_id_within_hierarchy(struct task_struct *tsk, int hierarchy_id,
+					      int ancestor_level)
+{
+	struct cgroup *cgrp, *ancestor;
+	struct cgroup_root *root;
+	u64 cgid = 0;
+
+	spin_lock_irq(&css_set_lock);
+	list_for_each_entry(root, &cgroup_roots, root_list) {
+		/* cgroup1 only*/
+		if (root == &cgrp_dfl_root)
+			continue;
+		if (root->hierarchy_id != hierarchy_id)
+			continue;
+
+		cgrp = task_cgroup_from_root(tsk, root);
+		WARN_ON_ONCE(!cgrp);
+		ancestor = cgroup_ancestor(cgrp, ancestor_level);
+		if (!ancestor)
+			break;
+
+		cgid = cgroup_id(ancestor);
+		break;
+	}
+	spin_unlock_irq(&css_set_lock);
+	return cgid;
+}
+
 static int __init cgroup1_wq_init(void)
 {
 	/*
-- 
2.30.1 (Apple Git-130)

