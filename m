Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C077131FB
	for <lists+cgroups@lfdr.de>; Sat, 27 May 2023 04:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjE0CkN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 26 May 2023 22:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjE0CkN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 26 May 2023 22:40:13 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FDFC9;
        Fri, 26 May 2023 19:40:11 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QSm9f52TQzqSHN;
        Sat, 27 May 2023 10:35:34 +0800 (CST)
Received: from huawei.com (10.175.104.170) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sat, 27 May
 2023 10:40:07 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <roman.gushchin@linux.dev>, <shakeelb@google.com>,
        <akpm@linux-foundation.org>
CC:     <muchun.song@linux.dev>, <cgroups@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] memcg: remove unused mem_cgroup_from_obj()
Date:   Sat, 27 May 2023 18:31:26 +0800
Message-ID: <20230527103126.398267-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The function mem_cgroup_from_obj() is not used anymore. Remove it and
clean up relevant comments.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/memcontrol.h |  6 ------
 mm/memcontrol.c            | 31 -------------------------------
 2 files changed, 37 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 00a88cf947e1..ce8c2355ed9f 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1813,7 +1813,6 @@ static inline int memcg_kmem_id(struct mem_cgroup *memcg)
 	return memcg ? memcg->kmemcg_id : -1;
 }
 
-struct mem_cgroup *mem_cgroup_from_obj(void *p);
 struct mem_cgroup *mem_cgroup_from_slab_obj(void *p);
 
 static inline void count_objcg_event(struct obj_cgroup *objcg,
@@ -1876,11 +1875,6 @@ static inline int memcg_kmem_id(struct mem_cgroup *memcg)
 	return -1;
 }
 
-static inline struct mem_cgroup *mem_cgroup_from_obj(void *p)
-{
-	return NULL;
-}
-
 static inline struct mem_cgroup *mem_cgroup_from_slab_obj(void *p)
 {
 	return NULL;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6a3d4ce87b8a..532b29c9a0fe 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2972,37 +2972,6 @@ struct mem_cgroup *mem_cgroup_from_obj_folio(struct folio *folio, void *p)
 /*
  * Returns a pointer to the memory cgroup to which the kernel object is charged.
  *
- * A passed kernel object can be a slab object, vmalloc object or a generic
- * kernel page, so different mechanisms for getting the memory cgroup pointer
- * should be used.
- *
- * In certain cases (e.g. kernel stacks or large kmallocs with SLUB) the caller
- * can not know for sure how the kernel object is implemented.
- * mem_cgroup_from_obj() can be safely used in such cases.
- *
- * The caller must ensure the memcg lifetime, e.g. by taking rcu_read_lock(),
- * cgroup_mutex, etc.
- */
-struct mem_cgroup *mem_cgroup_from_obj(void *p)
-{
-	struct folio *folio;
-
-	if (mem_cgroup_disabled())
-		return NULL;
-
-	if (unlikely(is_vmalloc_addr(p)))
-		folio = page_folio(vmalloc_to_page(p));
-	else
-		folio = virt_to_folio(p);
-
-	return mem_cgroup_from_obj_folio(folio, p);
-}
-
-/*
- * Returns a pointer to the memory cgroup to which the kernel object is charged.
- * Similar to mem_cgroup_from_obj(), but faster and not suitable for objects,
- * allocated using vmalloc().
- *
  * A passed kernel object must be a slab object or a generic kernel page.
  *
  * The caller must ensure the memcg lifetime, e.g. by taking rcu_read_lock(),
-- 
2.27.0

