Return-Path: <cgroups+bounces-5486-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 408439C2705
	for <lists+cgroups@lfdr.de>; Fri,  8 Nov 2024 22:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5FB41F2397A
	for <lists+cgroups@lfdr.de>; Fri,  8 Nov 2024 21:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E471F426F;
	Fri,  8 Nov 2024 21:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3Aj9CbV"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5E41EBA03;
	Fri,  8 Nov 2024 21:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731101392; cv=none; b=QW7GAqaI9Pu/svuWsAhSLD5yUVm9zGZJlytiOfI2DWHZSH+/trQ7VpozPCMEiRemzs2nLtFf1i7WeW+4l+Aykk6WuQAngKuUwmS2odlyOLfNA5cGgrnQX3M/LYh4j1BGWkJOA2aL0gHpERYODJTGio6lLMMqG4iYRBzfzb3zqgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731101392; c=relaxed/simple;
	bh=ZJ/UGoRVCAIi7MimytzM5Vb9VB7NvIybOtmXOb1iUVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KbUfSSKDRldZzGwY5u4yQOAktyGIdumX8iQiU9oRk04XU08pM9USeXl6MhO/nD1/+zWtS1o5bL8PECoDxcIq6x4CKA/EljeWn2E0DbwWDXqWIPUtzUDtaBqjV0/sjo+lB+X9CO0MznG3YqDOe0XJdtEqLLHWOLjjFaF2CyJRNf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C3Aj9CbV; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e28fe07e97dso2801841276.3;
        Fri, 08 Nov 2024 13:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731101390; x=1731706190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SlQ3sjJT81bsTmwr1uay84sXlsybFvKefjGpPF85ZWQ=;
        b=C3Aj9CbV1gkEOZV6ZPN/J9mq7/XY34uGApN0wY3ufRgCl/N+lJzNOYNOaDiQ1cceMH
         Ne3NexeV6YJkRm868syV8heXJkySKW5HLiyyVnTNtT9d5OtrakDLc3/Tcn0CDSHMFxyo
         MalY5TZvi1h9cyV5ZTkoJ3je+kRW0Iz8pFi5JRuoqJrjynh+wJBZ46mjNoqgKIr3Ozvg
         3VPeJnpCMSTrCwn5wazFwAARhHUHyVROcKxq654RkdxGqS371ppNSlCKy9kO0axziAAB
         v90OK7VL6hs6WEnGc6TOQ4gNlneDf/nwxy1O9h8HvtSnN0DsVpR/C+imhXFyI8JjRigX
         xNqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731101390; x=1731706190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SlQ3sjJT81bsTmwr1uay84sXlsybFvKefjGpPF85ZWQ=;
        b=Ra1MmG/eJ5H7kwHm8ESKTevHv6YKyru9Cf8098IEhXycXmci+jR6Ep+W6cLc9nHLX/
         2pfJbpeK4a1jkvc03AcjieBKcOjFiIKFkHsD6xeFLd8t1k8J0YNbd+z9Bwhj26mvs2C0
         h8z885n78is3wLGWVSHP2kXsFLzxnpnbOvUt6fVSTUmfkweZgQYu9BsYe4LmF5+5OqKn
         S+mpRY/YEzbqZ2ji3BwYMxArL4YlQXqQ5wurda/kTpMiOhAZ8mLwcStkwOtkWu0ga5HR
         VNUQK2wvoaDHSEfPRld03zDseVudqXTJNIKSWCXPkkA+hzfdIxjf2wOOz+4fTuWfWCzr
         Yuhw==
X-Forwarded-Encrypted: i=1; AJvYcCUrBtllv2VYw37X70ESG3Vr/HgMt9glCmBZ8DX+lSbwzVZ5fTXtMGAWN2TFaul6nCIWZ+vX7qRe@vger.kernel.org, AJvYcCXeWM4T0/ppMNkySJDZxDAzphXnKuFDetpOyfgTX7kwkFEbcx/t7aMDurxAWz+3SAw1IFY2oWUAkAZkWVzg@vger.kernel.org
X-Gm-Message-State: AOJu0Yy67D8hxEJlcSnYTOgDcYa4+H3YL4GmQ6C2L5520B1QEdHJQRx0
	jkJlhD4BKYo7D71Xr8yMi1V2YaLeMO7gIk5Qy6q64lcz73G2mR0F
X-Google-Smtp-Source: AGHT+IFYGeqK9WHN6tzmVfn8RrbnYZR+fESmtaRa7GS9uP5CtuQHP1PNtDJrSMzfXRi9Cqzl4/l5eQ==
X-Received: by 2002:a05:690c:7308:b0:6e3:3521:88ff with SMTP id 00721157ae682-6eaddd9507amr55794997b3.18.1731101389891;
        Fri, 08 Nov 2024 13:29:49 -0800 (PST)
Received: from localhost (fwdproxy-frc-005.fbsv.net. [2a03:2880:21ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eace8ee1c0sm8850617b3.28.2024.11.08.13.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 13:29:49 -0800 (PST)
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
Subject: [PATCH 2/3] memcg/hugetlb: Introduce mem_cgroup_charge_hugetlb
Date: Fri,  8 Nov 2024 13:29:45 -0800
Message-ID: <20241108212946.2642085-3-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241108212946.2642085-1-joshua.hahnjy@gmail.com>
References: <20241108212946.2642085-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces mem_cgroup_charge_hugetlb, which combines the
logic of mem_cgroup{try,commit}_hugetlb. This reduces the footprint of
memcg in hugetlb code, and also consolidates the error path that memcg
can take into just one point.

Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>

---
 include/linux/memcontrol.h |  2 ++
 mm/hugetlb.c               | 34 ++++++++++++----------------------
 mm/memcontrol.c            | 19 +++++++++++++++++++
 3 files changed, 33 insertions(+), 22 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index bb49e0d4b377..d90c1ac791f1 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -678,6 +678,8 @@ static inline int mem_cgroup_charge(struct folio *folio, struct mm_struct *mm,
 int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg, gfp_t gfp,
 		long nr_pages);
 
+int mem_cgroup_charge_hugetlb(struct folio* folio, gfp_t gfp);
+
 int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struct *mm,
 				  gfp_t gfp, swp_entry_t entry);
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index fbb10e52d7ea..6f6841483039 100644
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
@@ -3092,10 +3080,15 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 		}
 	}
 
-	if (!memcg_charge_ret)
-		mem_cgroup_commit_charge(folio, memcg);
-	lruvec_stat_mod_folio(folio, NR_HUGETLB, pages_per_huge_page(h));
-	mem_cgroup_put(memcg);
+	ret = mem_cgroup_charge_hugetlb(folio, gfp);
+	if (ret == -ENOMEM) {
+		spin_unlock_irq(&hugetlb_lock);
+		free_huge_folio(folio);
+		return ERR_PTR(-ENOMEM);
+	}
+	else if (!ret)
+		lruvec_stat_mod_folio(folio, NR_HUGETLB,
+		      pages_per_huge_page(h));
 
 	return folio;
 
@@ -3110,9 +3103,6 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 		hugepage_subpool_put_pages(spool, 1);
 out_end_reservation:
 	vma_end_reservation(h, vma, addr);
-	if (!memcg_charge_ret)
-		mem_cgroup_cancel_charge(memcg, nr_pages);
-	mem_cgroup_put(memcg);
 	return ERR_PTR(-ENOSPC);
 }
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 97f63ec9c9fb..95ee77fe27af 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4529,6 +4529,25 @@ int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg, gfp_t gfp,
 	return 0;
 }
 
+int mem_cgroup_charge_hugetlb(struct folio *folio, gfp_t gfp)
+{
+	struct mem_cgroup *memcg = get_mem_cgroup_from_current();
+	int ret = 0;
+
+	if (mem_cgroup_disabled() || !memcg_accounts_hugetlb() ||
+		!memcg || !cgroup_subsys_on_dfl(memory_cgrp_subsys)) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
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


