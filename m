Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 933331B22D8
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2020 11:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgDUJd4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Apr 2020 05:33:56 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:49515 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725920AbgDUJd4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Apr 2020 05:33:56 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07484;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0TwDj3zG_1587461629;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TwDj3zG_1587461629)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Apr 2020 17:33:50 +0800
Subject: Re: [PATCH 00/18] mm: memcontrol: charge swapin pages on
 instantiation
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <js1304@gmail.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
References: <20200420221126.341272-1-hannes@cmpxchg.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <e5f966d8-8b1c-cecf-7022-ae160d266443@linux.alibaba.com>
Date:   Tue, 21 Apr 2020 17:32:43 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200420221126.341272-1-hannes@cmpxchg.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



ÔÚ 2020/4/21 ÉÏÎç6:11, Johannes Weiner Ð´µÀ:
> This patch series reworks memcg to charge swapin pages directly at
> swapin time, rather than at fault time, which may be much later, or
> not happen at all.
> 
> The delayed charging scheme we have right now causes problems:
> 
> - Alex's per-cgroup lru_lock patches rely on pages that have been
>   isolated from the LRU to have a stable page->mem_cgroup; otherwise
>   the lock may change underneath him. Swapcache pages are charged only
>   after they are added to the LRU, and charging doesn't follow the LRU
>   isolation protocol.

Hi Johannes,

Thanks a lot! 
It looks all fine for me. I will rebase per cgroup lru_lock on this.
Thanks!

Alex

> 
> - Joonsoo's anon workingset patches need a suitable LRU at the time
>   the page enters the swap cache and displaces the non-resident
>   info. But the correct LRU is only available after charging.
> 
> - It's a containment hole / DoS vector. Users can trigger arbitrarily
>   large swap readahead using MADV_WILLNEED. The memory is never
>   charged unless somebody actually touches it.
> 
> - It complicates the page->mem_cgroup stabilization rules
> 
> In order to charge pages directly at swapin time, the memcg code base
> needs to be prepared, and several overdue cleanups become a necessity:
> 
> To charge pages at swapin time, we need to always have cgroup
> ownership tracking of swap records. We also cannot rely on
> page->mapping to tell apart page types at charge time, because that's
> only set up during a page fault.
> 
> To eliminate the page->mapping dependency, memcg needs to ditch its
> private page type counters (MEMCG_CACHE, MEMCG_RSS, NR_SHMEM) in favor
> of the generic vmstat counters and accounting sites, such as
> NR_FILE_PAGES, NR_ANON_MAPPED etc.
> 
> To switch to generic vmstat counters, the charge sequence must be
> adjusted such that page->mem_cgroup is set up by the time these
> counters are modified.
> 
> The series is structured as follows:
> 
> 1. Bug fixes
> 2. Decoupling charging from rmap
> 3. Swap controller integration into memcg
> 4. Direct swapin charging
> 
> The patches survive a simple swapout->swapin test inside a virtual
> machine. Because this is blocking two major patch sets, I'm sending
> these out early and will continue testing in parallel to the review.
> 
>  include/linux/memcontrol.h |  53 +----
>  include/linux/mm.h         |   4 +-
>  include/linux/swap.h       |   6 +-
>  init/Kconfig               |  17 +-
>  kernel/events/uprobes.c    |  10 +-
>  mm/filemap.c               |  43 ++---
>  mm/huge_memory.c           |  45 ++---
>  mm/khugepaged.c            |  25 +--
>  mm/memcontrol.c            | 448 ++++++++++++++-----------------------------
>  mm/memory.c                |  51 ++---
>  mm/migrate.c               |  20 +-
>  mm/rmap.c                  |  53 +++--
>  mm/shmem.c                 | 117 +++++------
>  mm/swap_cgroup.c           |   6 -
>  mm/swap_state.c            |  89 +++++----
>  mm/swapfile.c              |  25 +--
>  mm/userfaultfd.c           |   5 +-
>  17 files changed, 367 insertions(+), 650 deletions(-)
> 
