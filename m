Return-Path: <cgroups+bounces-2822-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBF48BE449
	for <lists+cgroups@lfdr.de>; Tue,  7 May 2024 15:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 808381C21259
	for <lists+cgroups@lfdr.de>; Tue,  7 May 2024 13:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62061635DB;
	Tue,  7 May 2024 13:30:24 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2075415F412;
	Tue,  7 May 2024 13:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715088624; cv=none; b=q8d4H/WH83lUPI+OYegzZZw2m1DL4LL0M/9+7h0BnkqcBIA+yZO2Ha2reY4SYlBG4hpkW4v+2BylLpTG1nS9AiAot7jqpUA36kCgk73rtIEP4Ad7kB1frkX51gaETGQpHbry4nQX3X4pHKF2xFj5YacUSFY42YU08G7vnsf9B/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715088624; c=relaxed/simple;
	bh=eIBo/rK4/UuN2nQCjJhvhD8Oggxyhot/vjrYauT0czM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RV01R4zQIrC0dRhA32t+4csu2z94FI65drahQtSWmqL+tNhmeZHdybhS+TL5TmdVt7KVyH+OQL/LcOVvTgULFJqhgfFeziY9fg1u5Fh6eNE4EZ0ZiaENNI/nrR8azgZKO4y3crt2rNbbFllRJ6uRhzTLMDs02OpxHDgNL+eW/sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VYfJ25KfdzCrNm;
	Tue,  7 May 2024 21:29:06 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id 6E844180065;
	Tue,  7 May 2024 21:30:17 +0800 (CST)
Received: from hulk-vt.huawei.com (10.67.174.26) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 21:30:17 +0800
From: Xiu Jianfeng <xiujianfeng@huawei.com>
To: <hannes@cmpxchg.org>, <mhocko@kernel.org>, <roman.gushchin@linux.dev>,
	<shakeel.butt@linux.dev>, <muchun.song@linux.dev>,
	<akpm@linux-foundation.org>
CC: <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3 -next] mm: memcg: make alloc_mem_cgroup_per_node_info() return bool
Date: Tue, 7 May 2024 13:23:24 +0000
Message-ID: <20240507132324.1158510-1-xiujianfeng@huawei.com>
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

alloc_mem_cgroup_per_node_info() returns int that doesn't map to any
errno error code. The only existing caller doesn't really need an error
code so change the the function to return bool (true on success) because
this is slightly less confusing and more consistent with the other code.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/memcontrol.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index feb6651ee1e8..5d4da23264fa 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5642,13 +5642,13 @@ struct mem_cgroup *mem_cgroup_get_from_ino(unsigned long ino)
 }
 #endif
 
-static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
+static bool alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
 {
 	struct mem_cgroup_per_node *pn;
 
 	pn = kzalloc_node(sizeof(*pn), GFP_KERNEL, node);
 	if (!pn)
-		return 1;
+		return false;
 
 	pn->lruvec_stats = kzalloc_node(sizeof(struct lruvec_stats),
 					GFP_KERNEL_ACCOUNT, node);
@@ -5664,11 +5664,11 @@ static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
 	pn->memcg = memcg;
 
 	memcg->nodeinfo[node] = pn;
-	return 0;
+	return true;
 fail:
 	kfree(pn->lruvec_stats);
 	kfree(pn);
-	return 1;
+	return false;
 }
 
 static void free_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
@@ -5741,7 +5741,7 @@ static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
 	}
 
 	for_each_node(node)
-		if (alloc_mem_cgroup_per_node_info(memcg, node))
+		if (!alloc_mem_cgroup_per_node_info(memcg, node))
 			goto fail;
 
 	if (memcg_wb_domain_init(memcg, GFP_KERNEL))
-- 
2.34.1


