Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFBA221EE6
	for <lists+cgroups@lfdr.de>; Thu, 16 Jul 2020 10:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgGPIu2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 Jul 2020 04:50:28 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:52846 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725867AbgGPIu1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 16 Jul 2020 04:50:27 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01358;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0U2sj6R3_1594889419;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U2sj6R3_1594889419)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 16 Jul 2020 16:50:20 +0800
Subject: Re: [PATCH v16 00/22] per memcg lru_lock
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name
References: <1594429136-20002-1-git-send-email-alex.shi@linux.alibaba.com>
Message-ID: <ce4537a5-91ee-60aa-5e3b-49de153a18ef@linux.alibaba.com>
Date:   Thu, 16 Jul 2020 16:49:28 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1594429136-20002-1-git-send-email-alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi All,

This version get tested and passed Hugh Dickin's testing as well as v15/v14.
Thanks, Hugh!

Anyone like to give any comments or concerns for the patches?


Thanks
Alex


在 2020/7/11 上午8:58, Alex Shi 写道:
> The new version which bases on v5.8-rc4. Add 2 more patchs:
> 'mm/thp: remove code path which never got into'
> 'mm/thp: add tail pages into lru anyway in split_huge_page()'
> and modified 'mm/mlock: reorder isolation sequence during munlock'
> 
> Current lru_lock is one for each of node, pgdat->lru_lock, that guard for
> lru lists, but now we had moved the lru lists into memcg for long time. Still
> using per node lru_lock is clearly unscalable, pages on each of memcgs have
> to compete each others for a whole lru_lock. This patchset try to use per
> lruvec/memcg lru_lock to repleace per node lru lock to guard lru lists, make
> it scalable for memcgs and get performance gain.
> 
> Currently lru_lock still guards both lru list and page's lru bit, that's ok.
> but if we want to use specific lruvec lock on the page, we need to pin down
> the page's lruvec/memcg during locking. Just taking lruvec lock first may be
> undermined by the page's memcg charge/migration. To fix this problem, we could
> take out the page's lru bit clear and use it as pin down action to block the
> memcg changes. That's the reason for new atomic func TestClearPageLRU.
> So now isolating a page need both actions: TestClearPageLRU and hold the
> lru_lock.
> 
> The typical usage of this is isolate_migratepages_block() in compaction.c
> we have to take lru bit before lru lock, that serialized the page isolation
> in memcg page charge/migration which will change page's lruvec and new 
> lru_lock in it.
> 
> The above solution suggested by Johannes Weiner, and based on his new memcg 
> charge path, then have this patchset. (Hugh Dickins tested and contributed much
> code from compaction fix to general code polish, thanks a lot!).
> 
> The patchset includes 3 parts:
> 1, some code cleanup and minimum optimization as a preparation.
> 2, use TestCleanPageLRU as page isolation's precondition
> 3, replace per node lru_lock with per memcg per node lru_lock
> 
> Following Daniel Jordan's suggestion, I have run 208 'dd' with on 104
> containers on a 2s * 26cores * HT box with a modefied case:
> https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/tree/case-lru-file-readtwice
> With this patchset, the readtwice performance increased about 80%
> in concurrent containers.
> 
> Thanks Hugh Dickins and Konstantin Khlebnikov, they both brought this
> idea 8 years ago, and others who give comments as well: Daniel Jordan, 
> Mel Gorman, Shakeel Butt, Matthew Wilcox etc.
> 
> Thanks for Testing support from Intel 0day and Rong Chen, Fengguang Wu,
> and Yun Wang. Hugh Dickins also shared his kbuild-swap case. Thanks!
> 
> Alex Shi (20):
>   mm/vmscan: remove unnecessary lruvec adding
>   mm/page_idle: no unlikely double check for idle page counting
>   mm/compaction: correct the comments of compact_defer_shift
>   mm/compaction: rename compact_deferred as compact_should_defer
>   mm/thp: move lru_add_page_tail func to huge_memory.c
>   mm/thp: clean up lru_add_page_tail
>   mm/thp: remove code path which never got into
>   mm/thp: narrow lru locking
>   mm/memcg: add debug checking in lock_page_memcg
>   mm/swap: fold vm event PGROTATED into pagevec_move_tail_fn
>   mm/lru: move lru_lock holding in func lru_note_cost_page
>   mm/lru: move lock into lru_note_cost
>   mm/lru: introduce TestClearPageLRU
>   mm/thp: add tail pages into lru anyway in split_huge_page()
>   mm/compaction: do page isolation first in compaction
>   mm/mlock: reorder isolation sequence during munlock
>   mm/swap: serialize memcg changes during pagevec_lru_move_fn
>   mm/lru: replace pgdat lru_lock with lruvec lock
>   mm/lru: introduce the relock_page_lruvec function
>   mm/pgdat: remove pgdat lru_lock
> 
> Hugh Dickins (2):
>   mm/vmscan: use relock for move_pages_to_lru
>   mm/lru: revise the comments of lru_lock
> 
>  Documentation/admin-guide/cgroup-v1/memcg_test.rst |  15 +-
>  Documentation/admin-guide/cgroup-v1/memory.rst     |  21 +--
>  Documentation/trace/events-kmem.rst                |   2 +-
>  Documentation/vm/unevictable-lru.rst               |  22 +--
>  include/linux/compaction.h                         |   4 +-
>  include/linux/memcontrol.h                         |  98 +++++++++++
>  include/linux/mm_types.h                           |   2 +-
>  include/linux/mmzone.h                             |   6 +-
>  include/linux/page-flags.h                         |   1 +
>  include/linux/swap.h                               |   4 +-
>  include/trace/events/compaction.h                  |   2 +-
>  mm/compaction.c                                    | 113 ++++++++----
>  mm/filemap.c                                       |   4 +-
>  mm/huge_memory.c                                   |  47 +++--
>  mm/memcontrol.c                                    |  71 +++++++-
>  mm/memory.c                                        |   3 -
>  mm/mlock.c                                         |  93 +++++-----
>  mm/mmzone.c                                        |   1 +
>  mm/page_alloc.c                                    |   1 -
>  mm/page_idle.c                                     |   8 -
>  mm/rmap.c                                          |   4 +-
>  mm/swap.c                                          | 189 ++++++++-------------
>  mm/swap_state.c                                    |   2 -
>  mm/vmscan.c                                        | 174 ++++++++++---------
>  mm/workingset.c                                    |   2 -
>  25 files changed, 524 insertions(+), 365 deletions(-)
> 
