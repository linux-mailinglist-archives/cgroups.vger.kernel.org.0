Return-Path: <cgroups+bounces-12713-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C41CDDC81
	for <lists+cgroups@lfdr.de>; Thu, 25 Dec 2025 13:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F181C3080645
	for <lists+cgroups@lfdr.de>; Thu, 25 Dec 2025 12:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA9432570E;
	Thu, 25 Dec 2025 12:46:01 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89C23242A4;
	Thu, 25 Dec 2025 12:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766666760; cv=none; b=cXFh0pqAYlGO+da2WixjNKoi9pbc6s+ZU2xWX/cd3zqyaBM/Fjdrmocp9qkYs/iKs0ioc4B0efhdI7Os/lCwH2GRnDPaJKpC4g5srbctKUPutEoTB1a64/2+w6GlZae4WNn/lmETCNEpBvtEI2HkDWeDejjmFOcVNxW4NiHjpMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766666760; c=relaxed/simple;
	bh=MXyGhiP8Ypkw+qa7sBXRPy6LWOA4tDDAUtV6YiFZV+c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ualMs+ytKwFBrud10A0b3RuZMRUdr+y/UHheLJUs6j2mLfT2jRFZtJWBjBB90dF1gyBuHBBU18pkIl0pYY1SWaHh3vNP3Z85PWeBpDFQZ9wD9a8SEtHttYFUDsc7eAR5j67r9mq3CD1Ga+Dl+5lnjC/3K/swRj9dBhL8jczjxiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dcT4B5hDczKHMlT;
	Thu, 25 Dec 2025 20:45:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 25E6B40574;
	Thu, 25 Dec 2025 20:45:52 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgDHdfb1MU1pT76_BQ--.27441S21;
	Thu, 25 Dec 2025 20:45:52 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huaweicloud.com
Subject: [PATCH RESEND -next 19/21] cpuset: simplify the update_prstate() function
Date: Thu, 25 Dec 2025 12:30:56 +0000
Message-Id: <20251225123058.231765-20-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251225123058.231765-1-chenridong@huaweicloud.com>
References: <20251225123058.231765-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHdfb1MU1pT76_BQ--.27441S21
X-Coremail-Antispam: 1UD129KBjvJXoWxXFyxZw47Zw43Jw4xGry7Awb_yoWrWrWfpr
	yYkFWIgFWUtr15u3s8Gan7uw4Fgw4ktFyjyr9xW34rX3W2yas29Fyjy39ayay5WF9rG3y5
	Z3Z0gr48GF47AwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUAV
	WUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr
	1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUvYLPU
	UUUU=
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
index 9a7b02d79fee..7f46cead4d97 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1538,6 +1538,24 @@ static void partition_disable(struct cpuset *cs, struct cpuset *parent,
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
@@ -2784,7 +2802,6 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	int err = PERR_NONE, old_prs = cs->partition_root_state;
 	struct cpuset *parent = parent_cs(cs);
 	struct tmpmasks tmpmask;
-	bool isolcpus_updated = false;
 
 	if (old_prs == new_prs)
 		return 0;
@@ -2833,16 +2850,8 @@ static int update_prstate(struct cpuset *cs, int new_prs)
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
@@ -2858,36 +2867,15 @@ static int update_prstate(struct cpuset *cs, int new_prs)
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


