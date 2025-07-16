Return-Path: <cgroups+bounces-8745-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAAEB07F00
	for <lists+cgroups@lfdr.de>; Wed, 16 Jul 2025 22:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 677E9166AD2
	for <lists+cgroups@lfdr.de>; Wed, 16 Jul 2025 20:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38D42BCF4B;
	Wed, 16 Jul 2025 20:35:37 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F220126E6E8
	for <cgroups@vger.kernel.org>; Wed, 16 Jul 2025 20:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752698137; cv=none; b=cHsVeplLy1JSFtW9BY2kC59mNyPCgfOrmVGkwFFIswmv2aIxKCea+AIjArB6FCTVINNo0/032YBLzYC3NEtQd14UPLuRziaPa+ZT7g0N9b4NsbadIacVWgjMioMTKaP0ZXTq6PwLo4QNl/i2afuaVAh8kHdmV+SsRl24SXn2frU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752698137; c=relaxed/simple;
	bh=fz24MBZaP1rGDz+9ge5+8SdQD7a1z0k1BNiy0BvaXmo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Ldz54dHslMbL0pdsbYKHcOwCA0FI31Xb7LK0XKWc05DH7snH2HxY47Xj0eeuXoBBIGPTKoATukHY1UEX4UGp1ptfu6LK12JyMo1GYXqWrhl/T3eME/x5GCqgRYEpZMo6RcbxhqUVDmnKIyIcpBqDZ8bTVZ+d6cTrKrpPpP1H97w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330.lge.net) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 17 Jul 2025 05:20:32 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
From: Youngjun Park <youngjun.park@lge.com>
To: akpm@linux-foundation.org,
	hannes@cmpxchg.org
Cc: mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	shikemeng@huaweicloud.com,
	kasong@tencent.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	baohua@kernel.org,
	chrisl@kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	gunho.lee@lge.com,
	iamjoonsoo.kim@lge.com,
	taejoon.song@lge.com,
	Youngjun Park <youngjun.park@lge.com>
Subject: [PATCH 0/4] mm/swap, memcg: Support per-cgroup swap device priorities
Date: Thu, 17 Jul 2025 05:20:02 +0900
Message-Id: <20250716202006.3640584-1-youngjun.park@lge.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patchset introduces a mechanism to assign swap device priorities
per cgroup.

It is an evolution of a previously submitted RFC [1], with revised
semantics, interfaces, and implementation based on community feedback.

======================================================================
I. MOTIVATION
======================================================================

Core requirement was to improve application responsiveness and loading
time, especially for latency-critical applications, without increasing
RAM or storage hardware resources.

Device constraints:
  - Linux-based embedded platform
  - Limited system RAM
  - Small local swap
  - No option to expand RAM or local swap

To mitigate this, we explored utilizing idle RAM and storage from nearby
devices as remote swap space. To maximize its effectiveness, we needed
per-cgroup control over swap device selection:

  - Assign faster local swap devices to latency-critical apps
  - Assign remote swap devices to background apps

However, current kernel swap infrastructure does not support per-cgroup
swap device assignment.

======================================================================
II. EVALUATED ALTERNATIVES
======================================================================

**II-1. Per-cgroup Dedicated Swap Devices**

- Proposed upstream [2]
- Difficult to maintain consistent global vs per-cgroup swap state
- Hard to reconcile with memory.max and swap.max semantics

**II-2. Multi-backend Swap Device with Cgroup-aware Routing**

- Breaks layering abstraction (block device cgroup awareness)
- Swap devices treated as physical storage
- Related ideas discussed in [3]

**II-3. Per-cgroup Swap Enable/Disable with Usage Control**

- Could expand swap.max via zswap writeback [4]
- Cannot express flexible device orderings
- Less expressive than per-device priorities

**Conclusion:** Per-cgroup swap priority configuration is the most natural and
least invasive extension to existing kernel mechanisms.

======================================================================
III. DESIGN OVERVIEW
======================================================================

**III-1. Per-Cgroup Swap Priority**

Semantics:
- Configure swap priorities per device via the `memory.swap.priority` interface.
- If a value is specified, it overrides the global priority for that cgroup.
- Priority semantics follow the global swap behavior:
  - Higher numeric values are preferred
  - Devices with equal priority are used round-robin
  - Negative priorities follow NUMA-aware fallback [5]
- If no value is given, the global swap priority is used.
- Default settings influence swap device propagation on swapon/swapoff events.
- At `swapon`, these settings determine whether and how newly added devices
  are included for the cgroup.

Each cgroup exposes a readable and writable file:

  memory.swap.priority

This file accepts one `<id> <priority>` pair per line, where `<id>` is the
numeric ID of a swap device as shown in `/proc/swaps`:

  Filename       Type        Size   Used  Priority  Id
  /dev/sda2      partition   ...    ...   20        1
  /dev/sdb2      partition   ...    ...   -2        2

The following defaults can be set:

- `default none`:
  Use global priority (implicit default)

- `default disabled`:
  Exclude swap devices from use in this cgroup

These defaults determine how new devices are handled at `swapon` time.

Special keywords can also be specified per device:
- `<id> none`: use global priority (clears override)
- `<id> disabled`: exclude the device from this cgroup's swap allocation

Reading this file shows the current configuration. Devices not explicitly set
may still appear if their effective priority differs from the global value due
to NUMA fallback or internal normalization.

**Example**

  echo "1 -2" > memory.swap.priority

May result in:

  1 -2
  2 -3

To revert both devices to global priority:

  echo "1 none" > memory.swap.priority
  echo "2 none" > memory.swap.priority

To disable device 1 while allowing device 2:

  echo "1 disabled" > memory.swap.priority

**III-2. Inheritance**

Inheritance semantics:

- Each cgroup inherits from the **highest** ancestor with a setting
- Intermediate ancestors are ignored
- If no ancestor is configured, the local setting is used
- If the inherited ancestor configuration is removed or absent, the cgroup
  falls back to its local setting. If none exists, the global priority is used.

The effective configuration after inheritance is visible via:

  memory.swap.priority.effective

If `default disabled` is active, it is shown explicitly.  
If `default none` is used, it is applied silently and not shown.

======================================================================
IV. TESTING
======================================================================

This patchset was tested on x86_64 under QEMU using `stress-ng` to generate
swap I/O while toggling swap devices and updating `memory.swap.priority`.

The kernel was instrumented with KASAN, lockdep, and other
`CONFIG_DEBUG_*` options to increase debugging coverage and help identify
potential issues under stress.

======================================================================
V. CHANGE HISTORY
======================================================================

== RFC → v1 ==

[1] Changed interface from flat `1:10,2:-1` to line-based flat key format,
    following cgroup v2 interface conventions where each swap device is
    configured independently.
    - Suggested by: Michal Koutný

[2] Added `memory.swap.priority.effective` to expose the final applied
    priority, reflecting cgroup inheritance rules.

[3] Clarified default semantics: `default none`, `default disabled`
    - Suggested by: Michal Koutný

[4] Implemented per-cgroup percpu swap device cache and used per-device
    shared clusters to avoid scalability issues
    - Suggested by: Kairui Song

[5] Exposed swap device id via /proc/swaps for introspection

[6] Introduced swap_cgroup_priority.h to define the main interface and declare
    symbols shared with swapfile.c.

[7] Aligned the number of swap_cgroup_priority_pnode instances with nr_swapfiles
    to ensure consistency during swap device changes.

[8] Removed the explicit delete interface, now handled implicitly by dynamic tracking.

======================================================================
VI. REFERENCES
======================================================================

[1] RFC: Per-cgroup swap device prioritization  
    https://lore.kernel.org/linux-mm/aEvLjEInMQC7hEyh@yjaykim-PowerEdge-T330/T/#mbbb6a5e9e30843097e1f5f65fb98f31d582b973d  
[2] Cgroup-specific swap devices (2014)  
    https://lkml.iu.edu/hypermail/linux/kernel/1404.0/02530.html  
[3] Swap redirection and zswap writeback discussions  
    https://lore.kernel.org/linux-mm/CAMgjq7DGMS5A4t6nOQmwyLy5Px96aoejBkiwFHgy9uMk-F8Y-w@mail.gmail.com  
[4] Per-cgroup zswap writeback  
    https://lore.kernel.org/lkml/CAF8kJuN-4UE0skVHvjUzpGefavkLULMonjgkXUZSBVJrcGFXCA@mail.gmail.com  
[5] Swap NUMA fallback  
    https://docs.kernel.org/vm/swap_numa.html
---

This feature is marked **EXPERIMENTAL** in Kconfig, as it has not yet undergone
extensive real-world testing. The implementation is functional and reflects
feedback from prior RFC discussions, but further testing and review are welcome.
I’m happy to iterate based on community feedback.

Thanks,
Youngjun Park

Youngjun Park (4):
  mm/swap, memcg: Introduce infrastructure for cgroup-based swap
    priority
  mm: swap: Apply per-cgroup swap priority mechanism to swap layer
  mm: memcg: Add swap cgroup priority inheritance mechanism
  mm: swap: Per-cgroup per-CPU swap device cache with shared clusters

 Documentation/admin-guide/cgroup-v2.rst |   76 ++
 MAINTAINERS                             |    2 +
 include/linux/memcontrol.h              |    3 +
 include/linux/swap.h                    |   10 +
 mm/Kconfig                              |   14 +
 mm/Makefile                             |    1 +
 mm/memcontrol.c                         |  105 ++-
 mm/swap_cgroup_priority.c               | 1036 +++++++++++++++++++++++
 mm/swap_cgroup_priority.h               |  128 +++
 mm/swapfile.c                           |  108 ++-
 10 files changed, 1456 insertions(+), 27 deletions(-)
 create mode 100644 mm/swap_cgroup_priority.c
 create mode 100644 mm/swap_cgroup_priority.h

base-commit: 347e9f5043c89695b01e66b3ed111755afcf1911
-- 
2.34.1


