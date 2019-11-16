Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7EE0FEA5E
	for <lists+cgroups@lfdr.de>; Sat, 16 Nov 2019 04:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfKPDPQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 Nov 2019 22:15:16 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:51689 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727256AbfKPDPP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 Nov 2019 22:15:15 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R281e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0TiBsg6Y_1573874109;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TiBsg6Y_1573874109)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 16 Nov 2019 11:15:09 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     alex.shi@linux.alibaba.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Arun KS <arunks@codeaurora.org>,
        Rong Chen <rong.a.chen@intel.com>
Subject: [PATCH v3 2/7] mm/lruvec: add irqsave flags into lruvec struct
Date:   Sat, 16 Nov 2019 11:15:01 +0800
Message-Id: <1573874106-23802-3-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1573874106-23802-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1573874106-23802-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

We need a irqflags vaiable to save state when do irqsave action, declare
it here would make code more clear/clean.

Rong Chen <rong.a.chen@intel.com> reported the 'irqflags' variable need
move to the tail of lruvec struct otherwise it causes 18% regressions of
vm-scalability testing on his machine. So add the flags and lru_lock to
both near struct tail, even I have no clue of this perf losing.

Originally-from: Hugh Dickins <hughd@google.com>
Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Wei Yang <richard.weiyang@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Arun KS <arunks@codeaurora.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
CC: Rong Chen <rong.a.chen@intel.com>
Cc: cgroups@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 include/linux/mmzone.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index a13b8a602ee5..9b8b8daf4e03 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -269,6 +269,8 @@ struct lruvec {
 	unsigned long			flags;
 	/* per lruvec lru_lock for memcg */
 	spinlock_t			lru_lock;
+	/* flags for irqsave */
+	unsigned long			irqflags;
 #ifdef CONFIG_MEMCG
 	struct pglist_data *pgdat;
 #endif
-- 
1.8.3.1

