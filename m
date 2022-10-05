Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A015F592A
	for <lists+cgroups@lfdr.de>; Wed,  5 Oct 2022 19:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiJERhS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Oct 2022 13:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiJERhR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 Oct 2022 13:37:17 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E29753BE
        for <cgroups@vger.kernel.org>; Wed,  5 Oct 2022 10:37:16 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id mp3-20020a17090b190300b0020af8232049so526298pjb.9
        for <cgroups@vger.kernel.org>; Wed, 05 Oct 2022 10:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=rlW8penUCTiIbLOsfrslJ/J/g+TenjXX9VkYuhroyUE=;
        b=cre+57nEzmahI/Jg40WpCpvVTDra/Np6hwgfHPiHb9kvUAEW6v66vCHfRJHy69FvkT
         kSZx/SqkG8Qpv8Hq2If8J6iuXxv/mc6j5C8Yoglkw1Ei7M4l2S0YQIltO+5M1vw3CkOc
         6nlZ2fg7N4ebt+lgDXLPSBDhdUmChoewoKY66ezVqioZk/qfXiRg5Y2WgDulfrBlU7/2
         27z2NsHcZ6oyTLUaEXcRfL5qfW8C7g0sATkpk9bURP0kN49QvJMqwD9Ym3G/rL+iUGpW
         Le2W9Wf5i7EgN5mTB26OTqxUSYbfvjf6BpxPtRd14y0xdfXzkV3xQ1GOiOYTmEPwy0In
         6Qaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=rlW8penUCTiIbLOsfrslJ/J/g+TenjXX9VkYuhroyUE=;
        b=N/VADoxfo1heocud6UeRjrR5VHpNEUyvks9Zb2XxckBGwFx+lQIMDgnWDtXjK1yaIK
         4iIPAr/+ru4AWQNeb9KALfTgu1h1g6HEHUqq/sw92imhzMcUY8DzTWEP4BCZYUrDGRES
         Gj5K2p/BRBYFkfsnGkInT+Lmslc5zw5o9JKxwNgq5XGGdEregKh2BN5UE0yCLGPD//Z6
         qnuSVdXz8CWH0ORQPbL+jHscrXez6Qe/FGd8Mr9tAXvfKrjTeTKiPRWpKU96/zqUFB/y
         yf/ojANKbNmO3OiOfIsGFEYUKqtGVZR4j1Q9c0rwp5i35ZXfdk/+mUiFPJbNxtl1c1jo
         i7fg==
X-Gm-Message-State: ACrzQf2hwY0T8IC68tlzyLj/ZGoPqIWqxjBqDXAnLZrJEdzpcQI3ykgy
        aGS/VmM5twZZRVB2updcT4+WN0I5MC+QjPUe
X-Google-Smtp-Source: AMsMyM4O1bI7xHUu+DyS7ikNiTdgZOK+8YGSqLRq/aLCcEuTBve3ylHNTvqqAAIgShF3oCOy/2xW86pG+uk7n7nQ
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:902:f707:b0:17f:8541:c04b with SMTP
 id h7-20020a170902f70700b0017f8541c04bmr484894plo.98.1664991435828; Wed, 05
 Oct 2022 10:37:15 -0700 (PDT)
Date:   Wed,  5 Oct 2022 17:37:13 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221005173713.1308832-1-yosryahmed@google.com>
Subject: [PATCH v2] mm/vmscan: check references from all memcgs for swapbacked memory
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     Greg Thelen <gthelen@google.com>,
        David Rientjes <rientjes@google.com>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

During page/folio reclaim, we check if a folio is referenced using
folio_referenced() to avoid reclaiming folios that have been recently
accessed (hot memory). The rationale is that this memory is likely to be
accessed soon, and hence reclaiming it will cause a refault.

For memcg reclaim, we currently only check accesses to the folio from
processes in the subtree of the target memcg. This behavior was
originally introduced by commit bed7161a519a ("Memory controller: make
page_referenced() cgroup aware") a long time ago. Back then, refaulted
pages would get charged to the memcg of the process that was faulting them
in. It made sense to only consider accesses coming from processes in the
subtree of target_mem_cgroup. If a page was charged to memcg A but only
being accessed by a sibling memcg B, we would reclaim it if memcg A is
is the reclaim target. memcg B can then fault it back in and get charged
for it appropriately.

Today, this behavior still makes sense for file pages. However, unlike
file pages, when swapbacked pages are refaulted they are charged to the
memcg that was originally charged for them during swapping out. Which
means that if a swapbacked page is charged to memcg A but only used by
memcg B, and we reclaim it from memcg A, it would simply be faulted back
in and charged again to memcg A once memcg B accesses it. In that sense,
accesses from all memcgs matter equally when considering if a swapbacked
page/folio is a viable reclaim target.

Modify folio_referenced() to always consider accesses from all memcgs if
the folio is swapbacked.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---

v1 -> v2:
- Move the folio_test_swapbacked() check inside folio_referenced()
    (Johannes).
- Slight rephrasing of the commit log and comment to make them
  clearer.
- Renamed memcg argument to folio_referenced() to target_memcg.

---
 include/linux/rmap.h |  2 +-
 mm/rmap.c            | 35 +++++++++++++++++++++++++++--------
 2 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index ca3e4ba6c58c..8130586eb637 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -352,7 +352,7 @@ static inline int page_try_share_anon_rmap(struct page *page)
  * Called from mm/vmscan.c to handle paging out
  */
 int folio_referenced(struct folio *, int is_locked,
-			struct mem_cgroup *memcg, unsigned long *vm_flags);
+		     struct mem_cgroup *target_memcg, unsigned long *vm_flags);
 
 void try_to_migrate(struct folio *folio, enum ttu_flags flags);
 void try_to_unmap(struct folio *, enum ttu_flags flags);
diff --git a/mm/rmap.c b/mm/rmap.c
index b6743c2b8b5f..7c98d0ca7cc6 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -882,7 +882,7 @@ static bool invalid_folio_referenced_vma(struct vm_area_struct *vma, void *arg)
  * folio_referenced() - Test if the folio was referenced.
  * @folio: The folio to test.
  * @is_locked: Caller holds lock on the folio.
- * @memcg: target memory cgroup
+ * @target_memcg: target memory cgroup of reclaim.
  * @vm_flags: A combination of all the vma->vm_flags which referenced the folio.
  *
  * Quick test_and_clear_referenced for all mappings of a folio,
@@ -891,12 +891,12 @@ static bool invalid_folio_referenced_vma(struct vm_area_struct *vma, void *arg)
  * the function bailed out due to rmap lock contention.
  */
 int folio_referenced(struct folio *folio, int is_locked,
-		     struct mem_cgroup *memcg, unsigned long *vm_flags)
+		     struct mem_cgroup *target_memcg, unsigned long *vm_flags)
 {
 	int we_locked = 0;
 	struct folio_referenced_arg pra = {
 		.mapcount = folio_mapcount(folio),
-		.memcg = memcg,
+		.memcg = target_memcg,
 	};
 	struct rmap_walk_control rwc = {
 		.rmap_one = folio_referenced_one,
@@ -919,13 +919,32 @@ int folio_referenced(struct folio *folio, int is_locked,
 	}
 
 	/*
-	 * If we are reclaiming on behalf of a cgroup, skip
-	 * counting on behalf of references from different
-	 * cgroups
+	 * We check references to folios to make sure we don't reclaim hot
+	 * folios that are likely to be refaulted soon. If we are reclaiming
+	 * memory on behalf of a memcg, we may want to skip references from
+	 * processes outside the target memcg's subtree.
+	 *
+	 * For file folios, we only consider references from processes in the
+	 * subtree of the target memcg. If memcg A is under reclaim, and a
+	 * folio is charged to memcg A but only referenced by processes in
+	 * memcg B, we ignore references from memcg B and try to reclaim it.
+	 * If it is later accessed by memcg B it will be faulted back in and
+	 * charged appropriately to memcg B. For memcg A, this is cold memory
+	 * that should be reclaimed.
+	 *
+	 * On the other hand, when swapbacked folios are faulted in, they get
+	 * charged to the memcg that was originally charged for them at the time
+	 * of swapping out. This means that if a folio that is charged to
+	 * memcg A gets swapped out, it will get charged back to A when any
+	 * process in any memcg accesses it. In that sense, we need to consider
+	 * references from all memcgs when considering whether to reclaim a
+	 * swapbacked folio.
+	 *
+	 * Hence, only skip references from outside the target memcg (if any) if
+	 * the folio is not swapbacked.
 	 */
-	if (memcg) {
+	if (target_memcg && !folio_test_swapbacked(folio))
 		rwc.invalid_vma = invalid_folio_referenced_vma;
-	}
 
 	rmap_walk(folio, &rwc);
 	*vm_flags = pra.vm_flags;
-- 
2.38.0.rc1.362.ged0d419d3c-goog

