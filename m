Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC5822D7CB
	for <lists+cgroups@lfdr.de>; Sat, 25 Jul 2020 15:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbgGYNBp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 25 Jul 2020 09:01:45 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:47728 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727079AbgGYNA3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 25 Jul 2020 09:00:29 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0U3l6fmD_1595682015;
Received: from aliy8.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U3l6fmD_1595682015)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 25 Jul 2020 21:00:24 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        rong.a.chen@intel.com
Cc:     Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: [PATCH v17 09/21] mm/memcg: add debug checking in lock_page_memcg
Date:   Sat, 25 Jul 2020 20:59:46 +0800
Message-Id: <1595681998-19193-10-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1595681998-19193-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1595681998-19193-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Add a debug checking in lock_page_memcg, then we could get alarm
if anything wrong here.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: cgroups@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/memcontrol.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5d45a9159af9..20c8ed69a930 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1983,6 +1983,12 @@ struct mem_cgroup *lock_page_memcg(struct page *page)
 	if (unlikely(!memcg))
 		return NULL;
 
+#ifdef CONFIG_PROVE_LOCKING
+	local_irq_save(flags);
+	might_lock(&memcg->move_lock);
+	local_irq_restore(flags);
+#endif
+
 	if (atomic_read(&memcg->moving_account) <= 0)
 		return memcg;
 
-- 
1.8.3.1

