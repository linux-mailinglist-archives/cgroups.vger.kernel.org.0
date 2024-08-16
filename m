Return-Path: <cgroups+bounces-4326-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA2495448F
	for <lists+cgroups@lfdr.de>; Fri, 16 Aug 2024 10:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADA7E1C2132A
	for <lists+cgroups@lfdr.de>; Fri, 16 Aug 2024 08:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B02A13C9A9;
	Fri, 16 Aug 2024 08:35:09 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9592B76056;
	Fri, 16 Aug 2024 08:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723797309; cv=none; b=N/jndNFNHXoifH3JCd2t0dao7o/5GhqgLdW61KuvGS/akaEMwe8ScMmtqTT+rtNmBTpW38mVoNuWqlVXeoNEFWsw2dNQbh9l343Y2CEr7wOhrWoXsp2Q5Qj+Bgw5fzs/qg2GVwvvrRZ73J49yRto9wrGGVOKTqxoLHYd1sQqUEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723797309; c=relaxed/simple;
	bh=K0UEXoH/fXxsU2M6msDw9lrpONepQ8q4QEg68oanFc8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EeKASk3IKsGISfN0ZOVTen0ZiwlZy5WgV2YYYvbRioG96pIEwErYBDALER0+QR9YAfTHgrwYZsFUvdc2HOWZ90UvSf8jbLgyRdF6/zn0hGQjF3Yahf7Yg5lHU4LqDswsVeaI+HeDQos6csPWFNl8DwApsUnjNrDpxQ85NxhKF88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WlZtp6mvcz20lrJ;
	Fri, 16 Aug 2024 16:30:26 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 054FD1A016C;
	Fri, 16 Aug 2024 16:35:03 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Fri, 16 Aug
 2024 16:35:02 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<longman@redhat.com>, <adityakali@google.com>, <sergeh@kernel.org>,
	<mkoutny@suse.com>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next 1/3] cgroup/cpuset: Correct invalid remote parition prs
Date: Fri, 16 Aug 2024 08:27:25 +0000
Message-ID: <20240816082727.2779-2-chenridong@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816082727.2779-1-chenridong@huawei.com>
References: <20240816082727.2779-1-chenridong@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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
 kernel/cgroup/cpuset.c | 42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index e34fd6108b06..fdd5346616d3 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -80,6 +80,7 @@ enum prs_errcode {
 	PERR_HOTPLUG,
 	PERR_CPUSEMPTY,
 	PERR_HKEEPING,
+	PERR_PMT,
 };
 
 static const char * const perr_strings[] = {
@@ -91,6 +92,7 @@ static const char * const perr_strings[] = {
 	[PERR_HOTPLUG]   = "No cpu available due to hotplug",
 	[PERR_CPUSEMPTY] = "cpuset.cpus and cpuset.cpus.exclusive are empty",
 	[PERR_HKEEPING]  = "partition config conflicts with housekeeping setup",
+	[PERR_PMT]       = "Enable partition not permitted",
 };
 
 struct cpuset {
@@ -1669,7 +1671,7 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
 	 * The user must have sysadmin privilege.
 	 */
 	if (!capable(CAP_SYS_ADMIN))
-		return 0;
+		return PERR_PMT;
 
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
@@ -3151,24 +3153,26 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 		goto out;
 
 	if (!old_prs) {
-		enum partition_cmd cmd = (new_prs == PRS_ROOT)
-				       ? partcmd_enable : partcmd_enablei;
-
 		/*
-		 * cpus_allowed and exclusive_cpus cannot be both empty.
-		 */
-		if (xcpus_empty(cs)) {
-			err = PERR_CPUSEMPTY;
-			goto out;
-		}
+		* If parent is valid partition, enable local partiion.
+		* Otherwise, enable a remote partition.
+		*/
+		if (is_partition_valid(parent)) {
+			enum partition_cmd cmd = (new_prs == PRS_ROOT)
+					       ? partcmd_enable : partcmd_enablei;
 
-		err = update_parent_effective_cpumask(cs, cmd, NULL, &tmpmask);
-		/*
-		 * If an attempt to become local partition root fails,
-		 * try to become a remote partition root instead.
-		 */
-		if (err && remote_partition_enable(cs, new_prs, &tmpmask))
-			err = 0;
+			/*
+			 * cpus_allowed and exclusive_cpus cannot be both empty.
+			 */
+			if (xcpus_empty(cs)) {
+				err = PERR_CPUSEMPTY;
+				goto out;
+			}
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


