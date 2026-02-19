Return-Path: <cgroups+bounces-14026-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHgcOP6fl2nc3AIAu9opvQ
	(envelope-from <cgroups+bounces-14026-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 00:42:54 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7841639A8
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 00:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 626E63040A9C
	for <lists+cgroups@lfdr.de>; Thu, 19 Feb 2026 23:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2F9329384;
	Thu, 19 Feb 2026 23:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pnqCTMkg"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B30020CCDC;
	Thu, 19 Feb 2026 23:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771544527; cv=none; b=Ayf1z8QK/0Jusw+sIBGw9PYLRMwouezhP0Wxpiz0HosG+of4P5ZPQ8gSAeJMQmVrlG5XpLwruBmdjQTaP6+Bk0tokmjqHFbjYsq9ZvkYmtjBzU6idlvLLv7WKlqOzPMlkjIBmcc6n3BtckBwEQCRQNccaDXkDTZWwN0amIDHSjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771544527; c=relaxed/simple;
	bh=AKav55qicOcAvRRVOAKirVRCJ9tBFhlmEFMkkyeMvqU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mWc+JzQ5fhLjT7rV/E6n/z32sBTbLBk4VbCMnHrKn1yGBxf5hOoRdfS72puTJhPw4FJI2Z7i+Laa4QhqyK3w99NhUc9O4H4nTYsnXCOloSnLJbOjSp+PsBsIEfTiK0nDTqluDDeIMTg21zWdm/cyZFWKugyh+7U2fCHW0zSUdBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pnqCTMkg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A400C4CEF7;
	Thu, 19 Feb 2026 23:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771544527;
	bh=AKav55qicOcAvRRVOAKirVRCJ9tBFhlmEFMkkyeMvqU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=pnqCTMkg22dbooGByVctCRCYK7QqIENzZfe499K5bmGyDkWwmxwCGXhKMYN5ExCta
	 +q6pxDUxR5i+3hs4D38hLP3OicwysASRZqVnVVMoVO23fakOpIiZTny17fuFqBYY7U
	 Ftzu0h0rKaXcjUSzNs9Bup95ojkFBZtx5FJ7RLsjjq5jBWyhPDcdy29dhnDvcX4q0r
	 RLeiT5Qjtk2GW9g844EINFH+pf1tuU2cYJddL88RRUdIIuliON4V4ZqZlFa8WFO/AX
	 7DwTpoQgBuUxeONBWinJ9yGaN6slq8K4UT/5wUaBSuYkoNMfvKNlZMU8yZijQaPOKB
	 4Kwm2pmhxawYA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2765E9A04F;
	Thu, 19 Feb 2026 23:42:06 +0000 (UTC)
From: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>
Subject: [PATCH RFC 00/15] mm, swap: swap table phase IV with dynamic ghost
 swapfile
Date: Fri, 20 Feb 2026 07:42:01 +0800
Message-Id: <20260220-swap-table-p4-v1-0-104795d19815@tencent.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQ0ND3eLyxALdksSknFTdAhNdS4vUVEujpMRE82QTJaCegqLUtMwKsHn
 RSkFuzkqxtbUAaUzH9mQAAAA=
X-Change-ID: 20260111-swap-table-p4-98ee92baa7c4
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>, 
 Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
 Baoquan He <bhe@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Yosry Ahmed <yosry.ahmed@linux.dev>, Youngjun Park <youngjun.park@lge.com>, 
 Chengming Zhou <chengming.zhou@linux.dev>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
 Qi Zheng <zhengqi.arch@bytedance.com>, linux-kernel@vger.kernel.org, 
 cgroups@vger.kernel.org, Kairui Song <kasong@tencent.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771544524; l=11242;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=AKav55qicOcAvRRVOAKirVRCJ9tBFhlmEFMkkyeMvqU=;
 b=bMefXg26orrFX/o/nP5DoOVALI8DvpdRKz5GQyxQ2ji+AkA29lvpzsGW6SlKs8POwATD89TXr
 Fhn+jBg+Dk9CCC0HTIVF4vUMHUL9EDmVX7yiEuuYe9M6qlHxOK7KjCJ
X-Developer-Key: i=kasong@tencent.com; a=ed25519;
 pk=kCdoBuwrYph+KrkJnrr7Sm1pwwhGDdZKcKrqiK8Y1mI=
X-Endpoint-Received: by B4 Relay for kasong@tencent.com/kasong-sign-tencent
 with auth_id=562
X-Original-From: Kairui Song <kasong@tencent.com>
Reply-To: kasong@tencent.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14026-lists,cgroups=lfdr.de,kasong.tencent.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,oracle.com,nvidia.com,linux.alibaba.com,google.com,huaweicloud.com,gmail.com,redhat.com,cmpxchg.org,linux.dev,lge.com,bytedance.com,vger.kernel.org,tencent.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	HAS_REPLYTO(0.00)[kasong@tencent.com]
X-Rspamd-Queue-Id: 6D7841639A8
X-Rspamd-Action: no action

NOTE for an RFC quality series: Swap table P4 is patch 1 - 12, and the
dynamic ghost file is patch 13 - 15. Putting them together as RFC for
easier review and discussions. Swap table P4 is stable and good to merge
if we are OK with a few memcg reparent behavior (there is also a
solution if we don't), dynamic ghost swap is yet a minimal proof of
concept. See patch 15 for more details. And see below for Swap table 4
cover letter (nice performance gain and memory save).

This is based on the latest mm-unstable, swap table P3 [1] and patches
[2] and [3], [4]. Sending this out early, as it might be helpful for us
to get a cleaner picture of the ongoing efforts, make the discussions easier.

Summary: With this approach, we can have an infinitely or dynamically
large ghost which could be identical to "virtual swap", and support
every feature we need while being *runtime configurable* with *zero
overhead* for plain swap and keep the infrastructure unified. Also
highly compatible with YoungJun's swap tiering [5], and other ideas like
swap table compaction, swapops, as it aligns with a few proposals [6]
[7] [8] [9] [10].

In the past two years, most efforts have focused on the swap
infrastructure, and we have made tremendous gains in performance,
keeping the memory usage reasonable or lower, and also greatly cleaned
up and simplified the API and conventions.

Now the infrastructures are almost ready, after P4, implementing an
infinitely or dynamically large swapfile can be done in a very easy to
maintain and flexible way, code change is minimal and progressive
for review, and makes future optimization like swap table compaction
doable too, since the infrastructure is all the same for all swaps.

The dynamic swap file is now using Xarray for the cluster info, and
inside the cluster, it's all the same swap allocator, swap table, and
existing infrastructures. A virtual table is available for any extra
data or usage. See below for the benefits and what we can achieve.

Huge thanks to Chris Li for the layered swap table and ghost swapfile
idea, without whom the work here can't be archived. Also, thanks to Nhat
for pushing and suggesting using an Xarray for the swapfile [11] for
dynamic size. I was originally planning to use a dynamic cluster
array, which requires a bit more adaptation, cleanup, and convention
changes. But during the discussion there, I got the inspiration that
Xarray can be used as the intermediate step, making this approach
doable with minimal changes. Just keep using it in the future, it
might not hurt too, as Xarray is only limited to ghost / virtual
files, so plain swaps won't have any extra overhead for lookup or high
risk of swapout allocation failure.

I'm fully open and totally fine for suggestions on naming or API
strategy, and others are highly welcome to keep the work going using
this flexible approach. Following this approach, we will have all the
following things progressively (some are already or almost there):

- 8 bytes per slot memory usage, when using only plain swap.
  - And the memory usage can be reduced to 3 or only 1 byte.
- 16 bytes per slot memory usage, when using ghost / virtual zswap.
  - Zswap can just use ci_dyn->virtual_table to free up it's content
    completely.
  - And the memory usage can be reduced to 11 or 8 bytes using the same
    code above.
  - 24 bytes only if including reverse mapping is in use.
- Minimal code review or maintenance burden. All layers are using the exact
  same infrastructure for metadata / allocation / synchronization, making
  all API and conventions consistent and easy to maintain.
- Writeback, migration and compaction are easily supportable since both
  reverse mapping and reallocation are prepared. We just need a
  folio_realloc_swap to allocate new entries for the existing entry, and
  fill the swap table with a reserve map entry.
- Fast swapoff: Just read into ghost / virtual swap cache.
- Zero static data (mostly due to swap table P4), even the clusters are
  dynamic (If using Xarray, only for ghost / virtual swap file).
- So we can have an infinitely sized swap space with no static data
  overhead.
- Everything is runtime configurable, and high-performance. An
  uncompressible workload or an offline batch workload can directly use a
  plain or remote swap for the lowest interference, memory usage, or for
  best performance.
- Highly compatible with YoungJun's swap tiering, even the ghost / virtual
  file can be just a tier. For example, if you have a huge NBD that doesn't
  care about fragmentation and compression, or the workload is
  uncompressible, setting the workload to use NBD's tier will give you only
  8 bytes of overhead per slot and peak performance, bypassing everything.
  Meanwhile, other workloads or cgroups can still use the ghost layer with
  compression or defragmentation using 16 bytes (zswap only) or 24 bytes
  (ghost swap with physical writeback) overhead.
- No force or breaking change to any existing allocation, priority, swap
  setup, or reclaim strategy. Ghost / virtual swap can be enabled or
  disabled using swapon / swapoff.

And if you consider these ops are too complex to set up and maintain, we
can then only allow one ghost / virtual file, make it infinitely large,
and be the default one and top tier, then it achieves the identical thing
to virtual swap space, but with much fewer LOC changed and being runtime
optional.

Currently, the dynamic ghost files are just reported as ordinary swap files
in /proc/swaps and we can have multiple ones, so users will have a full
view of what's going on. This is a very easy-to-change design decision.
I'm open to ideas about how we should present this to users. e.g., Hiding
it will make it more "virtual", but I don't think that's a good idea.

The size of the swapfile (si->max) is now just a number, which could be
changeable at runtime if we have a proper idea how to expose that and
might need some audit of a few remaining users. But right now, we can
already easily have a huge swap device with no overhead, for example:

free -m
               total        used        free      shared  buff/cache   available
Mem:            1465         250         927           1         356        1215
Swap:       15269887           0    15269887

And for easier testing, I added a /dev/ghostswap in this RFC. `swapon
/dev/ghostswap` enables that. Without swapon /dev/ghostswap, any existing
users, including ZRAM, won't observe any change.

===

Original cover letter for swap table phase IV:

This series unifies the allocation and charging process of anon and shmem,
provides better synchronization, and consolidates cgroup tracking, hence
dropping the cgroup array and improving the performance of mTHP by about
~15%.

Still testing with build kernel under great pressure, enabling mTHP 256kB,
on an EPYC 7K62 using 16G ZRAM, make -j48 with 1G memory limit, 12 test
runs:

Before: 2215.55s system, 2:53.03 elapsed
After:  1852.14s system, 2:41.44 elapsed (16.4% faster system time)

In some workloads, the speed gain is more than that since this reduces
memory thrashing, so even IO-bound work could benefit a lot, and I no
longer see any: "Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying
PF", it was shown from time to time before this series.

Now, the swap cache layer ensures a folio will be the exclusive owner of
the swap slot, then charge it, which leads to much smaller thrashing when
under pressure.

And besides, the swap cgroup static array is gone, so for example, mounting
a 1TB swap device saves about 512MB of memory:

Before:
        total     used     free     shared  buff/cache available
Mem:    1465      854      331      1       347        610
Swap:   1048575   0        1048575

After:
        total     used     free     shared  buff/cache available
Mem:    1465      332      838      1       363        1133
Swap:   1048575   0        1048575

It saves us ~512M of memory, we now have close to 0 static overhead.

Link: https://lore.kernel.org/linux-mm/20260218-swap-table-p3-v3-0-f4e34be021a7@tencent.com/ [1]
Link: https://lore.kernel.org/linux-mm/20260213-memcg-privid-v1-1-d8cb7afcf831@tencent.com/ [2]
Link: https://lore.kernel.org/linux-mm/20260211-shmem-swap-gfp-v1-1-e9781099a861@tencent.com/ [3]
Link: https://lore.kernel.org/linux-mm/20260216-hibernate-perf-v4-0-1ba9f0bf1ec9@tencent.com/ [4]
Link: https://lore.kernel.org/linux-mm/20260217000950.4015880-1-youngjun.park@lge.com/ [5]
Link: https://lore.kernel.org/all/CAMgjq7BvQ0ZXvyLGp2YP96+i+6COCBBJCYmjXHGBnfisCAb8VA@mail.gmail.com/ [6]
Link: https://lwn.net/Articles/974587/ [7]
Link: https://lwn.net/Articles/932077/ [8]
Link: https://lwn.net/Articles/1016136/ [9]
Link: https://lore.kernel.org/linux-mm/20260208215839.87595-1-nphamcs@gmail.com/ [10]
Link: https://lore.kernel.org/linux-mm/CAKEwX=OUni7PuUqGQUhbMDtErurFN_i=1RgzyQsNXy4LABhXoA@mail.gmail.com/ [11]

Signed-off-by: Kairui Song <kasong@tencent.com>
---
Chris Li (1):
      mm: ghost swapfile support for zswap

Kairui Song (14):
      mm: move thp_limit_gfp_mask to header
      mm, swap: simplify swap_cache_alloc_folio
      mm, swap: move conflict checking logic of out swap cache adding
      mm, swap: add support for large order folios in swap cache directly
      mm, swap: unify large folio allocation
      memcg, swap: reparent the swap entry on swapin if swapout cgroup is dead
      memcg, swap: defer the recording of memcg info and reparent flexibly
      mm, swap: store and check memcg info in the swap table
      mm, swap: support flexible batch freeing of slots in different memcg
      mm, swap: always retrieve memcg id from swap table
      mm/swap, memcg: remove swap cgroup array
      mm, swap: merge zeromap into swap table
      mm, swap: add a special device for ghost swap setup
      mm, swap: allocate cluster dynamically for ghost swapfile

 MAINTAINERS                 |   1 -
 drivers/char/mem.c          |  39 ++++
 include/linux/huge_mm.h     |  24 +++
 include/linux/memcontrol.h  |  12 +-
 include/linux/swap.h        |  30 ++-
 include/linux/swap_cgroup.h |  47 -----
 mm/Makefile                 |   3 -
 mm/internal.h               |  25 ++-
 mm/memcontrol-v1.c          |  78 ++++----
 mm/memcontrol.c             | 119 ++++++++++--
 mm/memory.c                 |  89 ++-------
 mm/page_io.c                |  46 +++--
 mm/shmem.c                  | 122 +++---------
 mm/swap.h                   | 122 +++++-------
 mm/swap_cgroup.c            | 172 ----------------
 mm/swap_state.c             | 464 ++++++++++++++++++++++++--------------------
 mm/swap_table.h             | 105 ++++++++--
 mm/swapfile.c               | 278 ++++++++++++++++++++------
 mm/vmscan.c                 |   7 +-
 mm/workingset.c             |  16 +-
 mm/zswap.c                  |  29 +--
 21 files changed, 977 insertions(+), 851 deletions(-)
---
base-commit: 4750368e2cd365ac1e02c6919013c8871f35d8f9
change-id: 20260111-swap-table-p4-98ee92baa7c4

Best regards,
-- 
Kairui Song <kasong@tencent.com>



