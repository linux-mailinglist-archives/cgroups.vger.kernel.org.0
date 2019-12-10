Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E98E118703
	for <lists+cgroups@lfdr.de>; Tue, 10 Dec 2019 12:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfLJLsH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Dec 2019 06:48:07 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:43389 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727421AbfLJLsH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 Dec 2019 06:48:07 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R351e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0TkXAQar_1575978470;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TkXAQar_1575978470)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 10 Dec 2019 19:47:51 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        shakeelb@google.com, hannes@cmpxchg.org
Cc:     Alex Shi <alex.shi@linux.alibaba.com>
Subject: [PATCH v5 0/8] per lruvec lru_lock for memcg
Date:   Tue, 10 Dec 2019 19:46:16 +0800
Message-Id: <1575978384-222381-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi all,

Sorry for send out later.

This patchset move lru_lock into lruvec, give a lru_lock for each of
lruvec, thus bring a lru_lock for each of memcg per node.

This is the main patch to replace per node lru_lock with per memcg
lruvec lock.

We introduces function lock_page_lruvec, which will lock the page's
memcg and then memcg's lruvec->lru_lock. (Thanks Johannes Weiner,
Hugh Dickins and Konstantin Khlebnikov suggestion/reminder)

According to Daniel Jordan's suggestion, I run 208 'dd' with on 104
containers on a 2s * 26cores * HT box with a modefied case:
  https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/tree/case-lru-file-readtwice

With this and later patches, the readtwice performance increases about
80% with containers, but w/o memcg the readtwice performance drops
about 5%.(and another 5% drops with the last debug patch). Slighty
better than v4.(about 6% drop w/o memcg)

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


Alex Shi (7):
  mm/vmscan: remove unnecessary lruvec adding
  mm/lru: replace pgdat lru_lock with lruvec lock
  mm/lru: introduce the relock_page_lruvec function
  mm/mlock: optimize munlock_pagevec by relocking
  mm/swap: only change the lru_lock iff page's lruvec is different
  mm/pgdat: remove pgdat lru_lock
  mm/lru: debug checking for page memcg moving and lock_page_memcg

Hugh Dickins (1):
  mm/lru: revise the comments of lru_lock

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
 mm/memcontrol.c                                    | 88 +++++++++++++++-----
 mm/mlock.c                                         | 28 +++----
 mm/mmzone.c                                        |  1 +
 mm/page_alloc.c                                    |  1 -
 mm/page_idle.c                                     |  7 +-
 mm/rmap.c                                          |  2 +-
 mm/swap.c                                          | 75 +++++++----------
 mm/vmscan.c                                        | 97 ++++++++++++----------
 18 files changed, 300 insertions(+), 195 deletions(-)

-- 
1.8.3.1

