Return-Path: <cgroups+bounces-5423-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7589BBF34
	for <lists+cgroups@lfdr.de>; Mon,  4 Nov 2024 22:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9637281209
	for <lists+cgroups@lfdr.de>; Mon,  4 Nov 2024 21:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A5F1FA266;
	Mon,  4 Nov 2024 21:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eKNcimCI"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031101FA262
	for <cgroups@vger.kernel.org>; Mon,  4 Nov 2024 21:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730754371; cv=none; b=gw9fPwaDg0cz65t7TS2gTYz7x1z1irDm/f82wLYRPPE089CygA+AKR1cPKjdtL/RCnvhdmD8NRuQkApylfGTZbHCVrzzMr5Uo8U+ccTorn43uXdGLN1POw3KDsEzuGiEopWwB7md/8L2O050BkIPZoCPL88eELV4O0fxAWrDCD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730754371; c=relaxed/simple;
	bh=ugmwMJCtGAtEfRuPyqj6Fj6ygslTiU+38HjWqdBEmVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F2x1IIWXPZMlDRsc6rRpnHh7UdaX/s/UAQERpBx7d0vKw4eaKK2n9dSAfFh7GLMArsjRF+TawkZu10MILFMyhUojvefMK76JX+VESHZFg+kcwYXRDPCYSart+GvMvxUZM4TSS1NwnEISaf8++idVHreRrlJp2eLsNgArTRTdI5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eKNcimCI; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=gXYh3cqHcJHGeUBg4M162tqHpDf+n9+pJfHXppJVvX8=; b=eKNcimCIWz8r8AhbydXdSOF4Bm
	vjAZ+AnNuSAHBM79pVcg8E3yOWxdhKZdrshxl64iYJae5w7OXaJpvjCZ+GDp/NXiTk/lfgPg+uLLy
	9VoOx4HYikCSE8Cr4D39wxYFPf5onfG78FVxRtWXfeIUehak7qAO/SyfLDNDI2tbwqeJpgKpPRq6K
	BUps+r8AUI3S4B+BlS14v+IHkT/esIZ7hRxJxR77qqLtVp18bSo+jggQWqdmxHdWzgL1MHgPz0GkT
	QV5uDpMtMh4J+AYwWU5s32vATaIYTsVam9KW63kldO0sFODSr1Z24roYSwLalSZVoY0WwCKjhjMl/
	r3a52hdQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t84Gy-00000001ZYK-0hmI;
	Mon, 04 Nov 2024 21:06:04 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Muchun Song <muchun.song@linux.dev>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/3] mm: Opencode split_page_memcg() in __split_huge_page()
Date: Mon,  4 Nov 2024 21:05:58 +0000
Message-ID: <20241104210602.374975-2-willy@infradead.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241104210602.374975-1-willy@infradead.org>
References: <20241104210602.374975-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is in preparation for only handling kmem pages in
__split_huge_page().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/huge_memory.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f92068864469..44d25a74b611 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3234,6 +3234,10 @@ static void __split_huge_page_tail(struct folio *folio, int tail,
 		folio_set_large_rmappable(new_folio);
 	}
 
+#ifdef CONFIG_MEMCG
+	new_folio->memcg_data = folio->memcg_data;
+#endif
+
 	/* Finally unfreeze refcount. Additional reference from page cache. */
 	page_ref_unfreeze(page_tail,
 		1 + ((!folio_test_anon(folio) || folio_test_swapcache(folio)) ?
@@ -3267,8 +3271,11 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 	int order = folio_order(folio);
 	unsigned int nr = 1 << order;
 
-	/* complete memcg works before add pages to LRU */
-	split_page_memcg(head, order, new_order);
+#ifdef CONFIG_MEMCG
+	if (folio_memcg_charged(folio))
+		css_get_many(&folio_memcg(folio)->css,
+				(1 << (order - new_order)) - 1);
+#endif
 
 	if (folio_test_anon(folio) && folio_test_swapcache(folio)) {
 		offset = swap_cache_index(folio->swap);
-- 
2.43.0


