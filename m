Return-Path: <cgroups+bounces-12705-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FABCDDC39
	for <lists+cgroups@lfdr.de>; Thu, 25 Dec 2025 13:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1A23F300296D
	for <lists+cgroups@lfdr.de>; Thu, 25 Dec 2025 12:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C6123B62C;
	Thu, 25 Dec 2025 12:45:56 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C332AD2C;
	Thu, 25 Dec 2025 12:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766666755; cv=none; b=JYq/xgHw0gBCHG1QFrsmtsXxgy17MFTE0+IFugrKFjBaLJtKZsG09eYYAP9H19IsVkcwyDEjM7rAqIMa9jhiUyBhzHJcSUW4HHgJ9l0VY+owvn3lGuW1O8JeapkxFi37Hs8OY5T3LIHI3j504kR8vpZAWlHGJFPe5oMMWhUexqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766666755; c=relaxed/simple;
	bh=cO/z1lPS/1foP1bqyi42AkzaQBAU7k+dYR5WEzpXNpc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b3yOEmvlvynjcNq2gaHrJw7/ISxGXZC2CEWCE6ZjVcv1mtKL73ussqghKxAXue5a4Y7ptG3B/MuPulq1s0Obz1f2/a/GD/K0Oe9IK7pJaIF5ZLEhd4UnIQkdIFDhmwG3gP5S6QDcYwFxUj0PqZaoWNVI/NP2j2g9fQuqqYdziWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dcT3q00t7zYQv5n;
	Thu, 25 Dec 2025 20:45:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 563C54056D;
	Thu, 25 Dec 2025 20:45:51 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgDHdfb1MU1pT76_BQ--.27441S9;
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
Subject: [PATCH RESEND -next 07/21] cpuset: use partition_disable() for remote partition disablement
Date: Thu, 25 Dec 2025 12:30:44 +0000
Message-Id: <20251225123058.231765-8-chenridong@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgDHdfb1MU1pT76_BQ--.27441S9
X-Coremail-Antispam: 1UD129KBjvJXoW7WrWxCFyxJryDtFyfKr43trb_yoW8CF48pF
	13Cr47GFW5WF15uay7JFsruw1rKanrJF9rtw17W34rXF17Aa4v9a42k39Yva4jgFWDWry5
	Z3Z0gr48XF17AwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Now that the partition_disable() helper is available, replace the
existing implementation for remote partition disablement with this
centralized function to unify the disablement logic.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 0c62157c1d04..9bcc13b7ea08 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1662,6 +1662,8 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
  */
 static void remote_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
 {
+	int new_prs;
+
 	WARN_ON_ONCE(!is_remote_partition(cs));
 	/*
 	 * When a CPU is offlined, top_cpuset may end up with no available CPUs,
@@ -1672,20 +1674,8 @@ static void remote_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
 	WARN_ON_ONCE(!cpumask_subset(cs->effective_xcpus, subpartitions_cpus) &&
 		     !cpumask_empty(subpartitions_cpus));
 
-	spin_lock_irq(&callback_lock);
-	cs->remote_partition = false;
-	partition_xcpus_del(cs->partition_root_state, NULL, cs->effective_xcpus);
-	if (cs->prs_err)
-		cs->partition_root_state = -cs->partition_root_state;
-	else
-		cs->partition_root_state = PRS_MEMBER;
-
-	/* effective_xcpus may need to be changed */
-	compute_excpus(cs, cs->effective_xcpus);
-	reset_partition_data(cs);
-	spin_unlock_irq(&callback_lock);
-	update_isolation_cpumasks();
-	cpuset_force_rebuild();
+	new_prs = cs->prs_err ? -cs->partition_root_state : PRS_MEMBER;
+	partition_disable(cs, NULL, new_prs, cs->prs_err);
 
 	/*
 	 * Propagate changes in top_cpuset's effective_cpus down the hierarchy.
-- 
2.34.1


