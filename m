Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8130C1CB74F
	for <lists+cgroups@lfdr.de>; Fri,  8 May 2020 20:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgEHScx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 8 May 2020 14:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728066AbgEHScr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 8 May 2020 14:32:47 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEB8C05BD0B
        for <cgroups@vger.kernel.org>; Fri,  8 May 2020 11:32:47 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id z90so2121510qtd.10
        for <cgroups@vger.kernel.org>; Fri, 08 May 2020 11:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Eum9bjhCQUemh9iSZtdHJuvrUPzxWGTkZ4CcEro9n7E=;
        b=jiNhQR7oDFgCIaeq8w1kb7yBCUxXWI4PGAu8hvAJp/EDuZPdtqs0Kv0eQRCIbghrLr
         plx1VKm4Sw92oc+8T9hBnws9X3YpMutk37X+Z4vvHpsPuGw4ZF1Y2rPRjkD1agBRSLF1
         kS797R/esbPerCLSlEDiYcRzyVwhJ24kA8ALmaEzLu9cjjv83Lmxp6XMkh3hMvNIqVEU
         XEuKmtJ486aKM1U5k7/+R0un2thzz8+m1v19Z7FPHL+BnJkUfBDg73JlyXZZ7nG9aKiE
         94bS/k6zSEgO9ITOLKwSURZnE+flX89sr9YP4oD6ByysAzQdkJOyP+fRM8bipeTGLD/0
         yqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Eum9bjhCQUemh9iSZtdHJuvrUPzxWGTkZ4CcEro9n7E=;
        b=HgeWwG4lVntqw/7SHZVaXUyzkN3ZNDPGK9CT44op5kC8euSt67HO4Xc1UNZWis8tDb
         71S5ppslnCzQGj/9MLrkT6gxJpcBioDrgUe2uN79rc4xoLErSMSTcvNvauh4tUMiBC7A
         8vqOGPtVM1UlG6EmcEEARakFPmSt6KsmoWap62sFo+3GQJ9BKoeTusnaIHuh5C1cvwhQ
         YcXXe4e+v9d80e7JrYe9WSlXCgKegQMa84ukAgXhq3nYIeRKwPSWZD+UJKptadvA2jtq
         JOuwSUI6/GWP+2tYco+o4B5dpBaNsaRt7kQ7+08IYeWOk3EBiZd9D9jccaoF7iDFl3NJ
         wR6w==
X-Gm-Message-State: AGi0PuaJe/IvkLx0vIqnM+bbhElo0fPAwi+O8auSYaXwviEE6vh3yYf6
        n7b4gR0vO5foEN3yg9eezuFqZw==
X-Google-Smtp-Source: APiQypJ0pdn3xZQfxhpj1b1EoTjr0iocaEQ2GoCK8oxJJWIkU3kVnVnuPWxhjkluRfHHIg6t3mG3Kw==
X-Received: by 2002:aed:2442:: with SMTP id s2mr4367165qtc.153.1588962766615;
        Fri, 08 May 2020 11:32:46 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2627])
        by smtp.gmail.com with ESMTPSA id 10sm2348766qtp.4.2020.05.08.11.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 11:32:45 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Joonsoo Kim <js1304@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 19/19] mm: memcontrol: update page->mem_cgroup stability rules
Date:   Fri,  8 May 2020 14:31:06 -0400
Message-Id: <20200508183105.225460-20-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508183105.225460-1-hannes@cmpxchg.org>
References: <20200508183105.225460-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The previous patches have simplified the access rules around
page->mem_cgroup somewhat:

1. We never change page->mem_cgroup while the page is isolated by
   somebody else. This was by far the biggest exception to our rules
   and it didn't stop at lock_page() or lock_page_memcg().

2. We charge pages before they get put into page tables now, so the
   somewhat fishy rule about "can be in page table as long as it's
   still locked" is now gone and boiled down to having an exclusive
   reference to the page.

Document the new rules. Any of the following will stabilize the
page->mem_cgroup association:

- the page lock
- LRU isolation
- lock_page_memcg()
- exclusive access to the page

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Alex Shi <alex.shi@linux.alibaba.com>
Reviewed-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 mm/memcontrol.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 491fdeec0ce4..865440e8438e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1201,9 +1201,8 @@ int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
  * @page: the page
  * @pgdat: pgdat of the page
  *
- * This function is only safe when following the LRU page isolation
- * and putback protocol: the LRU lock must be held, and the page must
- * either be PageLRU() or the caller must have isolated/allocated it.
+ * This function relies on page->mem_cgroup being stable - see the
+ * access rules in commit_charge().
  */
 struct lruvec *mem_cgroup_page_lruvec(struct page *page, struct pglist_data *pgdat)
 {
@@ -2605,18 +2604,12 @@ static void commit_charge(struct page *page, struct mem_cgroup *memcg)
 {
 	VM_BUG_ON_PAGE(page->mem_cgroup, page);
 	/*
-	 * Nobody should be changing or seriously looking at
-	 * page->mem_cgroup at this point:
-	 *
-	 * - the page is uncharged
-	 *
-	 * - the page is off-LRU
-	 *
-	 * - an anonymous fault has exclusive page access, except for
-	 *   a locked page table
+	 * Any of the following ensures page->mem_cgroup stability:
 	 *
-	 * - a page cache insertion, a swapin fault, or a migration
-	 *   have the page locked
+	 * - the page lock
+	 * - LRU isolation
+	 * - lock_page_memcg()
+	 * - exclusive reference
 	 */
 	page->mem_cgroup = memcg;
 }
-- 
2.26.2

