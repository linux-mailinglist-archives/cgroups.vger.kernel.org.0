Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A84C1FEA5D
	for <lists+cgroups@lfdr.de>; Sat, 16 Nov 2019 04:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfKPDPO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 Nov 2019 22:15:14 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:38471 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727215AbfKPDPN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 Nov 2019 22:15:13 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0TiBwoht_1573874108;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TiBwoht_1573874108)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 16 Nov 2019 11:15:08 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     alex.shi@linux.alibaba.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org
Subject: [PATCH v3 0/8] per lruvec lru_lock for memcg
Date:   Sat, 16 Nov 2019 11:14:59 +0800
Message-Id: <1573874106-23802-1-git-send-email-alex.shi@linux.alibaba.com>
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

Thanks Hugh Dickins and Konstantin Khlebnikov, they both bring the same idea
7 years ago. Now I believe considering my testing result, and google internal
using fact. This feather is clearly benefit multi-container user.

So I like to introduce it here.

v3: rebase on linux-next, and fold the relock fix patch into introduceing patch

v2: bypass a performance regression bug and fix some function issues

v1: initial version, aim testing show 5% performance incrase

Alex Shi (7):
  mm/lru: add per lruvec lock for memcg
  mm/lruvec: add irqsave flags into lruvec struct
  mm/lru: replace pgdat lru_lock with lruvec lock
  mm/lru: only change the lru_lock iff page's lruvec is different
  mm/pgdat: remove pgdat lru_lock
  mm/lru: likely enhancement
  mm/lru: revise the comments of lru_lock

 Documentation/admin-guide/cgroup-v1/memcg_test.rst | 15 +----
 Documentation/admin-guide/cgroup-v1/memory.rst     |  6 +-
 Documentation/trace/events-kmem.rst                |  2 +-
 Documentation/vm/unevictable-lru.rst               | 22 +++----
 include/linux/memcontrol.h                         | 67 +++++++++++++++++++
 include/linux/mm_types.h                           |  2 +-
 include/linux/mmzone.h                             |  7 +-
 mm/compaction.c                                    | 62 +++++++++++------
 mm/filemap.c                                       |  4 +-
 mm/huge_memory.c                                   | 16 ++---
 mm/memcontrol.c                                    | 64 ++++++++++++++----
 mm/mlock.c                                         | 27 ++++----
 mm/mmzone.c                                        |  1 +
 mm/page_alloc.c                                    |  1 -
 mm/page_idle.c                                     |  5 +-
 mm/rmap.c                                          |  2 +-
 mm/swap.c                                          | 77 +++++++++-------------
 mm/vmscan.c                                        | 74 +++++++++++----------
 18 files changed, 277 insertions(+), 177 deletions(-)

-- 
1.8.3.1

