Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75026EB1E3
	for <lists+cgroups@lfdr.de>; Fri, 21 Apr 2023 20:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjDUSzJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 21 Apr 2023 14:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjDUSzI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 21 Apr 2023 14:55:08 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDC92716
        for <cgroups@vger.kernel.org>; Fri, 21 Apr 2023 11:55:05 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5058181d58dso3478623a12.1
        for <cgroups@vger.kernel.org>; Fri, 21 Apr 2023 11:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682103304; x=1684695304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AyMpFu/gW7V1QrWAD4ujKdEEmizb8dHB+Px9T26Bj7E=;
        b=isKqoY3MjZ10VkA1kWh+K/1YIbVB4ZAvLYZAyLAJfiirefha06VhT3jDD1NVNvMn8Q
         J9hQAx4CkqnErz52Kq2lCF6CcQ2DlcWv1SDGLyfzbCLdaOS2m6YvuHyDkbCYi2O3KRzU
         YxJPXTplFtFOoXZ9rGRR05f8wB2F/PTGdI3KnL86UeQFtPuP5pmvYzlw39z5pkHLEMWv
         0GYdOXyk3zC7QDBU4hzTaWRiOZIzh7kFLLqwAnDnVcpsKaH+o/o3VaBMuPNQ5xBKNSSB
         eNGUVOqm2tTMl+uuWvl6lg6RC+1CnCnvJFQ5ePHUUfAnd9D6D/VKsAE1UZh3+ZtCq6Qa
         HlZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682103304; x=1684695304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AyMpFu/gW7V1QrWAD4ujKdEEmizb8dHB+Px9T26Bj7E=;
        b=IjZXKDi7gzqCdXdb/HtCp3RK17rDyakoK4yH2dE9zhlPD7cxgFQet1aZiiXkATux09
         PJwm848hyTmOYoVOcmfyNNkXZpILHHu1RTM1ra14nUOiFtYmZaiUl/OLiJ67ekw8hkoO
         bqC1idyfOt0I088IFjt1JLkDQOdiSRutLSdYjrvDxLGC3Jjkr2sXWl2Ryt0HZ1TSB21R
         ZhRqHtqlOOxsmCHfu6ik4I6Aaepe8WH1x+/ssz0A0E85Js4HVAhEXRdchRjAT1ZPDYCt
         lWwYl1+G5YV1SVIqfMwC1Ivp5jIJ2fOeqYZbT6CghQS/JjkmnKyKYDNZNgPwQpyzQ5Ga
         Gbig==
X-Gm-Message-State: AAQBX9eyrDf9PB/0Aqyyko66upvhJ2FOMx/t4Te5G/ETXDHkZssP8XUd
        SLzLdJtvEMoxLYoYzGrl2gCUCfpfCkECPu/PxS+lOg==
X-Google-Smtp-Source: AKy350YxLnLo1mXDBp40Mi0RKka/emzWbasqRcxBHKJPfX4mUJngZNt7pHCurgMyvOJrufET2RW07qFhCmkYCcgAuSA=
X-Received: by 2002:a17:906:1b08:b0:94f:9f76:c74d with SMTP id
 o8-20020a1709061b0800b0094f9f76c74dmr3133846ejg.23.1682103303872; Fri, 21 Apr
 2023 11:55:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230421174020.2994750-1-yosryahmed@google.com>
In-Reply-To: <20230421174020.2994750-1-yosryahmed@google.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 21 Apr 2023 11:54:25 -0700
Message-ID: <CAJD7tkZKBGzBjkTGiVtwA=0VJ_L+UdGXjMWL7RcurQoooHTAUg@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] cgroup: eliminate atomic rstat flushing
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Apr 21, 2023 at 10:40=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> A previous patch series ([1] currently in mm-stable) changed most
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
> [1] https://lore.kernel.org/linux-mm/20230330191801.1967435-1-yosryahmed@=
google.com/
>
> RFC -> v1:
> - Collected R-b's and A-b's (Thanks everyone!).
> - Rebased onto mm-stable.
> - Cosmetic changes to commit logs.
>
> RFC: https://lore.kernel.org/linux-mm/20230403220337.443510-1-yosryahmed@=
google.com/

This is v1, not v5. I really suck at sending emails. Sorry.

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
> 2.40.0.634.g4ca3ef3211-goog
>
