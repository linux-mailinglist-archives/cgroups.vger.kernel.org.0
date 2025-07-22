Return-Path: <cgroups+bounces-8859-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEFFB0E2F9
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 19:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69DD31C85835
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 17:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AB42857D7;
	Tue, 22 Jul 2025 17:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/KdZ7qL"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FDD28134F;
	Tue, 22 Jul 2025 17:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753206332; cv=none; b=bHZzDsliUU2lVXdBzQJAo+dMm6pAczFt5tCKO3QUJNAyy20J4aRf6frE5vdzUeh2aWG7C7vqhgc606vaExT6zqMpSJie3Hg+G7I1L5SIvNutodbzbocbtn7eS1zvX5w3fPcHb/owqpcvJLfJAMzx12BV7qp7zoQGzPZ62PCa/0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753206332; c=relaxed/simple;
	bh=rOgq3i3j5TiypNmfGfxrmV389ym7bTxBHNRGTJKz+5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NYsIkkmLKRgjIEuCjiihtT1T3XGgLX76axaEr3NRS0+E++WML/9TfFAH9GLvuKmmUhs6jtb6laheJ5JHZaBZnP7QvZfbkFYXP9PSQZZ+rTt6MnbOnE5mHDnAbj8TCRdF3AJQDjvKhqnPsjhJ06h8PWSwIPLG7qy2A6apUrHnNw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/KdZ7qL; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-32f1aaf0d60so58643251fa.1;
        Tue, 22 Jul 2025 10:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753206328; x=1753811128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XjFuwE8taiWiJN5pZzHXNakG5MTT87qFINxfeX0KwoI=;
        b=B/KdZ7qLjbNXbQq3UmyUq8IBVWC9bvAQEZVfCcF3AZiJWc4Ni/MxWSzHIFI6S4BBiG
         SalIO+I1EIEYEyh/BJqTnen1YpQU0KgsUWusruI/bgvo0Kwu2QlwvUBLCcAxjX3yILJc
         ADD5vZvtGoJ2XJnTrdmKB2uUV2zqpUpOWb6/21rbB5VKxk9KfbqbyXNGcA/8WG2l2oyD
         WTDGEzO/xrJt6hVoTJu5gd0BxMe0qAje0CwQ2F7Fl82AHxltOhW5GS4QZpZalZWSiS1Y
         sf5oD8kKYKExcxy/nwWdVmNyy5U7IpAyAaTV4UoFsCxZwzMFyjs8QoL8SfkQeoeT4m8j
         x3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753206328; x=1753811128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XjFuwE8taiWiJN5pZzHXNakG5MTT87qFINxfeX0KwoI=;
        b=JnQcPSmKe0bgWFleKXaOhvV9QV4GRkKZB7+bsWlNtAGWINoF8rFue8BPk484Y1HB4U
         sjxurSoV0XLveCvYdBuy5IFstqqWX+Mmwncp+7iUEaK3926UQZN494Ve8feJRFaBN4BP
         FveIivlKZR7UH3ma9KX2ONmL7ynrxbtt4AvWkjVwyORD3yYtFy2dqUpm0j0LGmbHcwwx
         eUnrP1pl/vQVTPM6uEdRdiwJGN6CUXkIBWZsxWeKB7UFqbAL4X8996Olocxn0OGJcndf
         T8LZ2LOaF+WGvUzCTrDGZXDN0FkDwgMyonxv3fK4mxVqUf6XtJDXqKUjfpUVIOUScRyw
         weTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDy4gkryi1moyFspQtSUJWK/DQTx10tNONa6Ene1alJ6/7bd5TmqMI//ZUBbv/6cO857ssIQl8aIWkdJ2C@vger.kernel.org, AJvYcCWsguIWIYPAbVcE9CwpOyH6wldav5BWBASdw/dAK5d6s11XabvBbbEUwyGXVZNs62jQ72DKuthV@vger.kernel.org
X-Gm-Message-State: AOJu0YxIfcbtV9sBkjfL5A3wvHG7MFt4jIcfzptMFxp/rmX90wmePeqW
	rT990I92i8OTKm5kdsTKcdzyElhxIaUZtcvYRzNOkDL2ZAEBxEZAHYiWg1NeYFOYNwD376F+vz1
	+SYYAw/Sb+LbUj/COaNkutw0LvOxjtzE=
X-Gm-Gg: ASbGncujh6eNQt8hzlqpW9U+6DIWil7UdYlmRkfqzlapDuWXaq0GEbOnO2FoIglzvTa
	RICgxswZUZrasXMOcHCCzblF6HL26ST6Fut+z6Skmh8CXY20NEkWyZ/UtmYHoBk6TY6qMm0JwRL
	TPN2YoSUuTgcJe6Q2dAaSSLczDcmFi8omwzCrBa9PMc0nb5sqNhYs/o7KvfQTGmccixZQBUHjUy
	jsxvpM=
X-Google-Smtp-Source: AGHT+IFDF2mlLYaYBZGWLln98c4PCkofuMMIHb20qfTy6ayrJ+cpDu7CIoPj4/AIk3dXq3Z3l24UI3QC+X31rLhOYGA=
X-Received: by 2002:a05:651c:211b:b0:32f:1f1b:1e68 with SMTP id
 38308e7fff4ca-3309a4fa50bmr65974791fa.18.1753206327200; Tue, 22 Jul 2025
 10:45:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716202006.3640584-1-youngjun.park@lge.com> <20250716202006.3640584-5-youngjun.park@lge.com>
In-Reply-To: <20250716202006.3640584-5-youngjun.park@lge.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 23 Jul 2025 01:44:49 +0800
X-Gm-Features: Ac12FXzJvzXCImBzHeVF2F_uGI5AlIAZiwACCt3ZAEB8qvt4tn9o8yZaQ-naP_E
Message-ID: <CAMgjq7COLbfGwd4CYxNBaLTi4UaPDkKQzkLhsV-caoA-xq1V-g@mail.gmail.com>
Subject: Re: [PATCH 4/4] mm: swap: Per-cgroup per-CPU swap device cache with
 shared clusters
To: Youngjun Park <youngjun.park@lge.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	shikemeng@huaweicloud.com, nphamcs@gmail.com, bhe@redhat.com, 
	baohua@kernel.org, chrisl@kernel.org, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, gunho.lee@lge.com, 
	iamjoonsoo.kim@lge.com, taejoon.song@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 4:21=E2=80=AFAM Youngjun Park <youngjun.park@lge.co=
m> wrote:
>
> This patch introduces a new swap allocation mechanism that supports
> per-cgroup per-CPU swap device caches, combined with per-device per-CPU
> cluster management.
>
> The existing global swap allocator uses a per-CPU device cache and
> cluster, shared by all cgroups. Under this model, per-cgroup swap
> priorities cannot be effectively honored on the fast path, as allocations
> do not distinguish between cgroups.
>
> To address this, we introduce per-cgroup per-CPU swap device caches.
> This allows fast-path swap allocations to respect each cgroup=E2=80=99s
> individual priority settings.
>
> To avoid an explosion of cluster structures proportional to the number
> of cgroups, clusters remain per-device and are shared across cgroups.
> This strikes a balance between performance and memory overhead.
>
> Suggested-by: Nhat Pham <nphamcs@gmail.com>
> Suggested-by: Kairui Song <kasong@tencent.com>
> Signed-off-by: Youngjun Park <youngjun.park@lge.com>
> ---
>  include/linux/swap.h      |   7 ++
>  mm/swap_cgroup_priority.c | 156 +++++++++++++++++++++++++++++++++++++-
>  mm/swap_cgroup_priority.h |  39 ++++++++++
>  mm/swapfile.c             |  47 +++++++-----
>  4 files changed, 228 insertions(+), 21 deletions(-)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index bfddbec2ee28..ab15f4c103a1 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -283,6 +283,12 @@ enum swap_cluster_flags {
>  #define SWAP_NR_ORDERS         1
>  #endif
>
> +#ifdef CONFIG_SWAP_CGROUP_PRIORITY
> +struct percpu_cluster {
> +       unsigned int next[SWAP_NR_ORDERS]; /* Likely next allocation offs=
et */
> +};
> +#endif
> +
>  /*
>   * We keep using same cluster for rotational device so IO will be sequen=
tial.
>   * The purpose is to optimize SWAP throughput on these device.
> @@ -341,6 +347,7 @@ struct swap_info_struct {
>         struct list_head discard_clusters; /* discard clusters list */
>  #ifdef CONFIG_SWAP_CGROUP_PRIORITY
>         u64 id;
> +       struct percpu_cluster __percpu *percpu_cluster; /* per cpu's swap=
 location */
>  #endif
>         struct plist_node avail_lists[]; /*
>                                            * entries in swap_avail_heads,=
 one
> diff --git a/mm/swap_cgroup_priority.c b/mm/swap_cgroup_priority.c
> index 84e876b77f01..f960c3dcab48 100644
> --- a/mm/swap_cgroup_priority.c
> +++ b/mm/swap_cgroup_priority.c
> @@ -21,6 +21,17 @@
>  #include "swap_cgroup_priority.h"
>  #include "memcontrol-v1.h"
>
> +/*
> + * We do maintain a cache on a per-cgroup-per-swap-device basis.
> + * However, the underlying cluster cache itself is managed
> + * per-swap-device. This design prevents each individual
> + * swap_cgroup_priority entry from caching its own cluster data,
> + * even as the number of such entries increases.
> + */
> +struct percpu_swap_device {
> +       struct swap_info_struct *si[SWAP_NR_ORDERS];
> +};
> +
>  static DEFINE_MUTEX(swap_cgroup_priority_inherit_lck);
>  static LIST_HEAD(swap_cgroup_priority_list);
>
> @@ -49,6 +60,7 @@ static LIST_HEAD(swap_cgroup_priority_list);
>   * least_priority - Current lowest priority.
>   * distance - Priority differences from global swap priority.
>   * default_prio - Default priority for this cgroup.
> + * pcpu_swapdev - Per-CPU swap device.
>   * plist - Priority list head.
>   */
>  struct swap_cgroup_priority {
> @@ -64,6 +76,7 @@ struct swap_cgroup_priority {
>         int least_priority;
>         s8 distance;
>         int default_prio;
> +       struct percpu_swap_device __percpu *pcpu_swapdev;
>         struct plist_head plist[];
>  };
>
> @@ -132,6 +145,21 @@ static struct swap_cgroup_priority *get_effective_sw=
ap_cgroup_priority(
>         return swap_priority->effective;
>  }
>
> +static struct swap_cgroup_priority *get_effective_swap_cgroup_priority_r=
cu(
> +       struct mem_cgroup *memcg)
> +{
> +       struct swap_cgroup_priority *swap_priority;
> +
> +       if (!memcg)
> +               return NULL;
> +
> +       swap_priority =3D rcu_dereference(memcg->swap_priority);
> +       if (!swap_priority)
> +               return NULL;
> +
> +       return rcu_dereference(swap_priority->effective);
> +}
> +
>  static bool validate_effective_swap_cgroup_priority(
>         struct mem_cgroup *memcg,
>         struct swap_cgroup_priority **swap_priority)
> @@ -172,6 +200,9 @@ static void free_swap_cgroup_priority_pnode(
>  static void free_swap_cgroup_priority(
>         struct swap_cgroup_priority *swap_priority)
>  {
> +       if (swap_priority->pcpu_swapdev)
> +               free_percpu(swap_priority->pcpu_swapdev);
> +
>         for (int i =3D 0; i < MAX_SWAPFILES; i++)
>                 free_swap_cgroup_priority_pnode(swap_priority->pnode[i]);
>
> @@ -187,6 +218,12 @@ static struct swap_cgroup_priority *alloc_swap_cgrou=
p_priority(void)
>         if (!swap_priority)
>                 return NULL;
>
> +       swap_priority->pcpu_swapdev =3D alloc_percpu(struct percpu_swap_d=
evice);
> +       if (!swap_priority->pcpu_swapdev) {
> +               kvfree(swap_priority);
> +               return NULL;
> +       }
> +
>         /*
>          * Pre-allocates pnode array up to nr_swapfiles at init.
>          * Individual pnodes are assigned on swapon, but not freed
> @@ -326,10 +363,34 @@ bool swap_alloc_cgroup_priority(struct mem_cgroup *=
memcg,
>         unsigned long offset;
>         int node;
>
> -       /*
> -        * TODO: Per-cpu swap cluster cache can't be used directly
> -        * as cgroup-specific priorities may select different devices.
> -        */
> +       rcu_read_lock();
> +       if (!(swap_priority =3D get_effective_swap_cgroup_priority_rcu(me=
mcg))) {
> +               rcu_read_unlock();
> +               return false;
> +       }
> +
> +       /* Fast path */
> +       si =3D this_cpu_read(swap_priority->pcpu_swapdev->si[order]);
> +       if (si && get_swap_device_info(si)) {
> +               offset =3D cluster_alloc_swap_entry(si, order, SWAP_HAS_C=
ACHE);
> +               if (offset) {
> +                       *entry =3D swp_entry(si->type, offset);
> +                       /*
> +                        * Protected by 'percpu_swap_cluster' local_lock;
> +                        * CPU migration is disabled during this operatio=
n.
> +                        */
> +                       this_cpu_write(swap_priority->pcpu_swapdev->si[or=
der],
> +                                      si);
> +                       put_swap_device(si);
> +                       rcu_read_unlock();
> +
> +                       return true;
> +               }
> +               put_swap_device(si);
> +       }
> +       rcu_read_unlock();
> +
> +       /* Slow path */

Hi Youngjun

One thing I noticed after a quick glance is that this
swap_alloc_cgroup_priority is bloated and it is doing similar things
as folio_alloc_swap.

I imagined that we can just have a struct (eg. let's call it struct
swap_percpu_info / pi) as a closure of what the allocator needs, it
contains the plist and fast path device.

With slight changes to folio_alloc_swap, it can respect either the
cgroup's pi or global pi. (might be a horrible name though, feel free
to change it)

For example first thing swap_alloc_fast do will be:

`struct swap_percpu_info *pi =3D folio_swap_percpu_info(folio);`

folio_swap_percpu_info returns the cgroup's swap_percpu_info or the global =
one.

swap_alloc_slow can do a similar thing, it then can just use pi->plist
and pi->pcpu_swapdev, (cluster info will be in si) ignoring all the
cgroup differences.

Also it is better to check your patches with ./scripts/checkpatch.pl,
I'm seeing some styling issues.

I'll check your other patches too later this week, thanks for the
update on this idea.

>         spin_lock(&swap_avail_lock);
>         node =3D numa_node_id();
>
> @@ -350,6 +411,14 @@ bool swap_alloc_cgroup_priority(struct mem_cgroup *m=
emcg,
>                 if (get_swap_device_info(si)) {
>                         offset =3D cluster_alloc_swap_entry(si, order,
>                                                           SWAP_HAS_CACHE)=
;
> +                       /*
> +                        * Protected by 'percpu_swap_cluster' local_lock;
> +                        * CPU migration is disabled during this operatio=
n.
> +                        */
> +                       if (memcg->swap_priority =3D=3D swap_priority)
> +                               this_cpu_write(
> +                                       swap_priority->pcpu_swapdev->si[o=
rder],
> +                                       si);
>                         put_swap_device(si);
>                         if (offset) {
>                                 *entry =3D swp_entry(si->type, offset);
> @@ -687,6 +756,21 @@ static int __apply_swap_cgroup_priority(
>         return 0;
>  }
>
> +static int init_swap_cgroup_priority_pcpu_swapdev_cache(
> +       struct swap_cgroup_priority *swap_priority)
> +{
> +       int cpu;
> +
> +       for_each_possible_cpu(cpu) {
> +               struct percpu_swap_device *pcp_swap_dev =3D
> +                       per_cpu_ptr(swap_priority->pcpu_swapdev, cpu);
> +               for (int i =3D 0; i < SWAP_NR_ORDERS; i++)
> +                       pcp_swap_dev->si[i] =3D NULL;
> +       }
> +
> +       return 0;
> +}
> +
>  /*
>   * If this is the top-level swap_cgroup_priority, propagation is needed.
>   * We traverse the 'mem_cgroup_tree' using 'for_each_mem_cgroup_tree'.
> @@ -795,6 +879,8 @@ int apply_swap_cgroup_priority(struct mem_cgroup *mem=
cg, u64 id, int prio)
>         for_each_node(nid)
>                 plist_head_init(&swap_priority->plist[nid]);
>
> +       init_swap_cgroup_priority_pcpu_swapdev_cache(swap_priority);
> +
>  prio_set:
>         spin_lock(&swap_lock);
>         spin_lock(&swap_avail_lock);
> @@ -843,6 +929,23 @@ int apply_swap_cgroup_priority(struct mem_cgroup *me=
mcg, u64 id, int prio)
>
>         spin_unlock(&swap_avail_lock);
>         spin_unlock(&swap_lock);
> +       /*
> +        * XXX: We cannot fully synchronize with swap_alloc_cgroup_priori=
ty
> +        * when updating the next si.
> +        * Still, we ensure that flush operations inside swap_priority
> +        * are performed as reliably as possible.
> +        */
> +       if (id !=3D DEFAULT_ID &&
> +           swap_priority =3D=3D swap_priority->effective && !new) {
> +               int cpu;
> +               struct swap_info_struct **pcp_si;
> +               for_each_possible_cpu(cpu) {
> +                       pcp_si =3D per_cpu_ptr(
> +                               swap_priority->pcpu_swapdev->si, cpu);
> +                       for (int i =3D 0; i < SWAP_NR_ORDERS; i++)
> +                               pcp_si[i] =3D NULL;
> +               }
> +       }
>         mutex_unlock(&swap_cgroup_priority_inherit_lck);
>         return 0;
>
> @@ -886,3 +989,48 @@ void delete_swap_cgroup_priority(struct mem_cgroup *=
memcg)
>         spin_unlock(&swap_avail_lock);
>         mutex_unlock(&swap_cgroup_priority_inherit_lck);
>  }
> +
> +void flush_swap_cgroup_priority_percpu_swapdev(struct swap_info_struct *=
si)
> +{
> +       int cpu, i;
> +       struct swap_info_struct **pcp_si;
> +       struct swap_cgroup_priority *swap_priority;
> +
> +       rcu_read_lock();
> +       list_for_each_entry_rcu(swap_priority,
> +                               &swap_cgroup_priority_list, link) {
> +               for_each_possible_cpu(cpu) {
> +                       pcp_si =3D per_cpu_ptr(
> +                                       swap_priority->pcpu_swapdev->si, =
cpu);
> +
> +                       for (i =3D 0; i < SWAP_NR_ORDERS; i++)
> +                               cmpxchg(&pcp_si[i], si, NULL);
> +               }
> +       }
> +       rcu_read_unlock();
> +}
> +
> +bool alloc_percpu_swap_cluster(struct swap_info_struct *si)
> +{
> +       si->percpu_cluster =3D alloc_percpu(struct percpu_cluster);
> +       if (!si->percpu_cluster)
> +               return false;
> +
> +       int cpu;
> +       int i;
> +       for_each_possible_cpu(cpu) {
> +               struct percpu_cluster *cluster;
> +
> +               cluster =3D per_cpu_ptr(si->percpu_cluster, cpu);
> +               for (i =3D 0; i < SWAP_NR_ORDERS; i++)
> +                       cluster->next[i] =3D SWAP_ENTRY_INVALID;
> +       }
> +
> +       return true;
> +}
> +
> +void free_percpu_swap_cluster(struct swap_info_struct *si)
> +{
> +       free_percpu(si->percpu_cluster);
> +       si->percpu_cluster =3D NULL;
> +}
> diff --git a/mm/swap_cgroup_priority.h b/mm/swap_cgroup_priority.h
> index 5d16b63d12e0..815822ebd0d1 100644
> --- a/mm/swap_cgroup_priority.h
> +++ b/mm/swap_cgroup_priority.h
> @@ -47,6 +47,22 @@ struct swap_cgroup_priority *inherit_swap_cgroup_prior=
ity(
>  bool swap_alloc_cgroup_priority(struct mem_cgroup *memcg, swp_entry_t *e=
ntry,
>                                 int order);
>  void delete_swap_cgroup_priority(struct mem_cgroup *memcg);
> +void flush_swap_cgroup_priority_percpu_swapdev(struct swap_info_struct *=
si);
> +
> +bool alloc_percpu_swap_cluster(struct swap_info_struct *si);
> +void free_percpu_swap_cluster(struct swap_info_struct *si);
> +static inline void write_percpu_swap_cluster_next(struct swap_info_struc=
t *si,
> +                                                 int order,
> +                                                 unsigned int next)
> +{
> +       this_cpu_write(si->percpu_cluster->next[order], next);
> +}
> +
> +static inline unsigned int read_percpu_swap_cluster_next(
> +       struct swap_info_struct *si, int order)
> +{
> +        return __this_cpu_read(si->percpu_cluster->next[order]);
> +}
>  #else
>  int swap_node(struct swap_info_struct *si);
>  unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int =
order,
> @@ -85,5 +101,28 @@ static inline bool swap_alloc_cgroup_priority(struct =
mem_cgroup *memcg,
>  static inline void delete_swap_cgroup_priority(struct mem_cgroup *memcg)
>  {
>  }
> +static inline void flush_swap_cgroup_priority_percpu_swapdev(
> +       struct swap_info_struct *si)
> +{
> +}
> +static inline bool alloc_percpu_swap_cluster(struct swap_info_struct *si=
)
> +{
> +       return true;
> +}
> +static inline void free_percpu_swap_cluster(struct swap_info_struct *si)
> +{
> +}
> +static inline void write_percpu_swap_cluster_next(struct swap_info_struc=
t *si,
> +                                                 int order,
> +                                                 unsigned int next)
> +{
> +       return;
> +}
> +
> +static inline unsigned int read_percpu_swap_cluster_next(
> +       struct swap_info_struct *si, int order)
> +{
> +       return SWAP_ENTRY_INVALID;
> +}
>  #endif
>  #endif
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index bfd0532ad250..6a5ac9962e9f 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -817,12 +817,15 @@ static unsigned int alloc_swap_scan_cluster(struct =
swap_info_struct *si,
>  out:
>         relocate_cluster(si, ci);
>         unlock_cluster(ci);
> +
>         if (si->flags & SWP_SOLIDSTATE) {
>                 this_cpu_write(percpu_swap_cluster.offset[order], next);

Why not just remove the `percpu_swap_cluster.offset` and just share
si->percpu_cluster among all cgroups (including root cgroup)?

Otherwise, eg. if rootcg's pcpu cluster and one cgroup's pcpu
cluster are pointing to one same cluster, they might be in
contention on allocation of different order, or even in the same order
the performance might not be good as multiple CPUs will race
with each other.

It will be easier to implement too.




>                 this_cpu_write(percpu_swap_cluster.si[order], si);
> +               write_percpu_swap_cluster_next(si, order, next);
>         } else {
>                 si->global_cluster->next[order] =3D next;
>         }
> +
>         return found;
>  }
>
> @@ -892,26 +895,29 @@ unsigned long cluster_alloc_swap_entry(struct swap_=
info_struct *si, int order,
>         if (order && !(si->flags & SWP_BLKDEV))
>                 return 0;
>
> -       if (!(si->flags & SWP_SOLIDSTATE)) {
> +       if (si->flags & SWP_SOLIDSTATE) {
> +               offset =3D read_percpu_swap_cluster_next(si, order);
> +       } else {
>                 /* Serialize HDD SWAP allocation for each device. */
>                 spin_lock(&si->global_cluster_lock);
>                 offset =3D si->global_cluster->next[order];
> -               if (offset =3D=3D SWAP_ENTRY_INVALID)
> -                       goto new_cluster;
> +       }
>
> -               ci =3D lock_cluster(si, offset);
> -               /* Cluster could have been used by another order */
> -               if (cluster_is_usable(ci, order)) {
> -                       if (cluster_is_empty(ci))
> -                               offset =3D cluster_offset(si, ci);
> -                       found =3D alloc_swap_scan_cluster(si, ci, offset,
> -                                                       order, usage);
> -               } else {
> -                       unlock_cluster(ci);
> -               }
> -               if (found)
> -                       goto done;
> +       if (offset =3D=3D SWAP_ENTRY_INVALID)
> +               goto new_cluster;
> +
> +       ci =3D lock_cluster(si, offset);
> +       /* Cluster could have been used by another order */
> +       if (cluster_is_usable(ci, order)) {
> +               if (cluster_is_empty(ci))
> +                       offset =3D cluster_offset(si, ci);
> +               found =3D alloc_swap_scan_cluster(si, ci, offset,
> +                                               order, usage);
> +       } else {
> +               unlock_cluster(ci);
>         }
> +       if (found)
> +               goto done;
>
>  new_cluster:
>         ci =3D isolate_lock_cluster(si, &si->free_clusters);
> @@ -991,6 +997,7 @@ unsigned long cluster_alloc_swap_entry(struct swap_in=
fo_struct *si, int order,
>  done:
>         if (!(si->flags & SWP_SOLIDSTATE))
>                 spin_unlock(&si->global_cluster_lock);
> +
>         return found;
>  }
>
> @@ -2674,6 +2681,8 @@ static void flush_percpu_swap_cluster(struct swap_i=
nfo_struct *si)
>                 for (i =3D 0; i < SWAP_NR_ORDERS; i++)
>                         cmpxchg(&pcp_si[i], si, NULL);
>         }
> +
> +       flush_swap_cgroup_priority_percpu_swapdev(si);
>  }
>
>
> @@ -2802,6 +2811,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, speci=
alfile)
>         arch_swap_invalidate_area(p->type);
>         zswap_swapoff(p->type);
>         mutex_unlock(&swapon_mutex);
> +       free_percpu_swap_cluster(p);
>         kfree(p->global_cluster);
>         p->global_cluster =3D NULL;
>         vfree(swap_map);
> @@ -2900,7 +2910,6 @@ static void swap_stop(struct seq_file *swap, void *=
v)
>         mutex_unlock(&swapon_mutex);
>  }
>
> -
>  #ifndef CONFIG_SWAP_CGROUP_PRIORITY
>  static int swap_show(struct seq_file *swap, void *v)
>  {
> @@ -3239,7 +3248,10 @@ static struct swap_cluster_info *setup_clusters(st=
ruct swap_info_struct *si,
>         for (i =3D 0; i < nr_clusters; i++)
>                 spin_lock_init(&cluster_info[i].lock);
>
> -       if (!(si->flags & SWP_SOLIDSTATE)) {
> +       if (si->flags & SWP_SOLIDSTATE) {
> +               if (!alloc_percpu_swap_cluster(si))
> +                       goto err_free;
> +       } else {
>                 si->global_cluster =3D kmalloc(sizeof(*si->global_cluster=
),
>                                      GFP_KERNEL);
>                 if (!si->global_cluster)
> @@ -3532,6 +3544,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specia=
lfile, int, swap_flags)
>  bad_swap_unlock_inode:
>         inode_unlock(inode);
>  bad_swap:
> +       free_percpu_swap_cluster(si);
>         kfree(si->global_cluster);
>         si->global_cluster =3D NULL;
>         inode =3D NULL;
> --
> 2.34.1
>
>

