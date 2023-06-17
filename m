Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52649733FA7
	for <lists+cgroups@lfdr.de>; Sat, 17 Jun 2023 10:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343977AbjFQIbS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 17 Jun 2023 04:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234669AbjFQIbQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 17 Jun 2023 04:31:16 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE3A10CF;
        Sat, 17 Jun 2023 01:31:14 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Qjq4F2MQpzqSNm;
        Sat, 17 Jun 2023 16:31:09 +0800 (CST)
Received: from huawei.com (10.175.104.170) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sat, 17 Jun
 2023 16:31:11 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <longman@redhat.com>, <tj@kernel.org>, <hannes@cmpxchg.org>,
        <lizefan.x@bytedance.com>
CC:     <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] cgroup/cpuset: remove unneeded nodes_or() in cpuset_change_task_nodemask()
Date:   Sat, 17 Jun 2023 16:30:43 +0800
Message-ID: <20230617083043.2065556-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The tsk->mems_allowed is changed before calling mpol_rebind_task() and
being reassigned right after it. But tsk->mems_allowed is not needed
inside mpol_rebind_task(). So remove unneeded tsk->mems_allowed modify
via nodes_or() here.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 kernel/cgroup/cpuset.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 58e6f18f01c1..33a429c1179f 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1941,7 +1941,6 @@ static void cpuset_change_task_nodemask(struct task_struct *tsk,
 	local_irq_disable();
 	write_seqcount_begin(&tsk->mems_allowed_seq);
 
-	nodes_or(tsk->mems_allowed, tsk->mems_allowed, *newmems);
 	mpol_rebind_task(tsk, newmems);
 	tsk->mems_allowed = *newmems;
 
-- 
2.27.0

