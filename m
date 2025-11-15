Return-Path: <cgroups+bounces-11992-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FE3C602A6
	for <lists+cgroups@lfdr.de>; Sat, 15 Nov 2025 10:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0ED514E3507
	for <lists+cgroups@lfdr.de>; Sat, 15 Nov 2025 09:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8B728032D;
	Sat, 15 Nov 2025 09:47:06 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E954523D7C4;
	Sat, 15 Nov 2025 09:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763200026; cv=none; b=MgA28uqiGwGrgPAYAucl59u6eJHT87EBjA+NpFcZrIlY/E8lie8CaOfzxjiNNxg8NI+SSkSN7t2Dc3ROIbYE6uQxbprm4sfGMmZ2Xrt4XKqDpS0roK+qfR6nRGU0zFz00ECuBT3QKk34oKw3i9mTca6H0vA3l7b2pVxitqp35+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763200026; c=relaxed/simple;
	bh=EM3pYpdZ+L7QcTHZhu5+2yrHYW7d1u5AKf6wrAmmdvc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FCv9e86ygsxQBr28aVGcMWTre4+2QF8BGy7mKroUkIQvQ1JP7t7V89fHkjDqvebIPc2SKh6byME0nXEY+Q33Md9u3RyEJgRrAkq2VIvzf8XWHNRgx6yNidL5TW4ZkrTcHb90nZU6oQknLtrXom3Zsv1y+txXKW+39OxBxkuKh14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d7pzx4xkTzYQtyh;
	Sat, 15 Nov 2025 17:46:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E57451A1480;
	Sat, 15 Nov 2025 17:46:54 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgCnz1zzSxhpfa5HAw--.5650S2;
	Sat, 15 Nov 2025 17:46:54 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH -next] cpuset: treate root invalid trialcs as exclusive
Date: Sat, 15 Nov 2025 09:31:40 +0000
Message-Id: <20251115093140.1121329-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <765120d5-1887-4376-b779-8294df137b9d@huaweicloud.com>
References: <765120d5-1887-4376-b779-8294df137b9d@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnz1zzSxhpfa5HAw--.5650S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAr48Zr48XF45ury8tr17trb_yoW5AFWfpF
	W8Gr45J3yYgryY9w4DKan2g343Ka1kXa47trnxG34rGFy2q3ZFkFyDJ3sxZa43J39rGF18
	Zay2vr42gFnFyrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7IJmUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

A test scenario revealed inconsistent results based on operation order:
Scenario 1:
	#cd /sys/fs/cgroup/
	#mkdir A1
	#mkdir B1
	#echo 1-2 > B1/cpuset.cpus
	#echo 0-1 > A1/cpuset.cpus
	#echo root > A1/cpuset.cpus.partition
	#cat A1/cpuset.cpus.partition
	root invalid (Cpu list in cpuset.cpus not exclusive)

Scenario 2:
	#cd /sys/fs/cgroup/
	#mkdir A1
	#mkdir B1
	#echo 1-2 > B1/cpuset.cpus
	#echo root > A1/cpuset.cpus.partition
	#echo 0-1 > A1/cpuset.cpus
	#cat A1/cpuset.cpus.partition
	root

The second scenario produces an unexpected result: A1 should be marked
as invalid but is incorrectly recognized as valid. This occurs because
when validate_change is invoked, A1 (in root-invalid state) may
automatically transition to a valid partition, with non-exclusive state
checks against siblings, leading to incorrect validation.

To fix this inconsistency, treat trialcs in root-invalid state as exclusive
during validation and set the corresponding exclusive flags, ensuring
consistent behavior regardless of operation order.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index daf813386260..a189f356b5f1 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2526,6 +2526,18 @@ static void partition_cpus_change(struct cpuset *cs, struct cpuset *trialcs,
 	}
 }
 
+static int init_trialcs(struct cpuset *cs, struct cpuset *trialcs)
+{
+	trialcs->prs_err = PERR_NONE;
+	/*
+	 * If partition_root_state != 0, it may automatically change to a partition,
+	 * Therefore, we should treat trialcs as exclusive during validation
+	 */
+	if (trialcs->partition_root_state)
+		set_bit(CS_CPU_EXCLUSIVE, &trialcs->flags);
+	return compute_trialcs_excpus(trialcs, cs);
+}
+
 /**
  * update_cpumask - update the cpus_allowed mask of a cpuset and all tasks in it
  * @cs: the cpuset to consider
@@ -2551,9 +2563,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	if (alloc_tmpmasks(&tmp))
 		return -ENOMEM;
 
-	compute_trialcs_excpus(trialcs, cs);
-	trialcs->prs_err = PERR_NONE;
-
+	init_trialcs(cs, trialcs);
 	retval = cpus_allowed_validate_change(cs, trialcs, &tmp);
 	if (retval < 0)
 		goto out_free;
@@ -2612,7 +2622,7 @@ static int update_exclusive_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	 * Reject the change if there is exclusive CPUs conflict with
 	 * the siblings.
 	 */
-	if (compute_trialcs_excpus(trialcs, cs))
+	if (init_trialcs(cs, trialcs))
 		return -EINVAL;
 
 	/*
@@ -2628,7 +2638,6 @@ static int update_exclusive_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	if (alloc_tmpmasks(&tmp))
 		return -ENOMEM;
 
-	trialcs->prs_err = PERR_NONE;
 	partition_cpus_change(cs, trialcs, &tmp);
 
 	spin_lock_irq(&callback_lock);
-- 
2.34.1


