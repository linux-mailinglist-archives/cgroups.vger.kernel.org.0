Return-Path: <cgroups+bounces-5829-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F107B9ED760
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 21:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95C77163FC5
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 20:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDFB211A11;
	Wed, 11 Dec 2024 20:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FaRYoimu"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D5C20B814;
	Wed, 11 Dec 2024 20:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733949597; cv=none; b=vERLb6nDFrExDxcYZwsm5R521GbrA3pW891O0lBL/z9GvvwLjmAe/eRL8+vuOQOqJzqXElx+Qou1rfq2pPDbqD5OrNGleYC7QCzLLI0FzFFYWFmVQlNHK3s8zQZC6aAIV7/gRNMB6s2cZW1yAj43BilAfL8Y3FknrBU9U2kxlTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733949597; c=relaxed/simple;
	bh=AMF98hLGCzXV3uQ3vwmyZ1DrjpwjRU+6QG+eTj8OkyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VlC97Y34wOzi8e8yox7XRsOQtKxWRH0+ZBwvddJ5lLJ1vjDDx6MSRsxLMwqcKSu+E7qUNUDqYoe0yRKBL3rKeTwx+BzCx3/rncHYpZKq+rlOzdjoVMuZZBCHbXLkwJIB9ppPCOk7nchIshAsDTH90UoGX1LNqGAzhwuKVPahCZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FaRYoimu; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6f006748fd1so38519667b3.3;
        Wed, 11 Dec 2024 12:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733949595; x=1734554395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etyn39dYkYYqxl1MOdPR2a9G+AL/gyYbItp4iRGm6Gk=;
        b=FaRYoimusqmsan+E3uZILZalhaW3MwCstftpzKwPlgm8N3BKS4dtfQA9IfYi2KupGp
         tLIwMDKb1yoTNpxbv+fKf1jRWUB1LuF5SpD5P4DjhNIXvXISQoBdaFeV+vcQrfrm2nF7
         /mIhROytpmmWpZ6hUpQ4Fngx3EdrdqqLFSz9siulqretWHG4ua85Uoadx1hU1Ct6e6hB
         4/GgwYf3cd0Il6xwtzCG5rgsmK3l25eBQki0r2/ZNtmqJV68AlvDt6spstq+D9IZrwvX
         BnxMkV61o86uDIvlD3hcGy+nR4pRkyq9dV02FAJMYeR01Prm/YBsmCYmJ0elq+wj77P2
         jlSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733949595; x=1734554395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=etyn39dYkYYqxl1MOdPR2a9G+AL/gyYbItp4iRGm6Gk=;
        b=pBjfxC5ssdtDvdsElI0mJtfSHNdxMaP7ctaKwf8vqdcf01uWrc5qnuIB+ld38/hJjK
         MPyQ+arvlQYfbhSrrsapYhgPyoNxhqo8KDRL+uqwtNmSd3r9X8yKGGpOTZtmUK/WDTga
         hUTIHNMJRRhuqdMmHdpq2M+OdWBRQxrw2bPCFtqdNTgmPgk6YqIwc30q869CB4+9zDWP
         M8Wpait7nShomsIr+QWIoAwUhr6/xz1GiVz2OgzpmC+YB4g3J+Tca1JY0qPMATCn7oNj
         jrA4J0sjZ6YrAr9ybkGHJzK6vnR9M7qJhMw13J8yrq75vDF4V/cIxvkE6HNt6jHl/HB6
         ADkw==
X-Forwarded-Encrypted: i=1; AJvYcCVRd58fG0eACnAwVQXyU0Ebgeq6Y3TtUyspfMbRZiW/r2euo262zTWS42exC/KGijcAiNF3Txlb@vger.kernel.org, AJvYcCVWtzY3YiotIFaFXswtOMcJ4XJqIuNHuVa+NXXG+AXQvvFfWIdv8Xyes0X8tH5xyPGL25c+jYu1cXb8ZzUv@vger.kernel.org
X-Gm-Message-State: AOJu0YyT1FoYvcGKuaveASX210c6hZAiaoFhT04G7zmjet5drg94zLPZ
	fu4DPtilNyUSqr8rc7VdNs2/ZMhAhTRbnC8VcZYAbZc72O/5lCJA
X-Gm-Gg: ASbGncsLIwr9xlShCW04N3v5kfhfT4PjhLUPmei6Vg8sQAlzq5plg3jPcrILcxg/xPC
	GkSkMq0wnaLzNQXWIoKc4N5Zp6VsuJgWZ5UiI3fLp+b933EbxyD/BBEwLvmoTMVeCvwfsH8ujoI
	fsQdtI/SffC0J4ub0vP1n6xYmhcX3cm/N2hjXec4QrQlMQN/V9+zi2zROR3GKuQqo75L9sriPLV
	jr6GO2fGKKFV18sge9aIMR7BgiPNPHqmKCp7iiZYvNBMyPWLMakLUWHt/f8y3ScglZrCuN9if0i
	fVKVPvxaN2hyRg==
X-Google-Smtp-Source: AGHT+IHiKNGpDGljLutgpDps2QixRf6dKOvZDYWteW4cFSGFlQb0IBB4jIkNpQKhnKnsth+eROjXLA==
X-Received: by 2002:a05:690c:9a01:b0:6ef:7312:d05c with SMTP id 00721157ae682-6f1a4f68714mr11743177b3.2.1733949595078;
        Wed, 11 Dec 2024 12:39:55 -0800 (PST)
Received: from localhost (fwdproxy-nha-010.fbsv.net. [2a03:2880:25ff:a::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f14cebffeesm4012667b3.126.2024.12.11.12.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 12:39:54 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: shakeel.butt@linux.dev
Cc: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	sj@kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [v3 PATCH 2/3] memcg/hugetlb: Introduce mem_cgroup_charge_hugetlb
Date: Wed, 11 Dec 2024 12:39:50 -0800
Message-ID: <20241211203951.764733-3-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241211203951.764733-1-joshua.hahnjy@gmail.com>
References: <20241211203951.764733-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces mem_cgroup_charge_hugetlb which combines the logic
of mem_cgroup_hugetlb_try_charge / mem_cgroup_hugetlb_commit_charge and
removes the need for mem_cgroup_hugetlb_cancel_charge. It also reduces
the footprint of memcg in hugetlb code and consolidates all memcg
related error paths into one.

Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>

---
 include/linux/memcontrol.h |  7 +++++++
 mm/hugetlb.c               | 35 ++++++++++++++---------------------
 mm/memcontrol.c            | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+), 21 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 5502aa8e138e..f4271cfdba92 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -649,6 +649,8 @@ static inline int mem_cgroup_charge(struct folio *folio, struct mm_struct *mm,
 int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg, gfp_t gfp,
 		long nr_pages);
 
+int mem_cgroup_charge_hugetlb(struct folio* folio, gfp_t gfp);
+
 int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struct *mm,
 				  gfp_t gfp, swp_entry_t entry);
 
@@ -1152,6 +1154,11 @@ static inline int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg,
 	return 0;
 }
 
+static inline int mem_cgroup_charge_hugetlb(struct folio* folio, gfp_t gfp)
+{
+        return 0;
+}
+
 static inline int mem_cgroup_swapin_charge_folio(struct folio *folio,
 			struct mm_struct *mm, gfp_t gfp, swp_entry_t entry)
 {
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ea2ed8e301ef..f0f0ffae30a3 100644
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
@@ -3092,10 +3080,18 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 		}
 	}
 
-	if (!memcg_charge_ret)
-		mem_cgroup_commit_charge(folio, memcg);
+	ret = mem_cgroup_charge_hugetlb(folio, gfp);
+	/*
+	 * Unconditionally increment NR_HUGETLB here. If it turns out that
+	 * mem_cgroup_charge_hugetlb failed, then immediately free the page and
+	 * decrement NR_HUGETLB.
+	 */
 	lruvec_stat_mod_folio(folio, NR_HUGETLB, pages_per_huge_page(h));
-	mem_cgroup_put(memcg);
+
+	if (ret == -ENOMEM) {
+		free_huge_folio(folio);
+		return ERR_PTR(-ENOMEM);
+	}
 
 	return folio;
 
@@ -3110,9 +3106,6 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 		hugepage_subpool_put_pages(spool, 1);
 out_end_reservation:
 	vma_end_reservation(h, vma, addr);
-	if (!memcg_charge_ret)
-		mem_cgroup_cancel_charge(memcg, nr_pages);
-	mem_cgroup_put(memcg);
 	return ERR_PTR(-ENOSPC);
 }
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b25eab9c933e..c903e260a830 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4561,6 +4561,40 @@ int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg, gfp_t gfp,
 	return 0;
 }
 
+/**
+ * mem_cgroup_charge_hugetlb - charge the memcg for a hugetlb folio
+ * @folio: folio being charged
+ * @gfp: reclaim mode
+ *
+ * This function is called when allocating a huge page folio, after the page has
+ * already been obtained and charged to the appropriate hugetlb cgroup
+ * controller (if it is enabled).
+ *
+ * Returns ENOMEM if the memcg is already full.
+ * Returns 0 if either the charge was successful, or if we skip the charging.
+ */
+int mem_cgroup_charge_hugetlb(struct folio *folio, gfp_t gfp)
+{
+	struct mem_cgroup *memcg = get_mem_cgroup_from_current();
+	int ret = 0;
+
+	/*
+	 * Even memcg does not account for hugetlb, we still want to update
+	 * system-level stats via lruvec_stat_mod_folio. Return 0, and skip
+	 * charging the memcg.
+	 */
+	if (mem_cgroup_disabled() || !memcg_accounts_hugetlb() ||
+		!memcg || !cgroup_subsys_on_dfl(memory_cgrp_subsys))
+		goto out;
+
+	if (charge_memcg(folio, memcg, gfp))
+		ret = -ENOMEM;
+
+out:
+	mem_cgroup_put(memcg);
+	return ret;
+}
+
 /**
  * mem_cgroup_swapin_charge_folio - Charge a newly allocated folio for swapin.
  * @folio: folio to charge.
-- 
2.43.5


