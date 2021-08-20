Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C74E3F29B9
	for <lists+cgroups@lfdr.de>; Fri, 20 Aug 2021 12:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237133AbhHTKCQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 20 Aug 2021 06:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236384AbhHTKCQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 20 Aug 2021 06:02:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BD6C061575
        for <cgroups@vger.kernel.org>; Fri, 20 Aug 2021 03:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=OeK3I+1l0xomijoHvRqsdYXTySAGsZIzhVjcZsSq7U0=; b=Zr3DitrUpEOFcENF3OtghGRMLi
        kSUsgxxHghHOEjCYGgRPXlA0lGc838SHvugAnpoCt9BGKLn8a9GKOb3w5SEniekSW4MniHzDudrMq
        FOM0PxBd4/+2W7NQdVAEQb38Z5mJThI9xEIn/j6EdEKjhfh3G+/Vga5+wjgTWtn0qdbVOUJx+TVE/
        9c0JEFuHSbGtKTzjmYvP2YD2j3Emx3fJA849JqG1QmIQIzDxKAcoNWFcNYt17VJrIOODWOBe9vfDb
        7M61rDO+x9gTFoWQhuRgIse2pGdxFHyW9VNIkOBCHZWXDZDW7/FTeSKhAJQrTjRkWNwYqt7ew8BP4
        Bqpg/Mbw==;
Received: from [2001:4bb8:188:1b1:43a3:4b88:ec18:d4de] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mH1Ip-006LIh-GW; Fri, 20 Aug 2021 09:59:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 1/2] mm: unexport folio_memcg_{,un}lock
Date:   Fri, 20 Aug 2021 11:58:14 +0200
Message-Id: <20210820095815.445392-2-hch@lst.de>
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
index 45a160894a035..4cb4349065931 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2014,7 +2014,6 @@ void folio_memcg_lock(struct folio *folio)
 	memcg->move_lock_task = current;
 	memcg->move_lock_flags = flags;
 }
-EXPORT_SYMBOL(folio_memcg_lock);
 
 void lock_page_memcg(struct page *page)
 {
@@ -2048,7 +2047,6 @@ void folio_memcg_unlock(struct folio *folio)
 {
 	__folio_memcg_unlock(folio_memcg(folio));
 }
-EXPORT_SYMBOL(folio_memcg_unlock);
 
 void unlock_page_memcg(struct page *page)
 {
-- 
2.30.2

