Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86BAD3F29BD
	for <lists+cgroups@lfdr.de>; Fri, 20 Aug 2021 12:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237139AbhHTKDG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 20 Aug 2021 06:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237006AbhHTKDF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 20 Aug 2021 06:03:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54EB9C061575
        for <cgroups@vger.kernel.org>; Fri, 20 Aug 2021 03:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=nzUrzTYf+SxA9DhkR1ixsQBSLVoS1UsUtkY4TuBivPg=; b=JoPBlcJiFqV74veGWFe1sBI6Ng
        sSqpzCCSwBgVyHB08j9McLOlR3cKFBhyMcM5xzEaYClvs4XfWxXAuSHiC9pg7sCuqkRwfYygAa5gd
        qy3YJIAzot89NYNSk2ntP5jTiUBj05ROneWiPfxBo6F3HTFopgpp+RWecy19gWmSuafxTkyxR9CRh
        X+sYrZArif2/DzhEAuXF4thtO+TjEybpgk7bks4HCQuY9KPg4zHXxwbG96bBpDUDCdX97Sb9OsYHF
        iz3omvxWYed9N8aa6GScN9rCBQXVl7aWy9JbdSH0rob2x6BHLJ6atPqy2+vd5l9hz03G3V9AUFw3n
        FTiz/57w==;
Received: from [2001:4bb8:188:1b1:43a3:4b88:ec18:d4de] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mH1Jw-006LLa-Tk; Fri, 20 Aug 2021 10:00:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 2/2] mm: unexport {,un}lock_page_memcg
Date:   Fri, 20 Aug 2021 11:58:15 +0200
Message-Id: <20210820095815.445392-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210820095815.445392-1-hch@lst.de>
References: <20210820095815.445392-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

These are only used in built-in core mm code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/memcontrol.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4cb4349065931..6a74a180e3eae 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2019,7 +2019,6 @@ void lock_page_memcg(struct page *page)
 {
 	folio_memcg_lock(page_folio(page));
 }
-EXPORT_SYMBOL(lock_page_memcg);
 
 static void __folio_memcg_unlock(struct mem_cgroup *memcg)
 {
@@ -2052,7 +2051,6 @@ void unlock_page_memcg(struct page *page)
 {
 	folio_memcg_unlock(page_folio(page));
 }
-EXPORT_SYMBOL(unlock_page_memcg);
 
 struct obj_stock {
 #ifdef CONFIG_MEMCG_KMEM
-- 
2.30.2

