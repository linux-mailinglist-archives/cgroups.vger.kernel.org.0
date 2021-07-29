Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBF63DA386
	for <lists+cgroups@lfdr.de>; Thu, 29 Jul 2021 14:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237313AbhG2M6A (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Jul 2021 08:58:00 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:13211 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237268AbhG2M6A (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 29 Jul 2021 08:58:00 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Gb9Qk1XBcz1CQFL;
        Thu, 29 Jul 2021 20:51:58 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 29
 Jul 2021 20:57:54 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <vdavydov.dev@gmail.com>, <akpm@linux-foundation.org>
CC:     <shakeelb@google.com>, <guro@fb.com>, <willy@infradead.org>,
        <alexs@kernel.org>, <richard.weiyang@gmail.com>,
        <songmuchun@bytedance.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 2/5] mm, memcg: narrow the scope of percpu_charge_mutex
Date:   Thu, 29 Jul 2021 20:57:52 +0800
Message-ID: <20210729125755.16871-3-linmiaohe@huawei.com>
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

Since percpu_charge_mutex is only used inside drain_all_stock(), we can
narrow the scope of percpu_charge_mutex by moving it here.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6580c2381a3e..a03e24e57cd9 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2050,7 +2050,6 @@ struct memcg_stock_pcp {
 #define FLUSHING_CACHED_CHARGE	0
 };
 static DEFINE_PER_CPU(struct memcg_stock_pcp, memcg_stock);
-static DEFINE_MUTEX(percpu_charge_mutex);
 
 #ifdef CONFIG_MEMCG_KMEM
 static void drain_obj_stock(struct obj_stock *stock);
@@ -2209,6 +2208,7 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
  */
 static void drain_all_stock(struct mem_cgroup *root_memcg)
 {
+	static DEFINE_MUTEX(percpu_charge_mutex);
 	int cpu, curcpu;
 
 	/* If someone's already draining, avoid adding running more workers. */
-- 
2.23.0

