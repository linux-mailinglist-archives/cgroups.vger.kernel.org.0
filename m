Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF9FA1758EB
	for <lists+cgroups@lfdr.de>; Mon,  2 Mar 2020 12:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgCBLBI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Mar 2020 06:01:08 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:26314 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727663AbgCBLBI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Mar 2020 06:01:08 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0TrQmbg._1583146862;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TrQmbg._1583146862)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 02 Mar 2020 19:01:03 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     cgroups@vger.kernel.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        hannes@cmpxchg.org, lkp@intel.com
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 20/20] mm/memcg: add debug checking in lock_page_memcg
Date:   Mon,  2 Mar 2020 19:00:30 +0800
Message-Id: <1583146830-169516-21-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1583146830-169516-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1583146830-169516-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This extra irq disable/enable and BUG_ON checking costs 5% readtwice
performance on a 2 socket * 26 cores * HT box. So put it into
CONFIG_PROVE_LOCKING.

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
index 2d71e53ead88..8d7f6336f15c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2026,6 +2026,12 @@ struct mem_cgroup *lock_page_memcg(struct page *page)
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

