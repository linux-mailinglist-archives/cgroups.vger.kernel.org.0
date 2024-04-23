Return-Path: <cgroups+bounces-2664-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCC28ADC07
	for <lists+cgroups@lfdr.de>; Tue, 23 Apr 2024 04:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4CF41F22569
	for <lists+cgroups@lfdr.de>; Tue, 23 Apr 2024 02:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED24F17C6C;
	Tue, 23 Apr 2024 02:51:17 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3848117BD2;
	Tue, 23 Apr 2024 02:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713840677; cv=none; b=ghEtYNsZc8yXg9s3ZYaGwQHUmjxljgyioxK8x1XSJvN/CrMSPzZz6QKd5mTWsjBCqwTxAO0lP3D4lhzkyZGnQTx8725Wp2kJsItOZU7P2Z0T6/3K+5NpqFJ6kTe+8J/YC7/UW8VqnwrKL6m+p9TjdCBomjH+JKwx4NjSf9hN6zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713840677; c=relaxed/simple;
	bh=yo4EegpD5LBqfXVY4c3Tp5+JOb8sTd/ERASSILbGP5k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=COkIYGTD+jJ0wJl2075rRnXrBWt5VF2lXeOEF2vPEg/3ztjNQKVNO9R36iQ63YNTZ/8buXOkKn7o9HsJiChvWznffpIcbdyx93MKG3IeF2E6BTqLT6tjDsb9dednfrIHF2SZCf52cqvmekDrAEGy/l/+YVzIoPPG1XhZXbMrThA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4VNmkw0qPrz1RChk;
	Tue, 23 Apr 2024 10:48:08 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id 814A61A016C;
	Tue, 23 Apr 2024 10:51:11 +0800 (CST)
Received: from hulk-vt.huawei.com (10.67.174.26) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 10:51:11 +0800
From: Xiu Jianfeng <xiujianfeng@huawei.com>
To: <longman@redhat.com>, <lizefan.x@bytedance.com>, <tj@kernel.org>,
	<hannes@cmpxchg.org>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 -next] cgroup/cpuset: Avoid clearing CS_SCHED_LOAD_BALANCE twice
Date: Tue, 23 Apr 2024 02:44:39 +0000
Message-ID: <20240423024439.1064922-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500023.china.huawei.com (7.185.36.114)

In cpuset_css_online(), CS_SCHED_LOAD_BALANCE will be cleared twice,
the former one in the is_in_v2_mode() case could be removed because
is_in_v2_mode() can be true for cgroup v1 if the "cpuset_v2_mode"
mount option is specified, that balance flag change isn't appropriate
for this particular case.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

---
v2: remove the one in is_in_v2_mode() case.
---
 kernel/cgroup/cpuset.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index d8d3439eda4e..bb9bf25889c9 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -4051,11 +4051,6 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 		cs->effective_mems = parent->effective_mems;
 		cs->use_parent_ecpus = true;
 		parent->child_ecpus_count++;
-		/*
-		 * Clear CS_SCHED_LOAD_BALANCE if parent is isolated
-		 */
-		if (!is_sched_load_balance(parent))
-			clear_bit(CS_SCHED_LOAD_BALANCE, &cs->flags);
 	}
 
 	/*
-- 
2.34.1


