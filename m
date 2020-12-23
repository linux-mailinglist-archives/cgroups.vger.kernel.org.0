Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8946E2E21FE
	for <lists+cgroups@lfdr.de>; Wed, 23 Dec 2020 22:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbgLWVWc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Dec 2020 16:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729088AbgLWVWc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 23 Dec 2020 16:22:32 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73EB3C06179C
        for <cgroups@vger.kernel.org>; Wed, 23 Dec 2020 13:21:51 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id l11so605855lfg.0
        for <cgroups@vger.kernel.org>; Wed, 23 Dec 2020 13:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wF35nXj0WqYzyWdTSecMciE07b/6u11vJiyvqK4gz6s=;
        b=hRMjxvObgBylB6uesmR8k4mhN2Pag25RaGN4pEInOqMyvL7N0xNsE42tWYXG4UfS/K
         +XsNltY2tXUStsjEFN1DCG4drR9Yei1e1pwXBxYqxPOOmhk+RzpuwJEBcJEJBYbBaIWu
         THr2sXxeIA+/WiiHyFx6LUFoHZYjin8MgtY/Fqd5CQJswDcVyzUMDtXTGiPAs8ZJBB4L
         1CoQWXGNI/OdkwADgVzfhifxid1LxM5XDGRYxrB3/R4eaYk1AtIE4JAQz8bGZBRTVKOW
         aQIZawR3t/pSfsVITaeUVJCoYWC5LAIFLAm210rOtmgvOq0Z8rwRmedSpAVH38lM7HqO
         bQog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wF35nXj0WqYzyWdTSecMciE07b/6u11vJiyvqK4gz6s=;
        b=HnXzjupcUkrkzXo93wcRqxDHHxdldue/QgqO0ZRRYDG8QW55ZIi2ry7N317zLxpyp1
         odC4byDXezSIQHDiCZ+vqw7+AqoqvHcrPD2iywVVIMFSKpLzT8pob8guVSQn/C5lcYLc
         eo0+bZcr+h7+JGH7o7kgMdMnEQs4szflD+Czl+c9HGbSspM7ANQjcBvakJ2jc0+kuS+O
         7SGI7X1nhgNhfRcz1JPedeqvNCb+JXvtaawO8oUYj52JuGKJwhPwleSyyHqXjyN6Z2PK
         oTMAiWLpT3C3oH5mu9TvBIhofKaOskjBH/Ht61+kvS9PvqaStH9ogiXI4k4T4x/TadIC
         mVHg==
X-Gm-Message-State: AOAM533g0FCIyiMUKmwr8qysZoz5asELg0wdlpf+bPC0drVWPxI4n++M
        vHFLkkLUDXpDae2qLwxXp2dHAgrD+L/aDXXxSwlcGw==
X-Google-Smtp-Source: ABdhPJzHt5QoMR2hM01ksgvBri5qImtglXl7UpYz9rRyEvNbcOkgf4IEhhYCab297w4wPrrjMQKaK7bSjP/7n6Ddrt4=
X-Received: by 2002:a05:6512:32ad:: with SMTP id q13mr3919043lfe.83.1608758509561;
 Wed, 23 Dec 2020 13:21:49 -0800 (PST)
MIME-Version: 1.0
References: <20201217034356.4708-1-songmuchun@bytedance.com> <20201217034356.4708-8-songmuchun@bytedance.com>
In-Reply-To: <20201217034356.4708-8-songmuchun@bytedance.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 23 Dec 2020 13:21:38 -0800
Message-ID: <CALvZod4wT1oHir1yo1TYxU+1oa+RaZvCkuRJcLN5f80zGKoFhw@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] mm: memcontrol: make the slab calculation consistent
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Feng Tang <feng.tang@intel.com>, Neil Brown <neilb@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Dec 16, 2020 at 7:46 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> Although the ratio of the slab is one, we also should read the ratio
> from the related memory_stats instead of hard-coding. And the local
> variable of size is already the value of slab_unreclaimable. So we
> do not need to read again.
>
> To do this we need some code like below:
>
> if (unlikely(memory_stats[i].idx == NR_SLAB_UNRECLAIMABLE_B)) {
> -       size = memcg_page_state(memcg, NR_SLAB_RECLAIMABLE_B) +
> -              memcg_page_state(memcg, NR_SLAB_UNRECLAIMABLE_B);
> +       size += memcg_page_state(memcg, memory_stats[i - 1].idx) *
> +               memory_stats[i - 1].ratio;
>
> It requires a series of BUG_ONs or comments to ensure these two
> items are actually adjacent and in the right order. So it would
> probably be easier to implement this using a wrapper that has a
> big switch() for unit conversion.
>
> This would fix the ratio inconsistency and get rid of the order
> guarantee.
>

The commit message is really confusing. It is explaining a situation
which it did not do. I don't see any benefit of mentioning BUG_ONs or
[i-1]s in the message. The patch makes sure that we use the right
ratio for slab. Can you rewrite the commit message and motivate in
just that regard?

> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/memcontrol.c | 105 +++++++++++++++++++++++++++++++++++---------------------
>  1 file changed, 66 insertions(+), 39 deletions(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index a40797a27f87..eec44918d373 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1511,49 +1511,71 @@ static bool mem_cgroup_wait_acct_move(struct mem_cgroup *memcg)
>
>  struct memory_stat {
>         const char *name;
> -       unsigned int ratio;
>         unsigned int idx;
>  };
>
>  static const struct memory_stat memory_stats[] = {
> -       { "anon", PAGE_SIZE, NR_ANON_MAPPED },
> -       { "file", PAGE_SIZE, NR_FILE_PAGES },
> -       { "kernel_stack", 1024, NR_KERNEL_STACK_KB },
> -       { "pagetables", PAGE_SIZE, NR_PAGETABLE },
> -       { "percpu", 1, MEMCG_PERCPU_B },
> -       { "sock", PAGE_SIZE, MEMCG_SOCK },
> -       { "shmem", PAGE_SIZE, NR_SHMEM },
> -       { "file_mapped", PAGE_SIZE, NR_FILE_MAPPED },
> -       { "file_dirty", PAGE_SIZE, NR_FILE_DIRTY },
> -       { "file_writeback", PAGE_SIZE, NR_WRITEBACK },
> +       { "anon",                       NR_ANON_MAPPED                  },
> +       { "file",                       NR_FILE_PAGES                   },
> +       { "kernel_stack",               NR_KERNEL_STACK_KB              },
> +       { "pagetables",                 NR_PAGETABLE                    },
> +       { "percpu",                     MEMCG_PERCPU_B                  },
> +       { "sock",                       MEMCG_SOCK                      },
> +       { "shmem",                      NR_SHMEM                        },
> +       { "file_mapped",                NR_FILE_MAPPED                  },
> +       { "file_dirty",                 NR_FILE_DIRTY                   },
> +       { "file_writeback",             NR_WRITEBACK                    },
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -       { "anon_thp", PAGE_SIZE, NR_ANON_THPS },
> -       { "file_thp", PAGE_SIZE, NR_FILE_THPS },
> -       { "shmem_thp", PAGE_SIZE, NR_SHMEM_THPS },
> +       { "anon_thp",                   NR_ANON_THPS                    },
> +       { "file_thp",                   NR_FILE_THPS                    },
> +       { "shmem_thp",                  NR_SHMEM_THPS                   },
>  #endif
> -       { "inactive_anon", PAGE_SIZE, NR_INACTIVE_ANON },
> -       { "active_anon", PAGE_SIZE, NR_ACTIVE_ANON },
> -       { "inactive_file", PAGE_SIZE, NR_INACTIVE_FILE },
> -       { "active_file", PAGE_SIZE, NR_ACTIVE_FILE },
> -       { "unevictable", PAGE_SIZE, NR_UNEVICTABLE },
> -
> -       /*
> -        * Note: The slab_reclaimable and slab_unreclaimable must be
> -        * together and slab_reclaimable must be in front.
> -        */
> -       { "slab_reclaimable", 1, NR_SLAB_RECLAIMABLE_B },
> -       { "slab_unreclaimable", 1, NR_SLAB_UNRECLAIMABLE_B },
> +       { "inactive_anon",              NR_INACTIVE_ANON                },
> +       { "active_anon",                NR_ACTIVE_ANON                  },
> +       { "inactive_file",              NR_INACTIVE_FILE                },
> +       { "active_file",                NR_ACTIVE_FILE                  },
> +       { "unevictable",                NR_UNEVICTABLE                  },
> +       { "slab_reclaimable",           NR_SLAB_RECLAIMABLE_B           },
> +       { "slab_unreclaimable",         NR_SLAB_UNRECLAIMABLE_B         },
>
>         /* The memory events */
> -       { "workingset_refault_anon", 1, WORKINGSET_REFAULT_ANON },
> -       { "workingset_refault_file", 1, WORKINGSET_REFAULT_FILE },
> -       { "workingset_activate_anon", 1, WORKINGSET_ACTIVATE_ANON },
> -       { "workingset_activate_file", 1, WORKINGSET_ACTIVATE_FILE },
> -       { "workingset_restore_anon", 1, WORKINGSET_RESTORE_ANON },
> -       { "workingset_restore_file", 1, WORKINGSET_RESTORE_FILE },
> -       { "workingset_nodereclaim", 1, WORKINGSET_NODERECLAIM },
> +       { "workingset_refault_anon",    WORKINGSET_REFAULT_ANON         },
> +       { "workingset_refault_file",    WORKINGSET_REFAULT_FILE         },
> +       { "workingset_activate_anon",   WORKINGSET_ACTIVATE_ANON        },
> +       { "workingset_activate_file",   WORKINGSET_ACTIVATE_FILE        },
> +       { "workingset_restore_anon",    WORKINGSET_RESTORE_ANON         },
> +       { "workingset_restore_file",    WORKINGSET_RESTORE_FILE         },
> +       { "workingset_nodereclaim",     WORKINGSET_NODERECLAIM          },
>  };
>
> +/* Translate stat items to the correct unit for memory.stat output */
> +static int memcg_page_state_unit(int item)
> +{
> +       switch (item) {
> +       case MEMCG_PERCPU_B:
> +       case NR_SLAB_RECLAIMABLE_B:
> +       case NR_SLAB_UNRECLAIMABLE_B:
> +       case WORKINGSET_REFAULT_ANON:
> +       case WORKINGSET_REFAULT_FILE:
> +       case WORKINGSET_ACTIVATE_ANON:
> +       case WORKINGSET_ACTIVATE_FILE:
> +       case WORKINGSET_RESTORE_ANON:
> +       case WORKINGSET_RESTORE_FILE:
> +       case WORKINGSET_NODERECLAIM:
> +               return 1;
> +       case NR_KERNEL_STACK_KB:
> +               return SZ_1K;
> +       default:
> +               return PAGE_SIZE;
> +       }
> +}
> +
> +static inline unsigned long memcg_page_state_output(struct mem_cgroup *memcg,
> +                                                   int item)
> +{
> +       return memcg_page_state(memcg, item) * memcg_page_state_unit(item);
> +}
> +
>  static char *memory_stat_format(struct mem_cgroup *memcg)
>  {
>         struct seq_buf s;
> @@ -1577,13 +1599,12 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
>         for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
>                 u64 size;
>
> -               size = memcg_page_state(memcg, memory_stats[i].idx);
> -               size *= memory_stats[i].ratio;
> +               size = memcg_page_state_output(memcg, memory_stats[i].idx);
>                 seq_buf_printf(&s, "%s %llu\n", memory_stats[i].name, size);
>
>                 if (unlikely(memory_stats[i].idx == NR_SLAB_UNRECLAIMABLE_B)) {
> -                       size = memcg_page_state(memcg, NR_SLAB_RECLAIMABLE_B) +
> -                              memcg_page_state(memcg, NR_SLAB_UNRECLAIMABLE_B);
> +                       size += memcg_page_state_output(memcg,
> +                                                       NR_SLAB_RECLAIMABLE_B);
>                         seq_buf_printf(&s, "slab %llu\n", size);
>                 }
>         }
> @@ -6377,6 +6398,12 @@ static int memory_stat_show(struct seq_file *m, void *v)
>  }
>
>  #ifdef CONFIG_NUMA
> +static inline unsigned long lruvec_page_state_output(struct lruvec *lruvec,
> +                                                    int item)
> +{
> +       return lruvec_page_state(lruvec, item) * memcg_page_state_unit(item);
> +}
> +

No need to have lruvec_page_state_output() separately as there is just
one user. Just inline it.

>  static int memory_numa_stat_show(struct seq_file *m, void *v)
>  {
>         int i;
> @@ -6394,8 +6421,8 @@ static int memory_numa_stat_show(struct seq_file *m, void *v)
>                         struct lruvec *lruvec;
>
>                         lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(nid));
> -                       size = lruvec_page_state(lruvec, memory_stats[i].idx);
> -                       size *= memory_stats[i].ratio;
> +                       size = lruvec_page_state_output(lruvec,
> +                                                       memory_stats[i].idx);
>                         seq_printf(m, " N%d=%llu", nid, size);
>                 }
>                 seq_putc(m, '\n');
> --
> 2.11.0
>
