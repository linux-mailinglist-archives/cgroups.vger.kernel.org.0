Return-Path: <cgroups+bounces-7403-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3117A7F14B
	for <lists+cgroups@lfdr.de>; Tue,  8 Apr 2025 01:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFC883B71AA
	for <lists+cgroups@lfdr.de>; Mon,  7 Apr 2025 23:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C84022A4DA;
	Mon,  7 Apr 2025 23:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXnSt5Uu"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FA922333A;
	Mon,  7 Apr 2025 23:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744069347; cv=none; b=M8aIbyGIXCq//NvutMAfXV/Ismpm918cGrfyyGM77YltxJT2DOtcYgNfALXirFHiddP7alk2k50Zd8o+ELn32uxziBaBZXMvBlyHVZIgs6b+9KYLqksW0VsrigW+eSDK7SJuz6wrY95LiW/UUmBYQ2nclDAflt6xW1yfVPztuOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744069347; c=relaxed/simple;
	bh=oVpGe41fPmMvTdpNiXWH03bFXUxDuyC13/Zx0z7PH1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ui4dkQrsdvsRrsCk0iSnaXO2n6Q6NQbPqgn5MNViGsPFEHHc4SKMz36y5kz0zDIMpEQWZ/GG2mWGjkopBfJNpMyYhRcHscJ3wH7s0FxyHt7E8SGjzPkeO6fHyNCsSIy38MakdyjLvlh+J54G+bRf4E9Jp4GxakGq5rw75G1MAvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXnSt5Uu; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6ef9b8b4f13so46301837b3.2;
        Mon, 07 Apr 2025 16:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744069344; x=1744674144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lPtPHm7folqaXA12HoWBFzL/TwIC4oWfVtcHYTJdZgQ=;
        b=DXnSt5Uuyzq0fBPwBnrHlJo/jJMlfHpcPY5GPiU5hTxWnh4L3Bj9QTlj4ns64YrIzA
         jBsMDlFbJmAyR2cvlldYSFmov8zOgohZFFaEwskYbeX0gYr+0dUysCQMzvFTTTFzHJFf
         u4f+Mdd4sgK8rC3tjvPN/OKsR6rLwSDFczY651trGRcpmcNq85ed6/0WDrQx9pqULnG/
         jHzNRycr5hEOa+ZTNlcwcU7A1Xn4jt37w2Tvh1v2orYFnPY2snqBv7ts3Q5q5RmSNuBE
         R0FZkToNsi8cNu5c7r3RQJZr0tSRg2hyHeOcKjlNIcFGuQUt5RWnZkoVoCR+8O9leozq
         3oBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744069344; x=1744674144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lPtPHm7folqaXA12HoWBFzL/TwIC4oWfVtcHYTJdZgQ=;
        b=aAmB7as/p2EF2MjjodX+XOqPDmOW7ypgJb1TcjewVrSCWXLLNOmIjqtMLAVNwcd7Hj
         vBq33Gaj7nkm5aWbaO6axb6fPAKFr2CQIt9qwPXfcbnSeA0HvlbfLXEKQ2wCcAIH9mTE
         iQIRUEeNmG6n5OfWYlU5huZINjraC1N10ImZBbP8c9uQ59hhC9QRHjr09vxQV95uT0hU
         Eywd3Pm9RvHWtsyDeFXKfUw7+qtiBNlmM03CKpjNPVHO3v+kzlulbbiVvLx2mI61BQyA
         HRCZ5ChZCfMTPnA5gqJVvKUFsoVkbzyGTiqrgeIAkmtB2AmZ+DINnM+iJ3yZS+szqCYC
         K4FA==
X-Forwarded-Encrypted: i=1; AJvYcCWEOuWCuPnis05+RRvJCeUVoMnY9u/D179C2zDzq5i89SlmuhXuLRz3CR7pkvfqBFHYYiL3zCaeip30Wl+c@vger.kernel.org, AJvYcCWpF8+4U/vUvTwUNs+FXbt8RnzjXpDpO651okSASnq5fh4SXuh/WX9EIZj7VwiOGvfJfF9V5IWab7I=@vger.kernel.org, AJvYcCXUZw4oXFvjl19fyhT5zDS6c6X6wy39KZm7SJ5C+/4NgQ5BgDyWHEAAlxWnP4aJLIZpVfFFaBWZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwCNxQwdWwwjHF5qD45CaY/qUE+eROzq6+JAdqIgIAlLsX6Y65M
	Zkiug2hXBeyFBA6C7XBDFRfa3HiypRDnb5BMyKxcqgqr8IcAIfWT
X-Gm-Gg: ASbGncsHTr/9ya5IJPRn6sQaRIbkGAfvoT2T3rcQ9G29UOpk9f/t1TKONNnkS2TSZoj
	Bg7EnCrWQRymXsayFv2WwoFDNqboUY2gSJMLae/9yl3EBylPj2qGGBB5RxyyXjdh7FaVI1IYpJc
	7OOx+Sc5TuluH0GbF39LtEnry6ayuJUFSpJj9uPAh4Ha4Vt4KSF7zUXlmKUbV6gFK7WIdJpPwDs
	Bt1Snu9q1JmQNCFv7wYtbbuT3oCeFYgSFbF/fejuhaxKQATQNYmboxxymYL/gp2uid7sP0Ml+gx
	QZB6LbGWfqf1jsYljC5Y23dfXnf0R5H9xDE=
X-Google-Smtp-Source: AGHT+IE+3I5eE/MdnG3/EntOOcgitiFklqaQI81b+W0rThpohcxJp8quKwnrk36LJHJL89fjECjq0w==
X-Received: by 2002:a05:690c:338a:b0:6fd:3ff9:ad96 with SMTP id 00721157ae682-703e3358aeamr238554477b3.37.1744069343775;
        Mon, 07 Apr 2025 16:42:23 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:3::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-703d1e4e3absm27755197b3.30.2025.04.07.16.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 16:42:23 -0700 (PDT)
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
	linux-pm@vger.kernel.org
Subject: [RFC PATCH 00/14] Virtual Swap Space
Date: Mon,  7 Apr 2025 16:42:01 -0700
Message-ID: <20250407234223.1059191-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This RFC implements the virtual swap space idea, based on Yosry's
proposals at LSFMMBPF 2023 (see [1], [2], [3]), as well as valuable
inputs from Johannes Weiner. The same idea (with different
implementation details) has been floated by Rik van Riel since at least
2011 (see [8]).

The code attached to this RFC is purely a prototype. It is not 100%
merge-ready (see section VI for future work). I do, however, want to show
people this prototype/RFC, including all the bells and whistles and a
couple of actual use cases, so that folks can see what the end results
will look like, and give me early feedback :)

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
* Resource-wise, it is hugely wasteful in terms of disk usage, and
  limits the memory saving potentials of these optimizations by the
  static size of the swapfile, especially in high memory systems that
  can have up to terabytes worth of memory. It also creates significant
  challenges for users who rely on swap utilization as an early OOM
  signal.

Another motivation for a swap redesign is to simplify swapoff, which
is complicated and expensive in the current design. Tight coupling
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
as its lifetime information (swap count), via a dynamically allocated
per-swap-entry descriptor:

struct swp_desc {
	swp_entry_t vswap;
	union {
		swp_slot_t slot;
		struct folio *folio;
		struct zswap_entry *zswap_entry;
	};
	struct rcu_head rcu;

	rwlock_t lock;
	enum swap_type type;

	atomic_t memcgid;

	atomic_t in_swapcache;
	struct kref refcnt;
	atomic_t swap_count;
};

This design allows us to:
* Decouple zswap (and zeromapped swap entry) from backing swapfile:
  simply associate the virtual swap slot with one of the supported
  backends: a zswap entry, a zero-filled swap page, a slot on the
  swapfile, or an in-memory page .
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

Other than decoupling swap backends and optimizing swapoff, this new
design allows us to implement the following more easily and
efficiently:

* Multi-tier swapping (as mentioned in [5]), with transparent
  transferring (promotion/demotion) of pages across tiers (see [8] and
  [9]). Similar to swapoff, with the old design we would need to
  perform the expensive page table walk.
* Swapfile compaction to alleviate fragmentation (as proposed by Ying
  Huang in [6]).
* Mixed backing THP swapin (see [7]): Once you have pinned down the
  backing store of THPs, then you can dispatch each range of subpages
  to appropriate swapin handle.
* Swapping a folio out with discontiguous physical swap slots (see [10])


IV. Potential Issues

Here is a couple of issues I can think of, along with some potential
solutions:

1. Space overhead: we need one swap descriptor per swap entry.
* Note that this overhead is dynamic, i.e only incurred when we actually
  need to swap a page out.
* It can be further offset by the reduction of swap map and the
  elimination of zeromapped bitmap.

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

As mentioned above, I will implement proper dynamic swap range
partitioning in a follow up work.

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
* Swap map shrinking and zero map reduction when virtual swap is
  enabled.
* Range partition the virtual swap space.
* More benchmarking and experiments in a variety of use cases.

Long-term: removal of the old implementation and other non-blocking
opportunities
* Remove the old implementation, when there are no major regressions and
  bottlenecks, etc remained with the new design.
* Merge more existing swap data structures into this layer - for
  instance, the MTE swap xarray.
* Adding new use cases :)

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

Nhat Pham (14):
  swapfile: rearrange functions
  mm: swap: add an abstract API for locking out swapoff
  mm: swap: add a separate type for physical swap slots
  mm: swap: swap cache support for virtualized swap
  zswap: unify zswap tree for virtualized swap
  mm: swap: allocate a virtual swap slot for each swapped out page
  swap: implement the swap_cgroup API using virtual swap
  swap: manage swap entry lifetime at the virtual swap layer
  swap: implement locking out swapoff using virtual swap slot
  mm: swap: decouple virtual swap slot from backing store
  memcg: swap: only charge physical swap slots
  vswap: support THP swapin and batch free_swap_and_cache
  swap: simplify swapoff using virtual swap
  zswap: do not start zswap shrinker if there is no physical swap slots

 MAINTAINERS                |    7 +
 include/linux/mm_types.h   |    7 +
 include/linux/shmem_fs.h   |    3 +
 include/linux/swap.h       |  280 +++++--
 include/linux/swap_slots.h |    2 +-
 include/linux/swapops.h    |   37 +
 kernel/power/swap.c        |    6 +-
 mm/Kconfig                 |   28 +
 mm/Makefile                |    3 +
 mm/huge_memory.c           |    5 +-
 mm/internal.h              |   25 +-
 mm/memcontrol.c            |  166 ++++-
 mm/memory.c                |   99 ++-
 mm/migrate.c               |    1 +
 mm/page_io.c               |   60 +-
 mm/shmem.c                 |   29 +-
 mm/swap.h                  |   45 +-
 mm/swap_cgroup.c           |   10 +-
 mm/swap_slots.c            |   28 +-
 mm/swap_state.c            |  144 +++-
 mm/swapfile.c              |  770 ++++++++++++-------
 mm/vmscan.c                |   26 +-
 mm/vswap.c                 | 1437 ++++++++++++++++++++++++++++++++++++
 mm/zswap.c                 |   80 +-
 24 files changed, 2807 insertions(+), 491 deletions(-)
 create mode 100644 mm/vswap.c


base-commit: 922ceb9d4bb4dae66c37e24621687e0b4991f5a4
-- 
2.47.1

