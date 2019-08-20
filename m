Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6157B95B79
	for <lists+cgroups@lfdr.de>; Tue, 20 Aug 2019 11:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729568AbfHTJtg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 20 Aug 2019 05:49:36 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:60215 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728426AbfHTJtg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 20 Aug 2019 05:49:36 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R471e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TZztT3d_1566294571;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TZztT3d_1566294571)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 20 Aug 2019 17:49:31 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>
Subject: [PATCH 00/14] per memcg lru_lock 
Date:   Tue, 20 Aug 2019 17:48:23 +0800
Message-Id: <1566294517-86418-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This patchset move lru_lock into lruvec, give a lru_lock for each of
lruvec, thus bring a lru_lock for each of memcg.

Per memcg lru_lock would ease the lru_lock contention a lot in
this patch series.

In some data center, containers are used widely to deploy different kind
of services, then multiple memcgs share per node pgdat->lru_lock which
cause heavy lock contentions when doing lru operation.

On my 2 socket * 6 cores E5-2630 platform, 24 containers run aim9
simultaneously with mmtests' config:
        # AIM9
        export AIM9_TESTTIME=180
        export AIM9_TESTLIST=page_test,brk_test

perf lock report show much contentions on lru_lock in 20 second snapshot:
                        Name   acquired  contended   avg wait (ns) total wait (ns)   max wait (ns)   min wait (ns)
        &(ptlock_ptr(pag...         22          0               0       0               0               0
        ...
        &(&pgdat->lru_lo...          9          7           12728       89096           26656            1597

With this patch series, lruvec->lru_lock show no contentions
        &(&lruvec->lru_l...          8          0               0       0               0               0

and aim9 page_test/brk_test performance increased 5%~50%.
BTW, Detailed results in aim9-pft.compare.log if needed,
All containers data are increased and pretty steady.

$for i in Max Min Hmean Stddev CoeffVar BHmean-50 BHmean-95 BHmean-99; do echo "========= $i page_test ============"; cat aim9-pft.compare.log | grep "^$i.*page_test" | awk 'BEGIN {a=b=0;}  { a+=$3; b+=$6 } END { print "5.3-rc4          " a/24; print "5.3-rc4+lru_lock " b/24}' ; done
========= Max page_test ============
5.3-rc4          34729.6
5.3-rc4+lru_lock 36128.3
========= Min page_test ============
5.3-rc4          33644.2
5.3-rc4+lru_lock 35349.7
========= Hmean page_test ============
5.3-rc4          34355.4
5.3-rc4+lru_lock 35810.9
========= Stddev page_test ============
5.3-rc4          319.757
5.3-rc4+lru_lock 223.324
========= CoeffVar page_test ============
5.3-rc4          0.93125
5.3-rc4+lru_lock 0.623333
========= BHmean-50 page_test ============
5.3-rc4          34579.2
5.3-rc4+lru_lock 35977.1
========= BHmean-95 page_test ============
5.3-rc4          34421.7
5.3-rc4+lru_lock 35853.6
========= BHmean-99 page_test ============
5.3-rc4          34421.7
5.3-rc4+lru_lock 35853.6

$for i in Max Min Hmean Stddev CoeffVar BHmean-50 BHmean-95 BHmean-99; do echo "========= $i brk_test ============"; cat aim9-pft.compare.log | grep "^$i.*brk_test" | awk 'BEGIN {a=b=0;}  { a+=$3; b+=$6 } END { print "5.3-rc4          " a/24; print "5.3-rc4+lru_lock " b/24}' ; done
========= Max brk_test ============
5.3-rc4          96647.7
5.3-rc4+lru_lock 98960.3
========= Min brk_test ============
5.3-rc4          91800.8
5.3-rc4+lru_lock 96817.6
========= Hmean brk_test ============
5.3-rc4          95470
5.3-rc4+lru_lock 97769.6
========= Stddev brk_test ============
5.3-rc4          1253.52
5.3-rc4+lru_lock 596.593
========= CoeffVar brk_test ============
5.3-rc4          1.31375
5.3-rc4+lru_lock 0.609583
========= BHmean-50 brk_test ============
5.3-rc4          96141.4
5.3-rc4+lru_lock 98194
========= BHmean-95 brk_test ============
5.3-rc4          95818.5
5.3-rc4+lru_lock 97857.2
========= BHmean-99 brk_test ============
5.3-rc4          95818.5
5.3-rc4+lru_lock 97857.2

Alex Shi (14):
  mm/lru: move pgdat lru_lock into lruvec
  lru/memcg: move the lruvec->pgdat sync out lru_lock
  lru/memcg: using per lruvec lock in un/lock_page_lru
  lru/compaction: use per lruvec lock in isolate_migratepages_block
  lru/huge_page: use per lruvec lock in __split_huge_page
  lru/mlock: using per lruvec lock in munlock
  lru/swap: using per lruvec lock in page_cache_release
  lru/swap: uer lruvec lock in activate_page
  lru/swap: uer per lruvec lock in pagevec_lru_move_fn
  lru/swap: use per lruvec lock in release_pages
  lru/vmscan: using per lruvec lock in lists shrinking.
  lru/vmscan: use pre lruvec lock in check_move_unevictable_pages
  lru/vmscan: using per lruvec lru_lock in get_scan_count
  mm/lru: fix the comments of lru_lock

 include/linux/memcontrol.h | 24 ++++++++++----
 include/linux/mm_types.h   |  2 +-
 include/linux/mmzone.h     |  6 ++--
 mm/compaction.c            | 48 +++++++++++++++++-----------
 mm/filemap.c               |  4 +--
 mm/huge_memory.c           |  9 ++++--
 mm/memcontrol.c            | 24 ++++++--------
 mm/mlock.c                 | 35 ++++++++++----------
 mm/mmzone.c                |  1 +
 mm/page_alloc.c            |  1 -
 mm/page_idle.c             |  4 +--
 mm/rmap.c                  |  2 +-
 mm/swap.c                  | 79 +++++++++++++++++++++++++---------------------
 mm/vmscan.c                | 63 ++++++++++++++++++------------------
 14 files changed, 166 insertions(+), 136 deletions(-)

-- 
1.8.3.1

