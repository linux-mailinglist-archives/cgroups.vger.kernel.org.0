Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F88353881
	for <lists+cgroups@lfdr.de>; Sun,  4 Apr 2021 16:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbhDDOw1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 4 Apr 2021 10:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbhDDOw1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 4 Apr 2021 10:52:27 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942F0C061756
        for <cgroups@vger.kernel.org>; Sun,  4 Apr 2021 07:52:22 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id v10so6670682pfn.5
        for <cgroups@vger.kernel.org>; Sun, 04 Apr 2021 07:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ROIbdx9NEaHy04j2uTdjxQYFMD03Fs+kDBrN45oSLkE=;
        b=pber5eyHPYVGXZoMnj9kwxnIv0bUKffhYZQKY6Dj/uKitLpkJayms8VsrU/tx+sr6d
         Llzuj70uwIh6T2wQEPS42hXvN5UMb3nKcQWhqSknzVMraYRnLDDVzPnrU/dKnsEwOxlU
         n+ZtqnRSE7ju+j7XHml8Yn+4nkvXgjpP+hSBQhVYxhmHuu5oUCtAps6yxgGGEoqtBmRO
         jGniecanskartv32GXSrAnHNLyaCBhXPEr3k6I/RJOqAFEmaHpTFbGQaIJLMNNOuVFFE
         6MeRrffNDM1Cy9akCpQf0E0q5bq0EBX0UNRiNESUUJuBr2widck+yLQClhXTStlkIQUQ
         rFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ROIbdx9NEaHy04j2uTdjxQYFMD03Fs+kDBrN45oSLkE=;
        b=Stop51U7pMQexh40DVPbcq0fm2A1+w+xPr5m1RZajnrcuBSw9IvEL0W0/anGSpbWLk
         eSOJU4E7OEEOQr6DW56peDYUAIYu5UuA2a2jfZqYD4LXOW8q3H3Ixqw88l9/uQj1U6sH
         kTFWNchgh5uG27o1R/kiA+IHZSGCY9B71wDQLgqHmdDHVs63tPvWYt0YffgT7YS2lfdX
         KIhnrh5jLGGSVQxoFI+8hooP6cQ7xwWsLtPkoE8f+zWF0qkBmMCXxUQCQ3brcX8Stj4w
         o8BLDfUUrNg+R+tCoWNeYngCDfHwy1jJAoklX/Ck/kBMO3+nhrw9bqhLgx2vuDr83We9
         F97w==
X-Gm-Message-State: AOAM530cV95y+YdddLRV/8qmdSGTztZeE+c5pDCM+dbC717jlkSyA1ep
        /Xci7efMgPLv/G47DXGB16s=
X-Google-Smtp-Source: ABdhPJxahEh8PHgnydq1m5FxhFng9UH9q9oJ4pWF6ZYv0fXUyN8phnwHv3vZzeJMRcMx9LTioxcLZg==
X-Received: by 2002:a65:538f:: with SMTP id x15mr19738695pgq.429.1617547942154;
        Sun, 04 Apr 2021 07:52:22 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id l124sm13445031pfl.195.2021.04.04.07.52.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Apr 2021 07:52:21 -0700 (PDT)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        christian@brauner.io
Cc:     cgroups@vger.kernel.org, benbjiang@tencent.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        linussli@tencent.com, herberthbli@tencent.com,
        lennychen@tencent.com, allanyuliu@tencent.com,
        Peng Zhiguang <zgpeng@tencent.com>,
        Yulei Zhang <yuleixzhang@tencent.com>
Subject: [RFC 1/1] cgroup: add support for cgroup priority
Date:   Sun,  4 Apr 2021 22:52:12 +0800
Message-Id: <84ef7a7f3f9cd64c0426829565a0e7e7a1d61ef7.1617355387.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1617355387.git.yuleixzhang@tencent.com>
References: <cover.1617355387.git.yuleixzhang@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Lei Chen <lennychen@tencent.com>

Introduce new attribute "priority" to control group, which
could be used as scale by subssytem to manipulate the behaviors
of processes.
The default value of "priority" is set to 0 which means the
highest priority, and the totally levels of priority is defined
by CGROUP_PRIORITY_MAX.

Signed-off-by: Lei Chen <lennychen@tencent.com>
Signed-off-by: Liu Yu <allanyuliu@tencent.com>
Signed-off-by: Peng Zhiguang <zgpeng@tencent.com>
Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
---
 include/linux/cgroup-defs.h |  2 +
 include/linux/cgroup.h      |  2 +
 kernel/cgroup/cgroup.c      | 90 +++++++++++++++++++++++++++++++++++++
 3 files changed, 94 insertions(+)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 559ee05f8..3fa2f28a9 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -417,6 +417,7 @@ struct cgroup {
 	u16 subtree_ss_mask;
 	u16 old_subtree_control;
 	u16 old_subtree_ss_mask;
+	u16 priority;
 
 	/* Private pointers for each registered subsystem */
 	struct cgroup_subsys_state __rcu *subsys[CGROUP_SUBSYS_COUNT];
@@ -640,6 +641,7 @@ struct cgroup_subsys {
 	void (*exit)(struct task_struct *task);
 	void (*release)(struct task_struct *task);
 	void (*bind)(struct cgroup_subsys_state *root_css);
+	int (*css_priority_change)(struct cgroup_subsys_state *css, u16 old, u16 new);
 
 	bool early_init:1;
 
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 4f2f79de0..734d51aba 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -47,6 +47,7 @@ struct kernel_clone_args;
 
 /* internal flags */
 #define CSS_TASK_ITER_SKIPPED		(1U << 16)
+#define CGROUP_PRIORITY_MAX		8
 
 /* a css_task_iter should be treated as an opaque object */
 struct css_task_iter {
@@ -957,5 +958,6 @@ static inline void cgroup_bpf_get(struct cgroup *cgrp) {}
 static inline void cgroup_bpf_put(struct cgroup *cgrp) {}
 
 #endif /* CONFIG_CGROUP_BPF */
+ssize_t cgroup_priority(struct cgroup_subsys_state *css);
 
 #endif /* _LINUX_CGROUP_H */
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 9153b20e5..dcb057e42 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1892,6 +1892,7 @@ static void init_cgroup_housekeeping(struct cgroup *cgrp)
 	cgrp->dom_cgrp = cgrp;
 	cgrp->max_descendants = INT_MAX;
 	cgrp->max_depth = INT_MAX;
+	cgrp->priority = 0;
 	INIT_LIST_HEAD(&cgrp->rstat_css_list);
 	prev_cputime_init(&cgrp->prev_cputime);
 
@@ -4783,6 +4784,88 @@ static ssize_t cgroup_threads_write(struct kernfs_open_file *of,
 	return __cgroup_procs_write(of, buf, false) ?: nbytes;
 }
 
+static int cgroup_priority_show(struct seq_file *seq, void *v)
+{
+	struct cgroup *cgrp = seq_css(seq)->cgroup;
+	u16 prio = cgrp->priority;
+
+	seq_printf(seq, "%d\n", prio);
+
+	return 0;
+}
+
+static void cgroup_set_priority(struct cgroup *cgrp, unsigned int priority)
+{
+	u16 old = cgrp->priority;
+	struct cgroup_subsys_state *css;
+	int ssid;
+
+	cgrp->priority = priority;
+	for_each_css(css, ssid, cgrp) {
+		if (css->ss->css_priority_change)
+			css->ss->css_priority_change(css, old, priority);
+	}
+}
+
+static void cgroup_priority_propagate(struct cgroup *cgrp)
+{
+	struct cgroup *dsct;
+	struct cgroup_subsys_state *d_css;
+	u16 priority = cgrp->priority;
+
+	lockdep_assert_held(&cgroup_mutex);
+	cgroup_for_each_live_descendant_pre(dsct, d_css, cgrp) {
+		if (dsct->priority < priority)
+			cgroup_set_priority(dsct, priority);
+	}
+}
+
+static ssize_t cgroup_priority_write(struct kernfs_open_file *of,
+				      char *buf, size_t nbytes, loff_t off)
+{
+	struct cgroup *cgrp, *parent;
+	ssize_t ret;
+	u16 prio, orig;
+
+	buf = strstrip(buf);
+	ret = kstrtoint(buf, 0, &prio);
+	if (ret)
+		return ret;
+
+	if (prio < 0 || prio >= CGROUP_PRIORITY_MAX)
+		return -ERANGE;
+
+	cgrp = cgroup_kn_lock_live(of->kn, false);
+	if (!cgrp)
+		return -ENOENT;
+	parent = cgroup_parent(cgrp);
+	if (parent && prio < parent->priority) {
+		ret = -EINVAL;
+		goto unlock_out;
+	}
+	orig = cgrp->priority;
+	if (prio == orig)
+		goto unlock_out;
+
+	cgroup_set_priority(cgrp, prio);
+	cgroup_priority_propagate(cgrp);
+unlock_out:
+	cgroup_kn_unlock(of->kn);
+
+	return ret ?: nbytes;
+}
+
+ssize_t cgroup_priority(struct cgroup_subsys_state *css)
+{
+	struct cgroup *cgrp = css->cgroup;
+	unsigned int prio = 0;
+
+	if (cgrp)
+		prio = cgrp->priority;
+	return prio;
+}
+EXPORT_SYMBOL(cgroup_priority);
+
 /* cgroup core interface files for the default hierarchy */
 static struct cftype cgroup_base_files[] = {
 	{
@@ -4836,6 +4919,12 @@ static struct cftype cgroup_base_files[] = {
 		.seq_show = cgroup_max_depth_show,
 		.write = cgroup_max_depth_write,
 	},
+	{
+		.name = "cgroup.priority",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = cgroup_priority_show,
+		.write = cgroup_priority_write,
+	},
 	{
 		.name = "cgroup.stat",
 		.seq_show = cgroup_stat_show,
@@ -5178,6 +5267,7 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
 	cgrp->self.parent = &parent->self;
 	cgrp->root = root;
 	cgrp->level = level;
+	cgrp->priority = parent->priority;
 
 	ret = psi_cgroup_alloc(cgrp);
 	if (ret)
-- 
2.28.0

