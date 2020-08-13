Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20232243313
	for <lists+cgroups@lfdr.de>; Thu, 13 Aug 2020 06:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgHMECp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 Aug 2020 00:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbgHMECo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 13 Aug 2020 00:02:44 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F61AC061757;
        Wed, 12 Aug 2020 21:02:44 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 62so4151657qkj.7;
        Wed, 12 Aug 2020 21:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=w5SvE1fHI6P73p4d/Ave7K8xWurioQmoju2x6tyh2NI=;
        b=c4tk2gd6nfdYlP84ldnqXqtP9SL2coSrqYEmasUe0gQZjJ9C0qFxsRqvyD5YIjTIIy
         xy++8GAuvZBRqgofWHFgrqTguHhoglS5fxYbhD3S3hvBiiusYCIulc73UJJpWoRXNx2H
         naAhGT9cveMS7FMK01PpSjGi/n3QaC/mEfygXXhEM5Ry8Cm/3wlooFXW+una3QuRDRkO
         mLIxbRvO8+xXgT5VxrkpJtiEL35TzuV2kQ8SfPbcM+nYBVtnVWPF1th3BoG4zc3dclcI
         OjI3eBp5/pnZOyMFt7I5xh0/XNv+Sgy2qAVnFDvmydFQk9kFsCcJFfQhriOYNWzDDbvG
         k18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=w5SvE1fHI6P73p4d/Ave7K8xWurioQmoju2x6tyh2NI=;
        b=YkFe31KF1tHdE1UkpdkO4LPVH4z5dGBVF0ST8Q+O4eJaDQ3GPimQ6RQO0f5ll4Q/dB
         BoTKgTsHWthw/bsAZiRz48g8CutwkhzQ/N9jKMcAJMY0YYZ4btTJXkeI6Fdsy5Wsw3/O
         /9i7svS0fcYTjAwQLUwlqd6vLx8vRPn+SuNJxfwiJMPr/RyuGnGtrwaX0TPm8MxU8660
         AAJ10dmY9jqtUN1rwPCZiQGBjtNBJXovfZI8KU0uLXVDSjhGNmGnMHaFvmWKpQRgTyRB
         Fg+9Nv+S0QN0N7fFjATN5Q9Sgg6ORqhABSTlr4QYKyOJmPmwll7d0eOlmdUuzWs3MIdg
         Bomw==
X-Gm-Message-State: AOAM532NPaTMKhw4OFrJHen+Z/90qWs3Mk0iaUR06JxSl2eUEw43SOqA
        vKavwKkBdSiQFZwlI5Pm+rA=
X-Google-Smtp-Source: ABdhPJyPijbO2JJyKyc4Hd9Lkz09TGdRjKGbofrL3sAQNVTDFk9hoq+hNTNwhwCNKnBbKpoyYYqOiQ==
X-Received: by 2002:a37:8d0:: with SMTP id 199mr2876941qki.335.1597291363538;
        Wed, 12 Aug 2020 21:02:43 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:b:9c3:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id n128sm4396126qke.8.2020.08.12.21.02.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Aug 2020 21:02:43 -0700 (PDT)
Subject: [RFC PATCH 3/3] mm: Identify compound pages sooner in
 isolate_migratepages_block
From:   Alexander Duyck <alexander.duyck@gmail.com>
To:     alex.shi@linux.alibaba.com
Cc:     yang.shi@linux.alibaba.com, lkp@intel.com, rong.a.chen@intel.com,
        khlebnikov@yandex-team.ru, kirill@shutemov.name, hughd@google.com,
        linux-kernel@vger.kernel.org, alexander.duyck@gmail.com,
        daniel.m.jordan@oracle.com, linux-mm@kvack.org,
        shakeelb@google.com, willy@infradead.org, hannes@cmpxchg.org,
        tj@kernel.org, cgroups@vger.kernel.org, akpm@linux-foundation.org,
        richard.weiyang@gmail.com, mgorman@techsingularity.net,
        iamjoonsoo.kim@lge.com
Date:   Wed, 12 Aug 2020 21:02:40 -0700
Message-ID: <20200813040240.13054.76770.stgit@localhost.localdomain>
In-Reply-To: <20200813035100.13054.25671.stgit@localhost.localdomain>
References: <20200813035100.13054.25671.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Since we are holding a reference to the page much sooner in
isolate_migratepages_block we could move the PageCompound check out of the
LRU locked section and instead just place it after get_page_unless_zero. By
doing this we can allow any of the items that might trigger a failure to
trigger a failure for the compound page rather than the order 0 page and as
a result we should be able to process the pageblock faster.

In addition by testing for PageCompound sooner we can avoid having the LRU
flag cleared and then reset in the exception case. As a result this should
prevent any possible races where another thread might be attempting to pull
the LRU pages from the list.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 mm/compaction.c |   33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index c1e9918f9dd4..3803f129fd6a 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -954,6 +954,24 @@ static bool too_many_isolated(pg_data_t *pgdat)
 		if (unlikely(!get_page_unless_zero(page)))
 			goto isolate_fail;
 
+		/*
+		 * Page is compound. We know the order before we know if it is
+		 * on the LRU so we cannot assume it is THP. However since the
+		 * page will have the LRU validated shortly we can use the value
+		 * to skip over this page for now or validate the LRU is set and
+		 * then isolate the entire compound page if we are isolating to
+		 * generate a CMA page.
+		 */
+		if (PageCompound(page)) {
+			const unsigned int order = compound_order(page);
+
+			if (likely(order < MAX_ORDER))
+				low_pfn += (1UL << order) - 1;
+
+			if (!cc->alloc_contig)
+				goto isolate_fail_put;
+		}
+
 		if (__isolate_lru_page_prepare(page, isolate_mode) != 0)
 			goto isolate_fail_put;
 
@@ -978,23 +996,8 @@ static bool too_many_isolated(pg_data_t *pgdat)
 			rcu_read_unlock();
 
 			lruvec_memcg_debug(lruvec, page);
-
-			/*
-			 * Page become compound since the non-locked check,
-			 * and it's on LRU. It can only be a THP so the order
-			 * is safe to read and it's 0 for tail pages.
-			 */
-			if (unlikely(PageCompound(page) && !cc->alloc_contig)) {
-				low_pfn += compound_nr(page) - 1;
-				SetPageLRU(page);
-				goto isolate_fail_put;
-			}
 		}
 
-		/* The whole page is taken off the LRU; skip the tail pages. */
-		if (PageCompound(page))
-			low_pfn += compound_nr(page) - 1;
-
 		/* Successfully isolated */
 		del_page_from_lru_list(page, lruvec, page_lru(page));
 		mod_node_page_state(page_pgdat(page),

