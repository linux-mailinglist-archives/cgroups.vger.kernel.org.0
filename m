Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23971781410
	for <lists+cgroups@lfdr.de>; Fri, 18 Aug 2023 22:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379880AbjHRUGu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 18 Aug 2023 16:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379885AbjHRUGl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 18 Aug 2023 16:06:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AB32102;
        Fri, 18 Aug 2023 13:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=hBTE4z1qFRK8GKVkm74TePYQyzNHYl26/C9WeYlReVs=; b=nCMQUJtkYsiL9VLEqUAbyMPRNU
        FkMc5ws1uHU5C7DeZssEFP6ua822AKo3VO0PvVhd6XFmc4viXKfWrynUKg+8rvSUk/rbq6DZa6JZY
        Pk82WHNbCI/6AjlbREUTYzzcPcFkqTBS4vZ4YzaclfawVnVQ7A1nM7TYp/okctf3RoFGtFPkGXXw5
        cNLUdxTup4Yqp9SiwXSKm/JuLnPYGad0o84JGBV04hdcelsREQakr7eapSVsU5hOV8vKRQUzfYAev
        V58r161EPRq1WZ+sNB3X/ELtxoGemEq849+vHpH1TzzZJfT2nk7dVfoDJfWoCm0WRLzWAO+CjdI7+
        iNXer5Mw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qX5js-00BPV8-HE; Fri, 18 Aug 2023 20:06:32 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, Mike Rapoport <rppt@kernel.org>,
        linux-doc@vger.kernel.org, cgroups@vger.kernel.org
Subject: [PATCH 1/4] mm: Fix kernel-doc warning from tlb_flush_rmaps()
Date:   Fri, 18 Aug 2023 21:06:27 +0100
Message-Id: <20230818200630.2719595-2-willy@infradead.org>
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

The vma parameter wasn't described.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/mmu_gather.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index ea9683e12936..4f559f4ddd21 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -63,6 +63,7 @@ static void tlb_flush_rmap_batch(struct mmu_gather_batch *batch, struct vm_area_
 /**
  * tlb_flush_rmaps - do pending rmap removals after we have flushed the TLB
  * @tlb: the current mmu_gather
+ * @vma: The memory area from which the pages are being removed.
  *
  * Note that because of how tlb_next_batch() above works, we will
  * never start multiple new batches with pending delayed rmaps, so
-- 
2.40.1

