Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7A063688A
	for <lists+cgroups@lfdr.de>; Wed, 23 Nov 2022 19:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239431AbiKWSSo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Nov 2022 13:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239411AbiKWSSO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 23 Nov 2022 13:18:14 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2524414089
        for <cgroups@vger.kernel.org>; Wed, 23 Nov 2022 10:18:13 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id d18so9159454qvs.6
        for <cgroups@vger.kernel.org>; Wed, 23 Nov 2022 10:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LByvlpCL+LRhavRIegrpdrd5Lc2V7kp80WStpkpve1I=;
        b=cCBLtfi5K4sU5yrNo1RImOt+Dj8joY80jakzA+6USTvY467lH6tomTnQmnyul5qx3B
         dreZImpWfOi6dCDe6L46g1ybagMMyOeu+/yInkp04GIfiyCLZRL8mf0+LzZfJMf2jolk
         FJHdEJBOKctYHolC1/b26ialFQwRJGC177w2fMw6t/H7/BXbnBqvy7XKvo4cmtt2ibv4
         d+2IAyVQ/t9IxQAqfNr2Z+rxZ+hfPj69QX8vnS93R52rsFvX//2LwqjGu1zcfwF/A73Q
         pae3opRy+jrtwYhDv7S3iarQpyjSM5kUBe2Mr6Y+G9cCpTdTAv+x0r+jJSnBsXk3rZxZ
         HxOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LByvlpCL+LRhavRIegrpdrd5Lc2V7kp80WStpkpve1I=;
        b=iLFN5JDmAvcF4rkiRef2xoZ9lm/SCLgVcmrE49iIkgmVjbqZYj5+sovQe816K0ReZm
         zgBsdDjY1cv3cCUAfFAVu8FlDB5638WnkGg73ImjSutL1efNWED+kve7p8wju70meC6+
         UfUN9gHQPTD+BrTElC2ErmEjhDfQxF5/p8W0G9lso7SyvJNNZz/RtMCDzLjVjbaXTxZS
         hI3oHpWt/ryXhBTZaV1ZM+H9t2mBZxQ+A2H42Ovr/cuhkCMy5HldrhSz1sSl4GspMRv3
         /YV7mrrrCCWsGN6s+rb52F2ws6D8Qbh5up6eHupfrQJ2pdZCJilLWzWRXkFprSuboKxR
         cnXA==
X-Gm-Message-State: ANoB5pldvpPsJP3+k/It0nOeFYTe2KJE0znxXzRI02c4F3vGzNCtjIF5
        gLc9iXVS0XsYXZjZoapjxALuBsnKfVncGA==
X-Google-Smtp-Source: AA0mqf6euLVRQD6uWEiFOFFxCWVfrFfGyAoT44QChDA6t+nqbhvSbPtvgRHWym3ku5j6LUmaz6CySA==
X-Received: by 2002:ad4:448f:0:b0:4c6:c62f:fbe5 with SMTP id m15-20020ad4448f000000b004c6c62ffbe5mr4408701qvt.105.1669227492209;
        Wed, 23 Nov 2022 10:18:12 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:bc4])
        by smtp.gmail.com with ESMTPSA id a11-20020ac8108b000000b0035d08c1da35sm10021966qtj.45.2022.11.23.10.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 10:18:11 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm: remove lock_page_memcg() from rmap
Date:   Wed, 23 Nov 2022 13:18:38 -0500
Message-Id: <20221123181838.1373440-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

rmap changes (mapping and unmapping) of a page currently take
lock_page_memcg() to serialize 1) update of the mapcount and the
cgroup mapped counter with 2) cgroup moving the page and updating the
old cgroup and the new cgroup counters based on page_mapped().

Before b2052564e66d ("mm: memcontrol: continue cache reclaim from
offlined groups"), we used to reassign all pages that could be found
on a cgroup's LRU list on deletion - something that rmap didn't
naturally serialize against. Since that commit, however, the only
pages that get moved are those mapped into page tables of a task
that's being migrated. In that case, the pte lock is always held (and
we know the page is mapped), which keeps rmap changes at bay already.

The additional lock_page_memcg() by rmap is redundant. Remove it.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 35 ++++++++++++++++++++---------------
 mm/rmap.c       | 12 ------------
 2 files changed, 20 insertions(+), 27 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 23750cec0036..52b86ca7a78e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5676,7 +5676,10 @@ static struct page *mc_handle_file_pte(struct vm_area_struct *vma,
  * @from: mem_cgroup which the page is moved from.
  * @to:	mem_cgroup which the page is moved to. @from != @to.
  *
- * The caller must make sure the page is not on LRU (isolate_page() is useful.)
+ * This function acquires folio_lock() and folio_lock_memcg(). The
+ * caller must exclude all other possible ways of accessing
+ * page->memcg, such as LRU isolation (to lock out isolation) and
+ * having the page mapped and pte-locked (to lock out rmap).
  *
  * This function doesn't do "charge" to new cgroup and doesn't do "uncharge"
  * from old cgroup.
@@ -5696,6 +5699,13 @@ static int mem_cgroup_move_account(struct page *page,
 	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
 	VM_BUG_ON(compound && !folio_test_large(folio));
 
+	/*
+	 * We're only moving pages mapped into the moving process's
+	 * page tables. The caller's pte lock prevents rmap from
+	 * removing the NR_x_MAPPED state while we transfer it.
+	 */
+	VM_WARN_ON_ONCE(!folio_mapped(folio));
+
 	/*
 	 * Prevent mem_cgroup_migrate() from looking at
 	 * page's memory cgroup of its source page while we change it.
@@ -5715,30 +5725,25 @@ static int mem_cgroup_move_account(struct page *page,
 	folio_memcg_lock(folio);
 
 	if (folio_test_anon(folio)) {
-		if (folio_mapped(folio)) {
-			__mod_lruvec_state(from_vec, NR_ANON_MAPPED, -nr_pages);
-			__mod_lruvec_state(to_vec, NR_ANON_MAPPED, nr_pages);
-			if (folio_test_transhuge(folio)) {
-				__mod_lruvec_state(from_vec, NR_ANON_THPS,
-						   -nr_pages);
-				__mod_lruvec_state(to_vec, NR_ANON_THPS,
-						   nr_pages);
-			}
+		__mod_lruvec_state(from_vec, NR_ANON_MAPPED, -nr_pages);
+		__mod_lruvec_state(to_vec, NR_ANON_MAPPED, nr_pages);
+
+		if (folio_test_transhuge(folio)) {
+			__mod_lruvec_state(from_vec, NR_ANON_THPS, -nr_pages);
+			__mod_lruvec_state(to_vec, NR_ANON_THPS, nr_pages);
 		}
 	} else {
 		__mod_lruvec_state(from_vec, NR_FILE_PAGES, -nr_pages);
 		__mod_lruvec_state(to_vec, NR_FILE_PAGES, nr_pages);
 
+		__mod_lruvec_state(from_vec, NR_FILE_MAPPED, -nr_pages);
+		__mod_lruvec_state(to_vec, NR_FILE_MAPPED, nr_pages);
+
 		if (folio_test_swapbacked(folio)) {
 			__mod_lruvec_state(from_vec, NR_SHMEM, -nr_pages);
 			__mod_lruvec_state(to_vec, NR_SHMEM, nr_pages);
 		}
 
-		if (folio_mapped(folio)) {
-			__mod_lruvec_state(from_vec, NR_FILE_MAPPED, -nr_pages);
-			__mod_lruvec_state(to_vec, NR_FILE_MAPPED, nr_pages);
-		}
-
 		if (folio_test_dirty(folio)) {
 			struct address_space *mapping = folio_mapping(folio);
 
diff --git a/mm/rmap.c b/mm/rmap.c
index 459dc1c44d8a..11a4894158db 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1222,9 +1222,6 @@ void page_add_anon_rmap(struct page *page,
 	bool compound = flags & RMAP_COMPOUND;
 	bool first = true;
 
-	if (unlikely(PageKsm(page)))
-		lock_page_memcg(page);
-
 	/* Is page being mapped by PTE? Is this its first map to be added? */
 	if (likely(!compound)) {
 		first = atomic_inc_and_test(&page->_mapcount);
@@ -1254,9 +1251,6 @@ void page_add_anon_rmap(struct page *page,
 	if (nr)
 		__mod_lruvec_page_state(page, NR_ANON_MAPPED, nr);
 
-	if (unlikely(PageKsm(page)))
-		unlock_page_memcg(page);
-
 	/* address might be in next vma when migration races vma_adjust */
 	else if (first)
 		__page_set_anon_rmap(page, vma, address,
@@ -1321,7 +1315,6 @@ void page_add_file_rmap(struct page *page,
 	bool first;
 
 	VM_BUG_ON_PAGE(compound && !PageTransHuge(page), page);
-	lock_page_memcg(page);
 
 	/* Is page being mapped by PTE? Is this its first map to be added? */
 	if (likely(!compound)) {
@@ -1349,7 +1342,6 @@ void page_add_file_rmap(struct page *page,
 			NR_SHMEM_PMDMAPPED : NR_FILE_PMDMAPPED, nr_pmdmapped);
 	if (nr)
 		__mod_lruvec_page_state(page, NR_FILE_MAPPED, nr);
-	unlock_page_memcg(page);
 
 	mlock_vma_page(page, vma, compound);
 }
@@ -1378,8 +1370,6 @@ void page_remove_rmap(struct page *page,
 		return;
 	}
 
-	lock_page_memcg(page);
-
 	/* Is page being unmapped by PTE? Is this its last map to be removed? */
 	if (likely(!compound)) {
 		last = atomic_add_negative(-1, &page->_mapcount);
@@ -1427,8 +1417,6 @@ void page_remove_rmap(struct page *page,
 	 * and remember that it's only reliable while mapped.
 	 */
 
-	unlock_page_memcg(page);
-
 	munlock_vma_page(page, vma, compound);
 }
 
-- 
2.38.1

