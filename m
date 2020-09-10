Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8C45264D1B
	for <lists+cgroups@lfdr.de>; Thu, 10 Sep 2020 20:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgIJSee (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 10 Sep 2020 14:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbgIJSeE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 10 Sep 2020 14:34:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23450C061799;
        Thu, 10 Sep 2020 11:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=t4cbRdKf2ijE6kqJJxv8bdn8kFWgLxOFi/schcE0nRE=; b=rNWuYzU1YtoAnXiHJRmR/JtlkT
        oCgCfmfDzsUSKwCARtS/TK+S44gKkkmnhS2j39NPtKkamP3sSBPTDhk0G9H0k/4D7vfFABR+v9+dq
        Xf/Yqryar1Bue7sAFWv82sIm7AHNbrxhjKjp5h/1JLNf5Q4ctkoDa+s2hZ5z541SgJ5ZoBKb8OALD
        XwY/scqtUcymhxGLbQkaEWio8afszwY8uzZpu6Md/nBl/jIqkpiqa8L/PNQR77A/aC8lQeH1OyKnE
        bHfZXhiwmSEqg9jwzcMj/eoxkqfd+rC6tm/tMGjfLuL7DZg/mvNaDifqxPIL/6hn/Z+sQvAVosHyL
        nMDv1z0w==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGRNp-0005GO-6D; Thu, 10 Sep 2020 18:33:21 +0000
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
Subject: [PATCH v2 4/8] proc: Optimise smaps for shmem entries
Date:   Thu, 10 Sep 2020 19:33:14 +0100
Message-Id: <20200910183318.20139-5-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200910183318.20139-1-willy@infradead.org>
References: <20200910183318.20139-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Avoid bumping the refcount on pages when we're only interested in the
swap entries.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
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

