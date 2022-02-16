Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFC94B7ED7
	for <lists+cgroups@lfdr.de>; Wed, 16 Feb 2022 04:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344191AbiBPDSS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 15 Feb 2022 22:18:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344188AbiBPDSR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 15 Feb 2022 22:18:17 -0500
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12212FEB0C;
        Tue, 15 Feb 2022 19:18:01 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V4bNgsw_1644981474;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0V4bNgsw_1644981474)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 16 Feb 2022 11:17:59 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     lizefan.x@bytedance.com
Cc:     tj@kernel.org, hannes@cmpxchg.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] cpuset: Fix kernel-doc
Date:   Wed, 16 Feb 2022 11:17:53 +0800
Message-Id: <20220216031753.8298-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Fix the following W=1 kernel warnings:

kernel/cgroup/cpuset.c:3718: warning: expecting prototype for
cpuset_memory_pressure_bump(). Prototype was for
__cpuset_memory_pressure_bump() instead.

kernel/cgroup/cpuset.c:3568: warning: expecting prototype for
cpuset_node_allowed(). Prototype was for __cpuset_node_allowed()
instead.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 kernel/cgroup/cpuset.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 97c53f3cc917..5de18448016c 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3524,8 +3524,8 @@ static struct cpuset *nearest_hardwall_ancestor(struct cpuset *cs)
 	return cs;
 }
 
-/**
- * cpuset_node_allowed - Can we allocate on a memory node?
+/*
+ * __cpuset_node_allowed - Can we allocate on a memory node?
  * @node: is this an allowed node?
  * @gfp_mask: memory allocation flags
  *
@@ -3696,8 +3696,8 @@ void cpuset_print_current_mems_allowed(void)
 
 int cpuset_memory_pressure_enabled __read_mostly;
 
-/**
- * cpuset_memory_pressure_bump - keep stats of per-cpuset reclaims.
+/*
+ * __cpuset_memory_pressure_bump - keep stats of per-cpuset reclaims.
  *
  * Keep a running average of the rate of synchronous (direct)
  * page reclaim efforts initiated by tasks in each cpuset.
@@ -3712,7 +3712,7 @@ int cpuset_memory_pressure_enabled __read_mostly;
  * "memory_pressure".  Value displayed is an integer
  * representing the recent rate of entry into the synchronous
  * (direct) page reclaim by any task attached to the cpuset.
- **/
+ */
 
 void __cpuset_memory_pressure_bump(void)
 {
-- 
2.20.1.7.g153144c

