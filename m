Return-Path: <cgroups+bounces-2641-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 460618ABAE1
	for <lists+cgroups@lfdr.de>; Sat, 20 Apr 2024 11:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD5AEB203AA
	for <lists+cgroups@lfdr.de>; Sat, 20 Apr 2024 09:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7451773D;
	Sat, 20 Apr 2024 09:53:45 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA3B14AA8;
	Sat, 20 Apr 2024 09:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713606824; cv=none; b=NaGxhCc8j0PzCxqYAgo4rzdvwnhfLqbnnroWdvaTp4+xY6/lg1PssJ19CdK3CBCBMW00mD6Ymdokrn/1M1VVjYYyHryWQSQNtBa+Xlx5oPNzfL1BxlQzMxEDXqbJTveaELHnrt51shKnfmXuiV7lPJBVjIFMpDqUDIF9aJHQaqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713606824; c=relaxed/simple;
	bh=+UEfW4n/OC58SXRIdwEccw/Q+poG33AQ5RAZ8Fq1a04=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pzbTe3hpiQCWe36fpIy01LE+bxRpuV82r5H/PauAwR3EAEkhxT7J00SNHkAmP+I6jjze1ImH1Ome8djUNl8rt9G+jbMcyzJiJ6IvHrfZZtPj2vgSX6cgEYq6ceJB6jWhNmmrGSVGz3uTJYw9BHFG56StOUIfqFJn3itvWTlYi9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VM6Fx0lzHzdbFs;
	Sat, 20 Apr 2024 17:50:45 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id 8474418007C;
	Sat, 20 Apr 2024 17:53:41 +0800 (CST)
Received: from hulk-vt.huawei.com (10.67.174.26) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 20 Apr 2024 17:53:41 +0800
From: Xiu Jianfeng <xiujianfeng@huawei.com>
To: <longman@redhat.com>, <lizefan.x@bytedance.com>, <tj@kernel.org>,
	<hannes@cmpxchg.org>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] cgroup/cpuset: Avoid clearing CS_SCHED_LOAD_BALANCE twice
Date: Sat, 20 Apr 2024 09:47:13 +0000
Message-ID: <20240420094713.1028579-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500023.china.huawei.com (7.185.36.114)

In cpuset_css_online(), CS_SCHED_LOAD_BALANCE has been cleared in the
is_in_v2_mode() case under the same condition, don't do it twice.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 kernel/cgroup/cpuset.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index e70008a1d86a..159525cdaeb9 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -4059,13 +4059,6 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 			clear_bit(CS_SCHED_LOAD_BALANCE, &cs->flags);
 	}
 
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


