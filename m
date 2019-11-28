Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 669E110CDDD
	for <lists+cgroups@lfdr.de>; Thu, 28 Nov 2019 18:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfK1R00 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 Nov 2019 12:26:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:56404 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726594AbfK1R00 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 28 Nov 2019 12:26:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6B9A2AE20;
        Thu, 28 Nov 2019 17:26:24 +0000 (UTC)
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     cgroups@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] cgroup/pids: Make pids.events notifications affine to pids.max
Date:   Thu, 28 Nov 2019 18:26:12 +0100
Message-Id: <20191128172612.10259-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Currently, when pids.max limit is breached in the hierarchy, the event
is counted and reported in the cgroup where the forking task resides.

The proper hierarchical behavior is to count and report the event in the
cgroup whose limit is being exceeded. Apply this behavior in the default
hierarchy.

Reasons for RFC:

1) If anyone has adjusted their readings to this behavior, this is a BC
   break.

2) This solves no reported bug, just a spotted inconsistency.

3) One step further would be to distinguish pids.events and
   pids.events.local for proper hierarchical counting. (The current
   behavior wouldn't match neither though.)

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/cgroup/pids.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/kernel/cgroup/pids.c b/kernel/cgroup/pids.c
index 138059eb730d..5fc34d8b8f60 100644
--- a/kernel/cgroup/pids.c
+++ b/kernel/cgroup/pids.c
@@ -140,7 +140,7 @@ static void pids_charge(struct pids_cgroup *pids, int num)
  * the new value to exceed the hierarchical limit. Returns 0 if the charge
  * succeeded, otherwise -EAGAIN.
  */
-static int pids_try_charge(struct pids_cgroup *pids, int num)
+static int pids_try_charge(struct pids_cgroup *pids, int num, struct pids_cgroup **fail)
 {
 	struct pids_cgroup *p, *q;
 
@@ -153,8 +153,10 @@ static int pids_try_charge(struct pids_cgroup *pids, int num)
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
@@ -217,20 +219,25 @@ static void pids_cancel_attach(struct cgroup_taskset *tset)
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
+		/* Backwards compatibility on v1 where events were notified in
+		 * leaves. */
+		if (!cgroup_subsys_on_dfl(pids_cgrp_subsys))
+			pids_over_limit = pids;
+
 		/* Only log the first time events_limit is incremented. */
-		if (atomic64_inc_return(&pids->events_limit) == 1) {
+		if (atomic64_inc_return(&pids_over_limit->events_limit) == 1) {
 			pr_info("cgroup: fork rejected by pids controller in ");
-			pr_cont_cgroup_path(css->cgroup);
+			pr_cont_cgroup_path(pids_over_limit->css.cgroup);
 			pr_cont("\n");
 		}
-		cgroup_file_notify(&pids->events_file);
+		cgroup_file_notify(&pids_over_limit->events_file);
 	}
 	return err;
 }
-- 
2.24.0

