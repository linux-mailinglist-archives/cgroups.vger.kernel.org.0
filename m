Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8F4EF39DD
	for <lists+cgroups@lfdr.de>; Thu,  7 Nov 2019 21:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfKGUxo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 7 Nov 2019 15:53:44 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43037 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727422AbfKGUxn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 7 Nov 2019 15:53:43 -0500
Received: by mail-pl1-f196.google.com with SMTP id a18so2403044plm.10
        for <cgroups@vger.kernel.org>; Thu, 07 Nov 2019 12:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G54khj+7HQuZH/Bq0JBHfzkKo1enH/RDy6wMnpXDwKE=;
        b=ktj19YXkemOLXhVE9fyvNo9/PDNAyTs9lTuYy2LlTwds4Bke/X+poy8vHj99bW4/ZX
         DpQnVTJb9TjiDOjWdCYIKEDHLiSs41Sn6fGqyM6ltD8pkabo0+gjg0i0rn+nQWoI190w
         9DFzMR+Z1xlOaRPYdPsdV9uwf1x3kssfFUfXwKSTAt+T3UvrcEL5iToIIZwOiAKKsQBA
         kWxZsF+iLsYpyYoZau/0phrKshmn7RAbZn0F+1E8uguiH3U9rcslq708PPW23BAUkx6V
         CfnctVfY+Pkq7JBPGqyVjHAsR8jB2IfRVrrw7HM1poFGFL+IZH2oHuneGXtRSBUzt64C
         jk/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G54khj+7HQuZH/Bq0JBHfzkKo1enH/RDy6wMnpXDwKE=;
        b=h9Fv4ZeQQLI5QUbV7Ugq/mcUe3PNAd4FT3kHApd+ijlfJvDRxVo7xNxfgLyhFHccVW
         qGy59IlnfTgOt+By98aDJp03QBZ78E3XNEa7EzWcImOEO/DSpopPGhYKNmseoWlkAG0o
         sO1aCxBiEywaWaZkkbGmhza1E7awlY6oKIC591UDbT6NmX4nveAzTKhDVulC/8x/dgKy
         ClFddovpI9Jcp2KD+87lVRY4PA+SRjgugsZHVxkuR/HhBeWNyEMoJF0KmXYD6WfwCLRc
         KGLL2JrzvPQkCE+127VXjG85OwO7kRdNbART6Ik3xlKwAGx6Ud452vCsd777/nlLUc8V
         CyBg==
X-Gm-Message-State: APjAAAWUsapP3rDDHdEYAyA2F8CyctxhacBYKZyJuarn5zWkVpyfpMNH
        U9g27vQilbUEqcu+/U98Awvy7Q==
X-Google-Smtp-Source: APXvYqwdLjf1+kn7vwiSpz8qvaWkXbMANUTKufMZCkcDVr9KF9XpEvJKpTU6lM7ab2SdGfsdW/H6MA==
X-Received: by 2002:a17:902:ff06:: with SMTP id f6mr5918280plj.65.1573160022383;
        Thu, 07 Nov 2019 12:53:42 -0800 (PST)
Received: from localhost ([2620:10d:c090:200::3:3792])
        by smtp.gmail.com with ESMTPSA id s18sm3405408pfs.20.2019.11.07.12.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 12:53:41 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Rik van Riel <riel@surriel.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 2/3] mm: vmscan: detect file thrashing at the reclaim root
Date:   Thu,  7 Nov 2019 12:53:33 -0800
Message-Id: <20191107205334.158354-3-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191107205334.158354-1-hannes@cmpxchg.org>
References: <20191107205334.158354-1-hannes@cmpxchg.org>
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
index 5b86287fa069..a7a0a1a5c8d5 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -901,6 +901,11 @@ static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page,
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
index 063c0c1e112b..1e99f7ac1d7e 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -307,7 +307,7 @@ struct vma_swap_readahead {
 };
 
 /* linux/mm/workingset.c */
-void *workingset_eviction(struct page *page);
+void *workingset_eviction(struct page *page, struct mem_cgroup *target_memcg);
 void workingset_refault(struct page *page, void *shadow);
 void workingset_activation(struct page *page);
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index e8dd601e1fad..527617ee9b73 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -853,7 +853,7 @@ static pageout_t pageout(struct page *page, struct address_space *mapping)
  * gets returned with a refcount of 0.
  */
 static int __remove_mapping(struct address_space *mapping, struct page *page,
-			    bool reclaimed)
+			    bool reclaimed, struct mem_cgroup *target_memcg)
 {
 	unsigned long flags;
 	int refcount;
@@ -925,7 +925,7 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
 		 */
 		if (reclaimed && page_is_file_cache(page) &&
 		    !mapping_exiting(mapping) && !dax_mapping(mapping))
-			shadow = workingset_eviction(page);
+			shadow = workingset_eviction(page, target_memcg);
 		__delete_from_page_cache(page, shadow);
 		xa_unlock_irqrestore(&mapping->i_pages, flags);
 
@@ -948,7 +948,7 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
  */
 int remove_mapping(struct address_space *mapping, struct page *page)
 {
-	if (__remove_mapping(mapping, page, false)) {
+	if (__remove_mapping(mapping, page, false, NULL)) {
 		/*
 		 * Unfreezing the refcount with 1 rather than 2 effectively
 		 * drops the pagecache ref for us without requiring another
@@ -1426,7 +1426,8 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 
 			count_vm_event(PGLAZYFREED);
 			count_memcg_page_event(page, PGLAZYFREED);
-		} else if (!mapping || !__remove_mapping(mapping, page, true))
+		} else if (!mapping || !__remove_mapping(mapping, page, true,
+							 sc->target_mem_cgroup))
 			goto keep_locked;
 
 		unlock_page(page);
@@ -2189,6 +2190,7 @@ static bool inactive_list_is_low(struct lruvec *lruvec, bool file,
 	enum lru_list inactive_lru = file * LRU_FILE;
 	unsigned long inactive, active;
 	unsigned long inactive_ratio;
+	struct lruvec *target_lruvec;
 	unsigned long refaults;
 	unsigned long gb;
 
@@ -2200,8 +2202,9 @@ static bool inactive_list_is_low(struct lruvec *lruvec, bool file,
 	 * is being established. Disable active list protection to get
 	 * rid of the stale workingset quickly.
 	 */
-	refaults = lruvec_page_state_local(lruvec, WORKINGSET_ACTIVATE);
-	if (file && lruvec->refaults != refaults) {
+	target_lruvec = mem_cgroup_lruvec(sc->target_mem_cgroup, pgdat);
+	refaults = lruvec_page_state(target_lruvec, WORKINGSET_ACTIVATE);
+	if (file && target_lruvec->refaults != refaults) {
 		inactive_ratio = 0;
 	} else {
 		gb = (inactive + active) >> (30 - PAGE_SHIFT);
@@ -2973,19 +2976,14 @@ static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
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
index e8212123c1c3..f0885d9f41cd 100644
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
+void *workingset_eviction(struct page *page, struct mem_cgroup *target_memcg)
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
+	lruvec = mem_cgroup_lruvec(target_memcg, pgdat);
+	/* XXX: target_memcg can be NULL, go through lruvec */
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
2.24.0

