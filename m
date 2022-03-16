Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C8A4DB965
	for <lists+cgroups@lfdr.de>; Wed, 16 Mar 2022 21:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351349AbiCPUcz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 16 Mar 2022 16:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351072AbiCPUcu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 16 Mar 2022 16:32:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2617A53B76
        for <cgroups@vger.kernel.org>; Wed, 16 Mar 2022 13:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=wrxNxBy8s6TDvnPVGvUvMddh1Mjgt2nIlkzhG/1ajBY=; b=ZX8nantX2NIUcvAbd5Hw8ZWFqL
        oxU9CcdISZ8FFQlChGWUAzCnM8hpQ/TJyTnCheB5kxzIqbgV1loS2gECpHr4w+NKHda2JZAwIpyZR
        FGzUqdC/Mqyt+PXYGAG9DgklZktI/IdB4D3PWnOnMMun77o9zAh0uMiJElg4WDj3ER3FbFdEHMfHV
        BIRtkVAu847tsWJpPPX3MRF5MYpvBT+lxoGz9Y655mY63KTVsF/+HzMAMQspYh45jYdpaljIyLpCx
        RAvmJfS82wackrgUFXcwrtrRK0jIxw8MefyHlyE4uRyZppsvZffMRNeskX9klk0wg/im14x2/+gQw
        ehubXdHg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUaIs-006MBu-1I; Wed, 16 Mar 2022 20:31:30 +0000
Date:   Wed, 16 Mar 2022 20:31:30 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: [RFC] memcg: Convert mc_target.page to mc_target.folio
Message-ID: <YjJJIrENYb1qFHzl@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This is a fairly mechanical change to convert mc_target.page to
mc_target.folio.  This is a prerequisite for converting
find_get_incore_page() to find_get_incore_folio().  But I'm not
convinced it's right, and I'm not convinced the existing code is
quite right either.

In particular, the code in hunk @@ -6036,28 +6041,26 @@ needs
careful review.  There are also assumptions in here that a memory
allocation is never larger than a PMD, which is true today, but I've
been asked about larger allocations.


diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ae66972a0331..a424df06b3e1 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5461,42 +5461,44 @@ static int mem_cgroup_do_precharge(unsigned long count)
 }
 
 union mc_target {
-	struct page	*page;
+	struct folio	*folio;
 	swp_entry_t	ent;
 };
 
 enum mc_target_type {
 	MC_TARGET_NONE = 0,
-	MC_TARGET_PAGE,
+	MC_TARGET_FOLIO,
 	MC_TARGET_SWAP,
 	MC_TARGET_DEVICE,
 };
 
-static struct page *mc_handle_present_pte(struct vm_area_struct *vma,
+static struct folio *mc_handle_present_pte(struct vm_area_struct *vma,
 						unsigned long addr, pte_t ptent)
 {
 	struct page *page = vm_normal_page(vma, addr, ptent);
+	struct folio *folio;
 
 	if (!page || !page_mapped(page))
 		return NULL;
-	if (PageAnon(page)) {
+	folio = page_folio(page);
+	if (folio_test_anon(folio)) {
 		if (!(mc.flags & MOVE_ANON))
 			return NULL;
 	} else {
 		if (!(mc.flags & MOVE_FILE))
 			return NULL;
 	}
-	if (!get_page_unless_zero(page))
+	if (!folio_try_get(folio))
 		return NULL;
 
-	return page;
+	return folio;
 }
 
 #if defined(CONFIG_SWAP) || defined(CONFIG_DEVICE_PRIVATE)
-static struct page *mc_handle_swap_pte(struct vm_area_struct *vma,
+static struct folio *mc_handle_swap_pte(struct vm_area_struct *vma,
 			pte_t ptent, swp_entry_t *entry)
 {
-	struct page *page = NULL;
+	struct folio *folio;
 	swp_entry_t ent = pte_to_swp_entry(ptent);
 
 	if (!(mc.flags & MOVE_ANON))
@@ -5507,10 +5509,12 @@ static struct page *mc_handle_swap_pte(struct vm_area_struct *vma,
 	 * stored as special swap entries in the page table.
 	 */
 	if (is_device_private_entry(ent)) {
-		page = pfn_swap_entry_to_page(ent);
-		if (!get_page_unless_zero(page))
+		struct page *page = pfn_swap_entry_to_page(ent);
+
+		folio = page_folio(page);
+		if (!folio_try_get(folio))
 			return NULL;
-		return page;
+		return folio;
 	}
 
 	if (non_swap_entry(ent))
@@ -5518,22 +5522,22 @@ static struct page *mc_handle_swap_pte(struct vm_area_struct *vma,
 
 	/*
 	 * Because lookup_swap_cache() updates some statistics counter,
-	 * we call find_get_page() with swapper_space directly.
+	 * we call filemap_get_folio() with swapper_space directly.
 	 */
-	page = find_get_page(swap_address_space(ent), swp_offset(ent));
+	folio = filemap_get_folio(swap_address_space(ent), swp_offset(ent));
 	entry->val = ent.val;
 
-	return page;
+	return folio;
 }
 #else
-static struct page *mc_handle_swap_pte(struct vm_area_struct *vma,
+static struct folio *mc_handle_swap_pte(struct vm_area_struct *vma,
 			pte_t ptent, swp_entry_t *entry)
 {
 	return NULL;
 }
 #endif
 
-static struct page *mc_handle_file_pte(struct vm_area_struct *vma,
+static struct folio *mc_handle_file_pte(struct vm_area_struct *vma,
 			unsigned long addr, pte_t ptent)
 {
 	if (!vma->vm_file) /* anonymous vma */
@@ -5543,28 +5547,28 @@ static struct page *mc_handle_file_pte(struct vm_area_struct *vma,
 
 	/* page is moved even if it's not RSS of this task(page-faulted). */
 	/* shmem/tmpfs may report page out on swap: account for that too. */
-	return find_get_incore_page(vma->vm_file->f_mapping,
-			linear_page_index(vma, addr));
+	return page_folio(find_get_incore_page(vma->vm_file->f_mapping,
+			linear_page_index(vma, addr)));
 }
 
 /**
- * mem_cgroup_move_account - move account of the page
- * @page: the page
- * @compound: charge the page as compound or small page
- * @from: mem_cgroup which the page is moved from.
- * @to:	mem_cgroup which the page is moved to. @from != @to.
+ * mem_cgroup_move_account - move account of the folio
+ * @folio: The folio.
+ * @compound: Charge the folio as large or small.
+ * @from: mem_cgroup which the folio is moved from.
+ * @to:	mem_cgroup which the folio is moved to. @from != @to.
  *
- * The caller must make sure the page is not on LRU (isolate_page() is useful.)
+ * The caller must make sure the folio is not on LRU (folio_isolate_lru()
+ * is useful.)
  *
  * This function doesn't do "charge" to new cgroup and doesn't do "uncharge"
  * from old cgroup.
  */
-static int mem_cgroup_move_account(struct page *page,
+static int mem_cgroup_move_account(struct folio *folio,
 				   bool compound,
 				   struct mem_cgroup *from,
 				   struct mem_cgroup *to)
 {
-	struct folio *folio = page_folio(page);
 	struct lruvec *from_vec, *to_vec;
 	struct pglist_data *pgdat;
 	unsigned int nr_pages = compound ? folio_nr_pages(folio) : 1;
@@ -5576,7 +5580,7 @@ static int mem_cgroup_move_account(struct page *page,
 
 	/*
 	 * Prevent mem_cgroup_migrate() from looking at
-	 * page's memory cgroup of its source page while we change it.
+	 * folio's memory cgroup of its source folio while we change it.
 	 */
 	ret = -EBUSY;
 	if (!folio_trylock(folio))
@@ -5637,13 +5641,13 @@ static int mem_cgroup_move_account(struct page *page,
 	/*
 	 * All state has been migrated, let's switch to the new memcg.
 	 *
-	 * It is safe to change page's memcg here because the page
+	 * It is safe to change folio's memcg here because the folio
 	 * is referenced, charged, isolated, and locked: we can't race
 	 * with (un)charging, migration, LRU putback, or anything else
-	 * that would rely on a stable page's memory cgroup.
+	 * that would rely on a stable folio's memory cgroup.
 	 *
-	 * Note that lock_page_memcg is a memcg lock, not a page lock,
-	 * to save space. As soon as we switch page's memory cgroup to a
+	 * Note that folio_memcg_lock is a memcg lock, not a folio lock,
+	 * to save space. As soon as we switch folio's memory cgroup to a
 	 * new memcg that isn't locked, the above state can change
 	 * concurrently again. Make sure we're truly done with it.
 	 */
@@ -5676,21 +5680,21 @@ static int mem_cgroup_move_account(struct page *page,
  * @vma: the vma the pte to be checked belongs
  * @addr: the address corresponding to the pte to be checked
  * @ptent: the pte to be checked
- * @target: the pointer the target page or swap ent will be stored(can be NULL)
+ * @target: the pointer the target folio or swap ent will be stored(can be NULL)
  *
  * Returns
  *   0(MC_TARGET_NONE): if the pte is not a target for move charge.
- *   1(MC_TARGET_PAGE): if the page corresponding to this pte is a target for
- *     move charge. if @target is not NULL, the page is stored in target->page
+ *   1(MC_TARGET_FOLIO): if the folio corresponding to this pte is a target for
+ *     move charge. if @target is not NULL, the folio is stored in target->folio
  *     with extra refcnt got(Callers should handle it).
  *   2(MC_TARGET_SWAP): if the swap entry corresponding to this pte is a
  *     target for charge migration. if @target is not NULL, the entry is stored
  *     in target->ent.
- *   3(MC_TARGET_DEVICE): like MC_TARGET_PAGE  but page is device memory and
+ *   3(MC_TARGET_DEVICE): like MC_TARGET_FOLIO  but folio is device memory and
  *   thus not on the lru.
- *     For now we such page is charge like a regular page would be as for all
+ *     For now such folio is chargd like a regular folio would be as for all
  *     intent and purposes it is just special memory taking the place of a
- *     regular page.
+ *     regular folio.
  *
  *     See Documentations/vm/hmm.txt and include/linux/hmm.h
  *
@@ -5700,41 +5704,41 @@ static int mem_cgroup_move_account(struct page *page,
 static enum mc_target_type get_mctgt_type(struct vm_area_struct *vma,
 		unsigned long addr, pte_t ptent, union mc_target *target)
 {
-	struct page *page = NULL;
+	struct folio *folio = NULL;
 	enum mc_target_type ret = MC_TARGET_NONE;
 	swp_entry_t ent = { .val = 0 };
 
 	if (pte_present(ptent))
-		page = mc_handle_present_pte(vma, addr, ptent);
+		folio = mc_handle_present_pte(vma, addr, ptent);
 	else if (is_swap_pte(ptent))
-		page = mc_handle_swap_pte(vma, ptent, &ent);
+		folio = mc_handle_swap_pte(vma, ptent, &ent);
 	else if (pte_none(ptent))
-		page = mc_handle_file_pte(vma, addr, ptent);
+		folio = mc_handle_file_pte(vma, addr, ptent);
 
-	if (!page && !ent.val)
+	if (!folio && !ent.val)
 		return ret;
-	if (page) {
+	if (folio) {
 		/*
 		 * Do only loose check w/o serialization.
-		 * mem_cgroup_move_account() checks the page is valid or
+		 * mem_cgroup_move_account() checks the folio is valid or
 		 * not under LRU exclusion.
 		 */
-		if (page_memcg(page) == mc.from) {
-			ret = MC_TARGET_PAGE;
-			if (is_device_private_page(page) ||
-			    is_device_coherent_page(page))
+		if (folio_memcg(folio) == mc.from) {
+			ret = MC_TARGET_FOLIO;
+			if (folio_is_device_private(folio) ||
+			    folio_is_device_coherent(folio))
 				ret = MC_TARGET_DEVICE;
 			if (target)
-				target->page = page;
+				target->folio = folio;
 		}
 		if (!ret || !target)
-			put_page(page);
+			folio_put(folio);
 	}
 	/*
-	 * There is a swap entry and a page doesn't exist or isn't charged.
+	 * There is a swap entry and a folio doesn't exist or isn't charged.
 	 * But we cannot move a tail-page in a THP.
 	 */
-	if (ent.val && !ret && (!page || !PageTransCompound(page)) &&
+	if (ent.val && !ret && (!folio || !folio_test_large(folio)) &&
 	    mem_cgroup_id(mc.from) == lookup_swap_cgroup_id(ent)) {
 		ret = MC_TARGET_SWAP;
 		if (target)
@@ -5745,14 +5749,14 @@ static enum mc_target_type get_mctgt_type(struct vm_area_struct *vma,
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 /*
- * We don't consider PMD mapped swapping or file mapped pages because THP does
+ * We don't consider PMD mapped swapping or file mapped folios because THP does
  * not support them for now.
  * Caller should make sure that pmd_trans_huge(pmd) is true.
  */
 static enum mc_target_type get_mctgt_type_thp(struct vm_area_struct *vma,
 		unsigned long addr, pmd_t pmd, union mc_target *target)
 {
-	struct page *page = NULL;
+	struct folio *folio = NULL;
 	enum mc_target_type ret = MC_TARGET_NONE;
 
 	if (unlikely(is_swap_pmd(pmd))) {
@@ -5760,15 +5764,15 @@ static enum mc_target_type get_mctgt_type_thp(struct vm_area_struct *vma,
 				  !is_pmd_migration_entry(pmd));
 		return ret;
 	}
-	page = pmd_page(pmd);
-	VM_BUG_ON_PAGE(!page || !PageHead(page), page);
+	folio = page_folio(pmd_page(pmd));
+	VM_BUG_ON_FOLIO(!folio || !folio_test_large(folio), folio);
 	if (!(mc.flags & MOVE_ANON))
 		return ret;
-	if (page_memcg(page) == mc.from) {
-		ret = MC_TARGET_PAGE;
+	if (folio_memcg(folio) == mc.from) {
+		ret = MC_TARGET_FOLIO;
 		if (target) {
-			get_page(page);
-			target->page = page;
+			folio_get(folio);
+			target->folio = folio;
 		}
 	}
 	return ret;
@@ -5796,7 +5800,8 @@ static int mem_cgroup_count_precharge_pte_range(pmd_t *pmd,
 		 * support transparent huge page with MEMORY_DEVICE_PRIVATE but
 		 * this might change.
 		 */
-		if (get_mctgt_type_thp(vma, addr, *pmd, NULL) == MC_TARGET_PAGE)
+		if (get_mctgt_type_thp(vma, addr, *pmd, NULL) ==
+				MC_TARGET_FOLIO)
 			mc.precharge += HPAGE_PMD_NR;
 		spin_unlock(ptl);
 		return 0;
@@ -5987,7 +5992,7 @@ static int mem_cgroup_move_charge_pte_range(pmd_t *pmd,
 	spinlock_t *ptl;
 	enum mc_target_type target_type;
 	union mc_target target;
-	struct page *page;
+	struct folio *folio;
 
 	ptl = pmd_trans_huge_lock(pmd, vma);
 	if (ptl) {
@@ -5996,25 +6001,25 @@ static int mem_cgroup_move_charge_pte_range(pmd_t *pmd,
 			return 0;
 		}
 		target_type = get_mctgt_type_thp(vma, addr, *pmd, &target);
-		if (target_type == MC_TARGET_PAGE) {
-			page = target.page;
-			if (!isolate_lru_page(page)) {
-				if (!mem_cgroup_move_account(page, true,
+		if (target_type == MC_TARGET_FOLIO) {
+			folio = target.folio;
+			if (!folio_isolate_lru(folio)) {
+				if (!mem_cgroup_move_account(folio, true,
 							     mc.from, mc.to)) {
 					mc.precharge -= HPAGE_PMD_NR;
 					mc.moved_charge += HPAGE_PMD_NR;
 				}
-				putback_lru_page(page);
+				folio_putback_lru(folio);
 			}
-			put_page(page);
+			folio_put(folio);
 		} else if (target_type == MC_TARGET_DEVICE) {
-			page = target.page;
-			if (!mem_cgroup_move_account(page, true,
+			folio = target.folio;
+			if (!mem_cgroup_move_account(folio, true,
 						     mc.from, mc.to)) {
 				mc.precharge -= HPAGE_PMD_NR;
 				mc.moved_charge += HPAGE_PMD_NR;
 			}
-			put_page(page);
+			folio_put(folio);
 		}
 		spin_unlock(ptl);
 		return 0;
@@ -6036,28 +6041,26 @@ static int mem_cgroup_move_charge_pte_range(pmd_t *pmd,
 		case MC_TARGET_DEVICE:
 			device = true;
 			fallthrough;
-		case MC_TARGET_PAGE:
-			page = target.page;
+		case MC_TARGET_FOLIO:
+			folio = target.folio;
 			/*
-			 * We can have a part of the split pmd here. Moving it
-			 * can be done but it would be too convoluted so simply
-			 * ignore such a partial THP and keep it in original
-			 * memcg. There should be somebody mapping the head.
+			 * Is bailing out here with a large folio still the
+			 * right thing to do?  Unclear.
 			 */
-			if (PageTransCompound(page))
+			if (folio_test_large(folio))
 				goto put;
-			if (!device && isolate_lru_page(page))
+			if (!device && folio_isolate_lru(folio))
 				goto put;
-			if (!mem_cgroup_move_account(page, false,
+			if (!mem_cgroup_move_account(folio, false,
 						mc.from, mc.to)) {
 				mc.precharge--;
 				/* we uncharge from mc.from later. */
 				mc.moved_charge++;
 			}
 			if (!device)
-				putback_lru_page(page);
-put:			/* get_mctgt_type() gets the page */
-			put_page(page);
+				folio_putback_lru(folio);
+put:			/* get_mctgt_type() gets the folio */
+			folio_put(folio);
 			break;
 		case MC_TARGET_SWAP:
 			ent = target.ent;
