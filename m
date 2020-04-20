Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 352851B1924
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2020 00:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgDTWMU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 20 Apr 2020 18:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728446AbgDTWMR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 20 Apr 2020 18:12:17 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6C2C061A0E
        for <cgroups@vger.kernel.org>; Mon, 20 Apr 2020 15:12:16 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id j4so12520098qkc.11
        for <cgroups@vger.kernel.org>; Mon, 20 Apr 2020 15:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mru2mqYssRMwFvfM60SVK8LHEOtTvwZ9sk9Ozs6ntCE=;
        b=jbzqhoEM5d7NDzw3vfdtgPSSoDlrWCej+05GdZmq+IawnWaqCKW0HH/bet3KzfXkzI
         X40GyZbo6g+QTskRmkxQ4BoKE1dowe9171ocp8SAujcL5g1va70+O2r6uieOwu60OKv8
         2iBVNUCDBAtCC17cBY5xLP4VqdlKXcG9yz2XzIA5GCVzfi2UTnZy+eQnY/ovTSS3Cfgi
         LSZ9xrD0VnTnru809Wm7EHvlmTJ7PAPtjZB29vsCjFkd2c0vuv7jfoYdDviMy/qWaLjt
         yW2FMnGLHwetNA39YeYWTBk6TaxRFtCzGlSWHqLRh9vgdXbHPv8ItR6ybXmvfQgCLRiO
         5F6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mru2mqYssRMwFvfM60SVK8LHEOtTvwZ9sk9Ozs6ntCE=;
        b=QNZKTulGtUx3okpm0FG4xT3n64585iVjqQSVkctqa4/JUUbivvWralOgbKGP+D4R28
         Na786MIhQChC5n9wtnvGVTZhrjXVx1o++DVdT71J57zAT390Ht5Qbx5ySdJ1/FHVhGfY
         DIiNL8GNO3AenAb2b1dZncLX16OkJUMhQ9X1M2lvvehx6keHC3idKqHodJOe+Ov8JubU
         OQMMyGWRdj+o95pZITauh/1LOBin3amOW/iiV6X3nDMIZ7lLnbByaH35PnANDZT+azw8
         fLR38ivAS6c2yQamdrGAg/Y7tTqJdxbzBXizW8hwx6ECJOd7DPgTZaSEEmKKaIV/HmJE
         WFIQ==
X-Gm-Message-State: AGi0PuZbYx+EqZfOYw44dLxL55fO6V7gmVUradK9ZNCo1aXQaLdHpX8V
        K7o5aT1yGf0Kidu7jNYd5LzVlQ==
X-Google-Smtp-Source: APiQypKy4lffy6IiWnR6FoQOXGtMzDxnDrBryWX0kbP1QfAiEJF+n/mTkp0kRiachpRUe+VdcRJLdw==
X-Received: by 2002:a37:6587:: with SMTP id z129mr18837123qkb.437.1587420735277;
        Mon, 20 Apr 2020 15:12:15 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:e6b6])
        by smtp.gmail.com with ESMTPSA id i56sm521733qte.6.2020.04.20.15.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 15:12:14 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Joonsoo Kim <js1304@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 18/18] mm: memcontrol: update page->mem_cgroup stability rules
Date:   Mon, 20 Apr 2020 18:11:26 -0400
Message-Id: <20200420221126.341272-19-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200420221126.341272-1-hannes@cmpxchg.org>
References: <20200420221126.341272-1-hannes@cmpxchg.org>
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
---
 mm/memcontrol.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a8cce52b6b4d..7b63260c9b57 100644
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
2.26.0

