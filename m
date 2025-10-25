Return-Path: <cgroups+bounces-11173-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A660FC08CEA
	for <lists+cgroups@lfdr.de>; Sat, 25 Oct 2025 09:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F0BE1897EA4
	for <lists+cgroups@lfdr.de>; Sat, 25 Oct 2025 07:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC2D2F1FD5;
	Sat, 25 Oct 2025 07:04:04 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B0C2E3B03;
	Sat, 25 Oct 2025 07:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761375843; cv=none; b=p6pLTD0SLbvoZOaiUD34MdO+PQ1Q7VHfOwo3j+dBXPAhuSwP19GczW2f4cbRVvcOzddQhN+aV11jN7wpIGQlKCxZaSMkjCJEjtA2n2dWt8O+qCw2cIr3aXusaEN5NqNBzENdUh2ksXdx7Ubfr5hnZcbUXK9QEh2XDTbBff1vFrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761375843; c=relaxed/simple;
	bh=ekgS+jZiOyBlWnTKH5eHUTlgI96TfeJ3HmE303xch30=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pnfdnyYHEzB+pndv7IJLbcY1BcvIiRhspBSK9CEWXjy0S0lCtRl1ezzJ58QOBGZTz/TxHR0Et9utVtNuisgWQ2OVZrnFMJlaT7CH3zNXf22GpsNTOIbbqKHcOTVkwMAU5ZTq0vZ9IS66iqUMhsIORfNGnfbM7AJv0g7X+rbIHWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4ctrLz6lhCzYQtwM;
	Sat, 25 Oct 2025 15:02:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id CE64D1A0E86;
	Sat, 25 Oct 2025 15:03:50 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgCHKUJGdvxovSssBg--.49460S19;
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
Subject: [PATCH RFC v2 17/22] cpuset: unify local partition disable and invalidate
Date: Sat, 25 Oct 2025 06:48:39 +0000
Message-Id: <20251025064844.495525-18-chenridong@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgCHKUJGdvxovSssBg--.49460S19
X-Coremail-Antispam: 1UD129KBjvJXoWxurWUZr45uF47Zw43uw1rWFg_yoW5Ww4UpF
	y3Cr42qrWUJFy5u347JFs7C34rKwnrXa9FywnxX3WrJF12y3Wvya40y3s7Za45XF9rGryU
	Z3Z09r48X3W2kwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	x0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUwuWlUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

The local_partition_invalidate() and local_partition_disable() functions
contain similar logic that can be unified into a single implementation.
This patch consolidates both functions into local_partition_disable(),
creating symmetry with the existing remote_partition_disable() function.

This refactoring reduces code duplication and establishes a consistent
interface for partition disable operations across both local and remote
partition types.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 38 ++------------------------------------
 1 file changed, 2 insertions(+), 36 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 3d4f2dc63c50..e60a774a3654 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1956,40 +1956,6 @@ static void local_partition_disable(struct cpuset *cs, enum prs_errcode part_err
 	}
 }
 
-/**
- * local_partition_invalidate - Invalidate a local partition
- * @cs: Target cpuset (local partition root) to invalidate
- * @tmp: Temporary masks
- */
-static void local_partition_invalidate(struct cpuset *cs, struct tmpmasks *tmp)
-{
-	struct cpumask *xcpus = user_xcpus(cs);
-	struct cpuset *parent = parent_cs(cs);
-	int new_prs = cs->partition_root_state;
-	bool cpumask_updated = false;
-
-	lockdep_assert_held(&cpuset_mutex);
-	WARN_ON_ONCE(is_remote_partition(cs));	/* For local partition only */
-
-	if (!is_partition_valid(cs))
-		return;
-
-	/*
-	 * Make the current partition invalid.
-	 */
-	if (is_partition_valid(parent))
-		cpumask_updated = cpumask_and(tmp->addmask,
-					      xcpus, parent->effective_xcpus);
-	if (cs->partition_root_state > 0)
-		new_prs = -cs->partition_root_state;
-
-	partition_disable(cs, parent, new_prs, cs->prs_err);
-	if (cpumask_updated) {
-		cpuset_update_tasks_cpumask(parent, tmp->addmask);
-		update_sibling_cpumasks(parent, cs, tmp);
-	}
-}
-
 /**
  * __local_partition_update - Update local partition configuration
  * @cs: Target cpuset to update
@@ -2437,7 +2403,7 @@ static int cpus_allowed_validate_change(struct cpuset *cs, struct cpuset *trialc
 			if (is_partition_valid(cp) &&
 			    cpumask_intersects(xcpus, cp->effective_xcpus)) {
 				rcu_read_unlock();
-				local_partition_invalidate(cp, tmp);
+				local_partition_disable(cp, PERR_NOTEXCL, tmp);
 				rcu_read_lock();
 			}
 		}
@@ -2477,7 +2443,7 @@ static void partition_cpus_change(struct cpuset *cs, struct cpuset *trialcs,
 					   trialcs->effective_xcpus, tmp);
 	} else {
 		if (trialcs->prs_err)
-			local_partition_invalidate(cs, tmp);
+			local_partition_disable(cs, trialcs->prs_err, tmp);
 		else
 			__local_partition_update(cs, trialcs->exclusive_cpus,
 						 trialcs->effective_xcpus, tmp, false);
-- 
2.34.1


