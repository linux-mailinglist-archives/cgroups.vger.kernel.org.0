Return-Path: <cgroups+bounces-11902-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E357C55427
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 02:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 920024E2C15
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 01:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543832874E9;
	Thu, 13 Nov 2025 01:33:41 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B53265CA2
	for <cgroups@vger.kernel.org>; Thu, 13 Nov 2025 01:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762997621; cv=none; b=TeErVmROVdPQWXLiPnlbeaC1/DWpCRk9BHOsvB/WkmBN4OkSoSk5XE1cUpu16XFopn9WmCICmoQMbHaY1KOWeH3sa0pk/Gh5M2WA0evH7t2MR+9xBVaRr6NFoy/yXxE5gf4XJz0etKZir30B4inyLz82ZWMNUR207P3X7Lzgetc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762997621; c=relaxed/simple;
	bh=YYr0ovGXbPx1j+h8mG4oGlF/bo67CcFXqo/NraN20eI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qGqtRUZZvH+axGBSJjKUs/Uvax/NySU9SZrdye3GMw+pnjTPqLvlnuLSJyEh1XbKtjzQDOaalFY80q9rTDBtXXp575lRldOjzou0qoaqR5EMjO1v3blvL9PwtCo1qf6GnZSRnFGjhVxlRUzlK3h5baacBwbkwdXK/NaQAvoEWgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 13 Nov 2025 10:33:29 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Thu, 13 Nov 2025 10:33:29 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: Chris Li <chrisl@kernel.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, kasong@tencent.com,
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev,
	shikemeng@huaweicloud.com, nphamcs@gmail.com, bhe@redhat.com,
	baohua@kernel.org, gunho.lee@lge.com, taejoon.song@lge.com
Subject: Re: [RFC] mm/swap, memcg: Introduce swap tiers for cgroup based swap
 control
Message-ID: <aRU1abZaS+c1rK4R@yjaykim-PowerEdge-T330>
References: <20251109124947.1101520-1-youngjun.park@lge.com>
 <CACePvbV80ZtC2FL6Z-Y4Rg=5bzdi1O8zqQSMEGuxqhj5P0txsA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACePvbV80ZtC2FL6Z-Y4Rg=5bzdi1O8zqQSMEGuxqhj5P0txsA@mail.gmail.com>

On Wed, Nov 12, 2025 at 05:34:05AM -0800, Chris Li wrote:

Hello Chris :)

> Thanks for the patches. I notice that your cover letter does not have
> [0/3] on it. One tool I found useful is using the b4 to send out
> patches in series. Just for your consideration, it is not an ask. I
> can review patches not sent out from b4 just fine.

I manually edited the cover letter title, but made a human error.
Thanks for the tip.
 
> On Sun, Nov 9, 2025 at 4:50 AM Youngjun Park <youngjun.park@lge.com> wrote:
> >
> > Hi all,
> >
> > In constrained environments, there is a need to improve workload
> > performance by controlling swap device usage on a per-process or
> > per-cgroup basis. For example, one might want to direct critical
> > processes to faster swap devices (like SSDs) while relegating
> > less critical ones to slower devices (like HDDs or Network Swap).
> >
> > Initial approach was to introduce a per-cgroup swap priority
> > mechanism [1]. However, through review and discussion, several
> > drawbacks were identified:
> >
> > a. There is a lack of concrete use cases for assigning a fine-grained,
> >    unique swap priority to each cgroup.
> > b. The implementation complexity was high relative to the desired
> >    level of control.
> > c. Differing swap priorities between cgroups could lead to LRU
> >    inversion problems.
> >
> > To address these concerns, I propose the "swap tiers" concept,
> > originally suggested by Chris Li [2] and further developed through
> > collaborative discussions. I would like to thank Chris Li and
> > He Baoquan for their invaluable contributions in refining this
> > approach, and Kairui Song, Nhat Pham, and Michal Koutný for their
> > insightful reviews of earlier RFC versions.
> >
> > Concept
> > -------
> > A swap tier is a grouping mechanism that assigns a "named id" to a
> > range of swap priorities. For example, all swap devices with a
> > priority of 100 or higher could be grouped into a tier named "SSD",
> > and all others into a tier named "HDD".
> >
> > Cgroups can then select which named tiers they are permitted to use for
> > swapping via a new cgroup interface. This effectively restricts a
> > cgroup's swap activity to a specific subset of the available swap
> > devices.
> >
> > Proposed Interface
> > ------------------
> > 1. Global Tier Definition: /sys/kernel/mm/swap/tiers
> >
> > This file is used to define the global swap tiers and their associated
> > minimum priority levels.
> >
> > - To add tiers:
> >   Format: + 'tier_name':'prio'[,|' ']'tier_name 2':'prio']...
> >   Example:
> >   # echo "+ SSD:100,HDD:2" > /sys/kernel/mm/swap/tiers
> 
> I think a lot of this documentation nature of the cover letter should
> move into a kernel document commit. Maybe
> Documentation/mm/swap_tiers.rst

I will create a Documentation file based on what is mentioned here.

> Another suggestion is use "+SSD:100,+HDD:2,-SD" that kind of flavor
> similar to "cgroup.subtree_control" interface, which allows adding or
> removing cgroups. That way you can add and remove in one line action.

Your suggested format is more familiar. I have no objections and will
change it accordingly.

> >
> >   There are several rules for defining tiers:
> >   - Priority ranges for tiers must not overlap.
> 
> We can add that we suggest allocating a higher priority range for
> faster swap devices. That way more swap page faults will likely be
> served by faster swap devices.

It would be good to explicitly state this in the Documentation.

> >   - The combination of all defined tiers must cover the entire valid
> >     priority range (DEF_SWAP_PRIO to SHRT_MAX) to ensure every swap device
> >     can be assigned to a tier.
> >   - A tier's prio value is its inclusive lower bound,
> >     covering priorities up to the next tier's prio.
> >     The highest tier extends to SHRT_MAX, and the lowest tier extends to DEF_SWAP_PRIO.
> >   - If the specified tiers do not cover the entire priority range,
> >     the priority of the tier with the lowest specified priority value
> >     is set to SHRT_MIN
> >   - The total number of tiers is limited.
> >
> > - To remove tiers:
> >   Format: - 'tier_name'[,|' ']'tier_name2']...
> >   Example:
> >   # echo "- SSD,HDD" > /sys/kernel/mm/swap/tiers
> 
> See above, make the '-SSD, -HDD' similar to the "cgroup.subtree_control"

Ack as I said before commenct. Thanks for suggestion again.

> >   Note: A tier cannot be removed if it is currently in use by any
> >   cgroup or if any active swap device is assigned to it. This acts as
> >   a reference count to prevent disruption.
> >
> > - To show current tiers:
> >   Reading the file displays the currently configured tiers, their
> >   internal index, and the priority range they cover.
> >   Example:
> >   # echo "+ SSD:100,HDD:2" > /sys/kernel/mm/swap/tiers
> >   # cat /sys/kernel/mm/swap/tiers
> >   Name      Idx   PrioStart   PrioEnd
> >             0
> >   SSD       1    100         32767
> >   HDD       2     -1         99
> >
> >   - `Name`: The name of the tier. The unnamed entry is a default tier.
> >   - `Idx`: The internal index assigned to the tier.
> >   - `PrioStart`: The starting priority of the range covered by this tier.
> >   - `PrioEnd`: The ending priority of the range covered by this tier.
> >
> > Two special tiers are predefined:
> > - "": Represents the default inheritance behavior in cgroups.
> This belongs to the memory.swap.tiers section.
> "" is not a real tier's name. It is just a wide cast to refer to all tiers.

I will manage it separately as a logical tier that is not exposed to
users, and also handle it at the code level.

> > - "zswap": Reserved for zswap integration.
>
> One thing I realize is that, we might need to have per swap tier have
> a matching zswap tier. Otherwise when we refer to zswap, there is no
> way for the cgroup to select which backing swapfile does this zswap
> use for allocating the swap entry.

From the perspective of per-cgroup swap control,
if a ZSWAP tier is assigned and a cgroup selects that tier,
it determines whether to use zswap or not.

However, since the zswap backend does not know which tier it is linked
to, there could be a mismatch between the zswap tier (1), the backend
storage (2), and possibly another layer (3).  
This could lead to a contradiction where the cgroup-selected tier may
or may not correspond to the actual backend tier.  
Is this the correct understanding?

> We can avoid this complexity by providing a dedicated ghost swapfile,
> which only zswap can use to allocate swap entries.

From what I understood when youpreviously mentioned this concept,
the “ghost swapfile” is not a real swap device.  
It exists conceptually so that zswap can operate as if there is a swap
device, but in reality, only compressed swap entries are managed by
zswap itself. (zswap needs actual swap for compress swap)

Considering both points above, could you please clarify the intended
direction?  

Are you suggesting removing the zswap tier entirely, or defining a
specific way to manage it?  

I would appreciate a bit more explanation on how you envision the zswap
tier being handled.

Best Regards,
Youngjun Park

