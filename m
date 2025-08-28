Return-Path: <cgroups+bounces-9472-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8142FB39E51
	for <lists+cgroups@lfdr.de>; Thu, 28 Aug 2025 15:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C62A21C284BD
	for <lists+cgroups@lfdr.de>; Thu, 28 Aug 2025 13:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FA23128C2;
	Thu, 28 Aug 2025 13:11:37 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65D43112D4;
	Thu, 28 Aug 2025 13:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756386697; cv=none; b=klnB5jNv1wV3NTqWh8ONdqaJAOG64PCbLNoAAr5KcvVjwxZTXWmUymUeCrwXvpLi/lWSGCoLMV1Ytc5tD8y4Iov7zSF8ngZ5Y0n/Lkzx4jicch9Q6eFSDZabuRKy2PqchzBi46BkT7byq3+HAMC1DY9vsBeLMPVibG4ly2InoZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756386697; c=relaxed/simple;
	bh=MIwvenIyRzIuYB4aPHRCVY8emdLN4vI3Dbo74Uo4ruU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V8e4aIwqPj+ntF9n7cvNwBKdVF6TD04lveCGn3V+vHTV8v5kTBlHcTUhzoCg0Iy+N0HJLA77ZEHg9zljH43SYmnEQCsFLVuP1reV4PTKYPMJRMU4tKHrKwfa0tciC3zh19Iqr01cUyjXWFR8MdVjyjEP/pS0jUas+Z+NwZ1/7CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cCMH76mZrzKHNKH;
	Thu, 28 Aug 2025 21:11:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id A17171A1372;
	Thu, 28 Aug 2025 21:11:31 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP3 (Coremail) with SMTP id _Ch0CgBX8mlsVbBoQsxPAg--.40352S8;
	Thu, 28 Aug 2025 21:11:31 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH -next RFC 06/11] cpuset: introduce cpus_excl_conflict and mems_excl_conflict helpers
Date: Thu, 28 Aug 2025 12:56:26 +0000
Message-Id: <20250828125631.1978176-7-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828125631.1978176-1-chenridong@huaweicloud.com>
References: <20250828125631.1978176-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBX8mlsVbBoQsxPAg--.40352S8
X-Coremail-Antispam: 1UD129KBjvJXoWxWFy5Aw4fAF1UAFW5XFyDtrb_yoW5uFyxpF
	W8ArW2kayjgr17Gw43Kwn2grZYgw40qFnFkw15Xr1fAry7GF12vwn5XwnxAFy3JrZ5G3y5
	tFZ3tw4S9F9xJrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1l_M7UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

This patch adds cpus_excl_conflict() and mems_excl_conflict() helper
functions to improve code readability and maintainability. The exclusive
conflict checking follows these rules:

1. If either cpuset has the 'exclusive' flag set, their user_xcpus must
   not have any overlap.
2. If both cpusets are non-exclusive, their 'cpuset.cpus.exclusive' values
   must not intersect.
3. The 'cpuset.cpus' of one cpuset must not form a subset of another
   cpuset's 'cpuset.cpus.exclusive'.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 62 ++++++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 30 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 5dd1e9552000..5cfc53fe717c 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -584,6 +584,35 @@ static inline bool cpusets_are_exclusive(struct cpuset *cs1, struct cpuset *cs2)
 	return true;
 }
 
+static inline bool cpus_excl_conflict(struct cpuset *cs1, struct cpuset *cs2)
+{
+	/* One is exclusive, they must be exclusive */
+	if (is_cpu_exclusive(cs1) || is_cpu_exclusive(cs2))
+		return !cpusets_are_exclusive(cs1, cs2);
+
+	/* Exclusive_cpus can not have intersects*/
+	if (cpumask_intersects(cs1->exclusive_cpus, cs2->exclusive_cpus))
+		return true;
+
+	/* One cpus_allowed can not be a subset of another's cpuset.effective_cpus */
+	if (!cpumask_empty(cs1->cpus_allowed) &&
+	    cpumask_subset(cs1->cpus_allowed, cs2->exclusive_cpus))
+		return true;
+
+	if (!cpumask_empty(cs2->cpus_allowed) &&
+	    cpumask_subset(cs2->cpus_allowed, cs1->exclusive_cpus))
+		return true;
+
+	return false;
+}
+
+static inline bool mems_excl_conflict(struct cpuset *cs1, struct cpuset *cs2)
+{
+	if ((is_mem_exclusive(cs1) || is_mem_exclusive(cs2)))
+		return nodes_intersects(cs1->mems_allowed, cs2->mems_allowed);
+	return false;
+}
+
 /*
  * validate_change() - Used to validate that any proposed cpuset change
  *		       follows the structural rules for cpusets.
@@ -665,38 +694,11 @@ static int validate_change(struct cpuset *cur, struct cpuset *trial)
 	 */
 	ret = -EINVAL;
 	cpuset_for_each_child(c, css, par) {
-		bool txset, cxset;	/* Are exclusive_cpus set? */
-
 		if (c == cur)
 			continue;
-
-		txset = !cpumask_empty(trial->exclusive_cpus);
-		cxset = !cpumask_empty(c->exclusive_cpus);
-		if (is_cpu_exclusive(trial) || is_cpu_exclusive(c) ||
-		    (txset && cxset)) {
-			if (!cpusets_are_exclusive(trial, c))
-				goto out;
-		} else if (txset || cxset) {
-			struct cpumask *xcpus, *acpus;
-
-			/*
-			 * When just one of the exclusive_cpus's is set,
-			 * cpus_allowed of the other cpuset, if set, cannot be
-			 * a subset of it or none of those CPUs will be
-			 * available if these exclusive CPUs are activated.
-			 */
-			if (txset) {
-				xcpus = trial->exclusive_cpus;
-				acpus = c->cpus_allowed;
-			} else {
-				xcpus = c->exclusive_cpus;
-				acpus = trial->cpus_allowed;
-			}
-			if (!cpumask_empty(acpus) && cpumask_subset(acpus, xcpus))
-				goto out;
-		}
-		if ((is_mem_exclusive(trial) || is_mem_exclusive(c)) &&
-		    nodes_intersects(trial->mems_allowed, c->mems_allowed))
+		if (cpus_excl_conflict(trial, c))
+			goto out;
+		if (mems_excl_conflict(trial, c))
 			goto out;
 	}
 
-- 
2.34.1


