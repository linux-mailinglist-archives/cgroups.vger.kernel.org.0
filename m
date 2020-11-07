Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF682AA56D
	for <lists+cgroups@lfdr.de>; Sat,  7 Nov 2020 14:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgKGNej (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 7 Nov 2020 08:34:39 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:56002 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727084AbgKGNei (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 7 Nov 2020 08:34:38 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R521e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UEWYIIT_1604756073;
Received: from IT-FVFX43SYHV2H.lan(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UEWYIIT_1604756073)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 07 Nov 2020 21:34:33 +0800
Subject: Re: [PATCH] mm/memcg: update page struct member in comments
To:     Roman Gushchin <guro@fb.com>
Cc:     hannes@cmpxchg.org, akpm@linux-foundation.org,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1604662413-5734-1-git-send-email-alex.shi@linux.alibaba.com>
 <20201106205140.GA2285866@carbon.dhcp.thefacebook.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <1491c150-1cc0-6062-08ea-9c891548a3bc@linux.alibaba.com>
Date:   Sat, 7 Nov 2020 21:34:15 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201106205140.GA2285866@carbon.dhcp.thefacebook.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



ÔÚ 2020/11/7 ÉÏÎç4:51, Roman Gushchin Ð´µÀ:
> There are "page and memcg binding" and "page's memcg" used in similar cases,
> I think it's more obvious than "page_memcg(page) being stable".
> 
> Maybe it helps to address Ira's comment.
> 
> Anyway, please feel free to add:
> Acked-by: Roman Gushchin <guro@fb.com>
> 
> Thanks!

Thanks a lot! Roman.
here is the updated patch with your suggestion and ack.


From 0db2bd8f3833ec5e58c6978f771b05e4902e5156 Mon Sep 17 00:00:00 2001
From: Alex Shi <alex.shi@linux.alibaba.com>
Date: Fri, 6 Nov 2020 19:33:33 +0800
Subject: [PATCH v2] mm/memcg: update page struct member in comments

The page->mem_cgroup member is replaced by memcg_data, and add a helper
page_memcg() for it. Need to update comments to avoid confusing.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Acked-by: Roman Gushchin <guro@fb.com>
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
index 7657f16cf992..b6560ab1adc4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1330,7 +1330,7 @@ void lruvec_memcg_debug(struct lruvec *lruvec, struct page *page)
  * @page: the page
  * @pgdat: pgdat of the page
  *
- * This function relies on page->mem_cgroup being stable - see the
+ * This function relies on page's memcg being stable - see the
  * access rules in commit_charge().
  */
 struct lruvec *mem_cgroup_page_lruvec(struct page *page, struct pglist_data *pgdat)
@@ -2942,7 +2942,7 @@ static void commit_charge(struct page *page, struct mem_cgroup *memcg)
 {
 	VM_BUG_ON_PAGE(page_memcg(page), page);
 	/*
-	 * Any of the following ensures page->mem_cgroup stability:
+	 * Any of the following ensures page's memcg stability:
 	 *
 	 * - the page lock
 	 * - LRU isolation
-- 
1.8.3.1

