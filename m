Return-Path: <cgroups+bounces-2789-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EF48BCF59
	for <lists+cgroups@lfdr.de>; Mon,  6 May 2024 15:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AFBA1C203E5
	for <lists+cgroups@lfdr.de>; Mon,  6 May 2024 13:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05E778C67;
	Mon,  6 May 2024 13:43:40 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B614642B;
	Mon,  6 May 2024 13:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715003020; cv=none; b=QhLTiQfbXxi8G0n4i050ysuE1pyfSnOVNv5QKIHaWra6Skpp646AGDVbYzL3YDE7Mf9Fa0VqHWVcNMnveZqZyr5dYsd8xxdZX6gIbMyt5ELTGzQ9LCeEWTspqq03WSxEd77oYTQYXTb0ftH8kVIECr7yoGWn+xZmW4n4QdqODNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715003020; c=relaxed/simple;
	bh=nhwIlnyEtPbRTE8qpKMfmZn3Vfdf2AIZnGekxbXX+ck=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S6x+pXYIpKRPDTlEcwZAoAVlquUTvOuakPujvz/4gBWHaCRDVuq6x3rTy3BaB//EKx5BKBv4cfq1Oks2H5JKkDZjShQrmSgZXi0Dl1YHPJ64YWpx5E5zq/CYRhX26bxsLXmDQMCBfuTQiWEJiIt1pF7vLcEhEJneYTyazS1iaPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VY2bG6CQGztT3t;
	Mon,  6 May 2024 21:40:10 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id E5C5E180065;
	Mon,  6 May 2024 21:43:34 +0800 (CST)
Received: from hulk-vt.huawei.com (10.67.174.26) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 6 May 2024 21:43:34 +0800
From: Xiu Jianfeng <xiujianfeng@huawei.com>
To: <hannes@cmpxchg.org>, <mhocko@kernel.org>, <roman.gushchin@linux.dev>,
	<shakeel.butt@linux.dev>, <muchun.song@linux.dev>,
	<akpm@linux-foundation.org>
CC: <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH -next] mm: memcg: use meaningful error code for return value
Date: Mon, 6 May 2024 13:36:43 +0000
Message-ID: <20240506133643.1124102-1-xiujianfeng@huawei.com>
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

alloc_mem_cgroup_per_node_info() returns 1 if failed, use -ENOMEM
instead, which is more meaningful.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 mm/memcontrol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d11536ef59ef..657f68b536c4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5659,7 +5659,7 @@ static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
 
 	pn = kzalloc_node(sizeof(*pn), GFP_KERNEL, node);
 	if (!pn)
-		return 1;
+		return -ENOMEM;
 
 	pn->lruvec_stats = kzalloc_node(sizeof(struct lruvec_stats), GFP_KERNEL,
 					node);
@@ -5679,7 +5679,7 @@ static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
 fail:
 	kfree(pn->lruvec_stats);
 	kfree(pn);
-	return 1;
+	return -ENOMEM;
 }
 
 static void free_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
-- 
2.34.1


