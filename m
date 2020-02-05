Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC2C153221
	for <lists+cgroups@lfdr.de>; Wed,  5 Feb 2020 14:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbgBENot (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Feb 2020 08:44:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:52270 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726960AbgBENom (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 5 Feb 2020 08:44:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4B913AD57;
        Wed,  5 Feb 2020 13:44:39 +0000 (UTC)
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     cgroups@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 1/3] cgroup/pids: Separate semantics of pids.events related to pids.max
Date:   Wed,  5 Feb 2020 14:44:24 +0100
Message-Id: <20200205134426.10570-2-mkoutny@suse.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200205134426.10570-1-mkoutny@suse.com>
References: <20191128172612.10259-1-mkoutny@suse.com>
 <20200205134426.10570-1-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Currently, when pids.max limit is breached in the hierarchy, the event
is counted and reported in the cgroup where the forking task resides.

This decouples the limit and the notification caused by the limit making
it hard to detect when the actual limit was effected.

Let's introduce new events:
	  max
		The number of times the limit of the cgroup was hit.

	  max.imposed
		The number of times fork failed in the cgroup because of self
		or ancestor limit.

Since it changes semantics of the original "max" event, we introduce
this change only in the v2 API of the controller.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 Documentation/admin-guide/cgroup-v1/pids.rst |  3 +-
 Documentation/admin-guide/cgroup-v2.rst      | 12 ++++
 kernel/cgroup/pids.c                         | 72 +++++++++++++++++---
 3 files changed, 77 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/pids.rst b/Documentation/admin-guide/cgroup-v1/pids.rst
index 6acebd9e72c8..0f9f9a7b1f6c 100644
--- a/Documentation/admin-guide/cgroup-v1/pids.rst
+++ b/Documentation/admin-guide/cgroup-v1/pids.rst
@@ -36,7 +36,8 @@ superset of parent/child/pids.current.
 
 The pids.events file contains event counters:
 
-  - max: Number of times fork failed because limit was hit.
+  - max: Number of times fork failed in the cgroup because limit was hit in
+    self or ancestors.
 
 Example
 -------
diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 3f801461f0f3..38edeb79c2d8 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1816,6 +1816,18 @@ PID Interface Files
 	The number of processes currently in the cgroup and its
 	descendants.
 
+  pids.events
+	A read-only flat-keyed file which exists on non-root cgroups.  Unless
+	specified otherwise, a value change in this file generates a file modified
+	event. The following entries are defined.
+
+	  max
+		The number of times the limit of the cgroup was hit.
+
+	  max.imposed
+		The number of times fork failed in the cgroup because of self
+		or ancestor limit.
+
 Organisational operations are not blocked by cgroup policies, so it is
 possible to have pids.current > pids.max.  This can be done by either
 setting the limit to be smaller than pids.current, or attaching enough
diff --git a/kernel/cgroup/pids.c b/kernel/cgroup/pids.c
index 138059eb730d..bbfb2fb56029 100644
--- a/kernel/cgroup/pids.c
+++ b/kernel/cgroup/pids.c
@@ -50,8 +50,17 @@ struct pids_cgroup {
 	/* Handle for "pids.events" */
 	struct cgroup_file		events_file;
 
-	/* Number of times fork failed because limit was hit. */
+	/*
+	 * Number of times fork failed in subtree because this pids_cgroup
+	 * limit was hit.
+	 */
 	atomic64_t			events_limit;
+
+	/*
+	 * Number of times fork failed in this pids_cgroup because ancestor
+	 * limit was hit.
+	 */
+	atomic64_t			events_limit_imposed;
 };
 
 static struct pids_cgroup *css_pids(struct cgroup_subsys_state *css)
@@ -76,6 +85,7 @@ pids_css_alloc(struct cgroup_subsys_state *parent)
 	atomic64_set(&pids->counter, 0);
 	atomic64_set(&pids->limit, PIDS_MAX);
 	atomic64_set(&pids->events_limit, 0);
+	atomic64_set(&pids->events_limit_imposed, 0);
 	return &pids->css;
 }
 
@@ -140,7 +150,8 @@ static void pids_charge(struct pids_cgroup *pids, int num)
  * the new value to exceed the hierarchical limit. Returns 0 if the charge
  * succeeded, otherwise -EAGAIN.
  */
-static int pids_try_charge(struct pids_cgroup *pids, int num)
+static int pids_try_charge(struct pids_cgroup *pids, int num,
+			   struct pids_cgroup **fail)
 {
 	struct pids_cgroup *p, *q;
 
@@ -153,8 +164,10 @@ static int pids_try_charge(struct pids_cgroup *pids, int num)
 		 * p->limit is %PIDS_MAX then we know that this test will never
 		 * fail.
 		 */
-		if (new > limit)
+		if (new > limit) {
+			*fail = p;
 			goto revert;
+		}
 	}
 
 	return 0;
@@ -217,20 +230,29 @@ static void pids_cancel_attach(struct cgroup_taskset *tset)
 static int pids_can_fork(struct task_struct *task)
 {
 	struct cgroup_subsys_state *css;
-	struct pids_cgroup *pids;
+	struct pids_cgroup *pids, *pids_over_limit;
 	int err;
 
 	css = task_css_check(current, pids_cgrp_id, true);
 	pids = css_pids(css);
-	err = pids_try_charge(pids, 1);
+	err = pids_try_charge(pids, 1, &pids_over_limit);
 	if (err) {
-		/* Only log the first time events_limit is incremented. */
-		if (atomic64_inc_return(&pids->events_limit) == 1) {
+		/* Backwards compatibility on v1 where events were notified in
+		 * leaves. */
+		if (!cgroup_subsys_on_dfl(pids_cgrp_subsys))
+			pids_over_limit = pids;
+
+		/* Only log the first time events_limit_imposed is incremented. */
+		if (atomic64_inc_return(&pids->events_limit_imposed) == 1) {
 			pr_info("cgroup: fork rejected by pids controller in ");
-			pr_cont_cgroup_path(css->cgroup);
+			pr_cont_cgroup_path(pids->css.cgroup);
 			pr_cont("\n");
 		}
+		atomic64_inc(&pids_over_limit->events_limit);
+
 		cgroup_file_notify(&pids->events_file);
+		if (pids_over_limit != pids)
+			cgroup_file_notify(&pids_over_limit->events_file);
 	}
 	return err;
 }
@@ -309,6 +331,17 @@ static int pids_events_show(struct seq_file *sf, void *v)
 	struct pids_cgroup *pids = css_pids(seq_css(sf));
 
 	seq_printf(sf, "max %lld\n", (s64)atomic64_read(&pids->events_limit));
+	seq_printf(sf, "max.imposed %lld\n",
+		   (s64)atomic64_read(&pids->events_limit_imposed));
+	return 0;
+}
+
+static int pids_events_show_legacy(struct seq_file *sf, void *v)
+{
+	struct pids_cgroup *pids = css_pids(seq_css(sf));
+
+	seq_printf(sf, "max %lld\n",
+		   (s64)atomic64_read(&pids->events_limit_imposed));
 	return 0;
 }
 
@@ -333,6 +366,27 @@ static struct cftype pids_files[] = {
 	{ }	/* terminate */
 };
 
+static struct cftype pids_files_legacy[] = {
+	{
+		.name = "max",
+		.write = pids_max_write,
+		.seq_show = pids_max_show,
+		.flags = CFTYPE_NOT_ON_ROOT,
+	},
+	{
+		.name = "current",
+		.read_s64 = pids_current_read,
+		.flags = CFTYPE_NOT_ON_ROOT,
+	},
+	{
+		.name = "events",
+		.seq_show = pids_events_show_legacy,
+		.file_offset = offsetof(struct pids_cgroup, events_file),
+		.flags = CFTYPE_NOT_ON_ROOT,
+	},
+	{ }	/* terminate */
+};
+
 struct cgroup_subsys pids_cgrp_subsys = {
 	.css_alloc	= pids_css_alloc,
 	.css_free	= pids_css_free,
@@ -341,7 +395,7 @@ struct cgroup_subsys pids_cgrp_subsys = {
 	.can_fork	= pids_can_fork,
 	.cancel_fork	= pids_cancel_fork,
 	.release	= pids_release,
-	.legacy_cftypes	= pids_files,
 	.dfl_cftypes	= pids_files,
+	.legacy_cftypes	= pids_files_legacy,
 	.threaded	= true,
 };
-- 
2.24.1

