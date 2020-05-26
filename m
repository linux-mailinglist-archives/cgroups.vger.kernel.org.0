Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80EF31E190E
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2020 03:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388169AbgEZBZa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 25 May 2020 21:25:30 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55234 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387888AbgEZBZa (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 25 May 2020 21:25:30 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D5C4EA0762D88C679684;
        Tue, 26 May 2020 09:25:27 +0800 (CST)
Received: from [10.166.213.22] (10.166.213.22) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 26 May
 2020 09:25:25 +0800
From:   Zefan Li <lizefan@huawei.com>
Subject: [PATCH v3] memcg: Fix memcg_kmem_bypass() for remote memcg charging
To:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Cgroups <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>
References: <e6927a82-949c-bdfd-d717-0a14743c6759@huawei.com>
 <20200513090502.GV29153@dhcp22.suse.cz>
 <76f71776-d049-7407-8574-86b6e9d80704@huawei.com>
 <20200513112905.GX29153@dhcp22.suse.cz>
Message-ID: <1d202a12-26fe-0012-ea14-f025ddcd044a@huawei.com>
Date:   Tue, 26 May 2020 09:25:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200513112905.GX29153@dhcp22.suse.cz>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.213.22]
X-CFilter-Loop: Reflected
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

While trying to use remote memcg charging in an out-of-tree kernel module
I found it's not working, because the current thread is a workqueue thread.

As we will probably encounter this issue in the future as the users of
memalloc_use_memcg() grow, and it's nothing wrong for this usage, it's
better we fix it now.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Zefan Li <lizefan@huawei.com>
---

v3: bypass __GFP_ACCOUNT allocations in interrupt contexts.

---
 mm/memcontrol.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a3b97f1..3c7717a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2802,7 +2802,12 @@ static void memcg_schedule_kmem_cache_create(struct mem_cgroup *memcg,
 
 static inline bool memcg_kmem_bypass(void)
 {
-	if (in_interrupt() || !current->mm || (current->flags & PF_KTHREAD))
+	if (in_interrupt())
+		return true;
+
+	/* Allow remote memcg charging in kthread contexts. */
+	if ((!current->mm || (current->flags & PF_KTHREAD)) &&
+	     !current->active_memcg)
 		return true;
 	return false;
 }
-- 
2.7.4

