Return-Path: <cgroups+bounces-2640-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CA58ABADE
	for <lists+cgroups@lfdr.de>; Sat, 20 Apr 2024 11:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7938D1F21D10
	for <lists+cgroups@lfdr.de>; Sat, 20 Apr 2024 09:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A1017592;
	Sat, 20 Apr 2024 09:52:50 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96C514AA8;
	Sat, 20 Apr 2024 09:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713606770; cv=none; b=Tm5+DPBr/1fNdPd8xSiyluUElVx/3wiAQ+nOeO7iFPRyRsK4H7wOAA+WYRUsvcKjyrTwdljVjJWJqcbltQKAGmKt+fkkv+aoa8OMBpn/p0Wmx7kUNQ1DUXSdNF7qTSLA84gXqYE05Qn0vlSJ3Gt5M4ps0Zl4Vv+aa4JAX/jUFkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713606770; c=relaxed/simple;
	bh=e2kqeueujkKxoJOk8RoZfK74GHevzNEQ7bblI9EcQyA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GeD57hJh7hyAy9mh3zSIf0EjIYMYHrFZnfQW6BxvWnYHF8WRGMC8RhlYbuKKRzgfVlpAD3qwYRlmnAaoM0oPueYR3x+ICQ1ey6hq37BwO6tFtw/iT3maEJG2MRoS50YXnf2+qzaW4u7svvFHpfhj6kEBFAuR26BNcgJpvs0AtRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VM6Dr53mtzdbFy;
	Sat, 20 Apr 2024 17:49:48 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id 22AE518007D;
	Sat, 20 Apr 2024 17:52:45 +0800 (CST)
Received: from hulk-vt.huawei.com (10.67.174.26) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 20 Apr 2024 17:52:44 +0800
From: Xiu Jianfeng <xiujianfeng@huawei.com>
To: <longman@redhat.com>, <lizefan.x@bytedance.com>, <tj@kernel.org>,
	<hannes@cmpxchg.org>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] cgroup/cpuset: Statically initialize more members of top_cpuset
Date: Sat, 20 Apr 2024 09:46:16 +0000
Message-ID: <20240420094616.1028540-1-xiujianfeng@huawei.com>
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

Initializing top_cpuset.relax_domain_level and setting
CS_SCHED_LOAD_BALANCE to top_cpuset.flags in cpuset_init() could be
completed at the time of top_cpuset definition by compiler.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 kernel/cgroup/cpuset.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index d8d3439eda4e..e70008a1d86a 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -369,8 +369,9 @@ static inline void notify_partition_change(struct cpuset *cs, int old_prs)
 
 static struct cpuset top_cpuset = {
 	.flags = ((1 << CS_ONLINE) | (1 << CS_CPU_EXCLUSIVE) |
-		  (1 << CS_MEM_EXCLUSIVE)),
+		  (1 << CS_MEM_EXCLUSIVE) | (1 < CS_SCHED_LOAD_BALANCE)),
 	.partition_root_state = PRS_ROOT,
+	.relax_domain_level = -1,
 	.remote_sibling = LIST_HEAD_INIT(top_cpuset.remote_sibling),
 };
 
@@ -4309,8 +4310,6 @@ int __init cpuset_init(void)
 	nodes_setall(top_cpuset.effective_mems);
 
 	fmeter_init(&top_cpuset.fmeter);
-	set_bit(CS_SCHED_LOAD_BALANCE, &top_cpuset.flags);
-	top_cpuset.relax_domain_level = -1;
 	INIT_LIST_HEAD(&remote_children);
 
 	BUG_ON(!alloc_cpumask_var(&cpus_attach, GFP_KERNEL));
-- 
2.34.1


