Return-Path: <cgroups+bounces-12722-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3A6CDDCA8
	for <lists+cgroups@lfdr.de>; Thu, 25 Dec 2025 13:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F077F30A89FB
	for <lists+cgroups@lfdr.de>; Thu, 25 Dec 2025 12:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A39327211;
	Thu, 25 Dec 2025 12:46:02 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B5F324B09;
	Thu, 25 Dec 2025 12:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766666762; cv=none; b=bVPsg/mmtCueo+OOqLOVGdog64Roj7CZRfdgV3gkMq6qU0cI5MUJ5Friit1VlxzyS8uaLy5pyv0rEdKjFhgIWq0peTn4hBQG1uNPtMuT+gClg6Ahl40nVAegDU6UNWwQbWE5d37XfPKH2X17d2qjzFuNgttV/O4XxNv5dZhjB6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766666762; c=relaxed/simple;
	bh=ZmXqgYU/gemj/ulTXbBoRMrTqgoYM8aqWNWTHB79w00=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cG1EXhlNhaPd8J4KwwAb7r/jMLwSdTSoEQ2FoZY3xfKMOIKOO1meHAXGRzgaSEePvhiSJthrmqWNkJvwqrKtCKkenYM13I38zrovNX48F7w4IyJLk3tgGCfXy1LY2gMfTyFjPAM0lIazjDAUhKfricGkbeOYSWvjCuUxYkvY9mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dcT3q6K4tzYQv71;
	Thu, 25 Dec 2025 20:45:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3CCC34058C;
	Thu, 25 Dec 2025 20:45:52 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgDHdfb1MU1pT76_BQ--.27441S23;
	Thu, 25 Dec 2025 20:45:52 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huaweicloud.com
Subject: [PATCH RESEND -next 21/21] cpuset: Remove unnecessary validation in partition_cpus_change
Date: Thu, 25 Dec 2025 12:30:58 +0000
Message-Id: <20251225123058.231765-22-chenridong@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgDHdfb1MU1pT76_BQ--.27441S23
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw47tw4UXrW7Kw4DXryrWFg_yoW8Jw4kpF
	y7Gr4UGay5Wr1jkayDJas293s8K3ZrZF1UtFnxJa4fWF12qa4qka4jy39xZFyfXF9rCa48
	Z3ZIvr4qgFW2y37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr
	1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUvYLPU
	UUUU=
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
index 23c0ad5ed37e..87decf96a577 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2311,16 +2311,9 @@ static int cpus_allowed_validate_change(struct cpuset *cs, struct cpuset *trialc
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


