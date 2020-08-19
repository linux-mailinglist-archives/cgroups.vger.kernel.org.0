Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0060E24A642
	for <lists+cgroups@lfdr.de>; Wed, 19 Aug 2020 20:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgHSStZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 19 Aug 2020 14:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgHSStH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 19 Aug 2020 14:49:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC36C061345;
        Wed, 19 Aug 2020 11:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=lHH3FI1tdZZ9OqCoI613Ez6EcSFNmDwjhfuwAt20rC0=; b=bV5mILzXSPzh12r4bbJtUTmcyK
        mmNzxSnEJpTqrEIi28olHtDus3qRFErxyqk3CfVa6Nd4m1tQJRl4IgaCasF0ja9tQDItvvrax3GnS
        8UkqbyOfosJ5Q1ytEse0bM/qsh4yxOC1BjxdwFk5+1XwRJS5Mzl9pD0gRQiZFy1b0n+04o76H48LY
        t3U9M07QP7XUBrtP90Ne92iZXCDHymovYeKar5RSM0+3U/Kkv4PkKew1BHT59pZ55s+bYN1mtFgId
        s+FXFgC5nX3xOrYqcNbRh6at1KntZUZAJORErYWO3YvaY8XYRm8CaujUuJjZ+cHzX44rlsGU7au8p
        ZnGIytaQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8T8p-0006Te-2y; Wed, 19 Aug 2020 18:48:55 +0000
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
Subject: [PATCH 5/8] i915: Use find_lock_page instead of find_lock_entry
Date:   Wed, 19 Aug 2020 19:48:47 +0100
Message-Id: <20200819184850.24779-6-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200819184850.24779-1-willy@infradead.org>
References: <20200819184850.24779-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

i915 does not want to see value entries.  Switch it to use
find_lock_page() instead, and remove the export of find_lock_entry().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 4 ++--
 mm/filemap.c                              | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

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
diff --git a/mm/filemap.c b/mm/filemap.c
index 1aaea26556cc..36067cf7f8c5 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1628,7 +1628,6 @@ struct page *find_lock_entry(struct address_space *mapping, pgoff_t offset)
 	}
 	return page;
 }
-EXPORT_SYMBOL(find_lock_entry);
 
 /**
  * pagecache_get_page - Find and get a reference to a page.
-- 
2.28.0

