Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D096D5464
	for <lists+cgroups@lfdr.de>; Tue,  4 Apr 2023 00:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbjDCWDn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 Apr 2023 18:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbjDCWDm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 3 Apr 2023 18:03:42 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5C026AD
        for <cgroups@vger.kernel.org>; Mon,  3 Apr 2023 15:03:40 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d2-20020a170902cec200b001a1e8390831so18073424plg.5
        for <cgroups@vger.kernel.org>; Mon, 03 Apr 2023 15:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680559419;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Oudpa17NQV9icHAF4JVW0zNdSUdsNavz+h9FQ4FdLBA=;
        b=gmD3EzUX38OVjaGFgrpka4qXeIu+V1DoGMvDe0eWXeLuVA1CJdcNcSnyr+n+EpIa7P
         3MzjOnSmoFXG3JxX7Cs0Wn8GkvgBkLa16nyiWlhViz9Kto3HXhbMSTrrqLF92l4pjOwM
         Bl/A9PadEA4W2+qgRGAzaoQf4/LsxKQq3zYjYpbh+vXPlDzaJ4S4K1nV++HobeWezLIl
         5VMhWDSPBl0YL4XGy/N1tyENDpHWNaUPOK4Xcs933WjQ4R2VnAzEP/q0VSAq3rp+G1sc
         XYLTFN0b46pCsuwvdg0Q0NbrDy9LoUkmRlggmmc6W32L6LZuB1HPkybaEDU5BBFcgTTW
         Tt7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680559419;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oudpa17NQV9icHAF4JVW0zNdSUdsNavz+h9FQ4FdLBA=;
        b=H7FGh0u0UoB3ngwW7o3CBqOBXblyzPjQHMYQ4GQB/rMUaV5OxaidknV8SraQffhKZp
         S/0giQOH6MfLQMLrv897Ob7qWkHomXGgJplbBPsOE5DPqqWDwbIJ+OO0tD+qmdE8zp+C
         Vz7e1y2B2yZgP80F2Ra4fZ0QUm2BROPsWpv/5YmAqwA0jN+clWgsPw9gVxDEki79yMSR
         kKfiNQ4oCumYoweTCw8k9eSM1QYnL7rMRn3RsNuys3ljW5ioXwp9qFMTdKbFDVGqLJdJ
         v3ulnbVR3ZlyFWkvpTgcLmHJRfBFstktsqZcDA7g2iTJqqcwNka6zntGIPaqDKYgNupW
         TWlw==
X-Gm-Message-State: AAQBX9e0x32ZgEfkQDeGebaTYjqflAtfWLMa/r+1kqHUQSxsM17S9m28
        IoAphxxzSWvAoqyDKwFpEgB/zPzKf5vMKCQy
X-Google-Smtp-Source: AKy350bKjU+buVnqVou7mkcDlyP7x8rTHIyL9RVPi5Km1Z/toXrwbT5kmEIGX491iMh7wgy+1apIE3kjSSGe4OaY
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:902:9b91:b0:1a1:9015:4d5c with SMTP
 id y17-20020a1709029b9100b001a190154d5cmr211513plp.3.1680559419448; Mon, 03
 Apr 2023 15:03:39 -0700 (PDT)
Date:   Mon,  3 Apr 2023 22:03:32 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230403220337.443510-1-yosryahmed@google.com>
Subject: [PATCH mm-unstable RFC 0/5] cgroup: eliminate atomic rstat
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

A previous patch series ([1] currently in mm-unstable) changed most
atomic rstat flushing contexts to become non-atomic. This was done to
avoid an expensive operation that scales with # cgroups and # cpus to
happen with irqs disabled and scheduling not permitted. There were two
remaining atomic flushing contexts after that series. This series tries
to eliminate them as well, eliminating atomic rstat flushing completely.

The two remaining atomic flushing contexts are:
(a) wb_over_bg_thresh()->mem_cgroup_wb_stats()
(b) mem_cgroup_threshold()->mem_cgroup_usage()

For (a), flushing needs to be atomic as wb_writeback() calls
wb_over_bg_thresh() with a spinlock held. However, it seems like the
call to wb_over_bg_thresh() doesn't need to be protected by that
spinlock, so this series proposes a refactoring that moves the call
outside the lock criticial section and makes the stats flushing
in mem_cgroup_wb_stats() non-atomic.

For (b), flushing needs to be atomic as mem_cgroup_threshold() is called
with irqs disabled. We only flush the stats when calculating the root
usage, as it is approximated as the sum of some memcg stats (file, anon,
and optionally swap) instead of the conventional page counter. This
series proposes changing this calculation to use the global stats
instead, eliminating the need for a memcg stat flush.

After these 2 contexts are eliminated, we no longer need
mem_cgroup_flush_stats_atomic() or cgroup_rstat_flush_atomic(). We can
remove them and simplify the code.

Yosry Ahmed (5):
  writeback: move wb_over_bg_thresh() call outside lock section
  memcg: flush stats non-atomically in mem_cgroup_wb_stats()
  memcg: calculate root usage from global state
  memcg: remove mem_cgroup_flush_stats_atomic()
  cgroup: remove cgroup_rstat_flush_atomic()

 fs/fs-writeback.c          | 16 +++++++----
 include/linux/cgroup.h     |  1 -
 include/linux/memcontrol.h |  5 ----
 kernel/cgroup/rstat.c      | 26 ++++--------------
 mm/memcontrol.c            | 54 ++++++++------------------------------
 5 files changed, 27 insertions(+), 75 deletions(-)

-- 
2.40.0.348.gf938b09366-goog

