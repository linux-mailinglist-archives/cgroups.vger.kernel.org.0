Return-Path: <cgroups+bounces-4560-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 921189641AE
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2024 12:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B9B028B3CE
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2024 10:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B217F1B1D7F;
	Thu, 29 Aug 2024 10:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bdVeulaL"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2316194A54
	for <cgroups@vger.kernel.org>; Thu, 29 Aug 2024 10:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724926852; cv=none; b=J94OYad0Jkpm3qnPZdehoGebj6LWV/Or4fyhtbRng27m8jQz2nEOpvQPGpRfic3P8gB/TiVfFJ7iMmngL86+GJwuOUqxZRnHO5DGBw+JJ2QvCLQaBcmtly68jQhX01hWFjnQgh+IArMn+WVqg02ZYvZPSuxpjQ891sSVIsevo+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724926852; c=relaxed/simple;
	bh=nKiNAOHeWEvVLr0FHI5tGygqqNgOzHtNVsY+xRNlHiw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XdSYiGSFEbZbwRk0cvkXmD7TC3QX7bj9u7VUD0o1drIXuv62b6fGlS3xN9AW/PkI+xTb4y/RQchd+xzsdy09di0AX50s4/j5+bkFG+Li1nViqfquPt31wEIhGTM2f/bf0I6wK7tqihpWwuHN1+B3QC/Dm267cMPMvAY1x8o/Spk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bdVeulaL; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-201d5af11a4so4132725ad.3
        for <cgroups@vger.kernel.org>; Thu, 29 Aug 2024 03:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724926850; x=1725531650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IjshDs/Uxrgcfjr5jDqtbHwONktfCrAQk2fGGuPSrO0=;
        b=bdVeulaLvI6KXxSzRdDW3g3o7XyOvjCdA+NS8Ywlfcmxp3UVVydEasdliPtJW+ZKrA
         lpkIlc2vuy2JsJhKbOP22ynUWVIQPbiqj3VPumFMqR2FIOPzM5j9vKlv9Pjhd+ffV/rG
         Z+EO9GrFL54N/M0em1ZTzp+NDxLzYLjAjCmNsEJuj3rLuQnGlh1pWvfahDjdgiIwyFSE
         CuZ5uzBUGhd4MwCvOcHPLBurMV1chWuoTnuUPWWKU2xXSF0/2TaO296FpizNVAPbp1+8
         avbcYNvP57P2hUEGqaFlIUHbDluc5mNBp5tHH3Skqj2zsak6PcFO6PQ1h5W2X1hgpOJw
         bPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724926850; x=1725531650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IjshDs/Uxrgcfjr5jDqtbHwONktfCrAQk2fGGuPSrO0=;
        b=PEOieWydrLJScsxD5KkCeL8T+zxidSMyEk+9skJgex+Kh+Ef4hTdQoFe9aUJggKNUa
         d6LY8jy45lJMJr+c01S5gDug2PP8P/a8s2UTmLNJ+S1t2Y5zIW29Kwj9UJpzOLCu1799
         AbMuh8bpVOn4V6On3pOBmQ0F+qKX/N/rQhQbmHVlqpYLLmqkBiwkk+6JMSQdJMSkE+Tq
         38/bGjUOaemSap8wTDEoNK1laCnEkbSxwB0LIt0b5a6/7OmO4QNOTawnWSlr6vhPBrnA
         Bxx8evysbeJgLB2Hh4OsygBCiEt1zc+eNZSTpcYWywgoqNh5L6oQHjriXyIuIJF9LnrB
         4IPA==
X-Forwarded-Encrypted: i=1; AJvYcCW0CB7LEcs8UfWZWms1CZqAgktYuV0dCH6Xwt9SX9cPLGIZIhAXhQXvuddwffvJ+QAO6/odOhbI@vger.kernel.org
X-Gm-Message-State: AOJu0YyfEbzeYFs3M+KRZr6hnsLZtJ/l0UkPwuuLUfal8TWRQ7OfsTg5
	L7YppM3UFPJGrx6KxbMwQ9x1tSP/XSmLU0UQTlruUAUDqJuYddU1yAzKMTiC3i8=
X-Google-Smtp-Source: AGHT+IGdl0UcdnYDfDgFEzVC4k/yFpeWbl6UrHniAh9IltC24M18uuh9SesGq3bbAB7noPRGR0hr/Q==
X-Received: by 2002:a17:902:e74e:b0:1fb:8aa9:e2a9 with SMTP id d9443c01a7336-2050c345affmr28095435ad.15.1724926849984;
        Thu, 29 Aug 2024 03:20:49 -0700 (PDT)
Received: from n37-034-248.byted.org ([180.184.51.134])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205155673a2sm8355725ad.303.2024.08.29.03.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 03:20:48 -0700 (PDT)
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
To: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org
Cc: roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	lizefan.x@bytedance.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Zhongkun He <hezhongkun.hzk@bytedance.com>
Subject: [RFC PATCH 1/2] mm: vmscan: modify the semantics of scan_control.may_unmap to UNMAP_ANON and UNMAP_FILE
Date: Thu, 29 Aug 2024 18:20:38 +0800
Message-Id: <20240829102039.3455842-1-hezhongkun.hzk@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a preparation patch to add disable_unmap_file arg to memory.reclaim.

So far, the value of scan_control.may_unmap has only two types, true or false,
which represents whether pages can be unmapped for reclamation in the reclamation
path. It cannot distinguish between file pages and anonymous pages, so we cannot
make a more accurate choice when proactively reclaiming memory in user space. In
practical experience, mapped file pages are crucial for the operation of the program,
usually containing important executable code, data, and shared libraries, etc.
Therefore, it is necessary to make a more accurate distinction.

Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
---
 mm/vmscan.c | 61 +++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 47 insertions(+), 14 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 283e3f9d652b..50ac714cba2f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -107,8 +107,11 @@ struct scan_control {
 	/* Writepage batching in laptop mode; RECLAIM_WRITE */
 	unsigned int may_writepage:1;
 
+	#define UNMAP_ANON 1
+	#define UNMAP_FILE 2
+	#define UNMAP_ANON_AND_FILE UNMAP_ANON + UNMAP_FILE
 	/* Can mapped folios be reclaimed? */
-	unsigned int may_unmap:1;
+	unsigned int may_unmap:2;
 
 	/* Can folios be swapped as part of reclaim? */
 	unsigned int may_swap:1;
@@ -1083,8 +1086,23 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		if (unlikely(!folio_evictable(folio)))
 			goto activate_locked;
 
-		if (!sc->may_unmap && folio_mapped(folio))
-			goto keep_locked;
+		if (folio_mapped(folio)) {
+			switch (sc->may_unmap) {
+			/* The most likely case. */
+			case UNMAP_ANON_AND_FILE:
+				break;
+			case UNMAP_ANON:
+				if (!folio_test_anon(folio))
+					goto keep_locked;
+				break;
+			case UNMAP_FILE:
+				if (folio_test_anon(folio))
+					goto keep_locked;
+				break;
+			default:
+				goto keep_locked;
+			}
+		}
 
 		/* folio_update_gen() tried to promote this page? */
 		if (lru_gen_enabled() && !ignore_references &&
@@ -1563,7 +1581,7 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 {
 	struct scan_control sc = {
 		.gfp_mask = GFP_KERNEL,
-		.may_unmap = 1,
+		.may_unmap = UNMAP_ANON_AND_FILE,
 	};
 	struct reclaim_stat stat;
 	unsigned int nr_reclaimed;
@@ -1688,8 +1706,23 @@ static unsigned long isolate_lru_folios(unsigned long nr_to_scan,
 
 		if (!folio_test_lru(folio))
 			goto move;
-		if (!sc->may_unmap && folio_mapped(folio))
-			goto move;
+
+		if (folio_mapped(folio)) {
+			switch (sc->may_unmap) {
+			case UNMAP_ANON_AND_FILE:
+				break;
+			case UNMAP_ANON:
+				if (!folio_test_anon(folio))
+					goto move;
+				break;
+			case UNMAP_FILE:
+				if (folio_test_anon(folio))
+					goto move;
+				break;
+			default:
+				goto move;
+			}
+		}
 
 		/*
 		 * Be careful not to clear the lru flag until after we're
@@ -2135,7 +2168,7 @@ static unsigned int reclaim_folio_list(struct list_head *folio_list,
 	struct scan_control sc = {
 		.gfp_mask = GFP_KERNEL,
 		.may_writepage = 1,
-		.may_unmap = 1,
+		.may_unmap = UNMAP_ANON_AND_FILE,
 		.may_swap = 1,
 		.no_demotion = 1,
 	};
@@ -5467,7 +5500,7 @@ static ssize_t lru_gen_seq_write(struct file *file, const char __user *src,
 	int err = -EINVAL;
 	struct scan_control sc = {
 		.may_writepage = true,
-		.may_unmap = true,
+		.may_unmap = UNMAP_ANON_AND_FILE,
 		.may_swap = true,
 		.reclaim_idx = MAX_NR_ZONES - 1,
 		.gfp_mask = GFP_KERNEL,
@@ -6482,7 +6515,7 @@ unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
 		.nodemask = nodemask,
 		.priority = DEF_PRIORITY,
 		.may_writepage = !laptop_mode,
-		.may_unmap = 1,
+		.may_unmap = UNMAP_ANON_AND_FILE,
 		.may_swap = 1,
 	};
 
@@ -6526,7 +6559,7 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
 		.nr_to_reclaim = SWAP_CLUSTER_MAX,
 		.target_mem_cgroup = memcg,
 		.may_writepage = !laptop_mode,
-		.may_unmap = 1,
+		.may_unmap = UNMAP_ANON_AND_FILE,
 		.reclaim_idx = MAX_NR_ZONES - 1,
 		.may_swap = !noswap,
 	};
@@ -6572,7 +6605,7 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 		.target_mem_cgroup = memcg,
 		.priority = DEF_PRIORITY,
 		.may_writepage = !laptop_mode,
-		.may_unmap = 1,
+		.may_unmap = UNMAP_ANON_AND_FILE,
 		.may_swap = !!(reclaim_options & MEMCG_RECLAIM_MAY_SWAP),
 		.proactive = !!(reclaim_options & MEMCG_RECLAIM_PROACTIVE),
 	};
@@ -6837,7 +6870,7 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
 	struct scan_control sc = {
 		.gfp_mask = GFP_KERNEL,
 		.order = order,
-		.may_unmap = 1,
+		.may_unmap = UNMAP_ANON_AND_FILE,
 	};
 
 	set_task_reclaim_state(current, &sc.reclaim_state);
@@ -7304,7 +7337,7 @@ unsigned long shrink_all_memory(unsigned long nr_to_reclaim)
 		.reclaim_idx = MAX_NR_ZONES - 1,
 		.priority = DEF_PRIORITY,
 		.may_writepage = 1,
-		.may_unmap = 1,
+		.may_unmap = UNMAP_ANON_AND_FILE,
 		.may_swap = 1,
 		.hibernation_mode = 1,
 	};
@@ -7462,7 +7495,7 @@ static int __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned in
 		.order = order,
 		.priority = NODE_RECLAIM_PRIORITY,
 		.may_writepage = !!(node_reclaim_mode & RECLAIM_WRITE),
-		.may_unmap = !!(node_reclaim_mode & RECLAIM_UNMAP),
+		.may_unmap = !!(node_reclaim_mode & RECLAIM_UNMAP) ? UNMAP_ANON_AND_FILE : 0,
 		.may_swap = 1,
 		.reclaim_idx = gfp_zone(gfp_mask),
 	};
-- 
2.20.1


