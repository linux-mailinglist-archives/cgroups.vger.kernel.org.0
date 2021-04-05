Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25909354694
	for <lists+cgroups@lfdr.de>; Mon,  5 Apr 2021 20:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbhDESJL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 5 Apr 2021 14:09:11 -0400
Received: from mga09.intel.com ([134.134.136.24]:44452 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233511AbhDESJI (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 5 Apr 2021 14:09:08 -0400
IronPort-SDR: cwD7toYL4dtaJQokFDKL2XE44sWNGrpIeZL93XWFQOqfBL2O8rc+gvg1K90fpTfSVHIvBZi5KL
 zxl77F+z1zZA==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="193010914"
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="193010914"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 11:09:02 -0700
IronPort-SDR: qgI1AWasyGMiSQyPd1dlw+IO/g4dA+Sz56r88lb4ZjpUINjjsmOf13+aHJTagLpbV3IOggN1qe
 nqvLqza+TQBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="448153892"
Received: from skl-02.jf.intel.com ([10.54.74.28])
  by fmsmga002.fm.intel.com with ESMTP; 05 Apr 2021 11:09:01 -0700
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Michal Hocko <mhocko@suse.cz>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Ying Huang <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 03/11] mm: Account the top tier memory usage per cgroup
Date:   Mon,  5 Apr 2021 10:08:27 -0700
Message-Id: <b61bd640e02109c84eb5c430a00d8d75ecd6b284.1617642417.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617642417.git.tim.c.chen@linux.intel.com>
References: <cover.1617642417.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

For each memory cgroup, account its usage of the
top tier memory at the time a top tier page is assigned and
uncharged from the cgroup.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 include/linux/memcontrol.h |  1 +
 mm/memcontrol.c            | 39 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 25d8b9acec7c..609d8590950c 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -225,6 +225,7 @@ struct mem_cgroup {
 	/* Legacy consumer-oriented counters */
 	struct page_counter kmem;		/* v1 only */
 	struct page_counter tcpmem;		/* v1 only */
+	struct page_counter toptier;
 
 	/* Range enforcement for interrupt charges */
 	struct work_struct high_work;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 9a9d677a6654..fe7bb8613f5a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -253,6 +253,13 @@ struct cgroup_subsys_state *vmpressure_to_css(struct vmpressure *vmpr)
 	return &container_of(vmpr, struct mem_cgroup, vmpressure)->css;
 }
 
+static inline bool top_tier(struct page *page)
+{
+	int nid = page_to_nid(page);
+
+	return node_state(nid, N_TOPTIER);
+}
+
 #ifdef CONFIG_MEMCG_KMEM
 extern spinlock_t css_set_lock;
 
@@ -951,6 +958,23 @@ static void mem_cgroup_charge_statistics(struct mem_cgroup *memcg,
 	__this_cpu_add(memcg->vmstats_percpu->nr_page_events, nr_pages);
 }
 
+static inline void mem_cgroup_charge_toptier(struct mem_cgroup *memcg,
+					 struct page *page,
+					 int nr_pages)
+{
+	if (!top_tier(page))
+		return;
+
+	if (nr_pages >= 0)
+		page_counter_charge(&memcg->toptier,
+				   (unsigned long) nr_pages);
+	else {
+		nr_pages = -nr_pages;
+		page_counter_uncharge(&memcg->toptier,
+				   (unsigned long) nr_pages);
+	}
+}
+
 static bool mem_cgroup_event_ratelimit(struct mem_cgroup *memcg,
 				       enum mem_cgroup_events_target target)
 {
@@ -2932,6 +2956,7 @@ static void commit_charge(struct page *page, struct mem_cgroup *memcg)
 	 * - exclusive reference
 	 */
 	page->memcg_data = (unsigned long)memcg;
+	mem_cgroup_charge_toptier(memcg, page, thp_nr_pages(page));
 }
 
 #ifdef CONFIG_MEMCG_KMEM
@@ -3138,6 +3163,7 @@ int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order)
 		if (!ret) {
 			page->memcg_data = (unsigned long)memcg |
 				MEMCG_DATA_KMEM;
+			mem_cgroup_charge_toptier(memcg, page, 1 << order);
 			return 0;
 		}
 		css_put(&memcg->css);
@@ -3161,6 +3187,7 @@ void __memcg_kmem_uncharge_page(struct page *page, int order)
 	VM_BUG_ON_PAGE(mem_cgroup_is_root(memcg), page);
 	__memcg_kmem_uncharge(memcg, nr_pages);
 	page->memcg_data = 0;
+	mem_cgroup_charge_toptier(memcg, page, -nr_pages);
 	css_put(&memcg->css);
 }
 
@@ -5389,11 +5416,13 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 
 		page_counter_init(&memcg->memory, &parent->memory);
 		page_counter_init(&memcg->swap, &parent->swap);
+		page_counter_init(&memcg->toptier, &parent->toptier);
 		page_counter_init(&memcg->kmem, &parent->kmem);
 		page_counter_init(&memcg->tcpmem, &parent->tcpmem);
 	} else {
 		page_counter_init(&memcg->memory, NULL);
 		page_counter_init(&memcg->swap, NULL);
+		page_counter_init(&memcg->toptier, NULL);
 		page_counter_init(&memcg->kmem, NULL);
 		page_counter_init(&memcg->tcpmem, NULL);
 
@@ -5745,6 +5774,8 @@ static int mem_cgroup_move_account(struct page *page,
 	css_put(&from->css);
 
 	page->memcg_data = (unsigned long)to;
+	mem_cgroup_charge_toptier(to, page, nr_pages);
+	mem_cgroup_charge_toptier(from, page, -nr_pages);
 
 	__unlock_page_memcg(from);
 
@@ -6832,6 +6863,7 @@ struct uncharge_gather {
 	unsigned long nr_pages;
 	unsigned long pgpgout;
 	unsigned long nr_kmem;
+	unsigned long nr_toptier;
 	struct page *dummy_page;
 };
 
@@ -6846,6 +6878,7 @@ static void uncharge_batch(const struct uncharge_gather *ug)
 
 	if (!mem_cgroup_is_root(ug->memcg)) {
 		page_counter_uncharge(&ug->memcg->memory, ug->nr_pages);
+		page_counter_uncharge(&ug->memcg->toptier, ug->nr_toptier);
 		if (do_memsw_account())
 			page_counter_uncharge(&ug->memcg->memsw, ug->nr_pages);
 		if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && ug->nr_kmem)
@@ -6891,6 +6924,8 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
 
 	nr_pages = compound_nr(page);
 	ug->nr_pages += nr_pages;
+	if (top_tier(page))
+		ug->nr_toptier += nr_pages;
 
 	if (PageMemcgKmem(page))
 		ug->nr_kmem += nr_pages;
@@ -7216,8 +7251,10 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
 
 	page->memcg_data = 0;
 
-	if (!mem_cgroup_is_root(memcg))
+	if (!mem_cgroup_is_root(memcg)) {
 		page_counter_uncharge(&memcg->memory, nr_entries);
+		mem_cgroup_charge_toptier(memcg, page, -nr_entries);
+	}
 
 	if (!cgroup_memory_noswap && memcg != swap_memcg) {
 		if (!mem_cgroup_is_root(swap_memcg))
-- 
2.20.1

