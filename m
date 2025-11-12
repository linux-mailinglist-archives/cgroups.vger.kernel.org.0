Return-Path: <cgroups+bounces-11868-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D10BC52ACE
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 15:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C511234DE62
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 14:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506E332F768;
	Wed, 12 Nov 2025 14:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVVAz37E"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC3A30ACED
	for <cgroups@vger.kernel.org>; Wed, 12 Nov 2025 14:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762957237; cv=none; b=lTcKyE1k70XGE9r2fBpG03Vs3NJVMg9YK9lJX8+XAQUumGoWI+dXzx8eSvqw29Lb7hAA/2W6bvHnaTzb1WQNgnF2VVK0nILbH+eVcT57fD2PT2HU8gWgiVgwG3ArLNqN7SvdSJuLIqdgc/VwfnnBb0dFN1dib42aRvO8ys+csLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762957237; c=relaxed/simple;
	bh=VwaEPZFkxSfRUxExkhnjtFO7e5XEZouYM5kTfIq26eM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GzVyX8ZRNgT5qPZM0bHxg4QnpJcZuI/IU5CTjYue/0DoEG1AXS6yfioQ6SHs6zE3nasFVzdVeTqL4ZFe3TBwAMD2hcFfJBQQYc0PuLNfIq5BlnenBOy6uogRDww2plMNQc8oOVdIf/IfxJ2Ly8hlBrJPwsmPq3fLDJAf4OKHX8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVVAz37E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B21C4CEF1
	for <cgroups@vger.kernel.org>; Wed, 12 Nov 2025 14:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762957236;
	bh=VwaEPZFkxSfRUxExkhnjtFO7e5XEZouYM5kTfIq26eM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cVVAz37E+F4wPJqBJkXaVm9z/nbbDFPMtG4xb3RKT/Din1Ou1j6H6f8nAhO12vAAy
	 6BtLJCLoRchFRgSLWvRg7Z/nymQ4g6gMYA08Pudi7KA2VlW8lTF6ehHWeGodSUf35y
	 Nrf/fL3+UcjtmvfP1hBad7rybd4whCQJJXxDFU8Ow07sDsPHxf58jfuKzPoEiYzJ0S
	 xtM9uxQCLa7yY19asePtg+VWGsKW+IP1Lehup8Z+JsCp2qYOTfs0IDD4kZLPskZWux
	 9BITHlS1sY4msikZXgCKcx/yWnZugbre7MD3BgQo6RPNHLD+VJCvXr0/M9Dn2Damwa
	 hd4ffoPG641EQ==
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42b3ac40ae4so461716f8f.0
        for <cgroups@vger.kernel.org>; Wed, 12 Nov 2025 06:20:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXMLOGqIUfAjp/rBGX1Gz1PY7pNdYStLrF4DbBzl8sNpIrfeucEds6HfJGCwuRZ2wwQnC8Qfwy7@vger.kernel.org
X-Gm-Message-State: AOJu0YzAliI/dfBi2jfaVY/aplns7yBZhgSN6JluU6lqYu01Rcz4JnwC
	qlyuxsfnSQlSPHfqq2cOio5cC9Epo3hQmal60Njd66ozyi8cjh7cuPishds1aygkf+u8Zg2d/AX
	jo5gfEppHqgr0HqolNaQ9dRO0Omzqd94em98Z5ba8OA==
X-Google-Smtp-Source: AGHT+IG7ZvomWjJBJSZh8OCjBjvHIfE/CWQsf/lWNVCvFf1RWZm1wQ29zt1EGRnB0snCXwzU/IxO732p8j8bibV2xcw=
X-Received: by 2002:a05:6000:230f:b0:42b:3272:c4d7 with SMTP id
 ffacd0b85a97d-42b4bdd57c3mr2671533f8f.61.1762957235018; Wed, 12 Nov 2025
 06:20:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109124947.1101520-1-youngjun.park@lge.com> <20251109124947.1101520-3-youngjun.park@lge.com>
In-Reply-To: <20251109124947.1101520-3-youngjun.park@lge.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 12 Nov 2025 06:20:22 -0800
X-Gmail-Original-Message-ID: <CACePvbUvDfZgDx-sXkZ+Oa7DwtKg6b1t=owQ1sRZ_FpFrGxA3g@mail.gmail.com>
X-Gm-Features: AWmQ_bkRhrtPlH_G1yJEjA6WRfKAEvHTgkMv1h2pxRyTdK3n9S7XVdMGxrV5gaA
Message-ID: <CACePvbUvDfZgDx-sXkZ+Oa7DwtKg6b1t=owQ1sRZ_FpFrGxA3g@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm: swap: introduce swap tier infrastructure
To: Youngjun Park <youngjun.park@lge.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kasong@tencent.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	muchun.song@linux.dev, shikemeng@huaweicloud.com, nphamcs@gmail.com, 
	bhe@redhat.com, baohua@kernel.org, gunho.lee@lge.com, taejoon.song@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

First of all, for RFC series, please include RFC in each patch subject as w=
ell.

For the real patch submission, please consider split it into smaller
chunks and have incremental milestones.
Only introduce the function needed for each milestone, not define them
all together then use it in later patches.

See some feedback as follows.

This patch is too big, to be continued.

Chris

On Sun, Nov 9, 2025 at 4:50=E2=80=AFAM Youngjun Park <youngjun.park@lge.com=
> wrote:
>
> Swap tier groups swap devices by priority ranges.
> This allows different memory groups to use different swap devices.
>
> Swap tiers are identified by names and configured with priority ranges.
> Two special tiers are built-in: default (no name) tier and "zswap" tier.
>
> Interface:
> * /sys/kernel/mm/swap/tiers
> - Write:
> - Add format: "+ tierName:prio,tierName2:prio..."
> - Example: echo "+ SSD:100,HDD:-1" > /sys/kernel/mm/swap/tiers
> - Remove format: "- tierName,tierName2..."
> - Example: echo "- SSD,HDD" > /sys/kernel/mm/swap/tiers
> - Priority ranges merge when no cgroup references exist
> - Minimum priority becomes -1 when tiers are configured above -1
> - Read:
> - Format: "Name             Idx   PrioStart   PrioEnd"
> - Shows configured tiers with their priority ranges
>
> * /sys/fs/cgroup/*/memory.swap.tiers
> - Read: Shows written operations and final merged result
> - Write: Format "(+/-)tierName (+/-)tierName2..."
> - Example: echo "+ +SSD -HDD" > memory.swap.tier
> - Override semantics (echo "" clears all settings)
> - + enables tier, - disables tier
> - No prefix inherits parent settings
> - +/- alone affects all tiers (+ enables all, - disables all)
> - Root cgroup defaults to "+" (all swap devices enabled)
>
> Special tiers:
> - "" (default): for inheritance
> - "zswap": for zswap integration
>
> Suggested-by: Chris Li <chrisl@kernel.org>
> Signed-off-by: Youngjun Park <youngjun.park@lge.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst |  32 ++
>  MAINTAINERS                             |   2 +
>  include/linux/memcontrol.h              |   4 +
>  include/linux/swap.h                    |   3 +
>  mm/Kconfig                              |  13 +
>  mm/Makefile                             |   1 +
>  mm/swap.h                               |   4 +
>  mm/swap_tier.c                          | 602 ++++++++++++++++++++++++
>  mm/swap_tier.h                          |  75 +++
>  mm/swapfile.c                           |   5 +-
>  10 files changed, 738 insertions(+), 3 deletions(-)
>  create mode 100644 mm/swap_tier.c
>  create mode 100644 mm/swap_tier.h
>
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admi=
n-guide/cgroup-v2.rst
> index 3345961c30ac..ed8ef33b4d6a 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1850,6 +1850,38 @@ The following nested keys are defined.
>         Swap usage hard limit.  If a cgroup's swap usage reaches this
>         limit, anonymous memory of the cgroup will not be swapped out.
>
> +  memory.swap.tiers
> +        A read-write nested-keyed file which exists on non-root
> +        cgroups. The default is empty (inherits from parent).
> +
> +        This interface allows selecting which swap tiers a cgroup can
> +        use for swapping out memory.
> +
> +        When read, the file shows two lines:
> +          - The first line shows the operation string that was
> +            written to this file.
> +          - The second line shows the effective operation after
> +            merging with parent settings.
> +
> +        When writing, the format is:
> +          (+/-)(TIER_NAME) (+/-)(TIER_NAME) ...
> +
> +        Valid tier names are those configured in
> +        /sys/kernel/mm/swap/tiers.
> +
> +        Each tier can be prefixed with:
> +          +    Enable this tier (always on)
> +          -     Disable this tier (always off)
> +          none  Inherit from parent (incremental merge)
> +
> +        Special default tier operations (+ or - without tier name):
> +          +    Ignore parent settings, enable all swap tiers, then
> +                apply subsequent operations
> +          -     Ignore parent settings, disable all swap tiers, then
> +                apply subsequent operations
> +          none  Inherit all tier settings from parent, then apply
> +                subsequent operations incrementally
> +
>    memory.swap.events
>         A read-only flat-keyed file which exists on non-root cgroups.
>         The following entries are defined.  Unless specified
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fa519cbc4b88..3416d466d011 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16517,6 +16517,8 @@ F:      mm/swap.c
>  F:     mm/swap.h
>  F:     mm/swap_table.h
>  F:     mm/swap_state.c
> +F:     mm/swap_tier.c
> +F      mm/swap_tier.h
>  F:     mm/swapfile.c
>
>  MEMORY MANAGEMENT - THP (TRANSPARENT HUGE PAGE)
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 966f7c1a0128..1224029620ed 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -283,6 +283,10 @@ struct mem_cgroup {
>         /* per-memcg mm_struct list */
>         struct lru_gen_mm_list mm_list;
>  #endif
> +#ifdef CONFIG_SWAP_TIER

I think we don't need this CONFIG_SWAP_TIER. Making it part of the
default swap is fine.
By default the memory.swap.tiers is empty and matches the previous
swap behavior. The user doesn't need to do anything if they are not
using swap tiers. I see no reason to have a separate config option.

> +       int tiers_onoff;
> +       int tiers_mask;
> +#endif
>
>  #ifdef CONFIG_MEMCG_V1
>         /* Legacy consumer-oriented counters */
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 90fa27bb7796..8911eff9d37a 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -271,6 +271,9 @@ struct swap_info_struct {
>         struct percpu_ref users;        /* indicate and keep swap device =
valid. */
>         unsigned long   flags;          /* SWP_USED etc: see above */
>         signed short    prio;           /* swap priority of this type */
> +#ifdef CONFIG_SWAP_TIER
> +       int tier_idx;
> +#endif
>         struct plist_node list;         /* entry in swap_active_head */
>         signed char     type;           /* strange name for an index */
>         unsigned int    max;            /* extent of the swap_map */
> diff --git a/mm/Kconfig b/mm/Kconfig
> index e1fb11f36ede..78173ffe65d6 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -163,6 +163,19 @@ endmenu
>
>  endif
>
> +config SWAP_TIER
Same, I think we can remove the SWAP_TIER, just turn it on when swap is ena=
bled.

> +       default n
> +       bool "Swap tier"
> +       depends on SWAP && MEMCG && SYSFS
> +       help
> +          Swap tier is a concept proposed to group swap devices by
> +          priority ranges, allowing cgroups to select and use a desired
> +          swap_tier. This enables more flexible control over swap usage
> +          across different workloads.
> +          It is possible to assign a name for identifying a swap tier,
> +          and to configure the priority range used for selecting swap
> +          devices within that tier.
> +
>  menu "Slab allocator options"
>
>  config SLUB
> diff --git a/mm/Makefile b/mm/Makefile
> index 00ceb2418b64..9e98799f2edf 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -76,6 +76,7 @@ ifdef CONFIG_MMU
>  endif
>
>  obj-$(CONFIG_SWAP)     +=3D page_io.o swap_state.o swapfile.o
> +obj-$(CONFIG_SWAP_TIER)        +=3D swap_tier.o
>  obj-$(CONFIG_ZSWAP)    +=3D zswap.o
>  obj-$(CONFIG_HAS_DMA)  +=3D dmapool.o
>  obj-$(CONFIG_HUGETLBFS)        +=3D hugetlb.o hugetlb_sysfs.o hugetlb_sy=
sctl.o
> diff --git a/mm/swap.h b/mm/swap.h
> index d034c13d8dd2..b116282690c8 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -16,6 +16,10 @@ extern int page_cluster;
>  #define swap_entry_order(order)        0
>  #endif
>
> +#define DEF_SWAP_PRIO  -1
> +
> +extern spinlock_t swap_lock;
> +extern struct plist_head swap_active_head;
>  extern struct swap_info_struct *swap_info[];
>
>  /*
> diff --git a/mm/swap_tier.c b/mm/swap_tier.c
> new file mode 100644
> index 000000000000..4301e3c766b9
> --- /dev/null
> +++ b/mm/swap_tier.c
> @@ -0,0 +1,602 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/swap.h>
> +#include <linux/rcupdate.h>
> +#include <linux/memcontrol.h>
> +#include <linux/plist.h>
> +#include <linux/sysfs.h>
> +#include <linux/sort.h>
> +
> +#include "swap_tier.h"
> +
> +/*
> + * struct swap_tier - Structure representing a swap tier.
> + *
> + * @name:              Name of the swap_tier.
> + * @prio_st:           Starting value of priority.
> + * @prio_end:          Ending value of priority.
> + * @list:              Linked list of active tiers.
> + * @inactive_list:     Linked list of inactive tiers.
> + * @kref:              Reference count (held by swap device and memory c=
group).
> + */
> +static struct swap_tier {
> +       char name[MAX_TIERNAME];
> +       short prio_st;
> +       short prio_end;

I see a lot of complexity of the code come from this priority range.
Having both start and end.
We should be able to just keep just one of the start and end,  e.g.
high end of the priority, then keep all tier in a sorted list or
array. Then use the next tier's priority to indicate the other end of
the current tier.

> +       union {
> +               struct plist_node list;
> +               struct list_head inactive_list;
> +       };

Is this the list of swapfiles?
Why union, how does it indicate which field of the union is valid?

> +       struct kref ref;
> +} swap_tiers[MAX_SWAPTIER];
> +
> +static DEFINE_SPINLOCK(swap_tier_lock);
> +
> +/* Active swap priority list, reserved tier first, sorted in descending =
order */
> +static PLIST_HEAD(swap_tier_active_list);
> +/* Unused swap_tier object */
> +static LIST_HEAD(swap_tier_inactive_list);
> +
> +#define TIER_IDX(tier) ((tier) - swap_tiers)
> +
> +#define for_each_active_tier(tier) \
> +       plist_for_each_entry(tier, &swap_tier_active_list, list)
> +
> +#define for_each_tier(tier, idx) \
> +       for (idx =3D 0, tier =3D &swap_tiers[0]; idx < MAX_SWAPTIER; \
> +               idx++, tier =3D &swap_tiers[idx])
> +
> +static int nr_swaptiers =3D SWAP_TIER_RESERVED_CNT;
> +
> +#define SKIP_REPLACE_IDX       -1
> +#define NULL_TIER               -1
> +
> +/*
> + * Naming Convention:
> + *   swap_tiers_*() - Public/exported functions
> + *   swap_tier_*()  - Private/internal functions
> + */
> +
> +static bool swap_tier_replace_marked(int idx)
> +{
> +       return idx !=3D SKIP_REPLACE_IDX;
> +}
> +
> +static bool swap_tier_is_active(void)
> +{
> +       return nr_swaptiers > SWAP_TIER_RESERVED_CNT;
> +}
> +
> +static bool swap_tier_prio_in_range(struct swap_tier *tier, short prio)
> +{
> +       if (tier->prio_st <=3D prio && tier->prio_end >=3D prio)
> +               return true;
> +
> +       return false;
> +}
> +
> +/* swap_tiers initialization */
> +void swap_tiers_init(void)
> +{
> +       struct swap_tier *tier;
> +       int idx;
> +
> +       BUILD_BUG_ON(BITS_PER_TYPE(int) < MAX_SWAPTIER * 2);
> +
> +       for_each_tier(tier, idx) {
> +               if (idx < SWAP_TIER_RESERVED_CNT) {
> +                       /* for display fisrt */
> +                       plist_node_init(&tier->list, -SHRT_MAX);
> +                       plist_add(&tier->list, &swap_tier_active_list);
> +                       kref_init(&tier->ref);
> +               } else {
> +                       INIT_LIST_HEAD(&tier->inactive_list);
> +                       list_add_tail(&tier->inactive_list, &swap_tier_in=
active_list);
> +               }
> +       }
> +
> +       strscpy(swap_tiers[SWAP_TIER_DEFAULT].name, DEFAULT_TIER_NAME);

The default tier is not a real tier. It shouldn't show up in the
swap_tiers array.
The default tier is only a wide cast for memory.swap.tiers to select
tiers to turn on/off swap tiers. It is a wide cast pattern, not an
actual tier.

> +#ifdef CONFIG_ZSWAP
> +       strscpy(swap_tiers[SWAP_TIER_ZSWAP].name, ZSWAP_TIER_NAME);
> +#endif
> +}
> +
> +static bool swap_tier_alive(struct swap_tier *tier)
> +{
> +       lockdep_assert_held(&swap_tier_lock);
> +       return (kref_read(&tier->ref) > 1) ? true : false;
> +}
> +
> +static void swap_tier_get(struct swap_tier *tier)
> +{
> +       lockdep_assert_held(&swap_tier_lock);
> +       kref_get(&tier->ref);
> +}
> +
> +static void swap_tier_remove(struct swap_tier *tier);
> +static void swap_tier_release(struct kref *ref)
> +{
> +       struct swap_tier *tier =3D container_of(ref, struct swap_tier, re=
f);
> +
> +       swap_tier_remove(tier);
> +}
> +
> +static void swap_tier_put(struct swap_tier *tier)
> +{
> +       lockdep_assert_held(&swap_tier_lock);
> +       kref_put(&tier->ref, swap_tier_release);
> +}
> +
> +static int swap_tier_cmp(const void *p, const void *p2)
> +{
> +       const struct tiers_desc *tp =3D p;
> +       const struct tiers_desc *tp2 =3D p2;
> +
> +       return tp2->prio_st - tp->prio_st;
> +}
> +
> +static void swap_tier_get_mask(int mask)
> +{
> +       struct swap_tier *tier;
> +
> +       lockdep_assert_held(&swap_tier_lock);
> +
> +       for_each_active_tier(tier) {
> +               int tier_mask =3D TIER_MASK(TIER_IDX(tier), TIER_FULL_MAS=
K);
> +
> +               if (mask & tier_mask)
> +                       swap_tier_get(tier);
> +       }
> +}
> +
> +static void swap_tier_put_mask(int mask)
> +{
> +       struct swap_tier *tier;
> +
> +       lockdep_assert_held(&swap_tier_lock);
> +
> +       for_each_active_tier(tier) {
> +               int tier_mask =3D TIER_MASK(TIER_IDX(tier), TIER_FULL_MAS=
K);
> +
> +               if (mask & tier_mask)
> +                       swap_tier_put(tier);
> +       }
> +}
> +
> +static bool swap_tier_is_default(struct swap_tier *tier)
> +{
> +       int idx =3D TIER_IDX(tier);
> +
> +       return idx < SWAP_TIER_RESERVED_CNT ? true : false;
> +}
> +
> +/*
> + * Check if tier priority range can be split. If input falls within a
> + * referenced range, splitting is not allowed and an error is returned.
> + * If priority start is the same but tier has no reference, mark
> + * SKIP_REPLACE_IDX to allow replacement at apply time.
> + */
> +static int swap_tier_can_split_range(struct tiers_desc *desc)
> +{
> +       struct swap_tier *tier;
> +       int ret =3D 0;
> +
> +       lockdep_assert_held(&swap_tier_lock);
> +       desc->tier_idx =3D SKIP_REPLACE_IDX;
> +
> +       for_each_active_tier(tier) {
> +               if (swap_tier_is_default(tier))
> +                       continue;
> +
> +               if (tier->prio_st > desc->prio_st)
> +                       continue;
> +
> +               /* If start priorities match, replace tier name */
> +               if (tier->prio_st =3D=3D desc->prio_st)
> +                       desc->tier_idx =3D TIER_IDX(tier);
> +
> +               if (swap_tier_alive(tier))
> +                       ret =3D -EBUSY;
> +
> +               break;
> +       }
> +
> +       return ret;
> +}
> +
> +static void swap_tier_prepare(struct tiers_desc *desc)
> +{
> +       struct swap_tier *tier;
> +
> +       lockdep_assert_held(&swap_tier_lock);
> +
> +       if (WARN_ON(list_empty(&swap_tier_inactive_list)))
> +               return;
> +
> +       if (swap_tier_replace_marked(desc->tier_idx))
> +               return;
> +
> +       tier =3D list_first_entry(&swap_tier_inactive_list,
> +               struct swap_tier, inactive_list);
> +
> +       list_del(&tier->inactive_list);
> +       strscpy(tier->name, desc->name, MAX_TIERNAME);
> +       tier->prio_st =3D desc->prio_st;
> +       plist_node_init(&tier->list, -tier->prio_st);
> +       kref_init(&tier->ref);
> +
> +       plist_add(&tier->list, &swap_tier_active_list);
> +       nr_swaptiers++;
> +}
> +
> +static void swap_tier_apply(struct tiers_desc *desc, int nr)
> +{
> +       struct plist_node *pnode;
> +       struct swap_info_struct *p =3D NULL;
> +       struct swap_tier *tier;
> +       int prio_end =3D SHRT_MAX;
> +
> +       lockdep_assert_held(&swap_lock);
> +       lockdep_assert_held(&swap_tier_lock);
> +
> +       for (int i =3D 0; i < nr; i++) {
> +               int idx =3D desc[i].tier_idx;
> +
> +               if (swap_tier_replace_marked(idx))
> +                       strscpy(swap_tiers[idx].name, desc[i].name, MAX_T=
IERNAME);
> +       }
> +
> +       for_each_active_tier(tier) {
> +               if (swap_tier_is_default(tier))
> +                       continue;
> +
> +               tier->prio_end =3D prio_end;
> +               prio_end =3D tier->prio_st - 1;
> +       }
> +
> +       /* TODO: use swapfiles ?*/
> +       if (plist_head_empty(&swap_active_head))
> +               return;
> +
> +       for_each_active_tier(tier) {
> +               plist_for_each_continue(pnode, &swap_active_head) {
> +                       p =3D container_of(pnode, struct swap_info_struct=
, list);
> +                       if (p->tier_idx !=3D NULL_TIER)
> +                               continue;
> +                       if (!swap_tier_prio_in_range(tier, p->prio))
> +                               break;
> +                       swap_tier_get(tier);
> +               }
> +       }
> +}
> +
> +int swap_tiers_add(struct tiers_desc desc[], int nr)
> +{
> +       struct swap_tier *tier;
> +       int ret =3D 0;
> +
> +       if (nr <=3D 0)
> +               return -EINVAL;
> +
> +       sort(desc, nr, sizeof(desc[0]), swap_tier_cmp, NULL);
> +
> +       for (int i =3D 0; i < nr; i++) {
> +               if (i > 0 && desc[i].prio_st =3D=3D desc[i-1].prio_st)
> +                       return -EINVAL;
> +
> +               for (int j =3D i+1; j < nr; j++) {
> +                       if (!strcmp(desc[i].name, desc[j].name))
> +                               return -EINVAL;
> +               }
> +
> +               for_each_active_tier(tier) {
> +                       if (!strcmp(desc[i].name, tier->name))
> +                               return -EALREADY;
> +               }
> +       }
> +
> +       spin_lock(&swap_lock);
> +       spin_lock(&swap_tier_lock);
> +
> +       /* Tier set must cover all priorities */
> +       if (!swap_tier_is_active() && desc[nr-1].prio_st !=3D DEF_SWAP_PR=
IO)
> +               desc[nr-1].prio_st =3D DEF_SWAP_PRIO;
> +
> +       if (nr + nr_swaptiers > MAX_SWAPTIER) {
> +               ret =3D -ERANGE;
> +               goto out;
> +       }
> +
> +       for (int i =3D 0; i < nr; i++) {
> +               ret =3D swap_tier_can_split_range(&desc[i]);
> +               if (ret)
> +                       goto out;
> +       }
> +
> +       for (int i =3D 0; i < nr; i++)
> +               swap_tier_prepare(&desc[i]);
> +
> +       swap_tier_apply(desc, nr);
> +out:
> +       spin_unlock(&swap_tier_lock);
> +       spin_unlock(&swap_lock);
> +
> +       return ret;
> +}
> +
> +static void swap_tier_remove(struct swap_tier *tier)
> +{
> +       bool least_prio_merge =3D false;
> +       struct plist_node *next;
> +       struct swap_tier *merge_tier;
> +
> +       lockdep_assert_held(&swap_tier_lock);
> +
> +       if (tier->prio_st =3D=3D DEF_SWAP_PRIO) {
> +               least_prio_merge =3D true;
> +               next =3D plist_prev(&tier->list);
> +       } else
> +               next =3D plist_next(&tier->list);
> +
> +       plist_del(&tier->list, &swap_tier_active_list);
> +       INIT_LIST_HEAD(&tier->inactive_list);
> +       list_add_tail(&tier->inactive_list, &swap_tier_inactive_list);
> +       nr_swaptiers--;
> +
> +       if (nr_swaptiers =3D=3D SWAP_TIER_RESERVED_CNT)
> +               return;
> +
> +       merge_tier =3D container_of(next, struct swap_tier, list);
> +       /*
> +        * When the first tier is removed, the rule that all priorities
> +        * must be covered should be maintained. The next tier inherits t=
he
> +        * start value of the removed first tier.
> +        */
> +       if (least_prio_merge)
> +               merge_tier->prio_st =3D DEF_SWAP_PRIO;
> +       else
> +               merge_tier->prio_end =3D tier->prio_end;
> +}
> +
> +int swap_tiers_remove(struct tiers_desc desc[], int nr)
> +{
> +       int cnt =3D 0;
> +       int ret =3D 0;
> +       struct swap_tier *tier;
> +
> +       for (int i =3D 0; i < nr; i++) {
> +               for (int j =3D i+1; j < nr; j++) {
> +                       if (!strcmp(desc[i].name, desc[j].name))
> +                               return -EINVAL;
> +               }
> +       }
> +
> +       spin_lock(&swap_tier_lock);
> +       if (nr <=3D 0 || nr > nr_swaptiers) {
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       for (int i =3D 0; i < nr; i++) {
> +               for_each_active_tier(tier) {
> +                       if (swap_tier_is_default(tier))
> +                               continue;
> +
> +                       if (!strcmp(desc[i].name, tier->name)) {
> +                               if (swap_tier_alive(tier)) {
> +                                       ret =3D -EBUSY;
> +                                       goto out;
> +                               }
> +                               desc[i].tier_idx =3D TIER_IDX(tier);
> +                               cnt++;
> +                       }
> +               }
> +       }
> +
> +       if (cnt !=3D nr) {
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       for (int i =3D 0; i < nr; i++)
> +               swap_tier_put(&swap_tiers[desc[i].tier_idx]);
> +
> +out:
> +       spin_unlock(&swap_tier_lock);
> +       return ret;
> +}
> +
> +ssize_t swap_tiers_show_sysfs(char *buf)
> +{
> +       struct swap_tier *tier;
> +       ssize_t len =3D 0;
> +
> +       spin_lock(&swap_tier_lock);
> +       len +=3D sysfs_emit_at(buf, len, "%-16s %-5s %-11s %-11s\n",
> +                        "Name", "Idx", "PrioStart", "PrioEnd");
> +       for_each_active_tier(tier) {
> +               if (swap_tier_is_default(tier))
> +                       len +=3D sysfs_emit_at(buf, len, "%-16s %-5ld\n",
> +                                            tier->name,
> +                                            TIER_IDX(tier));
> +               else {
> +                       len +=3D sysfs_emit_at(buf, len, "%-16s %-5ld %-1=
1d %-11d\n",
> +                                            tier->name,
> +                                            TIER_IDX(tier),
> +                                            tier->prio_st,
> +                                            tier->prio_end);
> +               }
> +               if (len >=3D PAGE_SIZE)
> +                       break;
> +       }
> +       spin_unlock(&swap_tier_lock);
> +
> +       return len;
> +}
> +
> +static void swap_tier_show_mask(struct seq_file *m, int memcg_mask)
> +{
> +       struct swap_tier *tier;
> +       int idx;
> +
> +       for_each_active_tier(tier) {
> +               idx =3D TIER_IDX(tier);
> +               int tier_on_mask =3D TIER_MASK(idx, TIER_ON_MASK);
> +               int tier_off_mask =3D TIER_MASK(idx, TIER_OFF_MASK);
> +
> +               if (memcg_mask & tier_on_mask)
> +                       seq_printf(m, "+%s ", tier->name);
> +               else if (memcg_mask & tier_off_mask)
> +                       seq_printf(m, "-%s ", tier->name);
> +       }
> +       seq_puts(m, "\n");
> +}
> +
> +static bool swap_tier_has_default(int mask)
> +{
> +       return mask & DEFAULT_FULL_MASK;
> +}
> +
> +/*
> + * TODO: Simplify tier mask collection design if possible.
> + *
> + * Current approach uses two separate fields per cgroup:
> + *   - tiers_onoff: 2-bit per tier to indicate on/off state
> + *   - tiers_mask:  2-bit per tier to indicate if the tier is configured
> + *
> + * Trade-off to consider:
> + *   - Pre-compute at cgroup setup time (faster runtime, complex invalid=
ation)
> + *   - Keep runtime calculation (simpler, but repeated parent walks)
> + */
> +static int swap_tier_collect_mask(struct mem_cgroup *memcg)
> +{
> +       struct mem_cgroup *p;
> +       int onoff, mask, merge, new;
> +
> +       if (!memcg)
> +               return DEFAULT_ON_MASK;
> +
> +       onoff =3D memcg->tiers_onoff;
> +       mask =3D memcg->tiers_mask;
> +
> +       rcu_read_lock();
> +       for (p =3D parent_mem_cgroup(memcg); p && !swap_tier_has_default(=
onoff);
> +               p =3D parent_mem_cgroup(p)) {
> +               merge =3D mask | p->tiers_mask;
> +               new =3D merge ^ mask;
> +               onoff |=3D p->tiers_onoff & new;
> +               mask =3D merge;
> +       }
> +       rcu_read_unlock();
> +
> +       return onoff;
> +}
> +
> +int swap_tiers_collect_compare_mask(struct mem_cgroup *memcg)
> +{
> +       int onoff;
> +
> +       onoff =3D swap_tier_collect_mask(memcg);
> +
> +       /* Make common case fast */
> +       if (onoff & DEFAULT_ON_MASK)
> +               return onoff;
> +       /*
> +        * Root memcg has DEFAULT_ON_MASK; defaults are covered.
> +        * Checking DEFAULT_OFF_MASK suffices; only each tier's ON bit is=
 checked.
> +        * ON flag is inverted and compared with each swap device's OFF m=
ask.
> +        */
> +       return ~(onoff << 1);
> +}
> +
> +void swap_tiers_show_memcg(struct seq_file *m, struct mem_cgroup *memcg)
> +{
> +       spin_lock(&swap_tier_lock);
> +       if (memcg->tiers_onoff)
> +               swap_tier_show_mask(m, memcg->tiers_onoff);
> +       else
> +               seq_puts(m, "\n");
> +       swap_tier_show_mask(m, swap_tier_collect_mask(memcg));
> +       spin_unlock(&swap_tier_lock);
> +}
> +
> +void swap_tiers_assign(struct swap_info_struct *swp)
> +{
> +       struct swap_tier *tier;
> +
> +       spin_lock(&swap_tier_lock);
> +       swp->tier_idx =3D NULL_TIER;
> +
> +       for_each_active_tier(tier) {
> +               if (swap_tier_is_default(tier))
> +                       continue;
> +               if (swap_tier_prio_in_range(tier, swp->prio)) {
> +                       swp->tier_idx =3D TIER_IDX(tier);
> +                       swap_tier_get(tier);
> +                       break;
> +               }
> +       }
> +       spin_unlock(&swap_tier_lock);
> +}
> +
> +void swap_tiers_release(struct swap_info_struct *swp)
> +{
> +       spin_lock(&swap_tier_lock);
> +       if (swp->tier_idx !=3D NULL_TIER)
> +               swap_tier_put(&swap_tiers[swp->tier_idx]);
> +       spin_unlock(&swap_tier_lock);
> +}
> +
> +/* not incremental, but reset. */
> +int swap_tiers_get_mask(struct tiers_desc *desc, int nr, struct mem_cgro=
up *memcg)

Who is using this function? I can't find the user of this function in
this patch.
Please introduce this function together with the patch that uses it.
Don't introduce a function without a user.


> +{
> +       struct swap_tier *tier;
> +       int ret =3D 0;
> +       int tiers_mask =3D 0;
> +       int tiers_onoff =3D 0;
> +       int cnt =3D 0;
> +
> +       for (int i =3D 0; i < nr; i++) {
> +               for (int j =3D i+1; j < nr; j++) {
> +                       if (!strcmp(desc[i].name, desc[j].name))

These two nested for loops look suspicious. Again because I don't see
the caller, I can't reason what it is doing here.

Chris

> +                               return -EINVAL;
> +               }
> +       }
> +
> +       spin_lock(&swap_tier_lock);
> +       /* nr 0 is allowed for deletion */
> +       if (nr < 0 || nr > nr_swaptiers) {
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       for (int i =3D 0; i < nr; i++) {
> +               for_each_active_tier(tier) {
> +                       if (!strcmp(desc[i].name, tier->name)) {
> +                               tiers_mask |=3D TIER_MASK(TIER_IDX(tier),=
 TIER_FULL_MASK);
> +                               tiers_onoff |=3D TIER_MASK(TIER_IDX(tier)=
, desc[i].ops);
> +                               cnt++;
> +                               break;
> +                       }
> +               }
> +       }
> +
> +       if (cnt !=3D nr) {
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       swap_tier_put_mask(memcg->tiers_mask);
> +       swap_tier_get_mask(tiers_mask);
> +       memcg->tiers_mask =3D tiers_mask;
> +       memcg->tiers_onoff =3D tiers_onoff;
> +out:
> +       spin_unlock(&swap_tier_lock);
> +       return ret;
> +}
> +
> +void swap_tiers_put_mask(struct mem_cgroup *memcg)
> +{
> +       spin_lock(&swap_tier_lock);
> +       swap_tier_put_mask(memcg->tiers_mask);
> +       spin_unlock(&swap_tier_lock);
> +}
> diff --git a/mm/swap_tier.h b/mm/swap_tier.h
> new file mode 100644
> index 000000000000..f4b4e385638a
> --- /dev/null
> +++ b/mm/swap_tier.h
> @@ -0,0 +1,75 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _SWAP_TIER_H
> +#define _SWAP_TIER_H
> +
> +#include "swap.h"
> +#include <linux/memcontrol.h>
> +
> +#ifdef CONFIG_SWAP_TIER
> +
> +enum swap_tiers_index {
> +       SWAP_TIER_DEFAULT,
> +#ifdef CONFIG_ZSWAP
> +       SWAP_TIER_ZSWAP,
> +#endif
> +       SWAP_TIER_RESERVED_CNT,
> +};
> +
> +#define MAX_TIERNAME                   16
> +#define MAX_SWAPTIER                   12
> +
> +#define TIER_MASK(idx, mask)           ((mask) << (idx) * 2)
> +#define TIER_ON_MASK                   (1 << 0)
> +#define TIER_OFF_MASK                  (1 << 1)
> +#define TIER_FULL_MASK                 (TIER_ON_MASK | TIER_OFF_MASK)
> +
> +#define DEFAULT_ON_MASK                        TIER_MASK(SWAP_TIER_DEFAU=
LT, TIER_ON_MASK)
> +#define DEFAULT_OFF_MASK               TIER_MASK(SWAP_TIER_DEFAULT, TIER=
_OFF_MASK)
> +#define DEFAULT_FULL_MASK              (DEFAULT_ON_MASK | DEFAULT_OFF_MA=
SK)
> +
> +#define DEFAULT_TIER_NAME              ""
> +#define ZSWAP_TIER_NAME                        "ZSWAP"
> +
> +struct tiers_desc {
> +       char name[MAX_TIERNAME];
> +       union {
> +               signed short prio_st;
> +               signed short ops;
> +       };
> +       int tier_idx;
> +};
> +
> +void swap_tiers_init(void);
> +int swap_tiers_add(struct tiers_desc desc[], int nr);
> +int swap_tiers_remove(struct tiers_desc desc[], int nr);
> +ssize_t swap_tiers_show_sysfs(char *buf);
> +void swap_tiers_show_memcg(struct seq_file *m, struct mem_cgroup *memcg)=
;
> +void swap_tiers_assign(struct swap_info_struct *swp);
> +void swap_tiers_release(struct swap_info_struct *swp);
> +int swap_tiers_get_mask(struct tiers_desc *desc, int nr, struct mem_cgro=
up *memcg);
> +void swap_tiers_put_mask(struct mem_cgroup *memcg);
> +static inline bool swap_tiers_test_off(int tier_idx, int mask)
> +{
> +       return TIER_MASK(tier_idx, TIER_OFF_MASK) & mask;
> +}
> +int swap_tiers_collect_compare_mask(struct mem_cgroup *memcg);
> +#else
> +static inline void swap_tiers_init(void)
> +{
> +}
> +static inline void swap_tiers_assign(struct swap_info_struct *swp)
> +{
> +}
> +static inline void swap_tiers_release(struct swap_info_struct *swp)
> +{
> +}
> +static inline bool swap_tiers_test_off(int tier_off_mask, int mask)
> +{
> +       return false;
> +}
> +static inline int swap_tiers_collect_compare_mask(struct mem_cgroup *mem=
cg);
> +{
> +       return 0;
> +}
> +#endif
> +#endif
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 3bb77c9a4879..a5c90e419ff3 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -63,7 +63,7 @@ static void move_cluster(struct swap_info_struct *si,
>                          struct swap_cluster_info *ci, struct list_head *=
list,
>                          enum swap_cluster_flags new_flags);
>
> -static DEFINE_SPINLOCK(swap_lock);
> +DEFINE_SPINLOCK(swap_lock);
>  static unsigned int nr_swapfiles;
>  atomic_long_t nr_swap_pages;
>  /*
> @@ -74,7 +74,6 @@ atomic_long_t nr_swap_pages;
>  EXPORT_SYMBOL_GPL(nr_swap_pages);
>  /* protected with swap_lock. reading in vm_swap_full() doesn't need lock=
 */
>  long total_swap_pages;
> -#define DEF_SWAP_PRIO  -1
>  unsigned long swapfile_maximum_size;
>  #ifdef CONFIG_MIGRATION
>  bool swap_migration_ad_supported;
> @@ -89,7 +88,7 @@ static const char Unused_offset[] =3D "Unused swap offs=
et entry ";
>   * all active swap_info_structs
>   * protected with swap_lock, and ordered by priority.
>   */
> -static PLIST_HEAD(swap_active_head);
> +PLIST_HEAD(swap_active_head);
>
>  /*
>   * all available (active, not full) swap_info_structs
> --
> 2.34.1
>
>

