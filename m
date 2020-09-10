Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF3D0264D19
	for <lists+cgroups@lfdr.de>; Thu, 10 Sep 2020 20:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgIJSeR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 10 Sep 2020 14:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbgIJSeC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 10 Sep 2020 14:34:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7394C061798;
        Thu, 10 Sep 2020 11:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=O3f4pJZULtJ0Hg2fNHWuRs5XcF+sc7d6/Hzv1fj3FPw=; b=K31IH21Tut9dcJNTkS09h6hBMc
        zzqUmjTdSEGz7kbkojcnDkmNauqqxB7FbXhHGDpsxcJhPWRcqSYX0le9QfA9DkUTleaOsDu76FXdT
        3AdUKzs5yHbqQq3g1sP4PZsgZQkYfiNcQgmItXFGklo37jxy/0YO6B1YYw9zFBHlrFKptdYs3itjz
        LbBbGz1kjShY7XpdkW2tr/ARbYgUzKLJbGFBcZRovkONmt0heqXfLfc1Q/7MqGrFAeh1pfKxrHrJv
        VNm5Xs5VZPTA+FKeangibdYPtMCLGkGhe1oY8JSdJ8LyauGiq0l3DmjoxI8ToSbCB1zDsYU632iZa
        dvs7zhXw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGRNn-0005FX-SV; Thu, 10 Sep 2020 18:33:19 +0000
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
Subject: [PATCH v2 0/8] Return head pages from find_*_entry
Date:   Thu, 10 Sep 2020 19:33:10 +0100
Message-Id: <20200910183318.20139-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This patch series started out as part of the THP patch set, but it has
some nice effects along the way and it seems worth splitting it out and
submitting separately.

Currently find_get_entry() and find_lock_entry() return the page
corresponding to the requested index, but the first thing most callers do
is find the head page, which we just threw away.  As part of auditing
all the callers, I found some misuses of the APIs and some plain
inefficiencies that I've fixed.

The diffstat is unflattering, but I added more kernel-doc and a new wrapper.

v2:
 - Rework how shmem_getpage_gfp() handles getting a head page back from
   find_lock_entry()
 - Renamed find_get_swap_page() to find_get_incore_page()
 - Make sure find_get_incore_page() doesn't return a head page
 - Fix the missing include of linux/shmem_fs.h
 - Move find_get_entry and find_lock_entry prototypes to mm/internal.h
 - Rename thp_valid_index() to thp_contains()
 - Fix thp_contains() for hugetlbfs and swapcache
 - Add find_lock_head() wrapper around pagecache_get_page()

Matthew Wilcox (Oracle) (8):
  mm: Factor find_get_incore_page out of mincore_page
  mm: Use find_get_incore_page in memcontrol
  mm: Optimise madvise WILLNEED
  proc: Optimise smaps for shmem entries
  i915: Use find_lock_page instead of find_lock_entry
  mm: Convert find_get_entry to return the head page
  mm/shmem: Return head page from find_lock_entry
  mm: Add find_lock_head

 drivers/gpu/drm/i915/gem/i915_gem_shmem.c |  4 +--
 fs/proc/task_mmu.c                        |  8 +----
 include/linux/pagemap.h                   | 43 +++++++++++++++++-----
 include/linux/swap.h                      |  7 ++++
 mm/filemap.c                              | 44 +++++++++++------------
 mm/internal.h                             |  3 ++
 mm/madvise.c                              | 21 ++++++-----
 mm/memcontrol.c                           | 24 ++-----------
 mm/mincore.c                              | 28 ++-------------
 mm/shmem.c                                | 20 +++++------
 mm/swap_state.c                           | 32 +++++++++++++++++
 11 files changed, 127 insertions(+), 107 deletions(-)

-- 
2.28.0

