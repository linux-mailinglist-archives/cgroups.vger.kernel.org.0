Return-Path: <cgroups+bounces-11550-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AF2C2EC27
	for <lists+cgroups@lfdr.de>; Tue, 04 Nov 2025 02:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 10CD434996A
	for <lists+cgroups@lfdr.de>; Tue,  4 Nov 2025 01:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D85023D298;
	Tue,  4 Nov 2025 01:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PLa/5JiM"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D90A212B0A
	for <cgroups@vger.kernel.org>; Tue,  4 Nov 2025 01:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762219865; cv=none; b=ONuxJTlToanbIxmL3313jTTf+yh2izdSZXCHgNUeT8CD6W83H6shAbZ83SicoIEZYYkYqMFAUlKIjG+OGc4VC9K5x6c+WxUZqrqSaDZnry6uKu6VuLh3nOY7RTrVV+yS5aNc2l/u7y8zq6HvNvqxIiaoaymcAPnDlBf+CCfi5BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762219865; c=relaxed/simple;
	bh=bVJs4NiCQEJpq8nnVkrGSp0jNk/jhDmrc1ndtxL98uI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fDnOU3QrGSXTtYjti3bDqaEmi3fU69fVe3rP1C/WXXpv+waI5IPU59fvsIGxJxC/VVZMwaaXN8vr+UQLFWivls37oIhZHXARHQxOVnfOWPxgwgc2L/pTQ33J5khwxV/mDtuov2FqB+YSm6BX2yUpdbADIQRJT+bXkcMsML9nZKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PLa/5JiM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762219863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kkcfk+4cLoRRhXJI8onDbn/lGCMexxDRooewWX6who0=;
	b=PLa/5JiMuEdKUnHEiwDnF1rB2bc91trS9uzq0jC1d12mYLKw9F2fsg/CK15sJKuGiHe0vM
	JbfxhObsbYYVmVWgzp1RIp+ZIkqAaI1CCvGZcyAskB4DpNZ0EBJQiQcvajyWHBFdxRuUmZ
	fwLwrYnbcpv3+1jHwRHLf6wd/gi45+Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-438-NAUPFTVgMBy55a9G8AMMGA-1; Mon,
 03 Nov 2025 20:30:59 -0500
X-MC-Unique: NAUPFTVgMBy55a9G8AMMGA-1
X-Mimecast-MFC-AGG-ID: NAUPFTVgMBy55a9G8AMMGA_1762219855
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2D8A3180120B;
	Tue,  4 Nov 2025 01:30:55 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.81.236])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 494EC30001A1;
	Tue,  4 Nov 2025 01:30:53 +0000 (UTC)
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
Subject: [cgroup/for-6.19 PATCH v2 2/3] cgroup/cpuset: Fail if isolated and nohz_full don't leave any housekeeping
Date: Mon,  3 Nov 2025 20:30:36 -0500
Message-ID: <20251104013037.296013-3-longman@redhat.com>
In-Reply-To: <20251104013037.296013-1-longman@redhat.com>
References: <20251104013037.296013-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Currently the user can set up isolated cpus via cpuset and nohz_full in
such a way that leaves no housekeeping CPU (i.e. no CPU that is neither
domain isolated nor nohz full). This can be a problem for other
subsystems (e.g. the timer wheel imgration).

Prevent this configuration by blocking any assignation that would cause
the union of domain isolated cpus and nohz_full to covers all CPUs.

[longman: Remove isolated_cpus_should_update() and rewrite the checking
 in update_prstate() and update_parent_effective_cpumask(), also add
 prstate_housekeeping_conflict() check in update_prstate() as
 suggested by Chen Ridong]

Originally-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 75 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 74 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index da770dac955e..0c49905df394 100644
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
@@ -2994,7 +3062,12 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 		 * A change in load balance state only, no change in cpumasks.
 		 * Need to update isolated_cpus.
 		 */
-		isolcpus_updated = true;
+		if (((new_prs == PRS_ISOLATED) &&
+		     !isolated_cpus_can_update(cs->effective_xcpus, NULL)) ||
+		    prstate_housekeeping_conflict(new_prs, cs->effective_xcpus))
+			err = PERR_HKEEPING;
+		else
+			isolcpus_updated = true;
 	} else {
 		/*
 		 * Switching back to member is always allowed even if it
-- 
2.51.1


