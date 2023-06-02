Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A6071FB50
	for <lists+cgroups@lfdr.de>; Fri,  2 Jun 2023 09:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbjFBHq1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Jun 2023 03:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234165AbjFBHqJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 2 Jun 2023 03:46:09 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E767A1B9
        for <cgroups@vger.kernel.org>; Fri,  2 Jun 2023 00:45:28 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QXZfS5rc7z18M15;
        Fri,  2 Jun 2023 15:40:16 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 2 Jun 2023 15:44:57 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
        <cuigaosheng1@huawei.com>
CC:     <cgroups@vger.kernel.org>
Subject: [PATCH -next] rdmacg: fix kernel-doc warnings in rdmacg
Date:   Fri, 2 Jun 2023 15:44:56 +0800
Message-ID: <20230602074456.333840-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

Fix all kernel-doc warnings in rdmacg:

kernel/cgroup/rdma.c:209: warning: Function parameter or member 'cg'
not described in 'rdmacg_uncharge_hierarchy'
kernel/cgroup/rdma.c:230: warning: Function parameter or member 'cg'
not described in 'rdmacg_uncharge'

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 kernel/cgroup/rdma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/cgroup/rdma.c b/kernel/cgroup/rdma.c
index 3135406608c7..ef5878fb2005 100644
--- a/kernel/cgroup/rdma.c
+++ b/kernel/cgroup/rdma.c
@@ -197,6 +197,7 @@ uncharge_cg_locked(struct rdma_cgroup *cg,
 
 /**
  * rdmacg_uncharge_hierarchy - hierarchically uncharge rdma resource count
+ * @cg: pointer to cg to uncharge and all parents in hierarchy
  * @device: pointer to rdmacg device
  * @stop_cg: while traversing hirerchy, when meet with stop_cg cgroup
  *           stop uncharging
@@ -221,6 +222,7 @@ static void rdmacg_uncharge_hierarchy(struct rdma_cgroup *cg,
 
 /**
  * rdmacg_uncharge - hierarchically uncharge rdma resource count
+ * @cg: pointer to cg to uncharge and all parents in hierarchy
  * @device: pointer to rdmacg device
  * @index: index of the resource to uncharge in cgroup in given resource pool
  */
-- 
2.25.1

