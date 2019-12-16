Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED8A2120101
	for <lists+cgroups@lfdr.de>; Mon, 16 Dec 2019 10:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfLPJ1X (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 16 Dec 2019 04:27:23 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:53732 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726313AbfLPJ1W (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 16 Dec 2019 04:27:22 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0Tl4L2qr_1576488436;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0Tl4L2qr_1576488436)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 16 Dec 2019 17:27:17 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        shakeelb@google.com, hannes@cmpxchg.org
Cc:     Alex Shi <alex.shi@linux.alibaba.com>
Subject: [PATCH v6 00/10] per lruvec lru_lock for memcg
Date:   Mon, 16 Dec 2019 17:26:16 +0800
Message-Id: <1576488386-32544-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This patchset move lru_lock into lruvec, give a lru_lock for each of
lruvec, thus bring a lru_lock for each of memcg per node.

We introduces function lock_page_lruvec, which will lock the page's
memcg and then memcg's lruvec->lru_lock(Thanks Johannes Weiner,
Hugh Dickins and Konstantin Khlebnikov suggestion/reminder) to replace
old pgdat->lru_lock.

Following to Daniel Jordan's suggestion, I run 208 'dd' with on 104
containers on a 2s * 26cores * HT box with a modefied case:
  https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/tree/case-lru-file-readtwice

With this patchset, the readtwice performance increased about 80%
with containers. And no performance drops w/o container. The previous
suspicious slightly drop has gone in v5.5-rc version. And we even got another
5% performance increase. Also the readtwice case performance increased from 5.4
to 5.5-rc.

Another way to guard move_account is by lru_lock instead of move_lock 
Considering the memcg move task path:
   mem_cgroup_move_task:
     mem_cgroup_move_charge:
	lru_add_drain_all();
	atomic_inc(&mc.from->moving_account); //ask lruvec's move_lock
	synchronize_rcu();
	walk_parge_range: do charge_walk_ops(mem_cgroup_move_charge_pte_range):
	   isolate_lru_page();
	   mem_cgroup_move_account(page,)
		spin_lock(&from->move_lock) 
		page->mem_cgroup = to;
		spin_unlock(&from->move_lock) 
	   putback_lru_page(page)

to guard 'page->mem_cgroup = to' by to_vec->lru_lock has the similar effect with
move_lock. So for performance reason, both solutions are same.

Thanks Hugh Dickins and Konstantin Khlebnikov, they both brought the same idea
7 years ago.

Thanks all the comments from Hugh Dickins, Konstantin Khlebnikov, Daniel Jordan, 
Johannes Weiner, Mel Gorman, Shakeel Butt, Rong Chen, Fengguang Wu, Yun Wang etc.
and some testing support from Intel 0days!

v6, 
  a, rebase on v5.5-rc2, and do retesting.
  b, pick up Johanness' comments change and a lock_page_lru cleanup.

v5,
  a, locking page's memcg according JohannesW suggestion
  b, using macro for non memcg, according to Johanness and Metthew's suggestion.

v4: 
  a, fix the page->mem_cgroup dereferencing issue, thanks Johannes Weiner
  b, remove the irqsave flags changes, thanks Metthew Wilcox
  c, merge/split patches for better understanding and bisection purpose

v3: rebase on linux-next, and fold the relock fix patch into introduceing patch

v2: bypass a performance regression bug and fix some function issues

v1: initial version, aim testing show 5% performance increase



Alex Shi (8):
  mm/vmscan: remove unnecessary lruvec adding
  mm/lru: replace pgdat lru_lock with lruvec lock
  mm/lru: introduce the relock_page_lruvec function
  mm/mlock: optimize munlock_pagevec by relocking
  mm/swap: only change the lru_lock iff page's lruvec is different
  mm/pgdat: remove pgdat lru_lock
  mm/lru: debug checking for page memcg moving and lock_page_memcg
  mm/memcg: fold lock in lock_page_lru

Hugh Dickins (1):
  mm/lru: revise the comments of lru_lock

Johannes Weiner (1):
  mm: revise the comments of mem_cgroup_page_lruvec

 Documentation/admin-guide/cgroup-v1/memcg_test.rst | 15 +---
 Documentation/admin-guide/cgroup-v1/memory.rst     |  6 +-
 Documentation/trace/events-kmem.rst                |  2 +-
 Documentation/vm/unevictable-lru.rst               | 22 ++---
 include/linux/memcontrol.h                         | 63 ++++++++++++++
 include/linux/mm_types.h                           |  2 +-
 include/linux/mmzone.h                             |  5 +-
 mm/compaction.c                                    | 59 ++++++++-----
 mm/filemap.c                                       |  4 +-
 mm/huge_memory.c                                   | 18 ++--
 mm/memcontrol.c                                    | 95 +++++++++++++++++----
 mm/mlock.c                                         | 28 +++----
 mm/mmzone.c                                        |  1 +
 mm/page_alloc.c                                    |  1 -
 mm/page_idle.c                                     |  7 +-
 mm/rmap.c                                          |  2 +-
 mm/swap.c                                          | 75 +++++++----------
 mm/vmscan.c                                        | 97 ++++++++++++----------
 18 files changed, 309 insertions(+), 193 deletions(-)

-- 
1.8.3.1

