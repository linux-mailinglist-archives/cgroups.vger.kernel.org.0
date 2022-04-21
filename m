Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1092509FA7
	for <lists+cgroups@lfdr.de>; Thu, 21 Apr 2022 14:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384795AbiDUMcc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 Apr 2022 08:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238064AbiDUMc0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 Apr 2022 08:32:26 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2B53135E;
        Thu, 21 Apr 2022 05:29:36 -0700 (PDT)
Received: from kwepemi500010.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KkcH93Ds9zFqWR;
        Thu, 21 Apr 2022 20:27:01 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 kwepemi500010.china.huawei.com (7.221.188.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Apr 2022 20:29:33 +0800
Received: from ubuntu1804.huawei.com (10.67.174.175) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Apr 2022 20:29:32 +0800
From:   Lu Jialin <lujialin4@huawei.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>
CC:     Lu Jialin <lujialin4@huawei.com>,
        Wang Weiyang <wangweiyang2@huawei.com>,
        <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: [PATCH -next] mm/memcontrol.c: remove unused private flag of memory.oom_control
Date:   Thu, 21 Apr 2022 20:27:55 +0800
Message-ID: <20220421122755.40899-1-lujialin4@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.175]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

There is no use for the private value, __OOM_TYPE and OOM notifier
OOM_CONTROL. Therefore remove them to make the code clean.

Signed-off-by: Lu Jialin <lujialin4@huawei.com>
---
 mm/memcontrol.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 725f76723220..3aea256bfe7a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -209,7 +209,6 @@ static struct move_charge_struct {
 enum res_type {
 	_MEM,
 	_MEMSWAP,
-	_OOM_TYPE,
 	_KMEM,
 	_TCP,
 };
@@ -217,8 +216,6 @@ enum res_type {
 #define MEMFILE_PRIVATE(x, val)	((x) << 16 | (val))
 #define MEMFILE_TYPE(val)	((val) >> 16 & 0xffff)
 #define MEMFILE_ATTR(val)	((val) & 0xffff)
-/* Used for OOM notifier */
-#define OOM_CONTROL		(0)
 
 /*
  * Iteration constructs for visiting all cgroups (under a tree).  If
@@ -4883,7 +4880,6 @@ static struct cftype mem_cgroup_legacy_files[] = {
 		.name = "oom_control",
 		.seq_show = mem_cgroup_oom_control_read,
 		.write_u64 = mem_cgroup_oom_control_write,
-		.private = MEMFILE_PRIVATE(_OOM_TYPE, OOM_CONTROL),
 	},
 	{
 		.name = "pressure_level",
-- 
2.17.1

