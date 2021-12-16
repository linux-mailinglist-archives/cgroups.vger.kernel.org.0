Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8A364767DF
	for <lists+cgroups@lfdr.de>; Thu, 16 Dec 2021 03:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbhLPCVn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Dec 2021 21:21:43 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:16818 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbhLPCVg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Dec 2021 21:21:36 -0500
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JDwns2GqZz91dC;
        Thu, 16 Dec 2021 10:20:49 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 16 Dec 2021 10:21:22 +0800
Received: from ubuntu1804.huawei.com (10.67.174.152) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 16 Dec 2021 10:21:21 +0800
From:   Wang Weiyang <wangweiyang2@huawei.com>
To:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <vdavydov.dev@gmail.com>, <akpm@linux-foundation.org>
CC:     <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] mm/memcg: Use struct_size() helper in kzalloc()
Date:   Thu, 16 Dec 2021 10:20:24 +0800
Message-ID: <20211216022024.127375-1-wangweiyang2@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.152]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version, in
order to avoid any potential type mistakes or integer overflows that, in
the worst scenario, could lead to heap overflows.

Link: https://github.com/KSPP/linux/issues/160
Signed-off-by: Wang Weiyang <wangweiyang2@huawei.com>
---
 mm/memcontrol.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 54afa29145e8..ec4b677cdcad 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5129,15 +5129,11 @@ static void mem_cgroup_free(struct mem_cgroup *memcg)
 static struct mem_cgroup *mem_cgroup_alloc(void)
 {
 	struct mem_cgroup *memcg;
-	unsigned int size;
 	int node;
 	int __maybe_unused i;
 	long error = -ENOMEM;
 
-	size = sizeof(struct mem_cgroup);
-	size += nr_node_ids * sizeof(struct mem_cgroup_per_node *);
-
-	memcg = kzalloc(size, GFP_KERNEL);
+	memcg = kzalloc(struct_size(memcg, nodeinfo, nr_node_ids), GFP_KERNEL);
 	if (!memcg)
 		return ERR_PTR(error);
 
-- 
2.17.1

