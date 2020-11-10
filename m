Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7FC92AD5EF
	for <lists+cgroups@lfdr.de>; Tue, 10 Nov 2020 13:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgKJMOz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Nov 2020 07:14:55 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:43770 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726690AbgKJMOz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 Nov 2020 07:14:55 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R521e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0UEt5Kf8_1605010488;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UEt5Kf8_1605010488)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 10 Nov 2020 20:14:49 +0800
Subject: Re: [PATCH v21 00/19] per memcg lru lock
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
References: <1604566549-62481-1-git-send-email-alex.shi@linux.alibaba.com>
Message-ID: <d28dbde7-9daa-903f-2f7b-be856f6653d5@linux.alibaba.com>
Date:   Tue, 10 Nov 2020 20:14:24 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1604566549-62481-1-git-send-email-alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi All,

Is any more comments of this version?

Thanks
Alex

在 2020/11/5 下午4:55, Alex Shi 写道:
> This version rebase on next/master 20201104, with much of Johannes's
> Acks and some changes according to Johannes comments. And add a new patch
> v21-0006-mm-rmap-stop-store-reordering-issue-on-page-mapp.patch to support
> v21-0007.
> 
> This patchset followed 2 memcg VM_WARN_ON_ONCE_PAGE patches which were
> added to -mm tree yesterday.
>  
> Many thanks for line by line review by Hugh Dickins, Alexander Duyck and
> Johannes Weiner.
> 
> So now this patchset includes 3 parts:
> 1, some code cleanup and minimum optimization as a preparation. 
> 2, use TestCleanPageLRU as page isolation's precondition.
> 3, replace per node lru_lock with per memcg per node lru_lock.
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
> Daniel Jordan's testing show 62% improvement on modified readtwice case
> on his 2P * 10 core * 2 HT broadwell box on v18, which has no much different
> with this v20.
> https://lore.kernel.org/lkml/20200915165807.kpp7uhiw7l3loofu@ca-dmjordan1.us.oracle.com/
> 
> Thanks Hugh Dickins and Konstantin Khlebnikov, they both brought this
> idea 8 years ago, and others who give comments as well: Daniel Jordan, 
> Mel Gorman, Shakeel Butt, Matthew Wilcox, Alexander Duyck etc.
> 
> Thanks for Testing support from Intel 0day and Rong Chen, Fengguang Wu,
> and Yun Wang. Hugh Dickins also shared his kbuild-swap case. Thanks!
> 
> 
> Alex Shi (16):
>   mm/thp: move lru_add_page_tail func to huge_memory.c
>   mm/thp: use head for head page in lru_add_page_tail
>   mm/thp: Simplify lru_add_page_tail()
>   mm/thp: narrow lru locking
>   mm/vmscan: remove unnecessary lruvec adding
>   mm/rmap: stop store reordering issue on page->mapping
>   mm/memcg: add debug checking in lock_page_memcg
>   mm/swap.c: fold vm event PGROTATED into pagevec_move_tail_fn
>   mm/lru: move lock into lru_note_cost
>   mm/vmscan: remove lruvec reget in move_pages_to_lru
>   mm/mlock: remove lru_lock on TestClearPageMlocked
>   mm/mlock: remove __munlock_isolate_lru_page
>   mm/lru: introduce TestClearPageLRU
>   mm/compaction: do page isolation first in compaction
>   mm/swap.c: serialize memcg changes in pagevec_lru_move_fn
>   mm/lru: replace pgdat lru_lock with lruvec lock
> 
> Alexander Duyck (1):
>   mm/lru: introduce the relock_page_lruvec function
> 
> Hugh Dickins (2):
>   mm: page_idle_get_page() does not need lru_lock
>   mm/lru: revise the comments of lru_lock
> 
>  Documentation/admin-guide/cgroup-v1/memcg_test.rst |  15 +-
>  Documentation/admin-guide/cgroup-v1/memory.rst     |  21 +--
>  Documentation/trace/events-kmem.rst                |   2 +-
>  Documentation/vm/unevictable-lru.rst               |  22 +--
>  include/linux/memcontrol.h                         | 110 +++++++++++
>  include/linux/mm_types.h                           |   2 +-
>  include/linux/mmzone.h                             |   6 +-
>  include/linux/page-flags.h                         |   1 +
>  include/linux/swap.h                               |   4 +-
>  mm/compaction.c                                    |  94 +++++++---
>  mm/filemap.c                                       |   4 +-
>  mm/huge_memory.c                                   |  45 +++--
>  mm/memcontrol.c                                    |  79 +++++++-
>  mm/mlock.c                                         |  63 ++-----
>  mm/mmzone.c                                        |   1 +
>  mm/page_alloc.c                                    |   1 -
>  mm/page_idle.c                                     |   4 -
>  mm/rmap.c                                          |  11 +-
>  mm/swap.c                                          | 208 ++++++++-------------
>  mm/vmscan.c                                        | 207 ++++++++++----------
>  mm/workingset.c                                    |   2 -
>  21 files changed, 530 insertions(+), 372 deletions(-)
> 
