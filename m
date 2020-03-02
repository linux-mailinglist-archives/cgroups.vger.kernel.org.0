Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14F971758D6
	for <lists+cgroups@lfdr.de>; Mon,  2 Mar 2020 12:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgCBLA4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Mar 2020 06:00:56 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:33361 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725802AbgCBLA4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Mar 2020 06:00:56 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R441e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0TrQmbeZ_1583146852;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TrQmbeZ_1583146852)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 02 Mar 2020 19:00:53 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     cgroups@vger.kernel.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        hannes@cmpxchg.org, lkp@intel.com
Cc:     Alex Shi <alex.shi@linux.alibaba.com>
Subject: [PATCH v9 00/21] per lruvec lru_lock for memcg
Date:   Mon,  2 Mar 2020 19:00:10 +0800
Message-Id: <1583146830-169516-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi all,

This patchset mainly includes 3 parts:
1, some code cleanup and minimum optimization as a preparation.
2, use TestCleanPageLRU as page isolation's precondition
3, replace per node lru_lock with per memcg per node lru_lock

The keypoint of this patchset is moving lru_lock into lruvec, give a 
lru_lock for each of lruvec, thus bring a lru_lock for each of memcg 
per node. So on a large node machine, each of memcg don't suffer from
per node pgdat->lru_lock waiting. They could go fast with their self
lru_lock now.

Since lruvec belongs to each memcg, the critical point is to keep
page's memcg stable, so we take PageLRU as its isolation's precondition.
Thanks for Johannes Weiner help and suggestion!

Following Daniel Jordan's suggestion, I have run 208 'dd' with on 104
containers on a 2s * 26cores * HT box with a modefied case:
  https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/tree/case-lru-file-readtwice

With this patchset, the readtwice performance increased about 80%
in concurrent containers.

Thanks Hugh Dickins and Konstantin Khlebnikov, they both brought this
idea 8 years ago, and others who give comments as well: Daniel Jordan, 
Mel Gorman, Shakeel Butt, Matthew Wilcox etc.

Thanks for Testing support from Intel 0day and Rong Chen, Fengguang Wu,
and Yun Wang.

v9,
  a, use TestCleanPageLRU as page isolation's precondition, that
     resolved the page's memcg stable problem, Thanks Johannes Weiner!
  b, few more code clean up patches

v8,
  a, redo lock_page_lru cleanup as Konstantin Khlebnikov suggested.
  b, fix a bug in lruvec_memcg_debug, reported by Hugh Dickins

...

v1: initial version, aim testing show 5% performance increase on a 16 threads box.

Alex Shi (19):
  mm/vmscan: remove unnecessary lruvec adding
  mm/memcg: fold lock_page_lru into commit_charge
  mm/page_idle: no unlikely double check for idle page counting
  mm/thp: move lru_add_page_tail func to huge_memory.c
  mm/thp: clean up lru_add_page_tail
  mm/thp: narrow lru locking
  mm/lru: introduce TestClearPageLRU
  mm/lru: add page isolation precondition in __isolate_lru_page
  mm/mlock: ClearPageLRU before get lru lock in munlock page isolation
  mm/lru: take PageLRU first in moving page between lru lists
  mm/memcg: move SetPageLRU out of lru_lock in commit_charge
  mm/mlock: clean up __munlock_isolate_lru_page
  mm/lru: replace pgdat lru_lock with lruvec lock
  mm/lru: introduce the relock_page_lruvec function
  mm/mlock: optimize munlock_pagevec by relocking
  mm/swap: only change the lru_lock iff page's lruvec is different
  mm/pgdat: remove pgdat lru_lock
  mm/lru: add debug checking for page memcg moving
  mm/memcg: add debug checking in lock_page_memcg

Hugh Dickins (1):
  mm/lru: revise the comments of lru_lock

 Documentation/admin-guide/cgroup-v1/memcg_test.rst |  15 +-
 Documentation/admin-guide/cgroup-v1/memory.rst     |   8 +-
 Documentation/trace/events-kmem.rst                |   2 +-
 Documentation/vm/unevictable-lru.rst               |  22 +--
 include/linux/memcontrol.h                         |  77 ++++++++++
 include/linux/mm_types.h                           |   2 +-
 include/linux/mmzone.h                             |   5 +-
 include/linux/page-flags.h                         |   1 +
 include/linux/swap.h                               |   6 +-
 mm/compaction.c                                    |  78 ++++++----
 mm/filemap.c                                       |   4 +-
 mm/huge_memory.c                                   |  54 +++++--
 mm/memcontrol.c                                    | 110 +++++++++-----
 mm/mlock.c                                         |  88 ++++++-----
 mm/mmzone.c                                        |   1 +
 mm/page_alloc.c                                    |   1 -
 mm/page_idle.c                                     |   8 -
 mm/rmap.c                                          |   2 +-
 mm/swap.c                                          | 160 +++++++-------------
 mm/vmscan.c                                        | 163 +++++++++++----------
 20 files changed, 446 insertions(+), 361 deletions(-)

-- 
1.8.3.1

