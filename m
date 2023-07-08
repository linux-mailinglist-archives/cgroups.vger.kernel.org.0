Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D1674BB65
	for <lists+cgroups@lfdr.de>; Sat,  8 Jul 2023 04:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjGHCcz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 7 Jul 2023 22:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGHCcy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 7 Jul 2023 22:32:54 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C34C8E;
        Fri,  7 Jul 2023 19:32:51 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QyZ3J2NKhzMqGH;
        Sat,  8 Jul 2023 10:29:32 +0800 (CST)
Received: from huawei.com (10.174.151.185) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 8 Jul
 2023 10:32:46 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <hannes@cmpxchg.org>,
        <mhocko@kernel.org>, <roman.gushchin@linux.dev>,
        <shakeelb@google.com>
CC:     <muchun.song@linux.dev>, <linux-mm@kvack.org>,
        <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2] mm/memcg: minor cleanup for MEM_CGROUP_ID_MAX
Date:   Sat, 8 Jul 2023 10:33:04 +0800
Message-ID: <20230708023304.1184111-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

MEM_CGROUP_ID_MAX is only used when CONFIG_MEMCG is configured. So remove
unneeded !CONFIG_MEMCG variant. Also it's only used in mem_cgroup_alloc(),
so move it from memcontrol.h to memcontrol.c. And further define it as:
  #define MEM_CGROUP_ID_MAX ((1UL << MEM_CGROUP_ID_SHIFT) - 1)
so if someone changes MEM_CGROUP_ID_SHIFT in the future, then
MEM_CGROUP_ID_MAX will be updated accordingly, as suggested by Muchun.

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/memcontrol.h | 2 --
 mm/memcontrol.c            | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 5818af8eca5a..58eb7ca65699 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -61,7 +61,6 @@ struct mem_cgroup_reclaim_cookie {
 #ifdef CONFIG_MEMCG
 
 #define MEM_CGROUP_ID_SHIFT	16
-#define MEM_CGROUP_ID_MAX	USHRT_MAX
 
 struct mem_cgroup_id {
 	int id;
@@ -1158,7 +1157,6 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 #else /* CONFIG_MEMCG */
 
 #define MEM_CGROUP_ID_SHIFT	0
-#define MEM_CGROUP_ID_MAX	0
 
 static inline struct mem_cgroup *folio_memcg(struct folio *folio)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e8ca4bdcb03c..284396ea8a33 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5165,6 +5165,7 @@ static struct cftype mem_cgroup_legacy_files[] = {
  * those references are manageable from userspace.
  */
 
+#define MEM_CGROUP_ID_MAX	((1UL << MEM_CGROUP_ID_SHIFT) - 1)
 static DEFINE_IDR(mem_cgroup_idr);
 
 static void mem_cgroup_id_remove(struct mem_cgroup *memcg)
-- 
2.33.0

