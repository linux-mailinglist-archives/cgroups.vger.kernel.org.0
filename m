Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 235E9102435
	for <lists+cgroups@lfdr.de>; Tue, 19 Nov 2019 13:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbfKSMYM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Nov 2019 07:24:12 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:42887 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725798AbfKSMYM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Nov 2019 07:24:12 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0TiYlW.J_1574166244;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TiYlW.J_1574166244)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 19 Nov 2019 20:24:04 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        shakeelb@google.com, hannes@cmpxchg.org
Cc:     Alex Shi <alex.shi@linux.alibaba.com>
Subject: [PATCH v4 0/9] per lruvec lru_lock for memcg
Date:   Tue, 19 Nov 2019 20:23:14 +0800
Message-Id: <1574166203-151975-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi all,

This patchset move lru_lock into lruvec, give a lru_lock for each of
lruvec, thus bring a lru_lock for each of memcg per node.

According to Daniel Jordan's suggestion, I run 64 'dd' with on 32
containers on my 2s* 8 core * HT box with the modefied case:
  https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/tree/case-lru-file-readtwice

With this change above lru_lock censitive testing improved 17% with multiple
containers scenario. And no performance lose w/o mem_cgroup.

Thanks Hugh Dickins and Konstantin Khlebnikov, they both brought the same idea
7 years ago. Now I believe considering my testing result, and google internal
using fact. This feature is clearly benefit multi-container users.

So I'd like to introduce it here.

Thanks all the comments from Hugh Dickins, Konstantin Khlebnikov, Daniel Jordan, 
Johannes Weiner, Mel Gorman, Shakeel Butt, Rong Chen, Fengguang Wu, Yun Wang etc.

v4: 
  a, fix the page->mem_cgroup dereferencing issue, thanks Johannes Weiner
  b, remove the irqsave flags changes, thanks Metthew Wilcox
  c, merge/split patches for better understanding and bisection purpose

v3: rebase on linux-next, and fold the relock fix patch into introduceing patch

v2: bypass a performance regression bug and fix some function issues

v1: initial version, aim testing show 5% performance increase


Alex Shi (9):
  mm/swap: fix uninitialized compiler warning
  mm/huge_memory: fix uninitialized compiler warning
  mm/lru: replace pgdat lru_lock with lruvec lock
  mm/mlock: only change the lru_lock iff page's lruvec is different
  mm/swap: only change the lru_lock iff page's lruvec is different
  mm/vmscan: only change the lru_lock iff page's lruvec is different
  mm/pgdat: remove pgdat lru_lock
  mm/lru: likely enhancement
  mm/lru: revise the comments of lru_lock

 Documentation/admin-guide/cgroup-v1/memcg_test.rst | 15 +----
 Documentation/admin-guide/cgroup-v1/memory.rst     |  6 +-
 Documentation/trace/events-kmem.rst                |  2 +-
 Documentation/vm/unevictable-lru.rst               | 22 +++----
 include/linux/memcontrol.h                         | 68 ++++++++++++++++++++
 include/linux/mm_types.h                           |  2 +-
 include/linux/mmzone.h                             |  5 +-
 mm/compaction.c                                    | 67 +++++++++++++------
 mm/filemap.c                                       |  4 +-
 mm/huge_memory.c                                   | 17 ++---
 mm/memcontrol.c                                    | 75 +++++++++++++++++-----
 mm/mlock.c                                         | 27 ++++----
 mm/mmzone.c                                        |  1 +
 mm/page_alloc.c                                    |  1 -
 mm/page_idle.c                                     |  5 +-
 mm/rmap.c                                          |  2 +-
 mm/swap.c                                          | 74 +++++++++------------
 mm/vmscan.c                                        | 74 ++++++++++-----------
 18 files changed, 287 insertions(+), 180 deletions(-)

-- 
1.8.3.1

