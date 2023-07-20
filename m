Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463FD75A745
	for <lists+cgroups@lfdr.de>; Thu, 20 Jul 2023 09:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjGTHId (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Jul 2023 03:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjGTHI3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Jul 2023 03:08:29 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883702123
        for <cgroups@vger.kernel.org>; Thu, 20 Jul 2023 00:08:28 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-56336f5dc6cso230704a12.0
        for <cgroups@vger.kernel.org>; Thu, 20 Jul 2023 00:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689836908; x=1692428908;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U/LCb/swRVuVzVICP60Gq89mZaxuIEA6maW/j6Ih8uc=;
        b=NmItOuI1BO8FpivokQJywTfJdRc87myk9anTbJ4UoJVsByhpyWZ2NhGs3XaN2cP2Nt
         JOV9ihqCzY8Rxsp+r6isfIFkW/SUwj9Vss4W2DuK2ccFsP635edEhy1jQxM9GiR5RwCK
         5oMMI3/PuSouXpEAZw7u4v68TUmwdBfHnyKCeBIftZE10kZdkxmv5uViyp1Mkr88BgDy
         w0adw8Rgvu0dZI9YOQ0lxUV8rJvfzPt+gm6BycHBJUwzSYgtNUNUoYFoNjXznI+XvsO6
         3RMjTaAvwUCkl3RUI9BRhsU/hvOSutDDKijJFjy210IHQPmnpkspt3yoNydMInG9aMxS
         +bjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689836908; x=1692428908;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U/LCb/swRVuVzVICP60Gq89mZaxuIEA6maW/j6Ih8uc=;
        b=F/lgP3ueKXDbnM2tlE7c2cg2FJfEjhUqeyyPIqqnwVez6VDAkxpYTHdFDj8moEwYLM
         TmqG8tEPo6VEre3FIra/LVyhBvcapv+jWLqE2pEPPYfVP+YHxincqVwNSWLc8T90cw6W
         TkqUgzLgPEOm3YtgOMOftWhUTEEI6NLKhrMgZg/io3Mp2+Zh0sxYZyHoPlWTthVGdq+A
         tooCe0u3t72rlsYjBU+KqYHCbQ4YqiWcUz/h0ITwsG4VKiEcVUHDrn1j0b+X7hVG8Idf
         tl07tGDXb4FdykEFYCWQNlMCtk27FTUoyZh7LFjMR47yWg1mQvirxf95efqWu9BmXYhy
         3tEg==
X-Gm-Message-State: ABy/qLb/F/Dr0DHTmNELQWPS+QmZF3730jIKv1u+SjbDr7IFGWCgx6HC
        Fs7/o1YpN7l5Yz7C1BcHlEcYMHb/wB0OfM77
X-Google-Smtp-Source: APBJJlGoahb1Hw3DrqI5/DdSPxhCfuqs9wKCySncxj0p/hiZ24g7ZOrRHDY0we6awSzCS5RXF+EZYXNCxdbOuEoT
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a63:6d4f:0:b0:530:3a44:1581 with SMTP
 id i76-20020a636d4f000000b005303a441581mr20974pgc.9.1689836907839; Thu, 20
 Jul 2023 00:08:27 -0700 (PDT)
Date:   Thu, 20 Jul 2023 07:08:17 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230720070825.992023-1-yosryahmed@google.com>
Subject: [RFC PATCH 0/8] memory recharging for offline memcgs
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>
Cc:     Muchun Song <muchun.song@linux.dev>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Yu Zhao <yuzhao@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "T.J. Mercier" <tjmercier@google.com>,
        Greg Thelen <gthelen@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This patch series implements the proposal in LSF/MM/BPF 2023 conference
for reducing offline/zombie memcgs by memory recharging [1]. The main
difference is that this series focuses on recharging and does not
include eviction of any memory charged to offline memcgs.

Two methods of recharging are proposed:

(a) Recharging of mapped folios.

When a memcg is offlined, queue an asynchronous worker that will walk
the lruvec of the offline memcg and try to recharge any mapped folios to
the memcg of one of the processes mapping the folio. The main assumption
is that a process mapping the folio is the "rightful" owner of the
memory.

Currently, this is only supported for evictable folios, as the
unevictable lru is imaginary and we cannot iterate the folios on it. A
separate proposal [2] was made to revive the unevictable lru, which
would allow recharging of unevictable folios.

(b) Deferred recharging of folios.

For folios that are unmapped, or mapped but we fail to recharge them
with (a), we rely on deferred recharging. Simply put, any time a folio
is accessed or dirtied by a userspace process, and that folio is charged
to an offline memcg, we will try to recharge it to the memcg of the
process accessing the folio. Again, we assume this process should be the
"rightful" owner of the memory. This is also done asynchronously to avoid
slowing down the data access path.

In both cases, we never OOM kill the recharging target if it goes above
limit. This is to avoid OOM killing a process an arbitrary amount of
time after it started using memory. This is a conservative policy that
can be revisited later.

The patches in this series are divided as follows:
- Patches 1 & 2 are preliminary refactoring and helpers introducion.
- Patches 3 to 5 implement (a) and (b) above.
- Patches 6 & 7 add stats, a sysctl, and a config option.
- Patch 8 is a selftest.

[1]https://lore.kernel.org/linux-mm/CABdmKX2M6koq4Q0Cmp_-=wbP0Qa190HdEGGaHfxNS05gAkUtPA@mail.gmail.com/
[2]https://lore.kernel.org/lkml/20230618065719.1363271-1-yosryahmed@google.com/

Yosry Ahmed (8):
  memcg: refactor updating memcg->moving_account
  mm: vmscan: add lruvec_for_each_list() helper
  memcg: recharge mapped folios when a memcg is offlined
  memcg: support deferred memcg recharging
  memcg: recharge folios when accessed or dirtied
  memcg: add stats for offline memcgs recharging
  memcg: add sysctl and config option to control memory recharging
  selftests: cgroup: test_memcontrol: add a selftest for memcg
    recharging

 include/linux/memcontrol.h                    |  14 +
 include/linux/swap.h                          |   8 +
 include/linux/vm_event_item.h                 |   5 +
 kernel/sysctl.c                               |  11 +
 mm/Kconfig                                    |  12 +
 mm/memcontrol.c                               | 376 +++++++++++++++++-
 mm/page-writeback.c                           |   2 +
 mm/swap.c                                     |   2 +
 mm/vmscan.c                                   |  28 ++
 mm/vmstat.c                                   |   6 +-
 tools/testing/selftests/cgroup/cgroup_util.c  |  14 +
 tools/testing/selftests/cgroup/cgroup_util.h  |   1 +
 .../selftests/cgroup/test_memcontrol.c        | 310 +++++++++++++++
 13 files changed, 784 insertions(+), 5 deletions(-)

-- 
2.41.0.255.g8b1d071c50-goog

