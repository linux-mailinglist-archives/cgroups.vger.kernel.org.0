Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50FD635CEDB
	for <lists+cgroups@lfdr.de>; Mon, 12 Apr 2021 18:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244697AbhDLQvJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Apr 2021 12:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345730AbhDLQrs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Apr 2021 12:47:48 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A2BC06138E
        for <cgroups@vger.kernel.org>; Mon, 12 Apr 2021 09:45:58 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id f29so9851027pgm.8
        for <cgroups@vger.kernel.org>; Mon, 12 Apr 2021 09:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a6x/SVY566QC4XRne/VcnphgwitSAF9FZ0ekSLyRb6U=;
        b=NrA3V8OYI4PeAa68KkhMvhrCGkESZskjhs8ykqnIV1hnUCHB/9kp/UfHBIz43yBPwk
         CwVEefr8Hd6/2tbtqq40azEAufA4JpCK9hV5c2vltMEH5X7mizo9OpmaHitn1UUrCkwH
         vVS4Tt7Ntj+gJ5GM9qSL+5Ww2kysiTZFRxlqt9rzKtcjy1PVRGJv+p1Hovqf0X2d32eZ
         uEZwIVb/oNyQ4D3Y2U15m3F1ZAAOqun0gk0n6QgpAcYCCoF1cJcJpOeN7i9ROI44vXLq
         yo7dUOFiiH1P3PrPcAgAyP++vpU3ZQPfLbPFk5AS79s/IP0X8wABMRGkotdHS448aJXX
         k2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a6x/SVY566QC4XRne/VcnphgwitSAF9FZ0ekSLyRb6U=;
        b=pN0xwL3piDPk2OyUhbt/MNPPIdPb6jarff5gjcklzBFGgc/Gw303l9xLwYHD1NhPjC
         2LoQLADe1uvbzQiD/dfTBETuakDDFJr3GDrjizt4K5r3HA7X6pyvURvSo/sjdP6tCVnK
         ksY9BVPZvmw/dIi7pPokWldnAhRfb90aESw55bZrUgpEmF6eci4iKj5if6mjIErRtb7L
         ZBzL5Ktv+iMdqI0XPWSlodVqlxWxImRyOq8+HYV8W3tZnq09S6XM0HIOzmmMea+oPz5u
         YEULkV7234urVLt+nSlk+hVfm29zLUqwzne8FHz4C9hs8D3FwyTozjr+qM+doaVdMEr/
         tr6A==
X-Gm-Message-State: AOAM533gp24WTAb2Hys6U8cnXE58+mv839QN4LVH4wWT2cD5YBBNKY1T
        2mW5YC2+7hgZes360U+pKgM=
X-Google-Smtp-Source: ABdhPJzhbk3CiIIK8RBvaDM+oT/jHezfpI9/0kWlb+qCPuJbX+J+2AEynaG+Kz05O2ICCgc/ABU/FQ==
X-Received: by 2002:a63:5c48:: with SMTP id n8mr27596087pgm.411.1618245957574;
        Mon, 12 Apr 2021 09:45:57 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id g10sm2913844pfj.137.2021.04.12.09.45.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Apr 2021 09:45:57 -0700 (PDT)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        christian@brauner.io
Cc:     cgroups@vger.kernel.org, benbjiang@tencent.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        linussli@tencent.com, herberthbli@tencent.com,
        Lei Chen <lennychen@tencent.com>,
        Liu Yu <allanyuliu@tencent.com>,
        Peng Zhiguang <zgpeng@tencent.com>,
        Yulei Zhang <yuleixzhang@tencent.com>
Subject: [RFC v2 1/2] cgroup: add support for cgroup priority
Date:   Tue, 13 Apr 2021 00:45:48 +0800
Message-Id: <2304fff128001ea8962704f1716286d03044ac51.1618219939.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1618219939.git.yuleixzhang@tencent.com>
References: <cover.1618219939.git.yuleixzhang@tencent.com>
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
index 9153b20e5..aa019ad24 100644
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
+	ret = kstrtou16(buf, 0, &prio);
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

