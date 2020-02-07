Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE24D155DD6
	for <lists+cgroups@lfdr.de>; Fri,  7 Feb 2020 19:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgBGSTq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 7 Feb 2020 13:19:46 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35661 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbgBGSTq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 7 Feb 2020 13:19:46 -0500
Received: by mail-oi1-f195.google.com with SMTP id b18so2902825oie.2
        for <cgroups@vger.kernel.org>; Fri, 07 Feb 2020 10:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=34picYXQl6IHu7WNFgMATwP1bU4pMx8hmiYQHYPAmOA=;
        b=NJqfVuSI3AsPMqIJRk81NBFWdamWWy58D28SzZCXHp5xAAChA887h8qGwHJBp4zGD0
         +IeHxJxajQjP0zuczefjuKkCpG5ePWspF/wLmt2DPd9rJJCBWYMLzeIogeYkbX8jP2io
         75aMTJFVtsJ0N0f8o2bUuLBzUenbZtXYno1zt7wlhLhDkJ0di7bmNmD5Lw6OHSYCqZ7c
         T1PGgnGBUgpophEpbFPC2VjY3nqMc1tc/DIQai/awMMuQI5EG/OYVDyvnSS87pBdgPz1
         KrYUiSdfH8NxA9HPoHlteOceMx9BFlK1ghWsRGkSWlB7YSOd9pDzTWb6LPvePCuGzQkh
         5Gng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=34picYXQl6IHu7WNFgMATwP1bU4pMx8hmiYQHYPAmOA=;
        b=tY5Kkpf9QhZh6i4AfObWzoVPll3eVIEMXGUWgtpXbJKQH5UrqzGFlpwiqxOfMrysbv
         5oRngrDCY3AJ80GweZcMDnHQ9WwzZZgv+kQzsicJ8iyV82vzWY+u3bLjbtZ5EFyAJN2N
         Y7xPuqVaAjzT9z5P7cHaSgfgQ6vNSgWtP+jYK7gmDtBZp/CE41e7FUJyBszzComZJnbd
         /9o05TmbuucOBWvkOoM5qCTEVqYtJuZK+6Iut9MwxmaiR2lLYYdtBFFeO02NZfoQUAR0
         7phJE+1slGcRPnr60VQf2tqGswLAwjVzeFR1qTCzVYg4ANaA0nPiMl3F1LPygKZlpg+l
         R53g==
X-Gm-Message-State: APjAAAX8lVhRYcR6vPU3V/5JkArK+Zrh1sgT+4hS9uYfpx8sy4H0nboa
        k6+2jwwh/5cZIRoFWtf69w5BicE8LaqKWu6p6jtbRBnj
X-Google-Smtp-Source: APXvYqwnR2XcCkLPLbX18YYwXzVJmr85u8NXmKcvWKgqYEBLX60yJsFs8A6UBnpugWe+5eS62zQM5nbDVJbAFStHtck=
X-Received: by 2002:aca:b183:: with SMTP id a125mr2943811oif.83.1581099585122;
 Fri, 07 Feb 2020 10:19:45 -0800 (PST)
MIME-Version: 1.0
References: <1581096119-13593-1-git-send-email-cai@lca.pw>
In-Reply-To: <1581096119-13593-1-git-send-email-cai@lca.pw>
From:   Marco Elver <elver@google.com>
Date:   Fri, 7 Feb 2020 19:19:33 +0100
Message-ID: <CANpmjNMk5zw+nbLa4Ko7zUdWOY8pFR6EuQ6WbRECmX=8o8PLUw@mail.gmail.com>
Subject: Re: [PATCH v2] mm/memcontrol: fix a data race in scan count
To:     Qian Cai <cai@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, vdavydov.dev@gmail.com,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, 7 Feb 2020 at 18:22, Qian Cai <cai@lca.pw> wrote:
>
> struct mem_cgroup_per_node mz.lru_zone_size[zone_idx][lru] could be
> accessed concurrently as noticed by KCSAN,
>
>  BUG: KCSAN: data-race in lruvec_lru_size / mem_cgroup_update_lru_size
>
>  write to 0xffff9c804ca285f8 of 8 bytes by task 50951 on cpu 12:
>   mem_cgroup_update_lru_size+0x11c/0x1d0
>   mem_cgroup_update_lru_size at mm/memcontrol.c:1266
>   isolate_lru_pages+0x6a9/0xf30
>   shrink_active_list+0x123/0xcc0
>   shrink_lruvec+0x8fd/0x1380
>   shrink_node+0x317/0xd80
>   do_try_to_free_pages+0x1f7/0xa10
>   try_to_free_pages+0x26c/0x5e0
>   __alloc_pages_slowpath+0x458/0x1290
>   __alloc_pages_nodemask+0x3bb/0x450
>   alloc_pages_vma+0x8a/0x2c0
>   do_anonymous_page+0x170/0x700
>   __handle_mm_fault+0xc9f/0xd00
>   handle_mm_fault+0xfc/0x2f0
>   do_page_fault+0x263/0x6f9
>   page_fault+0x34/0x40
>
>  read to 0xffff9c804ca285f8 of 8 bytes by task 50964 on cpu 95:
>   lruvec_lru_size+0xbb/0x270
>   mem_cgroup_get_zone_lru_size at include/linux/memcontrol.h:536
>   (inlined by) lruvec_lru_size at mm/vmscan.c:326
>   shrink_lruvec+0x1d0/0x1380
>   shrink_node+0x317/0xd80
>   do_try_to_free_pages+0x1f7/0xa10
>   try_to_free_pages+0x26c/0x5e0
>   __alloc_pages_slowpath+0x458/0x1290
>   __alloc_pages_nodemask+0x3bb/0x450
>   alloc_pages_current+0xa6/0x120
>   alloc_slab_page+0x3b1/0x540
>   allocate_slab+0x70/0x660
>   new_slab+0x46/0x70
>   ___slab_alloc+0x4ad/0x7d0
>   __slab_alloc+0x43/0x70
>   kmem_cache_alloc+0x2c3/0x420
>   getname_flags+0x4c/0x230
>   getname+0x22/0x30
>   do_sys_openat2+0x205/0x3b0
>   do_sys_open+0x9a/0xf0
>   __x64_sys_openat+0x62/0x80
>   do_syscall_64+0x91/0xb47
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
>  Reported by Kernel Concurrency Sanitizer on:
>  CPU: 95 PID: 50964 Comm: cc1 Tainted: G        W  O L    5.5.0-next-20200204+ #6
>  Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 07/10/2019
>
> The write is under lru_lock, but the read is done as lockless. The scan
> count is used to determine how aggressively the anon and file LRU lists
> should be scanned. Load tearing could generate an inefficient heuristic,
> so fix it by adding READ_ONCE() for the read and WRITE_ONCE() for the
> writes.
>
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>
> v2: also have WRITE_ONCE() in the writer which is necessary.

Again, note that KCSAN will *not* complain if you omitted the
WRITE_ONCE and only had the READ_ONCE, as long as the write aligned
and up to word-size. Because we still don't have a nice way to deal
with read-modify-writes, like 'var +=', '++', I don't know if we want
to do the WRITE_ONCE right now.

I think the kernel might need a primitive that avoids the readability
issues of writing 'WRITE_ONCE(var, var + val)'. I don't have strong
opinions on this, so it's up to maintainers.

Thanks,
-- Marco

>  include/linux/memcontrol.h | 2 +-
>  mm/memcontrol.c            | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index a7a0a1a5c8d5..e8734dabbc61 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -533,7 +533,7 @@ unsigned long mem_cgroup_get_zone_lru_size(struct lruvec *lruvec,
>         struct mem_cgroup_per_node *mz;
>
>         mz = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
> -       return mz->lru_zone_size[zone_idx][lru];
> +       return READ_ONCE(mz->lru_zone_size[zone_idx][lru]);
>  }
>
>  void mem_cgroup_handle_over_high(void);
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 6f6dc8712e39..daf375cc312c 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1263,7 +1263,7 @@ void mem_cgroup_update_lru_size(struct lruvec *lruvec, enum lru_list lru,
>         lru_size = &mz->lru_zone_size[zid][lru];
>
>         if (nr_pages < 0)
> -               *lru_size += nr_pages;
> +               WRITE_ONCE(*lru_size, *lru_size + nr_pages);
>
>         size = *lru_size;
>         if (WARN_ONCE(size < 0,
> @@ -1274,7 +1274,7 @@ void mem_cgroup_update_lru_size(struct lruvec *lruvec, enum lru_list lru,
>         }
>
>         if (nr_pages > 0)
> -               *lru_size += nr_pages;
> +               WRITE_ONCE(*lru_size, *lru_size + nr_pages);
>  }
>
>  /**
> --
> 1.8.3.1
>
