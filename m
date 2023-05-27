Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518D67131B0
	for <lists+cgroups@lfdr.de>; Sat, 27 May 2023 03:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243988AbjE0BnD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 26 May 2023 21:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244009AbjE0Bmz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 26 May 2023 21:42:55 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF7DE5E;
        Fri, 26 May 2023 18:42:37 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QSkvF1P9hzqTQT;
        Sat, 27 May 2023 09:38:01 +0800 (CST)
Received: from huawei.com (10.175.104.170) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sat, 27 May
 2023 09:42:34 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <lizefan.x@bytedance.com>, <tj@kernel.org>, <hannes@cmpxchg.org>
CC:     <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] cgroup: remove unused macro for_each_e_css()
Date:   Sat, 27 May 2023 17:33:53 +0800
Message-ID: <20230527093353.153078-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

for_each_e_css() is unused now. Remove it.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 kernel/cgroup/cgroup.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 625d7483951c..413b4f1f1b70 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -689,21 +689,6 @@ EXPORT_SYMBOL_GPL(of_css);
 				lockdep_is_held(&cgroup_mutex)))) { }	\
 		else
 
-/**
- * for_each_e_css - iterate all effective css's of a cgroup
- * @css: the iteration cursor
- * @ssid: the index of the subsystem, CGROUP_SUBSYS_COUNT after reaching the end
- * @cgrp: the target cgroup to iterate css's of
- *
- * Should be called under cgroup_[tree_]mutex.
- */
-#define for_each_e_css(css, ssid, cgrp)					    \
-	for ((ssid) = 0; (ssid) < CGROUP_SUBSYS_COUNT; (ssid)++)	    \
-		if (!((css) = cgroup_e_css_by_mask(cgrp,		    \
-						   cgroup_subsys[(ssid)]))) \
-			;						    \
-		else
-
 /**
  * do_each_subsys_mask - filter for_each_subsys with a bitmask
  * @ss: the iteration cursor
-- 
2.27.0

