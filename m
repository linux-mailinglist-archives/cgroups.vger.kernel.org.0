Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDC03DA387
	for <lists+cgroups@lfdr.de>; Thu, 29 Jul 2021 14:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237295AbhG2M6A (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Jul 2021 08:58:00 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:12331 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237203AbhG2M57 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 29 Jul 2021 08:57:59 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Gb9S56lmzz7yRF;
        Thu, 29 Jul 2021 20:53:09 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 29
 Jul 2021 20:57:53 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <vdavydov.dev@gmail.com>, <akpm@linux-foundation.org>
CC:     <shakeelb@google.com>, <guro@fb.com>, <willy@infradead.org>,
        <alexs@kernel.org>, <richard.weiyang@gmail.com>,
        <songmuchun@bytedance.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 1/5] mm, memcg: remove unused functions
Date:   Thu, 29 Jul 2021 20:57:51 +0800
Message-ID: <20210729125755.16871-2-linmiaohe@huawei.com>
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

Since commit 2d146aa3aa84 ("mm: memcontrol: switch to rstat"), last user
of memcg_stat_item_in_bytes() is gone. And since commit fa40d1ee9f15 ("mm:
vmscan: memcontrol: remove mem_cgroup_select_victim_node()"), only the
declaration of mem_cgroup_select_victim_node() is remained here. Remove
them.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/memcontrol.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 7028d8e4a3d7..04437504444f 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -606,13 +606,6 @@ static inline bool PageMemcgKmem(struct page *page)
 	return folio_memcg_kmem(page_folio(page));
 }
 
-static __always_inline bool memcg_stat_item_in_bytes(int idx)
-{
-	if (idx == MEMCG_PERCPU_B)
-		return true;
-	return vmstat_item_in_bytes(idx);
-}
-
 static inline bool mem_cgroup_is_root(struct mem_cgroup *memcg)
 {
 	return (memcg == root_mem_cgroup);
@@ -916,11 +909,6 @@ static inline bool mem_cgroup_online(struct mem_cgroup *memcg)
 	return !!(memcg->css.flags & CSS_ONLINE);
 }
 
-/*
- * For memory reclaim.
- */
-int mem_cgroup_select_victim_node(struct mem_cgroup *memcg);
-
 void mem_cgroup_update_lru_size(struct lruvec *lruvec, enum lru_list lru,
 		int zid, int nr_pages);
 
-- 
2.23.0

