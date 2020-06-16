Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA2FA1FA8AC
	for <lists+cgroups@lfdr.de>; Tue, 16 Jun 2020 08:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgFPGOa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 16 Jun 2020 02:14:30 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:38846 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727071AbgFPGO3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 16 Jun 2020 02:14:29 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0U.l4uVw_1592288061;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U.l4uVw_1592288061)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 16 Jun 2020 14:14:21 +0800
Subject: Re: [PATCH v11 00/16] per memcg lru lock
To:     Hugh Dickins <hughd@google.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com
References: <1590663658-184131-1-git-send-email-alex.shi@linux.alibaba.com>
 <alpine.LSU.2.11.2006072100390.2001@eggly.anvils>
 <31943f08-a8e8-be38-24fb-ab9d25fd96ff@linux.alibaba.com>
 <alpine.LSU.2.11.2006091904530.2779@eggly.anvils>
 <730c595b-f4bf-b16a-562e-de25b9b7eb97@linux.alibaba.com>
 <alpine.LSU.2.11.2006111409280.10801@eggly.anvils>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <cc471d42-4e7d-b8ec-bc2f-ee85090231fb@linux.alibaba.com>
Date:   Tue, 16 Jun 2020 14:14:19 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.2006111409280.10801@eggly.anvils>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/6/12 上午6:09, Hugh Dickins 写道:
>>> I thought that a very safe change, but best to do some test runs with
>>> it in before finalizing. And was then unpleasantly surprised to hit a
>>> VM_BUG_ON_PAGE(lruvec_memcg(lruvec) != page->mem_cgroup) from
>>> lock_page_lruvec_irqsave < relock_page_lruvec < pagevec_lru_move_fn <
>>> pagevec_move_tail < lru_add_drain_cpu after 6 hours on one machine.
>>> Then similar but < rotate_reclaimable_page after 8 hours on another.
>>>
>>> Only seen once before: that's what drove me to add patch 4 (with 3 to
>>> revert the locking before it): somehow, when adding the lruvec locking
>>> there, I just took it for granted that your patchset would have the
>>> appropriate locking (or TestClearPageLRU magic) at the other end.
>>>
>>> But apparently not. And I'm beginning to think that TestClearPageLRU
>>> was just to distract the audience from the lack of proper locking.
>>>
>>> I have certainly not concluded that yet, but I'm having to think about
>>> an area of the code which I'd imagined you had under control (and I'm
>>> puzzled why my testing has found it so very hard to hit). If we're
>>> lucky, I'll find that pagevec_move_tail is a special case, and
>>> nothing much else needs changing; but I doubt that will be so.
> ... shows that your locking primitives are not yet good enough
> to handle the case when tasks are moved between memcgs with
> move_charge_at_immigrate set.  "bin/cg m" in the tests I sent,
> but today I'm changing its "seconds=60" to "seconds=1" in hope
> of speeding up the reproduction.
> 
> Ah, good, two machines crashed in 1.5 hours: but I don't need to
> examine the crashes, now that it's obvious there's no protection -
> please, think about rotate_reclaimable_page() (there will be more
> cases, but in practice that seems easiest to hit, so focus on that)
> and how it is not protected from mem_cgroup_move_account().
> 
> I'm thinking too. Maybe judicious use of lock_page_memcg() can fix it
> (8 years ago it was unsuitable, but a lot has changed for the better
> since then); otherwise it's back to what I've been doing all along,
> taking the likely lruvec lock, and checking under that lock whether
> we have the right lock (as your lruvec_memcg_debug() does), retrying
> if not. Which may be more efficient than involving lock_page_memcg().
> 
Hi Hugh,

Thanks a lot for the report!

Think again lru_move_fn and mem_cgroup_move_account relation. I found
if we want to change the pgdat->lru_lock to memcg's lruvec lock, we have
to serialize mem_cgroup_move_account during pagevec_lru_move_fn. Otherwise
the possible bad scenario would like:

        cpu 0                                   cpu 1
    lruvec = mem_cgroup_page_lruvec()
                                        if (!isolate_lru_page())
                                                mem_cgroup_move_account

    spin_lock_irqsave(&lruvec->lru_lock <== wrong lock.

So we need the ClearPageLRU to block isolate_lru_page(), then serialize
the memcg change here. Do relock check would get a mitigation, but not
solution.

The following patch fold vm event PGROTATED into pagevec_move_tail_fn
and fixed this problem by ClearPageLRU before page moving between lru
I will split them into 2 patches, and merge into v12 patchset.

Reported-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>


diff --git a/mm/swap.c b/mm/swap.c
index eba0c17dffd8..fa211157bfec 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -200,8 +200,7 @@ int get_kernel_page(unsigned long start, int write, struct page **pages)
 EXPORT_SYMBOL_GPL(get_kernel_page);
 
 static void pagevec_lru_move_fn(struct pagevec *pvec,
-	void (*move_fn)(struct page *page, struct lruvec *lruvec, void *arg),
-	void *arg)
+	void (*move_fn)(struct page *page, struct lruvec *lruvec), bool add)
 {
 	int i;
 	struct lruvec *lruvec = NULL;
@@ -210,8 +209,14 @@ static void pagevec_lru_move_fn(struct pagevec *pvec,
 	for (i = 0; i < pagevec_count(pvec); i++) {
 		struct page *page = pvec->pages[i];
 
+		if (!add && !TestClearPageLRU(page))
+			continue;
+
 		lruvec = relock_page_lruvec_irqsave(page, lruvec, &flags);
-		(*move_fn)(page, lruvec, arg);
+		(*move_fn)(page, lruvec);
+
+		if (!add)
+			SetPageLRU(page);
 	}
 	if (lruvec)
 		unlock_page_lruvec_irqrestore(lruvec, flags);
@@ -219,35 +224,23 @@ static void pagevec_lru_move_fn(struct pagevec *pvec,
 	pagevec_reinit(pvec);
 }
 
-static void pagevec_move_tail_fn(struct page *page, struct lruvec *lruvec,
-				 void *arg)
+static void pagevec_move_tail_fn(struct page *page, struct lruvec *lruvec)
 {
-	int *pgmoved = arg;
-
 	if (PageLRU(page) && !PageUnevictable(page)) {
 		del_page_from_lru_list(page, lruvec, page_lru(page));
 		ClearPageActive(page);
 		add_page_to_lru_list_tail(page, lruvec, page_lru(page));
-		(*pgmoved) += hpage_nr_pages(page);
+		__count_vm_events(PGROTATED, hpage_nr_pages(page));
 	}
 }
 
 /*
- * pagevec_move_tail() must be called with IRQ disabled.
- * Otherwise this may cause nasty races.
- */
-static void pagevec_move_tail(struct pagevec *pvec)
-{
-	int pgmoved = 0;
-
-	pagevec_lru_move_fn(pvec, pagevec_move_tail_fn, &pgmoved);
-	__count_vm_events(PGROTATED, pgmoved);
-}
-
-/*
  * Writeback is about to end against a page which has been marked for immediate
  * reclaim.  If it still appears to be reclaimable, move it to the tail of the
  * inactive list.
+ *
+ * pagevec_move_tail_fn() must be called with IRQ disabled.
+ * Otherwise this may cause nasty races.
  */
 void rotate_reclaimable_page(struct page *page)
 {
@@ -260,7 +253,7 @@ void rotate_reclaimable_page(struct page *page)
 		local_lock_irqsave(&lru_rotate.lock, flags);
 		pvec = this_cpu_ptr(&lru_rotate.pvec);
 		if (!pagevec_add(pvec, page) || PageCompound(page))
-			pagevec_move_tail(pvec);
+			pagevec_lru_move_fn(pvec, pagevec_move_tail_fn, false);
 		local_unlock_irqrestore(&lru_rotate.lock, flags);
 	}
 }
@@ -302,8 +295,7 @@ void lru_note_cost_page(struct page *page)
 		      page_is_file_lru(page), hpage_nr_pages(page));
 }
 
-static void __activate_page(struct page *page, struct lruvec *lruvec,
-			    void *arg)
+static void __activate_page(struct page *page, struct lruvec *lruvec)
 {
 	if (PageLRU(page) && !PageActive(page) && !PageUnevictable(page)) {
 		int lru = page_lru_base_type(page);
@@ -327,7 +319,7 @@ static void activate_page_drain(int cpu)
 	struct pagevec *pvec = &per_cpu(lru_pvecs.activate_page, cpu);
 
 	if (pagevec_count(pvec))
-		pagevec_lru_move_fn(pvec, __activate_page, NULL);
+		pagevec_lru_move_fn(pvec, __activate_page, false);
 }
 
 static bool need_activate_page_drain(int cpu)
@@ -345,7 +337,7 @@ void activate_page(struct page *page)
 		pvec = this_cpu_ptr(&lru_pvecs.activate_page);
 		get_page(page);
 		if (!pagevec_add(pvec, page) || PageCompound(page))
-			pagevec_lru_move_fn(pvec, __activate_page, NULL);
+			pagevec_lru_move_fn(pvec, __activate_page, false);
 		local_unlock(&lru_pvecs.lock);
 	}
 }
@@ -515,8 +507,7 @@ void lru_cache_add_active_or_unevictable(struct page *page,
  * be write it out by flusher threads as this is much more effective
  * than the single-page writeout from reclaim.
  */
-static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec,
-			      void *arg)
+static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec)
 {
 	int lru;
 	bool active;
@@ -563,8 +554,7 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec,
 	}
 }
 
-static void lru_deactivate_fn(struct page *page, struct lruvec *lruvec,
-			    void *arg)
+static void lru_deactivate_fn(struct page *page, struct lruvec *lruvec)
 {
 	if (PageLRU(page) && PageActive(page) && !PageUnevictable(page)) {
 		int lru = page_lru_base_type(page);
@@ -581,8 +571,7 @@ static void lru_deactivate_fn(struct page *page, struct lruvec *lruvec,
 	}
 }
 
-static void lru_lazyfree_fn(struct page *page, struct lruvec *lruvec,
-			    void *arg)
+static void lru_lazyfree_fn(struct page *page, struct lruvec *lruvec)
 {
 	if (PageLRU(page) && PageAnon(page) && PageSwapBacked(page) &&
 	    !PageSwapCache(page) && !PageUnevictable(page)) {
@@ -625,21 +614,21 @@ void lru_add_drain_cpu(int cpu)
 
 		/* No harm done if a racing interrupt already did this */
 		local_lock_irqsave(&lru_rotate.lock, flags);
-		pagevec_move_tail(pvec);
+		pagevec_lru_move_fn(pvec, pagevec_move_tail_fn, false);
 		local_unlock_irqrestore(&lru_rotate.lock, flags);
 	}
 
 	pvec = &per_cpu(lru_pvecs.lru_deactivate_file, cpu);
 	if (pagevec_count(pvec))
-		pagevec_lru_move_fn(pvec, lru_deactivate_file_fn, NULL);
+		pagevec_lru_move_fn(pvec, lru_deactivate_file_fn, false);
 
 	pvec = &per_cpu(lru_pvecs.lru_deactivate, cpu);
 	if (pagevec_count(pvec))
-		pagevec_lru_move_fn(pvec, lru_deactivate_fn, NULL);
+		pagevec_lru_move_fn(pvec, lru_deactivate_fn, false);
 
 	pvec = &per_cpu(lru_pvecs.lru_lazyfree, cpu);
 	if (pagevec_count(pvec))
-		pagevec_lru_move_fn(pvec, lru_lazyfree_fn, NULL);
+		pagevec_lru_move_fn(pvec, lru_lazyfree_fn, false);
 
 	activate_page_drain(cpu);
 }
@@ -668,7 +657,7 @@ void deactivate_file_page(struct page *page)
 		pvec = this_cpu_ptr(&lru_pvecs.lru_deactivate_file);
 
 		if (!pagevec_add(pvec, page) || PageCompound(page))
-			pagevec_lru_move_fn(pvec, lru_deactivate_file_fn, NULL);
+			pagevec_lru_move_fn(pvec, lru_deactivate_file_fn, false);
 		local_unlock(&lru_pvecs.lock);
 	}
 }
@@ -690,7 +679,7 @@ void deactivate_page(struct page *page)
 		pvec = this_cpu_ptr(&lru_pvecs.lru_deactivate);
 		get_page(page);
 		if (!pagevec_add(pvec, page) || PageCompound(page))
-			pagevec_lru_move_fn(pvec, lru_deactivate_fn, NULL);
+			pagevec_lru_move_fn(pvec, lru_deactivate_fn, false);
 		local_unlock(&lru_pvecs.lock);
 	}
 }
@@ -712,7 +701,7 @@ void mark_page_lazyfree(struct page *page)
 		pvec = this_cpu_ptr(&lru_pvecs.lru_lazyfree);
 		get_page(page);
 		if (!pagevec_add(pvec, page) || PageCompound(page))
-			pagevec_lru_move_fn(pvec, lru_lazyfree_fn, NULL);
+			pagevec_lru_move_fn(pvec, lru_lazyfree_fn, false);
 		local_unlock(&lru_pvecs.lock);
 	}
 }
@@ -913,8 +902,7 @@ void __pagevec_release(struct pagevec *pvec)
 }
 EXPORT_SYMBOL(__pagevec_release);
 
-static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec,
-				 void *arg)
+static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec)
 {
 	enum lru_list lru;
 	int was_unevictable = TestClearPageUnevictable(page);
@@ -973,7 +961,7 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec,
  */
 void __pagevec_lru_add(struct pagevec *pvec)
 {
-	pagevec_lru_move_fn(pvec, __pagevec_lru_add_fn, NULL);
+	pagevec_lru_move_fn(pvec, __pagevec_lru_add_fn, true);
 }
 
 /**
