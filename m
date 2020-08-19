Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E75C7249409
	for <lists+cgroups@lfdr.de>; Wed, 19 Aug 2020 06:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgHSE1T (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 19 Aug 2020 00:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgHSE1R (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 19 Aug 2020 00:27:17 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEFCC061389;
        Tue, 18 Aug 2020 21:27:17 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id w9so16892363qts.6;
        Tue, 18 Aug 2020 21:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=nJQwZMk0HVg1Xi5MdVbpw2haA8xPFp0DOao/4ztkzvc=;
        b=o+etTA4y6IyxOSsiGgtDeP6nsslFfCsdsqI/ytWlD0PrEUbBiCogFNkpkPYaJS2uSV
         5Jrtw6H7e8g3+b0ajpM/n1TB1IoHygoMchrjdnR0ctTVyV0u7c9ejlKYhU6tpaFAg8lf
         cxEjRIH6aarpICQ3D40Jep09AZ1RKdcrXs8Hqoqzr4SdDacFmBkgE/O0LUZAi6SWO5TI
         6GtbeZRf+u/eU7YRn+F6n6QC9lvwgq7CpKoibwq4XfQwRL7JOtdwY79HY6VrXMs2V0Lm
         faOt3XiyhX3ezawcRskNnct6vHVkrJ6FnE5Eo4JnELvFe2nfcGZXW8LJgF6OIMBWdvfL
         d8wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=nJQwZMk0HVg1Xi5MdVbpw2haA8xPFp0DOao/4ztkzvc=;
        b=SOnCi3rTL8Lkvcqm0tz4DSmC3QZgMcGqMX7vYJRTxSjPiKnTq8NAiuHHVbLvbvVvpF
         oLqpbQSm4TiaEu40c4kfGeGCed2jIw6lm8DEuhXMAVdEFxpUPHbIN1Nt/DxGtsFfZCO+
         SzBz+WGTKj1d4RCgHg1m8OgxjMdoRtDR1RIlIC7BGnGJYIc3Lf8E9D+pvtvHuEsWcZCl
         SIL4JCw3jb9AvoSL9r7FyuYkSgme3r8i/jmNBUNwsJczW6V95IUdJJKDRsLXeWodejVS
         t8B7957pU2sJBOCu63q5+jE1F3A+ZkZciICumK02juSLf2B7OnF/q/WjKzR8oRSWtBOw
         3H9w==
X-Gm-Message-State: AOAM531D8e5U22t70+2KpQ/i2XuqCGd70V/Ud6AGXh/gpUTl/kpC2RmN
        q4UOad1gPojbVcnKSrvULeY=
X-Google-Smtp-Source: ABdhPJxoECmzGuSI1+0DQ9CGQygdSLOyI+slhpLtdVXP5IOP+KyGcOaAEGCSGUdabuqBc1XlA2TaKQ==
X-Received: by 2002:aed:3e0c:: with SMTP id l12mr21600150qtf.179.1597811236964;
        Tue, 18 Aug 2020 21:27:16 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:b:9c3:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id p33sm27941856qtp.49.2020.08.18.21.27.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Aug 2020 21:27:16 -0700 (PDT)
Subject: [RFC PATCH v2 2/5] mm: Drop use of test_and_set_skip in favor of
 just setting skip
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
Date:   Tue, 18 Aug 2020 21:27:14 -0700
Message-ID: <20200819042713.23414.5084.stgit@localhost.localdomain>
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

The only user of test_and_set_skip was isolate_migratepages_block and it
was using it after a call that was testing and clearing the LRU flag. As
such it really didn't need to be behind the LRU lock anymore as it wasn't
really fulfilling its purpose.

Since it is only possible to be able to test and set the skip flag if we
were able to obtain the LRU bit for the first page in the pageblock the
use of the test_and_set_skip becomes redundant as the LRU flag now becomes
the item that limits us to only one thread being able to perform the
operation and there being no need for a test_and_set operation.

With that being the case we can simply drop the bit and instead directly
just call the set_pageblock_skip function if the page we are working on is
the valid_page at the start of the pageblock. Then any other threads that
enter this pageblock should see the skip bit set on the first valid page in
the pageblock.

Since we have dropped the late abort case we can drop the code that was
clearing the LRU flag and calling page_put since the abort case will now
not be holding a reference to a page now.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 mm/compaction.c |   53 +++++++++++++----------------------------------------
 1 file changed, 13 insertions(+), 40 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 88c7b950f676..f986c67e83cc 100644
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
-		set_pageblock_skip(page);
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
@@ -1021,11 +991,20 @@ static bool too_many_isolated(pg_data_t *pgdat)
 
 			lruvec_memcg_debug(lruvec, page);
 
-			/* Try get exclusive access under lock */
-			if (!skip_updated) {
+			/*
+			 * Indicate that we want exclusive access to the
+			 * rest of the pageblock.
+			 *
+			 * The LRU flag prevents simultaneous access to the
+			 * first PFN, and the LRU lock helps to prevent
+			 * simultaneous update of multiple pageblocks shared
+			 * in the same bitmap.
+			 */
+			if (page == valid_page) {
+				if (!cc->ignore_skip_hint &&
+				    !cc->no_set_skip_hint)
+					set_pageblock_skip(page);
 				skip_updated = true;
-				if (test_and_set_skip(cc, page, low_pfn))
-					goto isolate_abort;
 			}
 		}
 
@@ -1098,15 +1077,9 @@ static bool too_many_isolated(pg_data_t *pgdat)
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

