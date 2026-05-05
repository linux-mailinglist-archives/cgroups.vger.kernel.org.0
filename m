Return-Path: <cgroups+bounces-15605-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MELyImQP+mntIgMAu9opvQ
	(envelope-from <cgroups+bounces-15605-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 05 May 2026 17:40:20 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCE14D05B8
	for <lists+cgroups@lfdr.de>; Tue, 05 May 2026 17:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA690308489C
	for <lists+cgroups@lfdr.de>; Tue,  5 May 2026 15:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF6B48A2B5;
	Tue,  5 May 2026 15:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pserL7Au"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F0848A2B6
	for <cgroups@vger.kernel.org>; Tue,  5 May 2026 15:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777995542; cv=none; b=Go1ua+de8wgiNwBpNPYkTj3e2tKPrAvtKsLHfdiPuvUhhcOUJFHhtHL5Ztn8UoISam3Y7dHlwglmPdU4Gw0TQfOYaI0MB0FPGV4Sac5BXd3j6sY0xs1NaOCK4VLmu0jO82X+N2e/qPeEFe6LGJc3WkmjJ5TItl2PkccHnVY1KrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777995542; c=relaxed/simple;
	bh=EJCCe0WNltbyud2UzysjfOVQKDck1ulvekBx/TpAivs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eUrbxFngur7HxdylYc6zGGjhDsO0rmKxYBQeNYo9fUstuzEFPs5n8ChbnHnfaf6wdJxBm6xHy0uzAaII/r6e5nKDxMz1edHSQCDGSynafEco8NOdk1PX+prvLPYwI9hv83e51hY7PQAQooQZKdv9wWUu/0xcXscnPh4HuRilBb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pserL7Au; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-479d9b155deso1792375b6e.3
        for <cgroups@vger.kernel.org>; Tue, 05 May 2026 08:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777995537; x=1778600337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=axnIiDKKK4q9A13nw5CaT5lKQQ8B3m75uwcJkZDFYhA=;
        b=pserL7AuFc5q1zfIH17eYrdhdX/u8PTYJugEhJQFWThyLvDPaFGw9UVIn6iURSMnwn
         9WDlZgvAeXPvo/b/F09G+fJRrdConMLEedkQ0K5oYU/NOeBIDi81mP4Vh9C9ITyjlfRK
         jI9IFHzWguvxfh7C+qqREiBvnp1rgie9tXQAKrf4+GGuNkBf+OSoSocWP5GI4DOjH+hk
         Jscr3LIeQwbIXCQOUlHt77ZYNujFsESveIU1zrQFD3jizTq0DIIb/HbEo7TGiT3UgIq+
         sKVp3RE2KySDxqSOj/NJyNFIkxGbgnOv+Kpi5j1J/4p2y2LwfjNsbqmJfC5krnuddvBi
         ml6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777995537; x=1778600337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=axnIiDKKK4q9A13nw5CaT5lKQQ8B3m75uwcJkZDFYhA=;
        b=SUXqlXSYk8cblN3LVxM3tHUm3eOAUmcFYHowzPDZb+toL9im67+g58xZrym4dyUpRj
         rqsVlHTrNq4Z+qlw5+VRjeskpvVsxMR6Yw72hOnR7jfzkj65eVLhS63Uvt6D55nBLFct
         bPSw2+9/1yt/IS2LhDK3pLCCT4YU74kK0nTFuPhlRIQSab2eZ0U1PhSW330PDKVJJjey
         3VzWlLTZEYtJj/KxGn3oKBKnAbz+VR6PL9VyxLx7+8tgDzRcGjLkJIQxo0BGToh/HtYz
         Oi6+pRPwemB6kCMNB5MuCU7OmXOTUvx6dZQkl6QnHLFnGl8+KmRaKWQ73FHw0MBJiMct
         ymXw==
X-Forwarded-Encrypted: i=1; AFNElJ+oSWSJ9DiN21zX+w1fdqfjAllRCWPandM9kEPeaLqhGUqvsFLEOIYVBxnX2D+FfxJizq+218qS@vger.kernel.org
X-Gm-Message-State: AOJu0YywTErZdRAJ8v9QdsZhvVdSyqPm9J8Lk5WzloZGJuNvWZM9NwAG
	6Qa1Kopp9aZBKyA17BZw/mVGuTvwyZ83/1ro6s5bgGFCVVhjioGMnoea
X-Gm-Gg: AeBDiet3wKhLUk4l2YdKMxrQ+5iQgrmN24HG7/lnU03Ou5qjuYNA3p8KUujXrKVTpwq
	YjF+FdSvb1Mbc2SvsmvnZBncV4mNokhKoFCVQebhybGfTNxZ2OQgtd5HTb1ys9x4on36faLeudC
	IEHsvYJoQdSf8PoF0U8sYDLaA/0b+bF2re0ci6wZvQqlM5jHrgBmJ+/OG00BTWIHXDOda3o1+IA
	G4ydmlFzDsJgjC8tsMBsJYDwkT06RAYe6tWrdsns1ERXUSmGiDancXm6wZnu9S5U7qNHAhhxmu3
	ZcDSIH63shVibL0BCXKpJcNkfKyWTCGuQUp4nh1RxzJ5Ey+KpFx65yhgK4w11Qw+0h753kZy94I
	m5QzGhP6Q6Ei/ZnSDTfQsblgB2T/XCWUaFWVStVY8apOSBllERXocIt6hVrE2flKFoZ8FXVFQ9c
	UWaeLJHpv6v1ilRIx3XIE4D9Gv3vf/EEvkG2vHccBa7zTSE+ANWVqSudk=
X-Received: by 2002:a05:6808:3097:b0:47a:8c2:a551 with SMTP id 5614622812f47-47e25c660a1mr1802225b6e.16.1777995536774;
        Tue, 05 May 2026 08:38:56 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:4::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-434548c1151sm13657565fac.2.2026.05.05.08.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 08:38:55 -0700 (PDT)
From: Nhat Pham <nphamcs@gmail.com>
To: kasong@tencent.com
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	apopple@nvidia.com,
	axelrasmussen@google.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	bhe@redhat.com,
	byungchul@sk.com,
	cgroups@vger.kernel.org,
	chengming.zhou@linux.dev,
	chrisl@kernel.org,
	corbet@lwn.net,
	david@kernel.org,
	dev.jain@arm.com,
	gourry@gourry.net,
	hannes@cmpxchg.org,
	hughd@google.com,
	jannh@google.com,
	joshua.hahnjy@gmail.com,
	lance.yang@linux.dev,
	lenb@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-pm@vger.kernel.org,
	lorenzo.stoakes@oracle.com,
	matthew.brost@intel.com,
	mhocko@suse.com,
	muchun.song@linux.dev,
	npache@redhat.com,
	nphamcs@gmail.com,
	pavel@kernel.org,
	peterx@redhat.com,
	peterz@infradead.org,
	pfalcato@suse.de,
	rafael@kernel.org,
	rakie.kim@sk.com,
	roman.gushchin@linux.dev,
	rppt@kernel.org,
	ryan.roberts@arm.com,
	shakeel.butt@linux.dev,
	shikemeng@huaweicloud.com,
	surenb@google.com,
	tglx@kernel.org,
	vbabka@suse.cz,
	weixugc@google.com,
	ying.huang@linux.alibaba.com,
	yosry.ahmed@linux.dev,
	yuanchu@google.com,
	zhengqi.arch@bytedance.com,
	ziy@nvidia.com,
	kernel-team@meta.com,
	riel@surriel.com,
	haowenchao22@gmail.com
Subject: [PATCH v6 00/22] Virtual Swap Space
Date: Tue,  5 May 2026 08:38:29 -0700
Message-ID: <20260505153854.1612033-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EDCE14D05B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15605-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[55];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lwn.net:url]

This patch series is (still) based on 6.19 for now, for ease of
regression investigation and testing :) Kairui reported regressions
on fast swapfile backends (PMEM to be specific) in [19], so I have
focused on reproducing them and trying to figure out what happened.
For a more in-depth analysis, see [22].

I think I have got most of it, but since my setup cannot be 100%
similar to Kairui's, I figured I should not overindex on my setups
and send it out for his feedbacks. I will also try to work on
other benchmarks that he's interested in :)

Special thanks to Kairui, Johannes, and Gregory for their feedbacks,
ideas and testing! All mistakes are mine though :)


Changelog:
* v5 -> v6: focusing on reducing the CPU and memory overhead on fast
  swap backends (zram, and hopefully PMEM).
    * Combine multiple vswap operations to reduce roundtrips
      to the vswap layer.
    * Batch per-entry operations where possible (vswap_free for e.g).
    * Eliminate redundant lookups.
    * Per-CPU lookup cache for vswap cluster to reduce xarray
      indirection overhead (patch 22).
    * Augment the reverse map to avoid physical-to-virtual swap
      indirection cost when checking swap-cache-only status.
    * Decouple descriptor array from cluster header to eliminate
      wasted space from slab rounding in cluster allocation.
* v4 -> v5:
    * Fix a deadlock in memcg1_swapout (reported by syzbot [16]).
    * Replace VM_WARN_ON(!spin_is_locked()) with lockdep_assert_held(),
      and use guard(rcu) in vswap_cpu_dead
      (reported by Peter Zijlstra [17]).
* v3 -> v4:
    * Fix poor swap free batching behavior to alleviate a regression
      (reported by Kairui Song).
    * Fix assorted kernel build errors reported by kernel test robots
      in the case of CONFIG_SWAP=n.
* RFC v2 -> v3:
    * Implement a cluster-based allocation algorithm for virtual swap
      slots, inspired by Kairui Song and Chris Li's implementation, as
      well as Johannes Weiner's suggestions. This eliminates the lock
	  contention issues on the virtual swap layer.
    * Re-use swap table for the reverse mapping.
    * Remove CONFIG_VIRTUAL_SWAP.
    * Reducing the size of the swap descriptor from 48 bytes to 24
      bytes, i.e another 50% reduction in memory overhead from v2.
    * Remove swap cache and zswap tree and use the swap descriptor
      for this.
    * Remove zeromap, and replace the swap_map bytemap with 2 bitmaps
      (one for allocated slots, and one for bad slots).
    * Rebase on top of 6.19 (7d0a66e4bb9081d75c82ec4957c50034cb0ea449)
	* Update cover letter to include new benchmark results and discussion
	  on overhead in various cases.
* RFC v1 -> RFC v2:
    * Use a single atomic type (swap_refs) for reference counting
      purpose. This brings the size of the swap descriptor from 64 B
      down to 48 B (25% reduction). Suggested by Yosry Ahmed.
    * Zeromap bitmap is removed in the virtual swap implementation.
      This saves one bit per physical swapfile slot.
    * Rearrange the patches and the code change to make things more
      reviewable. Suggested by Johannes Weiner.
    * Update the cover letter a bit.

This patch series implements the virtual swap space idea, based on Yosry's
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
  pages swap optimizations.
* Tying zswap (and more generally, other in-memory swap backends) to
  the current physical swapfile infrastructure makes zswap implicitly
  statically sized. This does not make sense, as unlike disk swap, in
  which we consume a limited resource (disk space or swapfile space) to
  save another resource (memory), zswap consume the same resource it is
  saving (memory). The more we zswap, the more memory we have available,
  not less. We are not rationing a limited resource when we limit
  the size of the zswap pool, but rather we are capping the resource
  (memory) saving potential of zswap. Under memory pressure, using
  more zswap is almost always better than the alternative (disk IOs, or
  even worse, OOMs), and dynamically sizing the zswap pool on demand
  allows the system to flexibly respond to these precarious scenarios.
* Operationally, static provisioning the swapfile for zswap pose
  significant challenges, because the sysadmin has to prescribe how
  much swap is needed a priori, for each combination of
  (memory size x disk space x workload usage). It is even more
  complicated when we take into account the variance of memory
  compression, which changes the reclaim dynamics (and as a result,
  swap space size requirement). The problem is further exacerbated for
  users who rely on swap utilization (and exhaustion) as an OOM signal.

  All of these factors make it very difficult to configure the swapfile
  for zswap: too small of a swapfile and we risk preventable OOMs and
  limit the memory saving potentials of zswap; too big of a swapfile
  and we waste disk space and memory due to swap metadata overhead.
  This dilemma becomes more drastic in high memory systems, which can
  have up to TBs worth of memory.

Past attempts to decouple disk and compressed swap backends, namely the
ghost swapfile approach (see [13]), as well as the alternative
compressed swap backend zram, have mainly focused on eliminating the
disk space usage of compressed backends. We want a solution that not
only tackles that same problem, but also achieve the dynamicization of
swap space to maximize the memory saving potentials while reducing
operational and static memory overhead.

Finally, any swap redesign should support efficient backend transfer,
i.e without having to perform the expensive page table walk to
update all the PTEs that refer to the swap entry:
* The main motivation for this requirement is zswap writeback. To quote
  Johannes (from [14]): "Combining compression with disk swap is
  extremely powerful, because it dramatically reduces the worst aspects
  of both: it reduces the memory footprint of compression by shedding
  the coldest data to disk; it reduces the IO latencies and flash wear
  of disk swap through the writeback cache. In practice, this reduces
  *average event rates of the entire reclaim/paging/IO stack*."
* Another motivation is to simplify swapoff, which is both complicated
  and expensive in the current design, precisely because we are storing
  an encoding of the backend positional information in the page table,
  and thus requires a full page table walk to remove these references.


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
                swp_slot_t         slot;                 /*     0     8 */
                struct zswap_entry * zswap_entry;        /*     0     8 */
        };                                               /*     0     8 */
        union {
                struct folio *     swap_cache;           /*     8     8 */
                void *             shadow;               /*     8     8 */
        };                                               /*     8     8 */
        unsigned int               swap_count;           /*    16     4 */
        unsigned short             memcgid:16;           /*    20: 0  2 */
        bool                       in_swapcache:1;       /*    22: 0  1 */

        /* Bitfield combined with previous fields */

        enum swap_type             type:2;               /*    20:17  4 */

        /* size: 24, cachelines: 1, members: 6 */
        /* bit_padding: 13 bits */
        /* last cacheline: 24 bytes */
};

(output from pahole).

This design allows us to:
* Decouple zswap (and zeromapped swap entry) from backing swapfile:
  simply associate the virtual swap slot with one of the supported
  backends: a zswap entry, a zero-filled swap page, a slot on the
  swapfile, or an in-memory page.
* Simplify and optimize swapoff: we only have to fault the page in and
  have the virtual swap slot points to the page instead of the on-disk
  physical swap slot. No need to perform any page table walking.

The size of the virtual swap descriptor is 24 bytes. Note that this is
not all "new" overhead, as the swap descriptor will replace:
* the swap_cgroup arrays (one per swap type) in the old design, which
  is a massive source of static memory overhead. With the new design,
  it is only allocated for used clusters.
* the swap tables, which holds the swap cache and workingset shadows.
* the zeromap bitmap, which is a bitmap of physical swap slots to
  indicate whether the swapped out page is zero-filled or not.
* huge chunk of the swap_map. The swap_map is now replaced by 2 bitmaps,
  one for allocated slots, and one for bad slots, representing 3 possible
  states of a slot on the swapfile: allocated, free, and bad.
* the zswap tree.

So, in terms of additional memory overhead:
* For zswap entries, the added memory overhead is rather minimal. The
  new indirection pointer neatly replaces the existing zswap tree.
  We really only incur less than one word of overhead for swap count
  blow up (since we no longer use swap continuation) and the swap type.
* For physical swap entries, the new design will impose fewer than 3 words
  memory overhead. However, as noted above this overhead is only for
  actively used swap entries, whereas in the current design the overhead is
  static (including the swap cgroup array for example).

  The primary victim of this overhead will be zram users. However, as
  zswap now no longer takes up disk space, zram users can consider
  switching to zswap (which, as a bonus, has a lot of useful features
  out of the box, such as cgroup tracking, dynamic zswap pool sizing,
  LRU-ordering writeback, etc.).

For a more concrete example, suppose we have a 32 GB swapfile (i.e.
8,388,608 swap entries), and we use zswap.

0% usage, or 0 entries: 0.00 MB
* Old design total overhead: 25.00 MB
* Vswap total overhead: 0.00 MB

25% usage, or 2,097,152 entries:
* Old design total overhead: 57.00 MB
* Vswap total overhead: 48.25 MB

50% usage, or 4,194,304 entries:
* Old design total overhead: 89.00 MB
* Vswap total overhead: 96.50 MB

75% usage, or 6,291,456 entries:
* Old design total overhead: 121.00 MB
* Vswap total overhead: 144.75 MB

100% usage, or 8,388,608 entries:
* Old design total overhead: 153.00 MB
* Vswap total overhead: 193.00 MB

So even in the worst case scenario for virtual swap, i.e when we
somehow have an oracle to correctly size the swapfile for zswap
pool to 32 GB, the added overhead is only 40 MB, which is a mere
0.12% of the total swapfile :)

In practice, the overhead will be closer to the 50-75% usage case, as
systems tend to leave swap headroom for pathological events or sudden
spikes in memory requirements. The added overhead in these cases are
practically negligible. And in deployments where swapfiles for zswap
are previously sparsely used, switching over to virtual swap will
actually reduce memory overhead.

Doing the same math for the disk swap, which is the worst case for
virtual swap in terms of swap backends:

0% usage, or 0 entries: 0.00 MB
* Old design total overhead: 25.00 MB
* Vswap total overhead: 2.00 MB

25% usage, or 2,097,152 entries:
* Old design total overhead: 41.00 MB
* Vswap total overhead: 66.25 MB

50% usage, or 4,194,304 entries:
* Old design total overhead: 57.00 MB
* Vswap total overhead: 130.50 MB

75% usage, or 6,291,456 entries:
* Old design total overhead: 73.00 MB
* Vswap total overhead: 194.75 MB

100% usage, or 8,388,608 entries:
* Old design total overhead: 89.00 MB
* Vswap total overhead: 259.00 MB

The added overhead is 170MB, which is 0.5% of the total swapfile size,
again in the worst case when we have a sizing oracle.

Please see the attached patches for more implementation details.


III. Usage and Benchmarking

This patch series introduce no new syscalls or userspace API. Existing
userspace setups will work as-is, except we no longer have to create a
swapfile or set memory.swap.max if we want to use zswap, as zswap is no
longer tied to physical swap. The zswap pool will be automatically and
dynamically sized based on memory usage and reclaim dynamics.

All benchmarks below use MGLRU and zram as the swap backend. zram,
being a fast swapfile, represents the worst case for vswap in terms of
overhead (both memory- and CPU-wise). This is also as close as I can
get to the setup in which Kairui reported his regressions (see [18]),
as I do not have access to a PMEM swap device. This also means I have
to modify the parameters of these benchmarks a bit, as zram eats up
memory of the system too - I hope this is acceptable.

All values are reported as mean +/- standard deviation across rounds.

Test system: x86_64, 52 cores for all these benchmarks, 64GB zram swap.

1. Memhog: single-threaded, 48GB allocation on a host with 16GB RAM,
   8 rounds.

                    Baseline (6.19)    VSS v5          VSS v6
   real (s)       80.50 +/- 1.90   83.00 +/- 1.80   80.64 +/- 1.72
   sys (s)        62.71 +/- 2.01   65.72 +/- 1.80   62.93 +/- 1.63
   delta real             -             +3.1%            +0.2%
   delta sys              -             +4.8%            +0.4%

2. Usemem single-threaded: anonymous memory allocation (56GB) on a host
   with 32GB RAM, 16 rounds.

                    Baseline (6.19)       VSS v5          VSS v6
   real (s)       176.52 +/- 4.25  182.12 +/- 3.96  176.56 +/- 3.30
   sys (s)        122.60 +/- 3.96  128.42 +/- 3.92  123.01 +/- 3.07
   tput (KB/s)    390602 +/- 10179 380372 +/-  8802  390524 +/-  7752
   free (ms)        7287 +/-  281    8354 +/-  217     7332 +/-  268
   delta real             -            +3.2%            +0.0%
   delta sys              -            +4.7%            +0.3%
   delta tput             -            -2.6%            -0.0%
   delta free             -           +14.6%            +0.6%

I do want to note that the free time is severely affected by system
compaction, due to a contention between zs_free() and
zs_page_migrate(). This actually affects both baseline and vswap, and
it's a bit of a luck-of-the-draw on a round-per-round basis whether you
will hit it, which is another reason that delays my submission of this
version. I also re-run it for 16 rounds instead of 8, in hope that the
variance will be averaged out somewhat.

Fortunately, when I raised this issues on the mailing list, Wenchao
came up up with a brilliant idea to get around this contention
(see [19]). I have actually hacked together a quick-and-dirty prototype
based on his idea, and it helps tremendously on the free path, but I
will leave it to him to push on this direction ;)

3. Usemem concurrency: 52 threads x 300MB, random access, on a host
   with 16GB RAM, 20 rounds.

                    Baseline (6.19)    VSS v5          VSS v6
   real (s)       14.98 +/- 0.78   18.33 +/- 1.79   14.82 +/- 0.99
   sys (s)        396.4 +/- 31.1   511.9 +/- 60.3   390.7 +/- 37.0
   tput (KB/s)     28188 +/- 1810   23287 +/- 2464   28765 +/- 2264
   free (ms)       101.1 +/-  3.5    91.4 +/-  4.0    98.7 +/-  6.2
   delta real             -            +22.4%            -1.1%
   delta sys              -            +29.1%            -1.4%
   delta tput             -            -17.4%            +2.0%
   delta free             -             -9.6%            -2.4%

Note: not sure why VSS does better than baseline on the free path here.
Could be some weird lock contention effect - I will dig deeper once I
have the free (pun intended) time ;) This could be an indendent
work to improve swap overall, similar to the aforementioned zmalloc
lock contention :)

4. Kernel build: 52 workers (one per processor), memory.max = 3GB,
   64GB RAM, 5 rounds.

                    Baseline (6.19)    VSS v5          VSS v6
   real (s)       163.30 +/- 0.47  163.47 +/- 0.52  163.34 +/- 0.51
   sys (s)        538.87 +/- 16.49 535.93 +/- 11.88 535.53 +/- 15.29
   user (s)      5121.60 +/- 1.41 5126.80 +/- 1.55 5125.57 +/- 2.84
   delta real             -            +0.1%            +0.0%
   delta sys              -            -0.5%            -0.6%


With the optimizations done in V6, we have closed the gap between
virtual swap implementation and 6.19 vanilla to within noise :)


IV. Future Use Cases

While the patch series focus on two applications (decoupling swap
backends and swapoff optimization/simplification), this new,
future-proof design also allows us to implement new swap features more
easily and efficiently:

* Facilitating new backend implementations: Thanks to the flexibility
  of the new design, we can easily add new swap backends, such as
  compressed CXL as swap (see [20]). Vswap provides the much needed
  dynamicity and ease-of-backend transfer for these new backends.
  Another example is samefilled-swap-page (see [23]). I have actually
  hacked together a small patch to do this, but I decided not to
  include it, because it hides the problem in the memhog benchmark
  of virtual swap - I will send it in the next version if folks believe
  it is a worthwhile feature.
* Multi-tier swapping (as mentioned in [5]), with transparent
  transferring (promotion/demotion) of pages across tiers (see [8] and
  [9]). Similar to swapoff, with the old design we would need to
  perform the expensive page table walk.
* Swapfile compaction to alleviate fragmentation (as proposed by Ying
  Huang in [6]).
* Mixed backing THP swapin (see [7]): Once you have pinned down the
  backing store of THPs, then you can dispatch each range of subpages
  to appropriate backend swapin handler.
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
* Deferred physical swap allocation to optimize IO patterns and fallback
  to a different swap backend on error (see [24] and [25]).


V. References

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
[13]: https://lore.kernel.org/all/20251121-ghost-v1-1-cfc0efcf3855@kernel.org/
[14]: https://lore.kernel.org/linux-mm/20251202170222.GD430226@cmpxchg.org/
[15]: https://lore.kernel.org/linux-mm/CAMgjq7AQNGK-a=AOgvn4-V+zGO21QMbMTVbrYSW_R2oDSLoC+A@mail.gmail.com/
[16]: https://lore.kernel.org/all/69bc6c4f.050a0220.3bf4de.0001.GAE@google.com/
[17]: https://lore.kernel.org/all/20260319075621.GR3738010@noisy.programming.kicks-ass.net/
[18]: https://lore.kernel.org/all/CAMgjq7AiUr_Ntj51qoqvV+=XbEATjr7S4MH+rgD32T5pHfF7mg@mail.gmail.com/
[19]: https://lore.kernel.org/all/CAOptpSPs-1UrEa8AHg19e590=SiV6bpnex7gCbif8=aY7BtpuA@mail.gmail.com/
[20]: https://lore.kernel.org/all/aerrps94j70MkgdW@gourry-fedora-PF4VCD3F/
[21]: https://lore.kernel.org/all/afIKxG5mJZE6QgpR@gourry-fedora-PF4VCD3F/
[22]: https://lore.kernel.org/all/CAKEwX=NrUhUrAFx+8BYJEfaVKpCm-H9JhBzYSrqOQb-NW7QRug@mail.gmail.com/
[23]: https://lore.kernel.org/all/CAKEwX=PBjMVfMvKkNfqbgiw7o10NFyZBSB62ODzsqogv-WDYKQ@mail.gmail.com/
[24]: https://lore.kernel.org/all/CAKEwX=NR5dkKduTPwDHWiSMFwJ9ZmvindFvUNbPgQu690W_m+A@mail.gmail.com/
[25]: https://ieeexplore.ieee.org/document/8662047

Nhat Pham (22):
  mm/swap: decouple swap cache from physical swap infrastructure
  swap: rearrange the swap header file
  mm: swap: add an abstract API for locking out swapoff
  zswap: add new helpers for zswap entry operations
  mm/swap: add a new function to check if a swap entry is in swap
    cached.
  mm: swap: add a separate type for physical swap slots
  mm: create scaffolds for the new virtual swap implementation
  zswap: prepare zswap for swap virtualization
  mm: swap: allocate a virtual swap slot for each swapped out page
  swap: move swap cache to virtual swap descriptor
  zswap: move zswap entry management to the virtual swap descriptor
  swap: implement the swap_cgroup API using virtual swap
  swap: manage swap entry lifecycle at the virtual swap layer
  mm: swap: decouple virtual swap slot from backing store
  zswap: do not start zswap shrinker if there is no physical swap slots
  swap: do not unnecessarily pin readahead swap entries
  swapfile: remove zeromap bitmap
  memcg: swap: only charge physical swap slots
  swap: simplify swapoff using virtual swap
  swapfile: replace the swap map with bitmaps
  vswap: batch contiguous vswap free calls
  vswap: cache cluster lookup

 Documentation/mm/index.rst      |    1 -
 Documentation/mm/swap-table.rst |   69 -
 MAINTAINERS                     |    4 +-
 include/linux/cpuhotplug.h      |    1 +
 include/linux/memcontrol.h      |    5 +
 include/linux/mm_types.h        |   16 +
 include/linux/shmem_fs.h        |    9 +-
 include/linux/swap.h            |  210 ++-
 include/linux/swap_cgroup.h     |   18 +-
 include/linux/swapops.h         |   25 +
 include/linux/zswap.h           |   17 +-
 kernel/power/swap.c             |    6 +-
 mm/Makefile                     |    5 +-
 mm/filemap.c                    |   14 +-
 mm/huge_memory.c                |   11 +-
 mm/internal.h                   |   33 +-
 mm/madvise.c                    |    2 +-
 mm/memcontrol-v1.c              |   17 +-
 mm/memcontrol.c                 |  168 ++-
 mm/memory.c                     |  109 +-
 mm/migrate.c                    |   13 +-
 mm/mincore.c                    |   15 +-
 mm/page_io.c                    |  124 +-
 mm/shmem.c                      |  227 +--
 mm/swap.h                       |  268 ++--
 mm/swap_cgroup.c                |  172 ---
 mm/swap_state.c                 |  308 +---
 mm/swap_table.h                 |  132 +-
 mm/swapfile.c                   | 1607 ++++----------------
 mm/userfaultfd.c                |   18 +-
 mm/vmscan.c                     |   29 +-
 mm/vswap.c                      | 2515 +++++++++++++++++++++++++++++++
 mm/zswap.c                      |  178 +--
 33 files changed, 3615 insertions(+), 2731 deletions(-)
 delete mode 100644 Documentation/mm/swap-table.rst
 delete mode 100644 mm/swap_cgroup.c
 create mode 100644 mm/vswap.c


base-commit: 05f7e89ab9731565d8a62e3b5d1ec206485eeb0b
--
2.52.0

