Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAD677CF33
	for <lists+cgroups@lfdr.de>; Tue, 15 Aug 2023 17:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbjHOPd2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 15 Aug 2023 11:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236268AbjHOPc4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 15 Aug 2023 11:32:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649F31FD2
        for <cgroups@vger.kernel.org>; Tue, 15 Aug 2023 08:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692113452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qZFDV8+jj8F7XHKv5t7+2IcspoYlB3AdQ48S1jQW8vw=;
        b=MUxbad1gekIfrNIQ9x4E+8dRRwGMTukZ3kRyygJHfovau6SDYdLB0YrR6vxTbC690b9Q4M
        97fb/pl7YcPmQyDp0ZmyZ8Knna6ggEepi6t6W/QhmC7l1Yxto9t689HratBT+xDGh6hTyB
        qvnh5NesS7O3E2nygL0Osqil35YKN64=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-274-m0PA_YgjMkybxnxjbWQRcQ-1; Tue, 15 Aug 2023 11:30:48 -0400
X-MC-Unique: m0PA_YgjMkybxnxjbWQRcQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2435F8DC661;
        Tue, 15 Aug 2023 15:30:48 +0000 (UTC)
Received: from llong.com (unknown [10.22.18.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 87F7F40D2839;
        Tue, 15 Aug 2023 15:30:47 +0000 (UTC)
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
Subject: [PATCH-cgroup v6 3/6] cgroup/cpuset: Introduce remote partition
Date:   Tue, 15 Aug 2023 11:30:24 -0400
Message-Id: <20230815153027.633355-4-longman@redhat.com>
In-Reply-To: <20230815153027.633355-1-longman@redhat.com>
References: <20230815153027.633355-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
 kernel/cgroup/cpuset.c | 339 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 313 insertions(+), 26 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 9fa617729096..5b4d72f2f09d 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -194,6 +194,9 @@ struct cpuset {
 
 	/* Handle for cpuset.cpus.partition */
 	struct cgroup_file partition_file;
+
+	/* Remote partition silbling list anchored at remote_children */
+	struct list_head remote_sibling;
 };
 
 /*
@@ -201,6 +204,9 @@ struct cpuset {
  */
 static cpumask_var_t	subpartitions_cpus;
 
+/* List of remote partition root children */
+static struct list_head remote_children;
+
 /*
  * Partition root states:
  *
@@ -350,6 +356,7 @@ static struct cpuset top_cpuset = {
 	.flags = ((1 << CS_ONLINE) | (1 << CS_CPU_EXCLUSIVE) |
 		  (1 << CS_MEM_EXCLUSIVE)),
 	.partition_root_state = PRS_ROOT,
+	.remote_sibling = LIST_HEAD_INIT(top_cpuset.remote_sibling),
 };
 
 /**
@@ -1428,6 +1435,225 @@ static bool compute_effective_exclusive_cpumask(struct cpuset *cs,
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
+ * @newmask: the new exclusive_cpus mask
+ * @tmp: temparary masks
+ *
+ * top_cpuset and subpartitions_cpus will be updated or partition can be
+ * invalidated.
+ *
+ * newmask can be NULL which means checking the new effective exclusive_cpus
+ * to see if the remote partition needs to be deactivated.
+ */
+static void remote_cpus_update(struct cpuset *cs, struct cpumask *newmask,
+			       struct tmpmasks *tmp)
+{
+	bool adding, deleting;
+
+	if (WARN_ON_ONCE(!is_remote_partition(cs)))
+		return;
+
+	compute_effective_exclusive_cpumask(cs, tmp->new_cpus);
+
+	if (!newmask) {
+		/*
+		 * Check if the new effective_xcpus to see if
+		 * invalidation is needed.
+		 */
+		if (!cpumask_subset(cs->effective_cpus, tmp->new_cpus))
+			goto invalidate;
+		return;
+	}
+
+	WARN_ON_ONCE(!cpumask_subset(tmp->new_cpus, subpartitions_cpus));
+	if (cpumask_empty(newmask))
+		goto invalidate;
+
+	adding   = cpumask_andnot(tmp->addmask, newmask, tmp->new_cpus);
+	deleting = cpumask_andnot(tmp->delmask, tmp->new_cpus, newmask);
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
+ * @newmask: the new exclusive_cpus mask
+ * @delmask: temporary mask for deletion (not in tmp)
+ * @tmp: temparary masks
+ *
+ * This should be called before the given cs has updated its cpus_allowed
+ * and/or exclusive_cpus.
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
@@ -1522,8 +1748,9 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 
 	if (cmd == partcmd_enable) {
 		/*
-		 * Enabling partition root is not allowed if exclusive CPUs
-		 * doesn't overlap with parent's effective_xcpus.
+		 * Enabling partition root is not allowed if its
+		 * effective_xcpus doesn't overlap with parent's
+		 * effective_xcpus.
 		 */
 		if (!cpumask_intersects(xcpus, parent->effective_xcpus))
 			return PERR_INVCPUS;
@@ -1540,7 +1767,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 		subparts_delta++;
 	} else if (cmd == partcmd_disable) {
 		/*
-		 n* May need to add cpus to parent's effective_cpus for
+		 * May need to add cpus to parent's effective_cpus for
 		 * valid partition root.
 		 */
 		adding = !is_prs_invalid(old_prs) &&
@@ -1741,7 +1968,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
  * @new_ecpus: previously computed effective_cpus to be updated
  *
  * Compute the effective_cpus of a partition root by scanning effective_xcpus
- * of child partition roots and exclusing their effective_xcpus.
+ * of child partition roots and excluding their effective_xcpus.
  *
  * This has the side effect of invalidating valid child partition roots,
  * if necessary. Since it is called from either cpuset_hotplug_update_tasks()
@@ -1832,19 +2059,34 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
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
 
-		if (cp->exclusive_cpus) {
-			/* Update effective_xcpus */
+		/*
+		 * Update effective_xcpus if exclusive_cpus set in descendent
+		 * cpusets.
+		 */
+		if (cp->exclusive_cpus && (cp != cs)) {
 			spin_lock_irq(&callback_lock);
 			compute_effective_exclusive_cpumask(cp, NULL);
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
@@ -1862,7 +2104,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 		 * it is a partition root that has explicitly distributed
 		 * out all its CPUs.
 		 */
-		if (is_in_v2_mode() && cpumask_empty(tmp->new_cpus)) {
+		if (is_in_v2_mode() && !remote && cpumask_empty(tmp->new_cpus)) {
 			cpumask_copy(tmp->new_cpus, parent->effective_cpus);
 			if (!cp->use_parent_ecpus) {
 				cp->use_parent_ecpus = true;
@@ -1874,6 +2116,9 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 			parent->child_ecpus_count--;
 		}
 
+		if (remote)
+			goto get_css;
+
 		/*
 		 * Skip the whole subtree if
 		 * 1) the cpumask remains the same,
@@ -1896,7 +2141,6 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 		 * update_tasks_cpumask() again for tasks in the parent
 		 * cpuset if the parent's effective_cpus changes.
 		 */
-		old_prs = new_prs = cp->partition_root_state;
 		if ((cp != cs) && old_prs) {
 			switch (parent->partition_root_state) {
 			case PRS_ROOT:
@@ -1918,7 +2162,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 				break;
 			}
 		}
-
+get_css:
 		if (!css_tryget_online(&cp->css))
 			continue;
 		rcu_read_unlock();
@@ -1938,13 +2182,8 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 		if ((new_prs > 0) && cpumask_empty(cp->effective_xcpus))
 			cpumask_and(cp->effective_xcpus,
 				    cp->cpus_allowed, parent->effective_xcpus);
-		if (new_prs < 0) {
-			/* Reset partition data */
-			cp->nr_subparts = 0;
-			cpumask_clear(cp->effective_xcpus);
-			if (is_cpu_exclusive(cp))
-				clear_bit(CS_CPU_EXCLUSIVE, &cp->flags);
-		}
+		if (new_prs < 0)
+			reset_partition_data(cp);
 		spin_unlock_irq(&callback_lock);
 
 		notify_partition_change(cp, old_prs);
@@ -2142,12 +2381,23 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
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
+	} else if (cs->exclusive_cpus) {
+		/*
+		 * Use trialcs->effective_cpus as a temp cpumask
+		 */
+		remote_partition_check(cs, trialcs->effective_xcpus,
+				       trialcs->effective_cpus, &tmp);
 	}
 
 	spin_lock_irq(&callback_lock);
@@ -2229,8 +2479,7 @@ static int update_exclusive_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 		if (alloc_cpumasks(NULL, &tmp))
 			return -ENOMEM;
 
-		if (!trialcs->exclusive_cpus ||
-		    cpumask_empty(trialcs->exclusive_cpus)) {
+		if (!trialcs->exclusive_cpus) {
 			invalidate = true;
 			cs->prs_err = PERR_INVCPUS;
 		} else if (tasks_nocpu_error(parent, cs, trialcs->exclusive_cpus)) {
@@ -2238,12 +2487,24 @@ static int update_exclusive_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 			cs->prs_err = PERR_NOCPUS;
 		}
 
-		if (invalidate)
+		if (is_remote_partition(cs)) {
+			if (invalidate)
+				remote_partition_disable(cs, &tmp);
+			else
+				remote_cpus_update(cs, trialcs->effective_xcpus,
+						   &tmp);
+		} else if (invalidate)
 			update_parent_effective_cpumask(cs, partcmd_invalidate,
 							NULL, &tmp);
 		else
 			update_parent_effective_cpumask(cs, partcmd_update,
 						trialcs->exclusive_cpus, &tmp);
+	} else if (trialcs->exclusive_cpus) {
+		/*
+		 * Use trialcs->effective_cpus as a temp cpumask
+		 */
+		remote_partition_check(cs, trialcs->effective_xcpus,
+				       trialcs->effective_cpus, &tmp);
 	}
 
 	spin_lock_irq(&callback_lock);
@@ -2687,6 +2948,12 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 
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
@@ -2697,8 +2964,11 @@ static int update_prstate(struct cpuset *cs, int new_prs)
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
@@ -3604,6 +3874,7 @@ cpuset_css_alloc(struct cgroup_subsys_state *parent_css)
 	nodes_clear(cs->effective_mems);
 	fmeter_init(&cs->fmeter);
 	cs->relax_domain_level = -1;
+	INIT_LIST_HEAD(&cs->remote_sibling);
 
 	/* Set CS_MEMORY_MIGRATE for default hierarchy */
 	if (cgroup_subsys_on_dfl(cpuset_cgrp_subsys))
@@ -3639,6 +3910,11 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
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
@@ -3891,6 +4167,7 @@ int __init cpuset_init(void)
 	fmeter_init(&top_cpuset.fmeter);
 	set_bit(CS_SCHED_LOAD_BALANCE, &top_cpuset.flags);
 	top_cpuset.relax_domain_level = -1;
+	INIT_LIST_HEAD(&remote_children);
 
 	BUG_ON(!alloc_cpumask_var(&cpus_attach, GFP_KERNEL));
 
@@ -4006,6 +4283,7 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 	static nodemask_t new_mems;
 	bool cpus_updated;
 	bool mems_updated;
+	bool remote;
 	struct cpuset *parent;
 retry:
 	wait_event(cpuset_attach_wq, cs->attach_in_progress == 0);
@@ -4032,9 +4310,18 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
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
@@ -4042,7 +4329,7 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
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

