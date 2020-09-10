Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B8A264D3C
	for <lists+cgroups@lfdr.de>; Thu, 10 Sep 2020 20:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgIJSik (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 10 Sep 2020 14:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbgIJSeC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 10 Sep 2020 14:34:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B387C061796;
        Thu, 10 Sep 2020 11:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ewcIYV3TQS8WP/lMrXPvrY92L5jpE36QYNCFA1ncbsc=; b=F5AUBEYvYzQN95hW85bBYGSNGm
        dqr/FIDMdYM5Al3Z2/G44MeSLdg3FvtOGcL0es06Bnbznufe5c2x8Lz7RURVTk5n1zGZVcxrtzErO
        PZ53gJcR2CXaf7QigmY9EKywMn+n16Qge5W7dl8WazyVronln+U5qPN3PfzSg5tX+bQ9YjA+Pfu9M
        c3fW+KnwVq/E0Pe1/bLa7ghA4WL8vnyOSLsz70Fb8hIGYcN9V2XzkttUG0ylT6s6TAtKtqFAl7Zby
        QT5oT1X4Vq1OFEaAcU7o+Vf1OKFDtdZ4g2MaHkbITxeystP2bEPVRt06WbX6e2y0WsrLILor5Rj0F
        0CyJHhKw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGRNp-0005GR-FC; Thu, 10 Sep 2020 18:33:21 +0000
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
Subject: [PATCH v2 5/8] i915: Use find_lock_page instead of find_lock_entry
Date:   Thu, 10 Sep 2020 19:33:15 +0100
Message-Id: <20200910183318.20139-6-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200910183318.20139-1-willy@infradead.org>
References: <20200910183318.20139-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

i915 does not want to see value entries.  Switch it to use
find_lock_page() instead, and remove the export of find_lock_entry().
Move find_lock_entry() and find_get_entry() to mm/internal.h to discourage
any future use.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 4 ++--
 include/linux/pagemap.h                   | 2 --
 mm/filemap.c                              | 1 -
 mm/internal.h                             | 3 +++
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index 38113d3c0138..75e8b71c18b9 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -258,8 +258,8 @@ shmem_writeback(struct drm_i915_gem_object *obj)
 	for (i = 0; i < obj->base.size >> PAGE_SHIFT; i++) {
 		struct page *page;
 
-		page = find_lock_entry(mapping, i);
-		if (!page || xa_is_value(page))
+		page = find_lock_page(mapping, i);
+		if (!page)
 			continue;
 
 		if (!page_mapped(page) && clear_page_dirty_for_io(page)) {
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 12ab56c3a86f..905a64030647 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -384,8 +384,6 @@ static inline struct page *find_subpage(struct page *head, pgoff_t index)
 	return head + (index & (thp_nr_pages(head) - 1));
 }
 
-struct page *find_get_entry(struct address_space *mapping, pgoff_t offset);
-struct page *find_lock_entry(struct address_space *mapping, pgoff_t offset);
 unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
 			  unsigned int nr_entries, struct page **entries,
 			  pgoff_t *indices);
diff --git a/mm/filemap.c b/mm/filemap.c
index 78d07a712112..d64f6f76bc0b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1648,7 +1648,6 @@ struct page *find_lock_entry(struct address_space *mapping, pgoff_t offset)
 	}
 	return page;
 }
-EXPORT_SYMBOL(find_lock_entry);
 
 /**
  * pagecache_get_page - Find and get a reference to a page.
diff --git a/mm/internal.h b/mm/internal.h
index ab4beb7c5cd2..6345b08ce86c 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -60,6 +60,9 @@ static inline void force_page_cache_readahead(struct address_space *mapping,
 	force_page_cache_ra(&ractl, &file->f_ra, nr_to_read);
 }
 
+struct page *find_get_entry(struct address_space *mapping, pgoff_t index);
+struct page *find_lock_entry(struct address_space *mapping, pgoff_t index);
+
 /**
  * page_evictable - test whether a page is evictable
  * @page: the page to test
-- 
2.28.0

