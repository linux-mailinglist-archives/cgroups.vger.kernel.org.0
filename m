Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6564E6161
	for <lists+cgroups@lfdr.de>; Thu, 24 Mar 2022 10:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348900AbiCXJ6E (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 24 Mar 2022 05:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349380AbiCXJ54 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 24 Mar 2022 05:57:56 -0400
X-Greylist: delayed 2004 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 24 Mar 2022 02:56:23 PDT
Received: from SHSQR01.unisoc.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E259F6C6
        for <cgroups@vger.kernel.org>; Thu, 24 Mar 2022 02:56:22 -0700 (PDT)
Received: from SHSQR01.spreadtrum.com (localhost [127.0.0.2] (may be forged))
        by SHSQR01.unisoc.com with ESMTP id 22O9MwcT031546
        for <cgroups@vger.kernel.org>; Thu, 24 Mar 2022 17:22:58 +0800 (CST)
        (envelope-from zhaoyang.huang@unisoc.com)
Received: from SHSend.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id 22O9MgKw031135
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO);
        Thu, 24 Mar 2022 17:22:43 +0800 (CST)
        (envelope-from zhaoyang.huang@unisoc.com)
Received: from bj03382pcu.spreadtrum.com (10.0.74.65) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Thu, 24 Mar 2022 17:22:43 +0800
From:   "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        ke wang <ke.wang@unisoc.com>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>
Subject: [RFC PATCH] cgroup: introduce proportional protection on memcg
Date:   Thu, 24 Mar 2022 17:22:23 +0800
Message-ID: <1648113743-32622-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.74.65]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 22O9MgKw031135
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

current memcg protection via min,low,high asks for an evaluation of
protected entity, which could be hard for some system. Furthermore, the usage
could also be various under different scenarios(imagin keep protecting 50M when
usage change from 100M to 300M), which make the protection less meaning.
So we introduce the proportional protection over memcg's ever highest
usage(watermark) to overcome above constraints.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 include/linux/page_counter.h |  3 +++
 mm/memcontrol.c              | 17 +++++++++++++----
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
index 6795913..7762629 100644
--- a/include/linux/page_counter.h
+++ b/include/linux/page_counter.h
@@ -27,6 +27,9 @@ struct page_counter {
 	unsigned long watermark;
 	unsigned long failcnt;
 
+	/* proportional protection */
+	unsigned long min_prop;
+	unsigned long low_prop;
 	/*
 	 * 'parent' is placed here to be far from 'usage' to reduce
 	 * cache false sharing, as 'usage' is written mostly while
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 508bcea..937c6ce 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6616,6 +6616,7 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
 {
 	unsigned long usage, parent_usage;
 	struct mem_cgroup *parent;
+	unsigned long memcg_emin, memcg_elow, parent_emin, parent_elow;
 
 	if (mem_cgroup_disabled())
 		return;
@@ -6650,14 +6651,22 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
 
 	parent_usage = page_counter_read(&parent->memory);
 
+	/* use proportional protect first and take 1024 as 100% */
+	memcg_emin = READ_ONCE(memcg->memory.min_prop) ?
+		READ_ONCE(memcg->memory.min_prop) * READ_ONCE(memcg->memory.watermark) / 1024 : READ_ONCE(memcg->memory.min);
+	memcg_elow = READ_ONCE(memcg->memory.low_prop) ?
+		READ_ONCE(memcg->memory.low_prop) * READ_ONCE(memcg->memory.watermark) / 1024 : READ_ONCE(memcg->memory.low);
+	parent_emin = READ_ONCE(parent->memory.min_prop) ?
+		READ_ONCE(parent->memory.min_prop) * READ_ONCE(parent->memory.watermark) / 1024 : READ_ONCE(parent->memory.emin);
+	parent_elow = READ_ONCE(parent->memory.low_prop) ?
+		READ_ONCE(parent->memory.low_prop) * READ_ONCE(parent->memory.watermark) / 1024 : READ_ONCE(parent->memory.elow);
+
 	WRITE_ONCE(memcg->memory.emin, effective_protection(usage, parent_usage,
-			READ_ONCE(memcg->memory.min),
-			READ_ONCE(parent->memory.emin),
+			memcg_emin, parent_emin,
 			atomic_long_read(&parent->memory.children_min_usage)));
 
 	WRITE_ONCE(memcg->memory.elow, effective_protection(usage, parent_usage,
-			READ_ONCE(memcg->memory.low),
-			READ_ONCE(parent->memory.elow),
+			memcg_elow, parent_elow,
 			atomic_long_read(&parent->memory.children_low_usage)));
 }
 
-- 
1.9.1

