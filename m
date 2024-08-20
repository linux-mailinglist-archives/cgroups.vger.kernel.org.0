Return-Path: <cgroups+bounces-4366-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F395B957BCB
	for <lists+cgroups@lfdr.de>; Tue, 20 Aug 2024 05:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A27B01F23617
	for <lists+cgroups@lfdr.de>; Tue, 20 Aug 2024 03:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5845C146A96;
	Tue, 20 Aug 2024 03:09:17 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1461950A63;
	Tue, 20 Aug 2024 03:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724123357; cv=none; b=aIFKpi4R2lpTSiz98amkmp8QiX72MnjGENKmJKdaLLEK9P9UIWhVNaImRAUZHVhYYcYqHBB4qN+mrZ97bNSZ5Vn5ylyBlVl6inaVc3C34cbZRlH9U1CfupnwRvnhJNSvsXkSbLhM6hmlMmxsgRs//Ee40yHjUyN8A5S70hN6Lc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724123357; c=relaxed/simple;
	bh=VV+Wh59sYdVaS7hobUVpmOqniW6CX27QZcXWVjqbI8U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DWMgDWL2UTQywbqt4fNrD15OwQlg8NQFI1BJb4H3UN6K5Hnb7QJ+fRStOIUwPyWRTWVlyfN8XGsx6BCC5nivTzu0LbrvJpk9swVxDhU79kbZV+yVxdIApEtBXKprPKW/vvTkAwS0M7lEpOQk57cXpDCVNPsKd0X2yWeUVgTAr/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WnvWt12zbzfbY3;
	Tue, 20 Aug 2024 11:07:06 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 136B114037B;
	Tue, 20 Aug 2024 11:09:06 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Tue, 20 Aug
 2024 11:09:05 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<longman@redhat.com>, <adityakali@google.com>, <sergeh@kernel.org>,
	<mkoutny@suse.com>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 -next 1/3] cgroup/cpuset: Correct invalid remote parition prs
Date: Tue, 20 Aug 2024 03:01:24 +0000
Message-ID: <20240820030126.236997-2-chenridong@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240820030126.236997-1-chenridong@huawei.com>
References: <20240820030126.236997-1-chenridong@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd100013.china.huawei.com (7.221.188.163)

When enable a remote partition, I found that:

cd /sys/fs/cgroup/
mkdir test
mkdir test/test1
echo +cpuset > cgroup.subtree_control
echo +cpuset >  test/cgroup.subtree_control
echo 3 > test/test1/cpuset.cpus
echo root > test/test1/cpuset.cpus.partition
cat test/test1/cpuset.cpus.partition
root invalid (Parent is not a partition root)

The parent of a remote partition could not be a root. This is due to the
emtpy effective_xcpus. It would be better to prompt the message "invalid
cpu list in cpuset.cpus.exclusive".

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index e34fd6108b06..0ae68e0e5733 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -80,6 +80,7 @@ enum prs_errcode {
 	PERR_HOTPLUG,
 	PERR_CPUSEMPTY,
 	PERR_HKEEPING,
+	PERR_ACCESS,
 };
 
 static const char * const perr_strings[] = {
@@ -91,6 +92,7 @@ static const char * const perr_strings[] = {
 	[PERR_HOTPLUG]   = "No cpu available due to hotplug",
 	[PERR_CPUSEMPTY] = "cpuset.cpus and cpuset.cpus.exclusive are empty",
 	[PERR_HKEEPING]  = "partition config conflicts with housekeeping setup",
+	[PERR_ACCESS]    = "Enable partition not permitted",
 };
 
 struct cpuset {
@@ -1655,7 +1657,7 @@ static inline bool is_local_partition(struct cpuset *cs)
  * @cs: the cpuset to update
  * @new_prs: new partition_root_state
  * @tmp: temparary masks
- * Return: 1 if successful, 0 if error
+ * Return: 0 if successful, errcode if error
  *
  * Enable the current cpuset to become a remote partition root taking CPUs
  * directly from the top cpuset. cpuset_mutex must be held by the caller.
@@ -1669,7 +1671,7 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
 	 * The user must have sysadmin privilege.
 	 */
 	if (!capable(CAP_SYS_ADMIN))
-		return 0;
+		return PERR_ACCESS;
 
 	/*
 	 * The requested exclusive_cpus must not be allocated to other
@@ -1683,7 +1685,7 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
 	if (cpumask_empty(tmp->new_cpus) ||
 	    cpumask_intersects(tmp->new_cpus, subpartitions_cpus) ||
 	    cpumask_subset(top_cpuset.effective_cpus, tmp->new_cpus))
-		return 0;
+		return PERR_INVCPUS;
 
 	spin_lock_irq(&callback_lock);
 	isolcpus_updated = partition_xcpus_add(new_prs, NULL, tmp->new_cpus);
@@ -1698,7 +1700,7 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
 	 */
 	update_tasks_cpumask(&top_cpuset, tmp->new_cpus);
 	update_sibling_cpumasks(&top_cpuset, NULL, tmp);
-	return 1;
+	return 0;
 }
 
 /*
@@ -3151,9 +3153,6 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 		goto out;
 
 	if (!old_prs) {
-		enum partition_cmd cmd = (new_prs == PRS_ROOT)
-				       ? partcmd_enable : partcmd_enablei;
-
 		/*
 		 * cpus_allowed and exclusive_cpus cannot be both empty.
 		 */
@@ -3162,13 +3161,18 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 			goto out;
 		}
 
-		err = update_parent_effective_cpumask(cs, cmd, NULL, &tmpmask);
 		/*
-		 * If an attempt to become local partition root fails,
-		 * try to become a remote partition root instead.
+		 * If parent is valid partition, enable local partiion.
+		 * Otherwise, enable a remote partition.
 		 */
-		if (err && remote_partition_enable(cs, new_prs, &tmpmask))
-			err = 0;
+		if (is_partition_valid(parent)) {
+			enum partition_cmd cmd = (new_prs == PRS_ROOT)
+					       ? partcmd_enable : partcmd_enablei;
+
+			err = update_parent_effective_cpumask(cs, cmd, NULL, &tmpmask);
+		} else {
+			err = remote_partition_enable(cs, new_prs, &tmpmask);
+		}
 	} else if (old_prs && new_prs) {
 		/*
 		 * A change in load balance state only, no change in cpumasks.
-- 
2.34.1


