Return-Path: <cgroups+bounces-12028-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B62C62332
	for <lists+cgroups@lfdr.de>; Mon, 17 Nov 2025 04:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BCD864EC6D6
	for <lists+cgroups@lfdr.de>; Mon, 17 Nov 2025 03:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0AD298CC0;
	Mon, 17 Nov 2025 03:01:55 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C783E27B4E1;
	Mon, 17 Nov 2025 03:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763348514; cv=none; b=BGcyJIo4S+aGMbFH9jzyj5vzlGY2nGAG7SEX2fRPQ1XU1sJFDfij5j6GLaFBG5io7PAb3vdlgOm140u7PBxVbmBwt7Y528lNFxwRJ8G/N9ji9nIPx+PnoRhqz7ahW17JV9NmBG3rsX1fwG0rVHlIQSK23PePztxvCYcvrO4Ueuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763348514; c=relaxed/simple;
	bh=B6AfoMRJYvLuJ6KjLbTwgzJZkK9LrUOD4QJereZ35C8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mX9jRu30+tuUiKGJrVab5ISHbMh40MbyIEoE8kkyDZ61f4JNO5PDmt/zJgof9+Q71ZpLhWDyUhpDznRfYQ6C+4ZnkQOxdmUahWc/dRluyHwJNHuUG9tkX7pnegi4ulJX0enggsMI5vT8h6anfhbRBq5M9CEpGl1ICWkp3/a+HGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d8svY4KjTzKHMVh;
	Mon, 17 Nov 2025 11:01:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 22C921A13EF;
	Mon, 17 Nov 2025 11:01:38 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgA3lHr5jxpp+kwRBA--.27716S18;
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
Subject: [PATCH -next 16/21] cpuset: use partition_disable for compute_partition_effective_cpumask
Date: Mon, 17 Nov 2025 02:46:22 +0000
Message-Id: <20251117024627.1128037-17-chenridong@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgA3lHr5jxpp+kwRBA--.27716S18
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFWkZF15Ary5Jw45Xw1DJrb_yoW8KF43pF
	n7Ar47GrW5X345u3y7ta97uwn8Gws2q3WqyrnxXw1fXFy7Awn0ya42yaySq3yjqr97W34U
	Z3Z0qr48Ka1xAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Replace the partition invalidation logic in the
compute_partition_effective_cpumask() with a call to partition_disable().

This centralizes partition state management and ensures consistent
handling of partition disable operations throughout the cpuset subsystem.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 29 +++++++----------------------
 1 file changed, 7 insertions(+), 22 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 4e68e8edc827..af2966cd685d 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -174,15 +174,6 @@ static inline bool cs_is_member(const struct cpuset *cs)
 	return cs->partition_root_state == PRS_MEMBER;
 }
 
-/*
- * Callers should hold callback_lock to modify partition_root_state.
- */
-static inline void make_partition_invalid(struct cpuset *cs)
-{
-	if (cs->partition_root_state > 0)
-		cs->partition_root_state = -cs->partition_root_state;
-}
-
 /*
  * Send notification event of whenever partition_root_state changes.
  */
@@ -2114,6 +2105,7 @@ static void compute_partition_effective_cpumask(struct cpuset *cs,
 	struct cgroup_subsys_state *css;
 	struct cpuset *child;
 	bool populated = partition_is_populated(cs, NULL);
+	enum prs_errcode prs_err;
 
 	/*
 	 * Check child partition roots to see if they should be
@@ -2136,24 +2128,17 @@ static void compute_partition_effective_cpumask(struct cpuset *cs,
 		 * partition root.
 		 */
 		WARN_ON_ONCE(is_remote_partition(child));
-		child->prs_err = 0;
+		prs_err = 0;
 		if (!cpumask_subset(child->effective_xcpus,
 				    cs->effective_xcpus))
-			child->prs_err = PERR_INVCPUS;
+			prs_err = PERR_INVCPUS;
 		else if (populated &&
 			 cpumask_subset(new_ecpus, child->effective_xcpus))
-			child->prs_err = PERR_NOCPUS;
-
-		if (child->prs_err) {
-			int old_prs = child->partition_root_state;
+			prs_err = PERR_NOCPUS;
 
-			/*
-			 * Invalidate child partition
-			 */
-			spin_lock_irq(&callback_lock);
-			make_partition_invalid(child);
-			spin_unlock_irq(&callback_lock);
-			notify_partition_change(child, old_prs);
+		if (prs_err) {
+			partition_disable(child, cs, -child->partition_root_state,
+					  prs_err);
 			continue;
 		}
 		cpumask_andnot(new_ecpus, new_ecpus,
-- 
2.34.1


