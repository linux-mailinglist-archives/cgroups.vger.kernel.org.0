Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261DA792733
	for <lists+cgroups@lfdr.de>; Tue,  5 Sep 2023 18:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235073AbjIEQWE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 5 Sep 2023 12:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354684AbjIENeX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 5 Sep 2023 09:34:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDF41B7
        for <cgroups@vger.kernel.org>; Tue,  5 Sep 2023 06:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693920777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=78UWFuQVG4QBSgVcKbAwAJgCrrqt7rMnHw1/4UxcXhg=;
        b=TgLhsAJ7K3v7FUUljhBdHHBKj5aHG9Vz3a3Km5UhZ8rlX11+cBM2FM4OnBBQMOsAW11n9N
        aPIwpujenP4P0UnkpWOArCbT+xNz43OM17xmsBmPUIqYxAE2njP2+g+SawDoKPhSOQiSGe
        nMikDDSIHKhNZGk0fnnonPvrl6GKlAw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-Qxu_vkBIMfSvfnd9_TTKpg-1; Tue, 05 Sep 2023 09:32:54 -0400
X-MC-Unique: Qxu_vkBIMfSvfnd9_TTKpg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CBDDE970404;
        Tue,  5 Sep 2023 13:32:52 +0000 (UTC)
Received: from llong.com (unknown [10.22.9.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3D0DC21D4F3F;
        Tue,  5 Sep 2023 13:32:52 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christian Brauner <brauner@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v8 3/7] cgroup/cpuset: Add cpuset.cpus.exclusive for v2
Date:   Tue,  5 Sep 2023 09:32:39 -0400
Message-Id: <20230905133243.91107-4-longman@redhat.com>
In-Reply-To: <20230905133243.91107-1-longman@redhat.com>
References: <20230905133243.91107-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This patch introduces a new writable "cpuset.cpus.exclusive" control
file for v2 which will be added to non-root cpuset enabled cgroups. This new
file enables user to set a smaller list of exclusive CPUs to be used in
the creation of a cpuset partition.

The value written to "cpuset.cpus.exclusive" may not be the effective
value being used for the creation of cpuset partition, the effective
value will show up in "cpuset.cpus.exclusive.effective" and it is
subject to the constraint that it must also be a subset of cpus_allowed
and parent's "cpuset.cpus.exclusive.effective".

By writing to "cpuset.cpus.exclusive", "cpuset.cpus.exclusive.effective"
may be set to a non-empty value even for cgroups that are not valid
partition roots yet.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 273 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 239 insertions(+), 34 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index b269c6b79e1a..0419654f3004 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -134,6 +134,11 @@ struct cpuset {
 	 */
 	cpumask_var_t effective_xcpus;
 
+	/*
+	 * Exclusive CPUs as requested by the user (default hierarchy only)
+	 */
+	cpumask_var_t exclusive_cpus;
+
 	/*
 	 * This is old Memory Nodes tasks took on.
 	 *
@@ -605,16 +610,18 @@ static int is_cpuset_subset(const struct cpuset *p, const struct cpuset *q)
  */
 static inline int alloc_cpumasks(struct cpuset *cs, struct tmpmasks *tmp)
 {
-	cpumask_var_t *pmask1, *pmask2, *pmask3;
+	cpumask_var_t *pmask1, *pmask2, *pmask3, *pmask4;
 
 	if (cs) {
 		pmask1 = &cs->cpus_allowed;
 		pmask2 = &cs->effective_cpus;
 		pmask3 = &cs->effective_xcpus;
+		pmask4 = &cs->exclusive_cpus;
 	} else {
 		pmask1 = &tmp->new_cpus;
 		pmask2 = &tmp->addmask;
 		pmask3 = &tmp->delmask;
+		pmask4 = NULL;
 	}
 
 	if (!zalloc_cpumask_var(pmask1, GFP_KERNEL))
@@ -626,8 +633,14 @@ static inline int alloc_cpumasks(struct cpuset *cs, struct tmpmasks *tmp)
 	if (!zalloc_cpumask_var(pmask3, GFP_KERNEL))
 		goto free_two;
 
+	if (pmask4 && !zalloc_cpumask_var(pmask4, GFP_KERNEL))
+		goto free_three;
+
+
 	return 0;
 
+free_three:
+	free_cpumask_var(*pmask3);
 free_two:
 	free_cpumask_var(*pmask2);
 free_one:
@@ -646,6 +659,7 @@ static inline void free_cpumasks(struct cpuset *cs, struct tmpmasks *tmp)
 		free_cpumask_var(cs->cpus_allowed);
 		free_cpumask_var(cs->effective_cpus);
 		free_cpumask_var(cs->effective_xcpus);
+		free_cpumask_var(cs->exclusive_cpus);
 	}
 	if (tmp) {
 		free_cpumask_var(tmp->new_cpus);
@@ -674,6 +688,7 @@ static struct cpuset *alloc_trial_cpuset(struct cpuset *cs)
 	cpumask_copy(trial->cpus_allowed, cs->cpus_allowed);
 	cpumask_copy(trial->effective_cpus, cs->effective_cpus);
 	cpumask_copy(trial->effective_xcpus, cs->effective_xcpus);
+	cpumask_copy(trial->exclusive_cpus, cs->exclusive_cpus);
 	return trial;
 }
 
@@ -687,6 +702,13 @@ static inline void free_cpuset(struct cpuset *cs)
 	kfree(cs);
 }
 
+static inline struct cpumask *fetch_xcpus(struct cpuset *cs)
+{
+	return !cpumask_empty(cs->exclusive_cpus) ? cs->exclusive_cpus :
+	       cpumask_empty(cs->effective_xcpus) ? cs->cpus_allowed
+						  : cs->effective_xcpus;
+}
+
 /*
  * cpu_exclusive_check() - check if two cpusets are exclusive
  *
@@ -694,14 +716,10 @@ static inline void free_cpuset(struct cpuset *cs)
  */
 static inline bool cpu_exclusive_check(struct cpuset *cs1, struct cpuset *cs2)
 {
-	struct cpumask *cpus1, *cpus2;
+	struct cpumask *xcpus1 = fetch_xcpus(cs1);
+	struct cpumask *xcpus2 = fetch_xcpus(cs2);
 
-	cpus1 = cpumask_empty(cs1->effective_xcpus)
-		? cs1->cpus_allowed : cs1->effective_xcpus;
-	cpus2 = cpumask_empty(cs2->effective_xcpus)
-		? cs2->cpus_allowed : cs2->effective_xcpus;
-
-	if (cpumask_intersects(cpus1, cpus2))
+	if (cpumask_intersects(xcpus1, xcpus2))
 		return -EINVAL;
 	return 0;
 }
@@ -1368,6 +1386,54 @@ static bool tasks_nocpu_error(struct cpuset *parent, struct cpuset *cs,
 		partition_is_populated(cs, NULL));
 }
 
+static void reset_partition_data(struct cpuset *cs)
+{
+	struct cpuset *parent = parent_cs(cs);
+
+	if (!cgroup_subsys_on_dfl(cpuset_cgrp_subsys))
+		return;
+
+	lockdep_assert_held(&callback_lock);
+
+	cs->nr_subparts = 0;
+	if (cpumask_empty(cs->exclusive_cpus)) {
+		cpumask_clear(cs->effective_xcpus);
+		if (is_cpu_exclusive(cs))
+			clear_bit(CS_CPU_EXCLUSIVE, &cs->flags);
+	}
+	if (!cpumask_and(cs->effective_cpus,
+			 parent->effective_cpus, cs->cpus_allowed)) {
+		cs->use_parent_ecpus = true;
+		parent->child_ecpus_count++;
+		cpumask_copy(cs->effective_cpus, parent->effective_cpus);
+	}
+}
+
+/*
+ * compute_effective_exclusive_cpumask - compute effective exclusive CPUs
+ * @cs: cpuset
+ * @xcpus: effective exclusive CPUs value to be set
+ * Return: true if xcpus is not empty, false otherwise.
+ *
+ * Starting with exclusive_cpus (cpus_allowed if exclusive_cpus is not set),
+ * it must be a subset of cpus_allowed and parent's effective_xcpus.
+ */
+static bool compute_effective_exclusive_cpumask(struct cpuset *cs,
+						struct cpumask *xcpus)
+{
+	struct cpuset *parent = parent_cs(cs);
+
+	if (!xcpus)
+		xcpus = cs->effective_xcpus;
+
+	if (!cpumask_empty(cs->exclusive_cpus))
+		cpumask_and(xcpus, cs->exclusive_cpus, cs->cpus_allowed);
+	else
+		cpumask_copy(xcpus, cs->cpus_allowed);
+
+	return cpumask_and(xcpus, xcpus, parent->effective_xcpus);
+}
+
 /**
  * update_parent_effective_cpumask - update effective_cpus mask of parent cpuset
  * @cs:      The cpuset that requests change in partition root state
@@ -1426,7 +1492,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 	 */
 	adding = deleting = false;
 	old_prs = new_prs = cs->partition_root_state;
-	xcpus = !cpumask_empty(cs->effective_xcpus)
+	xcpus = !cpumask_empty(cs->exclusive_cpus)
 		? cs->effective_xcpus : cs->cpus_allowed;
 
 	if (cmd == partcmd_invalidate) {
@@ -1659,8 +1725,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 
 	if (adding || deleting) {
 		update_tasks_cpumask(parent, tmp->addmask);
-		if (parent->child_ecpus_count)
-			update_sibling_cpumasks(parent, cs, tmp);
+		update_sibling_cpumasks(parent, cs, tmp);
 	}
 
 	/*
@@ -1709,7 +1774,9 @@ static void compute_partition_effective_cpumask(struct cpuset *cs,
 	 *  2) All the effective_cpus will be used up and cp
 	 *     has tasks
 	 */
-	cpumask_and(new_ecpus, cs->effective_xcpus, cpu_active_mask);
+	compute_effective_exclusive_cpumask(cs, new_ecpus);
+	cpumask_and(new_ecpus, new_ecpus, cpu_active_mask);
+
 	rcu_read_lock();
 	cpuset_for_each_child(child, css, cs) {
 		if (!is_partition_valid(child))
@@ -1777,6 +1844,16 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 
 		compute_effective_cpumask(tmp->new_cpus, cp, parent);
 
+		/*
+		 * Update effective_xcpus if exclusive_cpus set.
+		 * The case when exclusive_cpus isn't set is handled later.
+		 */
+		if (!cpumask_empty(cp->exclusive_cpus) && (cp != cs)) {
+			spin_lock_irq(&callback_lock);
+			compute_effective_exclusive_cpumask(cp, NULL);
+			spin_unlock_irq(&callback_lock);
+		}
+
 		if (is_partition_valid(parent) && is_partition_valid(cp))
 			compute_partition_effective_cpumask(cp, tmp->new_cpus);
 
@@ -1869,7 +1946,11 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 		spin_lock_irq(&callback_lock);
 		cpumask_copy(cp->effective_cpus, tmp->new_cpus);
 		cp->partition_root_state = new_prs;
-		if ((new_prs > 0) && cpumask_empty(cp->effective_xcpus))
+		/*
+		 * Make sure effective_xcpus is properly set for a valid
+		 * partition root.
+		 */
+		if ((new_prs > 0) && cpumask_empty(cp->exclusive_cpus))
 			cpumask_and(cp->effective_xcpus,
 				    cp->cpus_allowed, parent->effective_xcpus);
 		if (new_prs < 0) {
@@ -1886,7 +1967,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 		WARN_ON(!is_in_v2_mode() &&
 			!cpumask_equal(cp->cpus_allowed, cp->effective_cpus));
 
-		update_tasks_cpumask(cp, tmp->new_cpus);
+		update_tasks_cpumask(cp, cp->effective_cpus);
 
 		/*
 		 * On default hierarchy, inherit the CS_SCHED_LOAD_BALANCE
@@ -1939,8 +2020,13 @@ static void update_sibling_cpumasks(struct cpuset *parent, struct cpuset *cs,
 
 	/*
 	 * Check all its siblings and call update_cpumasks_hier()
-	 * if their use_parent_ecpus flag is set in order for them
-	 * to use the right effective_cpus value.
+	 * if their effective_cpus will need to be changed.
+	 *
+	 * With the addition of effective_xcpus which is a subset of
+	 * cpus_allowed. It is possible a change in parent's effective_cpus
+	 * due to a change in a child partition's effective_xcpus will impact
+	 * its siblings even if they do not inherit parent's effective_cpus
+	 * directly.
 	 *
 	 * The update_cpumasks_hier() function may sleep. So we have to
 	 * release the RCU read lock before calling it. HIER_NO_SD_REBUILD
@@ -1951,8 +2037,13 @@ static void update_sibling_cpumasks(struct cpuset *parent, struct cpuset *cs,
 	cpuset_for_each_child(sibling, pos_css, parent) {
 		if (sibling == cs)
 			continue;
-		if (!sibling->use_parent_ecpus)
-			continue;
+		if (!sibling->use_parent_ecpus &&
+		    !is_partition_valid(sibling)) {
+			compute_effective_cpumask(tmp->new_cpus, sibling,
+						  parent);
+			if (cpumask_equal(tmp->new_cpus, sibling->effective_cpus))
+				continue;
+		}
 		if (!css_tryget_online(&sibling->css))
 			continue;
 
@@ -1977,6 +2068,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	struct tmpmasks tmp;
 	struct cpuset *parent = parent_cs(cs);
 	bool invalidate = false;
+	int hier_flags = 0;
 	int old_prs = cs->partition_root_state;
 
 	/* top_cpuset.cpus_allowed tracks cpu_online_mask; it's read-only */
@@ -2002,11 +2094,13 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 			return -EINVAL;
 
 		/*
-		 * When effective_xcpus is set, make sure it is a subset of
-		 * cpus_allowed and parent's effective_xcpus.
+		 * When exclusive_cpus isn't explicitly set, it is constrainted
+		 * by cpus_allowed and parent's effective_xcpus. Otherwise,
+		 * trialcs->effective_xcpus is used as a temporary cpumask
+		 * for checking validity of the partition root.
 		 */
-		cpumask_and(trialcs->effective_xcpus,
-			    parent->effective_xcpus, trialcs->cpus_allowed);
+		if (!cpumask_empty(trialcs->exclusive_cpus) || is_partition_valid(cs))
+			compute_effective_exclusive_cpumask(trialcs, NULL);
 	}
 
 	/* Nothing to do if the cpus didn't change */
@@ -2026,6 +2120,13 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 		}
 	}
 
+	/*
+	 * Check all the descendants in update_cpumasks_hier() if
+	 * effective_xcpus is to be changed.
+	 */
+	if (!cpumask_equal(cs->effective_xcpus, trialcs->effective_xcpus))
+		hier_flags = HIER_CHECKALL;
+
 	retval = validate_change(cs, trialcs);
 
 	if ((retval == -EINVAL) && cgroup_subsys_on_dfl(cpuset_cgrp_subsys)) {
@@ -2055,7 +2156,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	if (retval < 0)
 		goto out_free;
 
-	if (cs->partition_root_state) {
+	if (is_partition_valid(cs)) {
 		if (invalidate)
 			update_parent_effective_cpumask(cs, partcmd_invalidate,
 							NULL, &tmp);
@@ -2066,15 +2167,13 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 
 	spin_lock_irq(&callback_lock);
 	cpumask_copy(cs->cpus_allowed, trialcs->cpus_allowed);
-	if (!is_partition_valid(cs))
-		cpumask_clear(cs->effective_xcpus);
-	else
-		cpumask_copy(cs->effective_xcpus, trialcs->effective_xcpus);
-
+	cpumask_copy(cs->effective_xcpus, trialcs->effective_xcpus);
+	if ((old_prs > 0) && !is_partition_valid(cs))
+		reset_partition_data(cs);
 	spin_unlock_irq(&callback_lock);
 
-	/* effective_cpus will be updated here */
-	update_cpumasks_hier(cs, &tmp, 0);
+	/* effective_cpus/effective_xcpus will be updated here */
+	update_cpumasks_hier(cs, &tmp, hier_flags);
 
 	/* Update CS_SCHED_LOAD_BALANCE and/or sched_domains, if necessary */
 	if (cs->partition_root_state)
@@ -2084,6 +2183,94 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	return 0;
 }
 
+/**
+ * update_exclusive_cpumask - update the exclusive_cpus mask of a cpuset
+ * @cs: the cpuset to consider
+ * @trialcs: trial cpuset
+ * @buf: buffer of cpu numbers written to this cpuset
+ *
+ * The tasks' cpumask will be updated if cs is a valid partition root.
+ */
+static int update_exclusive_cpumask(struct cpuset *cs, struct cpuset *trialcs,
+				    const char *buf)
+{
+	int retval;
+	struct tmpmasks tmp;
+	struct cpuset *parent = parent_cs(cs);
+	bool invalidate = false;
+	int hier_flags = 0;
+	int old_prs = cs->partition_root_state;
+
+	if (!*buf) {
+		cpumask_clear(trialcs->exclusive_cpus);
+	} else {
+		retval = cpulist_parse(buf, trialcs->exclusive_cpus);
+		if (retval < 0)
+			return retval;
+		if (!is_cpu_exclusive(cs))
+			set_bit(CS_CPU_EXCLUSIVE, &trialcs->flags);
+	}
+
+	/* Nothing to do if the CPUs didn't change */
+	if (cpumask_equal(cs->exclusive_cpus, trialcs->exclusive_cpus))
+		return 0;
+
+	if (alloc_cpumasks(NULL, &tmp))
+		return -ENOMEM;
+
+	compute_effective_exclusive_cpumask(trialcs, NULL);
+
+	/*
+	 * Check all the descendants in update_cpumasks_hier() if
+	 * effective_xcpus is to be changed.
+	 */
+	if (!cpumask_equal(cs->effective_xcpus, trialcs->effective_xcpus))
+		hier_flags = HIER_CHECKALL;
+
+	retval = validate_change(cs, trialcs);
+	if (retval)
+		return retval;
+
+	if (is_partition_valid(cs)) {
+		if (cpumask_empty(trialcs->effective_xcpus)) {
+			invalidate = true;
+			cs->prs_err = PERR_INVCPUS;
+		} else if (tasks_nocpu_error(parent, cs, trialcs->effective_xcpus)) {
+			invalidate = true;
+			cs->prs_err = PERR_NOCPUS;
+		}
+
+		if (invalidate)
+			update_parent_effective_cpumask(cs, partcmd_invalidate,
+							NULL, &tmp);
+		else
+			update_parent_effective_cpumask(cs, partcmd_update,
+						trialcs->effective_xcpus, &tmp);
+	}
+
+	spin_lock_irq(&callback_lock);
+	cpumask_copy(cs->exclusive_cpus, trialcs->exclusive_cpus);
+	cpumask_copy(cs->effective_xcpus, trialcs->effective_xcpus);
+	if ((old_prs > 0) && !is_partition_valid(cs))
+		reset_partition_data(cs);
+	spin_unlock_irq(&callback_lock);
+
+	/*
+	 * Call update_cpumasks_hier() to update effective_cpus/effective_xcpus
+	 * of the subtree when it is a valid partition root or effective_xcpus
+	 * is updated.
+	 */
+	if (is_partition_valid(cs) || hier_flags)
+		update_cpumasks_hier(cs, &tmp, hier_flags);
+
+	/* Update CS_SCHED_LOAD_BALANCE and/or sched_domains, if necessary */
+	if (cs->partition_root_state)
+		update_partition_sd_lb(cs, old_prs);
+
+	free_cpumasks(NULL, &tmp);
+	return 0;
+}
+
 /*
  * Migrate memory region from one set of nodes to another.  This is
  * performed asynchronously as it can be called from process migration path
@@ -2474,10 +2661,10 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 		return -ENOMEM;
 
 	/*
-	 * Setup effective_xcpus if not set yet, it will be cleared later
-	 * if partition becomes invalid.
+	 * Setup effective_xcpus if not properly set yet, it will be cleared
+	 * later if partition becomes invalid.
 	 */
-	if ((new_prs > 0) && cpumask_empty(cs->effective_xcpus)) {
+	if ((new_prs > 0) && cpumask_empty(cs->exclusive_cpus)) {
 		struct cpuset *parent = parent_cs(cs);
 
 		spin_lock_irq(&callback_lock);
@@ -2533,7 +2720,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	cs->partition_root_state = new_prs;
 	WRITE_ONCE(cs->prs_err, err);
 	if (!is_partition_valid(cs))
-		cpumask_clear(cs->effective_xcpus);
+		reset_partition_data(cs);
 	spin_unlock_irq(&callback_lock);
 
 	/* Force update if switching back to member */
@@ -2889,6 +3076,7 @@ typedef enum {
 	FILE_EFFECTIVE_CPULIST,
 	FILE_EFFECTIVE_MEMLIST,
 	FILE_SUBPARTS_CPULIST,
+	FILE_EXCLUSIVE_CPULIST,
 	FILE_EFFECTIVE_XCPULIST,
 	FILE_CPU_EXCLUSIVE,
 	FILE_MEM_EXCLUSIVE,
@@ -3027,6 +3215,9 @@ static ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 	case FILE_CPULIST:
 		retval = update_cpumask(cs, trialcs, buf);
 		break;
+	case FILE_EXCLUSIVE_CPULIST:
+		retval = update_exclusive_cpumask(cs, trialcs, buf);
+		break;
 	case FILE_MEMLIST:
 		retval = update_nodemask(cs, trialcs, buf);
 		break;
@@ -3074,6 +3265,9 @@ static int cpuset_common_seq_show(struct seq_file *sf, void *v)
 	case FILE_EFFECTIVE_MEMLIST:
 		seq_printf(sf, "%*pbl\n", nodemask_pr_args(&cs->effective_mems));
 		break;
+	case FILE_EXCLUSIVE_CPULIST:
+		seq_printf(sf, "%*pbl\n", cpumask_pr_args(cs->exclusive_cpus));
+		break;
 	case FILE_EFFECTIVE_XCPULIST:
 		seq_printf(sf, "%*pbl\n", cpumask_pr_args(cs->effective_xcpus));
 		break;
@@ -3350,6 +3544,15 @@ static struct cftype dfl_files[] = {
 		.file_offset = offsetof(struct cpuset, partition_file),
 	},
 
+	{
+		.name = "cpus.exclusive",
+		.seq_show = cpuset_common_seq_show,
+		.write = cpuset_write_resmask,
+		.max_write_len = (100U + 6 * NR_CPUS),
+		.private = FILE_EXCLUSIVE_CPULIST,
+		.flags = CFTYPE_NOT_ON_ROOT,
+	},
+
 	{
 		.name = "cpus.exclusive.effective",
 		.seq_show = cpuset_common_seq_show,
@@ -3675,12 +3878,14 @@ int __init cpuset_init(void)
 	BUG_ON(!alloc_cpumask_var(&top_cpuset.cpus_allowed, GFP_KERNEL));
 	BUG_ON(!alloc_cpumask_var(&top_cpuset.effective_cpus, GFP_KERNEL));
 	BUG_ON(!alloc_cpumask_var(&top_cpuset.effective_xcpus, GFP_KERNEL));
+	BUG_ON(!alloc_cpumask_var(&top_cpuset.exclusive_cpus, GFP_KERNEL));
 	BUG_ON(!zalloc_cpumask_var(&subpartitions_cpus, GFP_KERNEL));
 
 	cpumask_setall(top_cpuset.cpus_allowed);
 	nodes_setall(top_cpuset.mems_allowed);
 	cpumask_setall(top_cpuset.effective_cpus);
 	cpumask_setall(top_cpuset.effective_xcpus);
+	cpumask_setall(top_cpuset.exclusive_cpus);
 	nodes_setall(top_cpuset.effective_mems);
 
 	fmeter_init(&top_cpuset.fmeter);
-- 
2.31.1

