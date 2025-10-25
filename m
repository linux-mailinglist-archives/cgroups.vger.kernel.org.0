Return-Path: <cgroups+bounces-11175-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 817E8C08CE7
	for <lists+cgroups@lfdr.de>; Sat, 25 Oct 2025 09:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A7172351C9B
	for <lists+cgroups@lfdr.de>; Sat, 25 Oct 2025 07:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C31F2DC33D;
	Sat, 25 Oct 2025 07:04:04 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53262E5439;
	Sat, 25 Oct 2025 07:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761375844; cv=none; b=VfvqklJ5JvlbdUO8jmevHFNa+iGVYlnoM3qxTafoNCvKo5frnIurcS1cmEPF/b88ulIrOSWfTqc0FqXHwm2DEGNEXjhh7OSIcpT01D+bKztKL9s1crX4h1zTXxe1S890EQkdTUJUgQxeYR24+e3r3BdX5qYOM6672XBOBVHeg14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761375844; c=relaxed/simple;
	bh=8FdZFd0nxHGm1suuqsXqXCQU90miy4IHPwSr/eS/AB0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZVDTf2JrctSO7ef5mUod+Hrt8G3kcuB07wpBlsrQpMEyUwvNFVCce3x5L2MycOlBubtdG+4rScKTVZTlmfixuKyNt43ASUyYFBLCfK5V7LNVQ0AugfF52q/vCakfWmMsSCTqj2SiHhFk/BRCBk3EISZWppxcmagMdorTl3aFzcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4ctrLz6y9lzYQtwS;
	Sat, 25 Oct 2025 15:02:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id D79A31A1259;
	Sat, 25 Oct 2025 15:03:50 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgCHKUJGdvxovSssBg--.49460S20;
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
Subject: [PATCH RFC v2 18/22] cpuset: use partition_disable for compute_partition_effective_cpumask
Date: Sat, 25 Oct 2025 06:48:40 +0000
Message-Id: <20251025064844.495525-19-chenridong@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgCHKUJGdvxovSssBg--.49460S20
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFWkZF15Ary5Jw45Xw1DJrb_yoW8KF43pF
	n7Ar47GrW5X345u39rta97uwn8Gws2q3Wqyr13Xw1fXFy7Awn0ka42yaySqFWjqr97WryU
	Z3Z0qr48KanrAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Replace the partition invalidation logic in the
compute_partition_effective_cpumask() with a call to partition_disable().

This centralizes partition state management and ensures consistent
handling of partition disable operations throughout the cpuset subsystem.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 29 +++++++----------------------
 1 file changed, 7 insertions(+), 22 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index e60a774a3654..fb1b332ee145 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -170,15 +170,6 @@ static inline bool cs_is_member(const struct cpuset *cs)
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
@@ -2062,6 +2053,7 @@ static void compute_partition_effective_cpumask(struct cpuset *cs,
 	struct cgroup_subsys_state *css;
 	struct cpuset *child;
 	bool populated = partition_is_populated(cs, NULL);
+	enum prs_errcode prs_err;
 
 	/*
 	 * Check child partition roots to see if they should be
@@ -2084,24 +2076,17 @@ static void compute_partition_effective_cpumask(struct cpuset *cs,
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


