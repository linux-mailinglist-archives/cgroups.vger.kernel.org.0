Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD9E7AB09A
	for <lists+cgroups@lfdr.de>; Fri, 22 Sep 2023 13:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbjIVL3Q (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Sep 2023 07:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233638AbjIVL3P (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Sep 2023 07:29:15 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578FC180;
        Fri, 22 Sep 2023 04:29:09 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6bd0a0a6766so1187299a34.2;
        Fri, 22 Sep 2023 04:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695382148; x=1695986948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DtklZII5h1uoYCXRNe+Jd8s2AyutOaiGxtLZvkF5nNg=;
        b=clBXYtOSYXNPBpTEclQPQQ8+t6XK2x15ADB9Hsb8LeW8sNnP+2YVdHFGADMOuT6HJB
         NXiOG2WQRXMTA388pVk5YJxQdp/3XBIExf5Ycn9KcvdlM+WwBPI9JcsoesenTemAeb7b
         oEl7xz/eBMHtbVOeHLIOdN5MuuUCaIiaI+v+0TVx7z9H3C0Uyz5+163dglxeIxLtnA6r
         Vd0YbH66a/qHa1K/ofpA3fHfe755Ow4a4614XmtTA7Ul6U9Q1mZk5eyya/2NoY9uecjb
         UX55yMvvL4O8IW/sgRTTSh+xl2kJzccSD0G/qgAm2jF2B5eF9ioaLzoxspOgfdZiH4dY
         EO5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695382148; x=1695986948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DtklZII5h1uoYCXRNe+Jd8s2AyutOaiGxtLZvkF5nNg=;
        b=VzgURzcvG7gwdaCmf/kyIh2foBjnWe3x9RP02NLBzSbANxVKXTIYF0pCuWUUL8AnCd
         WX2HVyc5C/a7oYu+sCIBss2zcyD4sIkGDTl23IoH3IzSRRu0xQco0KM/fr530iDLfkbH
         6WeCI0F5vOqHvPq3vzytXzE3ceWNS7Dx4FO3Hh+2IB7ZCJUbpQ3oMPYr6uKVL4B38mtf
         jL4j+WpAFtwWqYpkMnkmJIQ5zvLNj2AOBZJc6vyKUtwYL9v9ByedgQXM8XbZnuqxzTlJ
         iU6jI0javArgfjNV8g3FPeyOGWlU5scEpQ3394P7I1CzZ7pDFzqI4Wh1+UZCdGbR8Xfg
         Wv8Q==
X-Gm-Message-State: AOJu0YxRD8MC6wcow7CQfsyUheWc1vRnjpdS/sFjz1YcxDT+Rg/sF/wK
        r79Z1HVtfTtHx8PWG/fK+r4=
X-Google-Smtp-Source: AGHT+IHJndWMEJEjR9wUNcrfPZmW/KKZIJLe/nfxeG/OgTO8j6z/eoHjsDAvjGMMlNQHRNZ5OI/uTg==
X-Received: by 2002:a05:6358:7247:b0:135:99fa:5040 with SMTP id i7-20020a056358724700b0013599fa5040mr11290945rwa.12.1695382148452;
        Fri, 22 Sep 2023 04:29:08 -0700 (PDT)
Received: from vultr.guest ([149.28.194.201])
        by smtp.gmail.com with ESMTPSA id v16-20020aa78090000000b00690beda6987sm2973493pff.77.2023.09.22.04.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 04:29:05 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, yosryahmed@google.com,
        mkoutny@suse.com
Cc:     cgroups@vger.kernel.org, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 2/8] cgroup: Enable task_under_cgroup_hierarchy() on cgroup1
Date:   Fri, 22 Sep 2023 11:28:40 +0000
Message-Id: <20230922112846.4265-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230922112846.4265-1-laoar.shao@gmail.com>
References: <20230922112846.4265-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

At present, the task_under_cgroup_hierarchy() function serves the purpose
of determining whether a task resides exclusively within a cgroup2
hierarchy. However, considering the ongoing prevalence of cgroup1 and the
substantial effort and time required to migrate all cgroup1-based
applications to the cgroup2 framework, it becomes beneficial to make a
minor adjustment that expands its functionality to encompass cgroup1 as
well. By implementing this modification, we will gain the capability to
easily confirm a task's cgroup membership within BPF programs. For example,
we can effortlessly verify if a task belongs to a cgroup1 directory, such
as '/sys/fs/cgroup/cpu,cpuacct/kubepods/', or
'/sys/fs/cgroup/cpu,cpuacct/system.slice/'.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/cgroup-defs.h     | 20 ++++++++++++++++++++
 include/linux/cgroup.h          | 30 ++++++++++++++++++++++++++----
 kernel/cgroup/cgroup-internal.h | 20 --------------------
 3 files changed, 46 insertions(+), 24 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index f1b3151ac30b..5795825a04ff 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -299,6 +299,26 @@ struct css_set {
 	struct rcu_head rcu_head;
 };
 
+/*
+ * A cgroup can be associated with multiple css_sets as different tasks may
+ * belong to different cgroups on different hierarchies.  In the other
+ * direction, a css_set is naturally associated with multiple cgroups.
+ * This M:N relationship is represented by the following link structure
+ * which exists for each association and allows traversing the associations
+ * from both sides.
+ */
+struct cgrp_cset_link {
+	/* the cgroup and css_set this link associates */
+	struct cgroup		*cgrp;
+	struct css_set		*cset;
+
+	/* list of cgrp_cset_links anchored at cgrp->cset_links */
+	struct list_head	cset_link;
+
+	/* list of cgrp_cset_links anchored at css_set->cgrp_links */
+	struct list_head	cgrp_link;
+};
+
 struct cgroup_base_stat {
 	struct task_cputime cputime;
 
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index b307013b9c6c..e16cfb98b44c 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -387,8 +387,8 @@ static inline void cgroup_unlock(void)
  * The caller can also specify additional allowed conditions via @__c, such
  * as locks used during the cgroup_subsys::attach() methods.
  */
-#ifdef CONFIG_PROVE_RCU
 extern spinlock_t css_set_lock;
+#ifdef CONFIG_PROVE_RCU
 #define task_css_set_check(task, __c)					\
 	rcu_dereference_check((task)->cgroups,				\
 		rcu_read_lock_sched_held() ||				\
@@ -543,15 +543,37 @@ static inline struct cgroup *cgroup_ancestor(struct cgroup *cgrp,
  * @ancestor: possible ancestor of @task's cgroup
  *
  * Tests whether @task's default cgroup hierarchy is a descendant of @ancestor.
- * It follows all the same rules as cgroup_is_descendant, and only applies
- * to the default hierarchy.
+ * It follows all the same rules as cgroup_is_descendant.
  */
 static inline bool task_under_cgroup_hierarchy(struct task_struct *task,
 					       struct cgroup *ancestor)
 {
 	struct css_set *cset = task_css_set(task);
+	struct cgrp_cset_link *link;
+	struct cgroup *cgrp = NULL;
+	bool ret = false;
+
+	if (ancestor->root == &cgrp_dfl_root)
+		return cgroup_is_descendant(cset->dfl_cgrp, ancestor);
+
+	if (cset == &init_css_set)
+		return ancestor == &ancestor->root->cgrp;
+
+	spin_lock_irq(&css_set_lock);
+	list_for_each_entry(link, &cset->cgrp_links, cgrp_link) {
+		struct cgroup *c = link->cgrp;
+
+		if (c->root == ancestor->root) {
+			cgrp = c;
+			break;
+		}
+	}
+	spin_unlock_irq(&css_set_lock);
 
-	return cgroup_is_descendant(cset->dfl_cgrp, ancestor);
+	WARN_ON_ONCE(!cgrp);
+	if (cgroup_is_descendant(cgrp, ancestor))
+		ret = true;
+	return ret;
 }
 
 /* no synchronization, the result can only be used as a hint */
diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index c56071f150f2..620c60c9daa3 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -83,26 +83,6 @@ struct cgroup_file_ctx {
 	} procs1;
 };
 
-/*
- * A cgroup can be associated with multiple css_sets as different tasks may
- * belong to different cgroups on different hierarchies.  In the other
- * direction, a css_set is naturally associated with multiple cgroups.
- * This M:N relationship is represented by the following link structure
- * which exists for each association and allows traversing the associations
- * from both sides.
- */
-struct cgrp_cset_link {
-	/* the cgroup and css_set this link associates */
-	struct cgroup		*cgrp;
-	struct css_set		*cset;
-
-	/* list of cgrp_cset_links anchored at cgrp->cset_links */
-	struct list_head	cset_link;
-
-	/* list of cgrp_cset_links anchored at css_set->cgrp_links */
-	struct list_head	cgrp_link;
-};
-
 /* used to track tasks and csets during migration */
 struct cgroup_taskset {
 	/* the src and dst cset list running through cset->mg_node */
-- 
2.30.1 (Apple Git-130)

