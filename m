Return-Path: <cgroups+bounces-3943-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 734849405FD
	for <lists+cgroups@lfdr.de>; Tue, 30 Jul 2024 05:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94A541C22745
	for <lists+cgroups@lfdr.de>; Tue, 30 Jul 2024 03:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D0A1448FA;
	Tue, 30 Jul 2024 03:38:46 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AFB22315;
	Tue, 30 Jul 2024 03:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722310725; cv=none; b=Ix5esXufLE6r2zVW0j2fZdt1nA7GNLfrPITfg26kQk01LDQF8R04QIdPS7J0VKN5+9676VUKhhgvYglgA+0Opt81Jr5hlwqkrVNjmxT2D5u0Hxjqe/ItpqB9uDG+gStxu/CkxZ2PitnVMk4UXS5U9kis0qP5aSf1RJlO8a7iY6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722310725; c=relaxed/simple;
	bh=7hsn5NbG/L6xMNTJLxdCf7BBRU7+2YmtpZ/3e8jjYfU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XI4UFF8cEz+S4exI41MNMrHw/DOcO94CtaAv42Vaz2c2j1ev7lgj9OsTd0x2Pm9n1D1VmvEvl2mYnspLyAacVD/F1FS0AP3ZqSZ/8Ws33OqrIJJrzolatg0aW53w+/5Z5TZGHoB8FCROBrvQHLODLv5gD91BJmeMvW/F2zlsEy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WY1Ck5tDfz4f3jdM;
	Tue, 30 Jul 2024 11:38:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A475A1A174A;
	Tue, 30 Jul 2024 11:38:39 +0800 (CST)
Received: from huaweicloud.com (unknown [10.67.174.26])
	by APP4 (Coremail) with SMTP id gCh0CgCnzYM+YKhmaDH_AA--.22804S2;
	Tue, 30 Jul 2024 11:38:39 +0800 (CST)
From: Xiu Jianfeng <xiujianfeng@huaweicloud.com>
To: tj@kernel.org,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xiujianfeng@huawei.com
Subject: [PATCH v2 -next] cgroup/pids: Avoid spurious event notification
Date: Tue, 30 Jul 2024 03:29:20 +0000
Message-Id: <20240730032920.3690263-1-xiujianfeng@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnzYM+YKhmaDH_AA--.22804S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCF15tw4kGr17JFyxJw15twb_yoW5GrW5p3
	ZxAFyrK395J3ZI93Z3W3srZFyfWa93W398CF48A34fJw12kr15XanFkF18Zr1UZFy7u3sr
	Xa1Yva45G34jyrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHDUUUUU==
X-CM-SenderInfo: x0lxyxpdqiv03j6k3tpzhluzxrxghudrp/

From: Xiu Jianfeng <xiujianfeng@huawei.com>

Currently when a process in a group forks and fails due to it's
parent's max restriction, all the cgroups from 'pids_forking' to root
will generate event notifications but only the cgroups from
'pids_over_limit' to root will increase the counter of PIDCG_MAX.

Consider this scenario: there are 4 groups A, B, C,and D, the
relationships are as follows, and user is watching on C.pids.events.

root->A->B->C->D

When a process in D forks and fails due to B.max restriction, the
user will get a spurious event notification because when he wakes up
and reads C.pids.events, he will find that the content has not changed.

To address this issue, only the cgroups from 'pids_over_limit' to root
will have their PIDCG_MAX counters increased and event notifications
generated.

Fixes: 385a635cacfe ("cgroup/pids: Make event counters hierarchical")
Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
v2: add Fixes tag and fix a extra notification
---
 kernel/cgroup/pids.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/kernel/cgroup/pids.c b/kernel/cgroup/pids.c
index f5cb0ec45b9d..34aa63d7c9c6 100644
--- a/kernel/cgroup/pids.c
+++ b/kernel/cgroup/pids.c
@@ -244,7 +244,6 @@ static void pids_event(struct pids_cgroup *pids_forking,
 		       struct pids_cgroup *pids_over_limit)
 {
 	struct pids_cgroup *p = pids_forking;
-	bool limit = false;
 
 	/* Only log the first time limit is hit. */
 	if (atomic64_inc_return(&p->events_local[PIDCG_FORKFAIL]) == 1) {
@@ -252,20 +251,17 @@ static void pids_event(struct pids_cgroup *pids_forking,
 		pr_cont_cgroup_path(p->css.cgroup);
 		pr_cont("\n");
 	}
-	cgroup_file_notify(&p->events_local_file);
 	if (!cgroup_subsys_on_dfl(pids_cgrp_subsys) ||
-	    cgrp_dfl_root.flags & CGRP_ROOT_PIDS_LOCAL_EVENTS)
+	    cgrp_dfl_root.flags & CGRP_ROOT_PIDS_LOCAL_EVENTS) {
+		cgroup_file_notify(&p->events_local_file);
 		return;
+	}
 
-	for (; parent_pids(p); p = parent_pids(p)) {
-		if (p == pids_over_limit) {
-			limit = true;
-			atomic64_inc(&p->events_local[PIDCG_MAX]);
-			cgroup_file_notify(&p->events_local_file);
-		}
-		if (limit)
-			atomic64_inc(&p->events[PIDCG_MAX]);
+	atomic64_inc(&pids_over_limit->events_local[PIDCG_MAX]);
+	cgroup_file_notify(&pids_over_limit->events_local_file);
 
+	for (p = pids_over_limit; parent_pids(p); p = parent_pids(p)) {
+		atomic64_inc(&p->events[PIDCG_MAX]);
 		cgroup_file_notify(&p->events_file);
 	}
 }
-- 
2.34.1


