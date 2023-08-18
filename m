Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90495781412
	for <lists+cgroups@lfdr.de>; Fri, 18 Aug 2023 22:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379879AbjHRUGu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 18 Aug 2023 16:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379886AbjHRUGl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 18 Aug 2023 16:06:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAD11BD4;
        Fri, 18 Aug 2023 13:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=HEUqudgPIORhVtUepujoEAHkjLRlCh4kIh4ylDVS334=; b=fOFUrOiJoU+PYtWXIoWPp0biHN
        1Iq2DbevP7Pj0Xo/lF1SpR5VllaM/JQGPznG3Hqk5Xwy0HQgNVBF0kqx56qtEkZ9YveSgLQD5ltey
        HeNAHPvW1If7K5JSc3kmmXIjsUGO4iKiKBZQUwC3r8p9h2WDYgK3axUogZZCbsRn9hyNh1W20nr5P
        jSNtiUDZRYo/5plPR1Q6xFGlrqFsptza3FrnkXM1My+Io2Fq3aTUTxMGlURxE9wEeOvYOOEmk1ZYz
        VuC0LdL2kbXOmnQwLGUSJJ+Ewit+QsdinLFP3OXV0FInJsbi4m5MR5SvQm02k8nwnErrrcqgx38am
        qKtG6Lqw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qX5js-00BPVE-PK; Fri, 18 Aug 2023 20:06:32 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, Mike Rapoport <rppt@kernel.org>,
        linux-doc@vger.kernel.org, cgroups@vger.kernel.org
Subject: [PATCH 4/4] mm: Add orphaned kernel-doc to the rst files.
Date:   Fri, 18 Aug 2023 21:06:30 +0100
Message-Id: <20230818200630.2719595-5-willy@infradead.org>
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

There are many files in mm/ that contain kernel-doc which is not
currently published on kernel.org.  Some of it is easily categorisable,
but most of it is going into the miscellaneous documentation section to
be organised later.

Some files aren't ready to be included; they contain documentation with
build errors.  Or they're nommu.c which duplicates documentation from
"real" MMU systems.  Those files are noted with a # mark (although really
anything which isn't a recognised directive would do to prevent inclusion)

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 Documentation/core-api/mm-api.rst | 25 +++++++++++++++++++++++++
 Documentation/mm/highmem.rst      |  1 +
 Documentation/mm/zsmalloc.rst     |  5 +++++
 3 files changed, 31 insertions(+)

diff --git a/Documentation/core-api/mm-api.rst b/Documentation/core-api/mm-api.rst
index f5dde5bceaea..2d091c873d1e 100644
--- a/Documentation/core-api/mm-api.rst
+++ b/Documentation/core-api/mm-api.rst
@@ -115,3 +115,28 @@ More Memory Management Functions
 .. kernel-doc:: include/linux/mmzone.h
 .. kernel-doc:: mm/util.c
    :functions: folio_mapping
+
+.. kernel-doc:: mm/rmap.c
+.. kernel-doc:: mm/migrate.c
+.. kernel-doc:: mm/mmap.c
+.. kernel-doc:: mm/kmemleak.c
+.. #kernel-doc:: mm/hmm.c (build warnings)
+.. kernel-doc:: mm/memremap.c
+.. kernel-doc:: mm/hugetlb.c
+.. kernel-doc:: mm/swap.c
+.. kernel-doc:: mm/zpool.c
+.. kernel-doc:: mm/memcontrol.c
+.. #kernel-doc:: mm/memory-tiers.c (build warnings)
+.. kernel-doc:: mm/shmem.c
+.. kernel-doc:: mm/migrate_device.c
+.. #kernel-doc:: mm/nommu.c (duplicates kernel-doc from other files)
+.. kernel-doc:: mm/mapping_dirty_helpers.c
+.. #kernel-doc:: mm/memory-failure.c (build warnings)
+.. kernel-doc:: mm/percpu.c
+.. kernel-doc:: mm/maccess.c
+.. kernel-doc:: mm/vmscan.c
+.. kernel-doc:: mm/memory_hotplug.c
+.. kernel-doc:: mm/mmu_notifier.c
+.. kernel-doc:: mm/balloon_compaction.c
+.. kernel-doc:: mm/huge_memory.c
+.. kernel-doc:: mm/io-mapping.c
diff --git a/Documentation/mm/highmem.rst b/Documentation/mm/highmem.rst
index fe68e02fc8ff..9d92e3f2b3d6 100644
--- a/Documentation/mm/highmem.rst
+++ b/Documentation/mm/highmem.rst
@@ -209,4 +209,5 @@ Functions
 =========
 
 .. kernel-doc:: include/linux/highmem.h
+.. kernel-doc:: mm/highmem.c
 .. kernel-doc:: include/linux/highmem-internal.h
diff --git a/Documentation/mm/zsmalloc.rst b/Documentation/mm/zsmalloc.rst
index a3c26d587752..76902835e68e 100644
--- a/Documentation/mm/zsmalloc.rst
+++ b/Documentation/mm/zsmalloc.rst
@@ -263,3 +263,8 @@ is heavy internal fragmentation and zspool compaction is unable to relocate
 objects and release zspages. In these cases, it is recommended to decrease
 the limit on the size of the zspage chains (as specified by the
 CONFIG_ZSMALLOC_CHAIN_SIZE option).
+
+Functions
+=========
+
+.. kernel-doc:: mm/zsmalloc.c
-- 
2.40.1

