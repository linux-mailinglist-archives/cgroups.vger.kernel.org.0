Return-Path: <cgroups+bounces-9486-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3ECB3C002
	for <lists+cgroups@lfdr.de>; Fri, 29 Aug 2025 17:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78A061886DF0
	for <lists+cgroups@lfdr.de>; Fri, 29 Aug 2025 15:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59ED342CA7;
	Fri, 29 Aug 2025 15:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/pUjtlN"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C19343213;
	Fri, 29 Aug 2025 15:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756482573; cv=none; b=ckj5ETJTY8bzPxhc6/uwG1eMGlMkM1P4GPDQE8vbwn5gL79ZqxSWRtcr+XD9zx6RZTvWXBg/YassXW65wFdPU8uIlD0KcmWfJHhJ967fXdt5WIZRbWbILNxctosFM4fAOqg8zngh01w/vbVTpnR3TGcxZaP3r3mKOvOGRnfyhTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756482573; c=relaxed/simple;
	bh=EmolSYetz1s/vfgGS0udWvK8bCbBeW5BQ9rcUHulJgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=azgr67X4FhVxRy7RiszL1C6B/K0yo9J2rsNESX5s/SW8kr8PrhvbsTIuSckCSxgFw6fMwoWn+ETNfAWDDP+vL1JArUs/qYKZoRl54EJ5cq1sAzz1TLJtn5cVuTZa0qQcsXCx3ygEWVlWP+csWFwU63KCsiPV9SpmlCeQ5BRaWPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/pUjtlN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BA13C4CEF5;
	Fri, 29 Aug 2025 15:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756482573;
	bh=EmolSYetz1s/vfgGS0udWvK8bCbBeW5BQ9rcUHulJgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X/pUjtlNA3q8T67DkXk64bvz6y4vf1gZ6dHbOkQSJuTI4OF6qrBqu5Azg6hPuGhFm
	 u3YuLghkohNMiRlCWgTxFPn+r7RzhNeUwsX0DPcfpy1DdOwQd7MovxWTkwJ4PlBVnT
	 QFFD1nUfxfhqp/BE2iFnFd0sxdqvXSC2SGI0VyF9fqvD+5kBx4kqStNdTT4HeCTKPh
	 LZIrbLMvl/ZXJnLXM/Ek1PZ4ioC5muDBFSob5aphSZM6Itx38A5pdFvsvqV/omLn/I
	 IQqUr5C2LEXVwhoAxB1qRTVza99aUGghEmAXVK6MjNsSQPDxkwVocHc7TEPuDKgpVg
	 WNwn2SD2W3XHQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>,
	cgroups@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 26/33] cgroup/cpuset: Fail if isolated and nohz_full don't leave any housekeeping
Date: Fri, 29 Aug 2025 17:48:07 +0200
Message-ID: <20250829154814.47015-27-frederic@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829154814.47015-1-frederic@kernel.org>
References: <20250829154814.47015-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Gabriele Monaco <gmonaco@redhat.com>

Currently the user can set up isolated cpus via cpuset and nohz_full in
such a way that leaves no housekeeping CPU (i.e. no CPU that is neither
domain isolated nor nohz full). This can be a problem for other
subsystems (e.g. the timer wheel imgration).

Prevent this configuration by blocking any assignation that would cause
the union of domain isolated cpus and nohz_full to covers all CPUs.

Acked-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/cgroup/cpuset.c | 57 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index df1dfacf5f9d..8260dd699fd8 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1275,6 +1275,19 @@ static void isolated_cpus_update(int old_prs, int new_prs, struct cpumask *xcpus
 		cpumask_andnot(isolated_cpus, isolated_cpus, xcpus);
 }
 
+/*
+ * isolated_cpus_should_update - Returns if the isolated_cpus mask needs update
+ * @prs: new or old partition_root_state
+ * @parent: parent cpuset
+ * Return: true if isolated_cpus needs modification, false otherwise
+ */
+static bool isolated_cpus_should_update(int prs, struct cpuset *parent)
+{
+	if (!parent)
+		parent = &top_cpuset;
+	return prs != parent->partition_root_state;
+}
+
 /*
  * partition_xcpus_add - Add new exclusive CPUs to partition
  * @new_prs: new partition_root_state
@@ -1339,6 +1352,36 @@ static bool partition_xcpus_del(int old_prs, struct cpuset *parent,
 	return isolcpus_updated;
 }
 
+/*
+ * isolcpus_nohz_conflict - check for isolated & nohz_full conflicts
+ * @new_cpus: cpu mask for cpus that are going to be isolated
+ * Return: true if there is conflict, false otherwise
+ *
+ * If nohz_full is enabled and we have isolated CPUs, their combination must
+ * still leave housekeeping CPUs.
+ */
+static bool isolcpus_nohz_conflict(struct cpumask *new_cpus)
+{
+	cpumask_var_t full_hk_cpus;
+	int res = false;
+
+	if (!housekeeping_enabled(HK_TYPE_KERNEL_NOISE))
+		return false;
+
+	if (!alloc_cpumask_var(&full_hk_cpus, GFP_KERNEL))
+		return true;
+
+	cpumask_and(full_hk_cpus, housekeeping_cpumask(HK_TYPE_KERNEL_NOISE),
+		    housekeeping_cpumask(HK_TYPE_DOMAIN));
+	cpumask_andnot(full_hk_cpus, full_hk_cpus, isolated_cpus);
+	cpumask_and(full_hk_cpus, full_hk_cpus, cpu_online_mask);
+	if (!cpumask_weight_andnot(full_hk_cpus, new_cpus))
+		res = true;
+
+	free_cpumask_var(full_hk_cpus);
+	return res;
+}
+
 static void update_housekeeping_cpumask(bool isolcpus_updated)
 {
 	int ret;
@@ -1453,6 +1496,9 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
 	if (!cpumask_intersects(tmp->new_cpus, cpu_active_mask) ||
 	    cpumask_subset(top_cpuset.effective_cpus, tmp->new_cpus))
 		return PERR_INVCPUS;
+	if (isolated_cpus_should_update(new_prs, NULL) &&
+	    isolcpus_nohz_conflict(tmp->new_cpus))
+		return PERR_HKEEPING;
 
 	spin_lock_irq(&callback_lock);
 	isolcpus_updated = partition_xcpus_add(new_prs, NULL, tmp->new_cpus);
@@ -1552,6 +1598,9 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
 		else if (cpumask_intersects(tmp->addmask, subpartitions_cpus) ||
 			 cpumask_subset(top_cpuset.effective_cpus, tmp->addmask))
 			cs->prs_err = PERR_NOCPUS;
+		else if (isolated_cpus_should_update(prs, NULL) &&
+			 isolcpus_nohz_conflict(tmp->addmask))
+			cs->prs_err = PERR_HKEEPING;
 		if (cs->prs_err)
 			goto invalidate;
 	}
@@ -1904,6 +1953,12 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 			return err;
 	}
 
+	if (deleting && isolated_cpus_should_update(new_prs, parent) &&
+	    isolcpus_nohz_conflict(tmp->delmask)) {
+		cs->prs_err = PERR_HKEEPING;
+		return PERR_HKEEPING;
+	}
+
 	/*
 	 * Change the parent's effective_cpus & effective_xcpus (top cpuset
 	 * only).
@@ -2924,6 +2979,8 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 		 * Need to update isolated_cpus.
 		 */
 		isolcpus_updated = true;
+		if (isolcpus_nohz_conflict(cs->effective_xcpus))
+			err = PERR_HKEEPING;
 	} else {
 		/*
 		 * Switching back to member is always allowed even if it
-- 
2.51.0


