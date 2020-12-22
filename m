Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 494F92E0599
	for <lists+cgroups@lfdr.de>; Tue, 22 Dec 2020 06:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725782AbgLVFVv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Dec 2020 00:21:51 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:53155 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725300AbgLVFVr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Dec 2020 00:21:47 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UJPqUQy_1608614460;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UJPqUQy_1608614460)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 22 Dec 2020 13:21:00 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     hughd@google.com
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] mm/memcg: revise the using condition of lock_page_lruvec function series
Date:   Tue, 22 Dec 2020 13:20:51 +0800
Message-Id: <1608614453-10739-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

lock_page_lruvec() and its variants are safe to use under the same
conditions as commit_charge(): add lock_page_memcg() to the comment.

Polished with Hugh Dickins' suggestions, thanks!

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Acked-by: Hugh Dickins <hughd@google.com>
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
index b80328f52fb4..8d400efc81b9 100644
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
+ * These functions are safe to use under any of the following conditions:
+ * - page locked
+ * - PageLRU cleared
+ * - lock_page_memcg()
+ * - page->_refcount is zero
  */
 struct lruvec *lock_page_lruvec(struct page *page)
 {
-- 
2.29.GIT

