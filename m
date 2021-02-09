Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1369E315A02
	for <lists+cgroups@lfdr.de>; Wed, 10 Feb 2021 00:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbhBIXY4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 9 Feb 2021 18:24:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233663AbhBIWHM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 9 Feb 2021 17:07:12 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A75C08E86F
        for <cgroups@vger.kernel.org>; Tue,  9 Feb 2021 13:45:45 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id o193so10119032qke.11
        for <cgroups@vger.kernel.org>; Tue, 09 Feb 2021 13:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EwcA9/MPS0+DC3O3HQWukmve7xuaXcZk9slnXQmx7cE=;
        b=wIT3T2WvKrwC5BKbIvNn7kdMwcTAScbRrfy18Jb8Zhtzgv/tJ/NMmI6yFeXmx+k+zt
         IAMVDHXZ9uks34GmNs68sEqzbBojhsn2RgNG8RCvtrE6RHopwENBg3jbgh3LGG65XQSy
         NPt/yTL38hj2tqZqevSZK70ul/wLkw9hmJljmQgwnVN0Q99ewpN7hr7kmujDldtFzpWZ
         J3W4K3szU4FwoHmBaYJDgsjBKctQ9T/3G7pFtNBuctYp5HkpCtTX4W7eVEV7lzKHiRIs
         I9/OKo/fFDMkIqhPr5e6FzDVIWPZhLcxuAgqgIIuNa2vpkc0rGZEX0eq0P7wzNG8aWVC
         x8iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EwcA9/MPS0+DC3O3HQWukmve7xuaXcZk9slnXQmx7cE=;
        b=tfDNIbPu0jsjBU4WOZ9TjzMHmdFI0QR/dIWEpkYirSeFoom6eWLJFx+WQQyKyaD41k
         ktXa7ASQ5RY/7TkE5wxAvTlrZZ6PnaPoOrDIT8YLuYs3ZcO3zpprHl6PcfEElkyNOwnA
         FmM7WyYgmHZ7HTqvYITDsppCJoVSxOYussjJ9KtstqlEvKK+RbAhNUkIVL8Q4ei/7z+d
         AiWWbSBAH8l3aN9p7Va8Wix+1yqx00wp6SBTzb+63Ysh6m0tPiyr0QYn31iJRcfJo3tp
         +vuL9+Ci7mstRznvjFnny0sh2v+wZ8SGo9OxBzkrs0vJqXt4hweLbej110btBSTsO5Y1
         mmOQ==
X-Gm-Message-State: AOAM533UGuyiaK+QRhCe+QukQy/c+me3q1/ah664ofO3kEVBJyf844xC
        z7W5N871Kt2+ZQ7YSk6vLsVf8w==
X-Google-Smtp-Source: ABdhPJzV8LHr++DxdDhtyzXnSxFy0nGQ52UC/V1tfcP4eIaAhidTFu9Ol3JhP8qypdKFlZYfHliP/Q==
X-Received: by 2002:a05:620a:1186:: with SMTP id b6mr239621qkk.180.1612907144543;
        Tue, 09 Feb 2021 13:45:44 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id z25sm10277qkz.33.2021.02.09.13.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 13:45:43 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH] mm: page-writeback: simplify memcg handling in test_clear_page_writeback()
Date:   Tue,  9 Feb 2021 16:45:43 -0500
Message-Id: <20210209214543.112655-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Page writeback doesn't hold a page reference, which allows truncate to
free a page the second PageWriteback is cleared. This used to require
special attention in test_clear_page_writeback(), where we had to be
careful not to rely on the unstable page->memcg binding and look up
all the necessary information before clearing the writeback flag.

Since commit 073861ed77b6 ("mm: fix VM_BUG_ON(PageTail) and
BUG_ON(PageWriteback)") test_clear_page_writeback() is called with an
explicit reference on the page, and this dance is no longer needed.

Use unlock_page_memcg() and dec_lruvec_page_stat() directly.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/page-writeback.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index eb34d204d4ee..f6c2c3165d4d 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2722,12 +2722,9 @@ EXPORT_SYMBOL(clear_page_dirty_for_io);
 int test_clear_page_writeback(struct page *page)
 {
 	struct address_space *mapping = page_mapping(page);
-	struct mem_cgroup *memcg;
-	struct lruvec *lruvec;
 	int ret;
 
-	memcg = lock_page_memcg(page);
-	lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
+	lock_page_memcg(page);
 	if (mapping && mapping_use_writeback_tags(mapping)) {
 		struct inode *inode = mapping->host;
 		struct backing_dev_info *bdi = inode_to_bdi(inode);
@@ -2755,11 +2752,11 @@ int test_clear_page_writeback(struct page *page)
 		ret = TestClearPageWriteback(page);
 	}
 	if (ret) {
-		dec_lruvec_state(lruvec, NR_WRITEBACK);
+		dec_lruvec_page_state(page, NR_WRITEBACK);
 		dec_zone_page_state(page, NR_ZONE_WRITE_PENDING);
 		inc_node_page_state(page, NR_WRITTEN);
 	}
-	__unlock_page_memcg(memcg);
+	unlock_page_memcg(page);
 	return ret;
 }
 
-- 
2.30.0

