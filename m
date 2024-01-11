Return-Path: <cgroups+bounces-1123-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E23E82B492
	for <lists+cgroups@lfdr.de>; Thu, 11 Jan 2024 19:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5C27B22768
	for <lists+cgroups@lfdr.de>; Thu, 11 Jan 2024 18:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31373537F1;
	Thu, 11 Jan 2024 18:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NzLVjgjx"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B251E52F82
	for <cgroups@vger.kernel.org>; Thu, 11 Jan 2024 18:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=nikFvHd6fGdNzCCFcNOYGz8RI17m7m/j0Xdu8XjTLzg=; b=NzLVjgjxox29jd/ntluwYpxv4D
	bVQK+95YJVxZUge/U0z3zh9L1AJkU+dtkQI0vJBHiQXWP7Od0DP/G9gDUXy87CxK3KgNxdSPTT5HR
	4a1cml7L8wwn7+lcP+W5YXasDVWmtYm7YGb+S8SvcEK4vzPQgi1s8UNicyRWgpLnwwbpKMFpLJmdD
	KAYRPeAeqb5unTOtACQs9g9kjsUq7eGxUXvrc2QLo9HMvmTSHOmpp0wg2x87GmWZ1ORqHaqRYi+Uq
	3XTcUNqJE/iRjVjPej2pgW4RSTr1eQamHjSbX5fI9IRUQ4gm3+W6wnez2+YYyTf7AJ/ACmR4HByoe
	kxmGEwgQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rNzXR-00EWr2-Ke; Thu, 11 Jan 2024 18:12:21 +0000
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
Subject: [PATCH 3/4] memcg: Use a folio in get_mctgt_type
Date: Thu, 11 Jan 2024 18:12:18 +0000
Message-Id: <20240111181219.3462852-4-willy@infradead.org>
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

Replace seven calls to compound_head() with one.  We still use the
page as page_mapped() is different from folio_mapped().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/memcontrol.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d14fe0740b37..b6096c34b3e4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6076,6 +6076,7 @@ static enum mc_target_type get_mctgt_type(struct vm_area_struct *vma,
 		unsigned long addr, pte_t ptent, union mc_target *target)
 {
 	struct page *page = NULL;
+	struct folio *folio;
 	enum mc_target_type ret = MC_TARGET_NONE;
 	swp_entry_t ent = { .val = 0 };
 
@@ -6090,9 +6091,11 @@ static enum mc_target_type get_mctgt_type(struct vm_area_struct *vma,
 	else if (is_swap_pte(ptent))
 		page = mc_handle_swap_pte(vma, ptent, &ent);
 
+	if (page)
+		folio = page_folio(page);
 	if (target && page) {
-		if (!trylock_page(page)) {
-			put_page(page);
+		if (!folio_trylock(folio)) {
+			folio_put(folio);
 			return ret;
 		}
 		/*
@@ -6107,8 +6110,8 @@ static enum mc_target_type get_mctgt_type(struct vm_area_struct *vma,
 		 * Alas, skip moving the page in this case.
 		 */
 		if (!pte_present(ptent) && page_mapped(page)) {
-			unlock_page(page);
-			put_page(page);
+			folio_unlock(folio);
+			folio_put(folio);
 			return ret;
 		}
 	}
@@ -6121,18 +6124,18 @@ static enum mc_target_type get_mctgt_type(struct vm_area_struct *vma,
 		 * mem_cgroup_move_account() checks the page is valid or
 		 * not under LRU exclusion.
 		 */
-		if (page_memcg(page) == mc.from) {
+		if (folio_memcg(folio) == mc.from) {
 			ret = MC_TARGET_PAGE;
-			if (is_device_private_page(page) ||
-			    is_device_coherent_page(page))
+			if (folio_is_device_private(folio) ||
+			    folio_is_device_coherent(folio))
 				ret = MC_TARGET_DEVICE;
 			if (target)
-				target->folio = page_folio(page);
+				target->folio = folio;
 		}
 		if (!ret || !target) {
 			if (target)
-				unlock_page(page);
-			put_page(page);
+				folio_unlock(folio);
+			folio_put(folio);
 		}
 	}
 	/*
-- 
2.43.0


