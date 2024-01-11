Return-Path: <cgroups+bounces-1121-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A49A082B48F
	for <lists+cgroups@lfdr.de>; Thu, 11 Jan 2024 19:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43C1D1F25F10
	for <lists+cgroups@lfdr.de>; Thu, 11 Jan 2024 18:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B755537F5;
	Thu, 11 Jan 2024 18:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Dly8SJF3"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B5854F9A
	for <cgroups@vger.kernel.org>; Thu, 11 Jan 2024 18:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=AS+uT7usg/s9J/TDR9k6OcZVDPC0GngCIBakXKVBtYw=; b=Dly8SJF3pkBydTQIAvm2nT5dA4
	9Aq4dmuKHgGbPIE4kTwz6uoNMZl+DHU7IMGFPey88/uA1ij73+5/j0Ui5a43nr65m8kLyZ1LM7acB
	R2b7rD/EoU7FfPOShDM472o4/xdGeLbM/29Hi/BZczIe5rnh3n4vU9ygevgY+uC6bZ0/B5iDq3Wya
	QQmnVSFYLa+KRlGpgrVYbhkHDTZTnCp3ufFfm1yxTq68OiFZqYdwWuVUKxhpAJ6ve9B7heg0ghmhd
	e3RIXQkaboHVKAyfuR+awVljhPAuXzoPlt6d/Z6GZC0ZScBFhO+Qf2RNxscxDgMzHwx0pUHD+tqjw
	wF+oOoTg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rNzXR-00EWr4-NM; Thu, 11 Jan 2024 18:12:21 +0000
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
Subject: [PATCH 4/4] memcg: Use a folio in get_mctgt_type_thp
Date: Thu, 11 Jan 2024 18:12:19 +0000
Message-Id: <20240111181219.3462852-5-willy@infradead.org>
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

Replace five calls to compound_head() with one.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/memcontrol.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b6096c34b3e4..935f48c4d399 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6161,6 +6161,7 @@ static enum mc_target_type get_mctgt_type_thp(struct vm_area_struct *vma,
 		unsigned long addr, pmd_t pmd, union mc_target *target)
 {
 	struct page *page = NULL;
+	struct folio *folio;
 	enum mc_target_type ret = MC_TARGET_NONE;
 
 	if (unlikely(is_swap_pmd(pmd))) {
@@ -6170,17 +6171,18 @@ static enum mc_target_type get_mctgt_type_thp(struct vm_area_struct *vma,
 	}
 	page = pmd_page(pmd);
 	VM_BUG_ON_PAGE(!page || !PageHead(page), page);
+	folio = page_folio(page);
 	if (!(mc.flags & MOVE_ANON))
 		return ret;
-	if (page_memcg(page) == mc.from) {
+	if (folio_memcg(folio) == mc.from) {
 		ret = MC_TARGET_PAGE;
 		if (target) {
-			get_page(page);
-			if (!trylock_page(page)) {
-				put_page(page);
+			folio_get(folio);
+			if (!folio_trylock(folio)) {
+				folio_put(folio);
 				return MC_TARGET_NONE;
 			}
-			target->folio = page_folio(page);
+			target->folio = folio;
 		}
 	}
 	return ret;
-- 
2.43.0


