Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3B462BA64C
	for <lists+cgroups@lfdr.de>; Fri, 20 Nov 2020 10:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgKTJff (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 20 Nov 2020 04:35:35 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:34656 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725942AbgKTJff (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 20 Nov 2020 04:35:35 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UFykla5_1605864932;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UFykla5_1605864932)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 20 Nov 2020 17:35:32 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH next-akpm] mm/memcg: remove incorrect comments
Date:   Fri, 20 Nov 2020 17:35:30 +0800
Message-Id: <1605864930-49405-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Swapcache readahead pages are charged before get used, so it unlikely be
migrated before charged. remove the incorrect comments.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Johannes Weiner <hannes@cmpxchg.org> 
Cc: Michal Hocko <mhocko@kernel.org> 
Cc: Vladimir Davydov <vdavydov.dev@gmail.com> 
Cc: Andrew Morton <akpm@linux-foundation.org> 
Cc: cgroups@vger.kernel.org 
Cc: linux-mm@kvack.org 
Cc: linux-kernel@vger.kernel.org 
---
 mm/memcontrol.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 45465c03a8d7..08c267305725 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6941,7 +6941,6 @@ void mem_cgroup_migrate(struct page *oldpage, struct page *newpage)
 	if (page_memcg(newpage))
 		return;
 
-	/* Swapcache readahead pages can get replaced before being charged */
 	memcg = page_memcg(oldpage);
 	VM_WARN_ON_ONCE_PAGE(!memcg, oldpage);
 	if (!memcg)
-- 
2.29.GIT

