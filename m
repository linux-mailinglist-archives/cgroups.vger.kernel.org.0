Return-Path: <cgroups+bounces-12010-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EF258C622CF
	for <lists+cgroups@lfdr.de>; Mon, 17 Nov 2025 04:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4320C4E6E62
	for <lists+cgroups@lfdr.de>; Mon, 17 Nov 2025 03:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C3C263C8F;
	Mon, 17 Nov 2025 03:01:48 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE21A189BB0;
	Mon, 17 Nov 2025 03:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763348508; cv=none; b=fMPECcn75Bg9rJJzwM4dUiDsf8tTTxmJ0S4y1IVUGPgBeFMnSSlboiaJrLKpe8m1YMzZzoYVT7KK11WT7XLhPo5cpgAS1/2q3MaW2ep6SJGgovcxAkcOuwePes5J9FhcuGGw/iksJuPvUFiyTUztR3briYOJny7FPpvo5G7OxUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763348508; c=relaxed/simple;
	bh=oVL0s7kinXQqcB09Q/T5aemEmPHCBElL8NkV4M0DU/c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JZ0K/ozS+qd2VRma10ZC1Xgkc4wB4FodXWJTWTv09VP5EqUGWUdWax4OOmlcwVeyDfsc/DNIHQNDayEDUg0Axn30VsQGdB3vuju9cfr9Qzsu5BO9lMb/k/ndes//UGmt5N8RKzDNUJQhkHKq6vUADlmkDWJN3FqrQlCLMGJ+NpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d8svK5QK8zYQtxW;
	Mon, 17 Nov 2025 11:01:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id DF1271A1F29;
	Mon, 17 Nov 2025 11:01:37 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgA3lHr5jxpp+kwRBA--.27716S14;
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
Subject: [PATCH -next 12/21] cpuset: introduce local_partition_update()
Date: Mon, 17 Nov 2025 02:46:18 +0000
Message-Id: <20251117024627.1128037-13-chenridong@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgA3lHr5jxpp+kwRBA--.27716S14
X-Coremail-Antispam: 1UD129KBjvJXoW3WFWkXr4rWrWkurW8uw18Grg_yoW3CrW8pF
	yUCr42q3yUKry5C343tan7Cws5Kws2qF9Fy3ZxJ3WrJFy7t34vya4jya9Ivr45XFZrW345
	Za90qF4xWFy7uwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

The local_partition_update() function replaces the command partcmd_update
previously handled within update_parent_effective_cpumask(). The update
logic follows a state-based approach:

1. Validation check: First verify if the local partition is currently valid
2. Invalidation handling: If the partition is invalid, trigger invalidation
3. State transition: If an invalid partition has no errors, transition to
   valid
4. cpumask updates: For local partition that only cpu maks changes, use
   partition_update() to handle partition change.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 151 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 146 insertions(+), 5 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 770a28491cb7..d1f0824bc7c9 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1897,6 +1897,62 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
 	remote_partition_disable(cs, tmp);
 }
 
+static bool is_user_xcpus_exclusive(struct cpuset *cs)
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
+ * @tmp: Temporary masks
+ *
+ * Return: PERR_NONE if validation passes, appropriate error code otherwise
+ *
+ * Important: The caller must ensure that @cs's cpu mask is updated before
+ * invoking this function when exclusive CPU validation is required.
+ */
+static enum prs_errcode validate_local_partition(struct cpuset *cs, int new_prs,
+			struct cpumask *excpus, bool excl_check, struct tmpmasks *tmp)
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
+	if (excl_check && !is_user_xcpus_exclusive(cs))
+		return PERR_NOTEXCL;
+
+	if (!tmp)
+		return validate_partition(cs, new_prs, excpus, excpus, NULL);
+	return validate_partition(cs, new_prs, excpus, tmp->addmask, tmp->delmask);
+}
+
 /**
  * local_partition_enable - Enable local partition for a cpuset
  * @cs: Target cpuset to become a local partition root
@@ -1968,6 +2024,85 @@ static void local_partition_disable(struct cpuset *cs, enum prs_errcode part_err
 	update_sibling_cpumasks(parent, cs, tmp);
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
+	cpumask_andnot(tmp->addmask, excpus, cs->effective_xcpus);
+	cpumask_andnot(tmp->delmask, cs->effective_xcpus, excpus);
+	part_error = validate_local_partition(cs, new_prs, excpus,
+					      excl_check, tmp);
+	if (part_error) {
+		local_partition_disable(cs, part_error, tmp);
+		return part_error;
+	}
+
+	/* Nothing changes, return PERR_NONE */
+	if (new_prs == old_prs &&
+	    (cpumask_empty(tmp->addmask) && cpumask_empty(tmp->delmask)))
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
+		partition_update(cs, new_prs, xcpus, excpus, tmp);
+	}
+
+	cpuset_update_tasks_cpumask(parent, tmp->addmask);
+	update_sibling_cpumasks(parent, cs, tmp);
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
@@ -2445,9 +2580,16 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
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
@@ -2456,7 +2598,6 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 		}
 
 		spin_lock_irq(&callback_lock);
-		cpumask_copy(cp->effective_cpus, tmp->new_cpus);
 		cp->partition_root_state = new_prs;
 		if (!cpumask_empty(cp->exclusive_cpus) && (cp != cs))
 			compute_excpus(cp, cp->effective_xcpus);
@@ -2645,8 +2786,8 @@ static void partition_cpus_change(struct cpuset *cs, struct cpuset *trialcs,
 		if (trialcs->prs_err)
 			local_partition_disable(cs, trialcs->prs_err, tmp);
 		else
-			update_parent_effective_cpumask(cs, partcmd_update,
-							trialcs->effective_xcpus, tmp);
+			__local_partition_update(cs, trialcs->exclusive_cpus,
+						 trialcs->effective_xcpus, tmp, false);
 	}
 }
 
@@ -4098,7 +4239,7 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 	else if (is_partition_valid(parent) && is_partition_invalid(cs) &&
 		 !cpumask_empty(user_xcpus(cs))) {
 		partcmd = partcmd_update;
-		update_parent_effective_cpumask(cs, partcmd, NULL, tmp);
+		local_partition_update(cs, tmp);
 	}
 
 	if (partcmd >= 0) {
-- 
2.34.1


