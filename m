Return-Path: <cgroups+bounces-11686-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC54C43E0A
	for <lists+cgroups@lfdr.de>; Sun, 09 Nov 2025 13:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B0844E56FE
	for <lists+cgroups@lfdr.de>; Sun,  9 Nov 2025 12:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76292F068A;
	Sun,  9 Nov 2025 12:50:03 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F972EC553
	for <cgroups@vger.kernel.org>; Sun,  9 Nov 2025 12:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762692603; cv=none; b=Bd2ErhYi5xkaECxjHNcaR9cQ+HAWCsvoAuUHXFq3GgCwZTSQ8FKkl2L7kuFiruFpFm7TSXoVILLqeZ7SfAT1pJ3Lkhm2ADXO4hdtVhnbPR/Mk4I8b8+eNRWiuzz/pET1pFPfpzH58ll1Y1XEJfJrlUDG5KJAl65DmxzFCaytMPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762692603; c=relaxed/simple;
	bh=wvsocl0Et2SLItHeh65bNaSfyrmCZWqDj6t5FavHHzM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=T5YoouYqL111Tylsq6NUVV4JCehmqCzQRlxik/FxkmxAJli+VhLKBCA28h3pJI3adVpOYMegBZAfQgb2nbbBXU1RZSCuljvK5MxL7mShOWjF+ImGPpbJlr4sjdk0ut+SXDBKcExwYoizTDpaQ8EmrAiCuXmKGZZIEwy3pGe9ZSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330.lge.net) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 9 Nov 2025 21:49:52 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
From: Youngjun Park <youngjun.park@lge.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chrisl@kernel.org,
	kasong@tencent.com,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	baohua@kernel.org,
	youngjun.park@lge.com,
	gunho.lee@lge.com,
	taejoon.song@lge.com
Subject: [RFC] mm/swap, memcg: Introduce swap tiers for cgroup based swap control
Date: Sun,  9 Nov 2025 21:49:44 +0900
Message-Id: <20251109124947.1101520-1-youngjun.park@lge.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

In constrained environments, there is a need to improve workload
performance by controlling swap device usage on a per-process or
per-cgroup basis. For example, one might want to direct critical
processes to faster swap devices (like SSDs) while relegating
less critical ones to slower devices (like HDDs or Network Swap).

Initial approach was to introduce a per-cgroup swap priority
mechanism [1]. However, through review and discussion, several
drawbacks were identified:

a. There is a lack of concrete use cases for assigning a fine-grained,
   unique swap priority to each cgroup. 
b. The implementation complexity was high relative to the desired
   level of control.
c. Differing swap priorities between cgroups could lead to LRU
   inversion problems.

To address these concerns, I propose the "swap tiers" concept, 
originally suggested by Chris Li [2] and further developed through 
collaborative discussions. I would like to thank Chris Li and 
He Baoquan for their invaluable contributions in refining this 
approach, and Kairui Song, Nhat Pham, and Michal Koutný for their 
insightful reviews of earlier RFC versions.

Concept
-------
A swap tier is a grouping mechanism that assigns a "named id" to a
range of swap priorities. For example, all swap devices with a
priority of 100 or higher could be grouped into a tier named "SSD",
and all others into a tier named "HDD".

Cgroups can then select which named tiers they are permitted to use for
swapping via a new cgroup interface. This effectively restricts a
cgroup's swap activity to a specific subset of the available swap
devices.

Proposed Interface
------------------
1. Global Tier Definition: /sys/kernel/mm/swap/tiers

This file is used to define the global swap tiers and their associated
minimum priority levels.

- To add tiers:
  Format: + 'tier_name':'prio'[,|' ']'tier_name 2':'prio']...
  Example:
  # echo "+ SSD:100,HDD:2" > /sys/kernel/mm/swap/tiers

  There are several rules for defining tiers:
  - Priority ranges for tiers must not overlap.
  - The combination of all defined tiers must cover the entire valid
    priority range (DEF_SWAP_PRIO to SHRT_MAX) to ensure every swap device
    can be assigned to a tier.
  - A tier's prio value is its inclusive lower bound,
    covering priorities up to the next tier's prio.
    The highest tier extends to SHRT_MAX, and the lowest tier extends to DEF_SWAP_PRIO.
  - If the specified tiers do not cover the entire priority range,
    the priority of the tier with the lowest specified priority value
    is set to SHRT_MIN
  - The total number of tiers is limited. 

- To remove tiers:
  Format: - 'tier_name'[,|' ']'tier_name2']...
  Example:
  # echo "- SSD,HDD" > /sys/kernel/mm/swap/tiers

  Note: A tier cannot be removed if it is currently in use by any
  cgroup or if any active swap device is assigned to it. This acts as
  a reference count to prevent disruption.

- To show current tiers:
  Reading the file displays the currently configured tiers, their
  internal index, and the priority range they cover.
  Example:
  # echo "+ SSD:100,HDD:2" > /sys/kernel/mm/swap/tiers
  # cat /sys/kernel/mm/swap/tiers
  Name      Idx   PrioStart   PrioEnd
            0
  SSD       1    100         32767
  HDD       2     -1         99

  - `Name`: The name of the tier. The unnamed entry is a default tier.
  - `Idx`: The internal index assigned to the tier.
  - `PrioStart`: The starting priority of the range covered by this tier.
  - `PrioEnd`: The ending priority of the range covered by this tier.

Two special tiers are predefined:
- "": Represents the default inheritance behavior in cgroups.
- "zswap": Reserved for zswap integration.

2. Cgroup Tier Selection: memory.swap.tiers

This file controls which swap tiers are enabled for a given cgroup.

- Reading the file:
  The first line shows the operation that was written to the file.
  The second line shows the final, effective set of tiers after
  merging with the parent cgroup's configuration.

- Writing to the file:
  Format: [+/-] [+|-][TIER_NAME]...
  - `+TIER_NAME`: Explicitly enables this tier for the cgroup.
  - `-TIER_NAME`: Explicitly disables this tier for the cgroup.
  - If a tier is not specified, its setting is inherited from the
    parent cgroup.
  - A standalone `+` at the beginning resets the configuration: it
    ignores the parent's settings, enables all globally defined tiers,
    and then applies the subsequent operations in the command.
  - A standalone `-` at the beginning also resets: it ignores the
    parent's settings, disables all tiers, and then applies subsequent
    operations.
  - The root cgroup defaults to an implicit `+`, enabling all swap
    devices.

  Example:
  # echo "+ -SSD -HDD" > /sys/fs/cgroup/my_cgroup/memory.swap.tiers
  This command first resets the cgroup's configuration to enable all
  tiers (due to the leading `+`), and then explicitly disables the
  "SSD" and "HDD" tiers.

Further Discussion and Open Questions
-------------------------------------
I seek feedback on this concept and have identified several key
points that require further discussion (though this is not an 
exhaustive list). This topic will also be presented at the upcoming 
Linux Plumbers Conference 2025 [3], and I would appreciate any 
feedback here on the list beforehand, or in person at the conference.

1.  The swap fast path utilizes a percpu cluster cache for efficiency.
    In swap tiers, this has been changed to a per-device per-cpu 
    cluster cache. (See the first patch in this series.)
    An alternative approach would be to cache only the swap_info_struct 
    (si) per-tier per-cpu, avoiding cluster caching entirely while still 
    maintaining fast device acquisition without `swap_avail_lock`.
    Should we pursue this alternative, or is the current per-device 
    per-cpu cluster caching approach preferable?

2.  Consistency with cgroup parent-child semantics: Unlike general
    resource distribution, tier selection may bypass parent
    constraints (e.g., a child can enable a tier disabled by its
    parent). Is this behavior acceptable?

3.  Per-cgroup swap tier limit: Is a `swap.tier.max` needed in
    addition to the existing `swap.max`?

4.  Parent-child tier mismatch: If a zombie memcg (child) uses a tier
    that is not available to its new parent, how should this be
    handled during recharging or reparenting? (This question is raised
    in the context of ongoing work to improve memcg reparenting and
    handle zombie memcgs [4, 5].)

5.  Tier mask calculation: What are the trade-offs between calculating
    the effective tier mask at runtime vs. pre-calculating it when the
    interface is written to?

6.  If a swap tier configuration is applied to a memcg, should we
    migrate existing swap-out pages that are on devices not belonging
    to any of the cgroup's allowed tiers?

7.  swap tier could be good abstraction layer. Discuss on extended usage of swap tiers.

Any feedback on the overall concept, interface, and these specific
points would be greatly appreciated.

Best Regards,
Youngjun Park

References
----------
[1] https://lore.kernel.org/linux-mm/aEvLjEInMQC7hEyh@yjaykim-PowerEdge-T330/T/#mbbb6a5e9e30843097e1f5f65fb98f31d582b973d
[2] https://lore.kernel.org/linux-mm/20250716202006.3640584-1-youngjun.park@lge.com/
[3] https://lpc.events/event/19/abstracts/2296/
[4] https://lore.kernel.org/linux-mm/20230720070825.992023-1-yosryahmed@google.com/
[5] https://blogs.oracle.com/linux/post/zombie-memcg-issues

Youngjun Park (3):
  mm, swap: change back to use each swap device's percpu cluster
  mm: swap: introduce swap tier infrastructure
  mm/swap: integrate swap tier infrastructure into swap subsystem

 Documentation/admin-guide/cgroup-v2.rst |  32 ++
 MAINTAINERS                             |   2 +
 include/linux/memcontrol.h              |   4 +
 include/linux/swap.h                    |  16 +-
 mm/Kconfig                              |  13 +
 mm/Makefile                             |   1 +
 mm/memcontrol.c                         |  69 +++
 mm/page_io.c                            |  21 +-
 mm/swap.h                               |   4 +
 mm/swap_state.c                         |  93 ++++
 mm/swap_tier.c                          | 602 ++++++++++++++++++++++++
 mm/swap_tier.h                          |  75 +++
 mm/swapfile.c                           | 169 +++----
 13 files changed, 987 insertions(+), 114 deletions(-)
 create mode 100644 mm/swap_tier.c
 create mode 100644 mm/swap_tier.h

base-commit: 02dafa01ec9a00c3758c1c6478d82fe601f5f1ba
-- 
2.34.1


