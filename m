Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14A07341EC4
	for <lists+cgroups@lfdr.de>; Fri, 19 Mar 2021 14:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhCSNuh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 19 Mar 2021 09:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbhCSNuJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 19 Mar 2021 09:50:09 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07987C06174A
        for <cgroups@vger.kernel.org>; Fri, 19 Mar 2021 06:50:09 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id x28so10102876lfu.6
        for <cgroups@vger.kernel.org>; Fri, 19 Mar 2021 06:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UsGaLcv8p/W1uMdTq13khVuGSy6Z0QJqkLpFYQ1bIJk=;
        b=i77Av+sBL8n+9UII8kK0PPrV0npH/0edODNbc1YUASq98qZ1gcvqBFDVwq1QLt1zyX
         7s4RpGH1yxfP87oZyrB+44qDBZUm8EUWzYn2cMXYhz8eq1T6/ozPZSt3dMDmsjB1YKZg
         6P2buZ8iGuy07bMMD+S2xdHzzYCWej0gyZK8KtUyVjNtJAzk6v/Lzp0MRhuESwTipzmm
         pZdGUo7CLI9ROlYI7rxw21LEGWx4f9FN7yZda+kKZtQ6rpPxkuV+78/gHaHWZ6a0R8i7
         nGs9ZB98n7tT8UtgieFAhSqszHDkwHh7qHtzNJ0T4Nia0yB3JEVoR2Mv6s81hF0QcQ8l
         lFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UsGaLcv8p/W1uMdTq13khVuGSy6Z0QJqkLpFYQ1bIJk=;
        b=UxF4LUEihid41MghGn7qTCKiFB6w9qrBZMixK5k3PKjwb+G41VeDRMGgtyxAWp5M3o
         49nRBea8CtIOHBWbr3N1SAGGF2201cRjgZ4yRRA3CAzWQdYjz5FV9eOe+JIwRNIENkNa
         lsU7q0EFT2UtJd7Go54SO193QrXKMh8tPhTAY58xjRf8vdVWHKJUKBA+D8L3adsqgaRJ
         SQvyqhiPYocUjnz5TjzR8EYTF+G+a5hYE6kn6h+ixVTALvk2SoMsNp1jpHFM1yUhp67c
         rGqSsOApHEq//8AjjifTwVyHgUv6xQp6cSLQhy/eSaUiwvxPDoXonp9oAnos9AxEVwF2
         13hQ==
X-Gm-Message-State: AOAM532wpHhx8L7aj9fuOZysxslntlKStAfyWBdUR+0aaOc0VoBOoTyx
        aQHdCRANh+tYvc6HVXALSFtMc9BgmBx2W4moh6IkEg==
X-Google-Smtp-Source: ABdhPJxjwHKa49QiYCC84s2uwLM8UKaH50qIbT/IGPLOnGzyv5F1r59+1hsVAoH7p5Tce+4oowp6iqf/ofxqUxf9M1Y=
X-Received: by 2002:a05:6512:2356:: with SMTP id p22mr853666lfu.347.1616161807266;
 Fri, 19 Mar 2021 06:50:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210319054944.50048-1-hannes@cmpxchg.org> <20210319054944.50048-2-hannes@cmpxchg.org>
In-Reply-To: <20210319054944.50048-2-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 19 Mar 2021 06:49:55 -0700
Message-ID: <CALvZod6HYfoSnBoq7JGW1ifLmLMmwSAyCqjh+bJ6L9evAPVGLQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: memcontrol: deprecate swapaccounting=0 mode
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Mar 18, 2021 at 10:49 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> The swapaccounting= commandline option already does very little
> today. To close a trivial containment failure case, the swap ownership
> tracking part of the swap controller has recently become mandatory
> (see commit 2d1c498072de ("mm: memcontrol: make swap tracking an
> integral part of memory control") for details), which makes up the
> majority of the work during swapout, swapin, and the swap slot map.
>
> The only thing left under this flag is the page_counter operations and
> the visibility of the swap control files in the first place, which are
> rather meager savings. There also aren't many scenarios, if any, where
> controlling the memory of a cgroup while allowing it unlimited access
> to a global swap space is a workable resource isolation stragegy.

*strategy

>
> On the other hand, there have been several bugs and confusion around
> the many possible swap controller states (cgroup1 vs cgroup2 behavior,
> memory accounting without swap accounting, memcg runtime disabled).
>
> This puts the maintenance overhead of retaining the toggle above its
> practical benefits. Deprecate it.
>
> Suggested-by: Shakeel Butt <shakeelb@google.com>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
[...]
>
>  static int __init setup_swap_account(char *s)
>  {
> -       if (!strcmp(s, "1"))
> -               cgroup_memory_noswap = false;
> -       else if (!strcmp(s, "0"))
> -               cgroup_memory_noswap = true;
> -       return 1;
> +       pr_warn_once("The swapaccount= commandline option is deprecated. "
> +                    "Please report your usecase to linux-mm@kvack.org if you "
> +                    "depend on this functionality.\n");
> +       return 0;

What's the difference between returning 0 or 1 here?

>  }
>  __setup("swapaccount=", setup_swap_account);
>
> @@ -7291,27 +7287,13 @@ static struct cftype memsw_files[] = {
>         { },    /* terminate */
>  };
>
> -/*
> - * If mem_cgroup_swap_init() is implemented as a subsys_initcall()
> - * instead of a core_initcall(), this could mean cgroup_memory_noswap still
> - * remains set to false even when memcg is disabled via "cgroup_disable=memory"
> - * boot parameter. This may result in premature OOPS inside
> - * mem_cgroup_get_nr_swap_pages() function in corner cases.
> - */
>  static int __init mem_cgroup_swap_init(void)
>  {
> -       /* No memory control -> no swap control */
> -       if (mem_cgroup_disabled())
> -               cgroup_memory_noswap = true;
> -
> -       if (cgroup_memory_noswap)
> -               return 0;
> -

Do we need a mem_cgroup_disabled() check here?

>         WARN_ON(cgroup_add_dfl_cftypes(&memory_cgrp_subsys, swap_files));
>         WARN_ON(cgroup_add_legacy_cftypes(&memory_cgrp_subsys, memsw_files));
>
>         return 0;
>  }
> -core_initcall(mem_cgroup_swap_init);
> +subsys_initcall(mem_cgroup_swap_init);
>
>  #endif /* CONFIG_MEMCG_SWAP */
> --
> 2.30.1
>
