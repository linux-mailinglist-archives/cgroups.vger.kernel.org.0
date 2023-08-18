Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D14A781418
	for <lists+cgroups@lfdr.de>; Fri, 18 Aug 2023 22:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379889AbjHRUHV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 18 Aug 2023 16:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379886AbjHRUGu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 18 Aug 2023 16:06:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE421BD4;
        Fri, 18 Aug 2023 13:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=vsBXmbIBGjgL8OAsP8lhIU5HpuKdHOAcVbKVff35yq0=; b=rkSXXrRqZSDngZsXaXS1lbcvKi
        QcxZl8fRtvl2u5og3DaZCgWwOd8wNJiUmPuNozZFhK4Rp2yqmIrBH6RtwP++DppbgOZSGlhwnIezt
        e1vasqNE2W4aZU+QTDwKwQiw25UEVta9LR0f40lR26wYW8zzUOaRhROTU2QP+RCM811qjbWcygzK2
        7Vuyv70yxpieq2E6NKpJanmkNqbcKLdBa6fsqSwE7FViFyinr4zEmkSFCp68hihuKk5XIqq9+GNHL
        fGl5oRgErGTMT2HUat8VgevjzrG6L30Rgiwy1OXl6ZCChibpTt3+MbcOEm7yqywAdIuemdd9xrcze
        90jN3SXw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qX5js-00BPVC-MY; Fri, 18 Aug 2023 20:06:32 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, Mike Rapoport <rppt@kernel.org>,
        linux-doc@vger.kernel.org, cgroups@vger.kernel.org
Subject: [PATCH 3/4] mm: Fix clean_record_shared_mapping_range kernel-doc
Date:   Fri, 18 Aug 2023 21:06:29 +0100
Message-Id: <20230818200630.2719595-4-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230818200630.2719595-1-willy@infradead.org>
References: <20230818200630.2719595-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Turn the a), b) into an unordered ReST list and remove the unnecessary
'Note:' prefix.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/mapping_dirty_helpers.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/mm/mapping_dirty_helpers.c b/mm/mapping_dirty_helpers.c
index a26dd8bcfcdb..2f8829b3541a 100644
--- a/mm/mapping_dirty_helpers.c
+++ b/mm/mapping_dirty_helpers.c
@@ -288,13 +288,14 @@ EXPORT_SYMBOL_GPL(wp_shared_mapping_range);
  * @end: Pointer to the number of the last set bit in @bitmap.
  * none set. The value is modified as new bits are set by the function.
  *
- * Note: When this function returns there is no guarantee that a CPU has
+ * When this function returns there is no guarantee that a CPU has
  * not already dirtied new ptes. However it will not clean any ptes not
  * reported in the bitmap. The guarantees are as follows:
- * a) All ptes dirty when the function starts executing will end up recorded
- *    in the bitmap.
- * b) All ptes dirtied after that will either remain dirty, be recorded in the
- *    bitmap or both.
+ *
+ * * All ptes dirty when the function starts executing will end up recorded
+ *   in the bitmap.
+ * * All ptes dirtied after that will either remain dirty, be recorded in the
+ *   bitmap or both.
  *
  * If a caller needs to make sure all dirty ptes are picked up and none
  * additional are added, it first needs to write-protect the address-space
-- 
2.40.1

