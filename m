Return-Path: <cgroups+bounces-8503-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81EC5AD6EB9
	for <lists+cgroups@lfdr.de>; Thu, 12 Jun 2025 13:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FBF63A5DCD
	for <lists+cgroups@lfdr.de>; Thu, 12 Jun 2025 11:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7585A236A9F;
	Thu, 12 Jun 2025 11:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBeyDPqe"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE19239E8B;
	Thu, 12 Jun 2025 11:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749726886; cv=none; b=XETZ0Mttaf9MMi0kzkDS1qQrnHiNusOflUL0QTO7797mTdQGzRERZAUHjgBOocnfKtMGpprxeCmbQQbjXwetXR08DplKzetO0r1MpAn3YUmU0g25GXKL6T7veIL/Y2tBTcu5oE9hG2Em74gzkvufLp6De3W60aPP8+Q/kr0Ow2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749726886; c=relaxed/simple;
	bh=XqoXrKkwn7abKy+vMuTWX/LjnWoqhtaYRa6STbVZigk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MVlnUWTlePzU0bqbLkyXvPhaX7hcGrFr4s/N7nN1hKPtPKNH0YpUQkY1jGNBmtH3Q+IZ0c0iYDanrdcusmj48lhoekri6FWFtN7gTimeDzKVyhH1Fu8SSgHSSER1wiEDuhstC9X2JTEDtCwOB+nUjbgSMfdBc494SjSgrUmHRKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mBeyDPqe; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-32a81344ae9so8710141fa.0;
        Thu, 12 Jun 2025 04:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749726882; x=1750331682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lyolDGz+XpXrbH8KPxZQxGtQW451+9nY+9T4gPueHSw=;
        b=mBeyDPqefYtnp4tpgAoFj93cIe+VNy3KTFkwhIw9biAS/Cxa0B4sahrDzvmiNSez/d
         91djHgmzFbgHD/bICnQ7e8oCpxpjIGhYm5KDWErUeZIHtX+HS1ap0u9rgMAKwkOr1JuC
         P0yOmlcl0EtP+vJm7YLHp86+BuohGqc2O3s+hgxAF+Ew4Qv7UppBZhCOeMcBnlcMLwOr
         Oxf8e3vlYOwu0rg7LME+FvinPaBOlVQ3JKgGxZzacZwhuAWrVeCrkAhOwzs14LutGKci
         uWZ6pgOZ4S43KzIeqnHsjyRtU2zb8tIgk/plEACI5PvM4OGJAdDW+Hb0rzNQ3+4hp4GG
         Yqcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749726882; x=1750331682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lyolDGz+XpXrbH8KPxZQxGtQW451+9nY+9T4gPueHSw=;
        b=eklez2t4wp6+ysNx+P15GZo8JLteOnc6YFbN47BKvNJD8o1j3ACb9tzYeLzkOdr25I
         qOB1/6YwZkbmwXwf8IuTExAJ4pmVHJfpyDL0rfWTrZ4GRNjPqQ4ifOF9f5Wp6soKRL7x
         9Ln7Yh7WJVJ68R9uhgraqchbRx0QuDFr5aUAOQLIMCiJ6f1O/Q+fVegkxD3YD+nT44aI
         4oKo1foqYOc6ho1a0JMhSitWa7V3cMbITbZu9gUB/OVMsprsuvDveD/MBpoccbKmwBgS
         /8hrhlIarkUkzPm7TaEAN1mKMwCiO/gHkiFwxICRgKxkLfen2DR64THE0Cku1KZmCxTX
         7lFg==
X-Forwarded-Encrypted: i=1; AJvYcCV2dJATSFXmVj3hwXd/lvZd3wvQ1aBvsiGT98pa7n3FR6hX7GnEHslAeWG07cr7slTmEJ0mtyUv@vger.kernel.org, AJvYcCXW8BX3sWDZ+Ek/pdH8r4ZmbVLDkMWzYAtM+4NevKML9+C4Mawid7D19Md+N4gFgYAFMeLACn5TrOPHp7lo@vger.kernel.org
X-Gm-Message-State: AOJu0YzCaf+8DlqnBNbBotroSfMFy+p4NB+oM6P/EhmYW/RWwRWk681A
	trm16leYGreWh+RERN8qoR1jD/Sgu9CSQQ7DqNPB0AfbWzGH0fOZg0zpE9bG03SaTxo/0DKRwtD
	lxqTiX/O1F0GNtz1Tzq2NvSSxicbvRMA=
X-Gm-Gg: ASbGncu0P7Mc9U+u+pSoi+9OMn+PiAUdqZd23Dka2VTR2bBTb746ndSkjPUygiE88yj
	v8Gv7uMrwwrWZ1aUoYjS7sOXNDdtDC0uNNiNO7lbx8K9FVp3jlwU0GAh7EwkNbuaO8UFYXwE/JD
	PCm7U//P7TFBkhOwOM+26rGSSrCGHHvcmcrRpASRjVh+pPw1IaMP4IEA==
X-Google-Smtp-Source: AGHT+IHn04oPwi89rrj1PFpVC87mCZKoYlj8U2B21/TTzmZZ4W8qSCT3nuhYaq9zuA78AVq70nOdTJzDwDa3s5wJ5PU=
X-Received: by 2002:a2e:b8c7:0:b0:30b:f52d:148f with SMTP id
 38308e7fff4ca-32b21d72375mr18710361fa.18.1749726881339; Thu, 12 Jun 2025
 04:14:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612103743.3385842-1-youngjun.park@lge.com> <20250612103743.3385842-3-youngjun.park@lge.com>
In-Reply-To: <20250612103743.3385842-3-youngjun.park@lge.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 12 Jun 2025 19:14:20 +0800
X-Gm-Features: AX0GCFuBIq3bPhkP3cqQUxmDFgqT54uajvPComqZWYIAV4bzOzS9ln88nMxGJjw
Message-ID: <CAMgjq7BJE9ALFG4N8wb-hdkC+b-8d1+ckXL9D6pbbfgiXfuzPA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] mm: swap: apply per cgroup swap priority
 mechansim on swap layer
To: youngjun.park@lge.com
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, hannes@cmpxchg.org, 
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	shikemeng@huaweicloud.com, nphamcs@gmail.com, bhe@redhat.com, 
	baohua@kernel.org, chrisl@kernel.org, muchun.song@linux.dev, 
	iamjoonsoo.kim@lge.com, taejoon.song@lge.com, gunho.lee@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 6:43=E2=80=AFPM <youngjun.park@lge.com> wrote:
>
> From: "youngjun.park" <youngjun.park@lge.com>
>

Hi, Youngjun,

Thanks for sharing this series.

> This patch implements swap device selection and swap on/off propagation
> when a cgroup-specific swap priority is set.
>
> There is one workaround to this implementation as follows.
> Current per-cpu swap cluster enforces swap device selection based solely
> on CPU locality, overriding the swap cgroup's configured priorities.

I've been thinking about this, we can switch to a per-cgroup-per-cpu
next cluster selector, the problem with current code is that swap
allocator is not designed with folio / cgroup in mind at all, so it's
really ugly to implement, which is why I have following two patches in
the swap table series:

https://lore.kernel.org/linux-mm/20250514201729.48420-18-ryncsn@gmail.com/
https://lore.kernel.org/linux-mm/20250514201729.48420-22-ryncsn@gmail.com/

The first one makes all swap allocation starts with a folio, the
second one makes the allocator always folio aware. So you can know
which cgroup is doing the allocation at anytime inside the allocator
(and it reduced the number of argument, also improving performance :)
)

So the allocator can just use cgroup's swap info if available, plist,
percpu cluster, and fallback to global locality in a very natural way.

> Therefore, when a swap cgroup priority is assigned, we fall back to
> using per-CPU clusters per swap device, similar to the previous behavior.
>
> A proper fix for this workaround will be evaluated in the next patch.

Hmm, but this is already the last patch in the series?

>
> Signed-off-by: Youngjun park <youngjun.park@lge.com>
> ---
>  include/linux/swap.h      |   8 +++
>  mm/swap.h                 |   8 +++
>  mm/swap_cgroup_priority.c | 133 ++++++++++++++++++++++++++++++++++++++
>  mm/swapfile.c             | 125 ++++++++++++++++++++++++-----------
>  4 files changed, 238 insertions(+), 36 deletions(-)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 49b73911c1bd..d158b0d5c997 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -283,6 +283,13 @@ enum swap_cluster_flags {
>  #define SWAP_NR_ORDERS         1
>  #endif
>
> +#ifdef CONFIG_SWAP_CGROUP_PRIORITY
> +struct percpu_cluster {
> +       local_lock_t lock; /* Protect the percpu_cluster above */
> +       unsigned int next[SWAP_NR_ORDERS]; /* Likely next allocation offs=
et */
> +};
> +#endif
> +
>  /*
>   * We keep using same cluster for rotational device so IO will be sequen=
tial.
>   * The purpose is to optimize SWAP throughput on these device.
> @@ -341,6 +348,7 @@ struct swap_info_struct {
>         struct list_head discard_clusters; /* discard clusters list */
>  #ifdef CONFIG_SWAP_CGROUP_PRIORITY
>         int unique_id;
> +       struct percpu_cluster __percpu *percpu_cluster; /* per cpu's swap=
 location */
>  #endif
>         struct plist_node avail_lists[]; /*
>                                            * entries in swap_avail_heads,=
 one
> diff --git a/mm/swap.h b/mm/swap.h
> index cd2649c632ed..cb6d653fe3f1 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -113,7 +113,15 @@ void delete_swap_cgroup_priority(struct mem_cgroup *=
memcg);
>  void show_swap_device_unique_id(struct seq_file *m);
>  #else
>  static inline void delete_swap_cgroup_priority(struct mem_cgroup *memcg)=
 {}
> +static inline void activate_swap_cgroup_priority_pnode(struct swap_info_=
struct *swp, bool swapon) {}
> +static inline void deactivate_swap_cgroup_priority_pnode(struct swap_inf=
o_struct *swp, bool swapoff){}
>  static inline void get_swap_unique_id(struct swap_info_struct *si) {}
> +static inline bool swap_alloc_cgroup_priority(struct mem_cgroup *memcg,
> +                               swp_entry_t *entry, int order)
> +{
> +       return false;
> +}
> +
>  #endif
>
>  #else /* CONFIG_SWAP */
> diff --git a/mm/swap_cgroup_priority.c b/mm/swap_cgroup_priority.c
> index b3e20b676680..bb18cb251f60 100644
> --- a/mm/swap_cgroup_priority.c
> +++ b/mm/swap_cgroup_priority.c
> @@ -54,6 +54,132 @@ static void get_swap_unique_id(struct swap_info_struc=
t *si)
>         si->unique_id =3D atomic_add_return(1, &swap_unique_id_counter);
>  }
>
> +static bool swap_alloc_cgroup_priority(struct mem_cgroup *memcg,
> +                               swp_entry_t *entry, int order)
> +{
> +       struct swap_cgroup_priority *swap_priority;
> +       struct swap_cgroup_priority_pnode *pnode, *next;
> +       unsigned long offset;
> +       int node;
> +
> +       if (!memcg)
> +               return false;
> +
> +       spin_lock(&swap_avail_lock);
> +priority_check:
> +       swap_priority =3D memcg->swap_priority;
> +       if (!swap_priority) {
> +               spin_unlock(&swap_avail_lock);
> +               return false;
> +       }
> +
> +       node =3D numa_node_id();
> +start_over:
> +       plist_for_each_entry_safe(pnode, next, &swap_priority->plist[node=
],
> +                                       avail_lists[node]) {
> +               struct swap_info_struct *si =3D pnode->swap;
> +               plist_requeue(&pnode->avail_lists[node],
> +                       &swap_priority->plist[node]);
> +               spin_unlock(&swap_avail_lock);
> +
> +               if (get_swap_device_info(si)) {
> +                       offset =3D cluster_alloc_swap_entry(si,
> +                                       order, SWAP_HAS_CACHE, true);
> +                       put_swap_device(si);
> +                       if (offset) {
> +                               *entry =3D swp_entry(si->type, offset);
> +                               return true;
> +                       }
> +                       if (order)
> +                               return false;
> +               }
> +
> +               spin_lock(&swap_avail_lock);
> +
> +               /* swap_priority is remove or changed under us. */
> +               if (swap_priority !=3D memcg->swap_priority)
> +                       goto priority_check;
> +
> +               if (plist_node_empty(&next->avail_lists[node]))
> +                       goto start_over;
> +       }
> +       spin_unlock(&swap_avail_lock);
> +
> +       return false;
> +}
> +
> +/* add_to_avail_list (swapon / swapusage > 0) */
> +static void activate_swap_cgroup_priority_pnode(struct swap_info_struct =
*swp,
> +                       bool swapon)
> +{
> +       struct swap_cgroup_priority *swap_priority;
> +       int i;
> +
> +       list_for_each_entry(swap_priority, &swap_cgroup_priority_list, li=
nk) {
> +               struct swap_cgroup_priority_pnode *pnode
> +                       =3D swap_priority->pnode[swp->type];
> +
> +               if (swapon) {
> +                       pnode->swap =3D swp;
> +                       pnode->prio =3D swp->prio;
> +               }
> +
> +               /* NUMA priority handling */
> +               for_each_node(i) {
> +                       if (swapon) {
> +                               if (swap_node(swp) =3D=3D i) {
> +                                       plist_node_init(
> +                                               &pnode->avail_lists[i],
> +                                               1);
> +                               } else {
> +                                       plist_node_init(
> +                                               &pnode->avail_lists[i],
> +                                               -pnode->prio);
> +                               }
> +                       }
> +
> +                       plist_add(&pnode->avail_lists[i],
> +                               &swap_priority->plist[i]);
> +               }
> +       }
> +}
> +
> +/* del_from_avail_list (swapoff / swap usage <=3D 0) */
> +static void deactivate_swap_cgroup_priority_pnode(struct swap_info_struc=
t *swp,
> +               bool swapoff)
> +{
> +       struct swap_cgroup_priority *swap_priority;
> +       int nid, i;
> +
> +       list_for_each_entry(swap_priority, &swap_cgroup_priority_list, li=
nk) {
> +               struct swap_cgroup_priority_pnode *pnode;
> +
> +               if (swapoff && swp->prio < 0) {
> +                       /*
> +                       * NUMA priority handling
> +                       * mimic swapoff prio adjustment without plist
> +                       */
> +                       for (int i =3D 0; i < MAX_SWAPFILES; i++) {
> +                               pnode =3D swap_priority->pnode[i];
> +                               if (pnode->prio > swp->prio ||
> +                                       pnode->swap =3D=3D swp)
> +                                       continue;
> +
> +                               pnode->prio++;
> +                               for_each_node(nid) {
> +                                       if (pnode->avail_lists[nid].prio =
!=3D 1)
> +                                               pnode->avail_lists[nid].p=
rio--;
> +                               }
> +                       }
> +               }
> +
> +               pnode =3D swap_priority->pnode[swp->type];
> +               for_each_node(i)
> +                       plist_del(&pnode->avail_lists[i],
> +                               &swap_priority->plist[i]);
> +       }
> +}
> +
>  int create_swap_cgroup_priority(struct mem_cgroup *memcg,
>                 int unique[], int prio[], int nr)
>  {
> @@ -183,6 +309,12 @@ void delete_swap_cgroup_priority(struct mem_cgroup *=
memcg)
>  {
>         struct swap_cgroup_priority *swap_priority;
>
> +       /*
> +       * XXX: Possible RCU wait? No. Cannot protect priority list additi=
on.
> +       * swap_avail_lock gives protection.
> +       * Think about other object protection mechanism
> +       * might be solve it and better. (e.g object reference)
> +       */
>         spin_lock(&swap_avail_lock);
>         swap_priority =3D memcg->swap_priority;
>         if (!swap_priority) {
> @@ -198,5 +330,6 @@ void delete_swap_cgroup_priority(struct mem_cgroup *m=
emcg)
>
>         for (int i =3D 0; i < MAX_SWAPFILES; i++)
>                 kvfree(swap_priority->pnode[i]);
> +
>         kvfree(swap_priority);
>  }
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index f8e48dd2381e..28afe4ec0504 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -126,8 +126,12 @@ static DEFINE_PER_CPU(struct percpu_swap_cluster, pe=
rcpu_swap_cluster) =3D {
>         .offset =3D { SWAP_ENTRY_INVALID },
>         .lock =3D INIT_LOCAL_LOCK(),
>  };
> -/* TODO: better choice? */
> +/* TODO: better arrangement */
>  #ifdef CONFIG_SWAP_CGROUP_PRIORITY
> +static bool get_swap_device_info(struct swap_info_struct *si);
> +static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *s=
i, int order,
> +                                             unsigned char usage, bool i=
s_cgroup_priority);
> +static int swap_node(struct swap_info_struct *si);
>  #include "swap_cgroup_priority.c"
>  #endif
>
> @@ -776,7 +780,8 @@ static unsigned int alloc_swap_scan_cluster(struct sw=
ap_info_struct *si,
>                                             struct swap_cluster_info *ci,
>                                             unsigned long offset,
>                                             unsigned int order,
> -                                           unsigned char usage)
> +                                           unsigned char usage,
> +                                           bool is_cgroup_priority)
>  {
>         unsigned int next =3D SWAP_ENTRY_INVALID, found =3D SWAP_ENTRY_IN=
VALID;
>         unsigned long start =3D ALIGN_DOWN(offset, SWAPFILE_CLUSTER);
> @@ -820,12 +825,19 @@ static unsigned int alloc_swap_scan_cluster(struct =
swap_info_struct *si,
>  out:
>         relocate_cluster(si, ci);
>         unlock_cluster(ci);
> +
>         if (si->flags & SWP_SOLIDSTATE) {
> -               this_cpu_write(percpu_swap_cluster.offset[order], next);
> -               this_cpu_write(percpu_swap_cluster.si[order], si);
> -       } else {
> +               if (!is_cgroup_priority) {
> +                       this_cpu_write(percpu_swap_cluster.offset[order],=
 next);
> +                       this_cpu_write(percpu_swap_cluster.si[order], si)=
;
> +               } else {
> +#ifdef CONFIG_SWAP_CGROUP_PRIORITY
> +                       __this_cpu_write(si->percpu_cluster->next[order],=
 next);
> +#endif
> +               }
> +       } else
>                 si->global_cluster->next[order] =3D next;
> -       }
> +
>         return found;
>  }
>
> @@ -883,7 +895,7 @@ static void swap_reclaim_work(struct work_struct *wor=
k)
>   * cluster for current CPU too.
>   */
>  static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *s=
i, int order,
> -                                             unsigned char usage)
> +                                             unsigned char usage, bool i=
s_cgroup_priority)
>  {
>         struct swap_cluster_info *ci;
>         unsigned int offset =3D SWAP_ENTRY_INVALID, found =3D SWAP_ENTRY_=
INVALID;
> @@ -895,32 +907,38 @@ static unsigned long cluster_alloc_swap_entry(struc=
t swap_info_struct *si, int o
>         if (order && !(si->flags & SWP_BLKDEV))
>                 return 0;
>
> -       if (!(si->flags & SWP_SOLIDSTATE)) {
> +       if (si->flags & SWP_SOLIDSTATE) {
> +#ifdef CONFIG_SWAP_CGROUP_PRIORITY
> +                local_lock(&si->percpu_cluster->lock);
> +                offset =3D __this_cpu_read(si->percpu_cluster->next[orde=
r]);
> +#endif
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
> +                                               order, usage, is_cgroup_p=
riority);
> +       } else {
> +               unlock_cluster(ci);
>         }
> +       if (found)
> +               goto done;
>
>  new_cluster:
>         ci =3D isolate_lock_cluster(si, &si->free_clusters);
>         if (ci) {
>                 found =3D alloc_swap_scan_cluster(si, ci, cluster_offset(=
si, ci),
> -                                               order, usage);
> +                                               order, usage, is_cgroup_p=
riority);
>                 if (found)
>                         goto done;
>         }
> @@ -934,7 +952,7 @@ static unsigned long cluster_alloc_swap_entry(struct =
swap_info_struct *si, int o
>
>                 while ((ci =3D isolate_lock_cluster(si, &si->nonfull_clus=
ters[order]))) {
>                         found =3D alloc_swap_scan_cluster(si, ci, cluster=
_offset(si, ci),
> -                                                       order, usage);
> +                                                       order, usage, is_=
cgroup_priority);
>                         if (found)
>                                 goto done;
>                         /* Clusters failed to allocate are moved to frag_=
clusters */
> @@ -952,7 +970,7 @@ static unsigned long cluster_alloc_swap_entry(struct =
swap_info_struct *si, int o
>                          * reclaimable (eg. lazy-freed swap cache) slots.
>                          */
>                         found =3D alloc_swap_scan_cluster(si, ci, cluster=
_offset(si, ci),
> -                                                       order, usage);
> +                                                       order, usage, is_=
cgroup_priority);
>                         if (found)
>                                 goto done;
>                         frags++;
> @@ -979,21 +997,27 @@ static unsigned long cluster_alloc_swap_entry(struc=
t swap_info_struct *si, int o
>                 while ((ci =3D isolate_lock_cluster(si, &si->frag_cluster=
s[o]))) {
>                         atomic_long_dec(&si->frag_cluster_nr[o]);
>                         found =3D alloc_swap_scan_cluster(si, ci, cluster=
_offset(si, ci),
> -                                                       0, usage);
> +                                                       0, usage, is_cgro=
up_priority);
>                         if (found)
>                                 goto done;
>                 }
>
>                 while ((ci =3D isolate_lock_cluster(si, &si->nonfull_clus=
ters[o]))) {
>                         found =3D alloc_swap_scan_cluster(si, ci, cluster=
_offset(si, ci),
> -                                                       0, usage);
> +                                                       0, usage, is_cgro=
up_priority);
>                         if (found)
>                                 goto done;
>                 }
>         }
>  done:
> -       if (!(si->flags & SWP_SOLIDSTATE))
> +       if (si->flags & SWP_SOLIDSTATE) {
> +#ifdef CONFIG_SWAP_CGROUP_PRIORITY
> +               local_unlock(&si->percpu_cluster->lock);
> +#endif
> +       } else {
>                 spin_unlock(&si->global_cluster_lock);
> +       }
> +
>         return found;
>  }
>
> @@ -1032,6 +1056,7 @@ static void del_from_avail_list(struct swap_info_st=
ruct *si, bool swapoff)
>         for_each_node(nid)
>                 plist_del(&si->avail_lists[nid], &swap_avail_heads[nid]);
>
> +       deactivate_swap_cgroup_priority_pnode(si, swapoff);
>  skip:
>         spin_unlock(&swap_avail_lock);
>  }
> @@ -1075,6 +1100,7 @@ static void add_to_avail_list(struct swap_info_stru=
ct *si, bool swapon)
>         for_each_node(nid)
>                 plist_add(&si->avail_lists[nid], &swap_avail_heads[nid]);
>
> +       activate_swap_cgroup_priority_pnode(si, swapon);
>  skip:
>         spin_unlock(&swap_avail_lock);
>  }
> @@ -1200,7 +1226,8 @@ static bool swap_alloc_fast(swp_entry_t *entry,
>         if (cluster_is_usable(ci, order)) {
>                 if (cluster_is_empty(ci))
>                         offset =3D cluster_offset(si, ci);
> -               found =3D alloc_swap_scan_cluster(si, ci, offset, order, =
SWAP_HAS_CACHE);
> +               found =3D alloc_swap_scan_cluster(si, ci, offset, order,
> +                               SWAP_HAS_CACHE, false);
>                 if (found)
>                         *entry =3D swp_entry(si->type, found);
>         } else {
> @@ -1227,7 +1254,7 @@ static bool swap_alloc_slow(swp_entry_t *entry,
>                 plist_requeue(&si->avail_lists[node], &swap_avail_heads[n=
ode]);
>                 spin_unlock(&swap_avail_lock);
>                 if (get_swap_device_info(si)) {
> -                       offset =3D cluster_alloc_swap_entry(si, order, SW=
AP_HAS_CACHE);
> +                       offset =3D cluster_alloc_swap_entry(si, order, SW=
AP_HAS_CACHE, false);
>                         put_swap_device(si);
>                         if (offset) {
>                                 *entry =3D swp_entry(si->type, offset);
> @@ -1294,10 +1321,12 @@ int folio_alloc_swap(struct folio *folio, gfp_t g=
fp)
>                 }
>         }
>
> -       local_lock(&percpu_swap_cluster.lock);
> -       if (!swap_alloc_fast(&entry, order))
> -               swap_alloc_slow(&entry, order);
> -       local_unlock(&percpu_swap_cluster.lock);
> +       if (!swap_alloc_cgroup_priority(folio_memcg(folio), &entry, order=
)) {
> +               local_lock(&percpu_swap_cluster.lock);
> +               if (!swap_alloc_fast(&entry, order))
> +                       swap_alloc_slow(&entry, order);
> +               local_unlock(&percpu_swap_cluster.lock);
> +       }
>
>         /* Need to call this even if allocation failed, for MEMCG_SWAP_FA=
IL. */
>         if (mem_cgroup_try_charge_swap(folio, entry))
> @@ -1870,7 +1899,7 @@ swp_entry_t get_swap_page_of_type(int type)
>         /* This is called for allocating swap entry, not cache */
>         if (get_swap_device_info(si)) {
>                 if (si->flags & SWP_WRITEOK) {
> -                       offset =3D cluster_alloc_swap_entry(si, 0, 1);
> +                       offset =3D cluster_alloc_swap_entry(si, 0, 1, fal=
se);
>                         if (offset) {
>                                 entry =3D swp_entry(si->type, offset);
>                                 atomic_long_dec(&nr_swap_pages);
> @@ -2800,6 +2829,10 @@ SYSCALL_DEFINE1(swapoff, const char __user *, spec=
ialfile)
>         arch_swap_invalidate_area(p->type);
>         zswap_swapoff(p->type);
>         mutex_unlock(&swapon_mutex);
> +#ifdef CONFIG_SWAP_CGROUP_PRIORITY
> +       free_percpu(p->percpu_cluster);
> +       p->percpu_cluster =3D NULL;
> +#endif
>         kfree(p->global_cluster);
>         p->global_cluster =3D NULL;
>         vfree(swap_map);
> @@ -3207,7 +3240,23 @@ static struct swap_cluster_info *setup_clusters(st=
ruct swap_info_struct *si,
>         for (i =3D 0; i < nr_clusters; i++)
>                 spin_lock_init(&cluster_info[i].lock);
>
> -       if (!(si->flags & SWP_SOLIDSTATE)) {
> +       if (si->flags & SWP_SOLIDSTATE) {
> +#ifdef CONFIG_SWAP_CGROUP_PRIORITY
> +               si->percpu_cluster =3D alloc_percpu(struct percpu_cluster=
);
> +               if (!si->percpu_cluster)
> +                       goto err_free;
> +
> +               int cpu;
> +               for_each_possible_cpu(cpu) {
> +                       struct percpu_cluster *cluster;
> +
> +                       cluster =3D per_cpu_ptr(si->percpu_cluster, cpu);
> +                       for (i =3D 0; i < SWAP_NR_ORDERS; i++)
> +                               cluster->next[i] =3D SWAP_ENTRY_INVALID;
> +                       local_lock_init(&cluster->lock);
> +               }
> +#endif
> +       } else {
>                 si->global_cluster =3D kmalloc(sizeof(*si->global_cluster=
),
>                                      GFP_KERNEL);
>                 if (!si->global_cluster)
> @@ -3495,6 +3544,10 @@ SYSCALL_DEFINE2(swapon, const char __user *, speci=
alfile, int, swap_flags)
>  bad_swap_unlock_inode:
>         inode_unlock(inode);
>  bad_swap:
> +#ifdef CONFIG_SWAP_CGROUP_PRIORITY
> +       free_percpu(si->percpu_cluster);
> +       si->percpu_cluster =3D NULL;
> +#endif
>         kfree(si->global_cluster);
>         si->global_cluster =3D NULL;
>         inode =3D NULL;
> --
> 2.34.1
>
>

