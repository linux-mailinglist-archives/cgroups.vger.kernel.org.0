Return-Path: <cgroups+bounces-11914-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC46C55E25
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 07:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F055C3498BC
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 06:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721293161AA;
	Thu, 13 Nov 2025 06:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bz1mN+Fn"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5568E253B73
	for <cgroups@vger.kernel.org>; Thu, 13 Nov 2025 06:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763014119; cv=none; b=mhAwEV1m5tNGPFX0VYyN4VAjU+PSXgdmwftGCt6aJ1yQ+7qZfa1wxKdQW+cbCwWE3UrcD6cH5FeWpfWPq6NKm59F0xwk9+qPQm7SI0CnZiJ1X13g0xWaBNj2d3KJx1tQla/9wNu8ulXnjI/WeGYMC2rz6ITW9GghvMsFb37ru6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763014119; c=relaxed/simple;
	bh=bt+slNTsSWGpyoitzeytMYWQpkRm3CEE3x7QbiHxpT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pP3wiNoipRza6wRnWntyoclUp0jb4vzVq8DWo77CBcyHJc5p73F7XtJIZs6jj95ggmgmEFZ35epOA2L5lc7IJ9amle7n+9tLq2zYEi9KWwWMzUCicjEXhjkFk6aoydZyUyPg3LJXuCT71+/0kvBgSf+U7bfAkZRTJTqJeOe7U+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bz1mN+Fn; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b729f239b39so77962666b.0
        for <cgroups@vger.kernel.org>; Wed, 12 Nov 2025 22:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763014116; x=1763618916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t22dgTeDrtFxWGb8huXOzqou4mk9fcSHfq/TLjMh8ns=;
        b=bz1mN+FnInElq8l0JmGtvzgFq/8rsvh9g6H81Yzy5cHnFGkpjksgclgtYZRKRuLq3m
         aY2xRn/uPtSGzCBKQNDkiR6NpxqhU1Xi21h4lmPeIMWlkX3ASZTfkZ17S8q4xNdF2hXb
         Uo2IwnFUA5vIqTZoKooysZ+1lKVqKJBkmzzTixrYdVmncFaGPYk8i8qnh4nCU0m1K1ts
         gXCEiSexWMbFXrKdIsrwAh40L6Nnc4tDek8JwB4Zoiv9k7DaFO+aEGge7ep8nskBN37R
         ukqLUImu06CPgattgsdN8+u8IYya9DmlhTIELPZq6zEGUJaW1sdgEKuYCocVap8U7Zel
         ixow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763014116; x=1763618916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t22dgTeDrtFxWGb8huXOzqou4mk9fcSHfq/TLjMh8ns=;
        b=YCSAms5cLPZS2mgF1HiXOzQaOT+/MfYdP7xD93Jx07NZsDMK4RKxwll8CjC/pV6lin
         eNJa3dsiPEeqnFW9SvHdV1dGMUx2gHfjQ1rsY/+eJVd4gkHWy2RuqD/rKl/LF0C+CbRg
         VguKdFV5ckWY+1xD5ubRUgW7G2u981o3rkBaXM5E+J7bogEncjFChSJQ3FhwRpP4DqsI
         4hO4hRiMEyZvH0yYI20fofmwghVferkUkGHwR/dXS4TlKdfb7TQo2DmCRWEgCDIe8TOC
         F453qJSauuFfcTMDnxqVuF+vVhRiol3hHUzqadZRD4kn0hIjFYtoBql+ggfaYyYa1jV6
         QOUA==
X-Forwarded-Encrypted: i=1; AJvYcCX3AXcHQr0m7Lh6hyjGhIrtYmz9cKXnvGg6E38qRvgHYANeqlfLUQ8/sN7I8HYu6rr2+SITMaCC@vger.kernel.org
X-Gm-Message-State: AOJu0YzfbmVFMR7JNWSW0N8Yf8AhQgDM5MKSb7hxzkaEs1AcPo3PrgL7
	TWwc+SOtMbPicqiJ6F/qspjfcZk4CJ427OD2oV23xSrMi+RaSdPSxpB1GjA8GXpezT+OIfGXPFW
	1uAbqiiDJ88Nl4Ncnja7ALfx3kDNwjgg0blw+lX4=
X-Gm-Gg: ASbGncsyGp4MbUy8HFOdCBSWeG8hpbGn5YulBQO5c6A3RSMZzFu64+Wk/6E0sj65AHQ
	hRy4eI3UXHbtMoXIqtiSLMxLg3kjsStQ2RoiPRJiUGdKR7qGrfJRVb/B/FU916Slxsjt08lMwNR
	vb68DviU+91YY/mmTccYHzKV9VSESrpzuizP/u8iW+ndgTEKQoWVf/yhWRUBpG1RJ33uEwwb+Yf
	HW/HC1mzbXKWS+bDNZiuTUAhZRBUOhyt/fykYSb4hthCHa7hN3SHC3EZiBWnIf1b4yukKoNLbUV
	FvwgdjP2AuWiXVid5209
X-Google-Smtp-Source: AGHT+IG7kqoXB2Wkka2Lo2zxPzuYPWP59bLwZ31GR/ODVeDKoIwplQX0m14wtg7CumzW9bsmTAPYXvf/G0tEKzBgNt0=
X-Received: by 2002:a17:907:eccc:b0:b73:2e54:a002 with SMTP id
 a640c23a62f3a-b73485707c9mr186790266b.15.1763014115205; Wed, 12 Nov 2025
 22:08:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109124947.1101520-1-youngjun.park@lge.com> <20251109124947.1101520-2-youngjun.park@lge.com>
In-Reply-To: <20251109124947.1101520-2-youngjun.park@lge.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 13 Nov 2025 14:07:59 +0800
X-Gm-Features: AWmQ_bltIMHm1Q-8yi3-GESMpbrkRwF6RIVrr2aS5VGUNJ1V-cdA8bflp4lx-lk
Message-ID: <CAMgjq7AomHkGAtpvEt_ZrGK6fLUkWgg0vDGZ0B570QU_oNwRGA@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm, swap: change back to use each swap device's
 percpu cluster
To: Youngjun Park <youngjun.park@lge.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, chrisl@kernel.org, hannes@cmpxchg.org, 
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	muchun.song@linux.dev, shikemeng@huaweicloud.com, nphamcs@gmail.com, 
	bhe@redhat.com, baohua@kernel.org, gunho.lee@lge.com, taejoon.song@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 9, 2025 at 8:54=E2=80=AFPM Youngjun Park <youngjun.park@lge.com=
> wrote:
>
> This reverts commit 1b7e90020eb7 ("mm, swap: use percpu cluster as
> allocation fast path").
>
> Because in the newly introduced swap tiers, the global percpu cluster
> will cause two issues:
> 1) it will cause caching oscillation in the same order of different si
>    if two different memcg can only be allowed to access different si and
>    both of them are swapping out.
> 2) It can cause priority inversion on swap devices. Imagine a case where
>    there are two memcg, say memcg1 and memcg2. Memcg1 can access si A, B
>    and A is higher priority device. While memcg2 can only access si B.
>    Then memcg 2 could write the global percpu cluster with si B, then
>    memcg1 take si B in fast path even though si A is not exhausted.
>
> Hence in order to support swap tier, revert commit 1b7e90020eb7 to use
> each swap device's percpu cluster.
>
> Co-developed-by: Baoquan He <bhe@redhat.com>
> Suggested-by: Kairui Song <kasong@tencent.com>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Signed-off-by: Youngjun Park <youngjun.park@lge.com>

Hi Youngjun, Baoquan, Thanks for the work on the percpu cluster thing.

It will be better if you can provide some benchmark result since the
whole point of global percpu cluster is to improve the performance and
get rid of the swap slot cache.

I'm fine with a small regression but we better be aware of it. And we
can still figure out some other ways to optimize it. e.g. I remember
Chris once mentioned an idea of having a per device slot cache, that
is different from the original slot cache (swap_slot.c): the allocator
will be aware of it so it will be much cleaner.

> ---
>  include/linux/swap.h |  13 +++-
>  mm/swapfile.c        | 151 +++++++++++++------------------------------
>  2 files changed, 56 insertions(+), 108 deletions(-)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 38ca3df68716..90fa27bb7796 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -250,10 +250,17 @@ enum {
>  #endif
>
>  /*
> - * We keep using same cluster for rotational device so IO will be sequen=
tial.
> - * The purpose is to optimize SWAP throughput on these device.
> + * We assign a cluster to each CPU, so each CPU can allocate swap entry =
from
> + * its own cluster and swapout sequentially. The purpose is to optimize =
swapout
> + * throughput.
>   */
> +struct percpu_cluster {
> +       local_lock_t lock; /* Protect the percpu_cluster above */

I think you mean "below"?

> +       unsigned int next[SWAP_NR_ORDERS]; /* Likely next allocation offs=
et */
> +};
> +
>  struct swap_sequential_cluster {
> +       spinlock_t lock; /* Serialize usage of global cluster */
>         unsigned int next[SWAP_NR_ORDERS]; /* Likely next allocation offs=
et */
>  };
>
> @@ -278,8 +285,8 @@ struct swap_info_struct {
>                                         /* list of cluster that are fragm=
ented or contented */
>         unsigned int pages;             /* total of usable pages of swap =
*/
>         atomic_long_t inuse_pages;      /* number of those currently in u=
se */
> +       struct percpu_cluster __percpu *percpu_cluster; /* per cpu's swap=
 location */
>         struct swap_sequential_cluster *global_cluster; /* Use one global=
 cluster for rotating device */
> -       spinlock_t global_cluster_lock; /* Serialize usage of global clus=
ter */
>         struct rb_root swap_extent_root;/* root of the swap extent rbtree=
 */
>         struct block_device *bdev;      /* swap device or bdev of swap fi=
le */
>         struct file *swap_file;         /* seldom referenced */
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 44eb6a6e5800..3bb77c9a4879 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -118,18 +118,6 @@ static atomic_t proc_poll_event =3D ATOMIC_INIT(0);
>
>  atomic_t nr_rotate_swap =3D ATOMIC_INIT(0);
>
> -struct percpu_swap_cluster {
> -       struct swap_info_struct *si[SWAP_NR_ORDERS];
> -       unsigned long offset[SWAP_NR_ORDERS];
> -       local_lock_t lock;
> -};
> -
> -static DEFINE_PER_CPU(struct percpu_swap_cluster, percpu_swap_cluster) =
=3D {
> -       .si =3D { NULL },
> -       .offset =3D { SWAP_ENTRY_INVALID },
> -       .lock =3D INIT_LOCAL_LOCK(),
> -};
> -
>  /* May return NULL on invalid type, caller must check for NULL return */
>  static struct swap_info_struct *swap_type_to_info(int type)
>  {
> @@ -497,7 +485,7 @@ swap_cluster_alloc_table(struct swap_info_struct *si,
>          * Swap allocator uses percpu clusters and holds the local lock.
>          */
>         lockdep_assert_held(&ci->lock);
> -       lockdep_assert_held(&this_cpu_ptr(&percpu_swap_cluster)->lock);
> +       lockdep_assert_held(&this_cpu_ptr(si->percpu_cluster)->lock);
>
>         /* The cluster must be free and was just isolated from the free l=
ist. */
>         VM_WARN_ON_ONCE(ci->flags || !cluster_is_empty(ci));
> @@ -515,8 +503,8 @@ swap_cluster_alloc_table(struct swap_info_struct *si,
>          */
>         spin_unlock(&ci->lock);
>         if (!(si->flags & SWP_SOLIDSTATE))
> -               spin_unlock(&si->global_cluster_lock);
> -       local_unlock(&percpu_swap_cluster.lock);
> +               spin_unlock(&si->global_cluster->lock);
> +       local_unlock(&si->percpu_cluster->lock);
>
>         table =3D swap_table_alloc(__GFP_HIGH | __GFP_NOMEMALLOC | GFP_KE=
RNEL);
>
> @@ -528,9 +516,9 @@ swap_cluster_alloc_table(struct swap_info_struct *si,
>          * could happen with ignoring the percpu cluster is fragmentation=
,
>          * which is acceptable since this fallback and race is rare.
>          */
> -       local_lock(&percpu_swap_cluster.lock);
> +       local_lock(&si->percpu_cluster->lock);
>         if (!(si->flags & SWP_SOLIDSTATE))
> -               spin_lock(&si->global_cluster_lock);
> +               spin_lock(&si->global_cluster->lock);
>         spin_lock(&ci->lock);
>
>         /* Nothing except this helper should touch a dangling empty clust=
er. */
> @@ -642,7 +630,7 @@ static bool swap_do_scheduled_discard(struct swap_inf=
o_struct *si)
>                 ci =3D list_first_entry(&si->discard_clusters, struct swa=
p_cluster_info, list);
>                 /*
>                  * Delete the cluster from list to prepare for discard, b=
ut keep
> -                * the CLUSTER_FLAG_DISCARD flag, percpu_swap_cluster cou=
ld be
> +                * the CLUSTER_FLAG_DISCARD flag, there could be percpu_c=
luster
>                  * pointing to it, or ran into by relocate_cluster.
>                  */
>                 list_del(&ci->list);
> @@ -939,12 +927,11 @@ static unsigned int alloc_swap_scan_cluster(struct =
swap_info_struct *si,
>  out:
>         relocate_cluster(si, ci);
>         swap_cluster_unlock(ci);
> -       if (si->flags & SWP_SOLIDSTATE) {
> -               this_cpu_write(percpu_swap_cluster.offset[order], next);
> -               this_cpu_write(percpu_swap_cluster.si[order], si);
> -       } else {
> +       if (si->flags & SWP_SOLIDSTATE)
> +               this_cpu_write(si->percpu_cluster->next[order], next);
> +       else
>                 si->global_cluster->next[order] =3D next;
> -       }
> +
>         return found;
>  }
>
> @@ -1037,13 +1024,17 @@ static unsigned long cluster_alloc_swap_entry(str=
uct swap_info_struct *si, int o
>         if (order && !(si->flags & SWP_BLKDEV))
>                 return 0;
>
> -       if (!(si->flags & SWP_SOLIDSTATE)) {
> +       if (si->flags & SWP_SOLIDSTATE) {
> +               /* Fast path using per CPU cluster */
> +               local_lock(&si->percpu_cluster->lock);
> +               offset =3D __this_cpu_read(si->percpu_cluster->next[order=
]);
> +       } else {
>                 /* Serialize HDD SWAP allocation for each device. */
> -               spin_lock(&si->global_cluster_lock);
> +               spin_lock(&si->global_cluster->lock);
>                 offset =3D si->global_cluster->next[order];
> -               if (offset =3D=3D SWAP_ENTRY_INVALID)
> -                       goto new_cluster;
> +       }
>
> +       if (offset !=3D SWAP_ENTRY_INVALID) {
>                 ci =3D swap_cluster_lock(si, offset);
>                 /* Cluster could have been used by another order */
>                 if (cluster_is_usable(ci, order)) {
> @@ -1058,7 +1049,6 @@ static unsigned long cluster_alloc_swap_entry(struc=
t swap_info_struct *si, int o
>                         goto done;
>         }
>
> -new_cluster:
>         /*
>          * If the device need discard, prefer new cluster over nonfull
>          * to spread out the writes.
> @@ -1121,8 +1111,10 @@ static unsigned long cluster_alloc_swap_entry(stru=
ct swap_info_struct *si, int o
>                         goto done;
>         }
>  done:
> -       if (!(si->flags & SWP_SOLIDSTATE))
> -               spin_unlock(&si->global_cluster_lock);
> +       if (si->flags & SWP_SOLIDSTATE)
> +               local_unlock(&si->percpu_cluster->lock);
> +       else
> +               spin_unlock(&si->global_cluster->lock);
>
>         return found;
>  }
> @@ -1303,43 +1295,8 @@ static bool get_swap_device_info(struct swap_info_=
struct *si)
>         return true;
>  }
>
> -/*
> - * Fast path try to get swap entries with specified order from current
> - * CPU's swap entry pool (a cluster).
> - */
> -static bool swap_alloc_fast(swp_entry_t *entry,
> -                           int order)
> -{
> -       struct swap_cluster_info *ci;
> -       struct swap_info_struct *si;
> -       unsigned int offset, found =3D SWAP_ENTRY_INVALID;
> -
> -       /*
> -        * Once allocated, swap_info_struct will never be completely free=
d,
> -        * so checking it's liveness by get_swap_device_info is enough.
> -        */
> -       si =3D this_cpu_read(percpu_swap_cluster.si[order]);
> -       offset =3D this_cpu_read(percpu_swap_cluster.offset[order]);
> -       if (!si || !offset || !get_swap_device_info(si))
> -               return false;
> -
> -       ci =3D swap_cluster_lock(si, offset);
> -       if (cluster_is_usable(ci, order)) {
> -               if (cluster_is_empty(ci))
> -                       offset =3D cluster_offset(si, ci);
> -               found =3D alloc_swap_scan_cluster(si, ci, offset, order, =
SWAP_HAS_CACHE);
> -               if (found)
> -                       *entry =3D swp_entry(si->type, found);
> -       } else {
> -               swap_cluster_unlock(ci);
> -       }
> -
> -       put_swap_device(si);
> -       return !!found;
> -}
> -
>  /* Rotate the device and switch to a new cluster */
> -static bool swap_alloc_slow(swp_entry_t *entry,
> +static void swap_alloc_entry(swp_entry_t *entry,
>                             int order)

It seems you also changed the rotation rule here so every allocation
of any order is causing a swap device rotation? Before 1b7e90020eb7
every 64 allocation causes a rotation as we had slot cache
(swap_slot.c). The global cluster makes the rotation happen for every
cluster so the overhead is even lower on average. But now a per
allocation roration seems a rather high overhead and may cause serious
fragmentation.

