Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09CB515321C
	for <lists+cgroups@lfdr.de>; Wed,  5 Feb 2020 14:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgBENom (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Feb 2020 08:44:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:52282 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727104AbgBENom (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 5 Feb 2020 08:44:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5E321AFAC;
        Wed,  5 Feb 2020 13:44:39 +0000 (UTC)
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     cgroups@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 2/3] cgroup/pids: Make event counters hierarchical
Date:   Wed,  5 Feb 2020 14:44:25 +0100
Message-Id: <20200205134426.10570-3-mkoutny@suse.com>
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

The pids.events file should honor the hierarchy, so make the events
propagate from their origin up to the root on the unified hierarchy. The
legacy hierarchy behavior remains the same.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  4 ++-
 kernel/cgroup/pids.c                    | 44 ++++++++++++++++---------
 2 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 38edeb79c2d8..5dda08f268b7 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1819,7 +1819,9 @@ PID Interface Files
   pids.events
 	A read-only flat-keyed file which exists on non-root cgroups.  Unless
 	specified otherwise, a value change in this file generates a file modified
-	event. The following entries are defined.
+	event. Fields in this file are hierarchical and the file modified event
+	can be generated due to an event down the hierarchy. The following
+	entries are defined.
 
 	  max
 		The number of times the limit of the cgroup was hit.
diff --git a/kernel/cgroup/pids.c b/kernel/cgroup/pids.c
index bbfb2fb56029..5d65b36931cd 100644
--- a/kernel/cgroup/pids.c
+++ b/kernel/cgroup/pids.c
@@ -223,6 +223,33 @@ static void pids_cancel_attach(struct cgroup_taskset *tset)
 	}
 }
 
+static void pids_event(struct pids_cgroup *pids_forking,
+		       struct pids_cgroup *pids_over_limit)
+{
+	struct pids_cgroup *p;
+	bool limit = false;
+
+	for (p = pids_forking; parent_pids(p); p = parent_pids(p)) {
+		/* Only log the first time events_limit_imposed is incremented. */
+		if (atomic64_inc_return(&p->events_limit_imposed) == 1 &&
+		    p == pids_forking) {
+			pr_info("cgroup: fork rejected by pids controller in ");
+			pr_cont_cgroup_path(p->css.cgroup);
+			pr_cont("\n");
+		}
+
+		if (p == pids_over_limit)
+			limit = true;
+		if (limit)
+			atomic64_inc(&p->events_limit);
+
+		cgroup_file_notify(&p->events_file);
+		/* Events are only notified in pids_forking on v1 */
+		if (!cgroup_subsys_on_dfl(pids_cgrp_subsys))
+			break;
+	}
+}
+
 /*
  * task_css_check(true) in pids_can_fork() and pids_cancel_fork() relies
  * on cgroup_threadgroup_change_begin() held by the copy_process().
@@ -237,22 +264,7 @@ static int pids_can_fork(struct task_struct *task)
 	pids = css_pids(css);
 	err = pids_try_charge(pids, 1, &pids_over_limit);
 	if (err) {
-		/* Backwards compatibility on v1 where events were notified in
-		 * leaves. */
-		if (!cgroup_subsys_on_dfl(pids_cgrp_subsys))
-			pids_over_limit = pids;
-
-		/* Only log the first time events_limit_imposed is incremented. */
-		if (atomic64_inc_return(&pids->events_limit_imposed) == 1) {
-			pr_info("cgroup: fork rejected by pids controller in ");
-			pr_cont_cgroup_path(pids->css.cgroup);
-			pr_cont("\n");
-		}
-		atomic64_inc(&pids_over_limit->events_limit);
-
-		cgroup_file_notify(&pids->events_file);
-		if (pids_over_limit != pids)
-			cgroup_file_notify(&pids_over_limit->events_file);
+		pids_event(pids, pids_over_limit);
 	}
 	return err;
 }
-- 
2.24.1

