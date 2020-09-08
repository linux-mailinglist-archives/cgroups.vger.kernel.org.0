Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 632C9262129
	for <lists+cgroups@lfdr.de>; Tue,  8 Sep 2020 22:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbgIHUcK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Sep 2020 16:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729912AbgIHUcF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Sep 2020 16:32:05 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91217C061755;
        Tue,  8 Sep 2020 13:32:04 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id j11so327573ejk.0;
        Tue, 08 Sep 2020 13:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L0s348EPZ76opdRD/bPy7Rbwh7tSlsvQeVHt84ZwjP8=;
        b=LRKeA5oYb87EGM45Ap1miIQqlIeSijAGRkWs3y4OODay63a561ttieuA5tKjKoztai
         2G/7a30tV/htfcq5CRqGXNqp/q55zOIwocN+4OMl05zoi5hAo19lTpeAL1maw4fTbdDn
         9cQYDcRSxIGwtEStIYyOouUZnn9wlHzDDxFgvSfxMUl7eqDDU3jbCR4uMgIwwsypUHJA
         KKPbUWwRWK1n1pjIn+P7MK03hEuzm2a9mIiTByFVxUxFPuUY7jPLfZdS+Vpwjm06d33K
         Qz2fzk7wXgy0CU/xVGCo4vXis/5sgpqH0xXWQrkcrL2bSt8ueHjnz1CuT31bA0kaAw4x
         E8NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L0s348EPZ76opdRD/bPy7Rbwh7tSlsvQeVHt84ZwjP8=;
        b=s+CAxaTh+jXW/oxNbY9fGbnI5ZerFLlQfzpGLa/P9CJGTn5fffRMdIT1el9sZ9lfWb
         akqGU9f/KKd33iO5wOxbKKcvB33qPB+LuY0MFTTpNZLMDx/mnMbjAkAVXj+/HS30mb9W
         zLhlco3B9IEjed0t8yatcA+nAR0b+xOAwww7pOl5B+tnhih5b+jyIKr7QgCp/lVsUlGf
         O4Bv84o8BNr5wjZw+lUztErTVvBQwn0x5E6BSOR42Lg1bKTcYd55OhO0AJ2mhB6UOf05
         NwfxdQ0P6xitGsf/O8JiwT7uWujrhuMrtYWcZ3Qpba4UK4k7dl+WT+9rfA/QUVC+J+q6
         40xw==
X-Gm-Message-State: AOAM533y31aecZwPjzl2Bgp+wT3Q4iApsLCjGDEGqJT5afgvGSVN1liB
        /dsb817jzM2iFh/cZGHYYofISn8Rb1tKDfe6DzA=
X-Google-Smtp-Source: ABdhPJzyL9Hjb/Dom8uDmNkOF6gkOXT/dAhKnE/DvCt1KLYQkR0JBaq9QbEI9HHaO1jZLxPHHr3mQ/738C7cvEcvvfo=
X-Received: by 2002:a17:907:2105:: with SMTP id qn5mr246845ejb.238.1599597123293;
 Tue, 08 Sep 2020 13:32:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200908201426.14837-1-jpitti@cisco.com>
In-Reply-To: <20200908201426.14837-1-jpitti@cisco.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 8 Sep 2020 13:31:51 -0700
Message-ID: <CAHbLzkqYrkA6=RSBpwEQJ5WaLUWwdP=05BPE2F4pRgk98NuVTg@mail.gmail.com>
Subject: Re: [PATCH v2] mm: memcg: yield cpu when we fail to charge pages
To:     Julius Hemanth Pitti <jpitti@cisco.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        xe-linux-external@cisco.com
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Sep 8, 2020 at 1:14 PM Julius Hemanth Pitti <jpitti@cisco.com> wrote:
>
> For non root CG, in try_charge(), we keep trying
> to charge until we succeed. On non-preemptive
> kernel, when we are OOM, this results in holding
> CPU forever.
>
> On SMP systems, this doesn't create a big problem
> because oom_reaper get a change to kill victim
> and make some free pages. However on a single-core
> CPU (or cases where oom_reaper pinned to same CPU
> where try_charge is executing), oom_reaper shall
> never get scheduled and we stay in try_charge forever.
>
> Steps to repo this on non-smp:
> 1. mount -t tmpfs none /sys/fs/cgroup
> 2. mkdir /sys/fs/cgroup/memory
> 3. mount -t cgroup none /sys/fs/cgroup/memory -o memory
> 4. mkdir /sys/fs/cgroup/memory/0
> 5. echo 40M > /sys/fs/cgroup/memory/0/memory.limit_in_bytes
> 6. echo $$ > /sys/fs/cgroup/memory/0/tasks
> 7. stress -m 5 --vm-bytes 10M --vm-hang 0

Isn't it the same problem solved by e3336cab2579 ("mm: memcg: fix
memcg reclaim soft lockup")? It has been in Linus's tree.

>
> Signed-off-by: Julius Hemanth Pitti <jpitti@cisco.com>
> Acked-by: Roman Gushchin <guro@fb.com>
> ---
>
> Changes in v2:
>  - Added comments.
>  - Added "Acked-by: Roman Gushchin <guro@fb.com>".
> ---
>  mm/memcontrol.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index cfa6cbad21d5..4f293bf8c7ed 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2745,6 +2745,15 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
>         if (fatal_signal_pending(current))
>                 goto force;
>
> +       /*
> +        * We failed to charge even after retries, give oom_reaper or
> +        * other process a change to make some free pages.
> +        *
> +        * On non-preemptive, Non-SMP system, this is critical, else
> +        * we keep retrying with no success, forever.
> +        */
> +       cond_resched();
> +
>         /*
>          * keep retrying as long as the memcg oom killer is able to make
>          * a forward progress or bypass the charge if the oom killer
> --
> 2.17.1
>
>
