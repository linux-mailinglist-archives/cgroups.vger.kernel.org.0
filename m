Return-Path: <cgroups+bounces-10185-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CBEB7D2DB
	for <lists+cgroups@lfdr.de>; Wed, 17 Sep 2025 14:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D18104855A4
	for <lists+cgroups@lfdr.de>; Wed, 17 Sep 2025 06:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7282C08B6;
	Wed, 17 Sep 2025 06:20:13 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F9E244681;
	Wed, 17 Sep 2025 06:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758090013; cv=none; b=Q4BZ2QJcZ1F+uf/hslCj2oQXULrWqnyaEIayoVjocy4Op1zk9rlfNWeO33k0Qb2F/1JHMZO+gASItOrEmTMsSl0xu3FENmz6DuGXp97NmBuJ1V0uNFOiPzgLKtHRjZZ45bCSktZFM5aFLsXkeeJQdDdBfJRymBQm909FRl2nvPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758090013; c=relaxed/simple;
	bh=GMBRMOA2p/PyuNseR2ex9BFzG79Tgd6ppzrNQ7iO2Zc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gq3igK/idvHQbcvwED8qY4Jil0rGLky9KKOAyP80y/SwAXel/l22kvN0WUn7Dz9PaDxg7yVTRtyTXP7WcJV7XmsKc3QqHxaIHNzAsWI0q7QO3xlPpFHjSYtu5N/00YMC5EHlRpOf6ky/ga5vaE+F9dvtdcmtzJVdiraFoaYtZmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cRTCC04XWzKHN5q;
	Wed, 17 Sep 2025 14:20:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B2E5D1A14C5;
	Wed, 17 Sep 2025 14:20:07 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgCn74sNU8pos3slCw--.39134S13;
	Wed, 17 Sep 2025 14:20:07 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH -next 11/11] cpuset: use partition_cpus_change for setting exclusive cpus
Date: Wed, 17 Sep 2025 06:04:54 +0000
Message-Id: <20250917060454.2885698-12-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250917060454.2885698-1-chenridong@huaweicloud.com>
References: <20250917060454.2885698-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCn74sNU8pos3slCw--.39134S13
X-Coremail-Antispam: 1UD129KBjvJXoW7KFW8Jw18CFyDZr48JF47Jwb_yoW8uF4rpF
	yfCr42qrW5Xr15W3yqg3sF9wn8KwsFq3WDt3ZrJ34fGFy2yanava4UWwsavFy5XasrCr18
	Za90vrWavF17CwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	x0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1l_M7UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

A previous patch has introduced a new helper function
partition_cpus_change(). Now replace the exclusive cpus setting logic
with this helper function.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
Reviewed-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 29 ++---------------------------
 1 file changed, 2 insertions(+), 27 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index c1eefbb7d941..5cfc960f7b15 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2561,8 +2561,6 @@ static int update_exclusive_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 {
 	int retval;
 	struct tmpmasks tmp;
-	struct cpuset *parent = parent_cs(cs);
-	bool invalidate = false;
 	bool force = false;
 	int old_prs = cs->partition_root_state;
 
@@ -2594,32 +2592,9 @@ static int update_exclusive_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	if (alloc_tmpmasks(&tmp))
 		return -ENOMEM;
 
-	if (old_prs) {
-		if (cpumask_empty(trialcs->effective_xcpus)) {
-			invalidate = true;
-			cs->prs_err = PERR_INVCPUS;
-		} else if (prstate_housekeeping_conflict(old_prs, trialcs->effective_xcpus)) {
-			invalidate = true;
-			cs->prs_err = PERR_HKEEPING;
-		} else if (tasks_nocpu_error(parent, cs, trialcs->effective_xcpus)) {
-			invalidate = true;
-			cs->prs_err = PERR_NOCPUS;
-		}
+	trialcs->prs_err = PERR_NONE;
+	partition_cpus_change(cs, trialcs, &tmp);
 
-		if (is_remote_partition(cs)) {
-			if (invalidate)
-				remote_partition_disable(cs, &tmp);
-			else
-				remote_cpus_update(cs, trialcs->exclusive_cpus,
-						   trialcs->effective_xcpus, &tmp);
-		} else if (invalidate) {
-			update_parent_effective_cpumask(cs, partcmd_invalidate,
-							NULL, &tmp);
-		} else {
-			update_parent_effective_cpumask(cs, partcmd_update,
-						trialcs->effective_xcpus, &tmp);
-		}
-	}
 	spin_lock_irq(&callback_lock);
 	cpumask_copy(cs->exclusive_cpus, trialcs->exclusive_cpus);
 	cpumask_copy(cs->effective_xcpus, trialcs->effective_xcpus);
-- 
2.34.1


