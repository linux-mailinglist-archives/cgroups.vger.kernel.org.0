Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E2A781416
	for <lists+cgroups@lfdr.de>; Fri, 18 Aug 2023 22:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379882AbjHRUGu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 18 Aug 2023 16:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379887AbjHRUGp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 18 Aug 2023 16:06:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD331BD4;
        Fri, 18 Aug 2023 13:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=H22wfoU9WmEkYEOI01RrpJTB8uzVeuDiXA5dlaT4Dc0=; b=DtFJI03cyruQ7/gwxPDSCMj7Mt
        P7ih/uMjbC/Hacz5WgyFcuMutT4pErsivhRTYQEcszmURU+a9Y575Pn7GK61xVl5JRekPeoM89EVX
        ZoP1r+vGiVM1o3Yd71Zr+SowTe+QhoRKq6QridfZAiz2n1aXhpZ0Ny31IQVbh7NUlF/bxVDWiLhN+
        /hsHBY5hsZ/kkSh0S1MTJJXm+CnVRW8d8B/yOBOPvVua6tf9awy+XGYc0GMzJTUej9x7JAz4+lbPQ
        O34tQw0e2/7/EDgYoKrsvSRiHAUmoGY2PoF+R50Ie/03rQ+AYed5NnsHzh3enTnSwUNnxNyUVafeP
        dg+Tw5yQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qX5js-00BPVA-Jw; Fri, 18 Aug 2023 20:06:32 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, Mike Rapoport <rppt@kernel.org>,
        linux-doc@vger.kernel.org, cgroups@vger.kernel.org
Subject: [PATCH 2/4] mm: Fix get_mctgt_type() kernel-doc
Date:   Fri, 18 Aug 2023 21:06:28 +0100
Message-Id: <20230818200630.2719595-3-willy@infradead.org>
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

Convert the return values to an ReST list and tidy up the wording while
I'm touching it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/memcontrol.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e041ba827e59..cd8b3ae6b8d9 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5850,25 +5850,20 @@ static int mem_cgroup_move_account(struct page *page,
  * @ptent: the pte to be checked
  * @target: the pointer the target page or swap ent will be stored(can be NULL)
  *
- * Returns
- *   0(MC_TARGET_NONE): if the pte is not a target for move charge.
- *   1(MC_TARGET_PAGE): if the page corresponding to this pte is a target for
- *     move charge. if @target is not NULL, the page is stored in target->page
- *     with extra refcnt got(Callers should handle it).
- *   2(MC_TARGET_SWAP): if the swap entry corresponding to this pte is a
- *     target for charge migration. if @target is not NULL, the entry is stored
- *     in target->ent.
- *   3(MC_TARGET_DEVICE): like MC_TARGET_PAGE  but page is device memory and
- *   thus not on the lru.
- *     For now we such page is charge like a regular page would be as for all
- *     intent and purposes it is just special memory taking the place of a
- *     regular page.
- *
- *     See Documentations/vm/hmm.txt and include/linux/hmm.h
- *
- * Called with pte lock held.
+ * Context: Called with pte lock held.
+ * Return:
+ * * MC_TARGET_NONE - If the pte is not a target for move charge.
+ * * MC_TARGET_PAGE - If the page corresponding to this pte is a target for
+ *   move charge. If @target is not NULL, the page is stored in target->page
+ *   with extra refcnt got (Callers should handle it).
+ * * MC_TARGET_SWAP - If the swap entry corresponding to this pte is a
+ *   target for charge migration. if @target is not NULL, the entry is stored
+ *   in target->ent.
+ * * MC_TARGET_DEVICE - Like MC_TARGET_PAGE but page is device memory and
+ *   thus not on the lru.  For now such page is charged like a regular page
+ *   would be as it is just special memory taking the place of a regular page.
+ *   See Documentations/vm/hmm.txt and include/linux/hmm.h
  */
-
 static enum mc_target_type get_mctgt_type(struct vm_area_struct *vma,
 		unsigned long addr, pte_t ptent, union mc_target *target)
 {
-- 
2.40.1

