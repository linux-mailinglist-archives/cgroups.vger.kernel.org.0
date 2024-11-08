Return-Path: <cgroups+bounces-5487-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0BF9C2707
	for <lists+cgroups@lfdr.de>; Fri,  8 Nov 2024 22:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D3D8283E67
	for <lists+cgroups@lfdr.de>; Fri,  8 Nov 2024 21:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61E01FC7F5;
	Fri,  8 Nov 2024 21:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzZNLJT/"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23D91F26E0;
	Fri,  8 Nov 2024 21:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731101393; cv=none; b=HUaD6T+6dobwFj9taKp6SUkRII/ZR4NEm0ibVaYRmnYZwTqbzuReuKP85eUEQKwisFdLJ/tqt2spYtSnXNJBWfK/nPUsD8lC4o5MU8tDpLuof6L/yaU4GnAd+cMTcTcp27ENPH28uIOb7obJ+qg7ba0ZPwiwCnt58uBw0GEsFoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731101393; c=relaxed/simple;
	bh=n/ekMca5sJkKEIQjCNmx2lVdFdZLj+8yltjIR9nyNcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EEXvkW2Vw19QUEH/3iAJvOSY4tSg/b1krVBN7KUCRekRo9y1YIYP/X9nleK5fvQi1gRRdmYTxcZRgIfoqm5vZE7IrKe34c8S/6zdyjaiv/Ef4hc/lAtj7X0I9JEg/q//leqUdRW8WoJu2y1ju2Y2QHsojISOkJY77lpCx3WrMXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CzZNLJT/; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6eacc99a063so27489937b3.3;
        Fri, 08 Nov 2024 13:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731101391; x=1731706191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dcz0dG1cPpUACCNHLbhNPDeGAN7gwrWZYHnMXSk4J1Y=;
        b=CzZNLJT/lsEvRHEVnpDpRDYU6CtmC1lyd4l6vSxHlao3JjPuUOCHjaEM1B7Amms7UG
         Sy3XNIA9X5vSNlMM7OUOFNzNN5wIXi0GVvrreAdbWhNnGt6iGxIGai+VJFi5pV2zw91J
         ra6re50yrI8r9TyJ16zbdM/4ovCn981X3mf1v4ak+/jFsWY+Dpnja8B3oF241jTuag/+
         qBcq9JlMsql2XmUvjFqrSO3/QJM6dTrEThlCi+y8DL7syBuNrrdFpTKRTBOYX9KB7JP9
         oojBUFgkrU6v8Tm1a3xDlP3b4q/PkloE+H2O/oLhCZKuAcUF+V3C9HtGNLRclQ8c9svz
         Ikzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731101391; x=1731706191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dcz0dG1cPpUACCNHLbhNPDeGAN7gwrWZYHnMXSk4J1Y=;
        b=aPNKDXdL1JFu5l4k35Z3oPikMnRFJW/tzpPHUdLFhc2hITpZecyrJK78bUAsrTGDCb
         I9+CfeG9fxA8RWIjVcFbeNJR0WGWQb1sCxaIcW3EWBkkV4aixRQB/yPa+8reRGoO5/Ss
         sEx8CU9rMJLIh0OaWQm+YRZL/6Pxwgv/e1cNpjsqhp1VG1dUFYGcAjsISOl0u86hVXnu
         Imk6IYEgxHpXJ++yNn7xzgLI9G9tZdGHV3z/UnN/p8Ym/MBPtnTH+PvMvV0F2MWafUoy
         phfiN06jTdVxD1Z+dObuOI2vBtRTqCkY1so4nAs73iA5t4+MplDX6IOYTHjtXY1VU2YX
         6TNw==
X-Forwarded-Encrypted: i=1; AJvYcCUnfXkvXLl+jBuFaQp/dwT+bxFZxVf6ms6USh47TT1pRPa+7hmnyMYcdeuVBiEDHdSfUDXO+WpcVd8rSJoA@vger.kernel.org, AJvYcCXCCObboNMgWdiCJSVYl2Ehtpb89xZw13746zjcLsAZ/MEzRstnqLUT60vlyrEixYIXaYWVQYdP@vger.kernel.org
X-Gm-Message-State: AOJu0YxlZP7Y90u1BJPLtMuzFEAuGYdmZQCS4E2jUWGbD2iFhSIWJ14e
	ZZm6po2gGVAlu65YvbujZOkc8G/5K0w9SfA0eYSmnKZl8AB0ufR3
X-Google-Smtp-Source: AGHT+IERNM8wQh4xbgTwcMUCkqiXB1m2+0T8XSuh0sv/LdGiPNf/7fQwQby4VwiHvmPjI5CuC9oBug==
X-Received: by 2002:a05:690c:6890:b0:6e3:1869:8983 with SMTP id 00721157ae682-6eaddfd3d0dmr42837497b3.40.1731101390852;
        Fri, 08 Nov 2024 13:29:50 -0800 (PST)
Received: from localhost (fwdproxy-frc-001.fbsv.net. [2a03:2880:21ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eaceb90192sm8872727b3.128.2024.11.08.13.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 13:29:50 -0800 (PST)
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
Subject: [PATCH 3/3] memcg/hugetlb: Deprecate memcg hugetlb try-commit-cancel protocol
Date: Fri,  8 Nov 2024 13:29:46 -0800
Message-ID: <20241108212946.2642085-4-joshua.hahnjy@gmail.com>
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

This patch fully deprecates the mem_cgroup_{try, commit, cancel} charge
functions, as well as their hugetlb variants. Please note that this
patch relies on [1], which removes the last references (from memcg-v1)
to some of these functions.

Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>

[1] https://lore.kernel.org/linux-mm/20241025012304.2473312-1-shakeel.butt@linux.dev/

---
 include/linux/memcontrol.h | 22 -------------
 mm/memcontrol.c            | 65 ++------------------------------------
 2 files changed, 3 insertions(+), 84 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index d90c1ac791f1..75f15c4efe73 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -649,8 +649,6 @@ static inline bool mem_cgroup_below_min(struct mem_cgroup *target,
 		page_counter_read(&memcg->memory);
 }
 
-void mem_cgroup_commit_charge(struct folio *folio, struct mem_cgroup *memcg);
-
 int __mem_cgroup_charge(struct folio *folio, struct mm_struct *mm, gfp_t gfp);
 
 /**
@@ -675,9 +673,6 @@ static inline int mem_cgroup_charge(struct folio *folio, struct mm_struct *mm,
 	return __mem_cgroup_charge(folio, mm, gfp);
 }
 
-int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg, gfp_t gfp,
-		long nr_pages);
-
 int mem_cgroup_charge_hugetlb(struct folio* folio, gfp_t gfp);
 
 int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struct *mm,
@@ -708,7 +703,6 @@ static inline void mem_cgroup_uncharge_folios(struct folio_batch *folios)
 	__mem_cgroup_uncharge_folios(folios);
 }
 
-void mem_cgroup_cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages);
 void mem_cgroup_replace_folio(struct folio *old, struct folio *new);
 void mem_cgroup_migrate(struct folio *old, struct folio *new);
 
@@ -1167,23 +1161,12 @@ static inline bool mem_cgroup_below_min(struct mem_cgroup *target,
 	return false;
 }
 
-static inline void mem_cgroup_commit_charge(struct folio *folio,
-		struct mem_cgroup *memcg)
-{
-}
-
 static inline int mem_cgroup_charge(struct folio *folio,
 		struct mm_struct *mm, gfp_t gfp)
 {
 	return 0;
 }
 
-static inline int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg,
-		gfp_t gfp, long nr_pages)
-{
-	return 0;
-}
-
 static inline int mem_cgroup_swapin_charge_folio(struct folio *folio,
 			struct mm_struct *mm, gfp_t gfp, swp_entry_t entry)
 {
@@ -1202,11 +1185,6 @@ static inline void mem_cgroup_uncharge_folios(struct folio_batch *folios)
 {
 }
 
-static inline void mem_cgroup_cancel_charge(struct mem_cgroup *memcg,
-		unsigned int nr_pages)
-{
-}
-
 static inline void mem_cgroup_replace_folio(struct folio *old,
 		struct folio *new)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 95ee77fe27af..17126d8d263d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2351,21 +2351,6 @@ int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	return 0;
 }
 
-/**
- * mem_cgroup_cancel_charge() - cancel an uncommitted try_charge() call.
- * @memcg: memcg previously charged.
- * @nr_pages: number of pages previously charged.
- */
-void mem_cgroup_cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)
-{
-	if (mem_cgroup_is_root(memcg))
-		return;
-
-	page_counter_uncharge(&memcg->memory, nr_pages);
-	if (do_memsw_account())
-		page_counter_uncharge(&memcg->memsw, nr_pages);
-}
-
 static void commit_charge(struct folio *folio, struct mem_cgroup *memcg)
 {
 	VM_BUG_ON_FOLIO(folio_memcg_charged(folio), folio);
@@ -2379,18 +2364,6 @@ static void commit_charge(struct folio *folio, struct mem_cgroup *memcg)
 	folio->memcg_data = (unsigned long)memcg;
 }
 
-/**
- * mem_cgroup_commit_charge - commit a previously successful try_charge().
- * @folio: folio to commit the charge to.
- * @memcg: memcg previously charged.
- */
-void mem_cgroup_commit_charge(struct folio *folio, struct mem_cgroup *memcg)
-{
-	css_get(&memcg->css);
-	commit_charge(folio, memcg);
-	memcg1_commit_charge(folio, memcg);
-}
-
 static inline void __mod_objcg_mlstate(struct obj_cgroup *objcg,
 				       struct pglist_data *pgdat,
 				       enum node_stat_item idx, int nr)
@@ -4469,7 +4442,9 @@ static int charge_memcg(struct folio *folio, struct mem_cgroup *memcg,
 	if (ret)
 		goto out;
 
-	mem_cgroup_commit_charge(folio, memcg);
+	css_get(&memcg->css);
+	commit_charge(folio, memcg);
+	memcg1_commit_charge(folio, memcg);
 out:
 	return ret;
 }
@@ -4495,40 +4470,6 @@ bool memcg_accounts_hugetlb(void)
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
-{
-	/*
-	 * If hugetlb memcg charging is not enabled, do not fail hugetlb allocation,
-	 * but do not attempt to commit charge later (or cancel on error) either.
-	 */
-	if (mem_cgroup_disabled() || !memcg ||
-		!cgroup_subsys_on_dfl(memory_cgrp_subsys) || !memcg_accounts_hugetlb())
-		return -EOPNOTSUPP;
-
-	if (try_charge(memcg, gfp, nr_pages))
-		return -ENOMEM;
-
-	return 0;
-}
-
 int mem_cgroup_charge_hugetlb(struct folio *folio, gfp_t gfp)
 {
 	struct mem_cgroup *memcg = get_mem_cgroup_from_current();
-- 
2.43.5


