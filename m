Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 313D333D828
	for <lists+cgroups@lfdr.de>; Tue, 16 Mar 2021 16:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbhCPPuj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 16 Mar 2021 11:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237540AbhCPPub (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 16 Mar 2021 11:50:31 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2747CC061756
        for <cgroups@vger.kernel.org>; Tue, 16 Mar 2021 08:50:30 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id k9so63188228lfo.12
        for <cgroups@vger.kernel.org>; Tue, 16 Mar 2021 08:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WwakdtxuHaTN5z0HCiQ4MNVrrN9llL1dGHrwS+1rEFI=;
        b=Y8vlN3SI/ykxQTjQbv4kH+9CK9WxCxroUfhO5YAG/Q06fEfhC7gmihPG0b2gkbg7p2
         BJcipNhPpwfAYZQawmSVw4SuDq9HgHqrnJ72QN6YzAPc/iS45ymhVnlsheWAmhIcRFFC
         5n043KRfcygMCCaESFPz/xle+ga7BJvXFjAgDJ2KE3+DwTFKrqQGRARQHbIWQizdgYAx
         yjC00EWkXA7CGN93CjqVoC9HMMj3XE/OgUEkwHEjGGzbImbrc7x5KngmL6YhRLcDwLnF
         rOlY48nIfjjcwEFdjlIDwqnZrPTEBtobD5wnEMK+86kKf6TRdXu36PZTzykBdCGIV382
         K6bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WwakdtxuHaTN5z0HCiQ4MNVrrN9llL1dGHrwS+1rEFI=;
        b=FgJ39Dh3Ca+mrLSXSUHx+3vlE/mUndfZ1T6nNFH8gG4cseEfvWtrEp3xezn6d7Xc95
         hVVOAgUMl/OSRtCztCgZUAWtCha0rzTtmjIVsXP/BKTb4HvIb1VEBHONjExDFHfLIcmo
         yn+objui4Lo5iV03iqj7IS/HxZ+6vdjP4b97iLFth1h1Jn00CRy00lLVaTGO4L2mIKk+
         FeL6kjowBz8mYEV4PCdXdv8GyZl4hLZnNqIE5PUugAQYqEuLJO89rke/z6uH3YgM4wEs
         Vx1rctFSgavavk6BHXFeV4q96MKGyfixxhysMhgJ5/k4dDuTzTl3PT9+yvVr2ir/9HXa
         uk7Q==
X-Gm-Message-State: AOAM533E/Z4O8qaPI+qfFW9ceO+VVOMkdNqR+J+qhqrq/1US4WEqGOVE
        MvRRgLTosLuZh2PZ91NXl+mx/VFjiwfvj0ccNDRewQ==
X-Google-Smtp-Source: ABdhPJyZ/vV2IRRHujPOKeVa0QetQ4VOSuoAxfKAEM82kauFP2bOtUCTQcIxCf4r+D48huq9DC6J/O4En2deKcexRrA=
X-Received: by 2002:a05:6512:39c9:: with SMTP id k9mr11272677lfu.432.1615909828360;
 Tue, 16 Mar 2021 08:50:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210316153655.500806-1-schatzberg.dan@gmail.com> <20210316153655.500806-3-schatzberg.dan@gmail.com>
In-Reply-To: <20210316153655.500806-3-schatzberg.dan@gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 16 Mar 2021 08:50:16 -0700
Message-ID: <CALvZod7sk52OYwxP=VRhS0q4xZ57UuSdL6Mi4Y956xDq3pTatQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm: Charge active memcg when no mm is set
To:     Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Mar 16, 2021 at 8:37 AM Dan Schatzberg <schatzberg.dan@gmail.com> wrote:
>
> memalloc_use_memcg() worked for kernel allocations but was silently
> ignored for user pages.

set_active_memcg()

>
> This patch establishes a precedence order for who gets charged:
>
> 1. If there is a memcg associated with the page already, that memcg is
>    charged. This happens during swapin.
>
> 2. If an explicit mm is passed, mm->memcg is charged. This happens
>    during page faults, which can be triggered in remote VMs (eg gup).
>
> 3. Otherwise consult the current process context. If it has configured
>    a current->active_memcg, use that. Otherwise, current->mm->memcg.

It's a bit more sophisticated than current->active_memcg. It has been
extended to work in interrupt context as well.

>
> Previously, if a NULL mm was passed to mem_cgroup_try_charge (case 3) it

mem_cgroup_charge()

> would always charge the root cgroup. Now it looks up the current
> active_memcg first (falling back to charging the root cgroup if not
> set).
>
> Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Tejun Heo <tj@kernel.org>
> Acked-by: Chris Down <chris@chrisdown.name>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>
> ---
>  mm/filemap.c    |  2 +-
>  mm/memcontrol.c | 14 +++++++++++---
>  mm/shmem.c      |  4 ++--
>  3 files changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 43700480d897..5135f330f05c 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -843,7 +843,7 @@ noinline int __add_to_page_cache_locked(struct page *page,
>         page->index = offset;
>
>         if (!huge) {
> -               error = mem_cgroup_charge(page, current->mm, gfp);
> +               error = mem_cgroup_charge(page, NULL, gfp);
>                 if (error)
>                         goto error;
>                 charged = true;
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index e064ac0d850a..9a1b23ed3412 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6690,7 +6690,8 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
>   * @gfp_mask: reclaim mode
>   *
>   * Try to charge @page to the memcg that @mm belongs to, reclaiming
> - * pages according to @gfp_mask if necessary.
> + * pages according to @gfp_mask if necessary. if @mm is NULL, try to
> + * charge to the active memcg.
>   *
>   * Returns 0 on success. Otherwise, an error code is returned.
>   */
> @@ -6726,8 +6727,15 @@ int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask)
>                 rcu_read_unlock();
>         }
>
> -       if (!memcg)
> -               memcg = get_mem_cgroup_from_mm(mm);
> +       if (!memcg) {
> +               if (!mm) {
> +                       memcg = get_mem_cgroup_from_current();
> +                       if (!memcg)
> +                               memcg = get_mem_cgroup_from_mm(current->mm);
> +               } else {
> +                       memcg = get_mem_cgroup_from_mm(mm);
> +               }
> +       }

You will need to rebase to the latest mm tree. This code has changed.
