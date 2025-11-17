Return-Path: <cgroups+bounces-12018-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F6BC622EA
	for <lists+cgroups@lfdr.de>; Mon, 17 Nov 2025 04:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF9474EC530
	for <lists+cgroups@lfdr.de>; Mon, 17 Nov 2025 03:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F304427E056;
	Mon, 17 Nov 2025 03:01:51 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1B2263C91;
	Mon, 17 Nov 2025 03:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763348511; cv=none; b=cZ658ZannOpFkg9T2qwLqbeZhknph8lP/31LXd0h4+p2LtEL5fo3jMPDlR3malAw+RYiPnmFxOYQS6MjHBfROlPI1LHoxYRaMZUqONfIzjtnlYmGqGAQvD89n2YPcSaWbF61poDMPpyv1KdWill9ZSSSziR1JrY4VY5dOvBQs5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763348511; c=relaxed/simple;
	bh=gB7//HZ/drCgAnuS/jK9gEOOtMLW7SNS/v5FtqKr6Hk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I12PcOPTb7VX/iAnUghDz6A0/b5iZIaShmP6fhpzIEyO50sDunaEP4XcqgHCAXU2U/a1xw98rtBSaPfND/lBNGdpBcSQUfTWuc2q3aL2J8N8i2kLoF0BSzh0b/5BApj4rRVDODRwKVbH7DbFMyXmxX0E4LpZIkXQBzHE1nGjJ8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d8svL1Z4vzYQty0;
	Mon, 17 Nov 2025 11:01:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 590BB1A07BB;
	Mon, 17 Nov 2025 11:01:38 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgA3lHr5jxpp+kwRBA--.27716S23;
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
Subject: [PATCH -next 21/21] cpuset: Remove unnecessary validation in partition_cpus_change
Date: Mon, 17 Nov 2025 02:46:27 +0000
Message-Id: <20251117024627.1128037-22-chenridong@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgA3lHr5jxpp+kwRBA--.27716S23
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw47tw4UXrW7Kw4DXryrWFg_yoW8Jw4kpF
	y7Gw4UGay5Wr1jkayDJas7u3s8K3ZrXF1UtFnxta4fWF1Iqa4qkFyjy39xZFyfXasrGa48
	Z3ZIvr4qgFW2yrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x
	0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UM6wAUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

When user-configured CPUs (including cpuset.cpus and cpuset.cpus.exclusive)
are modified, the partition may either be disabled or updated. Both local
and remote partitions update can fully validate their own validity: if the
validation fails, the partition will be disabled. Therefore, the
validationin partition_cpus_change is redundant and can be removed.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index b795af41eff8..59c1592280b0 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2465,16 +2465,9 @@ static int cpus_allowed_validate_change(struct cpuset *cs, struct cpuset *trialc
 static void partition_cpus_change(struct cpuset *cs, struct cpuset *trialcs,
 					struct tmpmasks *tmp)
 {
-	enum prs_errcode prs_err;
-
 	if (cs_is_member(cs))
 		return;
 
-	prs_err = validate_partition(cs, trialcs->partition_root_state,
-			trialcs->effective_xcpus, trialcs->effective_xcpus, NULL);
-	if (prs_err)
-		trialcs->prs_err = prs_err;
-
 	if (is_remote_partition(cs)) {
 		if (trialcs->prs_err)
 			remote_partition_disable(cs, trialcs->prs_err, tmp);
-- 
2.34.1


