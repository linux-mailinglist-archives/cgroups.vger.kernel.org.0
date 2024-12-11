Return-Path: <cgroups+bounces-5830-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BB39ED762
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 21:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7068188451B
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 20:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA22229679;
	Wed, 11 Dec 2024 20:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="guaxL6dW"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5672288EF;
	Wed, 11 Dec 2024 20:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733949598; cv=none; b=cjoXnkhcb8svgR7alZJOkMU9srY+OzVunUfCl4AGpvMzCpiNa34lB0YL6j0WcRavjS+508DcrCUt3AifRh7T69gS6lOcdRyT6IYph1eXNZwHnkgk2f58qumBhflOiXX3q6wIam+GVhTzXdSEtjPJlIJ5SProIeCphMdYeZ2Z8qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733949598; c=relaxed/simple;
	bh=WLwynhVDcI3vfVE61poQ/NqrgK1s6dKzdDUa9svjbqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j24RWxn6879BqahRaFFdrrBYT0VJ8cFFeJIAnlWnpyjp+CM7pKNCqUE7mMOG5aKuNwHjtYHTMhBJhlxrpftX9i3q0skDrrJOw1U7YPb2mBI8uV3GC0y025632IrIYqHB4SYtN3lsknNROYSIj48pp97KAP0MVeyCIHPLF09BV+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=guaxL6dW; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6eff4f0d627so41036667b3.1;
        Wed, 11 Dec 2024 12:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733949596; x=1734554396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TB7w562sxA4ON1zeYB8I14khwhTIPTHUGFUW2mmo+w4=;
        b=guaxL6dW80b2SmMCzEUCOSqmpk6W12+0A7jCKqn9YGO1OfMlPdKgR9fh1s1LpnvjKR
         B+rg9KU8fYez1ca2nnFtQi4+ka57Q4HTdcFo2H1h4BjxWiQbtZhK+jKWjnac5nTa9s3F
         t9sLYyMxJUiL77dBtouo6MaFwsjwlBA+lveapOLBIX93rKtP8KRZrWr5ra3ObnxwUQKQ
         uuXoOgE/OXZQdjb60e2fcCRM5MpvoZSv9rgMEsR8Q4PU+nl+J0A9szgkrStsBq3wGinu
         ceIVT0pCmF5j1d7c+cdJ82Pjv5iN2L1OgGAGKoa7N+V8uiJ6Ny5f8klu9s1Won/3L4PD
         Wb6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733949596; x=1734554396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TB7w562sxA4ON1zeYB8I14khwhTIPTHUGFUW2mmo+w4=;
        b=iplAcdA6RcNkGSoOERDRmW/1vU66EH8Sq43n9AGsT5CIN1kkA6CrWb2lpAD7U32flu
         9YcNGzEGt+beT3VN3xcITSGxayUTs/5smT0WSweKfO86awshiIJks67I6jmdj59VVFSF
         8UrsepMq1tJoDZCxjP86Qdu2lVb6EjkaWbPS6N5y62nm9DifvcGGWUrCDi2CXkk89P3u
         KMwISFyWFQtYRdzmdDhKUmdh9RyRzgNk+EHoiIr4lE4MvtmBOUFf44P01+JDJQqJrzwE
         rojQOwO9/w4CSPBjf3HA2khJlsXxP0FWIWZSe72Oe3bchtWjlFur7f1KaUUmYVSlNCu3
         1wZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUn70iFr2n4d1LMMZkWXYAfiShKKuz2cE1N7yUHO6KBf8Jay3jaaZzypTLEvO/oCKbPD6flI+Dq1ttdzUsa@vger.kernel.org, AJvYcCXEETj4IzzhsBDc3IXYSeB5u53LWD1aD7AfPA8rWuByjAZuafyaTCTm7SjbAww7qkpw0tI0sWHU@vger.kernel.org
X-Gm-Message-State: AOJu0YwtfMdVSgMd5IPTqkh3W2ZrSl9Q/YPxBgnuZx2rKW32TD+dRyBP
	SoSES9jPNUj/po283+RvQ4mHQCsKtuOLZHZ9E3PnrdlKP05dilMW
X-Gm-Gg: ASbGnctdvUe/u0tOEASX5Td2fwivnRmJ25YV7/3+TlQuidho5xKaw6XNJry9vO4bko+
	NE0VuM+tf0FQU477rrf8VUBtrKz5/Ir2bqScl+dSzGcTGttjIQaFaYfssOLivhGYwEfdSeVvYhM
	jVqd2uVwKTcXuCw2xEWtCPWMM0w8A3yTL5Gq4pzUGM8vpbgFWmsrG+P446elW/agWPSd6GHN4jA
	aJWavedpMFxYn0hZoDOPNisN1oN5KD9nmZRv9XVmPrXD3h5EkGwmWPgpEQ0PauVkNsp6ydi9uJC
	Luy2Y4bMMRVR0w==
X-Google-Smtp-Source: AGHT+IHKldzU41mVArIiVR43SbQPj9lPuiGmJL7kSl+CvnB5gG8KxKv/VPEhLHgXKWwXvwNSDfRJ8g==
X-Received: by 2002:a05:690c:6610:b0:6ef:504e:a50a with SMTP id 00721157ae682-6f198a3cf33mr14425157b3.2.1733949596093;
        Wed, 11 Dec 2024 12:39:56 -0800 (PST)
Received: from localhost (fwdproxy-nha-002.fbsv.net. [2a03:2880:25ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e3c94b436f9sm455633276.42.2024.12.11.12.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 12:39:55 -0800 (PST)
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
Subject: [PATCH 3/3] memcg/hugetlb: Remove memcg hugetlb try-commit-cancel protocol
Date: Wed, 11 Dec 2024 12:39:51 -0800
Message-ID: <20241211203951.764733-4-joshua.hahnjy@gmail.com>
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

This patch fully removes the mem_cgroup_{try, commit, cancel}_charge
functions, as well as their hugetlb variants.

Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

---
 include/linux/memcontrol.h | 22 -------------
 mm/memcontrol.c            | 65 ++------------------------------------
 2 files changed, 3 insertions(+), 84 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index d1ee98dc3a38..e1a9998d8add 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -620,8 +620,6 @@ static inline bool mem_cgroup_below_min(struct mem_cgroup *target,
 		page_counter_read(&memcg->memory);
 }
 
-void mem_cgroup_commit_charge(struct folio *folio, struct mem_cgroup *memcg);
-
 int __mem_cgroup_charge(struct folio *folio, struct mm_struct *mm, gfp_t gfp);
 
 /**
@@ -646,9 +644,6 @@ static inline int mem_cgroup_charge(struct folio *folio, struct mm_struct *mm,
 	return __mem_cgroup_charge(folio, mm, gfp);
 }
 
-int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg, gfp_t gfp,
-		long nr_pages);
-
 int mem_cgroup_charge_hugetlb(struct folio* folio, gfp_t gfp);
 
 int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struct *mm,
@@ -679,7 +674,6 @@ static inline void mem_cgroup_uncharge_folios(struct folio_batch *folios)
 	__mem_cgroup_uncharge_folios(folios);
 }
 
-void mem_cgroup_cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages);
 void mem_cgroup_replace_folio(struct folio *old, struct folio *new);
 void mem_cgroup_migrate(struct folio *old, struct folio *new);
 
@@ -1137,23 +1131,12 @@ static inline bool mem_cgroup_below_min(struct mem_cgroup *target,
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
@@ -1172,11 +1155,6 @@ static inline void mem_cgroup_uncharge_folios(struct folio_batch *folios)
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
index c903e260a830..7ddbb2d12eb9 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2383,21 +2383,6 @@ int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
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
@@ -2411,18 +2396,6 @@ static void commit_charge(struct folio *folio, struct mem_cgroup *memcg)
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
@@ -4510,7 +4483,9 @@ static int charge_memcg(struct folio *folio, struct mem_cgroup *memcg,
 	if (ret)
 		goto out;
 
-	mem_cgroup_commit_charge(folio, memcg);
+	css_get(&memcg->css);
+	commit_charge(folio, memcg);
+	memcg1_commit_charge(folio, memcg);
 out:
 	return ret;
 }
@@ -4527,40 +4502,6 @@ int __mem_cgroup_charge(struct folio *folio, struct mm_struct *mm, gfp_t gfp)
 	return ret;
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
 /**
  * mem_cgroup_charge_hugetlb - charge the memcg for a hugetlb folio
  * @folio: folio being charged
-- 
2.43.5


