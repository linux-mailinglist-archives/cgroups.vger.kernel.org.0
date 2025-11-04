Return-Path: <cgroups+bounces-11551-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE73C2EC4C
	for <lists+cgroups@lfdr.de>; Tue, 04 Nov 2025 02:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5410E3B0F1B
	for <lists+cgroups@lfdr.de>; Tue,  4 Nov 2025 01:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5126823D7FD;
	Tue,  4 Nov 2025 01:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b6Hr8d/a"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC9A23C4E0
	for <cgroups@vger.kernel.org>; Tue,  4 Nov 2025 01:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762219866; cv=none; b=kWBkXZefheZG7xLv8nxylIQF5G3VDaI+wHtJs/0AaQDpeI8z5wLoAP+F+wsbASVniKzRRDAjx7z0F2tp9Li8zTqlo/v8a3sAvtZzwe5kYJ1X5JmQzWkErfBFQBGd9e+55rSe8aEtzMap02Cbh1kZ71y3g+N4r/hzEQtKEGwGaTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762219866; c=relaxed/simple;
	bh=v8QKUmbq8i7jSRCrxQg+b3tC8orcXLp5bmBSIzV0x2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pVeV1HvEbg9XKQxPXTqvZwx+Wj3MnYuBFJnV1iYl7MN3up96uUT5eZvuNPBmr16ROB0dPGKiwYgGpRuEubdEPRaMLqcN59thcxi+ndjX37FBsR2Ayw/OvQz2O5b4BcWIVbSn+4D8YbB6wsAI56Bq1cWFQrjmPpd++AVbAWwR2Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b6Hr8d/a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762219863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ljuAAt+TifIm5ca711WY2ieL2DClvpYg6AtN4LW+1io=;
	b=b6Hr8d/atNJ+tTAeK/9lYgVwQ+k9Lm0zmAhgwsqzKe7LlgJIgjCXHL4reWjScfcZ6XrJK4
	dMwdyEx0FM94lSRRhjQClfAX/9Z455PkgwH1EGFnnXBB7ULQzbujsO4gEHYtpPoA6UF3hR
	xtnF56K0m16DNo82bbIlzpeW9B+XAeg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-WynKkvQqNXi38a2k_3HD-Q-1; Mon,
 03 Nov 2025 20:30:59 -0500
X-MC-Unique: WynKkvQqNXi38a2k_3HD-Q-1
X-Mimecast-MFC-AGG-ID: WynKkvQqNXi38a2k_3HD-Q_1762219857
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7E8D61800654;
	Tue,  4 Nov 2025 01:30:57 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.81.236])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7199B30001A1;
	Tue,  4 Nov 2025 01:30:55 +0000 (UTC)
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
Subject: [cgroup/for-6.19 PATCH v2 3/3] cgroup/cpuset: Globally track isolated_cpus update
Date: Mon,  3 Nov 2025 20:30:37 -0500
Message-ID: <20251104013037.296013-4-longman@redhat.com>
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

The current cpuset code passes a local isolcpus_updated flag around in a
number of functions to determine if external isolation related cpumasks
like wq_unbound_cpumask should be updated. It is a bit cumbersome and
makes the code more complex. Simplify the code by using a global boolean
flag "isolated_cpus_updating" to track this. This flag will be set in
isolated_cpus_update() and cleared in update_isolation_cpumasks().

No functional change is expected.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 73 ++++++++++++++++++++----------------------
 1 file changed, 35 insertions(+), 38 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 0c49905df394..854fe4cc1358 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -81,6 +81,13 @@ static cpumask_var_t	subpartitions_cpus;
  */
 static cpumask_var_t	isolated_cpus;
 
+/*
+ * isolated_cpus updating flag (protected by cpuset_mutex)
+ * Set if isolated_cpus is going to be updated in the current
+ * cpuset_mutex crtical section.
+ */
+static bool isolated_cpus_updating;
+
 /*
  * Housekeeping (HK_TYPE_DOMAIN) CPUs at boot
  */
@@ -1327,6 +1334,8 @@ static void isolated_cpus_update(int old_prs, int new_prs, struct cpumask *xcpus
 		cpumask_or(isolated_cpus, isolated_cpus, xcpus);
 	else
 		cpumask_andnot(isolated_cpus, isolated_cpus, xcpus);
+
+	isolated_cpus_updating = true;
 }
 
 /*
@@ -1334,15 +1343,12 @@ static void isolated_cpus_update(int old_prs, int new_prs, struct cpumask *xcpus
  * @new_prs: new partition_root_state
  * @parent: parent cpuset
  * @xcpus: exclusive CPUs to be added
- * Return: true if isolated_cpus modified, false otherwise
  *
  * Remote partition if parent == NULL
  */
-static bool partition_xcpus_add(int new_prs, struct cpuset *parent,
+static void partition_xcpus_add(int new_prs, struct cpuset *parent,
 				struct cpumask *xcpus)
 {
-	bool isolcpus_updated;
-
 	WARN_ON_ONCE(new_prs < 0);
 	lockdep_assert_held(&callback_lock);
 	if (!parent)
@@ -1352,13 +1358,11 @@ static bool partition_xcpus_add(int new_prs, struct cpuset *parent,
 	if (parent == &top_cpuset)
 		cpumask_or(subpartitions_cpus, subpartitions_cpus, xcpus);
 
-	isolcpus_updated = (new_prs != parent->partition_root_state);
-	if (isolcpus_updated)
+	if (new_prs != parent->partition_root_state)
 		isolated_cpus_update(parent->partition_root_state, new_prs,
 				     xcpus);
 
 	cpumask_andnot(parent->effective_cpus, parent->effective_cpus, xcpus);
-	return isolcpus_updated;
 }
 
 /*
@@ -1366,15 +1370,12 @@ static bool partition_xcpus_add(int new_prs, struct cpuset *parent,
  * @old_prs: old partition_root_state
  * @parent: parent cpuset
  * @xcpus: exclusive CPUs to be removed
- * Return: true if isolated_cpus modified, false otherwise
  *
  * Remote partition if parent == NULL
  */
-static bool partition_xcpus_del(int old_prs, struct cpuset *parent,
+static void partition_xcpus_del(int old_prs, struct cpuset *parent,
 				struct cpumask *xcpus)
 {
-	bool isolcpus_updated;
-
 	WARN_ON_ONCE(old_prs < 0);
 	lockdep_assert_held(&callback_lock);
 	if (!parent)
@@ -1383,14 +1384,12 @@ static bool partition_xcpus_del(int old_prs, struct cpuset *parent,
 	if (parent == &top_cpuset)
 		cpumask_andnot(subpartitions_cpus, subpartitions_cpus, xcpus);
 
-	isolcpus_updated = (old_prs != parent->partition_root_state);
-	if (isolcpus_updated)
+	if (old_prs != parent->partition_root_state)
 		isolated_cpus_update(old_prs, parent->partition_root_state,
 				     xcpus);
 
 	cpumask_and(xcpus, xcpus, cpu_active_mask);
 	cpumask_or(parent->effective_cpus, parent->effective_cpus, xcpus);
-	return isolcpus_updated;
 }
 
 /*
@@ -1432,17 +1431,24 @@ static bool isolated_cpus_can_update(struct cpumask *add_cpus,
 	return res;
 }
 
-static void update_isolation_cpumasks(bool isolcpus_updated)
+/*
+ * update_isolation_cpumasks - Update external isolation related CPU masks
+ *
+ * The following external CPU masks will be updated if necessary:
+ * - workqueue unbound cpumask
+ */
+static void update_isolation_cpumasks(void)
 {
 	int ret;
 
-	lockdep_assert_cpus_held();
-
-	if (!isolcpus_updated)
+	if (!isolated_cpus_updating)
 		return;
 
+	lockdep_assert_cpus_held();
+
 	ret = workqueue_unbound_exclude_cpumask(isolated_cpus);
 	WARN_ON_ONCE(ret < 0);
+	isolated_cpus_updating = false;
 }
 
 /**
@@ -1567,8 +1573,6 @@ static inline bool is_local_partition(struct cpuset *cs)
 static int remote_partition_enable(struct cpuset *cs, int new_prs,
 				   struct tmpmasks *tmp)
 {
-	bool isolcpus_updated;
-
 	/*
 	 * The user must have sysadmin privilege.
 	 */
@@ -1595,11 +1599,11 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
 		return PERR_HKEEPING;
 
 	spin_lock_irq(&callback_lock);
-	isolcpus_updated = partition_xcpus_add(new_prs, NULL, tmp->new_cpus);
+	partition_xcpus_add(new_prs, NULL, tmp->new_cpus);
 	list_add(&cs->remote_sibling, &remote_children);
 	cpumask_copy(cs->effective_xcpus, tmp->new_cpus);
 	spin_unlock_irq(&callback_lock);
-	update_isolation_cpumasks(isolcpus_updated);
+	update_isolation_cpumasks();
 	cpuset_force_rebuild();
 	cs->prs_err = 0;
 
@@ -1622,15 +1626,12 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
  */
 static void remote_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
 {
-	bool isolcpus_updated;
-
 	WARN_ON_ONCE(!is_remote_partition(cs));
 	WARN_ON_ONCE(!cpumask_subset(cs->effective_xcpus, subpartitions_cpus));
 
 	spin_lock_irq(&callback_lock);
 	list_del_init(&cs->remote_sibling);
-	isolcpus_updated = partition_xcpus_del(cs->partition_root_state,
-					       NULL, cs->effective_xcpus);
+	partition_xcpus_del(cs->partition_root_state, NULL, cs->effective_xcpus);
 	if (cs->prs_err)
 		cs->partition_root_state = -cs->partition_root_state;
 	else
@@ -1640,7 +1641,7 @@ static void remote_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
 	compute_excpus(cs, cs->effective_xcpus);
 	reset_partition_data(cs);
 	spin_unlock_irq(&callback_lock);
-	update_isolation_cpumasks(isolcpus_updated);
+	update_isolation_cpumasks();
 	cpuset_force_rebuild();
 
 	/*
@@ -1665,7 +1666,6 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
 {
 	bool adding, deleting;
 	int prs = cs->partition_root_state;
-	int isolcpus_updated = 0;
 
 	if (WARN_ON_ONCE(!is_remote_partition(cs)))
 		return;
@@ -1701,9 +1701,9 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
 
 	spin_lock_irq(&callback_lock);
 	if (adding)
-		isolcpus_updated += partition_xcpus_add(prs, NULL, tmp->addmask);
+		partition_xcpus_add(prs, NULL, tmp->addmask);
 	if (deleting)
-		isolcpus_updated += partition_xcpus_del(prs, NULL, tmp->delmask);
+		partition_xcpus_del(prs, NULL, tmp->delmask);
 	/*
 	 * Need to update effective_xcpus and exclusive_cpus now as
 	 * update_sibling_cpumasks() below may iterate back to the same cs.
@@ -1712,7 +1712,7 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
 	if (xcpus)
 		cpumask_copy(cs->exclusive_cpus, xcpus);
 	spin_unlock_irq(&callback_lock);
-	update_isolation_cpumasks(isolcpus_updated);
+	update_isolation_cpumasks();
 	if (adding || deleting)
 		cpuset_force_rebuild();
 
@@ -1793,7 +1793,6 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 	int deleting;	/* Deleting cpus from parent's effective_cpus	*/
 	int old_prs, new_prs;
 	int part_error = PERR_NONE;	/* Partition error? */
-	int isolcpus_updated = 0;
 	struct cpumask *xcpus = user_xcpus(cs);
 	int parent_prs = parent->partition_root_state;
 	bool nocpu;
@@ -2072,14 +2071,12 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 	 * and vice versa.
 	 */
 	if (adding)
-		isolcpus_updated += partition_xcpus_del(old_prs, parent,
-							tmp->addmask);
+		partition_xcpus_del(old_prs, parent, tmp->addmask);
 	if (deleting)
-		isolcpus_updated += partition_xcpus_add(new_prs, parent,
-							tmp->delmask);
+		partition_xcpus_add(new_prs, parent, tmp->delmask);
 
 	spin_unlock_irq(&callback_lock);
-	update_isolation_cpumasks(isolcpus_updated);
+	update_isolation_cpumasks();
 
 	if ((old_prs != new_prs) && (cmd == partcmd_update))
 		update_partition_exclusive_flag(cs, new_prs);
@@ -3102,7 +3099,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	else if (isolcpus_updated)
 		isolated_cpus_update(old_prs, new_prs, cs->effective_xcpus);
 	spin_unlock_irq(&callback_lock);
-	update_isolation_cpumasks(isolcpus_updated);
+	update_isolation_cpumasks();
 
 	/* Force update if switching back to member & update effective_xcpus */
 	update_cpumasks_hier(cs, &tmpmask, !new_prs);
-- 
2.51.1


