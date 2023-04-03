Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C026D547E
	for <lists+cgroups@lfdr.de>; Tue,  4 Apr 2023 00:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbjDCWFm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 Apr 2023 18:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjDCWFg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 3 Apr 2023 18:05:36 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7555446BD
        for <cgroups@vger.kernel.org>; Mon,  3 Apr 2023 15:05:33 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id eg48so122965007edb.13
        for <cgroups@vger.kernel.org>; Mon, 03 Apr 2023 15:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680559532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+Pu9YVys7d4kSNF1Q1j+VStoW6Udcnhp1204T10rf0=;
        b=MQc0fA7+oJ5pXhxxZImDXr5z6gNisXy6E+KS8J35TPw72G5kFBVbjh7kwQJ1pYpeKX
         ALIeHYtsuFVit4ojWHQg4PjXvHbvMvILW8/w0oxNN8pueWh6LStay5FVuUqUuGorC5Z6
         RS8g+Zsr99eX3NBfJHoshcrdMnlMJYyd2SsO+3bQTJdgfu4m5arn5ecYYnb97xK+LXBC
         ZBJkG0iOD7lxiLAB3PLydCsDk4EOZuHuZMpkwrwcF37r2t4CxP/ou8MAuJaMyMotyi7g
         GsK+x/49ejSIp1u7NJ8dsNOj8sud5LRpXF2CDd8KqUSH5kNjZsROpa5HzOhGwnXl/bTF
         B/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680559532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S+Pu9YVys7d4kSNF1Q1j+VStoW6Udcnhp1204T10rf0=;
        b=Tjo4S50at6OwwoqwHrECZjh3x/05NKGXCYLUjct+paWAU9bgZQnrAB0o0m+TZWIObe
         Wr4QF0i0RkJGIPEK20B50t//IMcfhwtCOeE+Q66sxV0IdmBDHdmK5binxojFpEZvilHz
         4B8cOIwrgqh1f9KsQj9FSNb01/McVmPq6r/hHi+qGFuGPcc0LiV+cZ/YIZGQoYBYkiWY
         k+zQPuuJiyWcQkUxuOn8gXeNlWgFb/L8gpUy45zqVZOetebGJeYwIhAIbkXNA9pE/qrH
         Coyid75GCW2RdeTHh3ggX5OSzve/P6UVbylkt1XrGPx0nRc/8bZ3q7n37+DaxxvYLmZw
         82Qw==
X-Gm-Message-State: AAQBX9fzZ5ItuOFDrVR3S+zAD41C6CJ9a8gpAZVWr1s14OXrAZbkyEt9
        7ewamPcA7OC5SZYxg2QMBjoDC/BPtK7jS+NmmnKjWg==
X-Google-Smtp-Source: AKy350a2bd0/HTdijZ5WvqoL/zNRl0YKvmiDnDigwaVD5dalacSBW35g211bTWin+PlIlTCfJIAwts6dy0xwSO/2qJE=
X-Received: by 2002:a17:907:7894:b0:8e5:411d:4d09 with SMTP id
 ku20-20020a170907789400b008e5411d4d09mr85418ejc.15.1680559531710; Mon, 03 Apr
 2023 15:05:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230403220337.443510-1-yosryahmed@google.com>
In-Reply-To: <20230403220337.443510-1-yosryahmed@google.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 3 Apr 2023 15:04:55 -0700
Message-ID: <CAJD7tkZ5vh5ssDux1LStX9ZivmGmXsFyxfADGJD5AXDaMnGWRQ@mail.gmail.com>
Subject: Re: [PATCH mm-unstable RFC 0/5] cgroup: eliminate atomic rstat
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Apr 3, 2023 at 3:03=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> A previous patch series ([1] currently in mm-unstable) changed most

.. and I naturally forgot to link this:
[1] https://lore.kernel.org/linux-mm/20230330191801.1967435-1-yosryahmed@go=
ogle.com/

> atomic rstat flushing contexts to become non-atomic. This was done to
> avoid an expensive operation that scales with # cgroups and # cpus to
> happen with irqs disabled and scheduling not permitted. There were two
> remaining atomic flushing contexts after that series. This series tries
> to eliminate them as well, eliminating atomic rstat flushing completely.
>
> The two remaining atomic flushing contexts are:
> (a) wb_over_bg_thresh()->mem_cgroup_wb_stats()
> (b) mem_cgroup_threshold()->mem_cgroup_usage()
>
> For (a), flushing needs to be atomic as wb_writeback() calls
> wb_over_bg_thresh() with a spinlock held. However, it seems like the
> call to wb_over_bg_thresh() doesn't need to be protected by that
> spinlock, so this series proposes a refactoring that moves the call
> outside the lock criticial section and makes the stats flushing
> in mem_cgroup_wb_stats() non-atomic.
>
> For (b), flushing needs to be atomic as mem_cgroup_threshold() is called
> with irqs disabled. We only flush the stats when calculating the root
> usage, as it is approximated as the sum of some memcg stats (file, anon,
> and optionally swap) instead of the conventional page counter. This
> series proposes changing this calculation to use the global stats
> instead, eliminating the need for a memcg stat flush.
>
> After these 2 contexts are eliminated, we no longer need
> mem_cgroup_flush_stats_atomic() or cgroup_rstat_flush_atomic(). We can
> remove them and simplify the code.
>
> Yosry Ahmed (5):
>   writeback: move wb_over_bg_thresh() call outside lock section
>   memcg: flush stats non-atomically in mem_cgroup_wb_stats()
>   memcg: calculate root usage from global state
>   memcg: remove mem_cgroup_flush_stats_atomic()
>   cgroup: remove cgroup_rstat_flush_atomic()
>
>  fs/fs-writeback.c          | 16 +++++++----
>  include/linux/cgroup.h     |  1 -
>  include/linux/memcontrol.h |  5 ----
>  kernel/cgroup/rstat.c      | 26 ++++--------------
>  mm/memcontrol.c            | 54 ++++++++------------------------------
>  5 files changed, 27 insertions(+), 75 deletions(-)
>
> --
> 2.40.0.348.gf938b09366-goog
>
