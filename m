Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5E075DFC3
	for <lists+cgroups@lfdr.de>; Sun, 23 Jul 2023 05:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjGWDZo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 22 Jul 2023 23:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjGWDZn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 22 Jul 2023 23:25:43 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9762C10CA;
        Sat, 22 Jul 2023 20:25:41 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R7pYP5dPSzVjD4;
        Sun, 23 Jul 2023 11:24:09 +0800 (CST)
Received: from huawei.com (10.174.151.185) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 23 Jul
 2023 11:25:38 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <cgroups@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH] mm/memcg: fix obsolete function name in mem_cgroup_protection()
Date:   Sun, 23 Jul 2023 11:25:38 +0800
Message-ID: <20230723032538.3190239-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Commit 45c7f7e1ef17 ("mm, memcg: decouple e{low,min} state mutations from
protection checks") changed the function name but not the corresponding
comment.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/memcontrol.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 058fb748e128..64014b656a0f 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -582,9 +582,9 @@ static inline void mem_cgroup_protection(struct mem_cgroup *root,
 	/*
 	 * There is no reclaim protection applied to a targeted reclaim.
 	 * We are special casing this specific case here because
-	 * mem_cgroup_protected calculation is not robust enough to keep
-	 * the protection invariant for calculated effective values for
-	 * parallel reclaimers with different reclaim target. This is
+	 * mem_cgroup_calculate_protection calculation is not robust enough
+	 * to keep the protection invariant for calculated effective values
+	 * for parallel reclaimers with different reclaim target. This is
 	 * especially a problem for tail memcgs (as they have pages on LRU)
 	 * which would want to have effective values 0 for targeted reclaim
 	 * but a different value for external reclaim.
-- 
2.33.0

