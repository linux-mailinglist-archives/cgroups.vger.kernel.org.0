Return-Path: <cgroups+bounces-5459-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB769BF90A
	for <lists+cgroups@lfdr.de>; Wed,  6 Nov 2024 23:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 797F71F2111A
	for <lists+cgroups@lfdr.de>; Wed,  6 Nov 2024 22:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32E020EA47;
	Wed,  6 Nov 2024 22:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWGIheHp"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BBE20D4F3;
	Wed,  6 Nov 2024 22:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730931280; cv=none; b=Egl1ZrC7GODgTaxwUNTmbNH/iupwCX8dGybvm/tWfJM3fTGmjSjnUK7k4Je1dSsRmm4rnJwtDJuIhOG0xPhfpsHMFBJKzRsL519Qq6e/2PChJMoEacgDbE7EWbfihvRAuYz1+T9m0MlpO9JEQMMXrKyIRvY90kKRZ2vF80ZAup4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730931280; c=relaxed/simple;
	bh=P1kC+Hm8/7dfYqrVrlPWMXBDsQUXhTRhj5IWs/wkmK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hRNc0I2ZMMfCkTiN+/LRh9d6PGIfxZ/x3PtGISiVXBIR55lJ2PRUT47DNmq2LYjbghPyv05auWgOhoA5FS+sfttttd7OHJxD4N6iyISUiv1dV9hB/P8tHYVV8CTnsiKwlCtMKVMzjAqQszCHZStQ36buf2RyOvYBhwnL4S40lto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWGIheHp; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e29047bec8fso1201320276.0;
        Wed, 06 Nov 2024 14:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730931277; x=1731536077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbER8uQRgMc3lGFT4u7VFeg6pXjRf9IXs/IQf6vmq6s=;
        b=DWGIheHpCS4XJbdXRcgD8hmNSNPpjqCCuE1I7FsnCEA5WcZz+qLTrE6q0M9Ohh+Gay
         jAARLo1biF9eyhl6t9I2wCeduXI9DRfs347XMDb45a0eM8qftu8aCzn/uBIETyZ7c8+O
         FYZaevPDSLscG/m0x0ZXR0H68jWZPuFvB29lZHv8p+NpbcvvqRoFtusJME7JOetV41qh
         De2rVNjZgwUS/0OnZIACCYiXppwFAR6B/WjUaG6Vs/1tUrzAGJz2VF8hf3FW+Ysoylv1
         qAtfdrtyx5CrPYyG/3iEV6AZG2OQP5jvvHB/f5W63W/zniLll4JnEUHI3xVhpbUwh1LH
         TerA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730931277; x=1731536077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cbER8uQRgMc3lGFT4u7VFeg6pXjRf9IXs/IQf6vmq6s=;
        b=TWOAsHJ0SnEaOoVMakBUKsxCg/xpSB3kEiocMVmj30uEtrgRQW8hQJMrWA32HZLO2r
         ZtdrbrnmWcHg/Vr//FYPikI98dQ/7IRBmabCceRZ4HNPbYLiOxu43G1YktdDiszl19NZ
         N5rpx0ch3PMenb2gXLBmGPBo94feuEqlbDzTiQV4dqsU0qy+31brbzPc59w76DfsUpNK
         5KgPvUwKgQrkx0ePxOaKJet9TfpiBd0dw5I3tv4lB5BIa26s3WLx6WqsCTZBioy+EC4d
         5NybfcQ4pfZudCJKOHwmydEzr79zKQ69pLTrEI2SK1fJSUnKubq8G+mftDZJYubYaoEE
         +aVw==
X-Forwarded-Encrypted: i=1; AJvYcCWJOafWSVOHBWiJZu2nsbGgR8QtZkKf6TxEvBYklN1vLKuq858gexyDoY33CgRvSQ/+coouBgmTY8uuV2bC@vger.kernel.org, AJvYcCXqvLKeTeCd5cHhyBbrFlIodvHjjnQ4ujOzbk+LNnaE3gqsd0ynMk9OqattjeI6wiketSPSlLHp@vger.kernel.org
X-Gm-Message-State: AOJu0YxU2UHZhAo1tSubYPtGOTHhd52DaUkGNQs5CnuDf25+UPq7p34f
	mMS3UMV66gX/crcAKP9JkTxslReI3lOlngGwhNrPMRNfp7AjMwmJ
X-Google-Smtp-Source: AGHT+IGszx+ho52yOVYH5yhv/l6mOK19o5HKqSOg2vLBuohvAZ7xFIBSVJm6ut1NbuJt/3OD0+/bdw==
X-Received: by 2002:a05:690c:23c5:b0:6db:e1e0:bf6a with SMTP id 00721157ae682-6eacbff145fmr10678587b3.7.1730931277584;
        Wed, 06 Nov 2024 14:14:37 -0800 (PST)
Received: from localhost (fwdproxy-frc-002.fbsv.net. [2a03:2880:21ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eaceb7a578sm185057b3.102.2024.11.06.14.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 14:14:36 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: shakeel.butt@linux.dev
Cc: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 2/2] memcg/hugetlb: Deprecate hugetlb memcg try-commit-cancel charging
Date: Wed,  6 Nov 2024 14:14:34 -0800
Message-ID: <20241106221434.2029328-3-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241106221434.2029328-1-joshua.hahnjy@gmail.com>
References: <20241106221434.2029328-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch deprecates the memcg try-{commit,cancel} logic used in hugetlb.
Instead of having three points of error for memcg accounting, the error
patch is reduced to just one point at the end, and shares the same path
with the hugeTLB controller as well.

Please note that the hugeTLB controller still uses the try_charge to 
{commit/cancel} protocol. 

Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>

---
 include/linux/memcontrol.h |  3 +--
 mm/hugetlb.c               | 35 ++++++++++++-----------------------
 mm/memcontrol.c            | 37 +++++++++----------------------------
 3 files changed, 22 insertions(+), 53 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 25761d55799e..0024634d161f 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -696,8 +696,7 @@ static inline int mem_cgroup_charge(struct folio *folio, struct mm_struct *mm,
 
 bool memcg_accounts_hugetlb(void);
 
-int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg, gfp_t gfp,
-		long nr_pages);
+int mem_cgroup_charge_hugetlb(struct folio *folio, gfp_t gfp);
 
 int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struct *mm,
 				  gfp_t gfp, swp_entry_t entry);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index fbb10e52d7ea..db9801b16d13 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2967,21 +2967,13 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 	struct hugepage_subpool *spool = subpool_vma(vma);
 	struct hstate *h = hstate_vma(vma);
 	struct folio *folio;
-	long map_chg, map_commit, nr_pages = pages_per_huge_page(h);
+	long map_chg, map_commit;
 	long gbl_chg;
-	int memcg_charge_ret, ret, idx;
+	int ret, idx;
 	struct hugetlb_cgroup *h_cg = NULL;
-	struct mem_cgroup *memcg;
 	bool deferred_reserve;
 	gfp_t gfp = htlb_alloc_mask(h) | __GFP_RETRY_MAYFAIL;
 
-	memcg = get_mem_cgroup_from_current();
-	memcg_charge_ret = mem_cgroup_hugetlb_try_charge(memcg, gfp, nr_pages);
-	if (memcg_charge_ret == -ENOMEM) {
-		mem_cgroup_put(memcg);
-		return ERR_PTR(-ENOMEM);
-	}
-
 	idx = hstate_index(h);
 	/*
 	 * Examine the region/reserve map to determine if the process
@@ -2989,12 +2981,8 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 	 * code of zero indicates a reservation exists (no change).
 	 */
 	map_chg = gbl_chg = vma_needs_reservation(h, vma, addr);
-	if (map_chg < 0) {
-		if (!memcg_charge_ret)
-			mem_cgroup_cancel_charge(memcg, nr_pages);
-		mem_cgroup_put(memcg);
+	if (map_chg < 0)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	/*
 	 * Processes that did not create the mapping will have no
@@ -3056,6 +3044,12 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 		/* Fall through */
 	}
 
+	ret = mem_cgroup_charge_hugetlb(folio, gfp);
+	if (ret == -ENOMEM)
+		goto free_folio;
+	else if (!ret)
+		lruvec_stat_mod_folio(folio, NR_HUGETLB, pages_per_huge_page(h));
+
 	hugetlb_cgroup_commit_charge(idx, pages_per_huge_page(h), h_cg, folio);
 	/* If allocation is not consuming a reservation, also store the
 	 * hugetlb_cgroup pointer on the page.
@@ -3092,13 +3086,11 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 		}
 	}
 
-	if (!memcg_charge_ret)
-		mem_cgroup_commit_charge(folio, memcg);
-	lruvec_stat_mod_folio(folio, NR_HUGETLB, pages_per_huge_page(h));
-	mem_cgroup_put(memcg);
-
 	return folio;
 
+free_folio:
+	spin_unlock_irq(&hugetlb_lock);
+	free_huge_folio(folio);
 out_uncharge_cgroup:
 	hugetlb_cgroup_uncharge_cgroup(idx, pages_per_huge_page(h), h_cg);
 out_uncharge_cgroup_reservation:
@@ -3110,9 +3102,6 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 		hugepage_subpool_put_pages(spool, 1);
 out_end_reservation:
 	vma_end_reservation(h, vma, addr);
-	if (!memcg_charge_ret)
-		mem_cgroup_cancel_charge(memcg, nr_pages);
-	mem_cgroup_put(memcg);
 	return ERR_PTR(-ENOSPC);
 }
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 59dea0122579..3b728635d6aa 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1448,8 +1448,7 @@ static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 		u64 size;
 
 #ifdef CONFIG_HUGETLB_PAGE
-		if (unlikely(memory_stats[i].idx == NR_HUGETLB) &&
-		    !(cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING))
+		if (unlikely(memory_stats[i].idx == NR_HUGETLB) && !memcg_accounts_hugetlb())
 			continue;
 #endif
 		size = memcg_page_state_output(memcg, memory_stats[i].idx);
@@ -4506,37 +4505,19 @@ bool memcg_accounts_hugetlb(void)
 #endif
 }
 
-/**
- * mem_cgroup_hugetlb_try_charge - try to charge the memcg for a hugetlb folio
- * @memcg: memcg to charge.
- * @gfp: reclaim mode.
- * @nr_pages: number of pages to charge.
- *
- * This function is called when allocating a huge page folio to determine if
- * the memcg has the capacity for it. It does not commit the charge yet,
- * as the hugetlb folio itself has not been obtained from the hugetlb pool.
- *
- * Once we have obtained the hugetlb folio, we can call
- * mem_cgroup_commit_charge() to commit the charge. If we fail to obtain the
- * folio, we should instead call mem_cgroup_cancel_charge() to undo the effect
- * of try_charge().
- *
- * Returns 0 on success. Otherwise, an error code is returned.
- */
-int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg, gfp_t gfp,
-			long nr_pages)
+int mem_cgroup_charge_hugetlb(struct folio *folio, gfp_t gfp)
 {
-	/*
-	 * If hugetlb memcg charging is not enabled, do not fail hugetlb allocation,
-	 * but do not attempt to commit charge later (or cancel on error) either.
-	 */
-	if (mem_cgroup_disabled() || !memcg ||
-		!cgroup_subsys_on_dfl(memory_cgrp_subsys) || !memcg_accounts_hugetlb())
+	struct mem_cgroup *memcg = get_mem_cgroup_from_current();
+
+	if (mem_cgroup_disabled() || !memcg_accounts_hugetlb() ||
+			!memcg || !cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		return -EOPNOTSUPP;
 
-	if (try_charge(memcg, gfp, nr_pages))
+	if (charge_memcg(folio, memcg, gfp))
 		return -ENOMEM;
 
+	mem_cgroup_put(memcg);
+
 	return 0;
 }
 
-- 
2.43.5


