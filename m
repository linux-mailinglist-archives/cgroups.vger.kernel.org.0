Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 248D1A8772
	for <lists+cgroups@lfdr.de>; Wed,  4 Sep 2019 21:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730440AbfIDNxX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Sep 2019 09:53:23 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:58198 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730407AbfIDNxW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Sep 2019 09:53:22 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 51B542E15F8;
        Wed,  4 Sep 2019 16:53:19 +0300 (MSK)
Received: from smtpcorp1j.mail.yandex.net (smtpcorp1j.mail.yandex.net [2a02:6b8:0:1619::137])
        by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id LqBQ2fs3tf-rIBGUSHB;
        Wed, 04 Sep 2019 16:53:19 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1567605199; bh=aH0EBATL6Xdm91KGXCuuSC/Nf1lvu8cwkbbLcyujFm0=;
        h=In-Reply-To:Message-ID:References:Date:To:From:Subject:Cc;
        b=fl847K3kjZFsvf9ONh0pvu4WnPP37n+rKajQUOJ0/PjF4b3vEk3MdbPjeEmJr8J66
         KH1pfejCfcbFVablXxrm59tJ7JJDWv3UVqKdOqcXd8uTnFHj7C/vtv5xmIxci1o6vF
         i1Rr9GHG+KHBPr/DwVSsMnVS4Pug6xmm41CqF96g=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:c142:79c2:9d86:677a])
        by smtpcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id Xi3vFfobyT-rI7uAiKM;
        Wed, 04 Sep 2019 16:53:18 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH v1 5/7] mm/mlock: recharge memory accounting to second mlock
 user at munlock
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Cc:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Date:   Wed, 04 Sep 2019 16:53:18 +0300
Message-ID: <156760519844.6560.1129059727979832602.stgit@buzz>
In-Reply-To: <156760509382.6560.17364256340940314860.stgit@buzz>
References: <156760509382.6560.17364256340940314860.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Munlock isolates page from LRU and then looks for another mlock vma.
Thus we could could rechange page to second mlock without isolating.

This patch adds argument 'isolated' to mlock_vma_page() and passes this
flag through try_to_ummap as TTU_LRU_ISOLATED.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 include/linux/rmap.h |    3 ++-
 mm/gup.c             |    2 +-
 mm/huge_memory.c     |    4 ++--
 mm/internal.h        |    6 ++++--
 mm/ksm.c             |    2 +-
 mm/migrate.c         |    2 +-
 mm/mlock.c           |   21 ++++++++++++---------
 mm/rmap.c            |    5 +++--
 8 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 988d176472df..4552716ac3da 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -98,7 +98,8 @@ enum ttu_flags {
 					 * do a final flush if necessary */
 	TTU_RMAP_LOCKED		= 0x80,	/* do not grab rmap lock:
 					 * caller holds it */
-	TTU_SPLIT_FREEZE	= 0x100,		/* freeze pte under splitting thp */
+	TTU_SPLIT_FREEZE	= 0x100, /* freeze pte under splitting thp */
+	TTU_LRU_ISOLATED	= 0x200, /* caller isolated page from LRU */
 };
 
 #ifdef CONFIG_MMU
diff --git a/mm/gup.c b/mm/gup.c
index f0accc229266..e0784e9022fe 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -306,7 +306,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 			 * know the page is still mapped, we don't even
 			 * need to check for file-cache page truncation.
 			 */
-			mlock_vma_page(vma, page);
+			mlock_vma_page(vma, page, false);
 			unlock_page(page);
 		}
 	}
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 157faa231e26..7822997d765c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1513,7 +1513,7 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
 			goto skip_mlock;
 		lru_add_drain();
 		if (page->mapping && !PageDoubleMap(page))
-			mlock_vma_page(vma, page);
+			mlock_vma_page(vma, page, false);
 		unlock_page(page);
 	}
 skip_mlock:
@@ -3009,7 +3009,7 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
 		page_add_file_rmap(new, true);
 	set_pmd_at(mm, mmun_start, pvmw->pmd, pmde);
 	if ((vma->vm_flags & VM_LOCKED) && !PageDoubleMap(new))
-		mlock_vma_page(vma, new);
+		mlock_vma_page(vma, new, false);
 	update_mmu_cache_pmd(vma, address, pvmw->pmd);
 }
 #endif
diff --git a/mm/internal.h b/mm/internal.h
index 9f91992ef281..1639fb581496 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -305,7 +305,8 @@ static inline void munlock_vma_pages_all(struct vm_area_struct *vma)
 /*
  * must be called with vma's mmap_sem held for read or write, and page locked.
  */
-extern void mlock_vma_page(struct vm_area_struct *vma, struct page *page);
+extern void mlock_vma_page(struct vm_area_struct *vma, struct page *page,
+			   bool isolated);
 extern unsigned int munlock_vma_page(struct page *page);
 
 /*
@@ -364,7 +365,8 @@ vma_address(struct page *page, struct vm_area_struct *vma)
 
 #else /* !CONFIG_MMU */
 static inline void clear_page_mlock(struct page *page) { }
-static inline void mlock_vma_page(struct vm_area_struct *, struct page *) { }
+static inline void mlock_vma_page(struct vm_area_struct *vma,
+				  struct page *page, bool isolated) { }
 static inline void mlock_migrate_page(struct page *new, struct page *old) { }
 
 #endif /* !CONFIG_MMU */
diff --git a/mm/ksm.c b/mm/ksm.c
index cb5705d6f26c..bf2a748c5e64 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1274,7 +1274,7 @@ static int try_to_merge_one_page(struct vm_area_struct *vma,
 		if (!PageMlocked(kpage)) {
 			unlock_page(page);
 			lock_page(kpage);
-			mlock_vma_page(vma, kpage);
+			mlock_vma_page(vma, kpage, false);
 			page = kpage;		/* for final unlock */
 		}
 	}
diff --git a/mm/migrate.c b/mm/migrate.c
index 1f6151cb7310..c13256ddc063 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -269,7 +269,7 @@ static bool remove_migration_pte(struct page *page, struct vm_area_struct *vma,
 				page_add_file_rmap(new, false);
 		}
 		if (vma->vm_flags & VM_LOCKED && !PageTransCompound(new))
-			mlock_vma_page(vma, new);
+			mlock_vma_page(vma, new, false);
 
 		if (PageTransHuge(page) && PageMlocked(page))
 			clear_page_mlock(page);
diff --git a/mm/mlock.c b/mm/mlock.c
index 68f068711203..07a2ab4d6a6c 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -85,7 +85,8 @@ void clear_page_mlock(struct page *page)
  * Mark page as mlocked if not already.
  * If page on LRU, isolate and putback to move to unevictable list.
  */
-void mlock_vma_page(struct vm_area_struct *vma, struct page *page)
+void mlock_vma_page(struct vm_area_struct *vma, struct page *page,
+		    bool isolated)
 {
 	/* Serialize with page migration */
 	BUG_ON(!PageLocked(page));
@@ -97,15 +98,17 @@ void mlock_vma_page(struct vm_area_struct *vma, struct page *page)
 		mod_zone_page_state(page_zone(page), NR_MLOCK,
 				    hpage_nr_pages(page));
 		count_vm_event(UNEVICTABLE_PGMLOCKED);
-		if (!isolate_lru_page(page)) {
-			/*
-			 * Force memory recharge to mlock user. Cannot
-			 * reclaim memory because called under pte lock.
-			 */
-			mem_cgroup_try_recharge(page, vma->vm_mm,
-						GFP_NOWAIT | __GFP_NOFAIL);
+
+		if (!isolated && isolate_lru_page(page))
+			return;
+		/*
+		 * Force memory recharge to mlock user.
+		 * Cannot reclaim memory because called under pte lock.
+		 */
+		mem_cgroup_try_recharge(page, vma->vm_mm,
+					GFP_NOWAIT | __GFP_NOFAIL);
+		if (!isolated)
 			putback_lru_page(page);
-		}
 	}
 }
 
diff --git a/mm/rmap.c b/mm/rmap.c
index de88f4897c1d..0b21b27f3519 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1410,7 +1410,8 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 					 * Holding pte lock, we do *not* need
 					 * mmap_sem here
 					 */
-					mlock_vma_page(vma, page);
+					mlock_vma_page(vma, page,
+						!!(flags & TTU_LRU_ISOLATED));
 				}
 				ret = false;
 				page_vma_mapped_walk_done(&pvmw);
@@ -1752,7 +1753,7 @@ void try_to_munlock(struct page *page)
 {
 	struct rmap_walk_control rwc = {
 		.rmap_one = try_to_unmap_one,
-		.arg = (void *)TTU_MUNLOCK,
+		.arg = (void *)(TTU_MUNLOCK | TTU_LRU_ISOLATED),
 		.done = page_not_mapped,
 		.anon_lock = page_lock_anon_vma_read,
 

