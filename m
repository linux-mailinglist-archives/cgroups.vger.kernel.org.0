Return-Path: <cgroups+bounces-13895-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QH+OOZjGjWnT6gAAu9opvQ
	(envelope-from <cgroups+bounces-13895-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 13:24:56 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C6712D6F3
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 13:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D7A1301C88E
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 12:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC7235770A;
	Thu, 12 Feb 2026 12:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJUC0Y4C"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09F52BDC1C;
	Thu, 12 Feb 2026 12:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770899009; cv=none; b=XdBit3Ymp0s1lHY3IgCV/s6/nnR+LVq6ArmVxfKXMzjnuEphD63wUeJv/D7hgM0Td6yruBHLHDFBXGgbEWjqb4tZ7gXnbqFhtPabfhCxuCGvFoif8PRr/XI9QaABcV6iNKhb72oSrDTGCej+h6voDy4prfUOuisBMQMYVZ2vvIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770899009; c=relaxed/simple;
	bh=TbORQw9SNMDUuZ+ox/zkPNyGdgF1Tidu10ms5XTyJSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j9JhWaMhHHRal7ewmh+M5gwdMyS8hkURHi/iYzTwbo3Nw68iOxI4dnhHqcBA7zceXR2Xb+OFHXEpJc9KDwWc+GQyktXgUHxXTWOX/9qZb19h9SUcyxGEO6vRRT9AwjVTpg1aj+nzgyhRay+tfArCUZZwWeCmO0IjuYEzBxnJDM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJUC0Y4C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA2D4C4CEF7;
	Thu, 12 Feb 2026 12:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770899009;
	bh=TbORQw9SNMDUuZ+ox/zkPNyGdgF1Tidu10ms5XTyJSE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eJUC0Y4CZW/npsA5JBIx6aQMdQtjbjN0pfTv7vmR3nFpRPomKCdx9CB6a//9oZNiS
	 tPZlic/jJ+F94OMOkaq9HuSzx14TmIxjY/ngkiuHWSBIGtNywh4BSMdYm/K1SsDqaG
	 FBM7efKgTIt+CVjgQLmjcznB4tuDOdHbHWvRut2pRyonKQ0EelDu0374EM66BFOBRu
	 H6VxHesAR41l7nEk1IW/AcdL23JZtA+e8xAt1GiVugLQz8g19DCBU8woLbJgw6dCLp
	 w8JxhBD4ps/IGai7NVc/IkYciji0mRokXDdjb2YVz9CcFouDR+BDdM/Kv3JhtBasP3
	 o9lyvVJ2uBASA==
Message-ID: <13e3cada-60a3-4451-ab7e-16dfbab3c352@kernel.org>
Date: Thu, 12 Feb 2026 13:23:17 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/20] Virtual Swap Space
To: Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, hughd@google.com,
 yosry.ahmed@linux.dev, mhocko@kernel.org, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, muchun.song@linux.dev, len.brown@intel.com,
 chengming.zhou@linux.dev, kasong@tencent.com, chrisl@kernel.org,
 huang.ying.caritas@gmail.com, ryan.roberts@arm.com,
 shikemeng@huaweicloud.com, viro@zeniv.linux.org.uk, baohua@kernel.org,
 bhe@redhat.com, osalvador@suse.de, lorenzo.stoakes@oracle.com,
 christophe.leroy@csgroup.eu, pavel@kernel.org, kernel-team@meta.com,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-pm@vger.kernel.org, peterx@redhat.com, riel@surriel.com,
 joshua.hahnjy@gmail.com, npache@redhat.com, gourry@gourry.net,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 rafael@kernel.org, jannh@google.com, pfalcato@suse.de,
 zhengqi.arch@bytedance.com
References: <20260208215839.87595-1-nphamcs@gmail.com>
 <CAKEwX=OvuVPJzQsSQm8F+zsRgJFnbMmW2JMJbGebp=U8+jMRYA@mail.gmail.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <CAKEwX=OvuVPJzQsSQm8F+zsRgJFnbMmW2JMJbGebp=U8+jMRYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13895-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kvack.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[40];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux-foundation.org,cmpxchg.org,google.com,linux.dev,kernel.org,intel.com,tencent.com,gmail.com,arm.com,huaweicloud.com,zeniv.linux.org.uk,redhat.com,suse.de,oracle.com,csgroup.eu,meta.com,vger.kernel.org,surriel.com,gourry.net,bytedance.com];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lwn.net:url]
X-Rspamd-Queue-Id: 80C6712D6F3
X-Rspamd-Action: no action

On 2/8/26 23:51, Nhat Pham wrote:
> On Sun, Feb 8, 2026 at 1:58 PM Nhat Pham <nphamcs@gmail.com> wrote:
>>
>> Changelog:
>> * RFC v2 -> v3:
>>      * Implement a cluster-based allocation algorithm for virtual swap
>>        slots, inspired by Kairui Song and Chris Li's implementation, as
>>        well as Johannes Weiner's suggestions. This eliminates the lock
>>            contention issues on the virtual swap layer.
>>      * Re-use swap table for the reverse mapping.
>>      * Remove CONFIG_VIRTUAL_SWAP.
>>      * Reducing the size of the swap descriptor from 48 bytes to 24
>>        bytes, i.e another 50% reduction in memory overhead from v2.
>>      * Remove swap cache and zswap tree and use the swap descriptor
>>        for this.
>>      * Remove zeromap, and replace the swap_map bytemap with 2 bitmaps
>>        (one for allocated slots, and one for bad slots).
>>      * Rebase on top of 6.19 (7d0a66e4bb9081d75c82ec4957c50034cb0ea449)
>>          * Update cover letter to include new benchmark results and discussion
>>            on overhead in various cases.
>> * RFC v1 -> RFC v2:
>>      * Use a single atomic type (swap_refs) for reference counting
>>        purpose. This brings the size of the swap descriptor from 64 B
>>        down to 48 B (25% reduction). Suggested by Yosry Ahmed.
>>      * Zeromap bitmap is removed in the virtual swap implementation.
>>        This saves one bit per phyiscal swapfile slot.
>>      * Rearrange the patches and the code change to make things more
>>        reviewable. Suggested by Johannes Weiner.
>>      * Update the cover letter a bit.
>>
>> This patch series implements the virtual swap space idea, based on Yosry's
>> proposals at LSFMMBPF 2023 (see [1], [2], [3]), as well as valuable
>> inputs from Johannes Weiner. The same idea (with different
>> implementation details) has been floated by Rik van Riel since at least
>> 2011 (see [8]).
>>
>> This patch series is based on 6.19. There are a couple more
>> swap-related changes in the mm-stable branch that I would need to
>> coordinate with, but I would like to send this out as an update, to show
>> that the lock contention issues that plagued earlier versions have been
>> resolved and performance on the kernel build benchmark is now on-par with
>> baseline. Furthermore, memory overhead has been substantially reduced
>> compared to the last RFC version.
>>
>>
>> I. Motivation
>>
>> Currently, when an anon page is swapped out, a slot in a backing swap
>> device is allocated and stored in the page table entries that refer to
>> the original page. This slot is also used as the "key" to find the
>> swapped out content, as well as the index to swap data structures, such
>> as the swap cache, or the swap cgroup mapping. Tying a swap entry to its
>> backing slot in this way is performant and efficient when swap is purely
>> just disk space, and swapoff is rare.
>>
>> However, the advent of many swap optimizations has exposed major
>> drawbacks of this design. The first problem is that we occupy a physical
>> slot in the swap space, even for pages that are NEVER expected to hit
>> the disk: pages compressed and stored in the zswap pool, zero-filled
>> pages, or pages rejected by both of these optimizations when zswap
>> writeback is disabled. This is the arguably central shortcoming of
>> zswap:
>> * In deployments when no disk space can be afforded for swap (such as
>>    mobile and embedded devices), users cannot adopt zswap, and are forced
>>    to use zram. This is confusing for users, and creates extra burdens
>>    for developers, having to develop and maintain similar features for
>>    two separate swap backends (writeback, cgroup charging, THP support,
>>    etc.). For instance, see the discussion in [4].
>> * Resource-wise, it is hugely wasteful in terms of disk usage. At Meta,
>>    we have swapfile in the order of tens to hundreds of GBs, which are
>>    mostly unused and only exist to enable zswap usage and zero-filled
>>    pages swap optimizations.
>> * Tying zswap (and more generally, other in-memory swap backends) to
>>    the current physical swapfile infrastructure makes zswap implicitly
>>    statically sized. This does not make sense, as unlike disk swap, in
>>    which we consume a limited resource (disk space or swapfile space) to
>>    save another resource (memory), zswap consume the same resource it is
>>    saving (memory). The more we zswap, the more memory we have available,
>>    not less. We are not rationing a limited resource when we limit
>>    the size of he zswap pool, but rather we are capping the resource
>>    (memory) saving potential of zswap. Under memory pressure, using
>>    more zswap is almost always better than the alternative (disk IOs, or
>>    even worse, OOMs), and dynamically sizing the zswap pool on demand
>>    allows the system to flexibly respond to these precarious scenarios.
>> * Operationally, static provisioning the swapfile for zswap pose
>>    significant challenges, because the sysadmin has to prescribe how
>>    much swap is needed a priori, for each combination of
>>    (memory size x disk space x workload usage). It is even more
>>    complicated when we take into account the variance of memory
>>    compression, which changes the reclaim dynamics (and as a result,
>>    swap space size requirement). The problem is further exarcebated for
>>    users who rely on swap utilization (and exhaustion) as an OOM signal.
>>
>>    All of these factors make it very difficult to configure the swapfile
>>    for zswap: too small of a swapfile and we risk preventable OOMs and
>>    limit the memory saving potentials of zswap; too big of a swapfile
>>    and we waste disk space and memory due to swap metadata overhead.
>>    This dilemma becomes more drastic in high memory systems, which can
>>    have up to TBs worth of memory.
>>
>> Past attempts to decouple disk and compressed swap backends, namely the
>> ghost swapfile approach (see [13]), as well as the alternative
>> compressed swap backend zram, have mainly focused on eliminating the
>> disk space usage of compressed backends. We want a solution that not
>> only tackles that same problem, but also achieve the dyamicization of
>> swap space to maximize the memory saving potentials while reducing
>> operational and static memory overhead.
>>
>> Finally, any swap redesign should support efficient backend transfer,
>> i.e without having to perform the expensive page table walk to
>> update all the PTEs that refer to the swap entry:
>> * The main motivation for this requirement is zswap writeback. To quote
>>    Johannes (from [14]): "Combining compression with disk swap is
>>    extremely powerful, because it dramatically reduces the worst aspects
>>    of both: it reduces the memory footprint of compression by shedding
>>    the coldest data to disk; it reduces the IO latencies and flash wear
>>    of disk swap through the writeback cache. In practice, this reduces
>>    *average event rates of the entire reclaim/paging/IO stack*."
>> * Another motivation is to simplify swapoff, which is both complicated
>>    and expensive in the current design, precisely because we are storing
>>    an encoding of the backend positional information in the page table,
>>    and thus requires a full page table walk to remove these references.
>>
>>
>> II. High Level Design Overview
>>
>> To fix the aforementioned issues, we need an abstraction that separates
>> a swap entry from its physical backing storage. IOW, we need to
>> “virtualize” the swap space: swap clients will work with a dynamically
>> allocated virtual swap slot, storing it in page table entries, and
>> using it to index into various swap-related data structures. The
>> backing storage is decoupled from the virtual swap slot, and the newly
>> introduced layer will “resolve” the virtual swap slot to the actual
>> storage. This layer also manages other metadata of the swap entry, such
>> as its lifetime information (swap count), via a dynamically allocated,
>> per-swap-entry descriptor:
>>
>> struct swp_desc {
>>          union {
>>                  swp_slot_t         slot;                 /*     0     8 */
>>                  struct zswap_entry * zswap_entry;        /*     0     8 */
>>          };                                               /*     0     8 */
>>          union {
>>                  struct folio *     swap_cache;           /*     8     8 */
>>                  void *             shadow;               /*     8     8 */
>>          };                                               /*     8     8 */
>>          unsigned int               swap_count;           /*    16     4 */
>>          unsigned short             memcgid:16;           /*    20: 0  2 */
>>          bool                       in_swapcache:1;       /*    22: 0  1 */
>>
>>          /* Bitfield combined with previous fields */
>>
>>          enum swap_type             type:2;               /*    20:17  4 */
>>
>>          /* size: 24, cachelines: 1, members: 6 */
>>          /* bit_padding: 13 bits */
>>          /* last cacheline: 24 bytes */
>> };
>>
>> (output from pahole).
>>
>> This design allows us to:
>> * Decouple zswap (and zeromapped swap entry) from backing swapfile:
>>    simply associate the virtual swap slot with one of the supported
>>    backends: a zswap entry, a zero-filled swap page, a slot on the
>>    swapfile, or an in-memory page.
>> * Simplify and optimize swapoff: we only have to fault the page in and
>>    have the virtual swap slot points to the page instead of the on-disk
>>    physical swap slot. No need to perform any page table walking.
>>
>> The size of the virtual swap descriptor is 24 bytes. Note that this is
>> not all "new" overhead, as the swap descriptor will replace:
>> * the swap_cgroup arrays (one per swap type) in the old design, which
>>    is a massive source of static memory overhead. With the new design,
>>    it is only allocated for used clusters.
>> * the swap tables, which holds the swap cache and workingset shadows.
>> * the zeromap bitmap, which is a bitmap of physical swap slots to
>>    indicate whether the swapped out page is zero-filled or not.
>> * huge chunk of the swap_map. The swap_map is now replaced by 2 bitmaps,
>>    one for allocated slots, and one for bad slots, representing 3 possible
>>    states of a slot on the swapfile: allocated, free, and bad.
>> * the zswap tree.
>>
>> So, in terms of additional memory overhead:
>> * For zswap entries, the added memory overhead is rather minimal. The
>>    new indirection pointer neatly replaces the existing zswap tree.
>>    We really only incur less than one word of overhead for swap count
>>    blow up (since we no longer use swap continuation) and the swap type.
>> * For physical swap entries, the new design will impose fewer than 3 words
>>    memory overhead. However, as noted above this overhead is only for
>>    actively used swap entries, whereas in the current design the overhead is
>>    static (including the swap cgroup array for example).
>>
>>    The primary victim of this overhead will be zram users. However, as
>>    zswap now no longer takes up disk space, zram users can consider
>>    switching to zswap (which, as a bonus, has a lot of useful features
>>    out of the box, such as cgroup tracking, dynamic zswap pool sizing,
>>    LRU-ordering writeback, etc.).
>>
>> For a more concrete example, suppose we have a 32 GB swapfile (i.e.
>> 8,388,608 swap entries), and we use zswap.
>>
>> 0% usage, or 0 entries: 0.00 MB
>> * Old design total overhead: 25.00 MB
>> * Vswap total overhead: 0.00 MB
>>
>> 25% usage, or 2,097,152 entries:
>> * Old design total overhead: 57.00 MB
>> * Vswap total overhead: 48.25 MB
>>
>> 50% usage, or 4,194,304 entries:
>> * Old design total overhead: 89.00 MB
>> * Vswap total overhead: 96.50 MB
>>
>> 75% usage, or 6,291,456 entries:
>> * Old design total overhead: 121.00 MB
>> * Vswap total overhead: 144.75 MB
>>
>> 100% usage, or 8,388,608 entries:
>> * Old design total overhead: 153.00 MB
>> * Vswap total overhead: 193.00 MB
>>
>> So even in the worst case scenario for virtual swap, i.e when we
>> somehow have an oracle to correctly size the swapfile for zswap
>> pool to 32 GB, the added overhead is only 40 MB, which is a mere
>> 0.12% of the total swapfile :)
>>
>> In practice, the overhead will be closer to the 50-75% usage case, as
>> systems tend to leave swap headroom for pathological events or sudden
>> spikes in memory requirements. The added overhead in these cases are
>> practically neglible. And in deployments where swapfiles for zswap
>> are previously sparsely used, switching over to virtual swap will
>> actually reduce memory overhead.
>>
>> Doing the same math for the disk swap, which is the worst case for
>> virtual swap in terms of swap backends:
>>
>> 0% usage, or 0 entries: 0.00 MB
>> * Old design total overhead: 25.00 MB
>> * Vswap total overhead: 2.00 MB
>>
>> 25% usage, or 2,097,152 entries:
>> * Old design total overhead: 41.00 MB
>> * Vswap total overhead: 66.25 MB
>>
>> 50% usage, or 4,194,304 entries:
>> * Old design total overhead: 57.00 MB
>> * Vswap total overhead: 130.50 MB
>>
>> 75% usage, or 6,291,456 entries:
>> * Old design total overhead: 73.00 MB
>> * Vswap total overhead: 194.75 MB
>>
>> 100% usage, or 8,388,608 entries:
>> * Old design total overhead: 89.00 MB
>> * Vswap total overhead: 259.00 MB
>>
>> The added overhead is 170MB, which is 0.5% of the total swapfile size,
>> again in the worst case when we have a sizing oracle.
>>
>> Please see the attached patches for more implementation details.
>>
>>
>> III. Usage and Benchmarking
>>
>> This patch series introduce no new syscalls or userspace API. Existing
>> userspace setups will work as-is, except we no longer have to create a
>> swapfile or set memory.swap.max if we want to use zswap, as zswap is no
>> longer tied to physical swap. The zswap pool will be automatically and
>> dynamically sized based on memory usage and reclaim dynamics.
>>
>> To measure the performance of the new implementation, I have run the
>> following benchmarks:
>>
>> 1. Kernel building: 52 workers (one per processor), memory.max = 3G.
>>
>> Using zswap as the backend:
>>
>> Baseline:
>> real: mean: 185.2s, stdev: 0.93s
>> sys: mean: 683.7s, stdev: 33.77s
>>
>> Vswap:
>> real: mean: 184.88s, stdev: 0.57s
>> sys: mean: 675.14s, stdev: 32.8s
>>
>> We actually see a slight improvement in systime (by 1.5%) :) This is
>> likely because we no longer have to perform swap charging for zswap
>> entries, and virtual swap allocator is simpler than that of physical
>> swap.
>>
>> Using SSD swap as the backend:
>>
>> Baseline:
>> real: mean: 200.3s, stdev: 2.33s
>> sys: mean: 489.88s, stdev: 9.62s
>>
>> Vswap:
>> real: mean: 201.47s, stdev: 2.98s
>> sys: mean: 487.36s, stdev: 5.53s
>>
>> The performance is neck-to-neck.
>>
>>
>> IV. Future Use Cases
>>
>> While the patch series focus on two applications (decoupling swap
>> backends and swapoff optimization/simplification), this new,
>> future-proof design also allows us to implement new swap features more
>> easily and efficiently:
>>
>> * Multi-tier swapping (as mentioned in [5]), with transparent
>>    transferring (promotion/demotion) of pages across tiers (see [8] and
>>    [9]). Similar to swapoff, with the old design we would need to
>>    perform the expensive page table walk.
>> * Swapfile compaction to alleviate fragmentation (as proposed by Ying
>>    Huang in [6]).
>> * Mixed backing THP swapin (see [7]): Once you have pinned down the
>>    backing store of THPs, then you can dispatch each range of subpages
>>    to appropriate backend swapin handler.
>> * Swapping a folio out with discontiguous physical swap slots
>>    (see [10]).
>> * Zswap writeback optimization: The current architecture pre-reserves
>>    physical swap space for pages when they enter the zswap pool, giving
>>    the kernel no flexibility at writeback time. With the virtual swap
>>    implementation, the backends are decoupled, and physical swap space
>>    is allocated on-demand at writeback time, at which point we can make
>>    much smarter decisions: we can batch multiple zswap writeback
>>    operations into a single IO request, allocating contiguous physical
>>    swap slots for that request. We can even perform compressed writeback
>>    (i.e writing these pages without decompressing them) (see [12]).
>>
>>
>> V. References
>>
>> [1]: https://lore.kernel.org/all/CAJD7tkbCnXJ95Qow_aOjNX6NOMU5ovMSHRC+95U4wtW6cM+puw@mail.gmail.com/
>> [2]: https://lwn.net/Articles/932077/
>> [3]: https://www.youtube.com/watch?v=Hwqw_TBGEhg
>> [4]: https://lore.kernel.org/all/Zqe_Nab-Df1CN7iW@infradead.org/
>> [5]: https://lore.kernel.org/lkml/CAF8kJuN-4UE0skVHvjUzpGefavkLULMonjgkXUZSBVJrcGFXCA@mail.gmail.com/
>> [6]: https://lore.kernel.org/linux-mm/87o78mzp24.fsf@yhuang6-desk2.ccr.corp.intel.com/
>> [7]: https://lore.kernel.org/all/CAGsJ_4ysCN6f7qt=6gvee1x3ttbOnifGneqcRm9Hoeun=uFQ2w@mail.gmail.com/
>> [8]: https://lore.kernel.org/linux-mm/4DA25039.3020700@redhat.com/
>> [9]: https://lore.kernel.org/all/CA+ZsKJ7DCE8PMOSaVmsmYZL9poxK6rn0gvVXbjpqxMwxS2C9TQ@mail.gmail.com/
>> [10]: https://lore.kernel.org/all/CACePvbUkMYMencuKfpDqtG1Ej7LiUS87VRAXb8sBn1yANikEmQ@mail.gmail.com/
>> [11]: https://lore.kernel.org/all/CAMgjq7BvQ0ZXvyLGp2YP96+i+6COCBBJCYmjXHGBnfisCAb8VA@mail.gmail.com/
>> [12]: https://lore.kernel.org/linux-mm/ZeZSDLWwDed0CgT3@casper.infradead.org/
>> [13]: https://lore.kernel.org/all/20251121-ghost-v1-1-cfc0efcf3855@kernel.org/
>> [14]: https://lore.kernel.org/linux-mm/20251202170222.GD430226@cmpxchg.org/
>>
>> Nhat Pham (20):
>>    mm/swap: decouple swap cache from physical swap infrastructure
>>    swap: rearrange the swap header file
>>    mm: swap: add an abstract API for locking out swapoff
>>    zswap: add new helpers for zswap entry operations
>>    mm/swap: add a new function to check if a swap entry is in swap
>>      cached.
>>    mm: swap: add a separate type for physical swap slots
>>    mm: create scaffolds for the new virtual swap implementation
>>    zswap: prepare zswap for swap virtualization
>>    mm: swap: allocate a virtual swap slot for each swapped out page
>>    swap: move swap cache to virtual swap descriptor
>>    zswap: move zswap entry management to the virtual swap descriptor
>>    swap: implement the swap_cgroup API using virtual swap
>>    swap: manage swap entry lifecycle at the virtual swap layer
>>    mm: swap: decouple virtual swap slot from backing store
>>    zswap: do not start zswap shrinker if there is no physical swap slots
>>    swap: do not unnecesarily pin readahead swap entries
>>    swapfile: remove zeromap bitmap
>>    memcg: swap: only charge physical swap slots
>>    swap: simplify swapoff using virtual swap
>>    swapfile: replace the swap map with bitmaps
>>
>>   Documentation/mm/swap-table.rst |   69 --
>>   MAINTAINERS                     |    2 +
>>   include/linux/cpuhotplug.h      |    1 +
>>   include/linux/mm_types.h        |   16 +
>>   include/linux/shmem_fs.h        |    7 +-
>>   include/linux/swap.h            |  135 ++-
>>   include/linux/swap_cgroup.h     |   13 -
>>   include/linux/swapops.h         |   25 +
>>   include/linux/zswap.h           |   17 +-
>>   kernel/power/swap.c             |    6 +-
>>   mm/Makefile                     |    5 +-
>>   mm/huge_memory.c                |   11 +-
>>   mm/internal.h                   |   12 +-
>>   mm/memcontrol-v1.c              |    6 +
>>   mm/memcontrol.c                 |  142 ++-
>>   mm/memory.c                     |  101 +-
>>   mm/migrate.c                    |   13 +-
>>   mm/mincore.c                    |   15 +-
>>   mm/page_io.c                    |   83 +-
>>   mm/shmem.c                      |  215 +---
>>   mm/swap.h                       |  157 +--
>>   mm/swap_cgroup.c                |  172 ---
>>   mm/swap_state.c                 |  306 +----
>>   mm/swap_table.h                 |   78 +-
>>   mm/swapfile.c                   | 1518 ++++-------------------
>>   mm/userfaultfd.c                |   18 +-
>>   mm/vmscan.c                     |   28 +-
>>   mm/vswap.c                      | 2025 +++++++++++++++++++++++++++++++
>>   mm/zswap.c                      |  142 +--
>>   29 files changed, 2853 insertions(+), 2485 deletions(-)
>>   delete mode 100644 Documentation/mm/swap-table.rst
>>   delete mode 100644 mm/swap_cgroup.c
>>   create mode 100644 mm/vswap.c
>>
>>
>> base-commit: 05f7e89ab9731565d8a62e3b5d1ec206485eeb0b
>> --
>> 2.47.3
> 
> Weirdly, it seems like the cover letter (and only the cover letter) is
> not being delivered...
> 
> I'm trying to figure out what's going on :( My apologies for the
> inconvenience...
> 

Are you CCing all maintainers that get_maintainers.pl suggests you to cc?

-- 
Cheers,

David

