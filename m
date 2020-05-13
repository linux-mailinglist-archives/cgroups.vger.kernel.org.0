Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCE11D11B9
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2020 13:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgEMLr6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 May 2020 07:47:58 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:36644 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726031AbgEMLr6 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 13 May 2020 07:47:58 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0302926D489EF7EEA254;
        Wed, 13 May 2020 19:47:56 +0800 (CST)
Received: from [10.133.206.78] (10.133.206.78) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 13 May
 2020 19:47:50 +0800
Subject: [PATCH v2] memcg: Fix memcg_kmem_bypass() for remote memcg charging
To:     Michal Hocko <mhocko@kernel.org>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Cgroups <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Roman Gushchin" <guro@fb.com>, Shakeel Butt <shakeelb@google.com>
References: <e6927a82-949c-bdfd-d717-0a14743c6759@huawei.com>
 <20200513090502.GV29153@dhcp22.suse.cz>
 <76f71776-d049-7407-8574-86b6e9d80704@huawei.com>
 <20200513112905.GX29153@dhcp22.suse.cz>
From:   Zefan Li <lizefan@huawei.com>
Message-ID: <3a721f62-5a66-8bc5-247b-5c8b7c51c555@huawei.com>
Date:   Wed, 13 May 2020 19:47:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20200513112905.GX29153@dhcp22.suse.cz>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.206.78]
X-CFilter-Loop: Reflected
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

While trying to use remote memcg charging in an out-of-tree kernel module
I found it's not working, because the current thread is a workqueue thread.

As we will probably encounter this issue in the future as the users of
memalloc_use_memcg() grow, it's better we fix it now.

Signed-off-by: Zefan Li <lizefan@huawei.com>
---

v2: add a comment as sugguested by Michal. and add changelog to explain why
upstream kernel needs this fix.

---

 mm/memcontrol.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a3b97f1..43a12ed 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2802,6 +2802,9 @@ static void memcg_schedule_kmem_cache_create(struct mem_cgroup *memcg,
 
 static inline bool memcg_kmem_bypass(void)
 {
+	/* Allow remote memcg charging in kthread contexts. */
+	if (unlikely(current->active_memcg))
+		return false;
 	if (in_interrupt() || !current->mm || (current->flags & PF_KTHREAD))
 		return true;
 	return false;
-- 
2.7.4

