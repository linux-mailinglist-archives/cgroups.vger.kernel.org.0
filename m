Return-Path: <cgroups+bounces-11170-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E39BC08CC0
	for <lists+cgroups@lfdr.de>; Sat, 25 Oct 2025 09:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 218844E7836
	for <lists+cgroups@lfdr.de>; Sat, 25 Oct 2025 07:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E072E1744;
	Sat, 25 Oct 2025 07:04:00 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244922DECDF;
	Sat, 25 Oct 2025 07:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761375840; cv=none; b=TNOwkvlQkls3t4erPxxCeRNrh91S0nAEZaRB1cqfHlDpCfHz2LfyqsXbQQ1QUu8+ZjUQhkkeQxKL1UvRJz7vJBbqRf962SNIbOQVCzdMe6IBbSAebvzwDjkS5ow0RMYKQEeALEZfdIVUbVQhhszY/AFJ/fYjOUjSeqfkmXdusGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761375840; c=relaxed/simple;
	bh=hOS7Stm/qFKCvnxwmt3qM9A5ziad4LVbiZAEOzR8Tkc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sn3YDG+dnwC9+7IPaB915Dn3SxV2ZGDfC2pfycfdyQTF/j5bf44SpZhN9WUVeCHr1v0H+C/7fLUW+YejFCPB7b6wYws/uyaxgqbsBAT3Ui6bVSppqr3ub6G4HA2pdYh78vFLxQ+L4cnGeveoFygFXybdj3zuzjeYzWCFHs7aJkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4ctrM718HnzKHMZq;
	Sat, 25 Oct 2025 15:02:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 154C21A125E;
	Sat, 25 Oct 2025 15:03:51 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgCHKUJGdvxovSssBg--.49460S23;
	Sat, 25 Oct 2025 15:03:50 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH RFC v2 21/22] cpuset: simplify update_prstate() function
Date: Sat, 25 Oct 2025 06:48:43 +0000
Message-Id: <20251025064844.495525-22-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251025064844.495525-1-chenridong@huaweicloud.com>
References: <20251025064844.495525-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCHKUJGdvxovSssBg--.49460S23
X-Coremail-Antispam: 1UD129KBjvJXoWxCry7ZF1xJF1rAF18Kw4kWFg_yoW5ur1fpF
	9xCF4xK3yjqw15u34jgan2vw1Fgw4Dtry2yr1DW34Sq3Wayas29Fyjy39ayFW5JF9xG345
	Zas09r48XaySkwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUwuWlUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

The current update_prstate() handles root-isolated partition state
transitions by directly manipulating partition fields. Now that
local[remote]_partition_enable() can fully validate partition and handle
root-isolated transitions, we can simplify the code.

This patch refactors the logic by:
- Calling local[remote]_partition_enable() when new_prs > 0 for
  better code cohesion
- Using partition_disable() when partition errors are detected
- Removing redundant field manipulation since proper interfaces
  already set these fields correctly

The change centralizes partition state management through established
interfaces, eliminating redundancy and improving maintainability.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 28 +++-------------------------
 1 file changed, 3 insertions(+), 25 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 52ef58e94926..42c7ee77d01b 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2898,7 +2898,6 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	int err = PERR_NONE, old_prs = cs->partition_root_state;
 	struct cpuset *parent = parent_cs(cs);
 	struct tmpmasks tmpmask;
-	bool isolcpus_updated = false;
 
 	if (old_prs == new_prs)
 		return 0;
@@ -2916,7 +2915,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	if (err)
 		goto out;
 
-	if (!old_prs) {
+	if (new_prs > 0) {
 		/*
 		 * cpus_allowed and exclusive_cpus cannot be both empty.
 		 */
@@ -2946,14 +2945,6 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 			err = local_partition_enable(cs, new_prs, &tmpmask);
 		else
 			err = remote_partition_enable(cs, new_prs, &tmpmask);
-	} else if (old_prs && new_prs) {
-		/*
-		 * A change in load balance state only, no change in cpumasks.
-		 * Need to update isolated_cpus.
-		 */
-		isolcpus_updated = true;
-		if (prstate_housekeeping_conflict(new_prs, cs->effective_xcpus))
-			err = PERR_HKEEPING;
 	} else {
 		/*
 		 * Switching back to member is always allowed even if it
@@ -2973,20 +2964,8 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	 * Make partition invalid & disable CS_CPU_EXCLUSIVE if an error
 	 * happens.
 	 */
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
-	update_unbound_workqueue_cpumask(isolcpus_updated);
+	if (err)
+		partition_disable(cs, parent, -new_prs, err);
 
 	/* Force update if switching back to member & update effective_xcpus */
 	update_cpumasks_hier(cs, &tmpmask, !new_prs);
@@ -2998,7 +2977,6 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	/* Update sched domains and load balance flag */
 	update_partition_sd_lb(cs, old_prs);
 
-	notify_partition_change(cs, old_prs);
 	if (force_sd_rebuild)
 		rebuild_sched_domains_locked();
 	free_tmpmasks(&tmpmask);
-- 
2.34.1


