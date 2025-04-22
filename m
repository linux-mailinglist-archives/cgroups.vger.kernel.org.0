Return-Path: <cgroups+bounces-7723-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6D6A96F68
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 16:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F33511B62C9A
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 14:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD5128EA61;
	Tue, 22 Apr 2025 14:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XVIYRkeR"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7327E28A40E
	for <cgroups@vger.kernel.org>; Tue, 22 Apr 2025 14:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745333777; cv=none; b=TknK5zx9Q2XxHiidwbRIfvV1PqGsRHBPt9dQWqUnUmP82v/Qxnitgt6VCAT+7ODnQVStFXLnRRvIrRj9gKqGsrnLxfFm80ipj7qY2HNQ/gz5Z0Q6zVf6RWsCHBi9s5pH8nPe0yHz+Cc7MVtSxOrg7+a8NA4Wo8KJim3xFInEbvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745333777; c=relaxed/simple;
	bh=+J4Ot2uYoqhdMcBpWYJQgmCyvNBmIFihGBbEt1D3Hr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p3+OguaF+kMz5pU5uB6Uq4mWIX0bjQ5L9rkJoeXnlmpKRWk5+rVW9Q686CQp77QsrC7QctorWJF2e4djS4Td9MLC3Or3fv48lo4CfZMV/XfYrVQ4Mq06gP16Y6AmlMj/gJuZU+4yALnBCCfyR3urqqPkTmOCrT5ejA+3EX4lsqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XVIYRkeR; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 22 Apr 2025 07:56:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745333772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HukUGfyVGRy6pXjxhQLdvDYNG7dXUnK5NwUPnqbXZdk=;
	b=XVIYRkeRx8+VmylNMxOePvCyqQdMzBfHYja7PaFFS3wuw9UcFScKSi7LXEeu9Lm2wWVz90
	+S0xDqDiokxHZ49HmXk3Ikz1Trqe/HedTEaB3D35h3W4LsGwYZ9ZhM2nXY7dkE1MoaRnyt
	qhiuL6n3aS3LqiOR6zDlRtjPIThXkIM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Nhat Pham <nphamcs@gmail.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
	hughd@google.com, mhocko@kernel.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev, len.brown@intel.com,
	chengming.zhou@linux.dev, kasong@tencent.com, chrisl@kernel.org,
	huang.ying.caritas@gmail.com, ryan.roberts@arm.com,
	viro@zeniv.linux.org.uk, baohua@kernel.org, osalvador@suse.de,
	lorenzo.stoakes@oracle.com, christophe.leroy@csgroup.eu,
	pavel@kernel.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH 00/14] Virtual Swap Space
Message-ID: <aAeuAwlST1sNifBs@Asmaa.>
References: <20250407234223.1059191-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250407234223.1059191-1-nphamcs@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Apr 07, 2025 at 04:42:01PM -0700, Nhat Pham wrote:
> This RFC implements the virtual swap space idea, based on Yosry's
> proposals at LSFMMBPF 2023 (see [1], [2], [3]), as well as valuable
> inputs from Johannes Weiner. The same idea (with different
> implementation details) has been floated by Rik van Riel since at least
> 2011 (see [8]).
> 
> The code attached to this RFC is purely a prototype. It is not 100%
> merge-ready (see section VI for future work). I do, however, want to show
> people this prototype/RFC, including all the bells and whistles and a
> couple of actual use cases, so that folks can see what the end results
> will look like, and give me early feedback :)
> 
> I. Motivation
> 
> Currently, when an anon page is swapped out, a slot in a backing swap
> device is allocated and stored in the page table entries that refer to
> the original page. This slot is also used as the "key" to find the
> swapped out content, as well as the index to swap data structures, such
> as the swap cache, or the swap cgroup mapping. Tying a swap entry to its
> backing slot in this way is performant and efficient when swap is purely
> just disk space, and swapoff is rare.
> 
> However, the advent of many swap optimizations has exposed major
> drawbacks of this design. The first problem is that we occupy a physical
> slot in the swap space, even for pages that are NEVER expected to hit
> the disk: pages compressed and stored in the zswap pool, zero-filled
> pages, or pages rejected by both of these optimizations when zswap
> writeback is disabled. This is the arguably central shortcoming of
> zswap:
> * In deployments when no disk space can be afforded for swap (such as
>   mobile and embedded devices), users cannot adopt zswap, and are forced
>   to use zram. This is confusing for users, and creates extra burdens
>   for developers, having to develop and maintain similar features for
>   two separate swap backends (writeback, cgroup charging, THP support,
>   etc.). For instance, see the discussion in [4].
> * Resource-wise, it is hugely wasteful in terms of disk usage, and
>   limits the memory saving potentials of these optimizations by the
>   static size of the swapfile, especially in high memory systems that
>   can have up to terabytes worth of memory. It also creates significant
>   challenges for users who rely on swap utilization as an early OOM
>   signal.
> 
> Another motivation for a swap redesign is to simplify swapoff, which
> is complicated and expensive in the current design. Tight coupling
> between a swap entry and its backing storage means that it requires a
> whole page table walk to update all the page table entries that refer to
> this swap entry, as well as updating all the associated swap data
> structures (swap cache, etc.).
> 
> 
> II. High Level Design Overview
> 
> To fix the aforementioned issues, we need an abstraction that separates
> a swap entry from its physical backing storage. IOW, we need to
> “virtualize” the swap space: swap clients will work with a dynamically
> allocated virtual swap slot, storing it in page table entries, and
> using it to index into various swap-related data structures. The
> backing storage is decoupled from the virtual swap slot, and the newly
> introduced layer will “resolve” the virtual swap slot to the actual
> storage. This layer also manages other metadata of the swap entry, such
> as its lifetime information (swap count), via a dynamically allocated
> per-swap-entry descriptor:
> 
> struct swp_desc {
> 	swp_entry_t vswap;
> 	union {
> 		swp_slot_t slot;
> 		struct folio *folio;
> 		struct zswap_entry *zswap_entry;
> 	};
> 	struct rcu_head rcu;
> 
> 	rwlock_t lock;
> 	enum swap_type type;
> 
> 	atomic_t memcgid;
> 
> 	atomic_t in_swapcache;
> 	struct kref refcnt;
> 	atomic_t swap_count;
> };

It's exciting to see this proposal materilizing :)

I didn't get a chance to look too closely at the code, but I have a few
high-level comments.

Do we need separate refcnt and swap_count? I am aware that there are
cases where we need to hold a reference to prevent the descriptor from
going away, without an extra page table entry referencing the swap
descriptor -- but I am wondering if we can get away by just incrementing
the swap count in these cases too? Would this mess things up?

> 
> This design allows us to:
> * Decouple zswap (and zeromapped swap entry) from backing swapfile:
>   simply associate the virtual swap slot with one of the supported
>   backends: a zswap entry, a zero-filled swap page, a slot on the
>   swapfile, or an in-memory page .
> * Simplify and optimize swapoff: we only have to fault the page in and
>   have the virtual swap slot points to the page instead of the on-disk
>   physical swap slot. No need to perform any page table walking.
> 
> Please see the attached patches for implementation details.
> 
> Note that I do not remove the old implementation for now. Users can
> select between the old and the new implementation via the
> CONFIG_VIRTUAL_SWAP build config. This will also allow us to land the
> new design, and iteratively optimize upon it (without having to include
> everything in an even more massive patch series).

I know this is easier, but honestly I'd prefer if we do an incremental
replacement (if possible) rather than introducing a new implementation
and slowly deprecating the old one, which historically doesn't seem to
go well :P

Once the series is organized as Johannes suggested, and we have better
insights into how this will be integrated with Kairui's work, it should
be clearer whether it's possible to incrementally update the current
implemetation rather than add a parallel implementation.

> 
> III. Future Use Cases
> 
> Other than decoupling swap backends and optimizing swapoff, this new
> design allows us to implement the following more easily and
> efficiently:
> 
> * Multi-tier swapping (as mentioned in [5]), with transparent
>   transferring (promotion/demotion) of pages across tiers (see [8] and
>   [9]). Similar to swapoff, with the old design we would need to
>   perform the expensive page table walk.
> * Swapfile compaction to alleviate fragmentation (as proposed by Ying
>   Huang in [6]).
> * Mixed backing THP swapin (see [7]): Once you have pinned down the
>   backing store of THPs, then you can dispatch each range of subpages
>   to appropriate swapin handle.
> * Swapping a folio out with discontiguous physical swap slots (see [10])
> 
> 
> IV. Potential Issues
> 
> Here is a couple of issues I can think of, along with some potential
> solutions:
> 
> 1. Space overhead: we need one swap descriptor per swap entry.
> * Note that this overhead is dynamic, i.e only incurred when we actually
>   need to swap a page out.
> * It can be further offset by the reduction of swap map and the
>   elimination of zeromapped bitmap.
> 
> 2. Lock contention: since the virtual swap space is dynamic/unbounded,
> we cannot naively range partition it anymore. This can increase lock
> contention on swap-related data structures (swap cache, zswap’s xarray,
> etc.).
> * The problem is slightly alleviated by the lockless nature of the new
>   reference counting scheme, as well as the per-entry locking for
>   backing store information.
> * Johannes suggested that I can implement a dynamic partition scheme, in
>   which new partitions (along with associated data structures) are
>   allocated on demand. It is one extra layer of indirection, but global
>   locking will only be done only on partition allocation, rather than on
>   each access. All other accesses only take local (per-partition)
>   locks, or are completely lockless (such as partition lookup).
> 
> 
> V. Benchmarking
> 
> As a proof of concept, I run the prototype through some simple
> benchmarks:
> 
> 1. usemem: 16 threads, 2G each, memory.max = 16G
> 
> I benchmarked the following usemem commands:
> 
> time usemem --init-time -w -O -s 10 -n 16 2g
> 
> Baseline:
> real: 33.96s
> user: 25.31s
> sys: 341.09s
> average throughput: 111295.45 KB/s
> average free time: 2079258.68 usecs
> 
> New Design:
> real: 35.87s
> user: 25.15s
> sys: 373.01s
> average throughput: 106965.46 KB/s
> average free time: 3192465.62 usecs
> 
> To root cause this regression, I ran perf on the usemem program, as
> well as on the following stress-ng program:
> 
> perf record -ag -e cycles -G perf_cg -- ./stress-ng/stress-ng  --pageswap $(nproc) --pageswap-ops 100000
> 
> and observed the (predicted) increase in lock contention on swap cache
> accesses. This regression is alleviated if I put together the
> following hack: limit the virtual swap space to a sufficient size for
> the benchmark, range partition the swap-related data structures (swap
> cache, zswap tree, etc.) based on the limit, and distribute the
> allocation of virtual swap slotss among these partitions (on a per-CPU
> basis):
> 
> real: 34.94s
> user: 25.28s
> sys: 360.25s
> average throughput: 108181.15 KB/s
> average free time: 2680890.24 usecs
> 
> As mentioned above, I will implement proper dynamic swap range
> partitioning in a follow up work.

I thought there would be some improvements with the new design once the
lock contention is gone, due to the colocation of all swap metadata. Do
we know why this isn't the case?

Also, one missing key metric in this cover letter is disk space savings.
It would be useful if you can give a realistic example about how much
disk space is being provisioned and wasted today to effictively use
zswap, and how much this can decrease with this design.

I believe the disk space savings are one of the main motivations so
let's showcase that :)

