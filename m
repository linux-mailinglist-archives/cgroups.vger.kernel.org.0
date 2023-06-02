Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2061271FB4E
	for <lists+cgroups@lfdr.de>; Fri,  2 Jun 2023 09:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbjFBHpX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Jun 2023 03:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234168AbjFBHpJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 2 Jun 2023 03:45:09 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B181985
        for <cgroups@vger.kernel.org>; Fri,  2 Jun 2023 00:44:21 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QXZgt3sLkztQW7;
        Fri,  2 Jun 2023 15:41:30 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 2 Jun 2023 15:43:46 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
        <cuigaosheng1@huawei.com>
CC:     <cgroups@vger.kernel.org>
Subject: [PATCH -next] cgroup: Replace the css_set call with cgroup_get
Date:   Fri, 2 Jun 2023 15:43:46 +0800
Message-ID: <20230602074346.333276-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

We will release the refcnt of cgroup via cgroup_put, for example
in the cgroup_lock_and_drain_offline function, so replace css_get
with the cgroup_get function for better readability.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 kernel/cgroup/cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 8b8ca2e01019..7d4272778c76 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -619,7 +619,7 @@ EXPORT_SYMBOL_GPL(cgroup_get_e_css);
 static void cgroup_get_live(struct cgroup *cgrp)
 {
 	WARN_ON_ONCE(cgroup_is_dead(cgrp));
-	css_get(&cgrp->self);
+	cgroup_get(cgrp);
 }
 
 /**
-- 
2.25.1

