Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E53B24FE51
	for <lists+cgroups@lfdr.de>; Mon, 24 Aug 2020 14:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgHXMzV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 24 Aug 2020 08:55:21 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:56370 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726956AbgHXMzT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 24 Aug 2020 08:55:19 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07484;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0U6k9-bl_1598273712;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U6k9-bl_1598273712)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 24 Aug 2020 20:55:13 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, willy@infradead.org,
        hannes@cmpxchg.org, lkp@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        shakeelb@google.com, iamjoonsoo.kim@lge.com,
        richard.weiyang@gmail.com, kirill@shutemov.name,
        alexander.duyck@gmail.com, rong.a.chen@intel.com, mhocko@suse.com,
        vdavydov.dev@gmail.com, shy828301@gmail.com
Subject: [PATCH v18 00/32] per memcg lru_lock 
Date:   Mon, 24 Aug 2020 20:54:33 +0800
Message-Id: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The new version which bases on v5.9-rc2. The first 6 patches was picked into
linux-mm, and add patch 25-32 that do some further post optimization.

The patchset includes 4 parts:
1, some code cleanup and minimum optimization as a preparation. patch 1-15.
2, use TestCleanPageLRU as page isolation's precondition. patch 16-19
3, replace per node lru_lock with per memcg per node lru_lock. patch 20
4, some post optimization. 				       patch 21-32

Current lru_lock is one for each of node, pgdat->lru_lock, that guard for
lru lists, but now we had moved the lru lists into memcg for long time. Still
using per node lru_lock is clearly unscalable, pages on each of memcgs have
to compete each others for a whole lru_lock. This patchset try to use per
lruvec/memcg lru_lock to repleace per node lru lock to guard lru lists, make
it scalable for memcgs and get performance gain.

Currently lru_lock still guards both lru list and page's lru bit, that's ok.
but if we want to use specific lruvec lock on the page, we need to pin down
the page's lruvec/memcg during locking. Just taking lruvec lock first may be
undermined by the page's memcg charge/migration. To fix this problem, we could
take out the page's lru bit clear and use it as pin down action to block the
memcg changes. That's the reason for new atomic func TestClearPageLRU.
So now isolating a page need both actions: TestClearPageLRU and hold the
lru_lock.

The typical usage of this is isolate_migratepages_block() in compaction.c
we have to take lru bit before lru lock, that serialized the page isolation
in memcg page charge/migration which will change page's lruvec and new 
lru_lock in it.

The above solution suggested by Johannes Weiner, and based on his new memcg 
charge path, then have this patchset. (Hugh Dickins tested and contributed much
code from compaction fix to general code polish, thanks a lot!).

Following Daniel Jordan's suggestion, I have run 208 'dd' with on 104
containers on a 2s * 26cores * HT box with a modefied case:
https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/tree/case-lru-file-readtwice
With this patchset, the readtwice performance increased about 80%
in concurrent containers.

Thanks Hugh Dickins and Konstantin Khlebnikov, they both brought this
idea 8 years ago, and others who give comments as well: Daniel Jordan, 
Mel Gorman, Shakeel Butt, Matthew Wilcox etc.

Thanks for Testing support from Intel 0day and Rong Chen, Fengguang Wu,
and Yun Wang. Hugh Dickins also shared his kbuild-swap case. Thanks!

Alex Shi (23):
  mm/memcg: warning on !memcg after readahead page charged
  mm/memcg: bail out early from swap accounting when memcg is disabled
  mm/thp: move lru_add_page_tail func to huge_memory.c
  mm/thp: clean up lru_add_page_tail
  mm/thp: remove code path which never got into
  mm/thp: narrow lru locking
  mm/swap.c: stop deactivate_file_page if page not on lru
  mm/vmscan: remove unnecessary lruvec adding
  mm/page_idle: no unlikely double check for idle page counting
  mm/compaction: rename compact_deferred as compact_should_defer
  mm/memcg: add debug checking in lock_page_memcg
  mm/swap.c: fold vm event PGROTATED into pagevec_move_tail_fn
  mm/lru: move lru_lock holding in func lru_note_cost_page
  mm/lru: move lock into lru_note_cost
  mm/lru: introduce TestClearPageLRU
  mm/compaction: do page isolation first in compaction
  mm/thp: add tail pages into lru anyway in split_huge_page()
  mm/swap.c: serialize memcg changes in pagevec_lru_move_fn
  mm/lru: replace pgdat lru_lock with lruvec lock
  mm/pgdat: remove pgdat lru_lock
  mm/mlock: remove lru_lock on TestClearPageMlocked in munlock_vma_page
  mm/mlock: remove __munlock_isolate_lru_page
  mm/swap.c: optimizing __pagevec_lru_add lru_lock

Alexander Duyck (6):
  mm/lru: introduce the relock_page_lruvec function
  mm/compaction: Drop locked from isolate_migratepages_block
  mm: Identify compound pages sooner in isolate_migratepages_block
  mm: Drop use of test_and_set_skip in favor of just setting skip
  mm: Add explicit page decrement in exception path for
    isolate_lru_pages
  mm: Split release_pages work into 3 passes

Hugh Dickins (3):
  mm/memcg: optimize mem_cgroup_page_lruvec
  mm/vmscan: use relock for move_pages_to_lru
  mm/lru: revise the comments of lru_lock

 Documentation/admin-guide/cgroup-v1/memcg_test.rst |  15 +-
 Documentation/admin-guide/cgroup-v1/memory.rst     |  21 +-
 Documentation/trace/events-kmem.rst                |   2 +-
 Documentation/vm/unevictable-lru.rst               |  22 +-
 include/linux/compaction.h                         |   4 +-
 include/linux/memcontrol.h                         | 110 ++++++++
 include/linux/mm_types.h                           |   2 +-
 include/linux/mmdebug.h                            |  13 +
 include/linux/mmzone.h                             |   6 +-
 include/linux/page-flags.h                         |   1 +
 include/linux/swap.h                               |   4 +-
 include/trace/events/compaction.h                  |   2 +-
 mm/compaction.c                                    | 166 +++++------
 mm/filemap.c                                       |   4 +-
 mm/huge_memory.c                                   |  48 +++-
 mm/memcontrol.c                                    |  92 +++++-
 mm/mlock.c                                         |  76 ++---
 mm/mmzone.c                                        |   1 +
 mm/page_alloc.c                                    |   1 -
 mm/page_idle.c                                     |   8 -
 mm/rmap.c                                          |   4 +-
 mm/swap.c                                          | 307 +++++++++++----------
 mm/vmscan.c                                        | 178 ++++++------
 mm/workingset.c                                    |   2 -
 24 files changed, 646 insertions(+), 443 deletions(-)

-- 
1.8.3.1

