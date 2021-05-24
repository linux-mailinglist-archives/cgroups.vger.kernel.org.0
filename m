Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9980C38F3E0
	for <lists+cgroups@lfdr.de>; Mon, 24 May 2021 21:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbhEXTzN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 24 May 2021 15:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbhEXTzN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 24 May 2021 15:55:13 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1E5C061574
        for <cgroups@vger.kernel.org>; Mon, 24 May 2021 12:53:44 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b66-20020a25cb450000b02905076ea039f1so38654445ybg.1
        for <cgroups@vger.kernel.org>; Mon, 24 May 2021 12:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=fc46/l2rCPobikwBmwQYOTco7XcqbGGg0DWxmUOO5h8=;
        b=jvOD4gDcykd2DnaG7KChFMf/t56S72Bk0bomU/fBxMiAnoWd7HVRyOSfpWu9Stuz6S
         zbV6X9qM2HOrZPWqyQKzh1wwdaBMoOhziaJdgBf7Q1M8/FjA436qXMTOSe6Gdx0zrxo/
         BXsIJZg4vS08vil0Hd5n8n4R9xs7bATgWexWfBWDnGEWapvmE1KFDPReV18Z+c9kf7Fm
         w5HeaWtaVkDQK94JtjL6L3r4Bmvj2wmnZZ+iVO1XEiH4ubLmyF/a3UGdlfdYRiz3346Y
         QqJUBGWd1+wUQBErjHzvUuU5RI8Wog1eDUQzPHiCjILmKkQ6pC5AlgsV6qb0Wn296vSl
         w5Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=fc46/l2rCPobikwBmwQYOTco7XcqbGGg0DWxmUOO5h8=;
        b=oqIbSoI1tUNHz82yG0MyZl4z4rkdrFN9AAy7jqnYNh0Mks6K3vEZL9rKIi9yUzhsmS
         msE0zTRFTJqE+Kch3LUyW9Sv67g0QRMZko4nF6DnMTZmXEM2eY2E0637ZIsFeUAf3XAO
         Vua5tXObdTrWfg4RmFEd1zbjM1WrNhhu2iXBNPYfIcMl30PK3orosGHMgsrYLLE4vWxz
         WtjL+3LE+r9HDPT3G7KOwbUI2GpJyfWl21BSLIWCu35RsnP5LL7XvbrofR+hxJAydQK8
         elQe35N/HAA5QqRVPDylPnQKBykxvxRUIWjflK9Rr9jwOZezABaK1ZvIP4kzqxlIOfTg
         8RXg==
X-Gm-Message-State: AOAM531MERpWc+raZoLNYqVKBr30EnPz9PQHhCw5ndnRameHfWs+B/PX
        wYCIrnzL3CsDxJpowNaAX8zMVtdzu0Y=
X-Google-Smtp-Source: ABdhPJz0xWr9aSCJIUX5Kh4JIeVf0qIpUzKga9yfb02e7Y1QctA+XTSC7aFMAb2/pfsHGYci5/U/GnQdJ2o=
X-Received: from surenb1.mtv.corp.google.com ([2620:15c:211:200:a530:52cb:fa88:d7b3])
 (user=surenb job=sendgmr) by 2002:a25:bb84:: with SMTP id y4mr63977ybg.450.1621886023878;
 Mon, 24 May 2021 12:53:43 -0700 (PDT)
Date:   Mon, 24 May 2021 12:53:39 -0700
Message-Id: <20210524195339.1233449-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH v3 1/1] cgroup: make per-cgroup pressure stall tracking configurable
From:   Suren Baghdasaryan <surenb@google.com>
To:     tj@kernel.org
Cc:     hannes@cmpxchg.org, lizefan.x@bytedance.com, mingo@redhat.com,
        peterz@infradead.org, shakeelb@google.com, juri.lelli@redhat.com,
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
changes in v3:
- Replaced psi_cgroups_disabled with psi_cgroups_enabled key, per PeterZ
- Rebased to ToT after cgroup tree merge
- Added "Disabling ... control group feature" message in cgroup_disable()
  similar to the new message generated when a cgroup gets disabled

 .../admin-guide/kernel-parameters.txt         |  9 +++-
 include/linux/cgroup-defs.h                   |  1 +
 include/linux/cgroup.h                        |  7 +++
 kernel/cgroup/cgroup.c                        | 48 +++++++++++++++++++
 kernel/sched/psi.c                            | 30 +++++++-----
 5 files changed, 80 insertions(+), 15 deletions(-)

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
index fb8f6d2cd104..5a9d898daecb 100644
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
index 6bc9c76680b2..5492fcb7f9ca 100644
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
index 21ecc6ee6a6d..3a15a8407b46 100644
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
@@ -6213,6 +6249,15 @@ static int __init cgroup_disable(char *str)
 			pr_info("Disabling %s control group subsystem\n",
 				ss->name);
 		}
+
+		for (i = 0; i < OPT_FEATURE_COUNT; i++) {
+			if (strcmp(token, cgroup_opt_feature_names[i]))
+				continue;
+			cgroup_feature_disable_mask |= 1 << i;
+			pr_info("Disabling %s control group feature\n",
+				cgroup_opt_feature_names[i]);
+			break;
+		}
 	}
 	return 1;
 }
@@ -6511,6 +6556,9 @@ static ssize_t show_delegatable_files(struct cftype *files, char *buf,
 		if (!(cft->flags & CFTYPE_NS_DELEGATABLE))
 			continue;
 
+		if ((cft->flags & CFTYPE_PRESSURE) && !cgroup_psi_enabled())
+			continue;
+
 		if (prefix)
 			ret += snprintf(buf + ret, size - ret, "%s.", prefix);
 
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index cc25a3cff41f..b773cae4c24b 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -148,6 +148,7 @@
 static int psi_bug __read_mostly;
 
 DEFINE_STATIC_KEY_FALSE(psi_disabled);
+DEFINE_STATIC_KEY_TRUE(psi_cgroups_enabled);
 
 #ifdef CONFIG_PSI_DEFAULT_DISABLED
 static bool psi_enable;
@@ -211,6 +212,9 @@ void __init psi_init(void)
 		return;
 	}
 
+	if (!cgroup_psi_enabled())
+		static_branch_disable(&psi_cgroups_enabled);
+
 	psi_period = jiffies_to_nsecs(PSI_FREQ);
 	group_init(&psi_system);
 }
@@ -744,23 +748,23 @@ static void psi_group_change(struct psi_group *group, int cpu,
 
 static struct psi_group *iterate_groups(struct task_struct *task, void **iter)
 {
+	if (*iter == &psi_system)
+		return NULL;
+
 #ifdef CONFIG_CGROUPS
-	struct cgroup *cgroup = NULL;
+	if (static_branch_likely(&psi_cgroups_enabled)) {
+		struct cgroup *cgroup = NULL;
 
-	if (!*iter)
-		cgroup = task->cgroups->dfl_cgrp;
-	else if (*iter == &psi_system)
-		return NULL;
-	else
-		cgroup = cgroup_parent(*iter);
+		if (!*iter)
+			cgroup = task->cgroups->dfl_cgrp;
+		else
+			cgroup = cgroup_parent(*iter);
 
-	if (cgroup && cgroup_parent(cgroup)) {
-		*iter = cgroup;
-		return cgroup_psi(cgroup);
+		if (cgroup && cgroup_parent(cgroup)) {
+			*iter = cgroup;
+			return cgroup_psi(cgroup);
+		}
 	}
-#else
-	if (*iter)
-		return NULL;
 #endif
 	*iter = &psi_system;
 	return &psi_system;
-- 
2.31.1.818.g46aad6cb9e-goog

