Return-Path: <cgroups+bounces-11912-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A56C559F5
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 05:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6CAE93425A8
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 04:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFAB267386;
	Thu, 13 Nov 2025 04:07:13 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95B81EB9E3
	for <cgroups@vger.kernel.org>; Thu, 13 Nov 2025 04:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763006833; cv=none; b=Bk7pJ10+C18CTTMBt8QlWSAda/uqMU7vj06irP+HVF7bBHYD+89qD9ic9keeTdpZK1cJY+ko/3psClVb0l2Ed2v0q6wrvhOZbb8egsNseaBhLbrM867w3R0Z9OBdfuSPpw7i3xin8qx/oOBmIVaZVB5srAEciWY8j5dXUQM2IgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763006833; c=relaxed/simple;
	bh=ufc3JxqrSh0wJMH6d8Jsoj8Gh7x2IJYQi0OlpFNc6pY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XWeVmjSy+r6M7tJbHUU4/qRj5G9xNFGiBs3jJVp1xI8TkyLhjzWyU63JZfZR2RYaNbzEHeG4vN1mWKc234yQpH/pqTkXE6Oj4evwO19X6uwkkUlM8rhJbmDejCJkviVX9+aGccMKv9Tmvb25rxpwXzUqox+ld239Q/ghYiK1puU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 13 Nov 2025 13:07:08 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Thu, 13 Nov 2025 13:07:08 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: Chris Li <chrisl@kernel.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, kasong@tencent.com,
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev,
	shikemeng@huaweicloud.com, nphamcs@gmail.com, bhe@redhat.com,
	baohua@kernel.org, gunho.lee@lge.com, taejoon.song@lge.com
Subject: Re: [PATCH 3/3] mm/swap: integrate swap tier infrastructure into
 swap subsystem
Message-ID: <aRVZbMNgvDbZDnDK@yjaykim-PowerEdge-T330>
References: <20251109124947.1101520-1-youngjun.park@lge.com>
 <20251109124947.1101520-4-youngjun.park@lge.com>
 <CACePvbU+NviPmpXQAJUrY4rTqmY_rvYy2JvDBAfT290GmQmfZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACePvbU+NviPmpXQAJUrY4rTqmY_rvYy2JvDBAfT290GmQmfZg@mail.gmail.com>

On Wed, Nov 12, 2025 at 06:44:23AM -0800, Chris Li wrote:
> It seems you should introduce the tiers first. Allow users to define tiers.
> Then the follow up patches use tiers defined here.
> 
> The patch order seems reversed to me.
> 
> See some feedback below, to be continued.
> 
> Chris

Ack. As I already mentioned, I will change it properly :D

> On Sun, Nov 9, 2025 at 4:50 AM Youngjun Park &lt;youngjun.park@lge.com&gt; wrote:
> >
> > Integrate the swap tier infrastructure into the existing swap subsystem
> > to enable selective swap device usage based on tier configuration.
> >
> > Signed-off-by: Youngjun Park &lt;youngjun.park@lge.com&gt;
> > ---
> >  mm/memcontrol.c | 69 ++++++++++++++++++++++++++++++++++++
> >  mm/page_io.c    | 21 ++++++++++-
> >  mm/swap_state.c | 93 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  mm/swapfile.c   | 15 ++++++--
> >  4 files changed, 194 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index bfc986da3289..33c7cc069754 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -68,6 +68,7 @@
> >  #include <net/ip.h>
> >  #include "slab.h"
> >  #include "memcontrol-v1.h"
> > +#include "swap_tier.h"
> >
> >  #include <linux/uaccess.h>
> >
> > @@ -3730,6 +3731,7 @@ static void mem_cgroup_free(struct mem_cgroup *memcg)
> >  {
> >         lru_gen_exit_memcg(memcg);
> >         memcg_wb_domain_exit(memcg);
> > +       swap_tiers_put_mask(memcg);
> >         __mem_cgroup_free(memcg);
> >  }
> >
> > @@ -3842,6 +3844,11 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
> >                 page_counter_init(&memcg->kmem, &parent->kmem, false);
> >                 page_counter_init(&memcg->tcpmem, &parent->tcpmem, false);
> >  #endif
> > +#ifdef CONFIG_SWAP_TIER
> > +               memcg->tiers_mask = 0;
> > +               memcg->tiers_onoff = 0;
> > +#endif
> > +
> >         } else {
> >                 init_memcg_stats();
> >                 init_memcg_events();
> > @@ -3850,6 +3857,10 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
> >  #ifdef CONFIG_MEMCG_V1
> >                 page_counter_init(&memcg->kmem, NULL, false);
> >                 page_counter_init(&memcg->tcpmem, NULL, false);
> > +#endif
> > +#ifdef CONFIG_SWAP_TIER
> Again, don't need this config.

Ack.

> > +               memcg->tiers_mask = DEFAULT_FULL_MASK;
>
> Is this memcg->tiers_mask a cached value after evaluating the
> swap.tiers onoff list by looking up the parent?

It is updated when configured through the memcg interface.
The tiers_onoff field represents which tiers are turned on or off,
and tiers_mask is the mask that includes both on and off bits for
those tiers. This mask is used in swap_tier_collect_mask logic to
avoid recalculating it every time.

> I was thinking of starting with always evaluating the tiers_mask. Then
> we don't need to store it here. How do you indicate the tiers_mask is
> out of date?

swap_tier_collect_mask does not cache it. The effective mask is
calculated at swap I/O time. It only changes through the user
interface.

From your mention of “evaluation,” I understand you are referring to
a dynamically computed mask that depends on the parent’s settings.
However, in my implementation, tiers_mask is simply the mask of the
selected tiers. tiers_onoff indicates on/off state, and tiers_mask
represents the full mask (both on and off bits) needed for
swap_tier_collect_mask calculation. Therefore, tiers_mask can be
derived from tiers_onoff and could potentially be removed.

> > +               memcg->tiers_onoff = DEFAULT_ON_MASK;
> >  #endif
> >                 root_mem_cgroup = memcg;
> >                 return &memcg->css;
> > @@ -5390,6 +5401,56 @@ static int swap_events_show(struct seq_file *m, void *v)
> >         return 0;
> >  }
> >
> > +#ifdef CONFIG_SWAP_TIER
> > +static int swap_tier_show(struct seq_file *m, void *v)
> > +{
> > +       struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
> > +
> > +       swap_tiers_show_memcg(m, memcg);
> > +       return 0;
> > +}
> > +
> > +static ssize_t swap_tier_write(struct kernfs_open_file *of,
> > +                               char *buf, size_t nbytes, loff_t off)
> > +{
> > +       struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
> > +       struct tiers_desc desc[MAX_SWAPTIER] = {};
> > +       char *pos = buf, *token;
> > +       int nr = 0;
> > +       int ret;
> > +
> > +       while ((token = strsep(&pos, " \t\n")) != NULL) {
>
> Not allowing plain space " "? Compare pointer != NULL is redundant.

You mean just allow " "?

I will change it to:
while ((token = strsep(" "))) {

> > +               if (!*token)
> > +                       continue;
> > +
> > +               if (nr >= MAX_SWAPTIER)
> > +                       return -E2BIG;
> > +
> > +               if (token[0] != '+' && token[0] != '-')
> > +                       return -EINVAL;
> > +
> > +               desc[nr].ops = (token[0] == '+') ? TIER_ON_MASK : TIER_OFF_MASK;
> > +
> > +               if (strlen(token) <= 1) {
> > +                       strscpy(desc[nr].name, DEFAULT_TIER_NAME);
> > +                       nr++;
> > +                       continue;
> > +               }
> > +
> > +               if (strscpy(desc[nr].name, token + 1, MAX_TIERNAME) < 0)
> > +                       return -EINVAL;
> > +
> > +               nr++;
> I don't think you need this nr, you will reach to the end of the
> string any way. What if the user specifies the same tier more than
> once? It is not optimal but the kernel should take it.
>
> OK, I see what is going on now, this whole desc thing can be greatly
> simplified. You shouldn't need to maintain the desc[nr], that desc
> array is the onoff mask in my mind. You just need to keep the tier
> bits in order.
>
> Notice in the memory.swap.tiers. Except for the default tier pattern,
> which always the first one if exists. The rest of the tier + - order
> does not matter. You look up the tier name into the tier mask bit.
> Just set the onoff bits for that tier.

The desc array is currently used as an
intermediate structure before applying the bitmask in swap_tier.c.
but as you mentioned, it might be unnecessary. I will review this
part to see if it can be simplified.

Best Regards,
Youngjun Park

