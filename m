Return-Path: <cgroups+bounces-11579-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1722C33F0F
	for <lists+cgroups@lfdr.de>; Wed, 05 Nov 2025 05:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C59D218C4D6E
	for <lists+cgroups@lfdr.de>; Wed,  5 Nov 2025 04:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7FC27AC4C;
	Wed,  5 Nov 2025 04:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ba71Yriy"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7D5276058
	for <cgroups@vger.kernel.org>; Wed,  5 Nov 2025 04:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762317567; cv=none; b=KZiRnnikIYo5U+mCg17sHjnB1RWakxzNJvjmXC80CT8wq5R8NTHDyhn+CoV0X34uZOTvGgZg0OsRl3glHciChiAZ8275HqdH5g5cVxcRM4HVO1ImJawsCgsfwynsTpc6HRoMaQ9EAxLs09PFnZEB5faJ4tgModKsVrdr5BrfEo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762317567; c=relaxed/simple;
	bh=PRMJcyYJl61mZBeSGGgiHzEd0shtT9jlqiAi1ex1Arw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WWXTG53yufRaUvZb/m73KJUuedFLq0j10gqO0RHsTixjEPTk4l2XQDkE4c59KNsvyUKVCDxd2j7fzLsEELzraxGQXhXPrW+3V/UM6Svf8vqVq49IJYPcji6ggkPyQSFatGyZAM7rBFZ/OzFrTwScT1lY20Wo/D3sD+6H17qPQrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ba71Yriy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762317565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wQG5O0jywdiZSfV+8D+TD6Dmb/AbN0MrtQRlMhnkX3c=;
	b=Ba71YriyOC2kUBcLbjLHLKNRnRZloaj3cz8H2KAqjDJYbmbLpDrRzslbJ3SJ0X2pYw53WO
	AfZRmbLkqBy96z9JIfKdPXGoc2IhvDv/jzf3+Itknw3lHxMKfspP/ev8REbwSKj1oK9EBg
	ukXBc9arwQtYti2+zuCfSoGD4pdLTu8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517--pHnmFIJO1CImlX9mI_A5w-1; Tue,
 04 Nov 2025 23:39:19 -0500
X-MC-Unique: -pHnmFIJO1CImlX9mI_A5w-1
X-Mimecast-MFC-AGG-ID: -pHnmFIJO1CImlX9mI_A5w_1762317558
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DAB1118011EF;
	Wed,  5 Nov 2025 04:39:17 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.89.34])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 33E18195608E;
	Wed,  5 Nov 2025 04:39:16 +0000 (UTC)
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
Subject: [cgroup/for-6.19 PATCH v3 5/5] cgroup/cpuset: Globally track isolated_cpus update
Date: Tue,  4 Nov 2025 23:38:48 -0500
Message-ID: <20251105043848.382703-6-longman@redhat.com>
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

The current cpuset code passes a local isolcpus_updated flag around in a
number of functions to determine if external isolation related cpumasks
like wq_unbound_cpumask should be updated. It is a bit cumbersome and
makes the code more complex. Simplify the code by using a global boolean
flag "isolated_cpus_updating" to track this. This flag will be set in
isolated_cpus_update() and cleared in update_isolation_cpumasks().

No functional change is expected.

Signed-off-by: Waiman Long <longman@redhat.com>
Reviewed-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 73 ++++++++++++++++++++----------------------
 1 file changed, 35 insertions(+), 38 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 2daf58bf0bbb..90288efe5367 100644
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
@@ -1452,17 +1451,24 @@ static bool prstate_housekeeping_conflict(int prstate, struct cpumask *new_cpus)
 	return false;
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
@@ -1587,8 +1593,6 @@ static inline bool is_local_partition(struct cpuset *cs)
 static int remote_partition_enable(struct cpuset *cs, int new_prs,
 				   struct tmpmasks *tmp)
 {
-	bool isolcpus_updated;
-
 	/*
 	 * The user must have sysadmin privilege.
 	 */
@@ -1616,11 +1620,11 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
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
 
@@ -1643,15 +1647,12 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
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
@@ -1661,7 +1662,7 @@ static void remote_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
 	compute_excpus(cs, cs->effective_xcpus);
 	reset_partition_data(cs);
 	spin_unlock_irq(&callback_lock);
-	update_isolation_cpumasks(isolcpus_updated);
+	update_isolation_cpumasks();
 	cpuset_force_rebuild();
 
 	/*
@@ -1686,7 +1687,6 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
 {
 	bool adding, deleting;
 	int prs = cs->partition_root_state;
-	int isolcpus_updated = 0;
 
 	if (WARN_ON_ONCE(!is_remote_partition(cs)))
 		return;
@@ -1722,9 +1722,9 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
 
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
@@ -1733,7 +1733,7 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
 	if (xcpus)
 		cpumask_copy(cs->exclusive_cpus, xcpus);
 	spin_unlock_irq(&callback_lock);
-	update_isolation_cpumasks(isolcpus_updated);
+	update_isolation_cpumasks();
 	if (adding || deleting)
 		cpuset_force_rebuild();
 
@@ -1794,7 +1794,6 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 	int deleting;	/* Deleting cpus from parent's effective_cpus	*/
 	int old_prs, new_prs;
 	int part_error = PERR_NONE;	/* Partition error? */
-	int isolcpus_updated = 0;
 	struct cpumask *xcpus = user_xcpus(cs);
 	int parent_prs = parent->partition_root_state;
 	bool nocpu;
@@ -2073,14 +2072,12 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
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
@@ -3103,7 +3100,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	else if (isolcpus_updated)
 		isolated_cpus_update(old_prs, new_prs, cs->effective_xcpus);
 	spin_unlock_irq(&callback_lock);
-	update_isolation_cpumasks(isolcpus_updated);
+	update_isolation_cpumasks();
 
 	/* Force update if switching back to member & update effective_xcpus */
 	update_cpumasks_hier(cs, &tmpmask, !new_prs);
-- 
2.51.1


