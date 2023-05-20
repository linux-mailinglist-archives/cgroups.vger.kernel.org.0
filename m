Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4858570A64F
	for <lists+cgroups@lfdr.de>; Sat, 20 May 2023 10:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjETIPK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 20 May 2023 04:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjETIPK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 20 May 2023 04:15:10 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D71CE43;
        Sat, 20 May 2023 01:15:08 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QNc0G2PW8zsRpX;
        Sat, 20 May 2023 16:13:02 +0800 (CST)
Received: from huawei.com (10.175.104.170) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sat, 20 May
 2023 16:15:05 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <longman@redhat.com>, <lizefan.x@bytedance.com>, <tj@kernel.org>,
        <hannes@cmpxchg.org>
CC:     <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] cgroup/cpuset: remove unneeded header files
Date:   Sun, 21 May 2023 00:06:34 +0800
Message-ID: <20230520160634.3015106-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Remove some unnecessary header files. No functional change intended.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 kernel/cgroup/cpuset.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index e4ca2dd2b764..a136c3e6144b 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -25,25 +25,13 @@
 #include <linux/cpu.h>
 #include <linux/cpumask.h>
 #include <linux/cpuset.h>
-#include <linux/err.h>
-#include <linux/errno.h>
-#include <linux/file.h>
-#include <linux/fs.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
-#include <linux/kmod.h>
-#include <linux/kthread.h>
-#include <linux/list.h>
 #include <linux/mempolicy.h>
 #include <linux/mm.h>
 #include <linux/memory.h>
 #include <linux/export.h>
-#include <linux/mount.h>
-#include <linux/fs_context.h>
-#include <linux/namei.h>
-#include <linux/pagemap.h>
-#include <linux/proc_fs.h>
 #include <linux/rcupdate.h>
 #include <linux/sched.h>
 #include <linux/sched/deadline.h>
@@ -51,18 +39,9 @@
 #include <linux/sched/task.h>
 #include <linux/seq_file.h>
 #include <linux/security.h>
-#include <linux/slab.h>
 #include <linux/spinlock.h>
-#include <linux/stat.h>
-#include <linux/string.h>
-#include <linux/time.h>
-#include <linux/time64.h>
-#include <linux/backing-dev.h>
-#include <linux/sort.h>
 #include <linux/oom.h>
 #include <linux/sched/isolation.h>
-#include <linux/uaccess.h>
-#include <linux/atomic.h>
 #include <linux/mutex.h>
 #include <linux/cgroup.h>
 #include <linux/wait.h>
-- 
2.27.0

