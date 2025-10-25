Return-Path: <cgroups+bounces-11161-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D604C08CA8
	for <lists+cgroups@lfdr.de>; Sat, 25 Oct 2025 09:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 56B4C4E4E8D
	for <lists+cgroups@lfdr.de>; Sat, 25 Oct 2025 07:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED392DF131;
	Sat, 25 Oct 2025 07:03:58 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4142DE6F4;
	Sat, 25 Oct 2025 07:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761375838; cv=none; b=olIx1m0SqIjXfNTD0RgHg6AZDne5ZbvHsMVhDuUcfMo8EF6QckD98ROTD4WYQOt+2x09l4u5nT9zhdUfubcLynunEzS6CG4s6JQodsGgJhuLGkoHcIDuUy+RewFrK/6U3lKU8vPmAm0aWjyHCQfFNOedbv3eE5QyFMD47FHCho0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761375838; c=relaxed/simple;
	bh=x/mh6LNlesQvCviYjMCaqqmUG4+j/9A0dHwwnbljO/M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zp8RUpcmKk8ltdBOMgoSinth6tB/VaOuA1mZrueH4lIWbBK68rvFtw9CYrwmjo70WDXCuLrLDgSv5IVvSBXUb/oxZOU6hwiVvk495369XVogGVoT36LGkJNfmt7B61SKl4yWVd48k9f6aane8GSt43PBTo0hgv1deoihwbWyRWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4ctrM64cZdzKHMZ9;
	Sat, 25 Oct 2025 15:02:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 8D0891A0E73;
	Sat, 25 Oct 2025 15:03:50 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgCHKUJGdvxovSssBg--.49460S15;
	Sat, 25 Oct 2025 15:03:50 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH RFC v2 13/22] cpuset: introduce local_partition_update()
Date: Sat, 25 Oct 2025 06:48:35 +0000
Message-Id: <20251025064844.495525-14-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251025064844.495525-1-chenridong@huaweicloud.com>
References: <20251025064844.495525-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCHKUJGdvxovSssBg--.49460S15
X-Coremail-Antispam: 1UD129KBjvJXoW3WFWkXr4fAFWxJr1kGr48JFb_yoW3AFW5pF
	y5Cr42q3yUKry5u343tan7Cws5Kws2qF9Fy3ZxJ3WfJFy7t34vya4jya9Ivr45XrZrW345
	Za90qF4xWF1UuwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUwuWlUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

The local_partition_update() function replaces the command partcmd_update
previously handled within update_parent_effective_cpumask(). The update
logic follows a state-based approach:

1. Validation check: First verify if the local partition is currently valid
2. Invalidation handling: If the partition is invalid, trigger invalidation
3. State transition: If an invalid partition has no errors, transition to
   valid
4. cpumasks updates: For local partition that only cpu maks changes, use
   partition_update() to handle partition change.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 153 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 148 insertions(+), 5 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 73a43ab58f72..49df38237c1d 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1822,6 +1822,59 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
 	remote_partition_disable(cs, tmp);
 }
 
+static bool is_user_cpus_exclusive(struct cpuset *cs)
+{
+	struct cpuset *parent = parent_cs(cs);
+	struct cgroup_subsys_state *css;
+	struct cpuset *child;
+	bool exclusive = true;
+
+	rcu_read_lock();
+	cpuset_for_each_child(child, css, parent) {
+		if (child == cs)
+			continue;
+		if (!cpusets_are_exclusive(cs, child)) {
+			exclusive = false;
+			break;
+		}
+	}
+	rcu_read_unlock();
+	return exclusive;
+}
+
+/**
+ * validate_local_partition - Validate for local partition
+ * @cs: Target cpuset to validate
+ * @new_prs: New partition root state to validate
+ * @excpus: New exclusive effectuve CPUs mask to validate
+ * @excl_check: Flag to enable exclusive CPUs ownership validation
+ *
+ * Return: PERR_NONE if validation passes, appropriate error code otherwise
+ *
+ * Important: The caller must ensure that @cs's cpu mask is updated before
+ * invoking this function when exclusive CPU validation is required.
+ */
+static enum prs_errcode validate_local_partition(struct cpuset *cs, int new_prs,
+					struct cpumask *excpus, bool excl_check)
+{
+	struct cpuset *parent = parent_cs(cs);
+
+	/*
+	 * The parent must be a partition root.
+	 * The new cpumask, if present, or the current cpus_allowed must
+	 * not be empty.
+	 */
+	if (!is_partition_valid(parent)) {
+		return is_partition_invalid(parent)
+			? PERR_INVPARENT : PERR_NOTPART;
+	}
+
+	if (excl_check && !is_user_cpus_exclusive(cs))
+		return PERR_NOTEXCL;
+
+	return validate_partition(cs, new_prs, excpus);
+}
+
 /**
  * local_partition_enable - Enable local partition for a cpuset
  * @cs: Target cpuset to become a local partition root
@@ -1948,6 +2001,90 @@ static void local_partition_invalidate(struct cpuset *cs, struct tmpmasks *tmp)
 	}
 }
 
+/**
+ * __local_partition_update - Update local partition configuration
+ * @cs: Target cpuset to update
+ * @xcpus: New exclusive CPU mask
+ * @excpus: New effective exclusive CPU mask
+ * @tmp: Temporary mask storage for intermediate calculations
+ * @excl_check: Flag to enable exclusivity validation
+ *
+ * Handles updates to local CPU partition configurations by validating
+ * changes, managing state transitions, and propagating updates through
+ * the cpuset hierarchy.
+ *
+ * Note on exclusivity checking: Exclusivity validation is required when
+ * transitioning from an invalid to valid partition state. However, when
+ * updating cpus_allowed or exclusive_cpus, exclusivity should have already
+ * been verified by validate_change(). In such cases, excl_check must be
+ * false since the cs cpumasks are not yet updated.
+ *
+ * Return: Partition error code (PERR_NONE indicates success)
+ */
+static int __local_partition_update(struct cpuset *cs, struct cpumask *xcpus,
+				  struct cpumask *excpus, struct tmpmasks *tmp,
+				  bool excl_check)
+{
+	struct cpuset *parent = parent_cs(cs);
+	int part_error = PERR_NONE;	/* Partition error? */
+	int old_prs, new_prs;
+	bool cpumask_updated = false;
+
+	lockdep_assert_held(&cpuset_mutex);
+	/* For local partition only */
+	if (WARN_ON_ONCE(is_remote_partition(cs) || cs_is_member(cs)))
+		return PERR_NONE;
+
+	old_prs = cs->partition_root_state;
+	/*
+	 * If new_prs < 0, it might transition to valid partition state.
+	 * Use absolute value for validation checks.
+	 */
+	new_prs = old_prs < 0 ? -old_prs : old_prs;
+	part_error = validate_local_partition(cs, new_prs, excpus, excl_check);
+	if (part_error) {
+		local_partition_disable(cs, part_error, tmp);
+		return part_error;
+	}
+
+	cpumask_updated = !cpumask_equal(excpus, cs->effective_xcpus);
+	/* Nothing changes, return PERR_NONE */
+	if (new_prs == old_prs && !cpumask_updated)
+		return PERR_NONE;
+
+	/*
+	 * If partition was previously invalid but now passes checks,
+	 * re-enable it and update related flags.
+	 * Otherwise, partition state doesn't change, only cpumasks change.
+	 */
+	if (is_partition_invalid(cs)) {
+		partition_enable(cs, parent, new_prs, excpus);
+		update_partition_exclusive_flag(cs, new_prs);
+		update_partition_sd_lb(cs, old_prs);
+	} else {
+		cpumask_andnot(tmp->addmask, excpus, cs->effective_xcpus);
+		cpumask_andnot(tmp->delmask, cs->effective_xcpus, excpus);
+		partition_update(cs, new_prs, xcpus, excpus, tmp);
+	}
+
+	/*
+	 * Propagate changes in parent's effective_cpus down the hierarchy.
+	 */
+	if (cpumask_updated) {
+		cpuset_update_tasks_cpumask(parent, tmp->addmask);
+		update_sibling_cpumasks(parent, cs, tmp);
+	}
+	return PERR_NONE;
+}
+
+static int local_partition_update(struct cpuset *cs, struct tmpmasks *tmp)
+{
+	struct cpuset *parent = parent_cs(cs);
+
+	cpumask_and(tmp->new_cpus, user_xcpus(cs), parent->effective_xcpus);
+	return __local_partition_update(cs, NULL, tmp->new_cpus, tmp, true);
+}
+
 /**
  * update_parent_effective_cpumask - update effective_cpus mask of parent cpuset
  * @cs:      The cpuset that requests change in partition root state
@@ -2410,9 +2547,16 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 		if (!css_tryget_online(&cp->css))
 			continue;
 		rcu_read_unlock();
+		/*
+		 * The tmp->new_cpus may by modified.
+		 * Update effective_cpus before passing tmp to other functions.
+		 */
+		spin_lock_irq(&callback_lock);
+		cpumask_copy(cp->effective_cpus, tmp->new_cpus);
+		spin_unlock_irq(&callback_lock);
 
 		if (update_parent) {
-			update_parent_effective_cpumask(cp, partcmd_update, NULL, tmp);
+			local_partition_update(cp, tmp);
 			/*
 			 * The cpuset partition_root_state may become
 			 * invalid. Capture it.
@@ -2421,7 +2565,6 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 		}
 
 		spin_lock_irq(&callback_lock);
-		cpumask_copy(cp->effective_cpus, tmp->new_cpus);
 		cp->partition_root_state = new_prs;
 		if (!cpumask_empty(cp->exclusive_cpus) && (cp != cs))
 			compute_excpus(cp, cp->effective_xcpus);
@@ -2613,8 +2756,8 @@ static void partition_cpus_change(struct cpuset *cs, struct cpuset *trialcs,
 		if (trialcs->prs_err)
 			local_partition_invalidate(cs, tmp);
 		else
-			update_parent_effective_cpumask(cs, partcmd_update,
-							trialcs->effective_xcpus, tmp);
+			__local_partition_update(cs, trialcs->exclusive_cpus,
+						 trialcs->effective_xcpus, tmp, false);
 	}
 }
 
@@ -4068,7 +4211,7 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 	else if (is_partition_valid(parent) && is_partition_invalid(cs) &&
 		 !cpumask_empty(user_xcpus(cs))) {
 		partcmd = partcmd_update;
-		update_parent_effective_cpumask(cs, partcmd, NULL, tmp);
+		local_partition_update(cs, tmp);
 	}
 
 	if (partcmd >= 0) {
-- 
2.34.1


