Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF71C296192
	for <lists+cgroups@lfdr.de>; Thu, 22 Oct 2020 17:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2901363AbgJVPU3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Oct 2020 11:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2509976AbgJVPU0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 22 Oct 2020 11:20:26 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB71DC0613CE
        for <cgroups@vger.kernel.org>; Thu, 22 Oct 2020 08:20:24 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id b69so1774308qkg.8
        for <cgroups@vger.kernel.org>; Thu, 22 Oct 2020 08:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zBBH901rQGlVlFoCnkqyIlpkXIRSFljWv35x5+cQPf8=;
        b=K/nRNa8p7sw9/iAQNZ79hyIJivwYVZRf9LPGMBQJkU3so+Aa7InLCzFOogauJpEnUP
         THh4W4D8SUTdDnI5IyBtA0yfxnQ0kuRyqfRhiq2J97w7M2MWvUUioMHQwgfJX4QOgXQk
         SfSOCGVauKWRDy5nuCZHUE4cCfiDJBcAHQC5pu7tKkWKoFq14twvjIZnpRK2qCSBxlfa
         TwFORMEq4o4rW1W89fq/xydP/6xWg7usvTaAPeykPNGDW1gC5h0ryJ5ZmwEhKHIoXxNJ
         SjW0v0m2NniwZpyuWU0FABhxibu13QkVx8a8rntRLjU1CbQZG5U5UMQF9lMvpsQ1vLmB
         EExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zBBH901rQGlVlFoCnkqyIlpkXIRSFljWv35x5+cQPf8=;
        b=pSk+IZO/PH7L1F3xY0IsEiRNRTEaW1z9waF+vym5ibsm7lulnOTsYNcH61Pqv2YfRz
         rlQyYLtB18oHD3fpBtDP+lRUr570mU72d4wwPXTjP/B1kwGvrRlEDV9s7hRf2OOO3cZa
         EbUgOfVYSTFdl30uFNEv2ATHFISqt7adN2AD3l5H2fP+dwx7O632Ptb2lKbc/uyxH741
         w8lkRGwhlSlsL/3RP5c3P0rAG31CkjNfyw+XGXL1MKurTGyNq67bcUmaZfmBKNWmtFi1
         IHiT2lnMDcAOmGY4Ndb2P/IM1N3Jh5Fc514JqVswIROrWnVPcyvjoMTS5lTAX4/QsW5O
         SYWg==
X-Gm-Message-State: AOAM531lFFAMxW3sy4Fv6mJn55HoETINHEzFB3WOBQ9FeLIQmYLXqBU2
        nqdl3m7SpAYwtjfS4c23ncqgRA==
X-Google-Smtp-Source: ABdhPJxlIHTHGOHGzLPZANXxHyN9jvKBN1ZfwQSQac4ihaDF7kJXLbxeD8vSdBsG3o5AQUe4eSgmOQ==
X-Received: by 2002:a37:664f:: with SMTP id a76mr3041550qkc.370.1603380023909;
        Thu, 22 Oct 2020 08:20:23 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:c400])
        by smtp.gmail.com with ESMTPSA id 11sm1163614qkc.91.2020.10.22.08.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 08:20:22 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH] mm: memcontrol: add file_thp, shmem_thp to memory.stat
Date:   Thu, 22 Oct 2020 11:18:44 -0400
Message-Id: <20201022151844.489337-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

As huge page usage in the page cache and for shmem files proliferates
in our production environment, the performance monitoring team has
asked for per-cgroup stats on those pages.

We already track and export anon_thp per cgroup. We already track file
THP and shmem THP per node, so making them per-cgroup is only a matter
of switching from node to lruvec counters. All callsites are in places
where the pages are charged and locked, so page->memcg is stable.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/filemap.c     | 4 ++--
 mm/huge_memory.c | 4 ++--
 mm/khugepaged.c  | 4 ++--
 mm/memcontrol.c  | 6 +++++-
 mm/shmem.c       | 2 +-
 5 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index e80aa9d2db68..334ce608735c 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -204,9 +204,9 @@ static void unaccount_page_cache_page(struct address_space *mapping,
 	if (PageSwapBacked(page)) {
 		__mod_lruvec_page_state(page, NR_SHMEM, -nr);
 		if (PageTransHuge(page))
-			__dec_node_page_state(page, NR_SHMEM_THPS);
+			__dec_lruvec_page_state(page, NR_SHMEM_THPS);
 	} else if (PageTransHuge(page)) {
-		__dec_node_page_state(page, NR_FILE_THPS);
+		__dec_lruvec_page_state(page, NR_FILE_THPS);
 		filemap_nr_thps_dec(mapping);
 	}
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index cba3812a5c3e..5fe044e5dad5 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2707,9 +2707,9 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 		spin_unlock(&ds_queue->split_queue_lock);
 		if (mapping) {
 			if (PageSwapBacked(head))
-				__dec_node_page_state(head, NR_SHMEM_THPS);
+				__dec_lruvec_page_state(head, NR_SHMEM_THPS);
 			else
-				__dec_node_page_state(head, NR_FILE_THPS);
+				__dec_lruvec_page_state(head, NR_FILE_THPS);
 		}
 
 		__split_huge_page(page, list, end, flags);
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index f1d5f6dde47c..04828e21f434 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1833,9 +1833,9 @@ static void collapse_file(struct mm_struct *mm,
 	}
 
 	if (is_shmem)
-		__inc_node_page_state(new_page, NR_SHMEM_THPS);
+		__inc_lruvec_page_state(new_page, NR_SHMEM_THPS);
 	else {
-		__inc_node_page_state(new_page, NR_FILE_THPS);
+		__inc_lruvec_page_state(new_page, NR_FILE_THPS);
 		filemap_nr_thps_inc(mapping);
 	}
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2636f8bad908..98177d5e8e03 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1507,6 +1507,8 @@ static struct memory_stat memory_stats[] = {
 	 * constant(e.g. powerpc).
 	 */
 	{ "anon_thp", 0, NR_ANON_THPS },
+	{ "file_thp", 0, NR_FILE_THPS },
+	{ "shmem_thp", 0, NR_SHMEM_THPS },
 #endif
 	{ "inactive_anon", PAGE_SIZE, NR_INACTIVE_ANON },
 	{ "active_anon", PAGE_SIZE, NR_ACTIVE_ANON },
@@ -1537,7 +1539,9 @@ static int __init memory_stats_init(void)
 
 	for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-		if (memory_stats[i].idx == NR_ANON_THPS)
+		if (memory_stats[i].idx == NR_ANON_THPS ||
+		    memory_stats[i].idx == NR_FILE_THPS ||
+		    memory_stats[i].idx == NR_SHMEM_THPS)
 			memory_stats[i].ratio = HPAGE_PMD_SIZE;
 #endif
 		VM_BUG_ON(!memory_stats[i].ratio);
diff --git a/mm/shmem.c b/mm/shmem.c
index 537c137698f8..5009d783d954 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -713,7 +713,7 @@ static int shmem_add_to_page_cache(struct page *page,
 		}
 		if (PageTransHuge(page)) {
 			count_vm_event(THP_FILE_ALLOC);
-			__inc_node_page_state(page, NR_SHMEM_THPS);
+			__inc_lruvec_page_state(page, NR_SHMEM_THPS);
 		}
 		mapping->nrpages += nr;
 		__mod_lruvec_page_state(page, NR_FILE_PAGES, nr);
-- 
2.29.0

