Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F15F324A649
	for <lists+cgroups@lfdr.de>; Wed, 19 Aug 2020 20:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgHSStn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 19 Aug 2020 14:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbgHSStG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 19 Aug 2020 14:49:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2E5C061383;
        Wed, 19 Aug 2020 11:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=6FEH2RzEKpeGkw1ry8PIMFPV7YWAJWwmC36GZdEh8I8=; b=mpxwSwSBY6UqYCwG+sE65V35BB
        J8yzFZhDe0QRMl1ZP/nlpb2+WKDQLYNkDnz76pIkiUTqTr189msFIwBJ8Mr8+Fb5eKxFjMBlC264q
        MFMM2mcRXQAZBJw4EqOpTiDhiJTFSkQjlg6ucjHSbR1dPWYPrVqiLTTEa+IgaEziprwqMjqE/2vJN
        8HJKcVy+CFy9D2tDrJzoPrvYKkIeAngzZupTTfRif0cbwdr6/FFFFOSjbC7q0zK/5WOG5hKulHIBH
        VFCsPpPgHZOLoqSynTDkWtpsghEfDw6rADRHNjdQRwN5rhOkDtE0OXzWVqUtA/fsw+CJSKW2WX9+8
        OaTNPKkg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8T8o-0006TI-Gl; Wed, 19 Aug 2020 18:48:54 +0000
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
Subject: [PATCH 4/8] proc: Optimise smaps for shmem entries
Date:   Wed, 19 Aug 2020 19:48:46 +0100
Message-Id: <20200819184850.24779-5-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200819184850.24779-1-willy@infradead.org>
References: <20200819184850.24779-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Avoid bumping the refcount on pages when we're only interested in the
swap entries.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/proc/task_mmu.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 5066b0251ed8..e42d9e5e9a3c 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -520,16 +520,10 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
 			page = device_private_entry_to_page(swpent);
 	} else if (unlikely(IS_ENABLED(CONFIG_SHMEM) && mss->check_shmem_swap
 							&& pte_none(*pte))) {
-		page = find_get_entry(vma->vm_file->f_mapping,
+		page = xa_load(&vma->vm_file->f_mapping->i_pages,
 						linear_page_index(vma, addr));
-		if (!page)
-			return;
-
 		if (xa_is_value(page))
 			mss->swap += PAGE_SIZE;
-		else
-			put_page(page);
-
 		return;
 	}
 
-- 
2.28.0

