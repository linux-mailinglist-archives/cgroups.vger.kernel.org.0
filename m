Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8409124A641
	for <lists+cgroups@lfdr.de>; Wed, 19 Aug 2020 20:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgHSStX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 19 Aug 2020 14:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbgHSStH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 19 Aug 2020 14:49:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABFEC061383;
        Wed, 19 Aug 2020 11:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=w+HVqr4efGoD6sO5rh6jBUm19i4nXIWL4lYqxm6m+Dw=; b=ZmtYcgiZ5LdbDSIKoVXUG1ouFg
        /hfkSHtfH3uHd26x5DjGqRysCKmmFZ9MCgamFq9q3hfGzI8pECzDcZV9/Nq4ICmOUp0D4/9zRsJb8
        kIixebqo4HfYXJGK7bYVSwORjoUKlHeD68WpP+Yr8GaLfd+gblrSY+C7I1H2PGW/bbSx3NAW72duE
        uDBfPYyqJ3SL/9LtMwu4H1SAx5sI40Rrelt5nfF+kX0367TC4hz0v++1/aFxyPDIhEFDv+Y0HyOG3
        XX9Uttsq1ZrFRlbcEGnwRwLXA1c1OOi5+STQo4WqHMNi0W+Hl0c7U82skzW23ti+d3yK6kof329hs
        9846SOKg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8T8m-0006Sk-C1; Wed, 19 Aug 2020 18:48:52 +0000
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
Subject: [PATCH 0/8] Return head pages from find_get_entry and find_lock_entry
Date:   Wed, 19 Aug 2020 19:48:42 +0100
Message-Id: <20200819184850.24779-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This patch seris started out as part of the THP patch set, but it has
some nice effects along the way and it seems worth splitting it out and
submitting separately.

Currently find_get_entry() and find_lock_entry() return the page
corresponding to the requested index, but the first thing most callers do
is find the head page, which we just threw away.  As part of auditing
all the callers, I found some misuses of the APIs and some plain
inefficiencies that I've fixed.

The diffstat is unflattering, but I added more kernel-doc.

Matthew Wilcox (Oracle) (8):
  mm: Factor find_get_swap_page out of mincore_page
  mm: Use find_get_swap_page in memcontrol
  mm: Optimise madvise WILLNEED
  proc: Optimise smaps for shmem entries
  i915: Use find_lock_page instead of find_lock_entry
  mm: Convert find_get_entry to return the head page
  mm: Return head page from find_lock_entry
  mm: Hoist find_subpage call further up in pagecache_get_page

 drivers/gpu/drm/i915/gem/i915_gem_shmem.c |  4 +--
 fs/proc/task_mmu.c                        |  8 +----
 include/linux/pagemap.h                   | 16 +++++++--
 include/linux/swap.h                      |  7 ++++
 mm/filemap.c                              | 41 +++++++++++------------
 mm/madvise.c                              | 21 +++++++-----
 mm/memcontrol.c                           | 25 ++------------
 mm/mincore.c                              | 28 ++--------------
 mm/shmem.c                                | 15 +++++----
 mm/swap_state.c                           | 31 +++++++++++++++++
 10 files changed, 98 insertions(+), 98 deletions(-)

-- 
2.28.0

