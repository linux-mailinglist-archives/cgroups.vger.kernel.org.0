Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511C56886C3
	for <lists+cgroups@lfdr.de>; Thu,  2 Feb 2023 19:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbjBBSjg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Feb 2023 13:39:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbjBBSjc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Feb 2023 13:39:32 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FD039B83
        for <cgroups@vger.kernel.org>; Thu,  2 Feb 2023 10:39:08 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id d8so2836781ljq.9
        for <cgroups@vger.kernel.org>; Thu, 02 Feb 2023 10:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KAbO+NGYMMBiRGmoWvlyv/VWZlOHs7HzWvQI05DtDaQ=;
        b=LDbZ5uYL7OA/3my6XOP4T51z1xT3UdJzNpZXZ+C0QAlG7OmRPWc/yZCZuH0y0zioRG
         uS0f+mq+upPFV+n8dvEUMUuySH5pvxg2/iJ7UKvSV2ku5bY4+RPaurbhnbpVRx2U3m3n
         oJEQn8w+Defn6Q0hpiTzExqk5nDpibuhRam5J8YumCAvehgO5RbMAIEZK7Aimy66+56k
         AKSawVpHyTSbwC8PmpeW6pQ1/SzCd6xZ+xAkYcRitTMhzpiIRocnHVkpJf1jIxtS/Vme
         S1PiFEPev5QdWe6uDFlIaQZtAyNZJ82aLqaB8K9nGZFNnJGat3HYP8edfXeMDkfdcPIX
         qjSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KAbO+NGYMMBiRGmoWvlyv/VWZlOHs7HzWvQI05DtDaQ=;
        b=pKmylIoDqsQj635ljUwm7ZptVMNTDmUhW9dKbWsFvyh/EZzgtKYzVI4DFGEeOZPefG
         ktpQUyyirmqy0Ze70QYfGQh+YuHvanmo4NehPSWxxWTjS8Z4wiaCrAJ6M0wdl2cCn4yI
         72Cu5KM2D+0I0F9lF5qKQqIo7/4YRCBWjRhhxi3nHzvPj9d/nHW/VHXJKN5mF4LNifN6
         PO0NQkr6+iBXdjeYhaeTH0x39BmyTtKwo29o371yqKsnxwt+NpAYNh7dOPwUg6ZI/7hV
         OgpZqojeBkvD6NV0IChN1N5rT+HUMLNd0uNWYDr4qBn/OBNz30ukOVZWMa+6lenXoS2d
         xBHg==
X-Gm-Message-State: AO0yUKVy0xM/D1xO4/ygIRlth/Dy/mPT+1gCZb75KwcAdPDKrGPUnjM5
        h/vRscgdGbbAKYiE2Czfu1chNQjvsxfPIatxGfkfeXyFxklC2X/T
X-Google-Smtp-Source: AK7set9Z1HSNUrxErEjCY9FIwYAXch2A7hSs5PckDTeqVPlsEoRDUWckZV5TPaeVMXzzhxSnsOB38bqNUdqp6lBWfKo=
X-Received: by 2002:a17:906:c241:b0:7c0:b3a8:a5f9 with SMTP id
 bl1-20020a170906c24100b007c0b3a8a5f9mr2108862ejb.154.1675362677201; Thu, 02
 Feb 2023 10:31:17 -0800 (PST)
MIME-Version: 1.0
References: <20230202155626.1829121-1-hannes@cmpxchg.org>
In-Reply-To: <20230202155626.1829121-1-hannes@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 2 Feb 2023 10:30:40 -0800
Message-ID: <CAJD7tkaCpD0LpzdA+NsZj2WK=iQCLn7RS9qc7K53Qonxhp4TgA@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: memcontrol: don't account swap failures not due
 to cgroup limits
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@suse.com>, Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Feb 2, 2023 at 7:56 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> Christian reports the following situation in a cgroup that doesn't
> have memory.swap.max configured:
>
>   $ cat memory.swap.events
>   high 0
>   max 0
>   fail 6218
>
> Upon closer examination, this is an ARM64 machine that doesn't support
> swapping out THPs. In that case, the first get_swap_page() fails, and
> the kernel falls back to splitting the THP and swapping the 4k
> constituents one by one. /proc/vmstat confirms this with a high rate
> of thp_swpout_fallback events.
>
> While the behavior can ultimately be explained, it's unexpected and
> confusing. I see three choices how to address this:
>
> a) Specifically exlude THP fallbacks from being counted, as the
>    failure is transient and the memory is ultimately swapped.
>
>    Arguably, though, the user would like to know if their cgroup's
>    swap limit is causing high rates of THP splitting during swapout.

We have the option to add THP_SWPOUT_FALLBACK (and THP_SWPOUT for
completeness) to memcg events for this if/when a use case arises,
right?

>
> b) Only count cgroup swap events when they are actually due to a
>    cgroup's own limit. Exclude failures that are due to physical swap
>    shortage or other system-level conditions (like !THP_SWAP). Also
>    count them at the level where the limit is configured, which may be
>    above the local cgroup that holds the page-to-be-swapped.
>
>    This is in line with how memory.swap.high, memory.high and
>    memory.max events are counted.
>
>    However, it's a change in documented behavior.

This option makes sense to me, but I can't speak to the change of
documented behavior. However, looking at the code, it seems like if we do this
the "max" & "fail" counters become effectively the same. "fail" would
not provide much value then.

I wonder if it makes sense to have both, and clarify that "fail" -
"max" would be non-limit based failures (e.g. ran out of swap space),
or would this cause confusion as to whether those non-limit failures
were transient (THP fallback) or eventual?


>
> c) Leave it as is. The documentation says system-level events are
>    counted, so stick to that.
>
>    This is the conservative option, but isn't very user friendly.
>    Cgroup events are usually due to a local control choice made by the
>    user. Mixing in events that are beyond the user's control makes it
>    difficult to id root causes and configure the system properly.
>
> Implement option b).
>
> Reported-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  Documentation/admin-guide/cgroup-v2.rst |  6 +++---
>  mm/memcontrol.c                         | 12 +++++-------
>  mm/swap_slots.c                         |  2 +-
>  3 files changed, 9 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index c8ae7c897f14..a8ffb89a4169 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1605,9 +1605,9 @@ PAGE_SIZE multiple when read back.
>                 failed.
>
>           fail
> -               The number of times swap allocation failed either
> -               because of running out of swap system-wide or max
> -               limit.
> +
> +               The number of times swap allocation failed because of
> +               the max limit.
>
>         When reduced under the current usage, the existing swap
>         entries are reclaimed gradually and the swap usage may stay
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index ab457f0394ab..c2a6206ce84b 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -7470,17 +7470,15 @@ int __mem_cgroup_try_charge_swap(struct folio *folio, swp_entry_t entry)
>         if (!memcg)
>                 return 0;
>
> -       if (!entry.val) {
> -               memcg_memory_event(memcg, MEMCG_SWAP_FAIL);
> -               return 0;
> -       }
> -
>         memcg = mem_cgroup_id_get_online(memcg);
>
>         if (!mem_cgroup_is_root(memcg) &&
>             !page_counter_try_charge(&memcg->swap, nr_pages, &counter)) {
> -               memcg_memory_event(memcg, MEMCG_SWAP_MAX);
> -               memcg_memory_event(memcg, MEMCG_SWAP_FAIL);
> +               struct mem_cgroup *swap_over_limit;
> +
> +               swap_over_limit = mem_cgroup_from_counter(counter, swap);
> +               memcg_memory_event(swap_over_limit, MEMCG_SWAP_MAX);
> +               memcg_memory_event(swap_over_limit, MEMCG_SWAP_FAIL);
>                 mem_cgroup_id_put(memcg);
>                 return -ENOMEM;
>         }
> diff --git a/mm/swap_slots.c b/mm/swap_slots.c
> index 0bec1f705f8e..66076bd60e2b 100644
> --- a/mm/swap_slots.c
> +++ b/mm/swap_slots.c
> @@ -342,7 +342,7 @@ swp_entry_t folio_alloc_swap(struct folio *folio)
>
>         get_swap_pages(1, &entry, 1);
>  out:
> -       if (mem_cgroup_try_charge_swap(folio, entry)) {
> +       if (entry.val && mem_cgroup_try_charge_swap(folio, entry) < 0) {
>                 put_swap_folio(folio, entry);
>                 entry.val = 0;
>         }
> --
> 2.39.1
>
>
