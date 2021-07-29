Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 943D33DA389
	for <lists+cgroups@lfdr.de>; Thu, 29 Jul 2021 14:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237352AbhG2M6C (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Jul 2021 08:58:02 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:7895 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234245AbhG2M6A (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 29 Jul 2021 08:58:00 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Gb9TF6k1qz81CY;
        Thu, 29 Jul 2021 20:54:09 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 29
 Jul 2021 20:57:55 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <vdavydov.dev@gmail.com>, <akpm@linux-foundation.org>
CC:     <shakeelb@google.com>, <guro@fb.com>, <willy@infradead.org>,
        <alexs@kernel.org>, <richard.weiyang@gmail.com>,
        <songmuchun@bytedance.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 3/5] mm, memcg: save some atomic ops when flush is already true
Date:   Thu, 29 Jul 2021 20:57:53 +0800
Message-ID: <20210729125755.16871-4-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210729125755.16871-1-linmiaohe@huawei.com>
References: <20210729125755.16871-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Add 'else' to save some atomic ops in obj_stock_flush_required() when
flush is already true. No functional change intended here.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a03e24e57cd9..5b4592d1e0f2 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2231,7 +2231,7 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
 		if (memcg && stock->nr_pages &&
 		    mem_cgroup_is_descendant(memcg, root_memcg))
 			flush = true;
-		if (obj_stock_flush_required(stock, root_memcg))
+		else if (obj_stock_flush_required(stock, root_memcg))
 			flush = true;
 		rcu_read_unlock();
 
-- 
2.23.0

