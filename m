Return-Path: <cgroups+bounces-1122-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CC582B490
	for <lists+cgroups@lfdr.de>; Thu, 11 Jan 2024 19:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F9241C24549
	for <lists+cgroups@lfdr.de>; Thu, 11 Jan 2024 18:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965515380A;
	Thu, 11 Jan 2024 18:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V8/B94yi"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E27537FC
	for <cgroups@vger.kernel.org>; Thu, 11 Jan 2024 18:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=ckLkDfpTy5X71kCDKuO9wk6WU/1baQA9VkLceFKNXrc=; b=V8/B94yi0XWKJBeBSphEHnJnTP
	OPrAAc6rjc8oO7WITgFGTDrIkp0HsGBGgRO91ipoC07vwDNLDpLV2ml06fcYpqsaCFqDexdsbtM6Z
	vd+jcROAvdMoq045wg0zd7FjgflmQ0nvNj+HvVHo3lU/GzL6hAaQENEkYs2tIQbflrMb9oMsqdYif
	kC6jG0PMTfe/DF1zm3H5Ke2jeYCSWlNoVvRU3KcuX3yqc3q1Lh991huh5e4kmgoDPCgCXbWKv8BiN
	8otdL6KQiHaqZfrDiYhSAKo0nYrnLoO2BemF1JCQ2EKJVuFkjviVrJcxJ3gXXRf3ITzpdinrjHfrm
	GPkj9dvw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rNzXR-00EWr0-Hx; Thu, 11 Jan 2024 18:12:21 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/4] memcg: Return the folio in union mc_target
Date: Thu, 11 Jan 2024 18:12:17 +0000
Message-Id: <20240111181219.3462852-3-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240111181219.3462852-1-willy@infradead.org>
References: <20240111181219.3462852-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All users of target.page convert it to the folio, so we can just return
the folio directly and save a few calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/memcontrol.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c04bda961165..d14fe0740b37 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5840,7 +5840,7 @@ static int mem_cgroup_do_precharge(unsigned long count)
 }
 
 union mc_target {
-	struct page	*page;
+	struct folio	*folio;
 	swp_entry_t	ent;
 };
 
@@ -6062,7 +6062,7 @@ static int mem_cgroup_move_account(struct folio *folio,
  * Return:
  * * MC_TARGET_NONE - If the pte is not a target for move charge.
  * * MC_TARGET_PAGE - If the page corresponding to this pte is a target for
- *   move charge. If @target is not NULL, the page is stored in target->page
+ *   move charge. If @target is not NULL, the folio is stored in target->folio
  *   with extra refcnt taken (Caller should release it).
  * * MC_TARGET_SWAP - If the swap entry corresponding to this pte is a
  *   target for charge migration.  If @target is not NULL, the entry is
@@ -6127,7 +6127,7 @@ static enum mc_target_type get_mctgt_type(struct vm_area_struct *vma,
 			    is_device_coherent_page(page))
 				ret = MC_TARGET_DEVICE;
 			if (target)
-				target->page = page;
+				target->folio = page_folio(page);
 		}
 		if (!ret || !target) {
 			if (target)
@@ -6177,7 +6177,7 @@ static enum mc_target_type get_mctgt_type_thp(struct vm_area_struct *vma,
 				put_page(page);
 				return MC_TARGET_NONE;
 			}
-			target->page = page;
+			target->folio = page_folio(page);
 		}
 	}
 	return ret;
@@ -6407,7 +6407,7 @@ static int mem_cgroup_move_charge_pte_range(pmd_t *pmd,
 		}
 		target_type = get_mctgt_type_thp(vma, addr, *pmd, &target);
 		if (target_type == MC_TARGET_PAGE) {
-			folio = page_folio(target.page);
+			folio = target.folio;
 			if (folio_isolate_lru(folio)) {
 				if (!mem_cgroup_move_account(folio, true,
 							     mc.from, mc.to)) {
@@ -6419,7 +6419,7 @@ static int mem_cgroup_move_charge_pte_range(pmd_t *pmd,
 			folio_unlock(folio);
 			folio_put(folio);
 		} else if (target_type == MC_TARGET_DEVICE) {
-			folio = page_folio(target.page);
+			folio = target.folio;
 			if (!mem_cgroup_move_account(folio, true,
 						     mc.from, mc.to)) {
 				mc.precharge -= HPAGE_PMD_NR;
@@ -6449,7 +6449,7 @@ static int mem_cgroup_move_charge_pte_range(pmd_t *pmd,
 			device = true;
 			fallthrough;
 		case MC_TARGET_PAGE:
-			folio = page_folio(target.page);
+			folio = target.folio;
 			/*
 			 * We can have a part of the split pmd here. Moving it
 			 * can be done but it would be too convoluted so simply
-- 
2.43.0


