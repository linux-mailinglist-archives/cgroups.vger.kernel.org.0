Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399AA7BBEE9
	for <lists+cgroups@lfdr.de>; Fri,  6 Oct 2023 20:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbjJFSqo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 6 Oct 2023 14:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233268AbjJFSqm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 6 Oct 2023 14:46:42 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA2CC5;
        Fri,  6 Oct 2023 11:46:35 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c5bf7871dcso20584005ad.1;
        Fri, 06 Oct 2023 11:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696617995; x=1697222795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S8WFxmGmo8Wm2uPAMHU1NgqFhq3Wq2AWhdy0gUN56bU=;
        b=m0fRJiSMC/GW4gnnIkjS2qEw0WweRetaH1KBGS4nSALS6mhCRVYqfgXJrSvzF77NYn
         M7F1IVw4V2nOj7GXLTUmZ9T0VzhjOLPgjFxulp6hBz3X/qzpFj2Q0aSyoEGzWYgnUBsp
         s6uXASzgU4Ohe4zBnXyb6i3MGkHU20QathciVF1nrDsKQNJ8OLZtfHCYNZ8Ee+grHPyQ
         n23qH6z3x7phHSgZqcoug8DHEDSIPLue+K7uiapSIytbCwF49+vSZP0zbc9zEfkkPIkN
         0IfBGSzO8OSj1Y6OJ4II7kCarQuDpHiJLUUvyuc1Ejnk/65fboUEGp2n+IVIqZKotv6a
         0gCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696617995; x=1697222795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S8WFxmGmo8Wm2uPAMHU1NgqFhq3Wq2AWhdy0gUN56bU=;
        b=b250ldXcYg50gH2WfrfYNZbL2GzcYZO43DuyPvSSYZ9oWdnMzdZeNvVWwCw40/8D/j
         HrZplf3kRplPFaQN3sD9aD5/4QdA1k/xEEX34g+QcgGobRrA/g65DfPNUE5OyfYO1UIP
         tm7rab2dceHoY3+GLgfEs94vRYID8+zlN65fBtkspwV2C24YI2ADXCxxudrXPqNNR/xN
         KeU8QNuEp1Uf/ccBd+vE7dgEsu0ZkYl+KxnWWx1TBuTMTHIShjGhIbh1VC73kKnbX84R
         aZuM3K8yGZjwd8jS9Uk4zunbKZ0vYMQSyBrEtPUnhza29TlVQF/40C4KOZJzyGGbOWIA
         /g8g==
X-Gm-Message-State: AOJu0YwFhMqh7h02oKm8f/ssO/gs8XN6+a55soOtCWSD7mTsAhTB1OMY
        Q4GXQfYBPOcqLUB8r/+9VRQ=
X-Google-Smtp-Source: AGHT+IFxR6wHAD2nVbIRv2FkwmdHHCgfiwmUD4DnTGWC/ogkLmz36RVmuDPIhydPU2RqgCuhvYX+eQ==
X-Received: by 2002:a17:903:228a:b0:1c3:2423:8e24 with SMTP id b10-20020a170903228a00b001c324238e24mr11013936plh.8.1696617994752;
        Fri, 06 Oct 2023 11:46:34 -0700 (PDT)
Received: from localhost (fwdproxy-prn-118.fbsv.net. [2a03:2880:ff:76::face:b00c])
        by smtp.gmail.com with ESMTPSA id ja18-20020a170902efd200b001bb750189desm4263819plb.255.2023.10.06.11.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 11:46:34 -0700 (PDT)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     riel@surriel.com, hannes@cmpxchg.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, mike.kravetz@oracle.com, yosryahmed@google.com,
        fvdl@google.com, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [PATCH v4 3/4] hugetlb: memcg: account hugetlb-backed memory in memory controller
Date:   Fri,  6 Oct 2023 11:46:28 -0700
Message-Id: <20231006184629.155543-4-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006184629.155543-1-nphamcs@gmail.com>
References: <20231006184629.155543-1-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 Documentation/admin-guide/cgroup-v2.rst | 29 +++++++++++++++++
 include/linux/cgroup-defs.h             |  5 +++
 include/linux/memcontrol.h              |  9 ++++++
 kernel/cgroup/cgroup.c                  | 15 ++++++++-
 mm/hugetlb.c                            | 35 ++++++++++++++++-----
 mm/memcontrol.c                         | 42 ++++++++++++++++++++++++-
 mm/migrate.c                            |  3 +-
 7 files changed, 127 insertions(+), 11 deletions(-)

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
index 5daf14da3759..e3eaa123256b 100644
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
@@ -1264,6 +1267,12 @@ static inline int mem_cgroup_charge(struct folio *folio,
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
index b9c479d768e2..a3adfecf5977 100644
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
@@ -7354,7 +7389,12 @@ void mem_cgroup_migrate(struct folio *old, struct folio *new)
 		return;
 
 	memcg = folio_memcg(old);
-	VM_WARN_ON_ONCE_FOLIO(!memcg, old);
+	/*
+	 * Note that it is normal to see !memcg for a hugetlb folio.
+	 * For e.g, itt could have been allocated when memory_hugetlb_accounting
+	 * was not selected.
+	 */
+	VM_WARN_ON_ONCE_FOLIO(!folio_test_hugetlb(old) && !memcg, old);
 	if (!memcg)
 		return;
 
diff --git a/mm/migrate.c b/mm/migrate.c
index 7d1804c4a5d9..6034c7ed1d65 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -633,8 +633,7 @@ void folio_migrate_flags(struct folio *newfolio, struct folio *folio)
 
 	folio_copy_owner(newfolio, folio);
 
-	if (!folio_test_hugetlb(folio))
-		mem_cgroup_migrate(folio, newfolio);
+	mem_cgroup_migrate(folio, newfolio);
 }
 EXPORT_SYMBOL(folio_migrate_flags);
 
-- 
2.34.1
