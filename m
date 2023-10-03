Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5267B5E0E
	for <lists+cgroups@lfdr.de>; Tue,  3 Oct 2023 02:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238011AbjJCASj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Oct 2023 20:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjJCASh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Oct 2023 20:18:37 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51E8D9;
        Mon,  2 Oct 2023 17:18:32 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d849df4f1ffso415435276.0;
        Mon, 02 Oct 2023 17:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696292312; x=1696897112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ljlf1C6cemVWRMa2u3+4If4eJjY7Mwf2KpBD+q2vND4=;
        b=Qd9Lb1nMBb4p3Ne3gUFH8y8dVfy8TWS+ndruxX+pZ6r6kqNTR2vEq83q37xfTt6Dgf
         /zuhaICe76pmnlA5JjQ1coatQ9wMR9uDsUAw927bNwbara7ejeBFKJQ+5O2CVbcMicZ7
         gWmtKa/kw5JCIBSoDVVs7/Qy0On8qtjPohNugguAdCjbqUoc78rZNJ0v4wVhpxP+8huj
         pI/z/rSeawo3E7aX0sbTIbt+rHTJP0uSdSEz1wBbeSS3MtwzmV+1+eNXn6zS23EX7bbr
         eEr0ocfghMQvYcDSPz7pZSSwMAZLrFG+SsbRj8N8scQgTLurS3sO4XKm9K4Hx7HoWaL5
         8upQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696292312; x=1696897112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ljlf1C6cemVWRMa2u3+4If4eJjY7Mwf2KpBD+q2vND4=;
        b=OHD59Y6R5W7SjsackAlJcL2/kjJ9/YeZpuggnzNl/nR2Ash+6TTmetVvhZcOlk/RS7
         p1Q6t5wezz88Xu1f/wGInOG0+3XdDAW6C29rG6/PqY3jLhjaqdWM8OumqBlg5vZ88Zy3
         TLlYLIDTQCF1hctvozC9M11twgG26n1RTQavyqoAPmuu4W2egE3+/HoZ7vGXGdCZx2sI
         fg3eNOCqIphKHAaWbI9ezKyXpWLEv1kRZRqx0Q9eI5WAx92Zw7KFC4HsUwEV99JIaPmh
         zyyGR79f3DXVrvNdRW3abPCT6JfuoUX/eN60I2XpZJLZk5B6j6eFTQW3aVzyrUleeqBm
         r7Xw==
X-Gm-Message-State: AOJu0YzFcQDYmqvcbQN4P5nbSuFY2DuE3CcOY/WJxCFIanSmovyF/lPx
        yLPSC3U+I995B4r8lS0qmOM=
X-Google-Smtp-Source: AGHT+IHKZ2t5Y+qhgEWn4ftJqbQ0/DCHUPMUTJhv+VodPGYm/UEFAikE60ER66YrSWH+pyTsNpZdDw==
X-Received: by 2002:a0d:f146:0:b0:589:fad6:c17c with SMTP id a67-20020a0df146000000b00589fad6c17cmr13490093ywf.45.1696292311958;
        Mon, 02 Oct 2023 17:18:31 -0700 (PDT)
Received: from localhost (fwdproxy-prn-015.fbsv.net. [2a03:2880:ff:f::face:b00c])
        by smtp.gmail.com with ESMTPSA id a15-20020a17090a70cf00b00276bde3b8cesm6793326pjm.15.2023.10.02.17.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 17:18:31 -0700 (PDT)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     riel@surriel.com, hannes@cmpxchg.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, mike.kravetz@oracle.com, yosryahmed@google.com,
        fvdl@google.com, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [PATCH v3 2/3] hugetlb: memcg: account hugetlb-backed memory in memory controller
Date:   Mon,  2 Oct 2023 17:18:27 -0700
Message-Id: <20231003001828.2554080-3-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003001828.2554080-1-nphamcs@gmail.com>
References: <20231003001828.2554080-1-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Currently, hugetlb memory usage is not acounted for in the memory
controller, which could lead to memory overprotection for cgroups with
hugetlb-backed memory. This has been observed in our production system.

For instance, here is one of our usecases: suppose there are two 32G
containers. The machine is booted with hugetlb_cma=6G, and each
container may or may not use up to 3 gigantic page, depending on the
workload within it. The rest is anon, cache, slab, etc. We can set the
hugetlb cgroup limit of each cgroup to 3G to enforce hugetlb fairness.
But it is very difficult to configure memory.max to keep overall
consumption, including anon, cache, slab etc. fair.

What we have had to resort to is to constantly poll hugetlb usage and
readjust memory.max. Similar procedure is done to other memory limits
(memory.low for e.g). However, this is rather cumbersome and buggy.
Furthermore, when there is a delay in memory limits correction, (for e.g
when hugetlb usage changes within consecutive runs of the userspace
agent), the system could be in an over/underprotected state.

This patch rectifies this issue by charging the memcg when the hugetlb
folio is utilized, and uncharging when the folio is freed (analogous to
the hugetlb controller). Note that we do not charge when the folio is
allocated to the hugetlb pool, because at this point it is not owned by
any memcg.

Some caveats to consider:
  * This feature is only available on cgroup v2.
  * There is no hugetlb pool management involved in the memory
    controller. As stated above, hugetlb folios are only charged towards
    the memory controller when it is used. Host overcommit management
    has to consider it when configuring hard limits.
  * Failure to charge towards the memcg results in SIGBUS. This could
    happen even if the hugetlb pool still has pages (but the cgroup
    limit is hit and reclaim attempt fails).
  * When this feature is enabled, hugetlb pages contribute to memory
    reclaim protection. low, min limits tuning must take into account
    hugetlb memory.
  * Hugetlb pages utilized while this option is not selected will not
    be tracked by the memory controller (even if cgroup v2 is remounted
    later on).

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 29 ++++++++++++++++++++
 include/linux/cgroup-defs.h             |  5 ++++
 include/linux/memcontrol.h              |  9 +++++++
 kernel/cgroup/cgroup.c                  | 15 ++++++++++-
 mm/hugetlb.c                            | 35 ++++++++++++++++++++-----
 mm/memcontrol.c                         | 35 +++++++++++++++++++++++++
 6 files changed, 120 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 622a7f28db1f..606b2e0eac4b 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -210,6 +210,35 @@ cgroup v2 currently supports the following mount options.
         relying on the original semantics (e.g. specifying bogusly
         high 'bypass' protection values at higher tree levels).
 
+  memory_hugetlb_accounting
+        Count HugeTLB memory usage towards the cgroup's overall
+        memory usage for the memory controller (for the purpose of
+        statistics reporting and memory protetion). This is a new
+        behavior that could regress existing setups, so it must be
+        explicitly opted in with this mount option.
+
+        A few caveats to keep in mind:
+
+        * There is no HugeTLB pool management involved in the memory
+          controller. The pre-allocated pool does not belong to anyone.
+          Specifically, when a new HugeTLB folio is allocated to
+          the pool, it is not accounted for from the perspective of the
+          memory controller. It is only charged to a cgroup when it is
+          actually used (for e.g at page fault time). Host memory
+          overcommit management has to consider this when configuring
+          hard limits. In general, HugeTLB pool management should be
+          done via other mechanisms (such as the HugeTLB controller).
+        * Failure to charge a HugeTLB folio to the memory controller
+          results in SIGBUS. This could happen even if the HugeTLB pool
+          still has pages available (but the cgroup limit is hit and
+          reclaim attempt fails).
+        * Charging HugeTLB memory towards the memory controller affects
+          memory protection and reclaim dynamics. Any userspace tuning
+          (of low, min limits for e.g) needs to take this into account.
+        * HugeTLB pages utilized while this option is not selected
+          will not be tracked by the memory controller (even if cgroup
+          v2 is remounted later on).
+
 
 Organizing Processes and Threads
 --------------------------------
diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index f1b3151ac30b..8641f4320c98 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -115,6 +115,11 @@ enum {
 	 * Enable recursive subtree protection
 	 */
 	CGRP_ROOT_MEMORY_RECURSIVE_PROT = (1 << 18),
+
+	/*
+	 * Enable hugetlb accounting for the memory controller.
+	 */
+	 CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING = (1 << 19),
 };
 
 /* cftype->flags */
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 42bf7e9b1a2f..a827e2129790 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -679,6 +679,9 @@ static inline int mem_cgroup_charge(struct folio *folio, struct mm_struct *mm,
 	return __mem_cgroup_charge(folio, mm, gfp);
 }
 
+int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg, gfp_t gfp,
+		long nr_pages);
+
 int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struct *mm,
 				  gfp_t gfp, swp_entry_t entry);
 void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry);
@@ -1262,6 +1265,12 @@ static inline int mem_cgroup_charge(struct folio *folio,
 	return 0;
 }
 
+static inline int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg,
+		gfp_t gfp, long nr_pages)
+{
+	return 0;
+}
+
 static inline int mem_cgroup_swapin_charge_folio(struct folio *folio,
 			struct mm_struct *mm, gfp_t gfp, swp_entry_t entry)
 {
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 1fb7f562289d..f11488b18ceb 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1902,6 +1902,7 @@ enum cgroup2_param {
 	Opt_favordynmods,
 	Opt_memory_localevents,
 	Opt_memory_recursiveprot,
+	Opt_memory_hugetlb_accounting,
 	nr__cgroup2_params
 };
 
@@ -1910,6 +1911,7 @@ static const struct fs_parameter_spec cgroup2_fs_parameters[] = {
 	fsparam_flag("favordynmods",		Opt_favordynmods),
 	fsparam_flag("memory_localevents",	Opt_memory_localevents),
 	fsparam_flag("memory_recursiveprot",	Opt_memory_recursiveprot),
+	fsparam_flag("memory_hugetlb_accounting", Opt_memory_hugetlb_accounting),
 	{}
 };
 
@@ -1936,6 +1938,9 @@ static int cgroup2_parse_param(struct fs_context *fc, struct fs_parameter *param
 	case Opt_memory_recursiveprot:
 		ctx->flags |= CGRP_ROOT_MEMORY_RECURSIVE_PROT;
 		return 0;
+	case Opt_memory_hugetlb_accounting:
+		ctx->flags |= CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING;
+		return 0;
 	}
 	return -EINVAL;
 }
@@ -1960,6 +1965,11 @@ static void apply_cgroup_root_flags(unsigned int root_flags)
 			cgrp_dfl_root.flags |= CGRP_ROOT_MEMORY_RECURSIVE_PROT;
 		else
 			cgrp_dfl_root.flags &= ~CGRP_ROOT_MEMORY_RECURSIVE_PROT;
+
+		if (root_flags & CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING)
+			cgrp_dfl_root.flags |= CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING;
+		else
+			cgrp_dfl_root.flags &= ~CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING;
 	}
 }
 
@@ -1973,6 +1983,8 @@ static int cgroup_show_options(struct seq_file *seq, struct kernfs_root *kf_root
 		seq_puts(seq, ",memory_localevents");
 	if (cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_RECURSIVE_PROT)
 		seq_puts(seq, ",memory_recursiveprot");
+	if (cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING)
+		seq_puts(seq, ",memory_hugetlb_accounting");
 	return 0;
 }
 
@@ -7050,7 +7062,8 @@ static ssize_t features_show(struct kobject *kobj, struct kobj_attribute *attr,
 			"nsdelegate\n"
 			"favordynmods\n"
 			"memory_localevents\n"
-			"memory_recursiveprot\n");
+			"memory_recursiveprot\n"
+			"memory_hugetlb_accounting\n");
 }
 static struct kobj_attribute cgroup_features_attr = __ATTR_RO(features);
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index de220e3ff8be..74472e911b0a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1902,6 +1902,7 @@ void free_huge_folio(struct folio *folio)
 				     pages_per_huge_page(h), folio);
 	hugetlb_cgroup_uncharge_folio_rsvd(hstate_index(h),
 					  pages_per_huge_page(h), folio);
+	mem_cgroup_uncharge(folio);
 	if (restore_reserve)
 		h->resv_huge_pages++;
 
@@ -3009,11 +3010,20 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 	struct hugepage_subpool *spool = subpool_vma(vma);
 	struct hstate *h = hstate_vma(vma);
 	struct folio *folio;
-	long map_chg, map_commit;
+	long map_chg, map_commit, nr_pages = pages_per_huge_page(h);
 	long gbl_chg;
-	int ret, idx;
+	int memcg_charge_ret, ret, idx;
 	struct hugetlb_cgroup *h_cg = NULL;
+	struct mem_cgroup *memcg;
 	bool deferred_reserve;
+	gfp_t gfp = htlb_alloc_mask(h) | __GFP_RETRY_MAYFAIL;
+
+	memcg = get_mem_cgroup_from_current();
+	memcg_charge_ret = mem_cgroup_hugetlb_try_charge(memcg, gfp, nr_pages);
+	if (memcg_charge_ret == -ENOMEM) {
+		mem_cgroup_put(memcg);
+		return ERR_PTR(-ENOMEM);
+	}
 
 	idx = hstate_index(h);
 	/*
@@ -3022,8 +3032,12 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 	 * code of zero indicates a reservation exists (no change).
 	 */
 	map_chg = gbl_chg = vma_needs_reservation(h, vma, addr);
-	if (map_chg < 0)
+	if (map_chg < 0) {
+		if (!memcg_charge_ret)
+			mem_cgroup_cancel_charge(memcg, nr_pages);
+		mem_cgroup_put(memcg);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	/*
 	 * Processes that did not create the mapping will have no
@@ -3034,10 +3048,8 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 	 */
 	if (map_chg || avoid_reserve) {
 		gbl_chg = hugepage_subpool_get_pages(spool, 1);
-		if (gbl_chg < 0) {
-			vma_end_reservation(h, vma, addr);
-			return ERR_PTR(-ENOSPC);
-		}
+		if (gbl_chg < 0)
+			goto out_end_reservation;
 
 		/*
 		 * Even though there was no reservation in the region/reserve
@@ -3119,6 +3131,11 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 			hugetlb_cgroup_uncharge_folio_rsvd(hstate_index(h),
 					pages_per_huge_page(h), folio);
 	}
+
+	if (!memcg_charge_ret)
+		mem_cgroup_commit_charge(folio, memcg);
+	mem_cgroup_put(memcg);
+
 	return folio;
 
 out_uncharge_cgroup:
@@ -3130,7 +3147,11 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 out_subpool_put:
 	if (map_chg || avoid_reserve)
 		hugepage_subpool_put_pages(spool, 1);
+out_end_reservation:
 	vma_end_reservation(h, vma, addr);
+	if (!memcg_charge_ret)
+		mem_cgroup_cancel_charge(memcg, nr_pages);
+	mem_cgroup_put(memcg);
 	return ERR_PTR(-ENOSPC);
 }
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 0219befeae38..6660684f6f97 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7085,6 +7085,41 @@ int __mem_cgroup_charge(struct folio *folio, struct mm_struct *mm, gfp_t gfp)
 	return ret;
 }
 
+/**
+ * mem_cgroup_hugetlb_try_charge - try to charge the memcg for a hugetlb folio
+ * @memcg: memcg to charge.
+ * @gfp: reclaim mode.
+ * @nr_pages: number of pages to charge.
+ *
+ * This function is called when allocating a huge page folio to determine if
+ * the memcg has the capacity for it. It does not commit the charge yet,
+ * as the hugetlb folio itself has not been obtained from the hugetlb pool.
+ *
+ * Once we have obtained the hugetlb folio, we can call
+ * mem_cgroup_commit_charge() to commit the charge. If we fail to obtain the
+ * folio, we should instead call mem_cgroup_cancel_charge() to undo the effect
+ * of try_charge().
+ *
+ * Returns 0 on success. Otherwise, an error code is returned.
+ */
+int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg, gfp_t gfp,
+			long nr_pages)
+{
+	/*
+	 * If hugetlb memcg charging is not enabled, do not fail hugetlb allocation,
+	 * but do not attempt to commit charge later (or cancel on error) either.
+	 */
+	if (mem_cgroup_disabled() || !memcg ||
+		!cgroup_subsys_on_dfl(memory_cgrp_subsys) ||
+		!(cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING))
+		return -EOPNOTSUPP;
+
+	if (try_charge(memcg, gfp, nr_pages))
+		return -ENOMEM;
+
+	return 0;
+}
+
 /**
  * mem_cgroup_swapin_charge_folio - Charge a newly allocated folio for swapin.
  * @folio: folio to charge.
-- 
2.34.1
