Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E24962AEA28
	for <lists+cgroups@lfdr.de>; Wed, 11 Nov 2020 08:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgKKH2P (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 11 Nov 2020 02:28:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbgKKH2K (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 11 Nov 2020 02:28:10 -0500
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30453C0613D4
        for <cgroups@vger.kernel.org>; Tue, 10 Nov 2020 23:28:11 -0800 (PST)
Received: by mail-oo1-xc44.google.com with SMTP id y3so219988ooq.2
        for <cgroups@vger.kernel.org>; Tue, 10 Nov 2020 23:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=DkcV1x7MgfBS236GtgzpXoMpSPJBXCFSqYnEz2asS8Y=;
        b=Gf4tMT9irso5W1qAZaQwEIQlLc3fBbqGXy95E/Xm26rt6qFj3o/whHQ2xSvngDlqYF
         +vJUBG9fAZrNuVlOA2/pgxsCcs+9epBcBrAWtNFVQKW2WZk8qjMPoyBWWBuqh7OCHJjt
         dUAHkYVjqsx9e9QbCBr8oznfG0H/DVtWt8iwN8Xrq1XUdCjDyrqOPb3m3o/Vco87M76t
         3+5Ka0GhgcEy1jngP+hKdR+QfAVxpZSSyL+K/aL/gmDpirv0lu7X6Bo+RoKAAycLxRXL
         5Rdkwa4r3TqZyyWgSD+i5GkOhkQlSKG5Ib1aweIyfEM7O5r+WQkKzqz0U8SgnKu0G15/
         fWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=DkcV1x7MgfBS236GtgzpXoMpSPJBXCFSqYnEz2asS8Y=;
        b=kDuhtlLcR3x6FlsmJb68YHnJHVOOxYC0w6ZRrUBppSRLwzP4pabO42ucI9tSqkdqQb
         2zP/yclMQ9uIitUZmHmc3nmtw9/nHAoDdizdIoDI5WxAJZU/pehVsgKfZLzAasCRCEet
         lMDrZihUSqQep9KpJifGLKekt6abSpWSq2LBuhyI8Ywd9E6rDvxS5scqpNlLlC+fGzNV
         y5JQoF3Mxs5nIMj8I6vUGW7NwhE+bLgn6ORbGKOglikfUedFecAJhP/yEdKUS//1awQZ
         RMa3MVjq7BpQBNxDakpxPMeerK5+TAYpZvlqEU7RGaEWqAo/liAMo8qg+uRIgQMh1lSD
         R03Q==
X-Gm-Message-State: AOAM531ioUGnohLtFSpd3/Vk+JAR3SdB1RTlomJunQ/f/O3A+Ms24hEe
        yamutf+ZSmXnt6LBwTtFk319+Q==
X-Google-Smtp-Source: ABdhPJzL1ToOpmmFpblyXPcpRbSl5YEfquIJpnotyhSxXxlp+lwCXytEgF+mxcgvDW5vfPNiX4gDnA==
X-Received: by 2002:a4a:b3c5:: with SMTP id q5mr1122260ooo.60.1605079690270;
        Tue, 10 Nov 2020 23:28:10 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id w14sm378030oou.16.2020.11.10.23.28.07
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 10 Nov 2020 23:28:09 -0800 (PST)
Date:   Tue, 10 Nov 2020 23:27:54 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Johannes Weiner <hannes@cmpxchg.org>
cc:     Alex Shi <alex.shi@linux.alibaba.com>, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        willy@infradead.org, lkp@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        shakeelb@google.com, iamjoonsoo.kim@lge.com,
        richard.weiyang@gmail.com, kirill@shutemov.name,
        alexander.duyck@gmail.com, rong.a.chen@intel.com, mhocko@suse.com,
        vdavydov.dev@gmail.com, shy828301@gmail.com,
        Vlastimil Babka <vbabka@suse.cz>,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH v20 08/20] mm: page_idle_get_page() does not need
 lru_lock
In-Reply-To: <20201102144110.GB724984@cmpxchg.org>
Message-ID: <alpine.LSU.2.11.2011102244420.1183@eggly.anvils>
References: <1603968305-8026-1-git-send-email-alex.shi@linux.alibaba.com> <1603968305-8026-9-git-send-email-alex.shi@linux.alibaba.com> <20201102144110.GB724984@cmpxchg.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 2 Nov 2020, Johannes Weiner wrote:
> On Thu, Oct 29, 2020 at 06:44:53PM +0800, Alex Shi wrote:
> > From: Hugh Dickins <hughd@google.com>
> > 
> > It is necessary for page_idle_get_page() to recheck PageLRU() after
> > get_page_unless_zero(), but holding lru_lock around that serves no
> > useful purpose, and adds to lru_lock contention: delete it.
> > 
> > See https://lore.kernel.org/lkml/20150504031722.GA2768@blaptop for the
> > discussion that led to lru_lock there; but __page_set_anon_rmap() now
> > uses WRITE_ONCE(),
> 
> That doesn't seem to be the case in Linus's or Andrew's tree. Am I
> missing a dependent patch series?

Sorry, I was out of action, then slower than ever, for a while.

Many thanks for calling out my falsehood there, Johannes.

What led me to write that?  It has baffled me, but at last I see:
this patch to page_idle_get_page() was 0002 in my lru_lock patchset
against v5.3 last year, and 0001 was the patch which made it true.
Then when I checked against mainline, I must have got confused by
the similar WRITE_ONCE in page_move_anon_rmap().

Appended below, but not rediffed, and let's not hold up Alex's set
for the rest of it: it is all theoretical until the kernel gets to
be built with a suitably malicious compiler; but I'll follow up
with a fresh version of the below after his set is safely in.

From a1abcbc2aac70c6ba47b8991992bb85b86b4a160 Mon Sep 17 00:00:00 2001
From: Hugh Dickins <hughd@google.com>
Date: Thu, 22 Aug 2019 15:49:44 -0700
Subject: [PATCH 1/9] mm: more WRITE_ONCE and READ_ONCE on page->mapping

v4.2 commit 414e2fb8ce5a ("rmap: fix theoretical race between do_wp_page
and shrink_active_list") added a WRITE_ONCE() where page_move_anon_rmap()
composes page->mapping from anon_vma pointer and PAGE_MAPPING_ANON.

Now do the same where __page_set_anon_rmap() does the same, and where
compaction.c applies PAGE_MAPPING_MOVABLE, and ksm.c PAGE_MAPPING_KSM.

rmap.c already uses READ_ONCE(page->mapping), but util.c should too:
add READ_ONCE() in page_rmapping(), page_anon_vma() and page_mapping().
Delete the then unused helper __page_rmapping().

I doubt that this commit fixes anything, but it's harmless and
unintrusive, and makes reasoning about page mapping flags easier.

What if a compiler implements "page->mapping = mapping" in other places
by, say, first assigning the odd bits of mapping, then adding in the
even bits?  Then we shall not build the kernel with such a compiler.

Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Alex Shi <alex.shi@linux.alibaba.com>
---
 mm/compaction.c |  7 ++++---
 mm/ksm.c        |  2 +-
 mm/rmap.c       |  7 ++++++-
 mm/util.c       | 24 ++++++++++--------------
 4 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 952dc2fb24e5..c405f4362624 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -113,7 +113,8 @@ void __SetPageMovable(struct page *page, struct address_space *mapping)
 {
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
 	VM_BUG_ON_PAGE((unsigned long)mapping & PAGE_MAPPING_MOVABLE, page);
-	page->mapping = (void *)((unsigned long)mapping | PAGE_MAPPING_MOVABLE);
+	WRITE_ONCE(page->mapping,
+		   (unsigned long)mapping | PAGE_MAPPING_MOVABLE);
 }
 EXPORT_SYMBOL(__SetPageMovable);
 
@@ -126,8 +127,8 @@ void __ClearPageMovable(struct page *page)
 	 * flag so that VM can catch up released page by driver after isolation.
 	 * With it, VM migration doesn't try to put it back.
 	 */
-	page->mapping = (void *)((unsigned long)page->mapping &
-				PAGE_MAPPING_MOVABLE);
+	WRITE_ONCE(page->mapping,
+		   (unsigned long)page->mapping & PAGE_MAPPING_MOVABLE);
 }
 EXPORT_SYMBOL(__ClearPageMovable);
 
diff --git a/mm/ksm.c b/mm/ksm.c
index 3dc4346411e4..426b6a40ea41 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -865,7 +865,7 @@ static inline struct stable_node *page_stable_node(struct page *page)
 static inline void set_page_stable_node(struct page *page,
 					struct stable_node *stable_node)
 {
-	page->mapping = (void *)((unsigned long)stable_node | PAGE_MAPPING_KSM);
+	WRITE_ONCE(page->mapping, (unsigned long)stable_node | PAGE_MAPPING_KSM);
 }
 
 #ifdef CONFIG_SYSFS
diff --git a/mm/rmap.c b/mm/rmap.c
index 003377e24232..9480df437edc 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1044,7 +1044,12 @@ static void __page_set_anon_rmap(struct page *page,
 		anon_vma = anon_vma->root;
 
 	anon_vma = (void *) anon_vma + PAGE_MAPPING_ANON;
-	page->mapping = (struct address_space *) anon_vma;
+	/*
+	 * Ensure that anon_vma and the PAGE_MAPPING_ANON bit are written
+	 * simultaneously, so a concurrent reader (eg page_referenced()'s
+	 * PageAnon()) will not see one without the other.
+	 */
+	WRITE_ONCE(page->mapping, (struct address_space *) anon_vma);
 	page->index = linear_page_index(vma, address);
 }
 
diff --git a/mm/util.c b/mm/util.c
index e6351a80f248..09b9fcbedac3 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -489,21 +489,14 @@ void kvfree(const void *addr)
 }
 EXPORT_SYMBOL(kvfree);
 
-static inline void *__page_rmapping(struct page *page)
-{
-	unsigned long mapping;
-
-	mapping = (unsigned long)page->mapping;
-	mapping &= ~PAGE_MAPPING_FLAGS;
-
-	return (void *)mapping;
-}
-
 /* Neutral page->mapping pointer to address_space or anon_vma or other */
 void *page_rmapping(struct page *page)
 {
+	unsigned long mapping;
+
 	page = compound_head(page);
-	return __page_rmapping(page);
+	mapping = (unsigned long)READ_ONCE(page->mapping);
+	return (void *)(mapping & ~PAGE_MAPPING_FLAGS);
 }
 
 /*
@@ -534,10 +527,11 @@ struct anon_vma *page_anon_vma(struct page *page)
 	unsigned long mapping;
 
 	page = compound_head(page);
-	mapping = (unsigned long)page->mapping;
+	mapping = (unsigned long)READ_ONCE(page->mapping);
+	/* Return NULL if file or PageMovable or PageKsm */
 	if ((mapping & PAGE_MAPPING_FLAGS) != PAGE_MAPPING_ANON)
 		return NULL;
-	return __page_rmapping(page);
+	return (struct anon_vma *)(mapping & ~PAGE_MAPPING_FLAGS);
 }
 
 struct address_space *page_mapping(struct page *page)
@@ -557,10 +551,12 @@ struct address_space *page_mapping(struct page *page)
 		return swap_address_space(entry);
 	}
 
-	mapping = page->mapping;
+	mapping = READ_ONCE(page->mapping);
+	/* Return NULL if PageAnon (including PageKsm) */
 	if ((unsigned long)mapping & PAGE_MAPPING_ANON)
 		return NULL;
 
+	/* Return struct address_space pointer if file or PageMovable */
 	return (void *)((unsigned long)mapping & ~PAGE_MAPPING_FLAGS);
 }
 EXPORT_SYMBOL(page_mapping);
-- 
2.23.0.187.g17f5b7556c-goog
