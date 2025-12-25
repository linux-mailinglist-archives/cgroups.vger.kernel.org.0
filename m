Return-Path: <cgroups+bounces-12712-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC62DCDDC7E
	for <lists+cgroups@lfdr.de>; Thu, 25 Dec 2025 13:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E25330792B4
	for <lists+cgroups@lfdr.de>; Thu, 25 Dec 2025 12:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDAE3254AD;
	Thu, 25 Dec 2025 12:46:00 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDA93233ED;
	Thu, 25 Dec 2025 12:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766666760; cv=none; b=Ix+6XOB9ycDUHV/tk+keUQdLtzYRGn4JBwWZncxBx18TW30vPe4EVmgQ1zkrnOWeMEL8no2i0WBfEIoGSWKgsmTfHdwfBMbJPVXlYbX+tcwcbLmNGYjl0/2Ckcxk/TINJzOAsj19IfpHcHuj7EaJ+oK2Zf7D2bseImcu+Sj5QcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766666760; c=relaxed/simple;
	bh=O0AiP1pB582/fo2zZeuRTypP7jALMr7OFyyfUAKucY8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WaEsKliqgzcQ/xZ8P/Dd3axedF6Mw3a4O4fTIvx/Av6hMRPhxSsNqhNcOd349dFQC11ZpBv3PGyJ2ISUbeM68rEij7kSDeBelpA/M2Pj8Gd+qVSu+EHdOwjDkuUCf57CIqAM0hp+niYrrgMD8LOxuWSEQSqCmam02swC6gYlAxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dcT4B38gRzKHMjq;
	Thu, 25 Dec 2025 20:45:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C47CA4056B;
	Thu, 25 Dec 2025 20:45:51 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgDHdfb1MU1pT76_BQ--.27441S16;
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
Subject: [PATCH RESEND -next 14/21] cpuset: remove redundant partition field updates
Date: Thu, 25 Dec 2025 12:30:51 +0000
Message-Id: <20251225123058.231765-15-chenridong@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgDHdfb1MU1pT76_BQ--.27441S16
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw18JF47CFy3KF1rCw4xCrg_yoW8CF1rpF
	WDurW7trWYgryrC39rGan2gr15KanFqa4DtFnrJw1rCFy7C3Wq9Fyqq390vF1jq3srCr4U
	ZFn0vrWSv3ZrurDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

With the previous patch series, partition-related fields are now properly
managed during partition enable, disable, and update operations. There
should be no need to set these fields outside of these dedicated partition
operations.

This patch removes the redundant partition field updates from the cpumask
setting code path. However, one exception remains: when setting
cpuset.cpus.exclusive on a non-partition cpuset, update_exclusive_cpumask()
must still set effective_xcpus directly. This is necessary because no
partition operation is invoked in this scenario, yet effective_xcpus needs
to be properly initialized.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index d4489079bff9..a1df78a75575 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2397,9 +2397,6 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 
 	spin_lock_irq(&callback_lock);
 	cpumask_copy(cs->cpus_allowed, trialcs->cpus_allowed);
-	cpumask_copy(cs->effective_xcpus, trialcs->effective_xcpus);
-	if ((old_prs > 0) && !is_partition_valid(cs))
-		reset_partition_data(cs);
 	spin_unlock_irq(&callback_lock);
 
 	/* effective_cpus/effective_xcpus will be updated here */
@@ -2463,8 +2460,6 @@ static int update_exclusive_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	spin_lock_irq(&callback_lock);
 	cpumask_copy(cs->exclusive_cpus, trialcs->exclusive_cpus);
 	cpumask_copy(cs->effective_xcpus, trialcs->effective_xcpus);
-	if ((old_prs > 0) && !is_partition_valid(cs))
-		reset_partition_data(cs);
 	spin_unlock_irq(&callback_lock);
 
 	/*
-- 
2.34.1


