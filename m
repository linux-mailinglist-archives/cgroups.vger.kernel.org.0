Return-Path: <cgroups+bounces-3001-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E1C8CEE64
	for <lists+cgroups@lfdr.de>; Sat, 25 May 2024 11:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09AEFB214E2
	for <lists+cgroups@lfdr.de>; Sat, 25 May 2024 09:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1F81CF8F;
	Sat, 25 May 2024 09:55:58 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92DA18044;
	Sat, 25 May 2024 09:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716630958; cv=none; b=LNgE+3TPpwW0ZG1YSNM0gWhjXXXqzDEKOAa9ltBeLlh+2qpV64Msx5YsiPHpAki2yH007dSZX6eA0vi7ssKhna4MnKQ/wUC2krZAp8j3dqEZNODz7xLiV9EwJWWefAxueY7HRxYsQU9oXdQjoTptAb5pucCF88p8fQRTabOcP/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716630958; c=relaxed/simple;
	bh=dsdHmYAYzOR7M6UUfdKTjuvEBmTe8UA2tjAlgVqAlIo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lcTMWzViopiCq32ccG8Jgu6SGTnCpWEV1QenlT7/eyCyFRKvv8e1U3ba+tsG4InR5OQcuF9VUQIVv3+5OJY6cVO2rvtXvcPHYndYdT00sW4qbJEEHlztZFN4RnTNFbr2pxk84zp1cwwJ10u+pS+Ouy/wD6Wy12XJMV9k/xSttxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VmcdK4Tn2z1S4s7;
	Sat, 25 May 2024 17:52:05 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id 93BC214011D;
	Sat, 25 May 2024 17:55:47 +0800 (CST)
Received: from hulk-vt.huawei.com (10.67.174.26) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 25 May 2024 17:55:47 +0800
From: Xiu Jianfeng <xiujianfeng@huawei.com>
To: <longman@redhat.com>, <lizefan.x@bytedance.com>, <tj@kernel.org>,
	<hannes@cmpxchg.org>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] cgroup/cpuset: Reduce the lock protecting CS_SCHED_LOAD_BALANCE
Date: Sat, 25 May 2024 09:46:48 +0000
Message-ID: <20240525094648.1585086-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500023.china.huawei.com (7.185.36.114)

In the cpuset_css_online(), clearing the CS_SCHED_LOAD_BALANCE bit
of cs->flags is guarded by callback_lock and cpuset_mutex. There is
no problem with itself, because it is consistent with the description
of there two global lock at the beginning of this file. However, since
the operation of checking, setting and clearing the flag bit is atomic,
protection of callback_lock is unnecessary here, see CS_SPREAD_*. so
to make it more consistent with the other code, move the operation
outside the critical section of callback_lock.

No functional changes intended.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 kernel/cgroup/cpuset.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index f9d2a3487645..315f8cbd6d35 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -4038,6 +4038,12 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 		set_bit(CS_SPREAD_PAGE, &cs->flags);
 	if (is_spread_slab(parent))
 		set_bit(CS_SPREAD_SLAB, &cs->flags);
+	/*
+	 * For v2, clear CS_SCHED_LOAD_BALANCE if parent is isolated
+	 */
+	if (cgroup_subsys_on_dfl(cpuset_cgrp_subsys) &&
+	    !is_sched_load_balance(parent))
+		clear_bit(CS_SCHED_LOAD_BALANCE, &cs->flags);
 
 	cpuset_inc();
 
@@ -4048,14 +4054,6 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 		cs->use_parent_ecpus = true;
 		parent->child_ecpus_count++;
 	}
-
-	/*
-	 * For v2, clear CS_SCHED_LOAD_BALANCE if parent is isolated
-	 */
-	if (cgroup_subsys_on_dfl(cpuset_cgrp_subsys) &&
-	    !is_sched_load_balance(parent))
-		clear_bit(CS_SCHED_LOAD_BALANCE, &cs->flags);
-
 	spin_unlock_irq(&callback_lock);
 
 	if (!test_bit(CGRP_CPUSET_CLONE_CHILDREN, &css->cgroup->flags))
-- 
2.34.1


