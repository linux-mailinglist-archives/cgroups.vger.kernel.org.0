Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA3FF2F3955
	for <lists+cgroups@lfdr.de>; Tue, 12 Jan 2021 20:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406063AbhALTBA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 12 Jan 2021 14:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728112AbhALTA7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 12 Jan 2021 14:00:59 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AD2C06179F
        for <cgroups@vger.kernel.org>; Tue, 12 Jan 2021 11:00:12 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id f17so4011574ljg.12
        for <cgroups@vger.kernel.org>; Tue, 12 Jan 2021 11:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cY7LiOljtRpl7NP8koJL4MoVHQoaXBOmsr02Iq9gODY=;
        b=oS8itD4fagD9W0NDK8IL/kpF+AARyhuR4yh5nmMvhIUGA47rDp5coomF6EJpC62Dyw
         ToCn3gbqEFz6X1QbaUx5S/wUB4rwXFX3vIQLHosV8OKDpieZPjmIQFrlOot9id0T2ty3
         4eewXDIOfQ4y0CgYEJX/eHqHPQb2R2M1PU4iwsmW28SYKQTGiNSVZ9sMsdT68+7Pypmd
         K0vqQbdjwoua0+2ReyH6Wdu6+4Sl2BzxuQCtyf2H7rjiQy47dBC1majpefS2fz3Uq7mk
         bECOoYxXCtMKsol4oYi1r02vng0JwkyNbQNUqRuDsdNNLj+zirPpWCI/85QKmQyHEumQ
         KaPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cY7LiOljtRpl7NP8koJL4MoVHQoaXBOmsr02Iq9gODY=;
        b=f5AKNTPlFA5N/LviJtLK5UjWtaBucgwcvqTaUw7YsoNKaEygjQpao/DC7q0iFR2fdV
         lB4p2ktvF7UXvgt2NyCqSmYgHwtiGlBWeYh5dPpvyjBaTJ6Hfs8du9a24fgLfWh1zRqg
         l5Qer6m+NhigMm5dyVqMDPvJeoCOFWdCesDa5Y8ptCXIXIOF3HPxZWEi1dfwtiFj74wG
         /ek/kT/P/0sLKJIvNAFWFSWkH0v3lFeo+tNrA2tg18aZK4FrGtuiQ0WeNoF/dVr6etDr
         CUbVEXyRaOhG88vx219pCJD9jmfdB7X2rQkYZS1Ru2/sNvvAjl1o1GjBfgnI0oAOE56+
         N2Hg==
X-Gm-Message-State: AOAM532XdFagBwfSsVQyX7YnAJ30jjUu41LwQtYnxPa/BD+m4gULzp9L
        I0gtsm6tc4zfnVdXoPiOuMv1o+smagIUsS5h5kBP7w==
X-Google-Smtp-Source: ABdhPJyeoR+rXzzgDzQiOMYj/rsdGmCt6Tdsk+6ir6pLcQbcgrKoCWr+GiQTGW/dIXR+H2ZOnjM+Tx/49XaFMo599FA=
X-Received: by 2002:a2e:850f:: with SMTP id j15mr287189lji.34.1610478009184;
 Tue, 12 Jan 2021 11:00:09 -0800 (PST)
MIME-Version: 1.0
References: <20210112163011.127833-1-hannes@cmpxchg.org>
In-Reply-To: <20210112163011.127833-1-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 12 Jan 2021 10:59:58 -0800
Message-ID: <CALvZod4VFA52dsdkW79-gUbiCf2ONfFJj6LkRU+3-fQpvYXL+A@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: prevent starvation when writing memory.high
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@suse.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 12, 2021 at 9:12 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> When a value is written to a cgroup's memory.high control file, the
> write() context first tries to reclaim the cgroup to size before
> putting the limit in place for the workload. Concurrent charges from
> the workload can keep such a write() looping in reclaim indefinitely.
>

Is this observed on real workload?

>
> In the past, a write to memory.high would first put the limit in place
> for the workload, then do targeted reclaim until the new limit has
> been met - similar to how we do it for memory.max. This wasn't prone
> to the described starvation issue. However, this sequence could cause
> excessive latencies in the workload, when allocating threads could be
> put into long penalty sleeps on the sudden memory.high overage created
> by the write(), before that had a chance to work it off.
>
> Now that memory_high_write() performs reclaim before enforcing the new
> limit, reflect that the cgroup may well fail to converge due to
> concurrent workload activity. Bail out of the loop after a few tries.
>
> Fixes: 536d3bf261a2 ("mm: memcontrol: avoid workload stalls when lowering memory.high")
> Cc: <stable@vger.kernel.org> # 5.8+
> Reported-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/memcontrol.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 605f671203ef..63a8d47c1cd3 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6275,7 +6275,6 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
>
>         for (;;) {
>                 unsigned long nr_pages = page_counter_read(&memcg->memory);
> -               unsigned long reclaimed;
>
>                 if (nr_pages <= high)
>                         break;
> @@ -6289,10 +6288,10 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
>                         continue;
>                 }
>
> -               reclaimed = try_to_free_mem_cgroup_pages(memcg, nr_pages - high,
> -                                                        GFP_KERNEL, true);
> +               try_to_free_mem_cgroup_pages(memcg, nr_pages - high,
> +                                            GFP_KERNEL, true);
>
> -               if (!reclaimed && !nr_retries--)

Any particular reason to remove !reclaimed?

> +               if (!nr_retries--)
>                         break;
>         }
>
> --
> 2.30.0
>
