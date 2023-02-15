Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FA5697A0C
	for <lists+cgroups@lfdr.de>; Wed, 15 Feb 2023 11:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234089AbjBOKj4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Feb 2023 05:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234099AbjBOKju (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Feb 2023 05:39:50 -0500
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2E9360B3;
        Wed, 15 Feb 2023 02:39:48 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0VbkDfVz_1676457584;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VbkDfVz_1676457584)
          by smtp.aliyun-inc.com;
          Wed, 15 Feb 2023 18:39:44 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     torvalds@linux-foundation.org, sj@kernel.org, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, naoya.horiguchi@nec.com,
        linmiaohe@huawei.com, david@redhat.com, osalvador@suse.de,
        mike.kravetz@oracle.com, willy@infradead.org,
        baolin.wang@linux.alibaba.com, damon@lists.linux.dev,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] Change the return value for page isolation functions
Date:   Wed, 15 Feb 2023 18:39:33 +0800
Message-Id: <cover.1676424378.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Now the page isolation functions did not return a boolean to indicate
success or not, instead it will return a negative error when failed
to isolate a page. So below code used in most places seem a boolean
success/failure thing, which can confuse people whether the isolation
is successful.

if (folio_isolate_lru(folio))
        continue;

Moreover the page isolation functions only return 0 or -EBUSY, and
most users did not care about the negative error except for few users,
thus we can convert all page isolation functions to return a boolean
value, which can remove the confusion to make code more clear.

No functional changes intended in this patch series.

Changes from v2:
 - Add a new boolean 'isolated' variable for functions that require the
 negative error value.
 - Keep the same return value logic in do_migrate_range(), that means it
 will return -EBUSY if all pages are failed to be isolated.
 - Collect Acked-by and Reviewed-by tags. Thanks David and SeongJae.

Changes from v1:
 - Convert all isolation functions to return bool.

Baolin Wang (4):
  mm: change to return bool for folio_isolate_lru()
  mm: change to return bool for isolate_lru_page()
  mm: hugetlb: change to return bool for isolate_hugetlb()
  mm: change to return bool for isolate_movable_page()

 include/linux/hugetlb.h |  6 +++---
 include/linux/migrate.h |  6 +++---
 mm/compaction.c         |  2 +-
 mm/damon/paddr.c        |  2 +-
 mm/folio-compat.c       |  4 ++--
 mm/gup.c                |  2 +-
 mm/hugetlb.c            | 13 ++++++++-----
 mm/internal.h           |  4 ++--
 mm/khugepaged.c         |  4 ++--
 mm/madvise.c            |  4 ++--
 mm/memcontrol.c         |  4 ++--
 mm/memory-failure.c     | 10 +++++-----
 mm/memory_hotplug.c     |  8 +++++---
 mm/mempolicy.c          |  4 ++--
 mm/migrate.c            | 20 +++++++++++---------
 mm/migrate_device.c     |  2 +-
 mm/vmscan.c             | 10 +++++-----
 17 files changed, 56 insertions(+), 49 deletions(-)

-- 
2.27.0

