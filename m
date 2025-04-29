Return-Path: <cgroups+bounces-7912-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F112AA3C5C
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 01:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADFC99A1D19
	for <lists+cgroups@lfdr.de>; Tue, 29 Apr 2025 23:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF8F2DCB53;
	Tue, 29 Apr 2025 23:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnOMG7NW"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015577405A;
	Tue, 29 Apr 2025 23:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745969933; cv=none; b=lF4tMWoFO+166DVqXmU0LJQDZVRvGK65/HoHdMxtQwmsHfRRrtJUof0yKulmYUf99nK6pLWmwNOizeEni/iK8rOETpquyTJdH+uV0o9+oejONT6hBwYDGIfbzqftXQWqdAMMEhqhQ8eBLCO/G3YbLDwZi8QFWzWs2NEYsCYxvc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745969933; c=relaxed/simple;
	bh=hlSk52nL/Lpt9htAXZ4ME42f4x6bT2+Mppgk82stef0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t25ALBnyoPZ/VdpjY9ihzC3E5tFkczlJDpylUARym/FaDGupwvjBtdq0y9I0fP3bZt4ZZKxN8YbJOUAiYvdPlUAy3CFBvEjtiMAnfi+VgR6iE+t0JtZZJc3iVtBVA6qpmD/yAIxjUKOuKo2PK3rdqGiWqaXqjMik8feX7D2BsRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnOMG7NW; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6ff27ad48beso58157257b3.0;
        Tue, 29 Apr 2025 16:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745969930; x=1746574730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gePul1KgQzD1b8fl0CS+HEj/lRMwit72cbZ3gcB0As8=;
        b=LnOMG7NWRoP7v7KzMOa5wVsQEhnHrwu4jFPW+1D/e9L8wtgmq5waGKrpHwDelLaLH9
         yTgOw7ThIMtsM56uz7HND1zYjaWV47Kd8Mxad2ANDYLkTlum5dVuZq5RBCUtkDN45RPF
         5w6HAtDsT+1XYIrthxMmmXlPFr/347ZDuk06/Sk5FbTY5qbCMmVF9M/eyos06hSSyg9v
         pMEqLUaCH2e38dj1W40gLaxOexNf0ZsAZ9KUh77vLoQubgWbiOc1Od8RDpHuz5Y7wvae
         FiebXvwMHZvUv/Urq6agxaLBDVFpUcwyWg5CEZcRyr9cG1CkdCat1s6whzGHPeZctTPw
         ulew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745969930; x=1746574730;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gePul1KgQzD1b8fl0CS+HEj/lRMwit72cbZ3gcB0As8=;
        b=G5LmQ+GzY5baIVMXV2xvWc4TKZ6mao10uCidTZmx4HS7JoDgJILMVvUb42RqoDNkYX
         CZmP+TV6CFFZzmTC8hm1QT7XLzPnzdgWmZ3FjHaRcAItXUHXsov8HUuEv8+pwqX2arjx
         QFOWQ1fCqK/xzgRgFU6pE0AUVBLMBdKmJxPke0pJy+YiL7Wrtzz+VIFB5/sePFdu+ZA6
         HQFA+w771ThwKKA5OrFAGhcT3DPG61JyAp6nKZlwopRsYOiDpgvT3PSW1oq6fgH/Wrd1
         lhPXJnDZVWg8CU3PZk09JT8t+bPt/+kIkZsJzDXBDCfB1jW2jN3U4x6FIoTbM20t6vFM
         WWig==
X-Forwarded-Encrypted: i=1; AJvYcCUtqS7NSLrt7vW/JBMhF4dP8Z+2W7Q5/3qaeivDGNJJnt0cUQkpFEf3UHCKgofvg5G/dU1fHAcCWpo=@vger.kernel.org, AJvYcCX1fW+chjLw3GzOgoSLEgW6gdjVSr29iEdrwmH1D0JyQjWbQAOWKKpWpvwhNMw46Qvro51GQ5KI@vger.kernel.org, AJvYcCXcQIx3f7m6c9fBD1icaqgHdA05+0L6jhwHtewtAY54r8ho2YjgIPAwuyNGzwx4BYtX57x587/UA9gjLz1L@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu3lbbc1nPHk0N0iRl+y1LDJ5mjphCUmsdsqb4DJf0801nRcV1
	9zCvZqVwIgYaOGTjTAXjgH7yTAsAXeMn0IPha5XjgaAapWcGZjr3
X-Gm-Gg: ASbGncvdmOSt/83SBxcnJZjG99AgeCcOt7iRy72h8vaqALLA+dr2QVSQIeQPN0YaDS0
	+GDsGv+LTRgvsdoWWmXIRUF84QvcHea8AafolVin5rA2Z6hBK7YOWJ/xmgfvPQteAwlUFxdNGJZ
	88r0FBpcLXN+J5zqPVOw1rEXoN0xd5h3MrNjVI0qfGUG0KuqYZHRWGp+wXKc5zkyGO+d9A+oYJi
	z6N/IDvMOoVUZfer5A18EUTIkWj6wIE2Ror9aK1NSb7uRtT2gxWfKx1wNZPwxGyr/zRF20GwQ4y
	R6M7UmzAA3BuixDSrXfAGq+/mRKhafQH3uDevQhT5g==
X-Google-Smtp-Source: AGHT+IHcojEKPUynJHlkXeBB7Cg37TCJuV1VyFIjPKbx+ERWUlA9J38SsranpjERy0Je9HGz5EpfFA==
X-Received: by 2002:a05:690c:998d:b0:706:aedf:4d91 with SMTP id 00721157ae682-708abd7da59mr20739557b3.14.1745969929646;
        Tue, 29 Apr 2025 16:38:49 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:8::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-708ae1b43dcsm723047b3.70.2025.04.29.16.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 16:38:49 -0700 (PDT)
From: Nhat Pham <nphamcs@gmail.com>
To: linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	hughd@google.com,
	yosry.ahmed@linux.dev,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	len.brown@intel.com,
	chengming.zhou@linux.dev,
	kasong@tencent.com,
	chrisl@kernel.org,
	huang.ying.caritas@gmail.com,
	ryan.roberts@arm.com,
	viro@zeniv.linux.org.uk,
	baohua@kernel.org,
	osalvador@suse.de,
	lorenzo.stoakes@oracle.com,
	christophe.leroy@csgroup.eu,
	pavel@kernel.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-pm@vger.kernel.org,
	peterx@redhat.com
Subject: [RFC PATCH v2 00/18] Virtual Swap Space
Date: Tue, 29 Apr 2025 16:38:28 -0700
Message-ID: <20250429233848.3093350-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changelog:
* v2:
	* Use a single atomic type (swap_refs) for reference counting
	  purpose. This brings the size of the swap descriptor from 64 KB
	  down to 48 KB (25% reduction). Suggested by Yosry Ahmed.
	* Zeromap bitmap is removed in the virtual swap implementation.
	  This saves one bit per phyiscal swapfile slot.
	* Rearrange the patches and the code change to make things more
	  reviewable. Suggested by Johannes Weiner.
	* Update the cover letter a bit.

This RFC implements the virtual swap space idea, based on Yosry's
proposals at LSFMMBPF 2023 (see [1], [2], [3]), as well as valuable
inputs from Johannes Weiner. The same idea (with different
implementation details) has been floated by Rik van Riel since at least
2011 (see [8]).


I. Motivation

Currently, when an anon page is swapped out, a slot in a backing swap
device is allocated and stored in the page table entries that refer to
the original page. This slot is also used as the "key" to find the
swapped out content, as well as the index to swap data structures, such
as the swap cache, or the swap cgroup mapping. Tying a swap entry to its
backing slot in this way is performant and efficient when swap is purely
just disk space, and swapoff is rare.

However, the advent of many swap optimizations has exposed major
drawbacks of this design. The first problem is that we occupy a physical
slot in the swap space, even for pages that are NEVER expected to hit
the disk: pages compressed and stored in the zswap pool, zero-filled
pages, or pages rejected by both of these optimizations when zswap
writeback is disabled. This is the arguably central shortcoming of
zswap:
* In deployments when no disk space can be afforded for swap (such as
  mobile and embedded devices), users cannot adopt zswap, and are forced
  to use zram. This is confusing for users, and creates extra burdens
  for developers, having to develop and maintain similar features for
  two separate swap backends (writeback, cgroup charging, THP support,
  etc.). For instance, see the discussion in [4].
* Resource-wise, it is hugely wasteful in terms of disk usage. At Meta,
  we have swapfile in the order of tens to hundreds of GBs, which are
  mostly unused and only exist to enable zswap usage and zero-filled
  pages swap optimizations. This also implicitly limits the memory
  saving potentials of these swap optimizations by the static size of
  the swapfile, which is especially problematic in high memory systems
  that can have up to TBs worth of memory.
* Operationally, the old design poses significant challenges, because
  the sysadmin has to prescribe how much swap is needed a priori, for
  each combination of (memory size x disk space x workload usage). It
  is even more complicated when we take into account the variance of
  memory compression, which changes the reclaim dynamics (and as a
  result, swap space requirement). The problem is further exarcebated
  for users who rely on swap utilization (and exhaustion) as an OOM
  signal.

Another motivation for a swap redesign is to simplify swapoff, which
is both complicated and expensive in the current design. Tight coupling
between a swap entry and its backing storage means that it requires a
whole page table walk to update all the page table entries that refer to
this swap entry, as well as updating all the associated swap data
structures (swap cache, etc.).


II. High Level Design Overview

To fix the aforementioned issues, we need an abstraction that separates
a swap entry from its physical backing storage. IOW, we need to
“virtualize” the swap space: swap clients will work with a dynamically
allocated virtual swap slot, storing it in page table entries, and
using it to index into various swap-related data structures. The
backing storage is decoupled from the virtual swap slot, and the newly
introduced layer will “resolve” the virtual swap slot to the actual
storage. This layer also manages other metadata of the swap entry, such
as its lifetime information (swap count), via a dynamically allocated,
per-swap-entry descriptor:

struct swp_desc {
	union {
		swp_slot_t slot;
		struct folio *folio;
		struct zswap_entry *zswap_entry;
	};
	struct rcu_head rcu;

	rwlock_t lock;
	enum swap_type type;

#ifdef CONFIG_MEMCG
	atomic_t memcgid;
#endif

	atomic_t swap_refs;
};

The size of the swap descriptor (without debug config options) is 48
bytes.

This design allows us to:
* Decouple zswap (and zeromapped swap entry) from backing swapfile:
  simply associate the virtual swap slot with one of the supported
  backends: a zswap entry, a zero-filled swap page, a slot on the
  swapfile, or an in-memory page.
* Simplify and optimize swapoff: we only have to fault the page in and
  have the virtual swap slot points to the page instead of the on-disk
  physical swap slot. No need to perform any page table walking.

Please see the attached patches for implementation details.

Note that I do not remove the old implementation for now. Users can
select between the old and the new implementation via the
CONFIG_VIRTUAL_SWAP build config. This will also allow us to land the
new design, and iteratively optimize upon it (without having to include
everything in an even more massive patch series).


III. Future Use Cases

While the patch series focus on two applications (decoupling swap
backends and swapoff optimization/simplification), this new,
future-proof design also allows us to implement new swap features more
easily and efficiently:

* Multi-tier swapping (as mentioned in [5]), with transparent
  transferring (promotion/demotion) of pages across tiers (see [8] and
  [9]). Similar to swapoff, with the old design we would need to
  perform the expensive page table walk.
* Swapfile compaction to alleviate fragmentation (as proposed by Ying
  Huang in [6]).
* Mixed backing THP swapin (see [7]): Once you have pinned down the
  backing store of THPs, then you can dispatch each range of subpages
  to appropriate swapin handle.
* Swapping a folio out with discontiguous physical swap slots
  (see [10]).
* Zswap writeback optimization: The current architecture pre-reserves
  physical swap space for pages when they enter the zswap pool, giving
  the kernel no flexibility at writeback time. With the virtual swap
  implementation, the backends are decoupled, and physical swap space
  is allocated on-demand at writeback time, at which point we can make
  much smarter decisions: we can batch multiple zswap writeback
  operations into a single IO request, allocating contiguous physical
  swap slots for that request. We can even perform compressed writeback
  (i.e writing these pages without decompressing them) (see [12]).


IV. Potential Issues

Here is a couple of issues I can think of, along with some potential
solutions:

1. Space overhead: we need one swap descriptor per swap entry.
* Note that this overhead is dynamic, i.e only incurred when we actually
  need to swap a page out.
* The swap descriptor replaces many other swap data structures:
  swap_cgroup arrays, zeromap, etc.
* It can be further offset by swap_map reduction: we only need 3 states
  for each entry in the swap_map (unallocated, allocated, bad). The two
  last states are potentially mergeable, reducing the swap_map to a
  bitmap.

2. Lock contention: since the virtual swap space is dynamic/unbounded,
we cannot naively range partition it anymore. This can increase lock
contention on swap-related data structures (swap cache, zswap’s xarray,
etc.).
* The problem is slightly alleviated by the lockless nature of the new
  reference counting scheme, as well as the per-entry locking for
  backing store information.
* Johannes suggested that I can implement a dynamic partition scheme, in
  which new partitions (along with associated data structures) are
  allocated on demand. It is one extra layer of indirection, but global
  locking will only be done only on partition allocation, rather than on
  each access. All other accesses only take local (per-partition)
  locks, or are completely lockless (such as partition lookup).

  This idea is very similar to Kairui's work to optimize the (physical)
  swap allocator. He is currently also working on a swap redesign (see
  [11]) - perhaps we can combine the two efforts to take advantage of
  the swap allocator's efficiency for virtual swap.


V. Benchmarking

As a proof of concept, I run the prototype through some simple
benchmarks:

1. usemem: 16 threads, 2G each, memory.max = 16G

I benchmarked the following usemem commands:

time usemem --init-time -w -O -s 10 -n 16 2g

Baseline:
real: 33.96s
user: 25.31s
sys: 341.09s
average throughput: 111295.45 KB/s
average free time: 2079258.68 usecs

New Design:
real: 35.87s
user: 25.15s
sys: 373.01s
average throughput: 106965.46 KB/s
average free time: 3192465.62 usecs

To root cause this regression, I ran perf on the usemem program, as
well as on the following stress-ng program:

perf record -ag -e cycles -G perf_cg -- ./stress-ng/stress-ng  --pageswap $(nproc) --pageswap-ops 100000

and observed the (predicted) increase in lock contention on swap cache
accesses. This regression is alleviated if I put together the
following hack: limit the virtual swap space to a sufficient size for
the benchmark, range partition the swap-related data structures (swap
cache, zswap tree, etc.) based on the limit, and distribute the
allocation of virtual swap slotss among these partitions (on a per-CPU
basis):

real: 34.94s
user: 25.28s
sys: 360.25s
average throughput: 108181.15 KB/s
average free time: 2680890.24 usecs

As mentioned above, I will implement proper dynamic virtual swap space
partitioning in a follow-up work, or adopt Kairui's solution.

2. Kernel building: zswap enabled, 52 workers (one per processor),
memory.max = 3G.

Baseline:
real: 183.55s
user: 5119.01s
sys: 655.16s

New Design:
real: mean: 184.5s
user: mean: 5117.4s
sys: mean: 695.23s

New Design (Static Partition)
real: 183.95s
user: 5119.29s
sys: 664.24s

3. Swapoff: 32 GB swapfile, 50% full, with a process that mmap-ed a
128GB file.

Baseline:
real: 25.54s
user: 0.00s
sys: 11.48s
    
New Design:
real: 11.69s
user: 0.00s
sys: 9.96s
    
The new design reduces the kernel CPU time by about 13%. There is also
reduction in real time, but this is mostly due to more asynchronous IO
(rather than the design itself) :)


VI. TODO list

This RFC includes a feature-complete prototype on top of 6.14. Here are
some action items:

Short-term: needs to be done before merging
* More clean-ups and stress-testing.
* Add more documentation of the new design and its API.

Medium-term: optimizations required to make virtual swap implementation
the default:
* Shrinking the swap map.
* Range partition the virtual swap space.
* More benchmarking and experiments in a variety of use cases.

Long-term: removal of the old implementation and other non-blocking
opportunities
* Remove the old implementation, when there are no major regressions and
  bottlenecks, etc remained with the new design.
* Merge more existing swap data structures into this layer (the MTE
  swap xarray for e.g).
* Adding new use cases :)


VII. References

[1]: https://lore.kernel.org/all/CAJD7tkbCnXJ95Qow_aOjNX6NOMU5ovMSHRC+95U4wtW6cM+puw@mail.gmail.com/
[2]: https://lwn.net/Articles/932077/
[3]: https://www.youtube.com/watch?v=Hwqw_TBGEhg
[4]: https://lore.kernel.org/all/Zqe_Nab-Df1CN7iW@infradead.org/ 
[5]: https://lore.kernel.org/lkml/CAF8kJuN-4UE0skVHvjUzpGefavkLULMonjgkXUZSBVJrcGFXCA@mail.gmail.com/
[6]: https://lore.kernel.org/linux-mm/87o78mzp24.fsf@yhuang6-desk2.ccr.corp.intel.com/
[7]: https://lore.kernel.org/all/CAGsJ_4ysCN6f7qt=6gvee1x3ttbOnifGneqcRm9Hoeun=uFQ2w@mail.gmail.com/
[8]: https://lore.kernel.org/linux-mm/4DA25039.3020700@redhat.com/
[9]: https://lore.kernel.org/all/CA+ZsKJ7DCE8PMOSaVmsmYZL9poxK6rn0gvVXbjpqxMwxS2C9TQ@mail.gmail.com/
[10]: https://lore.kernel.org/all/CACePvbUkMYMencuKfpDqtG1Ej7LiUS87VRAXb8sBn1yANikEmQ@mail.gmail.com/
[11]: https://lore.kernel.org/all/CAMgjq7BvQ0ZXvyLGp2YP96+i+6COCBBJCYmjXHGBnfisCAb8VA@mail.gmail.com/
[12]: https://lore.kernel.org/linux-mm/ZeZSDLWwDed0CgT3@casper.infradead.org/

Nhat Pham (18):
  swap: rearrange the swap header file
  swapfile: rearrange functions
  swapfile: rearrange freeing steps
  mm: swap: add an abstract API for locking out swapoff
  mm: swap: add a separate type for physical swap slots
  mm: create scaffolds for the new virtual swap implementation
  mm: swap: zswap: swap cache and zswap support for virtualized swap
  mm: swap: allocate a virtual swap slot for each swapped out page
  swap: implement the swap_cgroup API using virtual swap
  swap: manage swap entry lifetime at the virtual swap layer
  mm: swap: temporarily disable THP swapin and batched freeing swap
  mm: swap: decouple virtual swap slot from backing store
  zswap: do not start zswap shrinker if there is no physical swap slots
  memcg: swap: only charge physical swap slots
  vswap: support THP swapin and batch free_swap_and_cache
  swap: simplify swapoff using virtual swap
  swapfile: move zeromap setup out of enable_swap_info
  swapfile: remove zeromap in virtual swap implementation

 MAINTAINERS                |    7 +
 include/linux/mm_types.h   |    7 +
 include/linux/shmem_fs.h   |    3 +
 include/linux/swap.h       |  263 ++++++-
 include/linux/swap_slots.h |    2 +-
 include/linux/swapops.h    |   37 +
 kernel/power/swap.c        |    6 +-
 mm/Kconfig                 |   25 +
 mm/Makefile                |    3 +
 mm/huge_memory.c           |    5 +-
 mm/internal.h              |   25 +-
 mm/memcontrol.c            |  166 +++--
 mm/memory.c                |  103 ++-
 mm/migrate.c               |    1 +
 mm/page_io.c               |   60 +-
 mm/shmem.c                 |   29 +-
 mm/swap.h                  |   45 +-
 mm/swap_cgroup.c           |   10 +-
 mm/swap_slots.c            |   28 +-
 mm/swap_state.c            |  140 +++-
 mm/swapfile.c              |  831 +++++++++++++--------
 mm/userfaultfd.c           |   11 +-
 mm/vmscan.c                |   26 +-
 mm/vswap.c                 | 1400 ++++++++++++++++++++++++++++++++++++
 mm/zswap.c                 |   80 ++-
 25 files changed, 2799 insertions(+), 514 deletions(-)
 create mode 100644 mm/vswap.c


base-commit: 922ceb9d4bb4dae66c37e24621687e0b4991f5a4
-- 
2.47.1

