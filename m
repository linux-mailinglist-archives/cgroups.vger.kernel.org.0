Return-Path: <cgroups+bounces-12019-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3D5C62311
	for <lists+cgroups@lfdr.de>; Mon, 17 Nov 2025 04:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68A0B3AFBBD
	for <lists+cgroups@lfdr.de>; Mon, 17 Nov 2025 03:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054C727F00A;
	Mon, 17 Nov 2025 03:01:52 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757282701DA;
	Mon, 17 Nov 2025 03:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763348511; cv=none; b=a52GldI6wSLx4/VjY3uhDsjdLBEjFaZN472X4Kly84TwYPDV903JSyAl3AiJfXMdTzZomlkOIpQqPAHtCBDbRwICz7h8dT4ihWhdv0HunF/XyjnQEKsWQDdGaVIX1ypIGVgYymf1xocZ1qUbYYXj8whRYN4Xun8SuCjUWPMDf1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763348511; c=relaxed/simple;
	bh=xntzMy2mvWxNulh9iYgD8z0U0p6jEzu0/dS6dv8kA3o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kDO29HpBdsoFUppT2tB4QwqRBrcEHRvvKrZvNvuzQ3MmyPIkfy4MQCbxffHNr+LhWTIIPVHrppme4n/CL/SjiUMWNViLWvbHHZrbPntOo+VvQi86kwR4NmajInl6QCyqpNjxa2fX1gQNNYx8cGqcmXigUBY1/ZgHtjZzkbiZMJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d8svL0zzXzYQtxp;
	Mon, 17 Nov 2025 11:01:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 4760D1A1F31;
	Mon, 17 Nov 2025 11:01:38 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgA3lHr5jxpp+kwRBA--.27716S21;
	Mon, 17 Nov 2025 11:01:38 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH -next 19/21] cpuset: simplify the update_prstate() function
Date: Mon, 17 Nov 2025 02:46:25 +0000
Message-Id: <20251117024627.1128037-20-chenridong@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgA3lHr5jxpp+kwRBA--.27716S21
X-Coremail-Antispam: 1UD129KBjvJXoWxXFyxZw47ur45Gr1rAF17Awb_yoWrWrWfpr
	yYkFWIg3yUtr15u34DGan7Zw4Fgws7tryjyr9rW34rX3W2yas2vFyjy39ayay5WF9rG3y5
	Zas0gr48GF47AwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

This patch introduces partition_switch to handle both local partition
and remote partition root state switches between "root" and "isolated".
It first validates the partition viavalidate_partition() to check its
validity. If validation fails, it returns an error and disables the
partition; if validation passes, it enables the partition with the new
root state.

With partition_switch introduced, update_prstate() can be simplified. The
partition-related assignments in update_prstate() are redundant, as these
operations are already handled by partition_enable() and
partition_disable(). They are therefore removed.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 58 +++++++++++++++++-------------------------
 1 file changed, 23 insertions(+), 35 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 8690f144b208..333bd6476370 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1699,6 +1699,24 @@ static void partition_disable(struct cpuset *cs, struct cpuset *parent,
 	notify_partition_change(cs, old_prs);
 }
 
+static int partition_switch(struct cpuset *cs, int new_prs)
+{
+	enum prs_errcode err;
+	struct cpuset *parent;
+
+	lockdep_assert_held(&cpuset_mutex);
+	WARN_ON_ONCE(new_prs < 0 || !is_partition_valid(cs));
+	WARN_ON_ONCE(!cpuset_v2());
+
+	err = validate_partition(cs, new_prs, cs->effective_cpus,
+				 cs->effective_cpus, NULL);
+	if (err)
+		return err;
+	parent = is_remote_partition(cs) ? NULL : parent_cs(cs);
+	partition_enable(cs, parent, new_prs, cs->effective_cpus);
+	return 0;
+}
+
 /**
  * partition_update - Update an existing partition configuration
  * @cs: The cpuset to update
@@ -2938,7 +2956,6 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	int err = PERR_NONE, old_prs = cs->partition_root_state;
 	struct cpuset *parent = parent_cs(cs);
 	struct tmpmasks tmpmask;
-	bool isolcpus_updated = false;
 
 	if (old_prs == new_prs)
 		return 0;
@@ -2987,16 +3004,8 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 		else
 			err = remote_partition_enable(cs, new_prs, &tmpmask);
 	} else if (old_prs && new_prs) {
-		/*
-		 * A change in load balance state only, no change in cpumasks.
-		 * Need to update isolated_cpus.
-		 */
-		if (((new_prs == PRS_ISOLATED) &&
-		     !isolated_cpus_can_update(cs->effective_xcpus, NULL)) ||
-		    prstate_housekeeping_conflict(new_prs, cs->effective_xcpus))
-			err = PERR_HKEEPING;
-		else
-			isolcpus_updated = true;
+		/* Root state switches, eg, root --> isolated */
+		err = partition_switch(cs, new_prs);
 	} else {
 		/*
 		 * Switching back to member is always allowed even if it
@@ -3012,36 +3021,15 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 		 */
 	}
 out:
-	/*
-	 * Make partition invalid & disable CS_CPU_EXCLUSIVE if an error
-	 * happens.
-	 */
-	if (err) {
-		new_prs = -new_prs;
-		update_partition_exclusive_flag(cs, new_prs);
-	}
-
-	spin_lock_irq(&callback_lock);
-	cs->partition_root_state = new_prs;
-	WRITE_ONCE(cs->prs_err, err);
-	if (!is_partition_valid(cs))
-		reset_partition_data(cs);
-	else if (isolcpus_updated)
-		isolated_cpus_update(old_prs, new_prs, cs->effective_xcpus);
-	spin_unlock_irq(&callback_lock);
-	update_isolation_cpumasks();
+	/* Make partition invalid if an error happens */
+	if (err)
+		partition_disable(cs, parent, -new_prs, err);
 
 	/* Force update if switching back to member & update effective_xcpus */
 	update_cpumasks_hier(cs, &tmpmask, !new_prs);
 
-	/* A newly created partition must have effective_xcpus set */
-	WARN_ON_ONCE(!old_prs && (new_prs > 0)
-			      && cpumask_empty(cs->effective_xcpus));
-
 	/* Update sched domains and load balance flag */
 	update_partition_sd_lb(cs, old_prs);
-
-	notify_partition_change(cs, old_prs);
 	if (force_sd_rebuild)
 		rebuild_sched_domains_locked();
 	free_tmpmasks(&tmpmask);
-- 
2.34.1


