Return-Path: <cgroups+bounces-11576-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5334AC33EF8
	for <lists+cgroups@lfdr.de>; Wed, 05 Nov 2025 05:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 571ED4E4C2E
	for <lists+cgroups@lfdr.de>; Wed,  5 Nov 2025 04:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8136526A1AB;
	Wed,  5 Nov 2025 04:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VxHpr1+F"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76308261B83
	for <cgroups@vger.kernel.org>; Wed,  5 Nov 2025 04:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762317559; cv=none; b=D/GxHbY3an70V9ynfUFGWCW6hDK5QKa40eIDLXggMIrQ3+bX1PI99W0r8afUYcadW/m/2pDUA1i7Twh0g6rHKcE9mjAzvWTC7h7pQ0UYrt681CNCqtYmOIpnrvjzltUrycSDrdoWyfau46qHbRBH3hMfVs1NCDx//mrRPgUuJnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762317559; c=relaxed/simple;
	bh=FsDVuL4So5hYAjbKQr5dfptz8aZ5cBKhnkvvsXZclPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fQ1lflB4iCRfUOx1JjTOY7nXBOCQ8lujSgIh5qo/77SEzUbU3NoSJ1dssO/XSWqPpYjGND4QbDeEYfYxI5O2uyTrUkXxAt+lwp1nB2yM1bvU7DjUfwyn3zfHeA2+Z/rTS3pG8cESSoLPHRKbpbNuWDjDOR3xMvCpmEmXIFZl8Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VxHpr1+F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762317556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=56SeQtccCrfekrGgrecCjJvwM5GooUSBGQW14sYuREc=;
	b=VxHpr1+FwjrJ1tPwnhY4S5aFfuPgh5iZsDpeZkL72cxLdXns1pCYIBzh2HHms54Jkyt1dp
	OZLUSRFPugbsLhyEAeKhdvvNfZx3A+bMRbLVoDlIrBdnEU9lUB4CaaL85p5UpgaivgI6cW
	HMS2Wrpcjqgg2ErymeBz7YGdRHgn8h8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-287-69ZcZ23TOwuaBMR7Fw-poA-1; Tue,
 04 Nov 2025 23:39:13 -0500
X-MC-Unique: 69ZcZ23TOwuaBMR7Fw-poA-1
X-Mimecast-MFC-AGG-ID: 69ZcZ23TOwuaBMR7Fw-poA_1762317552
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7D93518011EF;
	Wed,  5 Nov 2025 04:39:11 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.89.34])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 463B5195608E;
	Wed,  5 Nov 2025 04:39:09 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ridong <chenridong@huawei.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Waiman Long <longman@redhat.com>
Subject: [cgroup/for-6.19 PATCH v3 2/5] cgroup/cpuset: Fail if isolated and nohz_full don't leave any housekeeping
Date: Tue,  4 Nov 2025 23:38:45 -0500
Message-ID: <20251105043848.382703-3-longman@redhat.com>
In-Reply-To: <20251105043848.382703-1-longman@redhat.com>
References: <20251105043848.382703-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Currently the user can set up isolated cpus via cpuset and nohz_full in
such a way that leaves no housekeeping CPU (i.e. no CPU that is neither
domain isolated nor nohz full). This can be a problem for other
subsystems (e.g. the timer wheel imgration).

Prevent this configuration by blocking any assignation that would cause
the union of domain isolated cpus and nohz_full to covers all CPUs.

[longman: Remove isolated_cpus_should_update() and rewrite the checking
 in update_prstate() and update_parent_effective_cpumask()]

Originally-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 74 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index da770dac955e..99622e90991a 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1393,6 +1393,45 @@ static bool partition_xcpus_del(int old_prs, struct cpuset *parent,
 	return isolcpus_updated;
 }
 
+/*
+ * isolated_cpus_can_update - check for isolated & nohz_full conflicts
+ * @add_cpus: cpu mask for cpus that are going to be isolated
+ * @del_cpus: cpu mask for cpus that are no longer isolated, can be NULL
+ * Return: false if there is conflict, true otherwise
+ *
+ * If nohz_full is enabled and we have isolated CPUs, their combination must
+ * still leave housekeeping CPUs.
+ *
+ * TBD: Should consider merging this function into
+ *      prstate_housekeeping_conflict().
+ */
+static bool isolated_cpus_can_update(struct cpumask *add_cpus,
+				     struct cpumask *del_cpus)
+{
+	cpumask_var_t full_hk_cpus;
+	int res = true;
+
+	if (!housekeeping_enabled(HK_TYPE_KERNEL_NOISE))
+		return true;
+
+	if (del_cpus && cpumask_weight_and(del_cpus,
+			housekeeping_cpumask(HK_TYPE_KERNEL_NOISE)))
+		return true;
+
+	if (!alloc_cpumask_var(&full_hk_cpus, GFP_KERNEL))
+		return false;
+
+	cpumask_and(full_hk_cpus, housekeeping_cpumask(HK_TYPE_KERNEL_NOISE),
+		    housekeeping_cpumask(HK_TYPE_DOMAIN));
+	cpumask_andnot(full_hk_cpus, full_hk_cpus, isolated_cpus);
+	cpumask_and(full_hk_cpus, full_hk_cpus, cpu_active_mask);
+	if (!cpumask_weight_andnot(full_hk_cpus, add_cpus))
+		res = false;
+
+	free_cpumask_var(full_hk_cpus);
+	return res;
+}
+
 static void update_isolation_cpumasks(bool isolcpus_updated)
 {
 	int ret;
@@ -1551,6 +1590,9 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
 	if (!cpumask_intersects(tmp->new_cpus, cpu_active_mask) ||
 	    cpumask_subset(top_cpuset.effective_cpus, tmp->new_cpus))
 		return PERR_INVCPUS;
+	if ((new_prs == PRS_ISOLATED) &&
+	    !isolated_cpus_can_update(tmp->new_cpus, NULL))
+		return PERR_HKEEPING;
 
 	spin_lock_irq(&callback_lock);
 	isolcpus_updated = partition_xcpus_add(new_prs, NULL, tmp->new_cpus);
@@ -1650,6 +1692,9 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
 		else if (cpumask_intersects(tmp->addmask, subpartitions_cpus) ||
 			 cpumask_subset(top_cpuset.effective_cpus, tmp->addmask))
 			cs->prs_err = PERR_NOCPUS;
+		else if ((prs == PRS_ISOLATED) &&
+			 !isolated_cpus_can_update(tmp->addmask, tmp->delmask))
+			cs->prs_err = PERR_HKEEPING;
 		if (cs->prs_err)
 			goto invalidate;
 	}
@@ -1750,6 +1795,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 	int part_error = PERR_NONE;	/* Partition error? */
 	int isolcpus_updated = 0;
 	struct cpumask *xcpus = user_xcpus(cs);
+	int parent_prs = parent->partition_root_state;
 	bool nocpu;
 
 	lockdep_assert_held(&cpuset_mutex);
@@ -1813,6 +1859,10 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 		if (prstate_housekeeping_conflict(new_prs, xcpus))
 			return PERR_HKEEPING;
 
+		if ((new_prs == PRS_ISOLATED) && (new_prs != parent_prs) &&
+		    !isolated_cpus_can_update(xcpus, NULL))
+			return PERR_HKEEPING;
+
 		if (tasks_nocpu_error(parent, cs, xcpus))
 			return PERR_NOCPUS;
 
@@ -1866,6 +1916,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 		 *
 		 * For invalid partition:
 		 *   delmask = newmask & parent->effective_xcpus
+		 *   The partition may become valid soon.
 		 */
 		if (is_partition_invalid(cs)) {
 			adding = false;
@@ -1880,6 +1931,23 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 			deleting = cpumask_and(tmp->delmask, tmp->delmask,
 					       parent->effective_xcpus);
 		}
+
+		/*
+		 * TBD: Invalidate a currently valid child root partition may
+		 * still break isolated_cpus_can_update() rule if parent is an
+		 * isolated partition.
+		 */
+		if (is_partition_valid(cs) && (old_prs != parent_prs)) {
+			if ((parent_prs == PRS_ROOT) &&
+			    /* Adding to parent means removing isolated CPUs */
+			    !isolated_cpus_can_update(tmp->delmask, tmp->addmask))
+				part_error = PERR_HKEEPING;
+			if ((parent_prs == PRS_ISOLATED) &&
+			    /* Adding to parent means adding isolated CPUs */
+			    !isolated_cpus_can_update(tmp->addmask, tmp->delmask))
+				part_error = PERR_HKEEPING;
+		}
+
 		/*
 		 * The new CPUs to be removed from parent's effective CPUs
 		 * must be present.
@@ -2994,7 +3062,11 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 		 * A change in load balance state only, no change in cpumasks.
 		 * Need to update isolated_cpus.
 		 */
-		isolcpus_updated = true;
+		if ((new_prs == PRS_ISOLATED) &&
+		    !isolated_cpus_can_update(cs->effective_xcpus, NULL))
+			err = PERR_HKEEPING;
+		else
+			isolcpus_updated = true;
 	} else {
 		/*
 		 * Switching back to member is always allowed even if it
-- 
2.51.1


