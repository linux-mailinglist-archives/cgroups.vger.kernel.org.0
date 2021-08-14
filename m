Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB5773EC52B
	for <lists+cgroups@lfdr.de>; Sat, 14 Aug 2021 22:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbhHNU6o (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 14 Aug 2021 16:58:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54367 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232860AbhHNU6m (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 14 Aug 2021 16:58:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628974693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=/FWymyrQLciNwrWKD+P1AGL1QQGB0Rc+iBXvPqYeYy8=;
        b=agFBhvEm2g/ZO5fuyMq/W0ZDnb52dlHwGlVF4Qa7TTj7SZeQLGk3PqWLweF9a6rgjzbleG
        N+/Y27wOf3a8t30yapcHMn0Qmj4qVY6Fw985DKbBjnzBxG4a7wUgYIyd5T8AxOpILfvhfS
        8NB+hZ1h3AXFszN40AMt9e0Q6dzmQow=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-nYxWsfdzMCyWXmrw-3HdZw-1; Sat, 14 Aug 2021 16:58:12 -0400
X-MC-Unique: nYxWsfdzMCyWXmrw-3HdZw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B703107ACF5;
        Sat, 14 Aug 2021 20:58:10 +0000 (UTC)
Received: from llong.com (unknown [10.22.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5EB51620DE;
        Sat, 14 Aug 2021 20:58:08 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v6 2/6] cgroup/cpuset: Show invalid partition reason string
Date:   Sat, 14 Aug 2021 16:57:39 -0400
Message-Id: <20210814205743.3039-3-longman@redhat.com>
In-Reply-To: <20210814205743.3039-1-longman@redhat.com>
References: <20210814205743.3039-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

There are a number of different reasons which can cause a partition to
become invalid. A user seeing an invalid partition may not know exactly
why. To help user to get a better understanding of the underlying reason,
The cpuset.cpus.partition control file, when read, will now report the
reason why a partition become invalid. When a partition does become
invalid, reading the control file will show "root invalid (<reason>)"
where <reason> is a string that describes why the partition is invalid.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 46 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 3ac88a6a57a2..7548e07a9874 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -78,6 +78,24 @@ struct fmeter {
 	spinlock_t lock;	/* guards read or write of above */
 };
 
+/*
+ * Invalid partition error code
+ */
+enum prs_errcode {
+	PERR_NONE = 0,
+	PERR_INVCPUS,
+	PERR_NOCPUS,
+	PERR_PARENT,
+	PERR_HOTPLUG,
+};
+
+static const char * const perr_strings[] = {
+	[PERR_INVCPUS] = "Invalid change to cpuset.cpus",
+	[PERR_PARENT]  = "Parent is no longer a partition root",
+	[PERR_NOCPUS]  = "Parent unable to distribute cpu downstream",
+	[PERR_HOTPLUG] = "No cpu available due to hotplug",
+};
+
 struct cpuset {
 	struct cgroup_subsys_state css;
 
@@ -163,6 +181,9 @@ struct cpuset {
 
 	/* Handle for cpuset.cpus.partition */
 	struct cgroup_file partition_file;
+
+	/* Invalid partiton error code, not lock protected */
+	enum prs_errcode prs_err;
 };
 
 /*
@@ -272,8 +293,13 @@ static inline int is_partition_root(const struct cpuset *cs)
 static inline void notify_partition_change(struct cpuset *cs,
 					   int old_prs, int new_prs)
 {
-	if (old_prs != new_prs)
-		cgroup_file_notify(&cs->partition_file);
+	if (old_prs == new_prs)
+		return;
+	cgroup_file_notify(&cs->partition_file);
+
+	/* Reset prs_err if not invalid */
+	if (new_prs != PRS_ERROR)
+		WRITE_ONCE(cs->prs_err, PERR_NONE);
 }
 
 static struct cpuset top_cpuset = {
@@ -1243,6 +1269,8 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 					      cpu_active_mask))
 				part_error = true;
 			cpumask_copy(tmp->addmask, parent->effective_cpus);
+			if ((READ_ONCE(cpuset->prs_err) == PERR_NONE) && part_error)
+				WRITE_ONCE(cpuset->prs_err, PERR_INVCPUS);
 		}
 	} else {
 		/*
@@ -1264,6 +1292,8 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 		part_error = (is_partition_root(cpuset) &&
 			      !parent->nr_subparts_cpus) ||
 			     cpumask_equal(tmp->addmask, parent->effective_cpus);
+		if (is_partition_root(cpuset) && part_error)
+			WRITE_ONCE(cpuset->prs_err, PERR_NOCPUS);
 	}
 
 	if (cmd == partcmd_update) {
@@ -1427,6 +1457,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp)
 				 * When parent is invalid, it has to be too.
 				 */
 				new_prs = PRS_ERROR;
+				WRITE_ONCE(cp->prs_err, PERR_PARENT);
 				break;
 			}
 		}
@@ -2541,6 +2572,7 @@ static s64 cpuset_read_s64(struct cgroup_subsys_state *css, struct cftype *cft)
 static int sched_partition_show(struct seq_file *seq, void *v)
 {
 	struct cpuset *cs = css_cs(seq_css(seq));
+	const char *err;
 
 	switch (cs->partition_root_state) {
 	case PRS_ENABLED:
@@ -2550,7 +2582,11 @@ static int sched_partition_show(struct seq_file *seq, void *v)
 		seq_puts(seq, "member\n");
 		break;
 	case PRS_ERROR:
-		seq_puts(seq, "root invalid\n");
+		err = perr_strings[READ_ONCE(cs->prs_err)];
+		if (err)
+			seq_printf(seq, "root invalid (%s)\n", err);
+		else
+			seq_puts(seq, "root invalid\n");
 		break;
 	}
 	return 0;
@@ -3150,6 +3186,10 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 			spin_lock_irq(&callback_lock);
 			cs->partition_root_state = PRS_ERROR;
 			spin_unlock_irq(&callback_lock);
+			if (parent->partition_root_state == PRS_ERROR)
+				WRITE_ONCE(cs->prs_err, PERR_PARENT);
+			else
+				WRITE_ONCE(cs->prs_err, PERR_HOTPLUG);
 			notify_partition_change(cs, old_prs, PRS_ERROR);
 		}
 		cpuset_force_rebuild();
-- 
2.18.1

