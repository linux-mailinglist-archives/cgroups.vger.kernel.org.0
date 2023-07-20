Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC5F75A74B
	for <lists+cgroups@lfdr.de>; Thu, 20 Jul 2023 09:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjGTHIt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Jul 2023 03:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjGTHIh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Jul 2023 03:08:37 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FBF269F
        for <cgroups@vger.kernel.org>; Thu, 20 Jul 2023 00:08:34 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c0d62f4487cso473532276.0
        for <cgroups@vger.kernel.org>; Thu, 20 Jul 2023 00:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689836913; x=1692428913;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zkE9erfuSG8gEvl0NErmWP/HjsAjs5BO1W50P95ENGk=;
        b=e/D65lKvyv50V3yr9BFRknnH79sSEuD/+1vUrcA4yvr7h7CImtQrd+boASPoSkcO0L
         6nRrg9RNuJbGc3QdJ+P9rn/E7NPWcOSDBxQOvrkM1p7NFo6krBFtBVk5c7HmdKOK4Es2
         PuB6i+F5kcVT9zlYpRauNGwgIdsKA8qks2YqdR/pIFwq1jYHE090fjgDVGsSN7ZNarF3
         4Cq9H5nWz2ZZjH50Yn64E7tOX0T+9lLwqWlGsXWl0d6eVKSMhor5hN/I8U314hOaUpAt
         UvHj1RrFPkxtGpaYcmmpPta/OEHLEEHI1epsszfPSw/hGh7pMPrxFrxoMgzBHB89kmi2
         mFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689836913; x=1692428913;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zkE9erfuSG8gEvl0NErmWP/HjsAjs5BO1W50P95ENGk=;
        b=egKWMQUVbCnBnABoyNcoEeCz19SsqzxXwh7j18FAOrB3oNfrhyiXWNQ7un52rSsLoB
         04fyvmIifKa9aiEvG1vusJFz/6NIYCuq6UPzcmRm6WX16OgcmM7X9ZxS9MHyj6E0fnQs
         OHQiXL03Csdbj/yMICbfJ0agT6dufOdM9ofb7lHUG6/AaZGZrTTBNWXsUoIZuqwPzfhA
         7F07kvwTglQXNIB3CIEvZhcgirjPaT0kK3f6YcDW55G0/uPVCUcFpCazucXaNnkWgNPq
         Bdb20vDJ80N60ZZ1OtiOqDWHccqcByN4jGej5JH+wze4GGmhcqs40LwP2YEhnPE33RqE
         TXFg==
X-Gm-Message-State: ABy/qLYNizdp7xrCIZQvIsVE2vmbAoBcpT7/adugDHeEztBT/LqsbwPW
        oo9HaVRxK6QmM645KH/6fuwOSSUS9X1x0uFi
X-Google-Smtp-Source: APBJJlF1XLkdIp+rrL6VnpxoZHQAd5Y1MvxoDSvMdyFfa3VhNOkSbCTVEqhKIhjXU4YLSRrvLIXqVgBHET8DWPA4
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a25:a021:0:b0:cf2:9e82:a5b5 with SMTP
 id x30-20020a25a021000000b00cf29e82a5b5mr32616ybh.8.1689836913480; Thu, 20
 Jul 2023 00:08:33 -0700 (PDT)
Date:   Thu, 20 Jul 2023 07:08:20 +0000
In-Reply-To: <20230720070825.992023-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230720070825.992023-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230720070825.992023-4-yosryahmed@google.com>
Subject: [RFC PATCH 3/8] memcg: recharge mapped folios when a memcg is offlined
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>
Cc:     Muchun Song <muchun.song@linux.dev>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Yu Zhao <yuzhao@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "T.J. Mercier" <tjmercier@google.com>,
        Greg Thelen <gthelen@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

When a cgroup is removed by userspace and its memcg goes offline,
attempt to recharge the pages charged to the memcg to other memcgs that
are actually using the folios. Recharging is done in an asynchronous
worker as it is an expensive operation and needs to acquire multiple
locks.

Recharge targets are identified by walking the rmap and checking the
memcgs of the processes mapping the folio, if any. We avoid an OOM kill
if we fail to charge the folio, to avoid inducing an OOM kill at a
seemingly random point in time in the target memcg.

If we fail for any reason (e.g. could not isolate all folios, could not
lock folio, target memcg reached its limit, etc), we reschedule the
worker to rety.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 include/linux/memcontrol.h |   6 +
 mm/memcontrol.c            | 230 +++++++++++++++++++++++++++++++++++++
 2 files changed, 236 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 5818af8eca5a..b41d69685ead 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -326,6 +326,12 @@ struct mem_cgroup {
 	struct lru_gen_mm_list mm_list;
 #endif
 
+	/* async recharge of mapped folios for offline memcgs */
+	struct {
+		struct delayed_work dwork;
+		int retries;
+	} recharge_mapped_work;
+
 	struct mem_cgroup_per_node *nodeinfo[];
 };
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ffdb848f4003..a46bc8f000c8 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -96,6 +96,8 @@ static bool cgroup_memory_nobpf __ro_after_init;
 static DECLARE_WAIT_QUEUE_HEAD(memcg_cgwb_frn_waitq);
 #endif
 
+static struct workqueue_struct *memcg_recharge_wq;
+
 /* Whether legacy memory+swap accounting is active */
 static bool do_memsw_account(void)
 {
@@ -5427,6 +5429,8 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 	return -ENOMEM;
 }
 
+static void memcg_recharge_mapped_folios(struct mem_cgroup *memcg);
+
 static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
@@ -5455,6 +5459,8 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
 	drain_all_stock(memcg);
 
 	mem_cgroup_id_put(memcg);
+
+	memcg_recharge_mapped_folios(memcg);
 }
 
 static void mem_cgroup_css_released(struct cgroup_subsys_state *css)
@@ -5487,6 +5493,7 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
 
 	vmpressure_cleanup(&memcg->vmpressure);
 	cancel_work_sync(&memcg->high_work);
+	cancel_delayed_work_sync(&memcg->recharge_mapped_work.dwork);
 	mem_cgroup_remove_from_trees(memcg);
 	free_shrinker_info(memcg);
 	mem_cgroup_free(memcg);
@@ -6367,6 +6374,219 @@ static void mem_cgroup_move_task(void)
 }
 #endif
 
+/* Returns true if recharging is successful */
+static bool mem_cgroup_recharge_folio(struct folio *folio,
+				      struct mem_cgroup *new_memcg)
+{
+	struct mem_cgroup *old_memcg = folio_memcg(folio);
+	gfp_t gfp = GFP_KERNEL | __GFP_RETRY_MAYFAIL;
+	long nr_pages = folio_nr_pages(folio);
+	int err = -1;
+
+	if (!new_memcg)
+		goto out;
+
+	err = try_charge(new_memcg, gfp, nr_pages);
+	if (err)
+		goto out;
+
+	err = mem_cgroup_move_account(&folio->page, folio_test_large(folio),
+				      old_memcg, new_memcg);
+	cancel_charge(err ? new_memcg : old_memcg, nr_pages);
+out:
+	return err == 0;
+}
+
+struct folio_memcg_rmap_recharge_arg {
+	bool recharged;
+};
+
+static bool folio_memcg_rmap_recharge_one(struct folio *folio,
+		struct vm_area_struct *vma, unsigned long address, void *arg)
+{
+	struct folio_memcg_rmap_recharge_arg *recharge_arg = arg;
+	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, address, 0);
+	struct mem_cgroup *memcg;
+
+	/*
+	 * page_vma_mapped_walk() is only needed to grab any pte lock to
+	 * serialize with page_remove_rmap(), as folio_mapped() must remain
+	 * stable during the move.
+	 */
+	recharge_arg->recharged = false;
+	while (page_vma_mapped_walk(&pvmw)) {
+		memcg = get_mem_cgroup_from_mm(vma->vm_mm);
+		if (mem_cgroup_recharge_folio(folio, memcg))
+			recharge_arg->recharged = true;
+		mem_cgroup_put(memcg);
+		page_vma_mapped_walk_done(&pvmw);
+		break;
+	}
+
+	/* stop the rmap walk if we were successful */
+	return !recharge_arg->recharged;
+}
+
+/* Returns true if recharging is successful */
+static bool folio_memcg_rmap_recharge(struct folio *folio)
+{
+	struct folio_memcg_rmap_recharge_arg arg = { .recharged = false };
+	struct rmap_walk_control rwc = {
+		.rmap_one = folio_memcg_rmap_recharge_one,
+		.arg = (void *)&arg,
+		.anon_lock = folio_lock_anon_vma_read,
+		.try_lock = true,
+	};
+
+	rmap_walk(folio, &rwc);
+	return arg.recharged;
+}
+
+static unsigned long lruvec_nr_local_mapped_pages(struct lruvec *lruvec)
+{
+	return lruvec_page_state_local(lruvec, NR_ANON_MAPPED) +
+		lruvec_page_state_local(lruvec, NR_FILE_MAPPED);
+}
+
+static unsigned long memcg_nr_local_mapped_pages(struct mem_cgroup *memcg)
+{
+	return memcg_page_state_local(memcg, NR_ANON_MAPPED) +
+		memcg_page_state_local(memcg, NR_FILE_MAPPED);
+}
+
+static bool memcg_recharge_lruvec_list(struct lruvec *lruvec,
+				       struct list_head *list,
+				       enum lru_list lru,
+				       void *arg)
+{
+	int isolated_idx = NR_ISOLATED_ANON + is_file_lru(lru);
+	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
+	unsigned long *nr_recharged = arg;
+	unsigned long nr_staged = 0;
+	LIST_HEAD(folios_skipped);
+	LIST_HEAD(folios_staged);
+	struct folio *folio;
+
+	/* Are we done with mapped pages on this node? */
+	if (!lruvec_nr_local_mapped_pages(lruvec))
+		return true;
+
+	/*
+	 * Iterating the LRUs here is tricky, because we
+	 * usually cannot iterate the entire list with the
+	 * lock held, and the LRU can change once we release it.
+	 *
+	 * What we try to do is isolate as many folios as we can
+	 * without hogging the lock or the cpu. We need to move
+	 * all the folios we iterate off the list to try to
+	 * avoid re-visiting them on retries.
+	 *
+	 * The folios we are interested in are moved to
+	 * @folios_staged, and other folios are moved to
+	 * @folios_skipped. Before releasing the lock, we splice
+	 * @folios_skipped back into the beginning of the LRU.
+	 * This essentially rotates the LRU, similar to reclaim,
+	 * as lru_to_folio() fetches folios from the end of the
+	 * LRU.
+	 */
+	spin_lock_irq(&lruvec->lru_lock);
+	while (!list_empty(list) && !need_resched() &&
+	       !spin_is_contended(&lruvec->lru_lock)) {
+		folio = lru_to_folio(list);
+		if (!folio_mapped(folio)) {
+			list_move(&folio->lru, &folios_skipped);
+			continue;
+		}
+
+		if (unlikely(!folio_try_get(folio))) {
+			list_move(&folio->lru, &folios_skipped);
+			continue;
+		}
+
+		if (!folio_test_clear_lru(folio)) {
+			list_move(&folio->lru, &folios_skipped);
+			folio_put(folio);
+			continue;
+		}
+
+		lruvec_del_folio(lruvec, folio);
+		list_add(&folio->lru, &folios_staged);
+		nr_staged += folio_nr_pages(folio);
+	}
+	list_splice(&folios_skipped, list);
+	spin_unlock_irq(&lruvec->lru_lock);
+
+	mod_lruvec_state(lruvec, isolated_idx, nr_staged);
+	mem_cgroup_start_move_charge(memcg);
+	while (!list_empty(&folios_staged)) {
+		folio = lru_to_folio(&folios_staged);
+		list_del(&folio->lru);
+
+		if (!folio_trylock(folio)) {
+			folio_putback_lru(folio);
+			continue;
+		}
+
+		if (folio_memcg_rmap_recharge(folio))
+			*nr_recharged += folio_nr_pages(folio);
+
+		folio_unlock(folio);
+		folio_putback_lru(folio);
+		cond_resched();
+	}
+	mem_cgroup_end_move_charge(memcg);
+	mod_lruvec_state(lruvec, isolated_idx, -nr_staged);
+	return false;
+}
+
+static void memcg_do_recharge_mapped_folios(struct work_struct *work)
+{
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct mem_cgroup *memcg = container_of(dwork, struct mem_cgroup,
+						recharge_mapped_work.dwork);
+	unsigned long nr_recharged = 0;
+	struct lruvec *lruvec;
+	int nid;
+
+	lru_add_drain_all();
+	for_each_node_state(nid, N_MEMORY) {
+		lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(nid));
+		lruvec_for_each_list(lruvec, memcg_recharge_lruvec_list,
+				     &nr_recharged);
+	}
+
+	/* Are we done with all mapped folios? */
+	if (!memcg_nr_local_mapped_pages(memcg))
+		return;
+
+	/* Did we make progress? reset retries */
+	if (nr_recharged > 0)
+		memcg->recharge_mapped_work.retries = 0;
+
+	/* Exponentially increase delay before each retry (from 1ms to ~32s) */
+	if (memcg->recharge_mapped_work.retries < MAX_RECLAIM_RETRIES)
+		queue_delayed_work(memcg_recharge_wq,
+				   &memcg->recharge_mapped_work.dwork,
+				   1 << memcg->recharge_mapped_work.retries++);
+}
+
+static void memcg_recharge_mapped_folios(struct mem_cgroup *memcg)
+{
+	/*
+	 * We need to initialize the work here, even if we are not going to
+	 * queue it, such that cancel_delayed_work_sync() in
+	 * mem_cgroup_css_free() does not complain.
+	 */
+	INIT_DELAYED_WORK(&memcg->recharge_mapped_work.dwork,
+			  memcg_do_recharge_mapped_folios);
+
+	if (memcg_recharge_wq && memcg_nr_local_mapped_pages(memcg)) {
+		memcg->recharge_mapped_work.retries = 0;
+		queue_delayed_work(memcg_recharge_wq,
+				   &memcg->recharge_mapped_work.dwork, 0);
+	}
+}
+
 #ifdef CONFIG_LRU_GEN
 static void mem_cgroup_attach(struct cgroup_taskset *tset)
 {
@@ -7904,3 +8124,13 @@ static int __init mem_cgroup_swap_init(void)
 subsys_initcall(mem_cgroup_swap_init);
 
 #endif /* CONFIG_SWAP */
+
+static int __init memcg_recharge_wq_init(void)
+{
+	if (mem_cgroup_disabled())
+		return 0;
+	memcg_recharge_wq = alloc_workqueue("memcg_recharge", WQ_UNBOUND, 0);
+	WARN_ON(!memcg_recharge_wq);
+	return 0;
+}
+subsys_initcall(memcg_recharge_wq_init);
-- 
2.41.0.255.g8b1d071c50-goog

