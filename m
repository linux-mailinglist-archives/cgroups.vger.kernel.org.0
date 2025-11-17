Return-Path: <cgroups+bounces-12024-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C5990C62323
	for <lists+cgroups@lfdr.de>; Mon, 17 Nov 2025 04:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8CED03628FC
	for <lists+cgroups@lfdr.de>; Mon, 17 Nov 2025 03:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20672882A9;
	Mon, 17 Nov 2025 03:01:53 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AAF276046;
	Mon, 17 Nov 2025 03:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763348513; cv=none; b=u5CIq70mqdhDVWZMuGsGFI2gOAfzWbrokeobFlcQz4Ly5FawdROSOoMxgfip7ZUiUcXtSQL/UZJTwAqDpyIDP9IiDbeH4w5z66uPfhXFWFIxz6Ao5RemmfFPT1GlXTE7EOSZIXRamoYTEzkALhC3dxR7tphPCXK0+i67a0c/S+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763348513; c=relaxed/simple;
	bh=AT51tCK1vBLy7WCddWQxVC7yZjrwm8MHONYbt09CkDw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ic62YIuykH+bmA2r5Kz/TtnhhCcknqCfjv0TsbP2oPPqXrJDzECJA6+yjpJNU/XBeAdHAK+sTkswpMMVNgV1XzQ5BYbPzQfAIqrLU24pH2Z7p58Hj1Nml6cF3TBIl5AdlwGpKBMxoEHHY3dpD12I/IjYSDY4bT+a/Nh6hFxVwQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d8svY3KM6zKHMTr;
	Mon, 17 Nov 2025 11:01:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 01C561A1F29;
	Mon, 17 Nov 2025 11:01:38 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgA3lHr5jxpp+kwRBA--.27716S15;
	Mon, 17 Nov 2025 11:01:37 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH -next 13/21] cpuset: remove update_parent_effective_cpumask
Date: Mon, 17 Nov 2025 02:46:19 +0000
Message-Id: <20251117024627.1128037-14-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251117024627.1128037-1-chenridong@huaweicloud.com>
References: <20251117024627.1128037-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgA3lHr5jxpp+kwRBA--.27716S15
X-Coremail-Antispam: 1UD129KBjvJXoW3Gry7Kw4xXrWUJF13uFyUKFg_yoWfKrW8pr
	yUGrsrXFWDtr18C39Fqan7uw1rKwsFqa4qy3s8W3WfAFy7A3Wvyryjya9YqFWYg3yDX34U
	Za90gr4fWF17AFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x
	0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UM6wAUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

Clean up by removing the update_parent_effective_cpumask() function.
Its logic has now been fully replaced and centralized by the new
helper functions.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 282 -----------------------------------------
 1 file changed, 282 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index d1f0824bc7c9..65430e12b58f 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2103,288 +2103,6 @@ static int local_partition_update(struct cpuset *cs, struct tmpmasks *tmp)
 	return __local_partition_update(cs, NULL, tmp->new_cpus, tmp, true);
 }
 
-/**
- * update_parent_effective_cpumask - update effective_cpus mask of parent cpuset
- * @cs:      The cpuset that requests change in partition root state
- * @cmd:     Partition root state change command
- * @newmask: Optional new cpumask for partcmd_update
- * @tmp:     Temporary addmask and delmask
- * Return:   0 or a partition root state error code
- *
- * For partcmd_enable*, the cpuset is being transformed from a non-partition
- * root to a partition root. The effective_xcpus (cpus_allowed if
- * effective_xcpus not set) mask of the given cpuset will be taken away from
- * parent's effective_cpus. The function will return 0 if all the CPUs listed
- * in effective_xcpus can be granted or an error code will be returned.
- *
- * For partcmd_disable, the cpuset is being transformed from a partition
- * root back to a non-partition root. Any CPUs in effective_xcpus will be
- * given back to parent's effective_cpus. 0 will always be returned.
- *
- * For partcmd_update, if the optional newmask is specified, the cpu list is
- * to be changed from effective_xcpus to newmask. Otherwise, effective_xcpus is
- * assumed to remain the same. The cpuset should either be a valid or invalid
- * partition root. The partition root state may change from valid to invalid
- * or vice versa. An error code will be returned if transitioning from
- * invalid to valid violates the exclusivity rule.
- *
- * For partcmd_invalidate, the current partition will be made invalid.
- *
- * The partcmd_enable* and partcmd_disable commands are used by
- * update_prstate(). An error code may be returned and the caller will check
- * for error.
- *
- * The partcmd_update command is used by update_cpumasks_hier() with newmask
- * NULL and update_cpumask() with newmask set. The partcmd_invalidate is used
- * by update_cpumask() with NULL newmask. In both cases, the callers won't
- * check for error and so partition_root_state and prs_err will be updated
- * directly.
- */
-static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
-					   struct cpumask *newmask,
-					   struct tmpmasks *tmp)
-{
-	struct cpuset *parent = parent_cs(cs);
-	int adding;	/* Adding cpus to parent's effective_cpus	*/
-	int deleting;	/* Deleting cpus from parent's effective_cpus	*/
-	int old_prs, new_prs;
-	int part_error = PERR_NONE;	/* Partition error? */
-	struct cpumask *xcpus = user_xcpus(cs);
-	int parent_prs = parent->partition_root_state;
-	bool nocpu;
-
-	lockdep_assert_held(&cpuset_mutex);
-	WARN_ON_ONCE(is_remote_partition(cs));	/* For local partition only */
-
-	/*
-	 * new_prs will only be changed for the partcmd_update and
-	 * partcmd_invalidate commands.
-	 */
-	adding = deleting = false;
-	old_prs = new_prs = cs->partition_root_state;
-
-	/*
-	 * The parent must be a partition root.
-	 * The new cpumask, if present, or the current cpus_allowed must
-	 * not be empty.
-	 */
-	if (!is_partition_valid(parent)) {
-		return is_partition_invalid(parent)
-		       ? PERR_INVPARENT : PERR_NOTPART;
-	}
-	if (!newmask && xcpus_empty(cs))
-		return PERR_CPUSEMPTY;
-
-	nocpu = tasks_nocpu_error(parent, cs, xcpus);
-
-	if (newmask) {
-		/*
-		 * Empty cpumask is not allowed
-		 */
-		if (cpumask_empty(newmask)) {
-			part_error = PERR_CPUSEMPTY;
-			goto write_error;
-		}
-
-		/* Check newmask again, whether cpus are available for parent/cs */
-		nocpu |= tasks_nocpu_error(parent, cs, newmask);
-
-		/*
-		 * partcmd_update with newmask:
-		 *
-		 * Compute add/delete mask to/from effective_cpus
-		 *
-		 * For valid partition:
-		 *   addmask = exclusive_cpus & ~newmask
-		 *			      & parent->effective_xcpus
-		 *   delmask = newmask & ~exclusive_cpus
-		 *		       & parent->effective_xcpus
-		 *
-		 * For invalid partition:
-		 *   delmask = newmask & parent->effective_xcpus
-		 *   The partition may become valid soon.
-		 */
-		if (is_partition_invalid(cs)) {
-			adding = false;
-			deleting = cpumask_and(tmp->delmask,
-					newmask, parent->effective_xcpus);
-		} else {
-			cpumask_andnot(tmp->addmask, xcpus, newmask);
-			adding = cpumask_and(tmp->addmask, tmp->addmask,
-					     parent->effective_xcpus);
-
-			cpumask_andnot(tmp->delmask, newmask, xcpus);
-			deleting = cpumask_and(tmp->delmask, tmp->delmask,
-					       parent->effective_xcpus);
-		}
-
-		/*
-		 * TBD: Invalidate a currently valid child root partition may
-		 * still break isolated_cpus_can_update() rule if parent is an
-		 * isolated partition.
-		 */
-		if (is_partition_valid(cs) && (old_prs != parent_prs)) {
-			if ((parent_prs == PRS_ROOT) &&
-			    /* Adding to parent means removing isolated CPUs */
-			    !isolated_cpus_can_update(tmp->delmask, tmp->addmask))
-				part_error = PERR_HKEEPING;
-			if ((parent_prs == PRS_ISOLATED) &&
-			    /* Adding to parent means adding isolated CPUs */
-			    !isolated_cpus_can_update(tmp->addmask, tmp->delmask))
-				part_error = PERR_HKEEPING;
-		}
-
-		/*
-		 * The new CPUs to be removed from parent's effective CPUs
-		 * must be present.
-		 */
-		if (deleting) {
-			cpumask_and(tmp->new_cpus, tmp->delmask, cpu_active_mask);
-			WARN_ON_ONCE(!cpumask_subset(tmp->new_cpus, parent->effective_cpus));
-		}
-
-		/*
-		 * Make partition invalid if parent's effective_cpus could
-		 * become empty and there are tasks in the parent.
-		 */
-		if (nocpu && (!adding ||
-		    !cpumask_intersects(tmp->addmask, cpu_active_mask))) {
-			part_error = PERR_NOCPUS;
-			deleting = false;
-			adding = cpumask_and(tmp->addmask,
-					     xcpus, parent->effective_xcpus);
-		}
-	} else {
-		/*
-		 * partcmd_update w/o newmask
-		 *
-		 * delmask = effective_xcpus & parent->effective_cpus
-		 *
-		 * This can be called from:
-		 * 1) update_cpumasks_hier()
-		 * 2) cpuset_hotplug_update_tasks()
-		 *
-		 * Check to see if it can be transitioned from valid to
-		 * invalid partition or vice versa.
-		 *
-		 * A partition error happens when parent has tasks and all
-		 * its effective CPUs will have to be distributed out.
-		 */
-		if (nocpu) {
-			part_error = PERR_NOCPUS;
-			if (is_partition_valid(cs))
-				adding = cpumask_and(tmp->addmask,
-						xcpus, parent->effective_xcpus);
-		} else if (is_partition_invalid(cs) && !cpumask_empty(xcpus) &&
-			   cpumask_subset(xcpus, parent->effective_xcpus)) {
-			struct cgroup_subsys_state *css;
-			struct cpuset *child;
-			bool exclusive = true;
-
-			/*
-			 * Convert invalid partition to valid has to
-			 * pass the cpu exclusivity test.
-			 */
-			rcu_read_lock();
-			cpuset_for_each_child(child, css, parent) {
-				if (child == cs)
-					continue;
-				if (!cpusets_are_exclusive(cs, child)) {
-					exclusive = false;
-					break;
-				}
-			}
-			rcu_read_unlock();
-			if (exclusive)
-				deleting = cpumask_and(tmp->delmask,
-						xcpus, parent->effective_cpus);
-			else
-				part_error = PERR_NOTEXCL;
-		}
-	}
-
-write_error:
-	if (part_error)
-		WRITE_ONCE(cs->prs_err, part_error);
-
-	if (cmd == partcmd_update) {
-		/*
-		 * Check for possible transition between valid and invalid
-		 * partition root.
-		 */
-		switch (cs->partition_root_state) {
-		case PRS_ROOT:
-		case PRS_ISOLATED:
-			if (part_error)
-				new_prs = -old_prs;
-			break;
-		case PRS_INVALID_ROOT:
-		case PRS_INVALID_ISOLATED:
-			if (!part_error)
-				new_prs = -old_prs;
-			break;
-		}
-	}
-
-	if (!adding && !deleting && (new_prs == old_prs))
-		return 0;
-
-	/*
-	 * Transitioning between invalid to valid or vice versa may require
-	 * changing CS_CPU_EXCLUSIVE. In the case of partcmd_update,
-	 * validate_change() has already been successfully called and
-	 * CPU lists in cs haven't been updated yet. So defer it to later.
-	 */
-	if ((old_prs != new_prs) && (cmd != partcmd_update))  {
-		int err = update_partition_exclusive_flag(cs, new_prs);
-
-		if (err)
-			return err;
-	}
-
-	/*
-	 * Change the parent's effective_cpus & effective_xcpus (top cpuset
-	 * only).
-	 *
-	 * Newly added CPUs will be removed from effective_cpus and
-	 * newly deleted ones will be added back to effective_cpus.
-	 */
-	spin_lock_irq(&callback_lock);
-	if (old_prs != new_prs)
-		cs->partition_root_state = new_prs;
-
-	/*
-	 * Adding to parent's effective_cpus means deletion CPUs from cs
-	 * and vice versa.
-	 */
-	if (adding)
-		partition_xcpus_del(old_prs, parent, tmp->addmask);
-	if (deleting)
-		partition_xcpus_add(new_prs, parent, tmp->delmask);
-
-	spin_unlock_irq(&callback_lock);
-	update_isolation_cpumasks();
-
-	if ((old_prs != new_prs) && (cmd == partcmd_update))
-		update_partition_exclusive_flag(cs, new_prs);
-
-	if (adding || deleting) {
-		cpuset_update_tasks_cpumask(parent, tmp->addmask);
-		update_sibling_cpumasks(parent, cs, tmp);
-	}
-
-	/*
-	 * For partcmd_update without newmask, it is being called from
-	 * cpuset_handle_hotplug(). Update the load balance flag and
-	 * scheduling domain accordingly.
-	 */
-	if ((cmd == partcmd_update) && !newmask)
-		update_partition_sd_lb(cs, old_prs);
-
-	notify_partition_change(cs, old_prs);
-	return 0;
-}
-
 /**
  * compute_partition_effective_cpumask - compute effective_cpus for partition
  * @cs: partition root cpuset
-- 
2.34.1


