Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E263A26F2D1
	for <lists+cgroups@lfdr.de>; Fri, 18 Sep 2020 05:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgIRDCP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 17 Sep 2020 23:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729968AbgIRDBA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 17 Sep 2020 23:01:00 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9772EC06174A
        for <cgroups@vger.kernel.org>; Thu, 17 Sep 2020 20:00:59 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id t56so3784725qtt.19
        for <cgroups@vger.kernel.org>; Thu, 17 Sep 2020 20:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=MShH3I1oLcjvEJbj3NYW9C342mvg+PbbBJCOoSH1HSQ=;
        b=CDRIysijqlvkYU+kfz4ExesE+3SJEmw3l9qWCAyu0Yl6J6QfFZHDzRMn2cts4G/GOz
         due2AZm8uZnE02XEz5UeXJrQLnFVWnnCS9C/pPkMQNrCt04NXlx25xEYkfo0PmopvTxC
         6Mc1ISZvlBE8hm/TYls84q50iEmrO8OTSwUfAOYHWxvmq5G4q3tHrvddW6BfGlAJaXXa
         7jtZbfY4KCbYKA922DT7v4HaAYQlRavyHrrpgTJ650wUBUgxocGjlFGX5ZdwB2iFOxvt
         Sb0vnDNEX8KpkSdUPfi9dXotay6ssMYaQk9GrMx5bqH0g6TjEErAVqtu1pf7rtwPgd1d
         LRRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=MShH3I1oLcjvEJbj3NYW9C342mvg+PbbBJCOoSH1HSQ=;
        b=kCJoZOPTNpD1ebtpkWfVafmRULzhTBSm77bUJmHGn/lVW59dOTgds1DuKUPZvbWPjf
         ElsHOUOTCLTA0pmL/aAVdnp4nln03TGKBjdC5neROzl5XlqE44NseQj0pL1AwgMS8VCA
         RY3HHbGbp9x6+Wjawa+smMtcr/7LEdQLqdmbCiSfuVUkrJMUFPubVWca/m6g9Od+IAy1
         iaQ06lDbVezKwSGofwEYYzWrKYRzxG3USfxizeiyoEtOAX5AG4cpsEoARt1PudwehieF
         QUSyG8qJAQSoFlGrM9Gj0IZ0MzNQllPdtAUuStnYcJ7k2WULhzCn/TciZYPnhO8HGI/o
         VOCg==
X-Gm-Message-State: AOAM530Dq0OaA3be1mVD/q8hgV4O11WED7M15AeVc+kPSesgSs4mUrHD
        DoTgsfdzfIMRkYdBTY3Lq+PF0xYWJNk=
X-Google-Smtp-Source: ABdhPJx5px4YCOzuxVaL63VwwQLE+zcsL6qsTZcmWHgsANcGMolFMRqq/fwgx6MIzZ049mi7yH0PVbKuSkw=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:7220:84ff:fe09:2d90])
 (user=yuzhao job=sendgmr) by 2002:a0c:b21b:: with SMTP id x27mr31580996qvd.12.1600398058666;
 Thu, 17 Sep 2020 20:00:58 -0700 (PDT)
Date:   Thu, 17 Sep 2020 21:00:38 -0600
Message-Id: <20200918030051.650890-1-yuzhao@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH 00/13] mm: clean up some lru related pieces
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Huang Ying <ying.huang@intel.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Jaewon Kim <jaewon31.kim@samsung.com>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Andrew,

I see you have taken this:
  mm: use add_page_to_lru_list()/page_lru()/page_off_lru()
Do you mind dropping it?

Michal asked to do a bit of additional work. So I thought I probably
should create a series to do more cleanups I've been meaning to.

This series contains the change in the patch above and goes a few
more steps farther. It's intended to improve readability and should
not have any performance impacts. There are minor behavior changes in
terms of debugging and error reporting, which I have all highlighted
in the individual patches. All patches were properly tested on 5.8
running Chrome OS, with various debug options turned on.

Michal,

Do you mind taking a looking at the entire series?

Thank you.

Yu Zhao (13):
  mm: use add_page_to_lru_list()
  mm: use page_off_lru()
  mm: move __ClearPageLRU() into page_off_lru()
  mm: shuffle lru list addition and deletion functions
  mm: don't pass enum lru_list to lru list addition functions
  mm: don't pass enum lru_list to trace_mm_lru_insertion()
  mm: don't pass enum lru_list to del_page_from_lru_list()
  mm: rename page_off_lru() to __clear_page_lru_flags()
  mm: inline page_lru_base_type()
  mm: VM_BUG_ON lru page flags
  mm: inline __update_lru_size()
  mm: make lruvec_lru_size() static
  mm: enlarge the int parameter of update_lru_size()

 include/linux/memcontrol.h     |  14 ++--
 include/linux/mm_inline.h      | 115 ++++++++++++++-------------------
 include/linux/mmzone.h         |   2 -
 include/linux/vmstat.h         |   2 +-
 include/trace/events/pagemap.h |  11 ++--
 mm/compaction.c                |   2 +-
 mm/memcontrol.c                |  10 +--
 mm/mlock.c                     |   2 +-
 mm/swap.c                      |  53 ++++++---------
 mm/vmscan.c                    |  28 +++-----
 10 files changed, 95 insertions(+), 144 deletions(-)

-- 
2.28.0.681.g6f77f65b4e-goog

