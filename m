Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C983E2DCC7C
	for <lists+cgroups@lfdr.de>; Thu, 17 Dec 2020 07:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725468AbgLQG3o (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 17 Dec 2020 01:29:44 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:34243 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725930AbgLQG3o (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 17 Dec 2020 01:29:44 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UItliQ7_1608186540;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UItliQ7_1608186540)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 17 Dec 2020 14:29:01 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] mm/memcg: revise the using condition of lock_page_lruvec function series
Date:   Thu, 17 Dec 2020 14:28:50 +0800
Message-Id: <1608186532-81218-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The series function could be used under lock_page_memcg(), add this and
a bit style changes following commit_charge().

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: cgroups@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/memcontrol.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b80328f52fb4..e6b50d068b2f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1345,10 +1345,11 @@ void lruvec_memcg_debug(struct lruvec *lruvec, struct page *page)
  * lock_page_lruvec - lock and return lruvec for a given page.
  * @page: the page
  *
- * This series functions should be used in either conditions:
- * PageLRU is cleared or unset
- * or page->_refcount is zero
- * or page is locked.
+ * This series functions should be used in any one of following conditions:
+ * - PageLRU is cleared or unset
+ * - page->_refcount is zero
+ * - page is locked.
+ * - lock_page_memcg()
  */
 struct lruvec *lock_page_lruvec(struct page *page)
 {
-- 
2.29.GIT

