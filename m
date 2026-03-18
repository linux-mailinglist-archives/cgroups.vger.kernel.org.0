Return-Path: <cgroups+bounces-14881-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEd6D2snu2kcfwIAu9opvQ
	(envelope-from <cgroups+bounces-14881-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 23:30:03 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA75C2C35F1
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 23:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0F9230A24D1
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 22:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED59D3783DB;
	Wed, 18 Mar 2026 22:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdZMyp/7"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FBA31A7F6
	for <cgroups@vger.kernel.org>; Wed, 18 Mar 2026 22:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773872997; cv=none; b=lsvLQayUKzkGLCb9ah2PobBqbBejFb8ZMxxnDYIZIB7KQbvd3/tQzzA8Y4qtI0l8j5pPlLgmoEQ6N2JtTP5Apn/xE++pXz0Q460yiZRKTznzR/fit5na6+owDwCMdbiuBNNzwBhDkPMMUDgbxwNBaVmC9IhFr+5jGYK5Gxg0ALk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773872997; c=relaxed/simple;
	bh=Z3SFT2WSimePZ+OS0f66iMUnMpZGk1N3KKTfJ46WGlo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hQEUrLxYh/U6kmtRyKC4sfK1pmkm8ujOKRbvAE2MUMsVEqjn9EwRdcb0n4RDmCoNCHCkKFjZd5RW9HzQ3WqZspkaSOM0FP8/z1bb/pEQAd3+4m+PTY92yvkTgouBaay8eOcwUBw0fnC6zwAnT4vXMwjwi+4mB6cvfzc+3goVC7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdZMyp/7; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-67bb5f989c4so248569eaf.1
        for <cgroups@vger.kernel.org>; Wed, 18 Mar 2026 15:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773872995; x=1774477795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RRYnHpo8uKuUlS1v8ui4dqVxSU8CGxN8PZ2oQLxXs9Q=;
        b=gdZMyp/7ZU0btmfhqF0iu0Y2585tUeIevIwIUPwGsVgKU0O7iOVUIscddgAuCW0Q+U
         BEXtwHnQdTFzb28ViJrOkj1W1wA+WOneqobIVouG2GgTWh9SG/AcolqD3tG1H+IbzMxF
         6UujBPA5tv9LxL6WPQ1w+T2EagziHN2EafCeE5T8z6gXRDEAfMyxEGMWGNRPcMbNULMK
         u8WVhwRe0y8XffIhLJpb+YZ3BubnPeqfCFQF2+iXf04AfWrvL0N3HxoqxGD2XbNyXAMJ
         KHaakCXZcMHfT15kq8TESIJ2iUKtUvxfeQvvuYEj1o0L3Jov6xGwwBmskgCj2NPuYCRt
         lCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773872995; x=1774477795;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RRYnHpo8uKuUlS1v8ui4dqVxSU8CGxN8PZ2oQLxXs9Q=;
        b=MSCQKoL/QpZy0glxtsnDrMsL9OAgWPfixap58iJJ2Htg7uDyoRf9rzWHpjqr5+Gwj3
         g5hdFrDaTNcn/UZjf7QXhy/BHugGwRom/o9BMDARRYuIiv5eSAFKbY/0t/10R6pty28h
         tNc9dnLloXxK0qeins+yp+dqKBX/Xv9X5Iz1P7736KvGSjmsNKfjhlaA9kLWaeUJViw+
         ur4s6h0oFxjlqEg+uH/0xch9FypfbPpw6BzgGaxkzNJbDPaDKrkWAeyJ9eRkmyU6iYov
         PjgWXxgNnOKCIRy2DnKzYhjy6Ryf6GvgKQDGcxAcBxtfSuDIga7x9qqP5wCpIZdbyaHg
         U1kQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3p2+aVZqc7RWyv8gx3XoqSCEUxWc9bsenFsIkPKOHo/3NwMRG0MiIy7q/BtV4udvbRJC6dTpG@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1+KkOtKZjAOVyhPAZqU7Lu6sehuIojxd9Y0dMtXxVf4Smf6tG
	hfaRM1Zsao8sJp9weEG3IJnGgvOMUPWa21laVPzH+RjN6kPOPml2n88m
X-Gm-Gg: ATEYQzzxNoe2rfleMzXVq8s/fu+AQTGmVNbQITqoHXqNV2SGX7iGqWPesSioIr9rhjT
	rk8ps6s1bMlt4HTi2j1HayV9xvXaP9FDXOV9FtTkb/aiUyukuEMXQrO7AXnl/roVCMbWithpRQ9
	5ppFuSXz2barH8NeF53ueoWXf4p9BBks0PS2+Psmjv4iZS4LeB2yYB27gqg6d3HOsNsBgZeAfCS
	QhI3FJzuwuDdc38rrG32r3NIUpRVy0lhs5BakeOZI/HSzfeEcZy9vBMNAw0KQke5H1upsG7UwOM
	j0y7TOQZXoE29jp+BZ4A9JY6RnQzilgu+HkxIw/xnf4zxG/IYvvzysSSW3Qef6O5+LKT8vONsTV
	NN4Nx2Jo2Bz6Tc6r9U3dJ5tKeDIfYN+WiYd5zGFCE0CMS9ZzY8+uULHp1rvoDPRnElUVBNlpNrb
	whpvJR3f+SEQKNarVtlaTh8YCTGmuaV+u2XpdzAwlndJT7
X-Received: by 2002:a05:6820:3094:b0:67b:ab68:b5e2 with SMTP id 006d021491bc7-67c0daa2707mr3707316eaf.18.1773872994524;
        Wed, 18 Mar 2026 15:29:54 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:2::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67c0d89ca52sm2470471eaf.12.2026.03.18.15.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 15:29:53 -0700 (PDT)
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
	riel@surriel.com
Subject: [PATCH v4 00/21] Virtual Swap Space
Date: Wed, 18 Mar 2026 15:29:31 -0700
Message-ID: <20260318222953.441758-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14881-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[54];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.953];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DA75C2C35F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


This patch series is based on 6.19. There are a couple more
swap-related changes in mainline that I would need to coordinate
with, but I still want to send this out as an update for the
regressions reported by Kairui Song in [15]. It's probably easier
to just build this thing rather than dig through that series of
emails to get the fix patch :)

Changelog:
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

To measure the performance of the new implementation, I have run the
following benchmarks:

1. Kernel building: 52 workers (one per processor), memory.max = 3G.

Using zswap as the backend:

Baseline:
real: mean: 164.29s, stdev: 0.53s
user: mean: 5109.06s, stdev: 2.04s
sys: mean: 672.62s, stdev: 30.46s

Vswap:
real: mean: 164.12s, stdev: 0.4s
user: mean: 5105.24s, stdev: 2.01s
sys: mean: 668.66s, stdev: 34.45s

Using SSD swap as the backend:

Baseline:
real: mean: 189.74s, stdev: 2.03s
user: mean: 5035.93s, stdev: 3.1s
sys: mean: 500.01s, stdev: 4.16s

Vswap:
real: mean: 190.18s, stdev: 4.35s
user: mean: 5038.26s, stdev: 7.39s
sys: mean: 497.09s, stdev: 12.3s

The performance is neck-to-neck for both swap backends, with vswap
slightly edging out in systime. However, the variance is high, so it is
hard to draw a definitive conclusion.

2. Usemem: Per a report from Kairui Song ([15]), I have run the
   following benchmark:

Memory state of the system:

free -m
               total        used        free      shared  buff/cache   available
Mem:           31596        5094       11667          19       15302       26502
Swap:          65535          33       65502

Running the usemem benchmark with n = 1, 56G for 5 times, and average
out the result:

Baseline (6.19):
real: mean: 190.93s, stdev: 5.09s
user: mean: 46.62s, stdev: 0.27s
sys: mean: 128.51s, stdev: 5.17s
throughput: mean: 382093 KB/s, stdev: 11173.6 KB/s
free time: mean: 7916690.2 usecs, stdev: 88923.0 usecs

VSS:
real: mean: 187.66s, stdev: 5.67s
user: mean: 46.5s, stdev: 0.16s
sys: mean: 125.3s, stdev: 5.58s
throughput: mean: 387506.4 KB/s, stdev: 12556.56 KB/s
free time: mean: 7029733.8 usecs, stdev: 124661.34 usecs


IV. Future Use Cases

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

