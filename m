Return-Path: <cgroups+bounces-2999-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 039BF8CEE60
	for <lists+cgroups@lfdr.de>; Sat, 25 May 2024 11:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E3E11F21796
	for <lists+cgroups@lfdr.de>; Sat, 25 May 2024 09:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8DE1CABD;
	Sat, 25 May 2024 09:51:34 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E80D18044;
	Sat, 25 May 2024 09:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716630694; cv=none; b=fUQJ450NGbh4Egpt0tBKGcpHJZeEKAFl7VHo3z9CetQHmt2KsEgmy8GVA/BF9hr1674U+po8uOqTrxxCJ7/eJ+LDZY+nlZXyRfXX0H6I2dQe0E1UQ9sjNh/sCVr1tSSDPzZNEb9xoNyjRAhT2kIISoCp+vaHTkOMjGiJ8ALBvWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716630694; c=relaxed/simple;
	bh=BpZ2WeV7iCiNNoc6LxfcR3UMip0GuuwLZxRLphn+qjM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s1nWSwFJgjzI+J7H9eGsu9GBYwAx2SnxNIWOzpNFPlJGIxpPdM4vx/zab1ZlaGAnxaoLd96lCg7x+ZdKIfgzM3iSNOOL4Pwl13mfma+3NFTAaX7JA9H6lXuZc5eZ3qseKER1CO/lCU2w6j5InWqVsKZpVd8OGWPNUN/hMW6BfCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VmcX9013YzxPtm;
	Sat, 25 May 2024 17:47:36 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id AAAE8180A9F;
	Sat, 25 May 2024 17:51:21 +0800 (CST)
Received: from hulk-vt.huawei.com (10.67.174.26) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 25 May 2024 17:51:21 +0800
From: Xiu Jianfeng <xiujianfeng@huawei.com>
To: <longman@redhat.com>, <lizefan.x@bytedance.co>, <tj@kernel.org>,
	<hannes@cmpxchg.org>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] cgroup/cpuset: Remove unnecessary zeroing
Date: Sat, 25 May 2024 09:44:03 +0000
Message-ID: <20240525094403.1584987-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500023.china.huawei.com (7.185.36.114)

The struct cpuset is kzalloc'd, all the members are zeroed already,
so don't need nodes_clear() here.

No functional changes intended.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 kernel/cgroup/cpuset.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index c12b9fdb22a4..a553e3d46498 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -4009,8 +4009,6 @@ cpuset_css_alloc(struct cgroup_subsys_state *parent_css)
 	}
 
 	__set_bit(CS_SCHED_LOAD_BALANCE, &cs->flags);
-	nodes_clear(cs->mems_allowed);
-	nodes_clear(cs->effective_mems);
 	fmeter_init(&cs->fmeter);
 	cs->relax_domain_level = -1;
 	INIT_LIST_HEAD(&cs->remote_sibling);
-- 
2.34.1


