Return-Path: <cgroups+bounces-11865-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BB699C52863
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 14:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E5284F6D02
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 13:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1C0337B9D;
	Wed, 12 Nov 2025 13:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETRSj4/b"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584183375A3
	for <cgroups@vger.kernel.org>; Wed, 12 Nov 2025 13:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762954459; cv=none; b=Qzhqtpq0Af6e3tdWvzR+tbpVBa5lBqYQaMhGkX1tjCAoSWDvzpyH/TTuhlwPlgLoAZxele6H2LHajHklBzPk9HgdYFFe88EV0A5o7CGz4ulMDxOsFyyaRFmTsjEe6eOtIJT0i+C8cOY3HmzzkokTrxxAQV5BshEyz9v51vMR43c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762954459; c=relaxed/simple;
	bh=Iswk76xrOcOZ+ghm9k0OtsD4f3QfWzKcacySZovmqZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fbnLrAyY5jkS4m/qTc7nPiT/p2v+Nnxd4MT4LThUq9LtZ//lJ5K33uaemC8OCuoascVlJ2c/y9/BpmeUMhaY+TbEMgYEiPvxpezsNgY9Pq1aRPXK1byZgz6RipvN1yRHlK/K0t91sPDCifDGvE5yVX+lfRz5yrMb6nXtR8h6kg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETRSj4/b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0651EC2BC86
	for <cgroups@vger.kernel.org>; Wed, 12 Nov 2025 13:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762954459;
	bh=Iswk76xrOcOZ+ghm9k0OtsD4f3QfWzKcacySZovmqZI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ETRSj4/bajJ1ZD0uaFMjWWqub+ltFHUXncRTGPcSP9amKobJ60Knkj1FVZCzd20Lk
	 K+cmkbylppaNMhLqcKKGLpm3VNN3U6bvyEri7jaqbob2Yv7fQodEiNl7eZk1OqZjVr
	 O71YjSPK1dyCXJs/QOUCdmCyFrYzxxqIYgd68TY0J+IfEXcyiK7MuApxSfAO9QJNpv
	 Vw5uBc2LAsDLLZNwvSpoq/C7upmFEYHwW+tpvKujh5subfImZjSw6Tj6sQBqPh8W/W
	 ZhM1jD2TmimZEIiV6H/uzkkmAyCBaXYXZyupPDJfoNA5diVznGX196ZidMwKSxRCLu
	 EGpCLdYq8vhFw==
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42b312a089fso630480f8f.2
        for <cgroups@vger.kernel.org>; Wed, 12 Nov 2025 05:34:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWm3dnsXK3k9gjKOvm1BaPF/7lB6HFbPAR+mZPWJbATY4ITgoGadfrzKZnETN62WbaWRPKYILYn@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn72bq9ZMxC3GYfCJ5YknhCNygcvpMNld8li8EiPXH7nL4OGu5
	ObImGxVfhWW+5pL/nPY4L9rZC9QPuPPr4Cdi9I1gjuJd4Hg47Cbcg4xlo4GRw/0WhzEPun5AhFq
	tENMntv/B0hfv+fklet0xHYdxQ+LHrYI21w2ybehO/g==
X-Google-Smtp-Source: AGHT+IF9bcWOvDByXeJcPGdpBQ62WykCFYRS8f6AjV3YIWckQFEoXL97S1nJnKOvcUbeL/OiU294pxGnu8ThdwoRQ1E=
X-Received: by 2002:a05:6000:4210:b0:427:8c85:a4ac with SMTP id
 ffacd0b85a97d-42b4bdb4cfcmr2474633f8f.47.1762954457534; Wed, 12 Nov 2025
 05:34:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109124947.1101520-1-youngjun.park@lge.com>
In-Reply-To: <20251109124947.1101520-1-youngjun.park@lge.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 12 Nov 2025 05:34:05 -0800
X-Gmail-Original-Message-ID: <CACePvbV80ZtC2FL6Z-Y4Rg=5bzdi1O8zqQSMEGuxqhj5P0txsA@mail.gmail.com>
X-Gm-Features: AWmQ_bkQL-nIO8ItDYbzVpVznojBy7HPNB9u7fXNkmn_UNYWv8e_ajah8xnS1QY
Message-ID: <CACePvbV80ZtC2FL6Z-Y4Rg=5bzdi1O8zqQSMEGuxqhj5P0txsA@mail.gmail.com>
Subject: Re: [RFC] mm/swap, memcg: Introduce swap tiers for cgroup based swap control
To: Youngjun Park <youngjun.park@lge.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kasong@tencent.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	muchun.song@linux.dev, shikemeng@huaweicloud.com, nphamcs@gmail.com, 
	bhe@redhat.com, baohua@kernel.org, gunho.lee@lge.com, taejoon.song@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Youngjun,

Sorry for the late reply, I have been super busy in the last two weeks
and I am still catching up on my backlogs.

Thanks for the patches. I notice that your cover letter does not have
[0/3] on it. One tool I found useful is using the b4 to send out
patches in series. Just for your consideration, it is not an ask. I
can review patches not sent out from b4 just fine.

On Sun, Nov 9, 2025 at 4:50=E2=80=AFAM Youngjun Park <youngjun.park@lge.com=
> wrote:
>
> Hi all,
>
> In constrained environments, there is a need to improve workload
> performance by controlling swap device usage on a per-process or
> per-cgroup basis. For example, one might want to direct critical
> processes to faster swap devices (like SSDs) while relegating
> less critical ones to slower devices (like HDDs or Network Swap).
>
> Initial approach was to introduce a per-cgroup swap priority
> mechanism [1]. However, through review and discussion, several
> drawbacks were identified:
>
> a. There is a lack of concrete use cases for assigning a fine-grained,
>    unique swap priority to each cgroup.
> b. The implementation complexity was high relative to the desired
>    level of control.
> c. Differing swap priorities between cgroups could lead to LRU
>    inversion problems.
>
> To address these concerns, I propose the "swap tiers" concept,
> originally suggested by Chris Li [2] and further developed through
> collaborative discussions. I would like to thank Chris Li and
> He Baoquan for their invaluable contributions in refining this
> approach, and Kairui Song, Nhat Pham, and Michal Koutn=C3=BD for their
> insightful reviews of earlier RFC versions.
>
> Concept
> -------
> A swap tier is a grouping mechanism that assigns a "named id" to a
> range of swap priorities. For example, all swap devices with a
> priority of 100 or higher could be grouped into a tier named "SSD",
> and all others into a tier named "HDD".
>
> Cgroups can then select which named tiers they are permitted to use for
> swapping via a new cgroup interface. This effectively restricts a
> cgroup's swap activity to a specific subset of the available swap
> devices.
>
> Proposed Interface
> ------------------
> 1. Global Tier Definition: /sys/kernel/mm/swap/tiers
>
> This file is used to define the global swap tiers and their associated
> minimum priority levels.
>
> - To add tiers:
>   Format: + 'tier_name':'prio'[,|' ']'tier_name 2':'prio']...
>   Example:
>   # echo "+ SSD:100,HDD:2" > /sys/kernel/mm/swap/tiers

I think a lot of this documentation nature of the cover letter should
move into a kernel document commit. Maybe
Documentation/mm/swap_tiers.rst

Another suggestion is use "+SSD:100,+HDD:2,-SD" that kind of flavor
similar to "cgroup.subtree_control" interface, which allows adding or
removing cgroups. That way you can add and remove in one line action.

>
>   There are several rules for defining tiers:
>   - Priority ranges for tiers must not overlap.

We can add that we suggest allocating a higher priority range for
faster swap devices. That way more swap page faults will likely be
served by faster swap devices.

>   - The combination of all defined tiers must cover the entire valid
>     priority range (DEF_SWAP_PRIO to SHRT_MAX) to ensure every swap devic=
e
>     can be assigned to a tier.
>   - A tier's prio value is its inclusive lower bound,
>     covering priorities up to the next tier's prio.
>     The highest tier extends to SHRT_MAX, and the lowest tier extends to =
DEF_SWAP_PRIO.
>   - If the specified tiers do not cover the entire priority range,
>     the priority of the tier with the lowest specified priority value
>     is set to SHRT_MIN
>   - The total number of tiers is limited.
>
> - To remove tiers:
>   Format: - 'tier_name'[,|' ']'tier_name2']...
>   Example:
>   # echo "- SSD,HDD" > /sys/kernel/mm/swap/tiers

See above, make the '-SSD, -HDD' similar to the "cgroup.subtree_control"
>
>   Note: A tier cannot be removed if it is currently in use by any
>   cgroup or if any active swap device is assigned to it. This acts as
>   a reference count to prevent disruption.
>
> - To show current tiers:
>   Reading the file displays the currently configured tiers, their
>   internal index, and the priority range they cover.
>   Example:
>   # echo "+ SSD:100,HDD:2" > /sys/kernel/mm/swap/tiers
>   # cat /sys/kernel/mm/swap/tiers
>   Name      Idx   PrioStart   PrioEnd
>             0
>   SSD       1    100         32767
>   HDD       2     -1         99
>
>   - `Name`: The name of the tier. The unnamed entry is a default tier.
>   - `Idx`: The internal index assigned to the tier.
>   - `PrioStart`: The starting priority of the range covered by this tier.
>   - `PrioEnd`: The ending priority of the range covered by this tier.
>
> Two special tiers are predefined:
> - "": Represents the default inheritance behavior in cgroups.
This belongs to the memory.swap.tiers section.
"" is not a real tier's name. It is just a wide cast to refer to all tiers.

> - "zswap": Reserved for zswap integration.

One thing I realize is that, we might need to have per swap tier have
a matching zswap tier. Otherwise when we refer to zswap, there is no
way for the cgroup to select which backing swapfile does this zswap
use for allocating the swap entry.

We can avoid this complexity by providing a dedicated ghost swapfile,
which only zswap can use to allocate swap entries.

> 2. Cgroup Tier Selection: memory.swap.tiers
>
> This file controls which swap tiers are enabled for a given cgroup.
>
> - Reading the file:
>   The first line shows the operation that was written to the file.
>   The second line shows the final, effective set of tiers after
>   merging with the parent cgroup's configuration.
>
> - Writing to the file:
>   Format: [+/-] [+|-][TIER_NAME]...
>   - `+TIER_NAME`: Explicitly enables this tier for the cgroup.
>   - `-TIER_NAME`: Explicitly disables this tier for the cgroup.
>   - If a tier is not specified, its setting is inherited from the
>     parent cgroup.
>   - A standalone `+` at the beginning resets the configuration: it
>     ignores the parent's settings, enables all globally defined tiers,
>     and then applies the subsequent operations in the command.
>   - A standalone `-` at the beginning also resets: it ignores the
>     parent's settings, disables all tiers, and then applies subsequent
>     operations.
>   - The root cgroup defaults to an implicit `+`, enabling all swap
>     devices.
>
>   Example:
>   # echo "+ -SSD -HDD" > /sys/fs/cgroup/my_cgroup/memory.swap.tiers
>   This command first resets the cgroup's configuration to enable all
>   tiers (due to the leading `+`), and then explicitly disables the
>   "SSD" and "HDD" tiers.
>
> Further Discussion and Open Questions
> -------------------------------------
> I seek feedback on this concept and have identified several key
> points that require further discussion (though this is not an
> exhaustive list). This topic will also be presented at the upcoming
> Linux Plumbers Conference 2025 [3], and I would appreciate any
> feedback here on the list beforehand, or in person at the conference.

All very good questions. Thanks for preparing that.

>
> 1.  The swap fast path utilizes a percpu cluster cache for efficiency.
>     In swap tiers, this has been changed to a per-device per-cpu
>     cluster cache. (See the first patch in this series.)
>     An alternative approach would be to cache only the swap_info_struct
>     (si) per-tier per-cpu, avoiding cluster caching entirely while still
>     maintaining fast device acquisition without `swap_avail_lock`.
>     Should we pursue this alternative, or is the current per-device
>     per-cpu cluster caching approach preferable?
>
> 2.  Consistency with cgroup parent-child semantics: Unlike general
>     resource distribution, tier selection may bypass parent
>     constraints (e.g., a child can enable a tier disabled by its
>     parent). Is this behavior acceptable?
>
> 3.  Per-cgroup swap tier limit: Is a `swap.tier.max` needed in
>     addition to the existing `swap.max`?

I really hope not.

>
> 4.  Parent-child tier mismatch: If a zombie memcg (child) uses a tier
>     that is not available to its new parent, how should this be
>     handled during recharging or reparenting? (This question is raised
>     in the context of ongoing work to improve memcg reparenting and
>     handle zombie memcgs [4, 5].)

I really want to avoid doing the reparenting.

Chris


>
> 5.  Tier mask calculation: What are the trade-offs between calculating
>     the effective tier mask at runtime vs. pre-calculating it when the
>     interface is written to?
>
> 6.  If a swap tier configuration is applied to a memcg, should we
>     migrate existing swap-out pages that are on devices not belonging
>     to any of the cgroup's allowed tiers?
>
> 7.  swap tier could be good abstraction layer. Discuss on extended usage =
of swap tiers.
>
> Any feedback on the overall concept, interface, and these specific
> points would be greatly appreciated.
>
> Best Regards,
> Youngjun Park
>
> References
> ----------
> [1] https://lore.kernel.org/linux-mm/aEvLjEInMQC7hEyh@yjaykim-PowerEdge-T=
330/T/#mbbb6a5e9e30843097e1f5f65fb98f31d582b973d
> [2] https://lore.kernel.org/linux-mm/20250716202006.3640584-1-youngjun.pa=
rk@lge.com/
> [3] https://lpc.events/event/19/abstracts/2296/
> [4] https://lore.kernel.org/linux-mm/20230720070825.992023-1-yosryahmed@g=
oogle.com/
> [5] https://blogs.oracle.com/linux/post/zombie-memcg-issues
>
> Youngjun Park (3):
>   mm, swap: change back to use each swap device's percpu cluster
>   mm: swap: introduce swap tier infrastructure
>   mm/swap: integrate swap tier infrastructure into swap subsystem
>
>  Documentation/admin-guide/cgroup-v2.rst |  32 ++
>  MAINTAINERS                             |   2 +
>  include/linux/memcontrol.h              |   4 +
>  include/linux/swap.h                    |  16 +-
>  mm/Kconfig                              |  13 +
>  mm/Makefile                             |   1 +
>  mm/memcontrol.c                         |  69 +++
>  mm/page_io.c                            |  21 +-
>  mm/swap.h                               |   4 +
>  mm/swap_state.c                         |  93 ++++
>  mm/swap_tier.c                          | 602 ++++++++++++++++++++++++
>  mm/swap_tier.h                          |  75 +++
>  mm/swapfile.c                           | 169 +++----
>  13 files changed, 987 insertions(+), 114 deletions(-)
>  create mode 100644 mm/swap_tier.c
>  create mode 100644 mm/swap_tier.h
>
> base-commit: 02dafa01ec9a00c3758c1c6478d82fe601f5f1ba
> --
> 2.34.1
>
>

