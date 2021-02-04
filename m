Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F057230F15B
	for <lists+cgroups@lfdr.de>; Thu,  4 Feb 2021 12:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235435AbhBDK5C (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 4 Feb 2021 05:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235464AbhBDK47 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 4 Feb 2021 05:56:59 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC6DC0613ED
        for <cgroups@vger.kernel.org>; Thu,  4 Feb 2021 02:56:19 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id t29so1868810pfg.11
        for <cgroups@vger.kernel.org>; Thu, 04 Feb 2021 02:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bomnKjBCXlMUt7cumGwFSxIt2tLEfiNfG1uDxtiHzHo=;
        b=meRFeoFABKNahcTD5pEZi9cJb0xVYtEo0jR+vAzCdEludgjz8sf1Qlv2/xeRPDfibp
         /MMKS0gDIAcIwS+spfwSSxSYmiHHlYLXKz78sdAEln7aHWvn0QsCJNlPvKVOmygR7EfF
         nSWXTdN5o2V9xWtAhYeJgMlGZE86yc7er/RVSRnjuvKWa6RjgUQXsVKFyMLzh72oLILh
         ZefaeRzKTsudfYwco8W1CE1Vr2eIFb+VxUGIitkSeo2UM5YS+/bx7Xwr9TH4t1EkX+rc
         uS0RLOQkFJ07jRmOC12Y7X8c6oWiSWepD2xx1ceyRtqiYop3Hqiqt9lcpsOK7wc4pLM+
         sZlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bomnKjBCXlMUt7cumGwFSxIt2tLEfiNfG1uDxtiHzHo=;
        b=TC81d4964NcKZjOHmvQt5Z0m3rHBebz1YUhV18dzg5U0I4f9/PFQwyGmX4zgr1ozWS
         kCiQ/CGH+azaZizUMp3+2pDuQf4LOU4MOGlVnWVwcwJth38a2p4j6eftUkSPzFwemR/L
         30BiEJAS5K+dFORsnPQhULkvxiBilX70DhOlsZg2Zyn2fy8/KK9ufebIFEjvl1WO8oU/
         cDrFtvb2LPUKrB5LRH3ZwoUAbEbdkRlbWr1Y6xmPFbCmOxGnmIq0CYLs+RG7uZSniC9u
         RjAdtmbdcOq1s2r8PjCIEuP7dB26oDk2H5nqj2IbbLNRGNnqd+3yE6Hp3ub1dC+p1RYk
         eh3Q==
X-Gm-Message-State: AOAM530GRJDZGnb08E7IOZQB7YhfmFbb8AXVy6Nu5048PV4Gx3qYKhEC
        OCZuzfk7Xl5XqU/1h7jVmAvyXw==
X-Google-Smtp-Source: ABdhPJxUgUArlXg8y2yW1BuiqYJ2lzKT+G+NfzP6TzP4jp5cEnjoQAINnZWIf/miYy7OqREs06CHgA==
X-Received: by 2002:a63:375d:: with SMTP id g29mr4490430pgn.226.1612436179150;
        Thu, 04 Feb 2021 02:56:19 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id z15sm2043493pjz.41.2021.02.04.02.56.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2021 02:56:18 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm: memcontrol: replace the loop with a list_for_each_entry()
Date:   Thu,  4 Feb 2021 18:53:20 +0800
Message-Id: <20210204105320.46072-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The rule of list walk has gone since:

 commit a9d5adeeb4b2 ("mm/memcontrol: allow to uncharge page without using page->lru field")

So remove the strange comment and replace the loop with a
list_for_each_entry().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6c7f1ea3955e..43341bd7ea1c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6891,24 +6891,11 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
 static void uncharge_list(struct list_head *page_list)
 {
 	struct uncharge_gather ug;
-	struct list_head *next;
+	struct page *page;
 
 	uncharge_gather_clear(&ug);
-
-	/*
-	 * Note that the list can be a single page->lru; hence the
-	 * do-while loop instead of a simple list_for_each_entry().
-	 */
-	next = page_list->next;
-	do {
-		struct page *page;
-
-		page = list_entry(next, struct page, lru);
-		next = page->lru.next;
-
+	list_for_each_entry(page, page_list, lru)
 		uncharge_page(page, &ug);
-	} while (next != page_list);
-
 	uncharge_batch(&ug);
 }
 
-- 
2.11.0

