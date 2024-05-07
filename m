Return-Path: <cgroups+bounces-2819-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C6F8BE0C8
	for <lists+cgroups@lfdr.de>; Tue,  7 May 2024 13:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED6501F26235
	for <lists+cgroups@lfdr.de>; Tue,  7 May 2024 11:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAA5152534;
	Tue,  7 May 2024 11:15:36 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFFB152170;
	Tue,  7 May 2024 11:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715080536; cv=none; b=uZixdnkdqxlW/MP6ZCVH0cl/Hu8gT9N/2EuMebWxC7rKa87J3v+KHWflvuujGzO4nNGAIgpHzbp+iFlGBGfgzH6Ttga+o+z0Jg0M4xzvCv3qFlBqxnfXXupKJZ/oHrYtTTqqq9ZKJV0NN9ivTwt5Ky4GI1eimHvcbSaQVmCWsFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715080536; c=relaxed/simple;
	bh=qTksG14/AXe3UADF3lCbJ7w9tRhXaIrGr0xnZCBfOIY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uTu2shJZAZLJEvvtmEPl8kHdlWN1q0YsMbCaVOYoHPRgo/CNRn744oz+EfXi7PzJeuGaGUhCzKLHq45dqhB2npOGgzSqczzKHTRYMY8DvoE7+Zg6vhG4I8pQGeuqTYTchxPqbegN/SmHLDZQCeKwjfJG4yviBZciC25YPEpbDEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VYbFN0mvtzYnhR;
	Tue,  7 May 2024 19:11:36 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id 59357180065;
	Tue,  7 May 2024 19:15:25 +0800 (CST)
Received: from hulk-vt.huawei.com (10.67.174.26) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 19:15:25 +0800
From: Xiu Jianfeng <xiujianfeng@huawei.com>
To: <hannes@cmpxchg.org>, <mhocko@kernel.org>, <roman.gushchin@linux.dev>,
	<shakeel.butt@linux.dev>, <muchun.song@linux.dev>,
	<akpm@linux-foundation.org>
CC: <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 -next] mm: memcg: make alloc_mem_cgroup_per_node_info() return bool
Date: Tue, 7 May 2024 11:08:32 +0000
Message-ID: <20240507110832.1128370-1-xiujianfeng@huawei.com>
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

Currently alloc_mem_cgroup_per_node_info() returns 1 if failed,
make it return bool, false for failure and true for success.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 mm/memcontrol.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d11536ef59ef..69d70feb8e68 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5653,13 +5653,13 @@ struct mem_cgroup *mem_cgroup_get_from_ino(unsigned long ino)
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
 
 	pn->lruvec_stats = kzalloc_node(sizeof(struct lruvec_stats), GFP_KERNEL,
 					node);
@@ -5675,11 +5675,11 @@ static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
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
@@ -5751,7 +5751,7 @@ static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
 	}
 
 	for_each_node(node)
-		if (alloc_mem_cgroup_per_node_info(memcg, node))
+		if (!alloc_mem_cgroup_per_node_info(memcg, node))
 			goto fail;
 
 	if (memcg_wb_domain_init(memcg, GFP_KERNEL))
-- 
2.34.1


