Return-Path: <cgroups+bounces-4075-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 877CC946826
	for <lists+cgroups@lfdr.de>; Sat,  3 Aug 2024 08:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB689B21358
	for <lists+cgroups@lfdr.de>; Sat,  3 Aug 2024 06:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001BD7D401;
	Sat,  3 Aug 2024 06:25:42 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D090A847B;
	Sat,  3 Aug 2024 06:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722666341; cv=none; b=SajK/zpv6J7lB7+KYSlQqLwI5BJSkuN3Q4L5+f9ol5kHeRy4N3U1ubox5bjGq6uzG3QKPuwsRMoruSXG/fo+RDuaA3DisxdbGDMyx96R7aAu46qse1wr91RTpBBoseCKGH8SjU8RYsAGCS+YuK3HCczmPCEevAPAEyweJVzjQ7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722666341; c=relaxed/simple;
	bh=nqpbm8WEcjBvV/nU61W2jnnnozZceO08/0FEReAeuPc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E/1m36SFTo0N2k+bs7Mkx5eEFph0xnQf3H/VOpZj/Jo7i6i22M5AMtsShMMUb0TSuSNRRkKJmWJ7RLMFjp98iNVwzIfaJqHwGpJHq4yC1zgQBGn698RjJylLsz+8gmh36CaImPDYs9fnkFxWdCn+Q0AFAHwoR1T7D45nhH/H4uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WbXkS699Cz4f3jMl;
	Sat,  3 Aug 2024 14:25:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id E80B91A0359;
	Sat,  3 Aug 2024 14:25:33 +0800 (CST)
Received: from huaweicloud.com (unknown [10.67.174.26])
	by APP2 (Coremail) with SMTP id Syh0CgCn3r1cza1m5YuCAg--.16339S2;
	Sat, 03 Aug 2024 14:25:33 +0800 (CST)
From: Xiu Jianfeng <xiujianfeng@huaweicloud.com>
To: tj@kernel.org,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xiujianfeng@huawei.com
Subject: [PATCH -next] cgroup/pids: Remove unreachable paths of pids_{can,cancel}_fork
Date: Sat,  3 Aug 2024 06:16:07 +0000
Message-Id: <20240803061607.50470-1-xiujianfeng@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCn3r1cza1m5YuCAg--.16339S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WFy7Wr1DAFWkKw4UGrW3Wrg_yoW8WFykpF
	nxC3s7KFWUWas8uw1UtrZ3ZryfKan3W34Uur4kJ3yftw12yw13GFyqyw10vry3Xry2gw17
	JF4Yka1agw1jvF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHDUUUUU==
X-CM-SenderInfo: x0lxyxpdqiv03j6k3tpzhluzxrxghudrp/

From: Xiu Jianfeng <xiujianfeng@huawei.com>

According to the implement of cgroup_css_set_fork() and the usage in
the cpuset controller which also has .can_fork and .cancel_fork hooks,
the argument 'cset' for these two hooks must not be NULL, so remove
the unrechable paths in thse two hooks.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 kernel/cgroup/pids.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/kernel/cgroup/pids.c b/kernel/cgroup/pids.c
index 34aa63d7c9c6..8f61114c36dd 100644
--- a/kernel/cgroup/pids.c
+++ b/kernel/cgroup/pids.c
@@ -272,15 +272,10 @@ static void pids_event(struct pids_cgroup *pids_forking,
  */
 static int pids_can_fork(struct task_struct *task, struct css_set *cset)
 {
-	struct cgroup_subsys_state *css;
 	struct pids_cgroup *pids, *pids_over_limit;
 	int err;
 
-	if (cset)
-		css = cset->subsys[pids_cgrp_id];
-	else
-		css = task_css_check(current, pids_cgrp_id, true);
-	pids = css_pids(css);
+	pids = css_pids(cset->subsys[pids_cgrp_id]);
 	err = pids_try_charge(pids, 1, &pids_over_limit);
 	if (err)
 		pids_event(pids, pids_over_limit);
@@ -290,14 +285,9 @@ static int pids_can_fork(struct task_struct *task, struct css_set *cset)
 
 static void pids_cancel_fork(struct task_struct *task, struct css_set *cset)
 {
-	struct cgroup_subsys_state *css;
 	struct pids_cgroup *pids;
 
-	if (cset)
-		css = cset->subsys[pids_cgrp_id];
-	else
-		css = task_css_check(current, pids_cgrp_id, true);
-	pids = css_pids(css);
+	pids = css_pids(cset->subsys[pids_cgrp_id]);
 	pids_uncharge(pids, 1);
 }
 
-- 
2.34.1


