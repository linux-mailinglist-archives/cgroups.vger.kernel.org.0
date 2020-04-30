Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13B1B1BED63
	for <lists+cgroups@lfdr.de>; Thu, 30 Apr 2020 03:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgD3BFa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 29 Apr 2020 21:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726279AbgD3BF3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 29 Apr 2020 21:05:29 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9703EC035494;
        Wed, 29 Apr 2020 18:05:29 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id w6so4405132ilg.1;
        Wed, 29 Apr 2020 18:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CUmejEMI9W4148ZwbJQR4oRKJlfTuk5tiVFPgpBtfEE=;
        b=u4//czMye7iX+yYcmMhK7eYzznKYgw27pn66Zlm/n4vCL+HBVx6UoX792Q3CHu0/co
         /FWAkSuboMQrgFRjTVVQOlwchBkpd5hSwn+PmXDgWq3qCGCYF4umAVs5s/EFrGEX2u2G
         m0S5LTfiJUlEky6L995fUQPY2LE2Jpxo15lNlxeFW7yk7+N5zZPXObxIoZeMHVTSX4db
         8pWWyoCWwP7wBB+VFp6F/kTl4YwU0X7ynN3cZcUlerH2MhnkX63lZYN+rEYW0PxwxuZ/
         FJB5Zeh6+syBfi8Zyxr2EsvHcx11JakjhVraYhuCj7bNWp52dhDpg22hD1IO04SEdi8C
         JwTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CUmejEMI9W4148ZwbJQR4oRKJlfTuk5tiVFPgpBtfEE=;
        b=ct+BZFGmo1/4tr2SBzxQbCSmfjghQTpV2RpU/aiOjSDQYgmCiZ5dO8PS15ey0I1rdA
         /vWlOkhKca6jOGVd9IgnItmsw5Sm3H9lkkFzCphaQO/2Oas+D50ZyrwDq97DmuFoNTjC
         GlCrTy0+UzKy0IePoVreabPdYFJ29dVV91DDJQzLsm/M1uim3tmxOlMKy0unjeobPfwB
         O8L9oKMHeRHbvolLypsdcaEsOX2Og/rh0Pa55bAUN/n2FNvBz8Z0tmZcCcYv/OZnJo7a
         oQHCvGrTraVgjykkAT8wYzIcPax20J1I/PuB5TNC6ie1x/vyCRY3ZRbO3IGBjgjdUrVx
         Dg8Q==
X-Gm-Message-State: AGi0PuZOuleFdGkNW3S1D7LJTpGz1nrPlIettmxGIzp8EAHMAzr5Qq4x
        8o6uiiLaRig4bZOnqDQTjWPPmajOySnp5STt9OCgK8JOcn0=
X-Google-Smtp-Source: APiQypLHLFF0yYE4l1uu8thH5v0632Zbu9203Hngur/IfGiLPu/p/UdZpVGulsn3Tzg3pnUc5O73XqTJqFkV2GZNT9Q=
X-Received: by 2002:a92:1b91:: with SMTP id f17mr1150332ill.142.1588208728936;
 Wed, 29 Apr 2020 18:05:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588092152.git.chris@chrisdown.name> <d454fca5d6b38b74d8dc35141e8519b02089a698.1588092152.git.chris@chrisdown.name>
In-Reply-To: <d454fca5d6b38b74d8dc35141e8519b02089a698.1588092152.git.chris@chrisdown.name>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 30 Apr 2020 09:04:53 +0800
Message-ID: <CALOAHbCotD1-+o_XZPU_4_i8Nn98r5F_5NpGVd=z6UG=rUcCmA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm, memcg: Avoid stale protection values when cgroup
 is above protection
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Apr 29, 2020 at 2:26 AM Chris Down <chris@chrisdown.name> wrote:
>
> From: Yafang Shao <laoar.shao@gmail.com>
>
> A cgroup can have both memory protection and a memory limit to isolate
> it from its siblings in both directions - for example, to prevent it
> from being shrunk below 2G under high pressure from outside, but also
> from growing beyond 4G under low pressure.
>
> Commit 9783aa9917f8 ("mm, memcg: proportional memory.{low,min} reclaim")
> implemented proportional scan pressure so that multiple siblings in
> excess of their protection settings don't get reclaimed equally but
> instead in accordance to their unprotected portion.
>
> During limit reclaim, this proportionality shouldn't apply of course:
> there is no competition, all pressure is from within the cgroup and
> should be applied as such. Reclaim should operate at full efficiency.
>
> However, mem_cgroup_protected() never expected anybody to look at the
> effective protection values when it indicated that the cgroup is above
> its protection. As a result, a query during limit reclaim may return
> stale protection values that were calculated by a previous reclaim cycle
> in which the cgroup did have siblings.
>
> When this happens, reclaim is unnecessarily hesitant and potentially
> slow to meet the desired limit. In theory this could lead to premature
> OOM kills, although it's not obvious this has occurred in practice.
>
> Fixes: 9783aa9917f8 ("mm, memcg: proportional memory.{low,min} reclaim")
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Signed-off-by: Chris Down <chris@chrisdown.name>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Roman Gushchin <guro@fb.com>
>
> [hannes@cmpxchg.org: rework code comment]
> [hannes@cmpxchg.org: changelog]
> [chris@chrisdown.name: fix store tear]
> [chris@chrisdown.name: retitle]
> ---
>  mm/memcontrol.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 0be00826b832..b0374be44e9e 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6392,8 +6392,19 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
>
>         if (!root)
>                 root = root_mem_cgroup;
> -       if (memcg == root)
> +       if (memcg == root) {
> +               /*
> +                * The cgroup is the reclaim root in this reclaim
> +                * cycle, and therefore not protected. But it may have
> +                * stale effective protection values from previous
> +                * cycles in which it was not the reclaim root - for
> +                * example, global reclaim followed by limit reclaim.
> +                * Reset these values for mem_cgroup_protection().
> +                */
> +               WRITE_ONCE(memcg->memory.emin, 0);
> +               WRITE_ONCE(memcg->memory.elow, 0);


Hi Chris,

Would you pls. add some comments above these newly added WRITE_ONCE() ?
E.g.
What does them mean to fix ?
Why do we must add WRITE_ONCE() and READ_ONCE here and there all over
the memcg protection ?
Otherwise, it may be harder to understand by the others.


>                 return MEMCG_PROT_NONE;
> +       }
>
>         usage = page_counter_read(&memcg->memory);
>         if (!usage)
> --
> 2.26.2
>


-- 
Thanks
Yafang
