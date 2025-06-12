Return-Path: <cgroups+bounces-8500-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66561AD6E5D
	for <lists+cgroups@lfdr.de>; Thu, 12 Jun 2025 12:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A87C3B234D
	for <lists+cgroups@lfdr.de>; Thu, 12 Jun 2025 10:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEC423BF8F;
	Thu, 12 Jun 2025 10:53:33 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCE9238172
	for <cgroups@vger.kernel.org>; Thu, 12 Jun 2025 10:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749725613; cv=none; b=a6bhWbdbUksaD04gT6A3TzXaMcuEJWPPQfk7ntYvx0hsJSGwSJe8QvelVliHr7K5cV4hAVQkiHqJ/J7p81a6cHnmUj5CujiM0mmrL4qT81zQJji8TbZon7OWIt1yR6kNAWq6m9uJMI20Z8Yh/G6pQt7izwwjTXxL3QL60VXM9h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749725613; c=relaxed/simple;
	bh=fsmh8ymc/qgXLf+OUn3OWPLrZcRCCdD238LfC1FJo7U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QE9i51uZto4GHUM5RwFI0+VtGbcnhcnXGW2y2G+F2efAHYr3oZUOUPmVNaAfDq1IbfKpR2NHyjMWFrKHtXJdqm4ZCfOrXbu1+Y/8h6qa5RKlP53z6ki/WxGR10+TT5S99FwiyiOD7oWn8ZrMnQcsVvdchDNtGjOxpWnu2ZEC+cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330.lge.net) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 12 Jun 2025 19:38:28 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
From: youngjun.park@lge.com
To: linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shikemeng@huaweicloud.com,
	kasong@tencent.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	baohua@kernel.org,
	chrisl@kernel.org,
	muchun.song@linux.dev,
	iamjoonsoo.kim@lge.com,
	taejoon.song@lge.com,
	gunho.lee@lge.com,
	Youngjun Park <youngjun.park@lge.com>
Subject: [RFC PATCH 0/2] mm/swap, memcg: Support per-cgroup swap device prioritization
Date: Thu, 12 Jun 2025 19:37:42 +0900
Message-Id: <20250612103743.3385842-1-youngjun.park@lge.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Youngjun Park <youngjun.park@lge.com>

Introduction
============
I am a kernel developer working on platforms deployed on commercial consumer devices.
Due to real-world product requirements, needed to modify the Linux kernel to support
a new swap management mechanism. The proposed mechanism allows assigning different swap
priorities to swap devices per cgroup.
I believe this mechanism can be generally useful for similar constrained-device scenarios
and would like to propose it for upstream inclusion and solicit feedback from the community.

Motivation
==========
Core requirement was to improve application responsiveness and loading time, especially
for latency critical applications, without increasing RAM or storage hardware resources.
Device constraints:
  - Linux-based embedded platform
  - Limited system RAM
  - Small local swap
  - No option to expand RAM or local swap
To mitigate this, we explored utilizing idle RAM and storage from nearby devices as remote
swap space. To maximize its effectiveness, we needed the ability to control which swap devices
were used by different cgroups:
  - Assign faster local swap devices to latency critical apps
  - Assign remote swap devices to background apps
However, current Linux kernel swap infrastructure does not support per-cgroup swap device
assignment.
To solve this, I propose a mechanism to allow each cgroup to specify its own swap device
priorities.

Evaluated Alternatives
======================
1. **Per-cgroup dedicated swap devices**
   - Previously proposed upstream [1]
   - Challenges in managing global vs per-cgroup swap state
   - Difficult to integrate with existing memory.limit / swap.max semantics
2. **Multi-backend swap device with cgroup-aware routing**
   - Considered sort of layering violation (block device cgroup awareness)
   - Swap devices are commonly meant to be physical block devices.
   - Similar idea mentioned in [2]
3. **Per-cgroup swap device enable/disable with swap usage contorl**
   - Expand swap.max with zswap.writeback usage
   - Discussed in context of zswap writeback [3]
   - Cannot express arbitrary priority orderings 
    (e.g. swap priority A-B-C on cgroup C-A-B impossible)
   - Less flexible than per-device priority approach
4. **Per-namespace swap priority configuration**
   - In short, make swap namespace for swap device priority
   - Overly complex for our use case
   - Cgroups are the natural scope for this mechanism

Based on these findings, we chose to prototype per-cgroup swap priority configuration
as the most natural, least invasive extension of the existing kernel mechanisms.

Design and Semantics
====================
- Each swap device gets a unique ID at `swapon` time
- Each cgroup has a `memory.swap.priority` interface:
  - Show unique ID by memory.swap.priority interface
  - Format: `unique_id:priority,unique_id:priority,...`
  - All currently-active swap devices must be listed
  - Priorities follow existing swap infrastructure semantics
- The interface is writeable and updatable at runtime
- A priority configuration can be reset via `echo "" > memory.swap.priority`
- Swap on/off events propagate to all cgroups with priority configurations

Example Usage
-------------
# swap device on
$ swapon
NAME      TYPE      SIZE USED PRIO
/dev/sdb  partition 300M  0B   10
/dev/sdc  partition 300M  0B    5

# assign custom priorities in a cgroup
$ echo "1:5,2:10" > memory.swap.priority
$ cat memory.swap.priority
Active
/dev/sdb  unique:1  prio:5
/dev/sdc  unique:2  prio:10

# adding new swap device later
$ swapon /dev/sdd --priority -1
$ cat memory.swap.priority
Active
/dev/sdb  unique:1  prio:5
/dev/sdc  unique:2  prio:10
/dev/sdd  unique:3  prio:-2 

# reset cgroup priority
$ echo "" > memory.swap.priority
$ cat memory.swap.priority
Inactive
/dev/sdb  unique:1  prio:10
/dev/sdc  unique:2  prio:5
/dev/sdd  unique:3  prio:-2

Implementation Notes
====================
The items mentioned below are to be considered during the next patch work.

- Workaround using per swap cpu cluster as before 
- Priority propgation of child cgroup
- And other TODO, XXX
- Refactoring for reviewability and maintainability, comprehensive testing
  and performance evaluation

Future Work
===========
These are items that would benefit from further consideration 
and potential implementation.

- Support for per-process or anything else swap prioritization
- Optional usage limits per swap device (e.g., ratio, max bytes)
- Generalizing the interface beyond cgroups

References
==========
[1] https://lkml.iu.edu/hypermail/linux/kernel/1404.0/02530.html
[2] https://lore.kernel.org/linux-mm/CAMgjq7DGMS5A4t6nOQmwyLy5Px96aoejBkiwFHgy9uMk-F8Y-w@mail.gmail.com
[3] https://lore.kernel.org/lkml/CAF8kJuN-4UE0skVHvjUzpGefavkLULMonjgkXUZSBVJrcGFXCA@mail.gmail.com

All comments and feedback are greatly appreciated.
Patch will follow.

Sincerely,
Youngjun Park

youngjun.park (2):
  mm/swap, memcg: basic structure and logic for per cgroup swap priority
    control
  mm: swap: apply per cgroup swap priority mechansim on swap layer

 include/linux/memcontrol.h |   3 +
 include/linux/swap.h       |  11 ++
 mm/Kconfig                 |   7 +
 mm/memcontrol.c            |  55 ++++++
 mm/swap.h                  |  18 ++
 mm/swap_cgroup_priority.c  | 335 +++++++++++++++++++++++++++++++++++++
 mm/swapfile.c              | 129 ++++++++++----
 7 files changed, 523 insertions(+), 35 deletions(-)
 create mode 100644 mm/swap_cgroup_priority.c

base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
-- 
2.34.1


