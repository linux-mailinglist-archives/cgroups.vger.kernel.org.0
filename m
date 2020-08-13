Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABB06243311
	for <lists+cgroups@lfdr.de>; Thu, 13 Aug 2020 06:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgHMECg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 Aug 2020 00:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbgHMECg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 13 Aug 2020 00:02:36 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EE7C061757;
        Wed, 12 Aug 2020 21:02:36 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id g26so4175495qka.3;
        Wed, 12 Aug 2020 21:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=g1Efyw0jo1iBHDaFGnCxXDBpkzz2KS4HPptzP2dpWOE=;
        b=SASn4JQnilStqGrDLOtz2BFduofMDuiSagfrx9tnHZ71TnmRd67ZdWrSRGdfw9IAGq
         m9yIwMMEh0ZnxBlWWdbePMh6dEcgXTiWIPxC6fGrDTGYo7BGwbIWQwzY9Jhaq1h4RGIO
         0Arw+y0bGAEeM1aYyHrS3Z9BHtyk9Pr+2pPT2rEJCnIlPqpxaCX+EcEyt7FFs1Zxo3Xo
         fy/zMPyLB9PA4P+zHE4VNKdiRgum8g6zhIjBRU+lJwJ8BAiAlg75lMljBWqa4qUbT9l4
         1TyLlqB6Kq8Gfn4JyGDzb0CJ/iU7Cu1i1QISLdmN/pZIL9Mz33xB9MB15pN+tZnGiLAO
         RQNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=g1Efyw0jo1iBHDaFGnCxXDBpkzz2KS4HPptzP2dpWOE=;
        b=NoD8BhA8Q/bhtozpjDAXr0bPTWU0+jfwUOR/IdSDOgVbrJFPd1PWH+33G+pgsALOUC
         0gKOyrHkn+mzfcUNqCgEnvqD8pKHbzB+avZs5oRboiUs0uBKi4Sbys1Oy3OAQ0GJXMD5
         sxPlTR1eXuAH1pYQKBSDQsY/ywS01sjT7s2mS47DkhsKeUIlWmRp9PLkFgmOXaS8i1JN
         rtq/2iWBLf0PuTK+ZPwMyfmZNGJZcYFmygNJf3cTjKUgnNbkJvVAD64lGTVdM+QvWtdH
         WojhAJ2RcwI2WwCEdnMXKIvvwKdlGzhtYIrEtv5Gie2j4Ldf8BDLTmpvv+UmwkFUNVcS
         rdrQ==
X-Gm-Message-State: AOAM531FTkMTQ1stcBtf23aegGurnA0Xhcsy8XyHrHx0CXdUihrwhCOL
        xJBnzNGV9yjD8yCP44Y6AdY=
X-Google-Smtp-Source: ABdhPJy/12XScIZblZWf8AE4TR/BGGcbA7se3/6sHFcRW8yveFpWOs/DZ0MnaggImp0MSomoB06k7g==
X-Received: by 2002:a05:620a:13c4:: with SMTP id g4mr3081984qkl.142.1597291355359;
        Wed, 12 Aug 2020 21:02:35 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:b:9c3:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id u39sm5526609qtc.54.2020.08.12.21.02.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Aug 2020 21:02:34 -0700 (PDT)
Subject: [RFC PATCH 2/3] mm: Drop use of test_and_set_skip in favor of just
 setting skip
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
Date:   Wed, 12 Aug 2020 21:02:32 -0700
Message-ID: <20200813040232.13054.82417.stgit@localhost.localdomain>
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

The only user of test_and_set_skip was isolate_migratepages_block and it
was using it after a call that was testing and clearing the LRU flag. As
such it really didn't need to be behind the LRU lock anymore as it wasn't
really fulfilling its purpose.

With that being the case we can simply drop the bit and instead directly
just call the set_pageblock_skip function if the page we are working on is
the valid_page at the start of the pageblock. It shouldn't be possible for
us to encounter the bit being set since we obtained the LRU flag for the
first page in the pageblock which means we would have exclusive access to
setting the skip bit. As such we don't need to worry about the abort case
since no other thread will be able to call what used to be
test_and_set_skip.

Since we have dropped the late abort case we can drop the code that was
clearing the LRU flag and calling page_put since the abort case will now
not be holding a reference to a page.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 mm/compaction.c |   50 +++++++-------------------------------------------
 1 file changed, 7 insertions(+), 43 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 5021a18ef722..c1e9918f9dd4 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -399,29 +399,6 @@ void reset_isolation_suitable(pg_data_t *pgdat)
 	}
 }
 
-/*
- * Sets the pageblock skip bit if it was clear. Note that this is a hint as
- * locks are not required for read/writers. Returns true if it was already set.
- */
-static bool test_and_set_skip(struct compact_control *cc, struct page *page,
-							unsigned long pfn)
-{
-	bool skip;
-
-	/* Do no update if skip hint is being ignored */
-	if (cc->ignore_skip_hint)
-		return false;
-
-	if (!IS_ALIGNED(pfn, pageblock_nr_pages))
-		return false;
-
-	skip = get_pageblock_skip(page);
-	if (!skip && !cc->no_set_skip_hint)
-		skip = !set_pageblock_skip(page);
-
-	return skip;
-}
-
 static void update_cached_migrate(struct compact_control *cc, unsigned long pfn)
 {
 	struct zone *zone = cc->zone;
@@ -480,12 +457,6 @@ static inline void update_pageblock_skip(struct compact_control *cc,
 static void update_cached_migrate(struct compact_control *cc, unsigned long pfn)
 {
 }
-
-static bool test_and_set_skip(struct compact_control *cc, struct page *page,
-							unsigned long pfn)
-{
-	return false;
-}
 #endif /* CONFIG_COMPACTION */
 
 /*
@@ -895,7 +866,6 @@ static bool too_many_isolated(pg_data_t *pgdat)
 		if (!valid_page && IS_ALIGNED(low_pfn, pageblock_nr_pages)) {
 			if (!cc->ignore_skip_hint && get_pageblock_skip(page)) {
 				low_pfn = end_pfn;
-				page = NULL;
 				goto isolate_abort;
 			}
 			valid_page = page;
@@ -991,6 +961,13 @@ static bool too_many_isolated(pg_data_t *pgdat)
 		if (!TestClearPageLRU(page))
 			goto isolate_fail_put;
 
+		/* Indicate that we want exclusive access to this pageblock */
+		if (page == valid_page) {
+			skip_updated = true;
+			if (!cc->ignore_skip_hint)
+				set_pageblock_skip(page);
+		}
+
 		/* If we already hold the lock, we can skip some rechecking */
 		if (!lruvec || !lruvec_holds_page_lru_lock(page, lruvec)) {
 			if (lruvec)
@@ -1002,13 +979,6 @@ static bool too_many_isolated(pg_data_t *pgdat)
 
 			lruvec_memcg_debug(lruvec, page);
 
-			/* Try get exclusive access under lock */
-			if (!skip_updated) {
-				skip_updated = true;
-				if (test_and_set_skip(cc, page, low_pfn))
-					goto isolate_abort;
-			}
-
 			/*
 			 * Page become compound since the non-locked check,
 			 * and it's on LRU. It can only be a THP so the order
@@ -1094,15 +1064,9 @@ static bool too_many_isolated(pg_data_t *pgdat)
 	if (unlikely(low_pfn > end_pfn))
 		low_pfn = end_pfn;
 
-	page = NULL;
-
 isolate_abort:
 	if (lruvec)
 		unlock_page_lruvec_irqrestore(lruvec, flags);
-	if (page) {
-		SetPageLRU(page);
-		put_page(page);
-	}
 
 	/*
 	 * Updated the cached scanner pfn once the pageblock has been scanned

