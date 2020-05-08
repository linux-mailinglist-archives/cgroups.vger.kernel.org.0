Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A09DD1CB739
	for <lists+cgroups@lfdr.de>; Fri,  8 May 2020 20:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgEHScN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 8 May 2020 14:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726807AbgEHScN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 8 May 2020 14:32:13 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3166C061A0C
        for <cgroups@vger.kernel.org>; Fri,  8 May 2020 11:32:12 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id p12so2109109qtn.13
        for <cgroups@vger.kernel.org>; Fri, 08 May 2020 11:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tzWVqUZtLwqxtxfWgFUyBr2nPkF3oxF3sVG4yWWQyv0=;
        b=Es4bHoTBFJW5deY/BPRm1w9FSHwlvLmnWbWr+JMeXV7lwHag/PJFMjSaaSHRkttda9
         ZBGMCqHHpexqozMp7joxpOR/FUBqY4fzUJeehlqLgHU0RSat1rj9Q+Xtcmcvp/Xucdmv
         EnHLzezIGvS2TdqxgQDzPqk6rWL/2RluSz8ZmEOU+wRKHuUmU8j/94jtvQvm3nrbytof
         CdDhhdVB5sBwTOP033+p/Ezivg7PnuZbXkMxxaA96tDTehDT8E1FkIS2v56S5APkj/yu
         qL5aCzZbbv0Y8ZY71fsPZmTIfK34i9XIhBcwDrRYYPwGqqTYiLOaoXXXHrj+OeSpZIhe
         IWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tzWVqUZtLwqxtxfWgFUyBr2nPkF3oxF3sVG4yWWQyv0=;
        b=QB8Llix5FRq5UkDgE+6lwoUP9yIyTeQLhgE9209twyIdqntMWf0ti8l3KSHvg1mIFW
         /oGERiL5xWVRHQX8B43upmDiIHWy4cne3SfcPz5lUo+8kfpXy3gqqT6UUp9iATJcvc0C
         UKJg4n8sIIxij7MoCoN+Lf/52SgvJM/V0+WgXYmFpdspHKgnm2c3bF1NDMLdsn9zR9ly
         8z6HfS0Ygvb+Lh/e7DtW0T5KDt1RsFUcyGAwtqNE1MQbGVCMQc69CLFn5VtRc7bR6tMM
         NLM1D85hpoK1heAYvXiS3xaZbvV3/XUbz9Hx0To/cmQTG/c4wbmFHwq/iHbE7F9c5MMZ
         V9Gw==
X-Gm-Message-State: AGi0PuaSEhw5vwbsr6vBkCedh/ulOJBS6QvEWHPK4LVuZKNLxaIdSNWH
        hHy4Kk9HfXyqmIVHBGZYiCAbVw==
X-Google-Smtp-Source: APiQypK7dhstJxBjZrfbvoGmymSVIQmOETHJ+bsToYQ1IK0kyvr9w+WXx+4CHsQzZKydtugQ2QbLDg==
X-Received: by 2002:ac8:2a70:: with SMTP id l45mr4578616qtl.232.1588962731840;
        Fri, 08 May 2020 11:32:11 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2627])
        by smtp.gmail.com with ESMTPSA id g6sm2118974qtc.52.2020.05.08.11.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 11:32:11 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Joonsoo Kim <js1304@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 00/19 V2] mm: memcontrol: charge swapin pages on instantiation
Date:   Fri,  8 May 2020 14:30:47 -0400
Message-Id: <20200508183105.225460-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This patch series reworks memcg to charge swapin pages directly at
swapin time, rather than at fault time, which may be much later, or
not happen at all.

Changes in version 2:
- prevent double charges on pre-allocated hugepages in khugepaged
- leave shmem swapcache when charging fails to avoid double IO (Joonsoo)
- fix temporary accounting bug by switching rmap<->commit (Joonsoo)
- fix double swap charge bug in cgroup1/cgroup2 code gating
- simplify swapin error checking (Joonsoo)
- mm: memcontrol: document the new swap control behavior (Alex)
- review tags

The delayed swapin charging scheme we have right now causes problems:

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

Based on v5.7-rc3-mmots-2020-05-01-20-14.

 Documentation/admin-guide/cgroup-v1/memory.rst |  19 +-
 include/linux/memcontrol.h                     |  53 +--
 include/linux/mm.h                             |   4 +-
 include/linux/swap.h                           |   6 +-
 init/Kconfig                                   |  17 +-
 kernel/events/uprobes.c                        |  10 +-
 mm/filemap.c                                   |  43 +--
 mm/huge_memory.c                               |  13 +-
 mm/khugepaged.c                                |  29 +-
 mm/memcontrol.c                                | 449 +++++++----------------
 mm/memory.c                                    |  51 +--
 mm/migrate.c                                   |  20 +-
 mm/rmap.c                                      |  53 +--
 mm/shmem.c                                     | 108 +++---
 mm/swap_cgroup.c                               |   6 -
 mm/swap_state.c                                |  89 ++---
 mm/swapfile.c                                  |  25 +-
 mm/userfaultfd.c                               |   5 +-
 18 files changed, 367 insertions(+), 633 deletions(-)
