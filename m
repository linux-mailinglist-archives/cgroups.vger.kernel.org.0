Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31BA379278F
	for <lists+cgroups@lfdr.de>; Tue,  5 Sep 2023 18:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349432AbjIEQVx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 5 Sep 2023 12:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354687AbjIENeY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 5 Sep 2023 09:34:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A4E1AE
        for <cgroups@vger.kernel.org>; Tue,  5 Sep 2023 06:32:58 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-VpvDTAJfOfOrFmV2vtJSXQ-1; Tue, 05 Sep 2023 09:32:55 -0400
X-MC-Unique: VpvDTAJfOfOrFmV2vtJSXQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 713188164F4;
        Tue,  5 Sep 2023 13:32:53 +0000 (UTC)
Received: from llong.com (unknown [10.22.9.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DB615202869C;
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
Subject: [PATCH v8 4/7] cgroup/cpuset: Introduce remote partition
Date:   Tue,  5 Sep 2023 09:32:40 -0400
Message-Id: <20230905133243.91107-5-longman@redhat.com>
In-Reply-To: <20230905133243.91107-1-longman@redhat.com>
References: <20230905133243.91107-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

One can use "cpuset.cpus.partition" to create multiple scheduling domains
or to produce a set of isolated CPUs where load balancing is disabled.
The former use case is less common but the latter one can be frequently
used especially for the Telco use cases like DPDK.

The existing "isolated" partition can be used to produce isolated
CPUs if the applications have full control of a system. However, in a
containerized environment where all the apps are run in a container,
it is hard to distribute out isolated CPUs from the root down given
the unified hierarchy nature of cgroup v2.

The container running on isolated CPUs can be several layers down from
the root. The current partition feature requires that all the ancestors
of a leaf partition root must be parititon roots themselves. This can
be hard to configure.

This patch introduces a new type of partition called remote partition.
A remote partition is a partition whose parent is not a partition root
itself and its CPUs are acquired directly from available CPUs in the
top cpuset through a hierachical distribution of exclusive CPUs down
from it.

By contrast, the existing type of partitions where their parents have
to be valid partition roots are referred to as local partitions as they
have to be clustered around a parent partition root.

Child local partitons can be created under a remote partition, but
a remote partition cannot be created under a local partition. We may
relax this limitation in the future if there are use cases for such
configuration.

Manually writing to the "cpuset.cpus.exclusive" file is not necessary
when creating local partitions.  However, writing proper values to
"cpuset.cpus.exclusive" down the cgroup hierarchy before the target
remote partition root is mandatory for the creation of a remote
partition.

The value in "cpuset.cpus.exclusive.effective" may change if its
"cpuset.cpus" or its parent's "cpuset.cpus.exclusive.effective" changes.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 335 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 306 insertions(+), 29 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 0419654f3004..7ac320e079b8 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -192,6 +192,9 @@ struct cpuset {
 
 	/* Handle for cpuset.cpus.partition */
 	struct cgroup_file partition_file;
+
+	/* Remote partition silbling list anchored at remote_children */
+	struct list_head remote_sibling;
 };
 
 /*
@@ -199,6 +202,9 @@ struct cpuset {
  */
 static cpumask_var_t	subpartitions_cpus;
 
+/* List of remote partition root children */
+static struct list_head remote_children;
+
 /*
  * Partition root states:
  *
@@ -348,6 +354,7 @@ static struct cpuset top_cpuset = {
 	.flags = ((1 << CS_ONLINE) | (1 << CS_CPU_EXCLUSIVE) |
 		  (1 << CS_MEM_EXCLUSIVE)),
 	.partition_root_state = PRS_ROOT,
+	.remote_sibling = LIST_HEAD_INIT(top_cpuset.remote_sibling),
 };
 
 /**
@@ -1434,6 +1441,211 @@ static bool compute_effective_exclusive_cpumask(struct cpuset *cs,
 	return cpumask_and(xcpus, xcpus, parent->effective_xcpus);
 }
 
+static inline bool is_remote_partition(struct cpuset *cs)
+{
+	return !list_empty(&cs->remote_sibling);
+}
+
+static inline bool is_local_partition(struct cpuset *cs)
+{
+	return is_partition_valid(cs) && !is_remote_partition(cs);
+}
+
+/*
+ * remote_partition_enable - Enable current cpuset as a remote partition root
+ * @cs: the cpuset to update
+ * @tmp: temparary masks
+ * Return: 1 if successful, 0 if error
+ *
+ * Enable the current cpuset to become a remote partition root taking CPUs
+ * directly from the top cpuset. cpuset_mutex must be held by the caller.
+ */
+static int remote_partition_enable(struct cpuset *cs, struct tmpmasks *tmp)
+{
+	/*
+	 * The user must have sysadmin privilege.
+	 */
+	if (!capable(CAP_SYS_ADMIN))
+		return 0;
+
+	/*
+	 * The requested exclusive_cpus must not be allocated to other
+	 * partitions and it can't use up all the root's effective_cpus.
+	 *
+	 * Note that if there is any local partition root above it or
+	 * remote partition root underneath it, its exclusive_cpus must
+	 * have overlapped with subpartitions_cpus.
+	 */
+	compute_effective_exclusive_cpumask(cs, tmp->new_cpus);
+	if (cpumask_empty(tmp->new_cpus) ||
+	    cpumask_intersects(tmp->new_cpus, subpartitions_cpus) ||
+	    cpumask_subset(top_cpuset.effective_cpus, tmp->new_cpus))
+		return 0;
+
+	spin_lock_irq(&callback_lock);
+	cpumask_andnot(top_cpuset.effective_cpus,
+		       top_cpuset.effective_cpus, tmp->new_cpus);
+	cpumask_or(subpartitions_cpus,
+		   subpartitions_cpus, tmp->new_cpus);
+
+	if (cs->use_parent_ecpus) {
+		struct cpuset *parent = parent_cs(cs);
+
+		cs->use_parent_ecpus = false;
+		parent->child_ecpus_count--;
+	}
+	list_add(&cs->remote_sibling, &remote_children);
+	spin_unlock_irq(&callback_lock);
+
+	/*
+	 * Proprogate changes in top_cpuset's effective_cpus down the hierarchy.
+	 */
+	update_tasks_cpumask(&top_cpuset, tmp->new_cpus);
+	update_sibling_cpumasks(&top_cpuset, NULL, tmp);
+
+	return 1;
+}
+
+/*
+ * remote_partition_disable - Remove current cpuset from remote partition list
+ * @cs: the cpuset to update
+ * @tmp: temparary masks
+ *
+ * The effective_cpus is also updated.
+ *
+ * cpuset_mutex must be held by the caller.
+ */
+static void remote_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
+{
+	compute_effective_exclusive_cpumask(cs, tmp->new_cpus);
+	WARN_ON_ONCE(!is_remote_partition(cs));
+	WARN_ON_ONCE(!cpumask_subset(tmp->new_cpus, subpartitions_cpus));
+
+	spin_lock_irq(&callback_lock);
+	cpumask_andnot(subpartitions_cpus,
+		       subpartitions_cpus, tmp->new_cpus);
+	cpumask_and(tmp->new_cpus,
+		    tmp->new_cpus, cpu_active_mask);
+	cpumask_or(top_cpuset.effective_cpus,
+		   top_cpuset.effective_cpus, tmp->new_cpus);
+	list_del_init(&cs->remote_sibling);
+	cs->partition_root_state = -cs->partition_root_state;
+	if (!cs->prs_err)
+		cs->prs_err = PERR_INVCPUS;
+	reset_partition_data(cs);
+	spin_unlock_irq(&callback_lock);
+
+	/*
+	 * Proprogate changes in top_cpuset's effective_cpus down the hierarchy.
+	 */
+	update_tasks_cpumask(&top_cpuset, tmp->new_cpus);
+	update_sibling_cpumasks(&top_cpuset, NULL, tmp);
+}
+
+/*
+ * remote_cpus_update - cpus_exclusive change of remote partition
+ * @cs: the cpuset to be updated
+ * @newmask: the new effective_xcpus mask
+ * @tmp: temparary masks
+ *
+ * top_cpuset and subpartitions_cpus will be updated or partition can be
+ * invalidated.
+ */
+static void remote_cpus_update(struct cpuset *cs, struct cpumask *newmask,
+			       struct tmpmasks *tmp)
+{
+	bool adding, deleting;
+
+	if (WARN_ON_ONCE(!is_remote_partition(cs)))
+		return;
+
+	WARN_ON_ONCE(!cpumask_subset(cs->effective_xcpus, subpartitions_cpus));
+
+	if (cpumask_empty(newmask))
+		goto invalidate;
+
+	adding   = cpumask_andnot(tmp->addmask, newmask, cs->effective_xcpus);
+	deleting = cpumask_andnot(tmp->delmask, cs->effective_xcpus, newmask);
+
+	/*
+	 * Additions of remote CPUs is only allowed if those CPUs are
+	 * not allocated to other partitions and there are effective_cpus
+	 * left in the top cpuset.
+	 */
+	if (adding && (!capable(CAP_SYS_ADMIN) ||
+		       cpumask_intersects(tmp->addmask, subpartitions_cpus) ||
+		       cpumask_subset(top_cpuset.effective_cpus, tmp->addmask)))
+		goto invalidate;
+
+	spin_lock_irq(&callback_lock);
+	if (adding) {
+		cpumask_or(subpartitions_cpus,
+			   subpartitions_cpus, tmp->addmask);
+		cpumask_andnot(top_cpuset.effective_cpus,
+			       top_cpuset.effective_cpus, tmp->addmask);
+	}
+	if (deleting) {
+		cpumask_andnot(subpartitions_cpus,
+			       subpartitions_cpus, tmp->delmask);
+		cpumask_and(tmp->delmask,
+			    tmp->delmask, cpu_active_mask);
+		cpumask_or(top_cpuset.effective_cpus,
+			   top_cpuset.effective_cpus, tmp->delmask);
+	}
+	spin_unlock_irq(&callback_lock);
+
+	/*
+	 * Proprogate changes in top_cpuset's effective_cpus down the hierarchy.
+	 */
+	update_tasks_cpumask(&top_cpuset, tmp->new_cpus);
+	update_sibling_cpumasks(&top_cpuset, NULL, tmp);
+	return;
+
+invalidate:
+	remote_partition_disable(cs, tmp);
+}
+
+/*
+ * remote_partition_check - check if a child remote partition needs update
+ * @cs: the cpuset to be updated
+ * @newmask: the new effective_xcpus mask
+ * @delmask: temporary mask for deletion (not in tmp)
+ * @tmp: temparary masks
+ *
+ * This should be called before the given cs has updated its cpus_allowed
+ * and/or effective_xcpus.
+ */
+static void remote_partition_check(struct cpuset *cs, struct cpumask *newmask,
+				   struct cpumask *delmask, struct tmpmasks *tmp)
+{
+	struct cpuset *child, *next;
+	int disable_cnt = 0;
+
+	/*
+	 * Compute the effective exclusive CPUs that will be deleted.
+	 */
+	if (!cpumask_andnot(delmask, cs->effective_xcpus, newmask) ||
+	    !cpumask_intersects(delmask, subpartitions_cpus))
+		return;	/* No deletion of exclusive CPUs in partitions */
+
+	/*
+	 * Searching the remote children list to look for those that will
+	 * be impacted by the deletion of exclusive CPUs.
+	 *
+	 * Since a cpuset must be removed from the remote children list
+	 * before it can go offline and holding cpuset_mutex will prevent
+	 * any change in cpuset status. RCU read lock isn't needed.
+	 */
+	lockdep_assert_held(&cpuset_mutex);
+	list_for_each_entry_safe(child, next, &remote_children, remote_sibling)
+		if (cpumask_intersects(child->effective_cpus, delmask)) {
+			remote_partition_disable(child, tmp);
+			disable_cnt++;
+		}
+	if (disable_cnt)
+		rebuild_sched_domains_locked();
+}
+
 /**
  * update_parent_effective_cpumask - update effective_cpus mask of parent cpuset
  * @cs:      The cpuset that requests change in partition root state
@@ -1548,7 +1760,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 		subparts_delta++;
 	} else if (cmd == partcmd_disable) {
 		/*
-		 n* May need to add cpus to parent's effective_cpus for
+		 * May need to add cpus to parent's effective_cpus for
 		 * valid partition root.
 		 */
 		adding = !is_prs_invalid(old_prs) &&
@@ -1749,7 +1961,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
  * @new_ecpus: previously computed effective_cpus to be updated
  *
  * Compute the effective_cpus of a partition root by scanning effective_xcpus
- * of child partition roots and exclusing their effective_xcpus.
+ * of child partition roots and excluding their effective_xcpus.
  *
  * This has the side effect of invalidating valid child partition roots,
  * if necessary. Since it is called from either cpuset_hotplug_update_tasks()
@@ -1840,9 +2052,17 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 	rcu_read_lock();
 	cpuset_for_each_descendant_pre(cp, pos_css, cs) {
 		struct cpuset *parent = parent_cs(cp);
+		bool remote = is_remote_partition(cp);
 		bool update_parent = false;
 
-		compute_effective_cpumask(tmp->new_cpus, cp, parent);
+		/*
+		 * Skip descendent remote partition that acquires CPUs
+		 * directly from top cpuset unless it is cs.
+		 */
+		if (remote && (cp != cs)) {
+			pos_css = css_rightmost_descendant(pos_css);
+			continue;
+		}
 
 		/*
 		 * Update effective_xcpus if exclusive_cpus set.
@@ -1854,8 +2074,12 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 			spin_unlock_irq(&callback_lock);
 		}
 
-		if (is_partition_valid(parent) && is_partition_valid(cp))
+		old_prs = new_prs = cp->partition_root_state;
+		if (remote || (is_partition_valid(parent) &&
+			       is_partition_valid(cp)))
 			compute_partition_effective_cpumask(cp, tmp->new_cpus);
+		else
+			compute_effective_cpumask(tmp->new_cpus, cp, parent);
 
 		/*
 		 * A partition with no effective_cpus is allowed as long as
@@ -1873,7 +2097,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 		 * it is a partition root that has explicitly distributed
 		 * out all its CPUs.
 		 */
-		if (is_in_v2_mode() && cpumask_empty(tmp->new_cpus)) {
+		if (is_in_v2_mode() && !remote && cpumask_empty(tmp->new_cpus)) {
 			cpumask_copy(tmp->new_cpus, parent->effective_cpus);
 			if (!cp->use_parent_ecpus) {
 				cp->use_parent_ecpus = true;
@@ -1885,6 +2109,9 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 			parent->child_ecpus_count--;
 		}
 
+		if (remote)
+			goto get_css;
+
 		/*
 		 * Skip the whole subtree if
 		 * 1) the cpumask remains the same,
@@ -1907,7 +2134,6 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 		 * update_tasks_cpumask() again for tasks in the parent
 		 * cpuset if the parent's effective_cpus changes.
 		 */
-		old_prs = new_prs = cp->partition_root_state;
 		if ((cp != cs) && old_prs) {
 			switch (parent->partition_root_state) {
 			case PRS_ROOT:
@@ -1929,7 +2155,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 				break;
 			}
 		}
-
+get_css:
 		if (!css_tryget_online(&cp->css))
 			continue;
 		rcu_read_unlock();
@@ -1953,13 +2179,8 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 		if ((new_prs > 0) && cpumask_empty(cp->exclusive_cpus))
 			cpumask_and(cp->effective_xcpus,
 				    cp->cpus_allowed, parent->effective_xcpus);
-		if (new_prs < 0) {
-			/* Reset partition data */
-			cp->nr_subparts = 0;
-			cpumask_clear(cp->effective_xcpus);
-			if (is_cpu_exclusive(cp))
-				clear_bit(CS_CPU_EXCLUSIVE, &cp->flags);
-		}
+		else if (new_prs < 0)
+			reset_partition_data(cp);
 		spin_unlock_irq(&callback_lock);
 
 		notify_partition_change(cp, old_prs);
@@ -2157,12 +2378,23 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 		goto out_free;
 
 	if (is_partition_valid(cs)) {
-		if (invalidate)
+		/*
+		 * Call remote_cpus_update() to handle valid remote partition
+		 */
+		if (is_remote_partition(cs))
+			remote_cpus_update(cs, trialcs->effective_xcpus, &tmp);
+		else if (invalidate)
 			update_parent_effective_cpumask(cs, partcmd_invalidate,
 							NULL, &tmp);
 		else
 			update_parent_effective_cpumask(cs, partcmd_update,
 						trialcs->effective_xcpus, &tmp);
+	} else if (!cpumask_empty(cs->exclusive_cpus)) {
+		/*
+		 * Use trialcs->effective_cpus as a temp cpumask
+		 */
+		remote_partition_check(cs, trialcs->effective_xcpus,
+				       trialcs->effective_cpus, &tmp);
 	}
 
 	spin_lock_irq(&callback_lock);
@@ -2203,6 +2435,7 @@ static int update_exclusive_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 
 	if (!*buf) {
 		cpumask_clear(trialcs->exclusive_cpus);
+		cpumask_clear(trialcs->effective_xcpus);
 	} else {
 		retval = cpulist_parse(buf, trialcs->exclusive_cpus);
 		if (retval < 0)
@@ -2218,7 +2451,8 @@ static int update_exclusive_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	if (alloc_cpumasks(NULL, &tmp))
 		return -ENOMEM;
 
-	compute_effective_exclusive_cpumask(trialcs, NULL);
+	if (*buf)
+		compute_effective_exclusive_cpumask(trialcs, NULL);
 
 	/*
 	 * Check all the descendants in update_cpumasks_hier() if
@@ -2240,14 +2474,26 @@ static int update_exclusive_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 			cs->prs_err = PERR_NOCPUS;
 		}
 
-		if (invalidate)
+		if (is_remote_partition(cs)) {
+			if (invalidate)
+				remote_partition_disable(cs, &tmp);
+			else
+				remote_cpus_update(cs, trialcs->effective_xcpus,
+						   &tmp);
+		} else if (invalidate) {
 			update_parent_effective_cpumask(cs, partcmd_invalidate,
 							NULL, &tmp);
-		else
+		} else {
 			update_parent_effective_cpumask(cs, partcmd_update,
 						trialcs->effective_xcpus, &tmp);
+		}
+	} else if (!cpumask_empty(trialcs->exclusive_cpus)) {
+		/*
+		 * Use trialcs->effective_cpus as a temp cpumask
+		 */
+		remote_partition_check(cs, trialcs->effective_xcpus,
+				       trialcs->effective_cpus, &tmp);
 	}
-
 	spin_lock_irq(&callback_lock);
 	cpumask_copy(cs->exclusive_cpus, trialcs->exclusive_cpus);
 	cpumask_copy(cs->effective_xcpus, trialcs->effective_xcpus);
@@ -2643,18 +2889,25 @@ static int update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
 static int update_prstate(struct cpuset *cs, int new_prs)
 {
 	int err = PERR_NONE, old_prs = cs->partition_root_state;
+	struct cpuset *parent = parent_cs(cs);
 	struct tmpmasks tmpmask;
 
 	if (old_prs == new_prs)
 		return 0;
 
 	/*
-	 * For a previously invalid partition root, leave it at being
-	 * invalid if new_prs is not "member".
+	 * For a previously invalid partition root with valid partition root
+	 * parent, treat it as if it is a "member". Otherwise, reject it as
+	 * remote partition cannot currently self-recover from an invalid
+	 * state.
 	 */
 	if (new_prs && is_prs_invalid(old_prs)) {
-		cs->partition_root_state = -new_prs;
-		return 0;
+		if (is_partition_valid(parent)) {
+			old_prs = PRS_MEMBER;
+		} else {
+			cs->partition_root_state = -new_prs;
+			return 0;
+		}
 	}
 
 	if (alloc_cpumasks(NULL, &tmpmask))
@@ -2665,8 +2918,6 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	 * later if partition becomes invalid.
 	 */
 	if ((new_prs > 0) && cpumask_empty(cs->exclusive_cpus)) {
-		struct cpuset *parent = parent_cs(cs);
-
 		spin_lock_irq(&callback_lock);
 		cpumask_and(cs->effective_xcpus,
 			    cs->cpus_allowed, parent->effective_xcpus);
@@ -2688,6 +2939,12 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 
 		err = update_parent_effective_cpumask(cs, partcmd_enable,
 						      NULL, &tmpmask);
+		/*
+		 * If an attempt to become local partition root fails,
+		 * try to become a remote partition root instead.
+		 */
+		if (err && remote_partition_enable(cs, &tmpmask))
+			err = 0;
 	} else if (old_prs && new_prs) {
 		/*
 		 * A change in load balance state only, no change in cpumasks.
@@ -2698,8 +2955,11 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 		 * Switching back to member is always allowed even if it
 		 * disables child partitions.
 		 */
-		update_parent_effective_cpumask(cs, partcmd_disable, NULL,
-						&tmpmask);
+		if (is_remote_partition(cs))
+			remote_partition_disable(cs, &tmpmask);
+		else
+			update_parent_effective_cpumask(cs, partcmd_disable,
+							NULL, &tmpmask);
 
 		/*
 		 * Invalidation of child partitions will be done in
@@ -3602,6 +3862,7 @@ cpuset_css_alloc(struct cgroup_subsys_state *parent_css)
 	nodes_clear(cs->effective_mems);
 	fmeter_init(&cs->fmeter);
 	cs->relax_domain_level = -1;
+	INIT_LIST_HEAD(&cs->remote_sibling);
 
 	/* Set CS_MEMORY_MIGRATE for default hierarchy */
 	if (cgroup_subsys_on_dfl(cpuset_cgrp_subsys))
@@ -3637,6 +3898,11 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 		cs->effective_mems = parent->effective_mems;
 		cs->use_parent_ecpus = true;
 		parent->child_ecpus_count++;
+		/*
+		 * Clear CS_SCHED_LOAD_BALANCE if parent is isolated
+		 */
+		if (!is_sched_load_balance(parent))
+			clear_bit(CS_SCHED_LOAD_BALANCE, &cs->flags);
 	}
 
 	/*
@@ -3891,6 +4157,7 @@ int __init cpuset_init(void)
 	fmeter_init(&top_cpuset.fmeter);
 	set_bit(CS_SCHED_LOAD_BALANCE, &top_cpuset.flags);
 	top_cpuset.relax_domain_level = -1;
+	INIT_LIST_HEAD(&remote_children);
 
 	BUG_ON(!alloc_cpumask_var(&cpus_attach, GFP_KERNEL));
 
@@ -4006,6 +4273,7 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 	static nodemask_t new_mems;
 	bool cpus_updated;
 	bool mems_updated;
+	bool remote;
 	struct cpuset *parent;
 retry:
 	wait_event(cpuset_attach_wq, cs->attach_in_progress == 0);
@@ -4032,9 +4300,18 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 	 * Compute effective_cpus for valid partition root, may invalidate
 	 * child partition roots if necessary.
 	 */
-	if (is_partition_valid(cs) && is_partition_valid(parent))
+	remote = is_remote_partition(cs);
+	if (remote || (is_partition_valid(cs) && is_partition_valid(parent)))
 		compute_partition_effective_cpumask(cs, &new_cpus);
 
+	if (remote && cpumask_empty(&new_cpus) &&
+	    partition_is_populated(cs, NULL)) {
+		remote_partition_disable(cs, tmp);
+		compute_effective_cpumask(&new_cpus, cs, parent);
+		remote = false;
+		cpuset_force_rebuild();
+	}
+
 	/*
 	 * Force the partition to become invalid if either one of
 	 * the following conditions hold:
@@ -4042,7 +4319,7 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 	 * 2) parent is invalid or doesn't grant any cpus to child
 	 *    partitions.
 	 */
-	if (is_partition_valid(cs) && (!is_partition_valid(parent) ||
+	if (is_local_partition(cs) && (!is_partition_valid(parent) ||
 				tasks_nocpu_error(parent, cs, &new_cpus))) {
 		update_parent_effective_cpumask(cs, partcmd_invalidate, NULL, tmp);
 		compute_effective_cpumask(&new_cpus, cs, parent);
-- 
2.31.1

