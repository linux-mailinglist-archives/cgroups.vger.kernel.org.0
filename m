Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2FD64D297
	for <lists+cgroups@lfdr.de>; Wed, 14 Dec 2022 23:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiLNWvq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 14 Dec 2022 17:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiLNWvo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 14 Dec 2022 17:51:44 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B873723D
        for <cgroups@vger.kernel.org>; Wed, 14 Dec 2022 14:51:42 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-410f1a84ed2so14437577b3.15
        for <cgroups@vger.kernel.org>; Wed, 14 Dec 2022 14:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nWNYEkPGu4xeEk865eL9sMmuW2qvvMiYdO6LZIHyaa0=;
        b=myX2b9usISZoaAY5lU77WMryQ3aiX1kl/4FYrRRu2anLDBwXSbsBolikYQkFrE5uPw
         lKs2zBenkmqM7nk4VAPKqxphYh/C85VVm75JcjKuqBNO7N+RCTdsu9AKHgx8EHirHk0T
         w2r7juJ9kckYckm1i+vB7kURLm7hD2ScKtVQmsSW++IEbyOuNS0oIEenv3GT7xAIZGOX
         ggQX/lJ0VWmWQKS79OFshXSdsQBIsO8T5XlIfMQRtVy0cVtOKlhsA0DnGU5/gGbBUU/V
         Sl08VGAI9QDRgV8KEgh9sUbJzjvAOu6YVO6tvrm43b8SdqxmfkyWf4RSUf6hEhzEtctS
         GUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nWNYEkPGu4xeEk865eL9sMmuW2qvvMiYdO6LZIHyaa0=;
        b=eiQzyELq37iy32Bo5AJjR/Gh0I3Vg/ZlvF+hn4e/F83JV37umMQfiU+6sJmtXVLrJQ
         3F3d7R6wR23FWEIEg5J8Q0iyb6bXhhrpRzc2TgR4/BQ0eErI5qKMhDJha/8Nm8RyD1NQ
         om5t+1MjvTJkoeb542vHpqN+epMS9RA9iRLIsysdGnQrxhTvBuRH3fPAtXKxTAE6Jk12
         sCh56+/pAune0obEgutF01uopQNLxgGxYTK9QXPARFSe5K6JkgYMlBqdx8fphX3d7fJJ
         37+A1wedD6L30XvPx4SUK/A+5oFkki+xNY2jdQNkIpGCKEBbmQtNCcPGdFqSxImXpKCF
         SNgA==
X-Gm-Message-State: ANoB5pkA6Q5O2LlKxPa84JXykKjqko1VhZjixqTfeomOEXZckRzIRk4J
        jFioGBphoTFnrpI3fLj2dZ5/o9zEzr7e
X-Google-Smtp-Source: AA0mqf5p/8+ElAHu6Tyopsq5sy0q9WFD35Y2Rao35CtwLJIqMC0MUh72/TWe1DhYSvz6JihTOiHjdwdazh4j
X-Received: from yuanchu.svl.corp.google.com ([2620:15c:2d4:203:1311:60bc:9e2a:ab1])
 (user=yuanchu job=sendgmr) by 2002:a81:7b06:0:b0:3d8:677e:29e with SMTP id
 w6-20020a817b06000000b003d8677e029emr38045398ywc.410.1671058302001; Wed, 14
 Dec 2022 14:51:42 -0800 (PST)
Date:   Wed, 14 Dec 2022 14:51:21 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221214225123.2770216-1-yuanchu@google.com>
Subject: [RFC PATCH 0/2] mm: multi-gen LRU: working set extensions
From:   Yuanchu Xie <yuanchu@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, Yuanchu Xie <yuanchu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Introduce a way of monitoring the working set of a workload, per page
type and per NUMA node, with granularity in minutes. It has page-level
granularity and minimal memory overhead by building on the
Multi-generational LRU framework, which already has most of the
infrastructure and is just missing a useful interface.

MGLRU organizes pages in generations, where an older generation contains
colder pages, and aging promotes the recently used pages into the young
generation and creates a new one. The working set size is how much
memory an application needs to keep working, the amount of "hot" memory
that's frequently used. The only missing pieces between MGLRU
generations and working set estimation are a consistent aging cadence
and an interface; we introduce the two additions.

Periodic aging
======
MGLRU Aging is currently driven by reclaim, so the amount of time
between generations is non-deterministic. With memcgs being aged
regularly, MGLRU generations become time-based working set information.

- memory.periodic_aging: a new root-level only file in cgroupfs
Writing to memory.periodic_aging sets the aging interval and opts into
periodic aging.
- kold: a new kthread that ages memcgs based on the set aging interval.

Page idle age stats
======
- memory.page_idle_age: we group pages into idle age ranges, and present
  the number of pages per node per pagetype in each range. This
  aggregates the time information from MGLRU generations hierarchically.

Use case: proactive reclaimer
======
The proactive reclaimer sets the aging interval, and periodically reads
the page idle age stats, forming a working set estimation, which it then
calculates an amount to write to memory.reclaim.

With the page idle age stats, a proactive reclaimer could calculate a
precise amount of memory to reclaim without continuously probing and
inducing reclaim.

A proactive reclaimer that uses a similar interface is used in the
Google data centers.

Use case: workload introspection
======
A workload may use the working set estimates to adjust application
behavior as needed, e.g. preemptively killing some of its workers to
avoid its working set thrashing, or dropping caches to fit within a
limit.
It can also be valuable to application developers, who can benefit from
an out-of-the-box overview of the application's usage behaviors.

TODO List
======
- selftests
- a userspace demonstrator combining periodic aging, page idle age
  stats, memory.reclaim, and/or PSI

Open questions
======
- MGLRU aging mechanism has a flag called force_scan. With
  force_scan=false, invoking MGLRU aging when an lruvec has a maximum
  number of generations does not actually perform aging.
  However, with force_scan=true, MGLRU moves the pages in the oldest
  generation to the second oldest generation. The force_scan=true flag
  also disables some optimizations in MGLRU's page table walks.
  The current patch sets force_scan=true, so that periodic aging would
  work without a proactive reclaimer evicting the oldest generation.

- The page idle age format uses a fixed set of time ranges in seconds.
  I have considered having it be based on the aging interval, or just
  compiling the raw timestamps.
  With the age ranges based on the aging interval, a memcg that's
  undergoing memcg reclaim might have its generations in the 10
  seconds range, and a much longer aging interval would obscure this
  fact.
  The raw timestamps from MGLRU could lead to a very large file when
  aggregated hierarchically.

Yuanchu Xie (2):
  mm: multi-gen LRU: periodic aging
  mm: multi-gen LRU: cgroup working set stats

 include/linux/kold.h   |  44 ++++++++++
 include/linux/mmzone.h |   4 +-
 mm/Makefile            |   3 +
 mm/kold.c              | 150 ++++++++++++++++++++++++++++++++
 mm/memcontrol.c        | 188 +++++++++++++++++++++++++++++++++++++++++
 mm/vmscan.c            |  35 +++++++-
 6 files changed, 422 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/kold.h
 create mode 100644 mm/kold.c

-- 
2.39.0.314.g84b9a713c41-goog

