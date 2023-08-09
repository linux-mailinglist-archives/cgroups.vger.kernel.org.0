Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5841F7754F4
	for <lists+cgroups@lfdr.de>; Wed,  9 Aug 2023 10:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjHIITX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 9 Aug 2023 04:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjHIITW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 9 Aug 2023 04:19:22 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4398DE7D;
        Wed,  9 Aug 2023 01:19:21 -0700 (PDT)
Received: from kwepemm600006.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RLNDs1xc7z1hwDR;
        Wed,  9 Aug 2023 16:16:29 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemm600006.china.huawei.com
 (7.193.23.105) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 16:19:18 +0800
From:   Wenyu Liu <liuwenyu7@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>
CC:     <louhongxiang@huawei.com>
Subject: [PATCH] cgroup:clean an indentation issue, remove extraneous tabs
Date:   Wed, 9 Aug 2023 16:19:31 +0800
Message-ID: <20230809081931.3745405-1-liuwenyu7@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600006.china.huawei.com (7.193.23.105)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

There is an extraneous tab around css_set_count,
clean it by remove the tab.

Signed-off-by: Wenyu Liu <liuwenyu7@huawei.com>
---
 kernel/cgroup/cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index f55a40db065f..12a8dfeb45f4 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -767,7 +767,7 @@ struct css_set init_css_set = {
 	.dfl_cgrp		= &cgrp_dfl_root.cgrp,
 };
 
-static int css_set_count	= 1;	/* 1 for init_css_set */
+static int css_set_count = 1;	/* 1 for init_css_set */
 
 static bool css_set_threaded(struct css_set *cset)
 {
-- 
2.33.0

