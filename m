Return-Path: <cgroups+bounces-12707-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B20ACDDC48
	for <lists+cgroups@lfdr.de>; Thu, 25 Dec 2025 13:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5BD94301399F
	for <lists+cgroups@lfdr.de>; Thu, 25 Dec 2025 12:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B99732039B;
	Thu, 25 Dec 2025 12:45:56 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D38AE55A;
	Thu, 25 Dec 2025 12:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766666756; cv=none; b=LLoZThshSlkyTKK4oce++KI7fX9khi4FibRyW0EIuia1F1qkeIoDDFNYoMNr9l2LTQ4r5paHrbv3TsXv5khpg5NY5tZzEzmFAyQctp9xS0G8wRuUVdCtKit4E0h1zf0qUeVNsNPLCHIm83S4S0/KLBc683yYIhdxuOSlcoQjUcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766666756; c=relaxed/simple;
	bh=v7uksGN1CrM8YcGspl4JJUGLxd0MV5MftavhCF8OE4A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pSXnxaENF5fsDPWoAIU9eZBaky7aIQSL3NHT4L2r8RaC5IrjW3nJ9KRNTFrlCbW55QXGqEszD7xEdDrkTHbZxgBep2yn50glQloEpIXc2dnOZZ4/TdXfQHHTyOY9LvFnV+lsD2lYdCxFjMvt3v7uU6jq1iP1Ywyc2VviXyiz0hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dcT4B0TSqzKHMhR;
	Thu, 25 Dec 2025 20:45:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 66A174056E;
	Thu, 25 Dec 2025 20:45:51 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgDHdfb1MU1pT76_BQ--.27441S10;
	Thu, 25 Dec 2025 20:45:51 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huaweicloud.com
Subject: [PATCH RESEND -next 08/21] cpuset: use partition_update() for remote partition update
Date: Thu, 25 Dec 2025 12:30:45 +0000
Message-Id: <20251225123058.231765-9-chenridong@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgDHdfb1MU1pT76_BQ--.27441S10
X-Coremail-Antispam: 1UD129KBjvJXoWxJF4UZw17WFW8ur47GF1UGFg_yoW5Gr1xpF
	yfGr42qa90qr1UC34Utan29rn5Ka1DtFWqy3ZrX34rAFy7C3W0y34Uta98XFy5W39rWr15
	AFZIqr42qFy7uwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUAV
	WUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJw
	CI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbx9NDUU
	UUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

Now that the partition_update() helper is available, use it to replace
the existing remote partition update logic. This unifies the update
path through a single centralized function.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 9bcc13b7ea08..73d9a8df3072 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1697,7 +1697,6 @@ static void remote_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
 static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
 			       struct cpumask *excpus, struct tmpmasks *tmp)
 {
-	bool adding, deleting;
 	int prs = cs->partition_root_state;
 
 	if (WARN_ON_ONCE(!is_remote_partition(cs)))
@@ -1710,15 +1709,15 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
 		goto invalidate;
 	}
 
-	adding   = cpumask_andnot(tmp->addmask, excpus, cs->effective_xcpus);
-	deleting = cpumask_andnot(tmp->delmask, cs->effective_xcpus, excpus);
+	cpumask_andnot(tmp->addmask, excpus, cs->effective_xcpus);
+	cpumask_andnot(tmp->delmask, cs->effective_xcpus, excpus);
 
 	/*
 	 * Additions of remote CPUs is only allowed if those CPUs are
 	 * not allocated to other partitions and there are effective_cpus
 	 * left in the top cpuset.
 	 */
-	if (adding) {
+	if (!cpumask_empty(tmp->addmask)) {
 		WARN_ON_ONCE(cpumask_intersects(tmp->addmask, subpartitions_cpus));
 		if (!capable(CAP_SYS_ADMIN))
 			cs->prs_err = PERR_ACCESS;
@@ -1732,23 +1731,7 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
 			goto invalidate;
 	}
 
-	spin_lock_irq(&callback_lock);
-	if (adding)
-		partition_xcpus_add(prs, NULL, tmp->addmask);
-	if (deleting)
-		partition_xcpus_del(prs, NULL, tmp->delmask);
-	/*
-	 * Need to update effective_xcpus and exclusive_cpus now as
-	 * update_sibling_cpumasks() below may iterate back to the same cs.
-	 */
-	cpumask_copy(cs->effective_xcpus, excpus);
-	if (xcpus)
-		cpumask_copy(cs->exclusive_cpus, xcpus);
-	spin_unlock_irq(&callback_lock);
-	update_isolation_cpumasks();
-	if (adding || deleting)
-		cpuset_force_rebuild();
-
+	partition_update(cs, cs->partition_root_state, xcpus, excpus, tmp);
 	/*
 	 * Propagate changes in top_cpuset's effective_cpus down the hierarchy.
 	 */
-- 
2.34.1


