Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D02340F3BA
	for <lists+cgroups@lfdr.de>; Fri, 17 Sep 2021 10:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245132AbhIQIJ2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 Sep 2021 04:09:28 -0400
Received: from relay.sw.ru ([185.231.240.75]:35812 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245027AbhIQIJZ (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 17 Sep 2021 04:09:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:Subject
        :From; bh=vNgx/3n9bi2etAGIYh4+okt/y0F7gydwzwqScVihv4w=; b=iE23CrPuqYwx6L+WuP0
        MSRozyky9urm64czXwWLrNZ/9ayDJS3aSLwMOheJcHJmfyOFUBrdXFadLP1BGBDronLgyS7h3usB1
        piWpEhLqoM1qklkFq3aRzLuG0vmdNKeGMym8Xsi1sQMvfui8ccy6JpnJzOA3VxSbOB8PjqsSCNM=;
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1mR8tW-002Gyw-D9; Fri, 17 Sep 2021 11:06:50 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH mm] vmalloc: back off when the current task is OOM-killed
To:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@openvz.org
References: <YT8PEBbYZhLixEJD@dhcp22.suse.cz>
Message-ID: <d07a5540-3e07-44ba-1e59-067500f024d9@virtuozzo.com>
Date:   Fri, 17 Sep 2021 11:06:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YT8PEBbYZhLixEJD@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Huge vmalloc allocation on heavy loaded node can lead to a global
memory shortage. A task called vmalloc can have the worst badness
and be chosen by OOM-killer, however received fatal signal and
oom victim mark does not interrupt allocation cycle. Vmalloc will
continue allocating pages over and over again, exacerbating the crisis
and consuming the memory freed up by another killed tasks.

This patch allows OOM-killer to break vmalloc cycle, makes OOM more
effective and avoid host panic.

Unfortunately it is not 100% safe. Previous attempt to break vmalloc
cycle was reverted by commit b8c8a338f75e ("Revert "vmalloc: back off when
the current task is killed"") due to some vmalloc callers did not handled
failures properly. Found issues was resolved, however, there may
be other similar places.

Such failures may be acceptable for emergencies, such as OOM. On the other
hand, we would like to detect them earlier. However they are quite rare,
and will be hidden by OOM messages, so I'm afraid they wikk have quite
small chance of being noticed and reported.

To improve the detection of such places this patch also interrupts the vmalloc
allocation cycle for all fatal signals. The checks are hidden under DEBUG_VM
config option to do not break unaware production kernels.

Vmalloc uses new alloc_pages_bulk subsystem, so newly added checks can
affect other users of this subsystem.

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 mm/page_alloc.c | 5 +++++
 mm/vmalloc.c    | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b37435c274cf..133d52e507ff 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5288,6 +5288,11 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 			continue;
 		}
 
+		if (tsk_is_oom_victim(current) ||
+		    (IS_ENABLED(CONFIG_DEBUG_VM) &&
+		     fatal_signal_pending(current)))
+			break;
+
 		page = __rmqueue_pcplist(zone, 0, ac.migratetype, alloc_flags,
 								pcp, pcp_list);
 		if (unlikely(!page)) {
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index c3b8e3e5cfc5..04b291076726 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -38,6 +38,7 @@
 #include <linux/pgtable.h>
 #include <linux/uaccess.h>
 #include <linux/hugetlb.h>
+#include <linux/oom.h>
 #include <asm/tlbflush.h>
 #include <asm/shmparam.h>
 
@@ -2860,6 +2861,11 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 		struct page *page;
 		int i;
 
+		if (tsk_is_oom_victim(current) ||
+		    (IS_ENABLED(CONFIG_DEBUG_VM) &&
+		     fatal_signal_pending(current)))
+			break;
+
 		page = alloc_pages_node(nid, gfp, order);
 		if (unlikely(!page))
 			break;
-- 
2.31.1

