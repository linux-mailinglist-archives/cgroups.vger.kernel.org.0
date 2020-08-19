Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 096B2249407
	for <lists+cgroups@lfdr.de>; Wed, 19 Aug 2020 06:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725601AbgHSE1K (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 19 Aug 2020 00:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgHSE1J (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 19 Aug 2020 00:27:09 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99611C061389;
        Tue, 18 Aug 2020 21:27:09 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id y11so10697129qvl.4;
        Tue, 18 Aug 2020 21:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=O0GPbeNx4pE5Cj/la6lYT0zllz6aGU2XNC8iLf9uFA4=;
        b=pO3zqnqL4c/mDAjAfh4ZWDwEb7d57VhBDoidBgKwr3U5coFnxDOXwnl2WrCcEy2ytc
         vPoW0tq9uKas+aNj5L2ZSate75S8hark40KC/B1fHTbUYPsjwNaa6uOzkoMyUQDpmlBL
         dOt7/SWEQPgLq23TAemQobbfIE2Jpi9Y99z4Ne9S+gMTKMvQKs3YapyvSlEmI2di09pJ
         dHjRXJ2gP38hCNvvOZk4UqKmcWaQRFnTLqeFlhyGet0x8XXRiPSc12oSao2IOrQonhDN
         0qNWU11jMey8c9BEr8FQP9SCHMrSyMK8EtIwBEOpavLMBYW6DnNK/t44D+cr7nXdgrJv
         7tUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=O0GPbeNx4pE5Cj/la6lYT0zllz6aGU2XNC8iLf9uFA4=;
        b=oWeWRm9toyhdN8jQY3Dqbp8C91z9G+Cbd7gd808aKLOXKiT1Ix5KwFgqvbMoRDFcOt
         AJh8hlmF6cRlFEfjibTqebo5wry3JKMy7vpXaQguU70iqpxb9/Vm239SOALHlUPlgDM1
         Lew5PIlSNCTRWOqzDPmRc5KcOV6Mw+KKFjr35uXZOwsqGIJzMGw/Fy2vZjvq//klD5ko
         GLCa3jqUcf376BcBg7JVNKH/0ERst1ek23FHim9M27mli2uUeQDAacST2iX5ongTs7lS
         KAqGNAbgSgPzXYHvh9oCmC+5klAtjdruUoI3R1/MNRFAGFUHqhWg2xC7Z6t07mCcOG2G
         IDFg==
X-Gm-Message-State: AOAM533x46pScNJc9xMZAa5P0t9Jc/FmS9mya7v4ijvh4Qzn2FzZo3D4
        tyIVtJahNVRAu6p90bPnm8WLKjxohmWaFg==
X-Google-Smtp-Source: ABdhPJxW+1uPbr69HlT8zdk5DCZHvushfLGH5Z8cxaaxbXoq04RhdHu82fDyOZeUTBoieLU6jFhc1g==
X-Received: by 2002:ad4:4b0b:: with SMTP id r11mr22115044qvw.94.1597811228761;
        Tue, 18 Aug 2020 21:27:08 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:b:9c3:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id p17sm21999894qkj.69.2020.08.18.21.27.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Aug 2020 21:27:08 -0700 (PDT)
Subject: [RFC PATCH v2 1/5] mm: Identify compound pages sooner in
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
Date:   Tue, 18 Aug 2020 21:27:05 -0700
Message-ID: <20200819042705.23414.84098.stgit@localhost.localdomain>
In-Reply-To: <20200819041852.23414.95939.stgit@localhost.localdomain>
References: <20200819041852.23414.95939.stgit@localhost.localdomain>
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
isolate_migratepages_block we can move the PageCompound check out of the
LRU locked section and instead just place it after get_page_unless_zero. By
doing this we can allow any of the items that might trigger a failure to
trigger a failure for the compound page rather than the order 0 page and as
a result we should be able to process the pageblock faster.

In addition by testing for PageCompound sooner we can avoid having the LRU
flag cleared and then reset in the exception case. As a result this should
prevent possible races where another thread might be attempting to pull the
LRU pages from the list.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 mm/compaction.c |   33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index d3f87f759773..88c7b950f676 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -984,6 +984,24 @@ static bool too_many_isolated(pg_data_t *pgdat)
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
 
@@ -1009,23 +1027,8 @@ static bool too_many_isolated(pg_data_t *pgdat)
 				if (test_and_set_skip(cc, page, low_pfn))
 					goto isolate_abort;
 			}
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

