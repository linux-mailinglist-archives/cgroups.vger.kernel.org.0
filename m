Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B63233AF3
	for <lists+cgroups@lfdr.de>; Tue,  4 Jun 2019 00:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfFCWPn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 Jun 2019 18:15:43 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43684 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfFCWPn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 3 Jun 2019 18:15:43 -0400
Received: by mail-pg1-f194.google.com with SMTP id f25so9058570pgv.10
        for <cgroups@vger.kernel.org>; Mon, 03 Jun 2019 15:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RkU+GNI+12gM0/3ezDUIhdwRxbBKO5hwfFKf3/tY+1A=;
        b=oy/P/HELxxb/EJXE/apahDsNV+eoErpsgMRA3rDtqEtlDDlbZphuEOvhKuoRrjMqEx
         46qUU/kTsBQsZvcKbHxIKwzTwvp9WV/Rlw4iq/wVvMh29zU7r3Bzk+PY5TaRifY2Kdid
         PzfFZwnKEwIFkeknv/LoIp5EIwI5/1kQmv83ryrRw5vYrNlWlEFArwKYxpko2I9RGQcV
         qGj9X132iKsMr59hbcUjFBmjb3YkYvtJh/b6wDhM3kov0KQPoQgnPNBmZ1zSoYVKC6wV
         FahT0+Qi4yXU5iUfE9lKgEBCCf322eaHmQWH1qEq/uJTCM1UkuLONmaoc7RN55tbh+Wt
         vLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RkU+GNI+12gM0/3ezDUIhdwRxbBKO5hwfFKf3/tY+1A=;
        b=qwKG16KATz8GUEfrYCvZ+GIMREURLx22wy9Eif9NF4PgZZYimue4fbFh+xJXKcMCNI
         WS2NsvoZ5CzI943e2Atj2QMdvgcNhSg3cxgj3uN1na8c4PRdNUMufrTvItGuw03F6Z1o
         elitUMsNXQbdI6ixXEDCGkFLyH/LQy/B7czWO+YdPTzy3bz+dE0efMKKN4sL/1S0BQCc
         43qj2cf7rcv6iiQDY9jkKJYpNVaL6nh+/xMFFy7y/8CWpaU2XyhlulWiwHyYyhQ5z0+S
         OMsWKMDGDl0AAydzl/JXlbajkBDs5WVdNKVpcF0ZsDlXjVgtu+KTd+wA5B2NRCFcDS6H
         OxAw==
X-Gm-Message-State: APjAAAWJuhV6JylEa87RbilYh8LVPqh6/mwONe+9sqEqiUk1Nja1F2FL
        26PrXAADw0q6xJQTh46naszBVA==
X-Google-Smtp-Source: APXvYqzvNF8OO/3aIw1yj8y8UKddwiouLy94HRA+PfYIFGFrI5SBPLc37aAR3Vqxgd2Ut2v61xQdSg==
X-Received: by 2002:a63:1919:: with SMTP id z25mr31688677pgl.440.1559596124724;
        Mon, 03 Jun 2019 14:08:44 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:9fa4])
        by smtp.gmail.com with ESMTPSA id e4sm15405027pgi.80.2019.06.03.14.08.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 14:08:44 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 10/11] mm: vmscan: detect file thrashing at the reclaim root
Date:   Mon,  3 Jun 2019 17:07:45 -0400
Message-Id: <20190603210746.15800-11-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603210746.15800-1-hannes@cmpxchg.org>
References: <20190603210746.15800-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

We use refault information to determine whether the cache workingset
is stable or transitioning, and dynamically adjust the inactive:active
file LRU ratio so as to maximize protection from one-off cache during
stable periods, and minimize IO during transitions.

With cgroups and their nested LRU lists, we currently don't do this
correctly. While recursive cgroup reclaim establishes a relative LRU
order among the pages of all involved cgroups, refaults only affect
the local LRU order in the cgroup in which they are occuring. As a
result, cache transitions can take longer in a cgrouped system as the
active pages of sibling cgroups aren't challenged when they should be.

[ Right now, this is somewhat theoretical, because the siblings, under
  continued regular reclaim pressure, should eventually run out of
  inactive pages - and since inactive:active *size* balancing is also
  done on a cgroup-local level, we will challenge the active pages
  eventually in most cases. But the next patch will move that relative
  size enforcement to the reclaim root as well, and then this patch
  here will be necessary to propagate refault pressure to siblings. ]

This patch moves refault detection to the root of reclaim. Instead of
remembering the cgroup owner of an evicted page, remember the cgroup
that caused the reclaim to happen. When refaults later occur, they'll
correctly influence the cross-cgroup LRU order that reclaim follows.

I.e. if global reclaim kicked out pages in some subgroup A/B/C, the
refault of those pages will challenge the global LRU order, and not
just the local order down inside C.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/memcontrol.h |  5 +++
 include/linux/swap.h       |  2 +-
 mm/vmscan.c                | 32 ++++++++---------
 mm/workingset.c            | 72 +++++++++++++++++++++++++++++---------
 4 files changed, 77 insertions(+), 34 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index d33e09c51acc..70dcb6ab4e68 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -899,6 +899,11 @@ static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page,
 	return &pgdat->__lruvec;
 }
 
+static inline struct mem_cgroup *parent_mem_cgroup(struct mem_cgroup *memcg)
+{
+	return NULL;
+}
+
 static inline bool mm_match_cgroup(struct mm_struct *mm,
 		struct mem_cgroup *memcg)
 {
diff --git a/include/linux/swap.h b/include/linux/swap.h
index de2c67a33b7e..c65c11158a6c 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -307,7 +307,7 @@ struct vma_swap_readahead {
 };
 
 /* linux/mm/workingset.c */
-void *workingset_eviction(struct page *page);
+void *workingset_eviction(struct mem_cgroup *target_memcg, struct page *page);
 void workingset_refault(struct page *page, void *shadow);
 void workingset_activation(struct page *page);
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index cabf94dfa92d..6b7bd5708c73 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -834,7 +834,7 @@ static pageout_t pageout(struct page *page, struct address_space *mapping,
  * gets returned with a refcount of 0.
  */
 static int __remove_mapping(struct address_space *mapping, struct page *page,
-			    bool reclaimed)
+			    bool reclaimed, struct mem_cgroup *target_memcg)
 {
 	unsigned long flags;
 	int refcount;
@@ -909,7 +909,7 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
 		 */
 		if (reclaimed && page_is_file_cache(page) &&
 		    !mapping_exiting(mapping) && !dax_mapping(mapping))
-			shadow = workingset_eviction(page);
+			shadow = workingset_eviction(target_memcg, page);
 		__delete_from_page_cache(page, shadow);
 		xa_unlock_irqrestore(&mapping->i_pages, flags);
 
@@ -932,7 +932,7 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
  */
 int remove_mapping(struct address_space *mapping, struct page *page)
 {
-	if (__remove_mapping(mapping, page, false)) {
+	if (__remove_mapping(mapping, page, false, NULL)) {
 		/*
 		 * Unfreezing the refcount with 1 rather than 2 effectively
 		 * drops the pagecache ref for us without requiring another
@@ -1410,7 +1410,8 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 
 			count_vm_event(PGLAZYFREED);
 			count_memcg_page_event(page, PGLAZYFREED);
-		} else if (!mapping || !__remove_mapping(mapping, page, true))
+		} else if (!mapping || !__remove_mapping(mapping, page, true,
+							 sc->target_mem_cgroup))
 			goto keep_locked;
 
 		unlock_page(page);
@@ -2119,6 +2120,7 @@ static bool inactive_list_is_low(struct lruvec *lruvec, bool file,
 	enum lru_list inactive_lru = file * LRU_FILE;
 	unsigned long inactive, active;
 	unsigned long inactive_ratio;
+	struct lruvec *target_lruvec;
 	unsigned long refaults;
 	unsigned long gb;
 
@@ -2130,8 +2132,9 @@ static bool inactive_list_is_low(struct lruvec *lruvec, bool file,
 	 * is being established. Disable active list protection to get
 	 * rid of the stale workingset quickly.
 	 */
-	refaults = lruvec_page_state_local(lruvec, WORKINGSET_ACTIVATE);
-	if (file && actual_reclaim && lruvec->refaults != refaults) {
+	target_lruvec = mem_cgroup_lruvec(sc->target_mem_cgroup, pgdat);
+	refaults = lruvec_page_state(target_lruvec, WORKINGSET_ACTIVATE);
+	if (file && actual_reclaim && target_lruvec->refaults != refaults) {
 		inactive_ratio = 0;
 	} else {
 		gb = (inactive + active) >> (30 - PAGE_SHIFT);
@@ -2937,19 +2940,14 @@ static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
 	sc->gfp_mask = orig_mask;
 }
 
-static void snapshot_refaults(struct mem_cgroup *root_memcg, pg_data_t *pgdat)
+static void snapshot_refaults(struct mem_cgroup *target_memcg, pg_data_t *pgdat)
 {
-	struct mem_cgroup *memcg;
-
-	memcg = mem_cgroup_iter(root_memcg, NULL, NULL);
-	do {
-		unsigned long refaults;
-		struct lruvec *lruvec;
+	struct lruvec *target_lruvec;
+	unsigned long refaults;
 
-		lruvec = mem_cgroup_lruvec(memcg, pgdat);
-		refaults = lruvec_page_state_local(lruvec, WORKINGSET_ACTIVATE);
-		lruvec->refaults = refaults;
-	} while ((memcg = mem_cgroup_iter(root_memcg, memcg, NULL)));
+	target_lruvec = mem_cgroup_lruvec(target_memcg, pgdat);
+	refaults = lruvec_page_state(target_lruvec, WORKINGSET_ACTIVATE);
+	target_lruvec->refaults = refaults;
 }
 
 /*
diff --git a/mm/workingset.c b/mm/workingset.c
index 2aaa70bea99c..2ae67a6d770c 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -213,28 +213,53 @@ static void unpack_shadow(void *shadow, int *memcgidp, pg_data_t **pgdat,
 	*workingsetp = workingset;
 }
 
+static void advance_inactive_age(struct mem_cgroup *memcg, pg_data_t *pgdat)
+{
+	/*
+	 * Reclaiming a cgroup means reclaiming all its children in a
+	 * round-robin fashion. That means that each cgroup has an LRU
+	 * order that is composed of the LRU orders of its child
+	 * cgroups; and every page has an LRU position not just in the
+	 * cgroup that owns it, but in all of that group's ancestors.
+	 *
+	 * So when the physical inactive list of a leaf cgroup ages,
+	 * the virtual inactive lists of all its parents, including
+	 * the root cgroup's, age as well.
+	 */
+	do {
+		struct lruvec *lruvec;
+
+		lruvec = mem_cgroup_lruvec(memcg, pgdat);
+		atomic_long_inc(&lruvec->inactive_age);
+	} while (memcg && (memcg = parent_mem_cgroup(memcg)));
+}
+
 /**
  * workingset_eviction - note the eviction of a page from memory
+ * @target_memcg: the cgroup that is causing the reclaim
  * @page: the page being evicted
  *
  * Returns a shadow entry to be stored in @page->mapping->i_pages in place
  * of the evicted @page so that a later refault can be detected.
  */
-void *workingset_eviction(struct page *page)
+void *workingset_eviction(struct mem_cgroup *target_memcg, struct page *page)
 {
 	struct pglist_data *pgdat = page_pgdat(page);
-	struct mem_cgroup *memcg = page_memcg(page);
-	int memcgid = mem_cgroup_id(memcg);
 	unsigned long eviction;
 	struct lruvec *lruvec;
+	int memcgid;
 
 	/* Page is fully exclusive and pins page->mem_cgroup */
 	VM_BUG_ON_PAGE(PageLRU(page), page);
 	VM_BUG_ON_PAGE(page_count(page), page);
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
 
-	lruvec = mem_cgroup_lruvec(memcg, pgdat);
-	eviction = atomic_long_inc_return(&lruvec->inactive_age);
+	advance_inactive_age(page_memcg(page), pgdat);
+
+	/* XXX: target_memcg can be NULL, go through lruvec */
+	lruvec = mem_cgroup_lruvec(target_memcg, pgdat);
+	memcgid = mem_cgroup_id(lruvec_memcg(lruvec));
+	eviction = atomic_long_read(&lruvec->inactive_age);
 	return pack_shadow(memcgid, pgdat, eviction, PageWorkingset(page));
 }
 
@@ -244,10 +269,13 @@ void *workingset_eviction(struct page *page)
  * @shadow: shadow entry of the evicted page
  *
  * Calculates and evaluates the refault distance of the previously
- * evicted page in the context of the node it was allocated in.
+ * evicted page in the context of the node and the memcg whose memory
+ * pressure caused the eviction.
  */
 void workingset_refault(struct page *page, void *shadow)
 {
+	struct mem_cgroup *eviction_memcg;
+	struct lruvec *eviction_lruvec;
 	unsigned long refault_distance;
 	struct pglist_data *pgdat;
 	unsigned long active_file;
@@ -277,12 +305,12 @@ void workingset_refault(struct page *page, void *shadow)
 	 * would be better if the root_mem_cgroup existed in all
 	 * configurations instead.
 	 */
-	memcg = mem_cgroup_from_id(memcgid);
-	if (!mem_cgroup_disabled() && !memcg)
+	eviction_memcg = mem_cgroup_from_id(memcgid);
+	if (!mem_cgroup_disabled() && !eviction_memcg)
 		goto out;
-	lruvec = mem_cgroup_lruvec(memcg, pgdat);
-	refault = atomic_long_read(&lruvec->inactive_age);
-	active_file = lruvec_lru_size(lruvec, LRU_ACTIVE_FILE, MAX_NR_ZONES);
+	eviction_lruvec = mem_cgroup_lruvec(eviction_memcg, pgdat);
+	refault = atomic_long_read(&eviction_lruvec->inactive_age);
+	active_file = lruvec_page_state(eviction_lruvec, NR_ACTIVE_FILE);
 
 	/*
 	 * Calculate the refault distance
@@ -302,6 +330,17 @@ void workingset_refault(struct page *page, void *shadow)
 	 */
 	refault_distance = (refault - eviction) & EVICTION_MASK;
 
+	/*
+	 * The activation decision for this page is made at the level
+	 * where the eviction occurred, as that is where the LRU order
+	 * during page reclaim is being determined.
+	 *
+	 * However, the cgroup that will own the page is the one that
+	 * is actually experiencing the refault event.
+	 */
+	memcg = get_mem_cgroup_from_mm(current->mm);
+	lruvec = mem_cgroup_lruvec(memcg, pgdat);
+
 	inc_lruvec_state(lruvec, WORKINGSET_REFAULT);
 
 	/*
@@ -310,10 +349,10 @@ void workingset_refault(struct page *page, void *shadow)
 	 * the memory was available to the page cache.
 	 */
 	if (refault_distance > active_file)
-		goto out;
+		goto out_memcg;
 
 	SetPageActive(page);
-	atomic_long_inc(&lruvec->inactive_age);
+	advance_inactive_age(memcg, pgdat);
 	inc_lruvec_state(lruvec, WORKINGSET_ACTIVATE);
 
 	/* Page was active prior to eviction */
@@ -321,6 +360,9 @@ void workingset_refault(struct page *page, void *shadow)
 		SetPageWorkingset(page);
 		inc_lruvec_state(lruvec, WORKINGSET_RESTORE);
 	}
+
+out_memcg:
+	mem_cgroup_put(memcg);
 out:
 	rcu_read_unlock();
 }
@@ -332,7 +374,6 @@ void workingset_refault(struct page *page, void *shadow)
 void workingset_activation(struct page *page)
 {
 	struct mem_cgroup *memcg;
-	struct lruvec *lruvec;
 
 	rcu_read_lock();
 	/*
@@ -345,8 +386,7 @@ void workingset_activation(struct page *page)
 	memcg = page_memcg_rcu(page);
 	if (!mem_cgroup_disabled() && !memcg)
 		goto out;
-	lruvec = mem_cgroup_lruvec(memcg, page_pgdat(page));
-	atomic_long_inc(&lruvec->inactive_age);
+	advance_inactive_age(memcg, page_pgdat(page));
 out:
 	rcu_read_unlock();
 }
-- 
2.21.0

