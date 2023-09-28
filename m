Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F827B102B
	for <lists+cgroups@lfdr.de>; Thu, 28 Sep 2023 02:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjI1A52 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Sep 2023 20:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjI1A51 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Sep 2023 20:57:27 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBACFF9;
        Wed, 27 Sep 2023 17:57:25 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c328b53aeaso110819045ad.2;
        Wed, 27 Sep 2023 17:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695862645; x=1696467445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+H70WFrHjMrC33zWeSocX4v9+VGzmilW73FM+FD2Vg=;
        b=PVpujigm5obT7Jn6PSh1oSML3KCpiIrLcPOU4mCOlPYtbW6XKEhCMELPx6Zda4pIZs
         txPT5vU1XXfAqLUTlHs4sJ8v+34QFY8rcFHDleBE80JeTXmWX1MUuAAjgTeLJxUj1y/d
         z+oMfQ8tZMwM94U4HYcCHQ8tmohFN/YjZrLm3Mku3AGHbB2Z/hx99QRSi7b/D4ktU2ed
         1ImJfHTZJBjZbGhI78ZreMHQNsdocJEFPybRnUdobFbQNkIxBhYmNi7IaJ9rSPUJ1jsn
         ZXrDZhZabAtYlMSsCz1GlaZ+Nt9lRTRXY0GweyrexIjPAZfapXKUnz2ejzGdNskQL5QM
         Fcxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695862645; x=1696467445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l+H70WFrHjMrC33zWeSocX4v9+VGzmilW73FM+FD2Vg=;
        b=SZL96va3deHdrzkA3PR9U+0UnEpEUmZ35bzMG9e5O5M6cTtXUZAmOjX2F6dZIE3e7z
         N1e98Bj/AlQfSS6rPDJQAN9RZo9llRVGtyfwF07ZBEy2Q/RcGsl/DeRQwqTuE3SDh+09
         zCBmmfUlvkQNXjkHo2p/IyEJ0hyF8aWbV91w50pGM+4gEjBn4fVB4qsJW69xDMqqcnar
         a1mzb2ZHP/4f8HOxtDEqsUIt5J07UfQInemg4zfGqH9kJ4xkHxctYMxbDP+wpjmPX8l1
         tJECL52v7xqQ/3q43dwvBPMlWn6tNM5jdYdoOEMXJ/q/UuhjafDMs9744UpUORALY3rX
         jvxQ==
X-Gm-Message-State: AOJu0YxzOJnHBHF4x8g6RCATKR3MCb/N4clPsjpp8Mm5mlNIORKLVxty
        NeWCgVdIh2cEK0iUgUOiUSE=
X-Google-Smtp-Source: AGHT+IEjRNoqzXKF5gkF19vMW7RkK619NLwy8fCyfUasNScpL0Etc6j3YwNDSSRZ9ZPXyjI3TILnCw==
X-Received: by 2002:a17:902:c409:b0:1c5:76b6:d94f with SMTP id k9-20020a170902c40900b001c576b6d94fmr4207589plk.31.1695862645217;
        Wed, 27 Sep 2023 17:57:25 -0700 (PDT)
Received: from localhost (fwdproxy-prn-117.fbsv.net. [2a03:2880:ff:75::face:b00c])
        by smtp.gmail.com with ESMTPSA id w4-20020a170902d3c400b001c737387810sm91937plb.31.2023.09.27.17.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 17:57:24 -0700 (PDT)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     riel@surriel.com, hannes@cmpxchg.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, mike.kravetz@oracle.com, yosryahmed@google.com,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [PATCH v2 1/2] hugetlb: memcg: account hugetlb-backed memory in memory controller
Date:   Wed, 27 Sep 2023 17:57:22 -0700
Message-Id: <20230928005723.1709119-2-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230928005723.1709119-1-nphamcs@gmail.com>
References: <20230928005723.1709119-1-nphamcs@gmail.com>
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

This patch rectifies this issue by charging the memcg when the hugetlb
folio is allocated, and uncharging when the folio is freed (analogous to
the hugetlb controller).

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  9 ++++++
 fs/hugetlbfs/inode.c                    |  2 +-
 include/linux/cgroup-defs.h             |  5 +++
 include/linux/hugetlb.h                 |  6 ++--
 include/linux/memcontrol.h              |  8 +++++
 kernel/cgroup/cgroup.c                  | 15 ++++++++-
 mm/hugetlb.c                            | 23 ++++++++++----
 mm/memcontrol.c                         | 41 +++++++++++++++++++++++++
 8 files changed, 99 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 622a7f28db1f..e6267b8cbd1d 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -210,6 +210,15 @@ cgroup v2 currently supports the following mount options.
         relying on the original semantics (e.g. specifying bogusly
         high 'bypass' protection values at higher tree levels).
 
+  memory_hugetlb_accounting
+        Count hugetlb memory usage towards the cgroup's overall
+        memory usage for the memory controller. This is a new behavior
+        that could regress existing setups, so it must be explicitly
+        opted in with this mount option. Note that hugetlb pages
+        allocated while this option is not selected will not be
+        tracked by the memory controller (even if cgroup v2 is
+        remounted later on).
+
 
 Organizing Processes and Threads
 --------------------------------
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 60fce26ff937..034967319955 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -902,7 +902,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 		 * to keep reservation accounting consistent.
 		 */
 		hugetlb_set_vma_policy(&pseudo_vma, inode, index);
-		folio = alloc_hugetlb_folio(&pseudo_vma, addr, 0);
+		folio = alloc_hugetlb_folio(&pseudo_vma, addr, 0, true);
 		hugetlb_drop_vma_policy(&pseudo_vma);
 		if (IS_ERR(folio)) {
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
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
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index a30686e649f7..9b73db1605a2 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -713,7 +713,8 @@ struct huge_bootmem_page {
 
 int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list);
 struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
-				unsigned long addr, int avoid_reserve);
+				unsigned long addr, int avoid_reserve,
+				bool restore_reserve_on_memcg_failure);
 struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
 				nodemask_t *nmask, gfp_t gfp_mask);
 struct folio *alloc_hugetlb_folio_vma(struct hstate *h, struct vm_area_struct *vma,
@@ -1016,7 +1017,8 @@ static inline int isolate_or_dissolve_huge_page(struct page *page,
 
 static inline struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 					   unsigned long addr,
-					   int avoid_reserve)
+					   int avoid_reserve,
+					   bool restore_reserve_on_memcg_failure)
 {
 	return NULL;
 }
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index e0cfab58ab71..8094679c99dd 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -677,6 +677,8 @@ static inline int mem_cgroup_charge(struct folio *folio, struct mm_struct *mm,
 	return __mem_cgroup_charge(folio, mm, gfp);
 }
 
+int mem_cgroup_hugetlb_charge_folio(struct folio *folio, gfp_t gfp);
+
 int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struct *mm,
 				  gfp_t gfp, swp_entry_t entry);
 void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry);
@@ -1251,6 +1253,12 @@ static inline int mem_cgroup_charge(struct folio *folio,
 	return 0;
 }
 
+static inline int mem_cgroup_hugetlb_charge_folio(struct folio *folio,
+		gfp_t gfp)
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
index de220e3ff8be..ff88ea4df11a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1902,6 +1902,7 @@ void free_huge_folio(struct folio *folio)
 				     pages_per_huge_page(h), folio);
 	hugetlb_cgroup_uncharge_folio_rsvd(hstate_index(h),
 					  pages_per_huge_page(h), folio);
+	mem_cgroup_uncharge(folio);
 	if (restore_reserve)
 		h->resv_huge_pages++;
 
@@ -3004,7 +3005,8 @@ int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list)
 }
 
 struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
-				    unsigned long addr, int avoid_reserve)
+					unsigned long addr, int avoid_reserve,
+					bool restore_reserve_on_memcg_failure)
 {
 	struct hugepage_subpool *spool = subpool_vma(vma);
 	struct hstate *h = hstate_vma(vma);
@@ -3119,6 +3121,15 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 			hugetlb_cgroup_uncharge_folio_rsvd(hstate_index(h),
 					pages_per_huge_page(h), folio);
 	}
+
+	/* undo allocation if memory controller disallows it. */
+	if (mem_cgroup_hugetlb_charge_folio(folio, GFP_KERNEL)) {
+		if (restore_reserve_on_memcg_failure)
+			restore_reserve_on_error(h, vma, addr, folio);
+		folio_put(folio);
+		return ERR_PTR(-ENOMEM);
+	}
+
 	return folio;
 
 out_uncharge_cgroup:
@@ -5179,7 +5190,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 				spin_unlock(src_ptl);
 				spin_unlock(dst_ptl);
 				/* Do not use reserve as it's private owned */
-				new_folio = alloc_hugetlb_folio(dst_vma, addr, 1);
+				new_folio = alloc_hugetlb_folio(dst_vma, addr, 1, false);
 				if (IS_ERR(new_folio)) {
 					folio_put(pte_folio);
 					ret = PTR_ERR(new_folio);
@@ -5656,7 +5667,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * be acquired again before returning to the caller, as expected.
 	 */
 	spin_unlock(ptl);
-	new_folio = alloc_hugetlb_folio(vma, haddr, outside_reserve);
+	new_folio = alloc_hugetlb_folio(vma, haddr, outside_reserve, true);
 
 	if (IS_ERR(new_folio)) {
 		/*
@@ -5930,7 +5941,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 							VM_UFFD_MISSING);
 		}
 
-		folio = alloc_hugetlb_folio(vma, haddr, 0);
+		folio = alloc_hugetlb_folio(vma, haddr, 0, true);
 		if (IS_ERR(folio)) {
 			/*
 			 * Returning error will result in faulting task being
@@ -6352,7 +6363,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 			goto out;
 		}
 
-		folio = alloc_hugetlb_folio(dst_vma, dst_addr, 0);
+		folio = alloc_hugetlb_folio(dst_vma, dst_addr, 0, true);
 		if (IS_ERR(folio)) {
 			ret = -ENOMEM;
 			goto out;
@@ -6394,7 +6405,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 			goto out;
 		}
 
-		folio = alloc_hugetlb_folio(dst_vma, dst_addr, 0);
+		folio = alloc_hugetlb_folio(dst_vma, dst_addr, 0, false);
 		if (IS_ERR(folio)) {
 			folio_put(*foliop);
 			ret = -ENOMEM;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d1a322a75172..d5dfc9b36acb 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7050,6 +7050,47 @@ int __mem_cgroup_charge(struct folio *folio, struct mm_struct *mm, gfp_t gfp)
 	return ret;
 }
 
+static struct mem_cgroup *get_mem_cgroup_from_current(void)
+{
+	struct mem_cgroup *memcg;
+
+again:
+	rcu_read_lock();
+	memcg = mem_cgroup_from_task(current);
+	if (!css_tryget(&memcg->css)) {
+		rcu_read_unlock();
+		goto again;
+	}
+	rcu_read_unlock();
+	return memcg;
+}
+
+/**
+ * mem_cgroup_hugetlb_charge_folio - Charge a newly allocated hugetlb folio.
+ * @folio: folio to charge.
+ * @gfp: reclaim mode
+ *
+ * This function charges an allocated hugetlbf folio to the memcg of the
+ * current task.
+ *
+ * Returns 0 on success. Otherwise, an error code is returned.
+ */
+int mem_cgroup_hugetlb_charge_folio(struct folio *folio, gfp_t gfp)
+{
+	struct mem_cgroup *memcg;
+	int ret;
+
+	if (mem_cgroup_disabled() ||
+		!(cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING))
+		return 0;
+
+	memcg = get_mem_cgroup_from_current();
+	ret = charge_memcg(folio, memcg, gfp);
+	mem_cgroup_put(memcg);
+
+	return ret;
+}
+
 /**
  * mem_cgroup_swapin_charge_folio - Charge a newly allocated folio for swapin.
  * @folio: folio to charge.
-- 
2.34.1
