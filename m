Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7609A699FD7
	for <lists+cgroups@lfdr.de>; Thu, 16 Feb 2023 23:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjBPWrD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 Feb 2023 17:47:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjBPWrC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 16 Feb 2023 17:47:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B6146164;
        Thu, 16 Feb 2023 14:47:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BB05DB828B5;
        Thu, 16 Feb 2023 22:47:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6ACC433EF;
        Thu, 16 Feb 2023 22:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1676587619;
        bh=9oeCHSLszN1ZlteZIP+mKzpT4ngVcpBp4cDal0zXZL0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XklABHGuz67Jr6L6q/GiqwCZqRGFa+meW1H0YZ/7JApSIsmEX8CEMBZVPkJ8B+60O
         FlR0T0McnQ+zkZBfm7a39gFwYc8vtAuogsrnhflLLTuwcTv+vtD/qfquyn7FMcATsT
         3jqW32IAcaubqFDEOIYbQmm1CSWaRBHcflvOu1P0=
Date:   Thu, 16 Feb 2023 14:46:58 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        torvalds@linux-foundation.org, sj@kernel.org, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, naoya.horiguchi@nec.com,
        linmiaohe@huawei.com, david@redhat.com, osalvador@suse.de,
        mike.kravetz@oracle.com, damon@lists.linux.dev,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] mm: change to return bool for
 isolate_movable_page()
Message-Id: <20230216144658.18add74d133be070f07cf1f5@linux-foundation.org>
In-Reply-To: <Y+z91pcxAuygc92J@casper.infradead.org>
References: <cover.1676424378.git.baolin.wang@linux.alibaba.com>
        <cb877f73f4fff8d309611082ec740a7065b1ade0.1676424378.git.baolin.wang@linux.alibaba.com>
        <Y+z91pcxAuygc92J@casper.infradead.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, 15 Feb 2023 15:44:22 +0000 Matthew Wilcox <willy@infradead.org> wrote:

> >  extern struct page *alloc_migration_target(struct page *page, unsigned long private);
> > -extern int isolate_movable_page(struct page *page, isolate_mode_t mode);
> > +extern bool isolate_movable_page(struct page *page, isolate_mode_t mode);
> 
> You can drop the 'extern' here.

There are a bunch of them, so a separate patch would be better.


--- a/include/linux/migrate.h~a
+++ a/include/linux/migrate.h
@@ -62,16 +62,16 @@ extern const char *migrate_reason_names[
 
 #ifdef CONFIG_MIGRATION
 
-extern void putback_movable_pages(struct list_head *l);
+void putback_movable_pages(struct list_head *l);
 int migrate_folio_extra(struct address_space *mapping, struct folio *dst,
 		struct folio *src, enum migrate_mode mode, int extra_count);
 int migrate_folio(struct address_space *mapping, struct folio *dst,
 		struct folio *src, enum migrate_mode mode);
-extern int migrate_pages(struct list_head *l, new_page_t new, free_page_t free,
-		unsigned long private, enum migrate_mode mode, int reason,
-		unsigned int *ret_succeeded);
-extern struct page *alloc_migration_target(struct page *page, unsigned long private);
-extern bool isolate_movable_page(struct page *page, isolate_mode_t mode);
+int migrate_pages(struct list_head *l, new_page_t new, free_page_t free,
+		  unsigned long private, enum migrate_mode mode, int reason,
+		  unsigned int *ret_succeeded);
+struct page *alloc_migration_target(struct page *page, unsigned long private);
+bool isolate_movable_page(struct page *page, isolate_mode_t mode);
 
 int migrate_huge_page_move_mapping(struct address_space *mapping,
 		struct folio *dst, struct folio *src);
@@ -142,8 +142,8 @@ const struct movable_operations *page_mo
 }
 
 #ifdef CONFIG_NUMA_BALANCING
-extern int migrate_misplaced_page(struct page *page,
-				  struct vm_area_struct *vma, int node);
+int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
+			   int node);
 #else
 static inline int migrate_misplaced_page(struct page *page,
 					 struct vm_area_struct *vma, int node)
_

