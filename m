Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126277AF467
	for <lists+cgroups@lfdr.de>; Tue, 26 Sep 2023 21:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234554AbjIZTt7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 26 Sep 2023 15:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234553AbjIZTt6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 26 Sep 2023 15:49:58 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF6EC0;
        Tue, 26 Sep 2023 12:49:51 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-277336b8717so3835206a91.2;
        Tue, 26 Sep 2023 12:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695757791; x=1696362591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHPSbE4HFUhSHC8JococnD2WCCrSSr2Zh6a3tHWORhg=;
        b=dnWxv+VasCA/ZeHubV+rrplQP+4dnMJ0wV/8H/UhWbBSKisN4EYiNSd/jWNiXJm0Fv
         Z6XH0pL3WNj6iHvGV25A0PnaawJm2UFiQxcI83ekTFUIAFkWDceQGuATqolzxpcrrcsK
         f5HMFx6KWWfy9yWuhTY6jzfp42fv+Q2yafjBdCC2MlzAn0IolPLyI5MJs9nPIK3Rb0Xg
         xLKRowX3ij6+4E//RG+1tJ1ZvGy/Lt4BHwpbj/lA2EzgKKpHAb0ml8c02lLNEKTEg4uc
         a6/NoT8LWAyWuTLQR3QMPF8AUblDMfndRf8jMyNR5mjt7vZ4fQ6Su6pd7bPdRNPCQVOA
         fMVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695757791; x=1696362591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DHPSbE4HFUhSHC8JococnD2WCCrSSr2Zh6a3tHWORhg=;
        b=G1f7oouhxh2UMPv7s7NHNTuiB0IaF5bATUhdTMzStSaq35WjaQy1jyWeF3s4rggBVZ
         hQ4t1n4VRICLE+9BwVitfm1DjUkbfuFV+/H/X6WXtpirA8A8FPzPSULC6rxS3GbjafVN
         1bNk+3tJiTL7egQB/W65vA2gyhnnUtrQeCC9Zg6ElcX3IeUuNJ0+MzYI+n9jCpbGxf65
         ZqNFV200uYbND47Sz8Ooin3zbkXwM8d1XgiCBrXI2IEh2OiQraxkA2zx0Mecjtuw+7q9
         yDd20QqzFtUFRNPtlKdcsEOSC30Dbh+cFTOdMcjfs3CuRp9dnD2d+0CoqKhwsIhzkTXF
         v0rA==
X-Gm-Message-State: AOJu0YxMg/50aFtcQwC2sOWsmU9Sr1OlUFDVZFPWuiSJNnXykuSoFxae
        ELFfk6urr+Yr3M7M6qBkG7Q=
X-Google-Smtp-Source: AGHT+IGFISuCv1SNjWDXqxDghs9FzB/KYM3zP0VlR0ZfNQk/UyoPEf7j5pzM+YuwubCahPcTSwtbWw==
X-Received: by 2002:a17:90b:128a:b0:271:9c5f:fc42 with SMTP id fw10-20020a17090b128a00b002719c5ffc42mr8383608pjb.31.1695757791100;
        Tue, 26 Sep 2023 12:49:51 -0700 (PDT)
Received: from localhost (fwdproxy-prn-006.fbsv.net. [2a03:2880:ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id 25-20020a17090a031900b00274bbfc34c8sm13212320pje.16.2023.09.26.12.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 12:49:50 -0700 (PDT)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     riel@surriel.com, hannes@cmpxchg.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, mike.kravetz@oracle.com, yosryahmed@google.com,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [PATCH 1/2] hugetlb: memcg: account hugetlb-backed memory in memory controller
Date:   Tue, 26 Sep 2023 12:49:48 -0700
Message-Id: <20230926194949.2637078-2-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230926194949.2637078-1-nphamcs@gmail.com>
References: <20230926194949.2637078-1-nphamcs@gmail.com>
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
 fs/hugetlbfs/inode.c       |  2 +-
 include/linux/hugetlb.h    |  6 ++++--
 include/linux/memcontrol.h |  8 ++++++++
 mm/hugetlb.c               | 23 ++++++++++++++++------
 mm/memcontrol.c            | 40 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 70 insertions(+), 9 deletions(-)

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
index d1a322a75172..e7ae63f14120 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7050,6 +7050,46 @@ int __mem_cgroup_charge(struct folio *folio, struct mm_struct *mm, gfp_t gfp)
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
+	if (mem_cgroup_disabled())
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

