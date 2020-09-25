Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C71A4278E4F
	for <lists+cgroups@lfdr.de>; Fri, 25 Sep 2020 18:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbgIYQWs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 25 Sep 2020 12:22:48 -0400
Received: from m12-15.163.com ([220.181.12.15]:49220 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727751AbgIYQWs (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 25 Sep 2020 12:22:48 -0400
X-Greylist: delayed 917 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Sep 2020 12:22:47 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=TPYFb
        PSp4V8vYQ4z0mS+XWUEYAjUGpB+g/xY+pc+6GE=; b=PVQYhqPDCUwiAEdCTv3nZ
        UM+WBwcstQfT/KMzCBTVXr5/Obw6/vTsN3e/TxWPG8kZ6Rs2ZRplwls5wzjfy5Lw
        +668EgpaU6EqLwJvcPjwdcOjjC5Cy1YB7H7L4iPdmgcPN7OO3OLqteOKxjsZ9xbN
        6FwYolGypdX4NBacz+rx58=
Received: from localhost (unknown [101.86.214.224])
        by smtp11 (Coremail) with SMTP id D8CowAAH3peaFW5fMOwfDw--.9007S2;
        Sat, 26 Sep 2020 00:06:51 +0800 (CST)
Date:   Sat, 26 Sep 2020 00:06:50 +0800
From:   Hui Su <sh_def@163.com>
To:     lizefan@huawei.com, tj@kernel.org, hannes@cmpxchg.org,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] mm: fix some comments in page_alloc.c and mempolicy.c
Message-ID: <20200925160650.GA42847@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: D8CowAAH3peaFW5fMOwfDw--.9007S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFWUurWrtF4fCw1rAF45GFg_yoW8tFWkpF
        WkGa45A3WFvF1jk392ka1Dury0gw48Ja17KFn5Gwn5Z3W3tF4qkF9rWwnxZryYyF1Y9a4U
        trZIvr4Yg3WDJ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jSnmiUUUUU=
X-Originating-IP: [101.86.214.224]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbitwSqX1aEFvbE+wABsK
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

1. the cpuset.c has been moved from kernel/cpuset.c to
kernel/cgroup/cpuset.c long time ago, but the comment is stale,
so we update it.
2. get_page_from_freelist() may alloc many pages according to
order, we may use pages for better.

Signed-off-by: Hui Su <sh_def@163.com>
---
 kernel/cgroup/cpuset.c | 2 +-
 mm/mempolicy.c         | 2 +-
 mm/page_alloc.c        | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 642415b8c3c9..1d3011c1aab6 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1,5 +1,5 @@
 /*
- *  kernel/cpuset.c
+ *  kernel/cgroup/cpuset.c
  *
  *  Processor and Memory placement constraints for sets of tasks.
  *
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index eddbe4e56c73..ac59b049b16c 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2295,7 +2295,7 @@ int vma_dup_policy(struct vm_area_struct *src, struct vm_area_struct *dst)
  * rebinds the mempolicy its copying by calling mpol_rebind_policy()
  * with the mems_allowed returned by cpuset_mems_allowed().  This
  * keeps mempolicies cpuset relative after its cpuset moves.  See
- * further kernel/cpuset.c update_nodemask().
+ * further kernel/cgroup/cpuset.c update_nodemask().
  *
  * current's mempolicy may be rebinded by the other task(the task that changes
  * cpuset's mems), so we needn't do rebind work for current task.
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index fab5e97dc9ca..1e3c7493e1cb 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3709,7 +3709,7 @@ static inline unsigned int current_alloc_flags(gfp_t gfp_mask,
 
 /*
  * get_page_from_freelist goes through the zonelist trying to allocate
- * a page.
+ * pages.
  */
 static struct page *
 get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
@@ -3723,7 +3723,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 retry:
 	/*
 	 * Scan zonelist, looking for a zone with enough free.
-	 * See also __cpuset_node_allowed() comment in kernel/cpuset.c.
+	 * See also __cpuset_node_allowed() comment in kernel/cgroup/cpuset.c.
 	 */
 	no_fallback = alloc_flags & ALLOC_NOFRAGMENT;
 	z = ac->preferred_zoneref;
-- 
2.25.1


