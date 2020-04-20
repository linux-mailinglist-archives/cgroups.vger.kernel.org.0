Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C175D1B190C
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2020 00:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgDTWLj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 20 Apr 2020 18:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbgDTWLj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 20 Apr 2020 18:11:39 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C22C061A0E
        for <cgroups@vger.kernel.org>; Mon, 20 Apr 2020 15:11:39 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id p19so5613628qve.0
        for <cgroups@vger.kernel.org>; Mon, 20 Apr 2020 15:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RujGPQ/aToLYsclK+dnkQViuIsABafgZ1mMvYzjDw+g=;
        b=W5pshhSfzWc52vhfUDfjZfdL/VdXS7EEmH4WjupWl3cqVRvkzHRdMif9qdTKIowIS8
         jtAAJQYEqixojOHZBAwYKYIBNXmiy8H0Znbn4GFingRmwQ/ryMs/wRbcV99z5DKszZwZ
         GbgekrRWQE4KOkzLdPImbNSlOrGNU8w67KZmcdmNmfQOQVhtUaPVQiBErlyrTzPIcazY
         BRDGb/AZnkYJcLUppRNHWkNHEhMfWC4TcYa+/yWj+QlRtp3A+M3prGSzj0ZLK2Nu+BF0
         flSMwNBRQYoSupuvRlDAnT/pL5UqpV/xfRbMu34r/69y9f8lmUPSyX8hJ2LF1Afg5ZiR
         aLhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RujGPQ/aToLYsclK+dnkQViuIsABafgZ1mMvYzjDw+g=;
        b=Vbzn0GvpAfg1ILW/EizODFr+oblAfiX+2heyGbLhJiIJN6CJAiBpvuVDktxEnMlwW8
         DlZNaN/Gz/cV6ORCirQuvg+KSQz1ro4NjhZ81xY0DYg5FS6B2uYtYFg4pCckaUAXKUah
         KsImL0/H+WQohPXuv6HsjbFAt0q7PWnuXueapnp568HnoMXPS1LrWY6ZNBdF6nNnDltU
         klFA4FE5ZkQ5I9yA4DVQzleXlEkpbRJWBEatLqfvrAyhJjRCinUjsHKA0ruO0qeFyBAj
         lRVZk4vn8u4nSHR9XS6Zhn1xckUerMU0xEiva4ex/4d7nLS7WvroC3QV3nES6ZyAP7P6
         +bDg==
X-Gm-Message-State: AGi0PuaejZNKA6nhxGJbSz7ubfdv5le+76mQhMfj2r6y0R6IjLiaQ9S+
        HExTuuXiG5rKaNKRIfJM7nw2uA==
X-Google-Smtp-Source: APiQypKHvBq1G1X6GokIqQMrcn6gfp4oAZoCTpAjG1OT2zuEPvkxv8ga5ahrNVdcrKu2Sq1g82edeQ==
X-Received: by 2002:a0c:fd8c:: with SMTP id p12mr17566981qvr.163.1587420698518;
        Mon, 20 Apr 2020 15:11:38 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:e6b6])
        by smtp.gmail.com with ESMTPSA id s125sm622755qkf.9.2020.04.20.15.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 15:11:37 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Joonsoo Kim <js1304@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 00/18] mm: memcontrol: charge swapin pages on instantiation
Date:   Mon, 20 Apr 2020 18:11:08 -0400
Message-Id: <20200420221126.341272-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This patch series reworks memcg to charge swapin pages directly at
swapin time, rather than at fault time, which may be much later, or
not happen at all.

The delayed charging scheme we have right now causes problems:

- Alex's per-cgroup lru_lock patches rely on pages that have been
  isolated from the LRU to have a stable page->mem_cgroup; otherwise
  the lock may change underneath him. Swapcache pages are charged only
  after they are added to the LRU, and charging doesn't follow the LRU
  isolation protocol.

- Joonsoo's anon workingset patches need a suitable LRU at the time
  the page enters the swap cache and displaces the non-resident
  info. But the correct LRU is only available after charging.

- It's a containment hole / DoS vector. Users can trigger arbitrarily
  large swap readahead using MADV_WILLNEED. The memory is never
  charged unless somebody actually touches it.

- It complicates the page->mem_cgroup stabilization rules

In order to charge pages directly at swapin time, the memcg code base
needs to be prepared, and several overdue cleanups become a necessity:

To charge pages at swapin time, we need to always have cgroup
ownership tracking of swap records. We also cannot rely on
page->mapping to tell apart page types at charge time, because that's
only set up during a page fault.

To eliminate the page->mapping dependency, memcg needs to ditch its
private page type counters (MEMCG_CACHE, MEMCG_RSS, NR_SHMEM) in favor
of the generic vmstat counters and accounting sites, such as
NR_FILE_PAGES, NR_ANON_MAPPED etc.

To switch to generic vmstat counters, the charge sequence must be
adjusted such that page->mem_cgroup is set up by the time these
counters are modified.

The series is structured as follows:

1. Bug fixes
2. Decoupling charging from rmap
3. Swap controller integration into memcg
4. Direct swapin charging

The patches survive a simple swapout->swapin test inside a virtual
machine. Because this is blocking two major patch sets, I'm sending
these out early and will continue testing in parallel to the review.

 include/linux/memcontrol.h |  53 +----
 include/linux/mm.h         |   4 +-
 include/linux/swap.h       |   6 +-
 init/Kconfig               |  17 +-
 kernel/events/uprobes.c    |  10 +-
 mm/filemap.c               |  43 ++---
 mm/huge_memory.c           |  45 ++---
 mm/khugepaged.c            |  25 +--
 mm/memcontrol.c            | 448 ++++++++++++++-----------------------------
 mm/memory.c                |  51 ++---
 mm/migrate.c               |  20 +-
 mm/rmap.c                  |  53 +++--
 mm/shmem.c                 | 117 +++++------
 mm/swap_cgroup.c           |   6 -
 mm/swap_state.c            |  89 +++++----
 mm/swapfile.c              |  25 +--
 mm/userfaultfd.c           |   5 +-
 17 files changed, 367 insertions(+), 650 deletions(-)


