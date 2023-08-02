Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B8776C35D
	for <lists+cgroups@lfdr.de>; Wed,  2 Aug 2023 05:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbjHBDLr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Aug 2023 23:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjHBDLq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Aug 2023 23:11:46 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0D5AC
        for <cgroups@vger.kernel.org>; Tue,  1 Aug 2023 20:11:45 -0700 (PDT)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RFxnF6Wf1z1GDJ7;
        Wed,  2 Aug 2023 11:10:41 +0800 (CST)
Received: from ci.huawei.com (10.67.175.89) by kwepemi500024.china.huawei.com
 (7.221.188.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 11:11:43 +0800
From:   Cai Xinchen <caixinchen1@huawei.com>
To:     <longman@redhat.com>, <lizefan.x@bytedance.com>, <tj@kernel.org>,
        <hannes@cmpxchg.org>
CC:     <cgroups@vger.kernel.org>, <caixinchen1@huawei.com>
Subject: [PATCH -next] cgroup/cpuset: fix kernel-doc
Date:   Wed, 2 Aug 2023 03:04:12 +0000
Message-ID: <20230802030412.173344-1-caixinchen1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.89]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500024.china.huawei.com (7.221.188.100)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Add kernel-doc of param @rotor to fix warnings:

kernel/cgroup/cpuset.c:4162: warning: Function parameter or member
'rotor' not described in 'cpuset_spread_node'
kernel/cgroup/cpuset.c:3771: warning: Function parameter or member
'work' not described in 'cpuset_hotplug_workfn'

Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>
---
 kernel/cgroup/cpuset.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index b278b60ed788..58ec88efa4f8 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3753,6 +3753,7 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 
 /**
  * cpuset_hotplug_workfn - handle CPU/memory hotunplug for a cpuset
+ * @work: unused
  *
  * This function is called after either CPU or memory configuration has
  * changed and updates cpuset accordingly.  The top_cpuset is always
@@ -4135,6 +4136,7 @@ bool cpuset_node_allowed(int node, gfp_t gfp_mask)
 
 /**
  * cpuset_spread_node() - On which node to begin search for a page
+ * @rotor: round robin rotor
  *
  * If a task is marked PF_SPREAD_PAGE or PF_SPREAD_SLAB (as for
  * tasks in a cpuset with is_spread_page or is_spread_slab set),
-- 
2.17.1

