Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D813B7C57
	for <lists+cgroups@lfdr.de>; Wed, 30 Jun 2021 06:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbhF3EFF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Jun 2021 00:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhF3EFF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Jun 2021 00:05:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3487C061760
        for <cgroups@vger.kernel.org>; Tue, 29 Jun 2021 21:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=4M1RMjp1sHStCMlmNe7eYn2fAPfqamAD/pAGYiqL3n0=; b=UwhPCJerldFihrwtXHNJHqabcZ
        YOMDupabJSqcrUfNNo3/nalt5CP2DtpDO9MlQq4bzk/jMonK/U9FciycMAGimGYPIxM0li0CXco9a
        qwTqO4VIVW3DRZ2uWG0SSbaobc3Tb0zEsakks3F9N79CV+PgsSVmYGHAI6XoW6ljE/BlDVPjBokY1
        FBKnqsCKNguz89FOlIWYpP9NMuw78GhS83wDZPIUmxBLVV27LttCUgTEmZ5O/VVhIBRM7e/aVtIoQ
        BjpRB3m03CXKYuck65gL8JB6qQdqk2hy6eXMti3FXpaFVUxn/g8KHqPQdWDBZBuHEvdcKQuwVIGem
        Jvy3SiHA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lyRPh-004qkb-NG; Wed, 30 Jun 2021 04:01:43 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, cgroups@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: [PATCH v3 01/18] mm: Add folio_nid()
Date:   Wed, 30 Jun 2021 05:00:17 +0100
Message-Id: <20210630040034.1155892-2-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210630040034.1155892-1-willy@infradead.org>
References: <20210630040034.1155892-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This is the folio equivalent of page_to_nid().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7ad3c8a115ae..48d2ccd9f8c3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1429,6 +1429,11 @@ static inline int page_to_nid(const struct page *page)
 }
 #endif
 
+static inline int folio_nid(const struct folio *folio)
+{
+	return page_to_nid(&folio->page);
+}
+
 #ifdef CONFIG_NUMA_BALANCING
 static inline int cpu_pid_to_cpupid(int cpu, int pid)
 {
-- 
2.30.2

