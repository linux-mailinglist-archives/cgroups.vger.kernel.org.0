Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E5C34164E
	for <lists+cgroups@lfdr.de>; Fri, 19 Mar 2021 08:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbhCSHQL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 19 Mar 2021 03:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234006AbhCSHPu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 19 Mar 2021 03:15:50 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25918C06175F
        for <cgroups@vger.kernel.org>; Fri, 19 Mar 2021 00:15:50 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id u190so1925413qkd.6
        for <cgroups@vger.kernel.org>; Fri, 19 Mar 2021 00:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ach62O71zJmjQaxBWOhbiCSRi6YbNUmXSSxM/3dIo+Q=;
        b=LLPxssSQQyhHC/5j0K/BnAF9lDHMavl2/PTd2rwGE98XJVC95NdTDe026Yif3esELH
         GRdvUKk+Uqgc+UFDBAhIRgK3rp7PfpFY0yWrP+rU/OYCI17KckVin8MPGJXa+i2G3oof
         YwH2dQ35WvcMKe8DiY1Zc5BH2axHtoXZ+EZw3eQFIblWMwZcWtiCFcVdg/AYV4CjuZsq
         yIbejLme3dOKD467pB9SBVkMhuNjXgbqSoT+wrkgn2q9gyuPSRQxQwl46Of0QzC/XtmL
         vAGYPoBoXtjdjuaF0391+wDtY3K0ddqc8GeWy1U7mEF7FG5JdAocigUxr81Qkiu9zlPJ
         54IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ach62O71zJmjQaxBWOhbiCSRi6YbNUmXSSxM/3dIo+Q=;
        b=rEcQgJcEA8LOK2N4TbBsXMQbfNG1CMAuRwR34Jo+iROF9GAeKyMJrfdkkksHh3AU7l
         Pc1eMgalydjtuDkJcFSMvFsMSrWt0WaR6l2mVQWRwHxM6wDt7nQ5Uuz1dGqWh9jIpIqc
         yE6hKOgFOY8qzRxFs2krN1GKeBI2yYOBkFZZFeArYJXbqE+lxJzClQOpYkGdSstidPcm
         w0CgXddOa5TkkdjUNvL8QDVHDljimziRJ2gabGI9rSiDQOPD65Q8yPQoG1U/EIfXCLCg
         Se9O8bfnqTKLF/UmoHvMaJOMHUkI5VjzePAwC5E2gSRU88mS/C9kWUcJ4mMb6pQEI5pk
         NXxQ==
X-Gm-Message-State: AOAM531oProhnpUna/WK7DBDflC+PlQ2rtueQyPr+gqjUNh4R7awmEtB
        K33t0V5FFW/fATaMWY4XzDUL7Q==
X-Google-Smtp-Source: ABdhPJzcVZooDuy5On6VBkwk0aHsGMJSy5WZ/VTSMoqE24RA8u3VTU1mcjFwPXOrAnTGoc8ZFG5Uew==
X-Received: by 2002:a05:620a:e10:: with SMTP id y16mr8123305qkm.375.1616138149176;
        Fri, 19 Mar 2021 00:15:49 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id r17sm3101975qtn.25.2021.03.19.00.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 00:15:48 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Zhou Guanghui <zhouguanghui1@huawei.com>,
        Zi Yan <ziy@nvidia.com>, Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH] mm: page_alloc: fix memcg accounting leak in speculative cache lookup
Date:   Fri, 19 Mar 2021 03:15:47 -0400
Message-Id: <20210319071547.60973-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

When the freeing of a higher-order page block (non-compound) races
with a speculative page cache lookup, __free_pages() needs to leave
the first order-0 page in the chunk to the lookup but free the buddy
pages that the lookup doesn't know about separately.

However, if such a higher-order page is charged to a memcg (e.g. !vmap
kernel stack)), only the first page of the block has page->memcg
set. That means we'll uncharge only one order-0 page from the entire
block, and leak the remainder.

Add a split_page_memcg() to __free_pages() right before it starts
taking the higher-order page apart and freeing its individual
constituent pages. This ensures all of them will have the memcg
linkage set up for correct uncharging. Also update the comments a bit
to clarify what exactly is happening to the page during that race.

This bug is old and has its roots in the speculative page cache patch
and adding cgroup accounting of kernel pages. There are no known user
reports. A backport to stable is therefor not warranted.

Reported-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/page_alloc.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c53fe4fa10bf..f4bd56656402 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5112,10 +5112,9 @@ static inline void free_the_page(struct page *page, unsigned int order)
  * the allocation, so it is easy to leak memory.  Freeing more memory
  * than was allocated will probably emit a warning.
  *
- * If the last reference to this page is speculative, it will be released
- * by put_page() which only frees the first page of a non-compound
- * allocation.  To prevent the remaining pages from being leaked, we free
- * the subsequent pages here.  If you want to use the page's reference
+ * This function isn't a put_page(). Don't let the put_page_testzero()
+ * fool you, it's only to deal with speculative cache references. It
+ * WILL free pages directly. If you want to use the page's reference
  * count to decide when to free the allocation, you should allocate a
  * compound page, and use put_page() instead of __free_pages().
  *
@@ -5124,11 +5123,33 @@ static inline void free_the_page(struct page *page, unsigned int order)
  */
 void __free_pages(struct page *page, unsigned int order)
 {
-	if (put_page_testzero(page))
+	/*
+	 * Drop the base reference from __alloc_pages and free. In
+	 * case there is an outstanding speculative reference, from
+	 * e.g. the page cache, it will put and free the page later.
+	 */
+	if (likely(put_page_testzero(page))) {
 		free_the_page(page, order);
-	else if (!PageHead(page))
+		return;
+	}
+
+	/*
+	 * The speculative reference will put and free the page.
+	 *
+	 * However, if the speculation was into a higher-order page
+	 * chunk that isn't marked compound, the other side will know
+	 * nothing about our buddy pages and only free the order-0
+	 * page at the start of our chunk! We must split off and free
+	 * the buddy pages here.
+	 *
+	 * The buddy pages aren't individually refcounted, so they
+	 * can't have any pending speculative references themselves.
+	 */
+	if (!PageHead(page) && order > 0) {
+		split_page_memcg(page, 1 << order);
 		while (order-- > 0)
 			free_the_page(page + (1 << order), order);
+	}
 }
 EXPORT_SYMBOL(__free_pages);
 
-- 
2.30.1

