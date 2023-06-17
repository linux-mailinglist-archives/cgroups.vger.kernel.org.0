Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88154733F2B
	for <lists+cgroups@lfdr.de>; Sat, 17 Jun 2023 09:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234389AbjFQH1c (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 17 Jun 2023 03:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjFQH1b (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 17 Jun 2023 03:27:31 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6861F2688;
        Sat, 17 Jun 2023 00:27:30 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Qjnb86hHQzMnyq;
        Sat, 17 Jun 2023 15:24:20 +0800 (CST)
Received: from huawei.com (10.175.104.170) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sat, 17 Jun
 2023 15:27:26 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <roman.gushchin@linux.dev>, <shakeelb@google.com>,
        <akpm@linux-foundation.org>
CC:     <muchun.song@linux.dev>, <cgroups@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] memcg: remove unneeded header files
Date:   Sat, 17 Jun 2023 15:26:58 +0800
Message-ID: <20230617072658.1826560-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

Remove some unneeded header files. No functional change intended.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memcontrol.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d42742edfeac..a2c82a18745d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -30,14 +30,10 @@
 #include <linux/cgroup.h>
 #include <linux/pagewalk.h>
 #include <linux/sched/mm.h>
-#include <linux/shmem_fs.h>
-#include <linux/hugetlb.h>
 #include <linux/pagemap.h>
 #include <linux/vm_event_item.h>
 #include <linux/smp.h>
 #include <linux/page-flags.h>
-#include <linux/backing-dev.h>
-#include <linux/bit_spinlock.h>
 #include <linux/rcupdate.h>
 #include <linux/limits.h>
 #include <linux/export.h>
@@ -66,7 +62,6 @@
 #include <linux/sched/isolation.h>
 #include "internal.h"
 #include <net/sock.h>
-#include <net/ip.h>
 #include "slab.h"
 #include "swap.h"
 
-- 
2.27.0

