Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC84B24A63D
	for <lists+cgroups@lfdr.de>; Wed, 19 Aug 2020 20:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgHSStW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 19 Aug 2020 14:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbgHSStJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 19 Aug 2020 14:49:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2631FC061342;
        Wed, 19 Aug 2020 11:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=66DP4Pf9efccaQIqwctMuv9XwKLU5wWgwMF4qWqr0Vk=; b=b4pHEvLPG1hkKsnmbfQrrqTHYi
        VWkIBNDtjyN9c8Z4LmNDcpjHj7yq6xtVSvSuiJUBrLhJ6I96lrnl+ChJ/s76uL2F4feghrlNFAQ1N
        MsxinyVoKVilyk25tpijsshqsL4+yiO4m5XrhCgIu6pXy0OOAd7tzIkD89C5t7Qz1KUbuj5qz01fd
        MSmojCrJigJEHzAYVnM3DkoJTYfyYNJlXIZjcizjLjuA9IesPN3cy97gRx00+1QRiJdbmQw8GmnLe
        IJOGDVShbQY8CWQ6aDu09E/pboQS5RIZ4Q1K2ryIsClNEi9KQZN5QbfFYiHPrEQ9S1eZ6yfVivX38
        rEAPV0mw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8T8n-0006Sx-83; Wed, 19 Aug 2020 18:48:53 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        intel-gfx@lists.freedesktop.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] mm: Use find_get_swap_page in memcontrol
Date:   Wed, 19 Aug 2020 19:48:44 +0100
Message-Id: <20200819184850.24779-3-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200819184850.24779-1-willy@infradead.org>
References: <20200819184850.24779-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The current code does not protect against swapoff of the underlying
swap device, so this is a bug fix as well as a worthwhile reduction in
code complexity.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/memcontrol.c | 25 ++-----------------------
 1 file changed, 2 insertions(+), 23 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b807952b4d43..4075f214a841 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5539,35 +5539,14 @@ static struct page *mc_handle_swap_pte(struct vm_area_struct *vma,
 static struct page *mc_handle_file_pte(struct vm_area_struct *vma,
 			unsigned long addr, pte_t ptent, swp_entry_t *entry)
 {
-	struct page *page = NULL;
-	struct address_space *mapping;
-	pgoff_t pgoff;
-
 	if (!vma->vm_file) /* anonymous vma */
 		return NULL;
 	if (!(mc.flags & MOVE_FILE))
 		return NULL;
 
-	mapping = vma->vm_file->f_mapping;
-	pgoff = linear_page_index(vma, addr);
-
 	/* page is moved even if it's not RSS of this task(page-faulted). */
-#ifdef CONFIG_SWAP
-	/* shmem/tmpfs may report page out on swap: account for that too. */
-	if (shmem_mapping(mapping)) {
-		page = find_get_entry(mapping, pgoff);
-		if (xa_is_value(page)) {
-			swp_entry_t swp = radix_to_swp_entry(page);
-			*entry = swp;
-			page = find_get_page(swap_address_space(swp),
-					     swp_offset(swp));
-		}
-	} else
-		page = find_get_page(mapping, pgoff);
-#else
-	page = find_get_page(mapping, pgoff);
-#endif
-	return page;
+	return find_get_swap_page(vma->vm_file->f_mapping,
+			linear_page_index(vma, addr));
 }
 
 /**
-- 
2.28.0

