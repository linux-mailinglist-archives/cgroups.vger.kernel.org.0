Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71E3695753
	for <lists+cgroups@lfdr.de>; Tue, 14 Feb 2023 04:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjBNDSb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Feb 2023 22:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjBNDSa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Feb 2023 22:18:30 -0500
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C1A4694;
        Mon, 13 Feb 2023 19:18:28 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0Vbe-fxI_1676344705;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Vbe-fxI_1676344705)
          by smtp.aliyun-inc.com;
          Tue, 14 Feb 2023 11:18:26 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     torvalds@linux-foundation.org, sj@kernel.org, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, baolin.wang@linux.alibaba.com,
        damon@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Some cleanups for page isolation
Date:   Tue, 14 Feb 2023 11:18:05 +0800
Message-Id: <cover.1676342827.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

The page isolation functions did not return a boolean to indicate
success or not, instead it will return a negative error when failed
to isolate a page. So it's better to check the negative error explicitly
for isolation to make the code more clear per Linus's suggestion in [1].

No functional changes intended in this patch series.

[1] https://lore.kernel.org/all/CAHk-=wiBrY+O-4=2mrbVyxR+hOqfdJ=Do6xoucfJ9_5az01L4Q@mail.gmail.com/

Baolin Wang (3):
  mm: check negative error of folio_isolate_lru() when failed to isolate
    a folio
  mm: check negative error of isolate_lru_page() when failed to isolate
    a page
  mm: mempolicy: check negative error of isolate_hugetlb() when failed
    to isolate a hugetlb

 mm/damon/paddr.c    | 2 +-
 mm/gup.c            | 2 +-
 mm/khugepaged.c     | 4 ++--
 mm/memcontrol.c     | 2 +-
 mm/mempolicy.c      | 2 +-
 mm/migrate.c        | 4 ++--
 mm/migrate_device.c | 2 +-
 7 files changed, 9 insertions(+), 9 deletions(-)

-- 
2.27.0

