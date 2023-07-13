Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBEF27520A7
	for <lists+cgroups@lfdr.de>; Thu, 13 Jul 2023 13:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234371AbjGML7b (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 Jul 2023 07:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234486AbjGML73 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 13 Jul 2023 07:59:29 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674DC1993;
        Thu, 13 Jul 2023 04:59:28 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R1tRs6fNDz18Lrv;
        Thu, 13 Jul 2023 19:58:49 +0800 (CST)
Received: from huawei.com (10.174.151.185) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 13 Jul
 2023 19:59:25 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <tj@kernel.org>, <hannes@cmpxchg.org>, <lizefan.x@bytedance.com>
CC:     <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] cgroup: remove obsolete comment above struct cgroupstats
Date:   Thu, 13 Jul 2023 19:59:38 +0800
Message-ID: <20230713115938.177428-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

There's no flag in the delay accounting structure indicates that the task
is waiting on IO since commit 1193829da1a6 ("delayacct: cleanup flags in
struct task_delay_info and functions use it"). So remove the comment.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/uapi/linux/cgroupstats.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/uapi/linux/cgroupstats.h b/include/uapi/linux/cgroupstats.h
index aa306e4cd6c1..80b2c8594480 100644
--- a/include/uapi/linux/cgroupstats.h
+++ b/include/uapi/linux/cgroupstats.h
@@ -24,8 +24,6 @@
  * basis. This data is shared using taskstats.
  *
  * Most of these states are derived by looking at the task->state value
- * For the nr_io_wait state, a flag in the delay accounting structure
- * indicates that the task is waiting on IO
  *
  * Each member is aligned to a 8 byte boundary.
  */
-- 
2.33.0

