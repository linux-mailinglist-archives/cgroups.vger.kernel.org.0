Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E743513D277
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2020 04:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730750AbgAPDFX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Jan 2020 22:05:23 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:60397 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730707AbgAPDFW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Jan 2020 22:05:22 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07484;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0TnrFiO5_1579143916;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TnrFiO5_1579143916)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 16 Jan 2020 11:05:16 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        shakeelb@google.com, hannes@cmpxchg.org
Cc:     Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: [PATCH v8 10/10] mm/memcg: add debug checking in lock_page_memcg
Date:   Thu, 16 Jan 2020 11:05:09 +0800
Message-Id: <1579143909-156105-11-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579143909-156105-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1579143909-156105-1-git-send-email-alex.shi@linux.alibaba.com>
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
index a567fd868739..4ad1b4d2eb1e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2029,6 +2029,12 @@ struct mem_cgroup *lock_page_memcg(struct page *page)
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

