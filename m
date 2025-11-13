Return-Path: <cgroups+bounces-11907-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 41098C5566E
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 03:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B91F5347D39
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 02:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6266D2F49E5;
	Thu, 13 Nov 2025 02:16:39 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo03.lge.com (lgeamrelo03.lge.com [156.147.51.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4168C2F3C07
	for <cgroups@vger.kernel.org>; Thu, 13 Nov 2025 02:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763000199; cv=none; b=oHW3AQCMK8z79bdaqKPU2TSUpqcEhAd3NSxYhfGJGMFqtlPRaUtipe7IeTm3LALMvCWMNKehcUkHiEcwoY8PAMYcEl6+Ta3uBnLNnMfn57UI8SSET+1+KHFMrawmem00Sw0eq1Rd0wenJUVgTzk/665yM5iYMFwS3ACOUicLmxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763000199; c=relaxed/simple;
	bh=Bt1uXlZPw/nKh5/JP2JGfg9HYD7gdM8IVXfmkIuY4OM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NBfgQA+ShHTzIe8ejuADgIlHjCQNc1DFFGe2EZVr6erGN3y+TSuDhJp3iOLh0dojxdS32rAzOqgUDSeqFDeJOZKej2I5qVbHdKv49jriGiKgeqkTS6RgZy66o4TGcSavrGChGYwz6PseVAab67goz/IGstJXuNBsr3in3IooODs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.102 with ESMTP; 13 Nov 2025 11:01:34 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Thu, 13 Nov 2025 11:01:34 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: Chris Li <chrisl@kernel.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, kasong@tencent.com,
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev,
	shikemeng@huaweicloud.com, nphamcs@gmail.com, bhe@redhat.com,
	baohua@kernel.org, gunho.lee@lge.com, taejoon.song@lge.com
Subject: Re: [PATCH 2/3] mm: swap: introduce swap tier infrastructure
Message-ID: <aRU7/ibyrPTn93qV@yjaykim-PowerEdge-T330>
References: <20251109124947.1101520-1-youngjun.park@lge.com>
 <20251109124947.1101520-3-youngjun.park@lge.com>
 <CACePvbUvDfZgDx-sXkZ+Oa7DwtKg6b1t=owQ1sRZ_FpFrGxA3g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACePvbUvDfZgDx-sXkZ+Oa7DwtKg6b1t=owQ1sRZ_FpFrGxA3g@mail.gmail.com>

On Wed, Nov 12, 2025 at 06:20:22AM -0800, Chris Li wrote:
> First of all, for RFC series, please include RFC in each patch subject as well.
> 
> For the real patch submission, please consider split it into smaller
> chunks and have incremental milestones.
> Only introduce the function needed for each milestone, not define them
> all together then use it in later patches.
> 
> See some feedback as follows.
> 
> This patch is too big, to be continued.
> 
> Chris

Sure, I will take care of it. will make better on real patch submissions.

> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 966f7c1a0128..1224029620ed 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -283,6 +283,10 @@ struct mem_cgroup {
> >         /* per-memcg mm_struct list */
> >         struct lru_gen_mm_list mm_list;
> >  #endif
> > +#ifdef CONFIG_SWAP_TIER
> 
> I think we don't need this CONFIG_SWAP_TIER. Making it part of the
> default swap is fine.
> By default the memory.swap.tiers is empty and matches the previous
> swap behavior. The user doesn't need to do anything if they are not
> using swap tiers. I see no reason to have a separate config option.

Okay I will change it to default kernel option.

> > +       int tiers_onoff;
> > +       int tiers_mask;
> > +#endif
> >
> >  #ifdef CONFIG_MEMCG_V1
> >         /* Legacy consumer-oriented counters */
> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > index 90fa27bb7796..8911eff9d37a 100644
> > --- a/include/linux/swap.h
> > +++ b/include/linux/swap.h
> > @@ -271,6 +271,9 @@ struct swap_info_struct {
> >         struct percpu_ref users;        /* indicate and keep swap device valid. */
> >         unsigned long   flags;          /* SWP_USED etc: see above */
> >         signed short    prio;           /* swap priority of this type */
> > +#ifdef CONFIG_SWAP_TIER
> > +       int tier_idx;
> > +#endif
> >         struct plist_node list;         /* entry in swap_active_head */
> >         signed char     type;           /* strange name for an index */
> >         unsigned int    max;            /* extent of the swap_map */
> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index e1fb11f36ede..78173ffe65d6 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -163,6 +163,19 @@ endmenu
> >
> >  endif
> >
> > +config SWAP_TIER
> Same, I think we can remove the SWAP_TIER, just turn it on when swap is enabled.

Ack

> > diff --git a/mm/swap.h b/mm/swap.h
> > index d034c13d8dd2..b116282690c8 100644
> > --- a/mm/swap.h
> > +++ b/mm/swap.h
> > @@ -16,6 +16,10 @@ extern int page_cluster;
> >  #define swap_entry_order(order)        0
> >  #endif
> >
> > +#define DEF_SWAP_PRIO  -1
> > +
> > +extern spinlock_t swap_lock;
> > +extern struct plist_head swap_active_head;
> >  extern struct swap_info_struct *swap_info[];
> >
> >  /*
> > diff --git a/mm/swap_tier.c b/mm/swap_tier.c
> > new file mode 100644
> > index 000000000000..4301e3c766b9
> > --- /dev/null
> > +++ b/mm/swap_tier.c
> > @@ -0,0 +1,602 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <linux/swap.h>
> > +#include <linux/rcupdate.h>
> > +#include <linux/memcontrol.h>
> > +#include <linux/plist.h>
> > +#include <linux/sysfs.h>
> > +#include <linux/sort.h>
> > +
> > +#include "swap_tier.h"
> > +
> > +/*
> > + * struct swap_tier - Structure representing a swap tier.
> > + *
> > + * @name:              Name of the swap_tier.
> > + * @prio_st:           Starting value of priority.
> > + * @prio_end:          Ending value of priority.
> > + * @list:              Linked list of active tiers.
> > + * @inactive_list:     Linked list of inactive tiers.
> > + * @kref:              Reference count (held by swap device and memory cgroup).
> > + */
> > +static struct swap_tier {
> > +       char name[MAX_TIERNAME];
> > +       short prio_st;
> > +       short prio_end;
> 
> I see a lot of complexity of the code come from this priority range.
> Having both start and end.
> We should be able to just keep just one of the start and end,  e.g.
> high end of the priority, then keep all tier in a sorted list or
> array. Then use the next tier's priority to indicate the other end of
> the current tier.

After checking my code, I decide to remove st or end.

> > +       union {
> > +               struct plist_node list;
> > +               struct list_head inactive_list;
> > +       };
> 
> Is this the list of swapfiles?
> Why union, how does it indicate which field of the union is valid?

It is swap_tier itself. The 'list' maintains active tiers, and
'inactive_list' maintains inactive tiers. One tier exists on either
'list' or 'inactive_list'. The code ensures that a tier must be on one
of them.

> > +
> > +/* swap_tiers initialization */
> > +void swap_tiers_init(void)
> > +{
> > +       struct swap_tier *tier;
> > +       int idx;
> > +
> > +       BUILD_BUG_ON(BITS_PER_TYPE(int) < MAX_SWAPTIER * 2);
> > +
> > +       for_each_tier(tier, idx) {
> > +               if (idx < SWAP_TIER_RESERVED_CNT) {
> > +                       /* for display fisrt */
> > +                       plist_node_init(&tier->list, -SHRT_MAX);
> > +                       plist_add(&tier->list, &swap_tier_active_list);
> > +                       kref_init(&tier->ref);
> > +               } else {
> > +                       INIT_LIST_HEAD(&tier->inactive_list);
> > +                       list_add_tail(&tier->inactive_list, &swap_tier_inactive_list);
> > +               }
> > +       }
> > +
> > +       strscpy(swap_tiers[SWAP_TIER_DEFAULT].name, DEFAULT_TIER_NAME);
> 
> The default tier is not a real tier. It shouldn't show up in the
> swap_tiers array.
> The default tier is only a wide cast for memory.swap.tiers to select
> tiers to turn on/off swap tiers. It is a wide cast pattern, not an
> actual tier.

Yeah, as I commented in the previous mail, I will change it to a
logical concept.

> > +void swap_tiers_show_memcg(struct seq_file *m, struct mem_cgroup *memcg)
> > +{
> > +       spin_lock(&swap_tier_lock);
> > +       if (memcg->tiers_onoff)
> > +               swap_tier_show_mask(m, memcg->tiers_onoff);
> > +       else
> > +               seq_puts(m, "\n");
> > +       swap_tier_show_mask(m, swap_tier_collect_mask(memcg));
> > +       spin_unlock(&swap_tier_lock);
> > +}
> > +
> > +void swap_tiers_assign(struct swap_info_struct *swp)
> > +{
> > +       struct swap_tier *tier;
> > +
> > +       spin_lock(&swap_tier_lock);
> > +       swp->tier_idx = NULL_TIER;
> > +
> > +       for_each_active_tier(tier) {
> > +               if (swap_tier_is_default(tier))
> > +                       continue;
> > +               if (swap_tier_prio_in_range(tier, swp->prio)) {
> > +                       swp->tier_idx = TIER_IDX(tier);
> > +                       swap_tier_get(tier);
> > +                       break;
> > +               }
> > +       }
> > +       spin_unlock(&swap_tier_lock);
> > +}
> > +
> > +void swap_tiers_release(struct swap_info_struct *swp)
> > +{
> > +       spin_lock(&swap_tier_lock);
> > +       if (swp->tier_idx != NULL_TIER)
> > +               swap_tier_put(&swap_tiers[swp->tier_idx]);
> > +       spin_unlock(&swap_tier_lock);
> > +}
> > +
> > +/* not incremental, but reset. */
> > +int swap_tiers_get_mask(struct tiers_desc *desc, int nr, struct mem_cgroup *memcg)
> 
> Who is using this function? I can't find the user of this function in
> this patch.
> Please introduce this function together with the patch that uses it.
> Don't introduce a function without a user.

swapoff calls swap_tiers_release. I must improve the readability of my
RFC patch series.

> 
> > +{
> > +       struct swap_tier *tier;
> > +       int ret = 0;
> > +       int tiers_mask = 0;
> > +       int tiers_onoff = 0;
> > +       int cnt = 0;
> > +
> > +       for (int i = 0; i < nr; i++) {
> > +               for (int j = i+1; j < nr; j++) {
> > +                       if (!strcmp(desc[i].name, desc[j].name))
> 
> These two nested for loops look suspicious. Again because I don't see

For assuring, unique tier name input.
I will think of making simple.

> the caller, I can't reason what it is doing here.

When a swap tier is designated by the memcg sys interface, it is
called. I will introduce this logic together with the caller
implementation.

Best Regards,
Youngjun Park

