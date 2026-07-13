Return-Path: <cgroups+bounces-17682-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Dg5BI35XVGpwkwMAu9opvQ
	(envelope-from <cgroups+bounces-17682-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 05:11:58 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7485746DCD
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 05:11:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=lge.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17682-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17682-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A70BA3007E21
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 03:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81809379C57;
	Mon, 13 Jul 2026 03:11:52 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo03.lge.com (lgeamrelo03.lge.com [156.147.51.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE02627B35B
	for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 03:11:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783912312; cv=none; b=GyeqNJexCVva3eUHU2YkO3nQXdWRiWSazX1N2jGETrTP90fLEnGawGHOicHb2xdpaTHEryZzdo84OiSDSAObg/P9HaSmLeq0myR7uY3IFqooNVfd01C4SPVkc0E30hyIXXYKOF/fmkiDRFRJry31bLl9VEIb3hwm/LU9X6smz1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783912312; c=relaxed/simple;
	bh=Po5njxvSjcWXacWac1+5h/VYOinCYBZzdpOOZoh2/3U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mL90sLst1O3r+3slKecowYblRQfkCJjJ9FpE6+A0FtHZaiJanWjGT9VZxY0fOwLneq7vewY3DHNUTiRo/M6GAIQeK59foYEkRllvukCZGYz3+sB5J8yArv3877MEUCa0vrWgeHlz1DZuGtvDEwqqWidJL7B+B4Wivsrau6uP1fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.102
Received: from unknown (HELO yjaykim-PowerEdge-T330.lge.net) (10.177.112.156)
	by 156.147.51.102 with ESMTP; 13 Jul 2026 11:56:47 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
From: Youngjun Park <youngjun.park@lge.com>
To: akpm@linux-foundation.org
Cc: chrisl@kernel.org,
	youngjun.park@lge.com,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kasong@tencent.com,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	shikemeng@huaweicloud.com,
	baoquan.he@linux.dev,
	baohua@kernel.org,
	yosry@kernel.org,
	joshua.hahnjy@gmail.com,
	gunho.lee@lge.com,
	taejoon.song@lge.com,
	hyungjun.cho@lge.com,
	baver.bae@lge.com,
	her0gyugyu@gmail.com
Subject: [PATCH v10 0/6] mm/swap, memcg: Introduce swap tiers for cgroup based swap control
Date: Mon, 13 Jul 2026 11:56:38 +0900
Message-Id: <20260713025644.170839-1-youngjun.park@lge.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lge.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17682-lists,cgroups=lfdr.de];
	FORGED_SENDER(0.00)[youngjun.park@lge.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,lge.com,kvack.org,vger.kernel.org,tencent.com,cmpxchg.org,linux.dev,huaweicloud.com,gmail.com];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:chrisl@kernel.org,m:youngjun.park@lge.com,m:linux-mm@kvack.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kasong@tencent.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:shikemeng@huaweicloud.com,m:baoquan.he@linux.dev,m:baohua@kernel.org,m:yosry@kernel.org,m:joshua.hahnjy@gmail.com,m:gunho.lee@lge.com,m:taejoon.song@lge.com,m:hyungjun.cho@lge.com,m:baver.bae@lge.com,m:her0gyugyu@gmail.com,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[youngjun.park@lge.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lge.com:mid,lge.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D7485746DCD

This is the v10 series of the swap tier patchset.

v10 folds in the Sashiko review fixes for the selftests added in v9 and
rebases onto the current mm-new. There are no functional changes to the
core swap or memcg code since v9; see the changelog for details.

For context, the bulk of the series is unchanged since v8, with great thanks
to Shakeel Butt and Yosry for the reviews and discussions [1] that shaped it.
The main change in v8 was the interface change to use memory.swap.tiers.max
with '0' (disable) and 'max' (enable) values. This mechanism was suggested
by Shakeel and Yosry.

This change allows for future extensions to control swap between tiers and
aligns better with existing memcg interfaces. It is confined to patch #3's
user-facing interface; internally, patch #3 still uses the existing mask
processing method, which is implementation-efficient.

We also discussed tier extensions. Thanks to Yosry, Nhat and Shakeel for their
valuable feedback.

Here is a brief summary of our tentative conclusions. Please correct me
if anything is misrepresented (details in references):

* Zswap tiering [2]:
  Zswap can itself be a tier (typically the fastest one). But, until vswap lands, 
  zswap cannot be the only allowed tier, 
  since it still needs a physical device for allocation;
  that restriction can be lifted once vswap is supported.
* Vswap tiering [3]:
  Vswap should be handled transparently to the user. Vswap itself will
  not be tiered. But, someday supported if there is strong and real usecase.
* Relationship with zswap.writeback [4]:
  If zswap tiering is introduced, it could replace the zswap-only tier.
  However, since zswap cannot be tiered independently without vswap, it is still
  needed for non-vswap cases.
* Tier demotion [5]:
  A separate interface like memory.swap.tiers.demotion might be needed.
  For now, we only support 0/max to enable/disable tiers. A future "auto"
  mode could scale a per-tier limit from swapfile size and memory.swap.max,
  similar to the direction memory tiering is heading in; the exact
  default-scaling behaviour is still under discussion.

I plan to apply the swap tier infrastructure and the first use case
(cgroup-based swap control) first, and continue following up on the
discussions above.

Overview
========

Swap Tiers group swap devices into performance classes (e.g. NVMe,
HDD, Network) and allow per-memcg selection of which tiers to use.
This mechanism was suggested by Chris Li.

Design Rationale
================

Swap tier selection is attached to memcg. A child cgroup may select a
subset of the parent's allowed tiers.

This
- Preserves cgroup inheritance semantics (boundary at parent,
  refinement at child).
- Reuses memcg, which already groups processes and enforces
  hierarchical memory limits.
- Aligns with existing memcg swap controls (e.g. swap.max, zswap.writeback)
- Avoids introducing a parallel swap control hierarchy.

Placing tier control outside memcg (e.g., via BPF, syscalls, or
madvise) would allow swap preference to diverge from the memcg
hierarchy. Integrating it into memcg keeps the swap policy
consistent with existing memory ownership semantics. There are
also real use cases built around memcg.

In the future, this can be extended to other interfaces to cover
additional use cases.

I believe a memcg-based swap control is a good starting point
before such extensions.

Use Cases
=========

#1: Latency separation (our primary deployment scenario)
  [ / ]
     |
     +-- latency-sensitive workload  (fast tier)
     +-- background workload         (slow tier)

The parent defines the memory boundary.
Each workload selects a swap tier via memory.swap.tiers.max according to
latency requirements.

This prevents latency-sensitive workloads from being swapped to
slow devices used by background workloads.

#2: Per-VM swap selection (Chris Li's deployment scenario)
  [ / ]
     |
     +-- [ Job on VM ]              (tiers: zswap, SSD)
            |
            +-- [ VMM guest memory ]  (tiers: SSD)

The parent (job) has access to both zswap and SSD tiers.
The child (VMM guest memory) selects SSD as its swap tier via
memory.swap.tiers.max. In this deployment, swap device selection
happens at the child level from the parent's available set.

#3: Tier isolation for reduced contention (hypothetical)
  [ / ]                    (tiers: A, B)
     |
     +-- workload X        (tiers: A)
     +-- workload Y        (tiers: B)

Each child uses a different tier. Since swap paths are separated
per tier, synchronization overhead between the two workloads is
reduced.

Future extension (Follow up)
============================

#1: Intra-tier distribution policy:
  Currently, swap devices with the same priority are allocated in a
  round-robin fashion. Per-tier policy files under
  /sys/kernel/mm/swap/tiers/ can control how devices within a tier
  are selected (e.g. round-robin, weighted).

#2: Inter-tier promotion and demotion:
  Promotion and demotion apply between tiers, not within a single
  tier. The current interface defines only tier assignment; it does
  not yet define when or how pages move between tiers. Two triggering
  models are possible:

  (a) User-triggered: userspace explicitly initiates migration between
      tiers (e.g. via a new interface or existing move_pages semantics).
  (b) Kernel-triggered: the kernel moves pages between tiers at
      appropriate points such as reclaim or refault.

#3: Per-VMA, per-process swap and BPF:
  Not just for memcg based swap, possible to extend Per-VMA or per-process
  swap. Or we can use it as BPF program.

#4: Zswap and vswap tiering:
  Tiering applies to the vswap + zswap combination.

#5: Vswap on/off control:
  Currently not supported. If a strong use case arises where vswap needs
  to be controlled by memcg, the tier interface could be used for it.

#6: Per-CPU swap allocation caching:
  Per-si/per-tier per-CPU caching of allocations to reduce contention in
  the tier-filtered allocation path.

Experimentation
===============

Tested on our internal platform using NBD as a separate swap tier.
Our first production's simple usecase.

Without tiers:
- No selective control over flash wear
- Cannot selectively assign NBD to specific applications

Cold launch improvement (preloaded vs. baseline):
- App A: 13.17s -> 4.18s (68%)
- App B: 5.60s -> 1.12s (80%)
- App C: 10.25s -> 2.00s (80%)

Performance impact with no tiers configured:
<1% regression in kernel build and vm-scalability benchmarks

Change log
===========

v10
- selftests: applied the Sashiko review fixes, and dropped redundant comments and dead code.
  (#5, #6 patches)
- Rebased on recent mm-new.
- v9 link: https://lore.kernel.org/linux-mm/20260620181635.299364-1-youngjun.park@lge.com/

v9
- Added selftests (per Nhat's request):
 - selftests/mm: swap tier configuration test for /sys/kernel/mm/swap/tiers.(#5 patch)
 - selftests/cgroup: swap tier routing test for memory.swap.tiers.max. (#6 patch)
- Removed the redundant rcu_read_lock() around the memcg tier-mask tree walk;
  for_each_mem_cgroup_tree() already takes RCU internally and returns each
  memcg with a reference held. (#3 patch)
- Sashiko review: swap_sync_discard() now honors the memcg tier mask, so the
  discard fallback no longer drains clusters on disallowed tiers. Left as-is:
  the cgroup tree walk under spinlock (bounded by cgroup.max.descendants, an
  admin-controlled limit, and triggered only by infrequent tier writes) and
  the pre-existing swap_avail_lock drop in swap_alloc_slow(). (#4 patch)
- Dropped patch #4's Reviewed-by tags (Nhat, Kairui, Baoquan): the
  swap_sync_discard() change above modifies that patch (the tier mask is now
  passed as a parameter into the alloc and discard paths), so the earlier tags
  no longer apply. Re-review would be welcome.
- v8 link: https://lore.kernel.org/linux-mm/20260617053447.2831896-1-youngjun.park@lge.com/

v8
- Changed the memcg interface to memory.swap.tiers.max.
  Values are '0' (disable) and 'max' (enable). Default is 'max'.
- Addressed Sashiko's review: Update the mask value atomically at once and
  read the mask value while grabbing lock.
- Collected review tags from Kairui and Nhat.
- Rebase on recent mm-new
- v7 link: https://lore.kernel.org/linux-mm/20260527062247.3440692-1-youngjun.park@lge.com/

v7
- Collect Baoquan's review tag
- Baoquan's feedback on fixing improper comment
- Minor code adjustments per Baoquan's feedback.
- Rebase on recent mm-new
- v6 link: https://lore.kernel.org/linux-mm/20260421055323.940344-1-youngjun.park@lge.com/

v6
- Sashiko AI review fixes
 - Fix batch parsing error path to restore snapshot before exit
 - Reject overlong tier names to prevent truncated duplicates
 - Avoid restoring raw list_head via memcpy (stale pointer risk)
 - Ensure early parse errors do not skip DEF_SWAP_PRIO validation
 - Use (1U << TIER_DEFAULT_IDX) to avoid signed shift UB
 - Defer tier mask inheritance to css_online() to close race window
 - Add READ_ONCE()/WRITE_ONCE() for tier mask accesses
- Other fixes
 - Fix build error reintroduced due to missing v5 change
 - Fix WARNING in folio_tier_effective_mask by adding rcu_read_lock()
 - default number of swap tier max (change to 32->31, for reserving last bit)
 - commit message refinement.
 - rebased on recently mm-new
- v5 link: https://lore.kernel.org/linux-mm/20260325175453.2523280-1-youngjun.park@lge.com/

v5
- Fixed build errors reported in v4
- rebased on up to date mm-new
- Minor cleanups
- Design docs with validation (by Shakeel Butt discussion)
- v4 link : https://lore.kernel.org/linux-mm/20260217000950.4015880-1-youngjun.park@lge.com/

v4
- Simplified control flow and indentation
- Added CONFIG option for MAX_SWAPTIER (default: 4)
- Added memory.swap.tiers.effective interface
- Reworked save/restore logic into snapshot/rollback model
- Removed tier priority modification support (deferred)
- Improved validation and fixed edge cases
- Rebased onto latest mm-new
- RFC v3 link: https://lore.kernel.org/linux-mm/20260131125454.3187546-1-youngjun.park@lge.com/

RFC v1 ~ v3
- Change the direction after discussion with Chris-Li
- apply some LPC feedback.
- RFC v2 - https://lore.kernel.org/linux-mm/20260126065242.1221862-1-youngjun.park@lge.com/
- RFC v1 - https://lore.kernel.org/linux-mm/20251109124947.1101520-1-youngjun.park@lge.com/

Earlier Approach (per cgroup swap priority)
- v1: https://lore.kernel.org/linux-mm/20250716202006.3640584-1-youngjun.park@lge.com/
- RFC: https://lore.kernel.org/linux-mm/aEvLjEInMQC7hEyh@yjaykim-PowerEdge-T330/T/#mbbb6a5e9e30843097e1f5f65fb98f31d582b973d

Reference
=========

[1] https://lore.kernel.org/linux-doc/aiw2p5ANjsQUCIHA@linux.dev/
[2] https://lore.kernel.org/linux-mm/CAKEwX=Nz9SWcEVQGQjHN8P8OANJY4BG0w+iQOzoNOWuteoVjAg@mail.gmail.com/
[3] https://lore.kernel.org/cgroups/CAKEwX=O23a4iWBZoewKVb8QqODte6r3Xijckw3_oCJNoiO9M5A@mail.gmail.com/
[4] https://lore.kernel.org/linux-mm/CAO9r8zOg0OP1Ak1v7CRzSfQq0D8b4Dw+_T0Jui6YTM_KwQQNOA@mail.gmail.com/
[5] https://lore.kernel.org/linux-mm/CAO9r8zNi4-QC4sUi=xXWHt9WMeG39mbyoSf8kON9vLOZ=cbCmw@mail.gmail.com/

Youngjun Park (6):
  mm: swap: introduce swap tier infrastructure
  mm: swap: associate swap devices with tiers
  mm: memcontrol: add interface for swap tier selection
  mm: swap: filter swap allocation by memcg tier mask
  selftests/mm: add a swap tier configuration test
  selftests/cgroup: add a swap tier routing test

 Documentation/admin-guide/cgroup-v2.rst       |  20 +
 Documentation/mm/index.rst                    |   1 +
 Documentation/mm/swap-tier.rst                | 159 ++++++
 MAINTAINERS                                   |   3 +
 include/linux/memcontrol.h                    |   5 +
 include/linux/swap.h                          |   1 +
 mm/Kconfig                                    |  12 +
 mm/Makefile                                   |   2 +-
 mm/memcontrol.c                               |  67 +++
 mm/swap.h                                     |   4 +
 mm/swap_state.c                               |  75 +++
 mm/swap_tier.c                                | 477 ++++++++++++++++
 mm/swap_tier.h                                |  76 +++
 mm/swapfile.c                                 |  34 +-
 tools/testing/selftests/cgroup/.gitignore     |   1 +
 tools/testing/selftests/cgroup/Makefile       |   2 +
 tools/testing/selftests/cgroup/config         |   2 +
 .../selftests/cgroup/test_swap_tiers.c        | 509 ++++++++++++++++++
 tools/testing/selftests/mm/.gitignore         |   1 +
 tools/testing/selftests/mm/Makefile           |   1 +
 tools/testing/selftests/mm/config             |   2 +
 tools/testing/selftests/mm/run_vmtests.sh     |   5 +
 tools/testing/selftests/mm/swap_tier.c        | 337 ++++++++++++
 23 files changed, 1785 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/mm/swap-tier.rst
 create mode 100644 mm/swap_tier.c
 create mode 100644 mm/swap_tier.h
 create mode 100644 tools/testing/selftests/cgroup/test_swap_tiers.c
 create mode 100644 tools/testing/selftests/mm/swap_tier.c

base-commit: 61cccb8363fcc282d4ae0555b8739dd227f5ad0b
-- 
2.34.1

