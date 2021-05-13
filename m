Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9969637FCEE
	for <lists+cgroups@lfdr.de>; Thu, 13 May 2021 19:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbhEMRzR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 May 2021 13:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbhEMRzL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 13 May 2021 13:55:11 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408C7C061761
        for <cgroups@vger.kernel.org>; Thu, 13 May 2021 10:54:00 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id f79-20020a6238520000b029028e7b5e8d7bso18337321pfa.12
        for <cgroups@vger.kernel.org>; Thu, 13 May 2021 10:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=4h31K2eiyFYJECD6jlXNAVHQd0JiCpNhIBmP2KCnD4c=;
        b=ofKtuEEcDD4yCmeEIuSCquHKovbV1slPISxwCQTyw4iykw/j2ncspJ0htUgP4AWxYm
         rSlAVzTDcK+inbYAWvLiarcwGutQB6dA5ySpZo+TT4zzJ0CuGmfcZfvem1/Rlhzt5xjs
         PD7X0d7fA30y+r8JmzzpGw6DXAFut/Bq2H184JYsu8js4vbXNOXQCqxa6W8R2B2I005W
         pdn6PN+RmkQNuZldg5kDR/QKAfGUpwHDkehDFK4Hw5ljWMF5uDt8Ou2FjZrHC0Q6nyzv
         ceIRFzEONJGOKB43ddrTtEQJf9Dg3oovy+TYa0zqrl5ob1hruZa2BSqWZJrSGeixShBq
         rqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=4h31K2eiyFYJECD6jlXNAVHQd0JiCpNhIBmP2KCnD4c=;
        b=Qn0PhoySihAeK5bA/7Y5QOpXkhp3L1eV2VqtDxsTBeo+/muyg4SWyPVqkxFCbc2hpV
         RzuYQmj7jo35MoXzRlMwWJp1yDmNxPXUX3xNv98s+RLiQnNSUGeX0l2unXXK7mwYqkQS
         SE5jYkbzXYFbSd5f77BHWgqHNq7C3hOc6TCEjgNqAtV9BcZZzK/r1globZvriEvTePCl
         bkobBQQsbpi2PV9LckSh/DYe6n9wulgkcUcbcrKdGzydbsWgrSkejmygNQwiiyxDzqvA
         YT0abvLycXDfcVRCWDtFq1mOX8iWniMyImwlsKI3NkpUk4RfbcAxm/e2WOL1FEN7YaOX
         VGQQ==
X-Gm-Message-State: AOAM530xT6Pd2ekt64MozN4Pxqce9dnVZrQZFFYCRg5kNkzBYbCOrtmS
        jQR7fyLP3UE8KPFs5sX/UXySLXPlb0M=
X-Google-Smtp-Source: ABdhPJxHPu2QPsy8y6naNODAyq0c2q6tVGXFYvsc/7U+J2gWtm/+DmC2EGP8TzQrAjoke41LFE3sDd3/QLk=
X-Received: from surenb1.mtv.corp.google.com ([2620:15c:211:200:f5d3:2ce1:2b19:735e])
 (user=surenb job=sendgmr) by 2002:a17:90a:4487:: with SMTP id
 t7mr533181pjg.1.1620928439289; Thu, 13 May 2021 10:53:59 -0700 (PDT)
Date:   Thu, 13 May 2021 10:53:49 -0700
Message-Id: <20210513175349.959661-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
Subject: [PATCH 1/1] cgroup: make per-cgroup pressure stall tracking configurable
From:   Suren Baghdasaryan <surenb@google.com>
To:     tj@kernel.org
Cc:     hannes@cmpxchg.org, lizefan.x@bytedance.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        minchan@kernel.org, corbet@lwn.net, bristot@redhat.com,
        paulmck@kernel.org, rdunlap@infradead.org,
        akpm@linux-foundation.org, tglx@linutronix.de, macro@orcam.me.uk,
        viresh.kumar@linaro.org, mike.kravetz@oracle.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, surenb@google.com, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

PSI accounts stalls for each cgroup separately and aggregates it at each
level of the hierarchy. This causes additional overhead with psi_avgs_work
being called for each cgroup in the hierarchy. psi_avgs_work has been
highly optimized, however on systems with large number of cgroups the
overhead becomes noticeable.
Systems which use PSI only at the system level could avoid this overhead
if PSI can be configured to skip per-cgroup stall accounting.
Add "cgroup_disable=pressure" kernel command-line option to allow
requesting system-wide only pressure stall accounting. When set, it
keeps system-wide accounting under /proc/pressure/ but skips accounting
for individual cgroups and does not expose PSI nodes in cgroup hierarchy.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 .../admin-guide/kernel-parameters.txt         |  9 +++-
 include/linux/cgroup-defs.h                   |  1 +
 include/linux/cgroup.h                        |  7 +++
 kernel/cgroup/cgroup.c                        | 46 +++++++++++++++++++
 kernel/sched/psi.c                            |  8 +++-
 5 files changed, 67 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index cb89dbdedc46..653c62142f07 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -497,16 +497,21 @@
 	ccw_timeout_log	[S390]
 			See Documentation/s390/common_io.rst for details.
 
-	cgroup_disable=	[KNL] Disable a particular controller
-			Format: {name of the controller(s) to disable}
+	cgroup_disable=	[KNL] Disable a particular controller or optional feature
+			Format: {name of the controller(s) or feature(s) to disable}
 			The effects of cgroup_disable=foo are:
 			- foo isn't auto-mounted if you mount all cgroups in
 			  a single hierarchy
 			- foo isn't visible as an individually mountable
 			  subsystem
+			- if foo is an optional feature then the feature is
+			  disabled and corresponding cgroup files are not
+			  created
 			{Currently only "memory" controller deal with this and
 			cut the overhead, others just disable the usage. So
 			only cgroup_disable=memory is actually worthy}
+			Specifying "pressure" disables per-cgroup pressure
+			stall information accounting feature
 
 	cgroup_no_v1=	[KNL] Disable cgroup controllers and named hierarchies in v1
 			Format: { { controller | "all" | "named" }
diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 559ee05f86b2..671f55cac0f0 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -110,6 +110,7 @@ enum {
 	CFTYPE_NO_PREFIX	= (1 << 3),	/* (DON'T USE FOR NEW FILES) no subsys prefix */
 	CFTYPE_WORLD_WRITABLE	= (1 << 4),	/* (DON'T USE FOR NEW FILES) S_IWUGO */
 	CFTYPE_DEBUG		= (1 << 5),	/* create when cgroup_debug */
+	CFTYPE_PRESSURE		= (1 << 6),	/* only if pressure feature is enabled */
 
 	/* internal flags, do not use outside cgroup core proper */
 	__CFTYPE_ONLY_ON_DFL	= (1 << 16),	/* only on default hierarchy */
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 4f2f79de083e..b929f589968b 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -676,6 +676,8 @@ static inline struct psi_group *cgroup_psi(struct cgroup *cgrp)
 	return &cgrp->psi;
 }
 
+bool cgroup_psi_enabled(void);
+
 static inline void cgroup_init_kthreadd(void)
 {
 	/*
@@ -735,6 +737,11 @@ static inline struct psi_group *cgroup_psi(struct cgroup *cgrp)
 	return NULL;
 }
 
+static inline bool cgroup_psi_enabled(void)
+{
+	return false;
+}
+
 static inline bool task_under_cgroup_hierarchy(struct task_struct *task,
 					       struct cgroup *ancestor)
 {
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index e049edd66776..c4b16c82e199 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -209,6 +209,22 @@ struct cgroup_namespace init_cgroup_ns = {
 static struct file_system_type cgroup2_fs_type;
 static struct cftype cgroup_base_files[];
 
+/* cgroup optional features */
+enum cgroup_opt_features {
+#ifdef CONFIG_PSI
+	OPT_FEATURE_PRESSURE,
+#endif
+	OPT_FEATURE_COUNT
+};
+
+static const char *cgroup_opt_feature_names[OPT_FEATURE_COUNT] = {
+#ifdef CONFIG_PSI
+	"pressure",
+#endif
+};
+
+static u16 cgroup_feature_disable_mask __read_mostly;
+
 static int cgroup_apply_control(struct cgroup *cgrp);
 static void cgroup_finalize_control(struct cgroup *cgrp, int ret);
 static void css_task_iter_skip(struct css_task_iter *it,
@@ -3631,6 +3647,18 @@ static void cgroup_pressure_release(struct kernfs_open_file *of)
 {
 	psi_trigger_replace(&of->priv, NULL);
 }
+
+bool cgroup_psi_enabled(void)
+{
+	return (cgroup_feature_disable_mask & (1 << OPT_FEATURE_PRESSURE)) == 0;
+}
+
+#else /* CONFIG_PSI */
+bool cgroup_psi_enabled(void)
+{
+	return false;
+}
+
 #endif /* CONFIG_PSI */
 
 static int cgroup_freeze_show(struct seq_file *seq, void *v)
@@ -3881,6 +3909,8 @@ static int cgroup_addrm_files(struct cgroup_subsys_state *css,
 restart:
 	for (cft = cfts; cft != cft_end && cft->name[0] != '\0'; cft++) {
 		/* does cft->flags tell us to skip this file on @cgrp? */
+		if ((cft->flags & CFTYPE_PRESSURE) && !cgroup_psi_enabled())
+			continue;
 		if ((cft->flags & __CFTYPE_ONLY_ON_DFL) && !cgroup_on_dfl(cgrp))
 			continue;
 		if ((cft->flags & __CFTYPE_NOT_ON_DFL) && cgroup_on_dfl(cgrp))
@@ -3958,6 +3988,9 @@ static int cgroup_init_cftypes(struct cgroup_subsys *ss, struct cftype *cfts)
 
 		WARN_ON(cft->ss || cft->kf_ops);
 
+		if ((cft->flags & CFTYPE_PRESSURE) && !cgroup_psi_enabled())
+			continue;
+
 		if (cft->seq_start)
 			kf_ops = &cgroup_kf_ops;
 		else
@@ -4866,6 +4899,7 @@ static struct cftype cgroup_base_files[] = {
 #ifdef CONFIG_PSI
 	{
 		.name = "io.pressure",
+		.flags = CFTYPE_PRESSURE,
 		.seq_show = cgroup_io_pressure_show,
 		.write = cgroup_io_pressure_write,
 		.poll = cgroup_pressure_poll,
@@ -4873,6 +4907,7 @@ static struct cftype cgroup_base_files[] = {
 	},
 	{
 		.name = "memory.pressure",
+		.flags = CFTYPE_PRESSURE,
 		.seq_show = cgroup_memory_pressure_show,
 		.write = cgroup_memory_pressure_write,
 		.poll = cgroup_pressure_poll,
@@ -4880,6 +4915,7 @@ static struct cftype cgroup_base_files[] = {
 	},
 	{
 		.name = "cpu.pressure",
+		.flags = CFTYPE_PRESSURE,
 		.seq_show = cgroup_cpu_pressure_show,
 		.write = cgroup_cpu_pressure_write,
 		.poll = cgroup_pressure_poll,
@@ -6216,6 +6252,13 @@ static int __init cgroup_disable(char *str)
 				continue;
 			cgroup_disable_mask |= 1 << i;
 		}
+
+		for (i = 0; i < OPT_FEATURE_COUNT; i++) {
+			if (strcmp(token, cgroup_opt_feature_names[i]))
+				continue;
+			cgroup_feature_disable_mask |= 1 << i;
+			break;
+		}
 	}
 	return 1;
 }
@@ -6514,6 +6557,9 @@ static ssize_t show_delegatable_files(struct cftype *files, char *buf,
 		if (!(cft->flags & CFTYPE_NS_DELEGATABLE))
 			continue;
 
+		if ((cft->flags & CFTYPE_PRESSURE) && !cgroup_psi_enabled())
+			continue;
+
 		if (prefix)
 			ret += snprintf(buf + ret, size - ret, "%s.", prefix);
 
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index cc25a3cff41f..c73efd7d4fba 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -747,9 +747,12 @@ static struct psi_group *iterate_groups(struct task_struct *task, void **iter)
 #ifdef CONFIG_CGROUPS
 	struct cgroup *cgroup = NULL;
 
-	if (!*iter)
+	if (!*iter) {
+		/* Skip to psi_system if per-cgroup accounting is disabled */
+		if (!cgroup_psi_enabled())
+			goto update_sys;
 		cgroup = task->cgroups->dfl_cgrp;
-	else if (*iter == &psi_system)
+	} else if (*iter == &psi_system)
 		return NULL;
 	else
 		cgroup = cgroup_parent(*iter);
@@ -758,6 +761,7 @@ static struct psi_group *iterate_groups(struct task_struct *task, void **iter)
 		*iter = cgroup;
 		return cgroup_psi(cgroup);
 	}
+update_sys:
 #else
 	if (*iter)
 		return NULL;
-- 
2.31.1.607.g51e8a6a459-goog

