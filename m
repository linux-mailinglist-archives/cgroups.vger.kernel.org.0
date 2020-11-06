Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5891A2A957D
	for <lists+cgroups@lfdr.de>; Fri,  6 Nov 2020 12:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgKFLdj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 6 Nov 2020 06:33:39 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:39911 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726447AbgKFLdj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 6 Nov 2020 06:33:39 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UEQewtU_1604662416;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UEQewtU_1604662416)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 06 Nov 2020 19:33:36 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     hannes@cmpxchg.org, akpm@linux-foundation.org
Cc:     Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/memcg: update page struct member in comments
Date:   Fri,  6 Nov 2020 19:33:33 +0800
Message-Id: <1604662413-5734-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The page->mem_cgroup member is replaced by memcg_data, and add a helper
page_memcg() for it. Need to update comments to avoid confusing.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Johannes Weiner <hannes@cmpxchg.org> 
Cc: Michal Hocko <mhocko@kernel.org> 
Cc: Vladimir Davydov <vdavydov.dev@gmail.com> 
Cc: Andrew Morton <akpm@linux-foundation.org> 
Cc: cgroups@vger.kernel.org 
Cc: linux-mm@kvack.org 
Cc: linux-kernel@vger.kernel.org 
---
 mm/memcontrol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b2aa3b73ab82..8a8debea34fc 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1310,7 +1310,7 @@ int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
  * @page: the page
  * @pgdat: pgdat of the page
  *
- * This function relies on page->mem_cgroup being stable - see the
+ * This function relies on page_memcg(page) being stable - see the
  * access rules in commit_charge().
  */
 struct lruvec *mem_cgroup_page_lruvec(struct page *page, struct pglist_data *pgdat)
@@ -2862,7 +2862,7 @@ static void commit_charge(struct page *page, struct mem_cgroup *memcg)
 {
 	VM_BUG_ON_PAGE(page_memcg(page), page);
 	/*
-	 * Any of the following ensures page->mem_cgroup stability:
+	 * Any of the following ensures page_memcg(page) stability:
 	 *
 	 * - the page lock
 	 * - LRU isolation
-- 
1.8.3.1

