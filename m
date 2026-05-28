Return-Path: <cgroups+bounces-16402-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LgjINyzGGr9mAgAu9opvQ
	(envelope-from <cgroups+bounces-16402-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 23:30:04 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D925FA661
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 23:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4CFF4302A7F5
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 21:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD87335C1A6;
	Thu, 28 May 2026 21:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sd4LBglO"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A22346781
	for <cgroups@vger.kernel.org>; Thu, 28 May 2026 21:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780003799; cv=none; b=N1cE0hAZslI3ftXqsiMkA9PlAvMZ/tdztmEI3zF/jYEujpVb2cjphixpgdZxlQUUitT28omlb3CDw51mwfO34gkEj6Vyr9caU1SwoGowcCDaAbtBENKXKsLu3ksy6wb1+enOdPE/pZ+/H+tLb2FSGraz3Lv8apt19MNKF2yLteE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780003799; c=relaxed/simple;
	bh=UrAhsPjmd0TupF+c+fm0hjWZinFhGQubT221z6T/6m4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EeIE+T89ZivF/4DsbOlsMDjeUzqkKppaXBhePyb+VH2C6R1gE3nRRodnlHU75a0FtS5A+PkCOEp9nxdVIhfh/ZzxvPuorMuWHbFoz3gan3lmUlbiRS8f/Sglj3xsm2FY3T0LKk09FS5Uwx7iY4p3GCoG9JDKgl611zBMjYFLius=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sd4LBglO; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7e6128bd9b3so3486065a34.1
        for <cgroups@vger.kernel.org>; Thu, 28 May 2026 14:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780003797; x=1780608597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XJk3QCW8gkREhNPtXeh46plc74xVDY9UZfjfo7eIXnI=;
        b=Sd4LBglONA2wQrRW+/iWTB+cwRcCB0pVYl8Z53xb2/4KO+wmSrydrHYO/g/ruaDGBo
         I7idkbaSBqXiFVHELvAeBeGlGioJ754w0T2J84jL8Zd5eLaMQ+7iZkX/D7cBPBCQ3l5g
         J5XQ58/12bXVtSCPCG3Ft7tCbOndRslUpl+EYSrc0JotW6DyVNW4zIA0vkAPKq0/hLpQ
         iXvm/PS/TTIZq2OD0Bu63VkRD+cQeTQUNHnDD7EZW9tf50MSkfS2MKS7qdRiQKr34z7d
         6UJsRsbBzXAlJG+NZVtuHBXzmVLLuDgar310zEzb8dsof9CvmWBdUMKQqsgQdKZ3630i
         REEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780003797; x=1780608597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XJk3QCW8gkREhNPtXeh46plc74xVDY9UZfjfo7eIXnI=;
        b=Zwy4hWzhtSxe4guaY+uiXkzzNtO8B7IXRrRtpXgfzWfb04z1t0D2KLmeSnPRorOiiw
         A6VRhUsTWi0UgggjFLYqEv9K0PHZc+rMcEcDP4+pUBXcIFPd4DYJaoAA6cWFpnpnWoh0
         tbvqYzwRo3WDntuPp4py1lYV+r/xrcPYgd8OjvPp+1iPAQhpLTermX3yO09MDlUYZI1A
         201a9SwrzGUJjfefRaIUt99beiHV4sWdS5AqdlxKJgr1xcWBcgoDcJEU0OYEwbsgIkSy
         PQnMboflOMGKsE8fDjqWEYryPhOUGgycdtlsVv6iwS8KvD+MW2Q0VJ4NegEdUISAZYOX
         jAZg==
X-Forwarded-Encrypted: i=1; AFNElJ/cdhG/s1f1h0c4ulGTwxB2jN7NZHVjpa85/oFIEoHGSmaKrUn91fMzlON1+FAAuItHHTTqLM/o@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2gcbCjo1mAtBDxh+OCIN6YBsAkifcjvS91+/g+GPn3kQyCcQd
	cLF816Ne8xhNA6DibE2QyLH7CZfSMNqKUpLfE3yLmxXQg5UX/v1t344R
X-Gm-Gg: Acq92OEmmEalBs2MGtezQLRkMtuIa3+mXovrhGjF0lBi5Owo6w3XUvAmuxyAmN2XW7V
	h1O7btH5gkBq91LgrvnbQGuCDDRHV+QYMl1AFSZRGLb1Xwvoee8tLKEY4Q9jF8smTaYyM7Iqar9
	UQMaUcTH2/4z7LNH7N8nHW4sHNBdwn3ebmZczfiRqe7VL1CYAbEL1bzmxhGk+JzCwV+AjtbjhTz
	hOyfBEs43399Dc/3TU8DpFsQ/jWL/9WbcNmAiyZJHEm/TuQ2ygiKDWwZhaHdrzCPBRXHDH7TvAE
	VqNNnYvfXhPxWpF3hdgnH5ULKNwsSTqsHKPfSV3REeO7jmi4+YznKIsG0tPdalFCsYaqu9OHxhO
	9aZvJBNUl6oCs8CIUySm8impvnfpuoVLFed/XtdRYhk4LgIoKkeZhQs1g7Kx1bFhHOmUfv2qTGX
	5XccfA6UZjqZZuInvqw2q5eONYbaKwKskcKaNRBSiJfH+ajRkaAvnDIlGq
X-Received: by 2002:a05:6830:81e9:b0:7d7:570b:6800 with SMTP id 46e09a7af769-7e694e30aa5mr217105a34.23.1780003796651;
        Thu, 28 May 2026 14:29:56 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:54::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e695212fa5sm129153a34.17.2026.05.28.14.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 14:29:56 -0700 (PDT)
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
Subject: [RFC PATCH 0/5] mm, swap: Virtual Swap Space (Swap Table Edition)
Date: Thu, 28 May 2026 14:29:24 -0700
Message-ID: <20260528212955.1912856-1-nphamcs@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	TAGGED_FROM(0.00)[bounces-16402-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_GT_50(0.00)[55];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: E9D925FA661
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Based on: mm-unstable @ 444fc9435e57 + swap-table phase IV v5 [2].

I manually adapted Kairui's ghost device implementation (from [4])
for my vswap device. I've credited him as Co-developed-by on Patch I
since a substantial portion of the dynamic-cluster infrastructure is
his (I did propose the idea of using xarray/radix tree for dynamic
swap clusters allocation and management though :P).

From here on out, for simplicity, I will refer to swap table phase IV
as "P4", and the older v6 virtual swap space implementation as "v6".


I. Context and Motivation

Virtual swap decouples PTE swap entries from physical swap backing,
allowing pages to be compressed by zswap without pre-allocating a
physical swap slot. See [1] for a more involved discussion on the
motivation of swap virtualization, but in short, a swap virtualization
scheme needs to satisfy 3 requirements, which are all driven by real
pressing use cases of many parties using swap:

1. No backend coupling. For instance, a zswap entry should not
   require a physical swap slot to be allocated. This prevents
   wastage of coupled backend resources, and allows zswap to be
   used in systems that do not have enough storage capacity for
   physical swap (without having to resort to silly hacks). The same
   should hold for zero-filled swap pages, and swap cached folios too.

2. Dynamic swap space. The virtualization scheme should not require
   static provisioning, to accommodate dynamic and unpredictable swap
   usage. This massively simplifies operational provisioning, and
   allow the in-memory compression backend to be maximally utilized.
   It also makes sure we do not induce unbounded overhead on unused
   swap capacity.

3. Efficient backend transfer. The virtualization scheme should not
   introduces PTE/rmap walking overhead for backend transfer. This
   is crucial for systems that want to support multiple swap backends
   in a tiering fashion (for e.g zswap -> disk swap).

There are a lot of other future use cases as well - see [1] for more
details.

This series reimplements the virtual swap space concept (see [1])
on top of Kairui Song's swap table infrastructure, on top of [2]
and in accordance with his proposal in [3]. The proposal's idea
is interesting, so I decided to give it a shot myself. I'm still not
100% sure that this is bug-proof, but hey, it compiles, and has
not crashed in my simple stress testing :)

The prototype here is feature-complete relative to the swap-table P4
baseline — swapout, swapin, freeing, swapoff, zswap writeback, zswap
shrinker, memcg charging, and THP swapin all work for
both vswap and direct-physical entries — and satisfies all three
requirements above: no backend coupling (zswap/zero entries hold no
physical slot), dynamic swap space (clusters allocated on demand via
xarray, no static provisioning), and efficient backend transfer
(in-place vtable updates, no PTE/rmap walking).

II. Design

With vswap, pages are assigned virtual swap entries on a ghost device
with no backing storage. These entries are backed by zswap, zero pages,
or (lazily) physical swap slots. Physical backing is allocated only
when needed — on zswap writeback or reclaim writeout, after the rmap
step.

Compared to the standalone v6 implementation [1], which introduces a
24-byte per-entry swap descriptor and its own cluster allocator, this
edition uses swap_table infrastructure, and share a lot of the allocator
logic. Per-slot metadata is stored in a tag-encoded virtual_table
(atomic_long_t, 8 bytes per slot), and physical clusters store
Pointer-tagged rmap entries in the swap_table for reverse lookup back to
the virtual cluster.

Here are some data layout diagrams:

  Case 1: vswap entry (virtualized)

  PTE                  swap_cluster_info_dynamic
  vswap_entry          +-------------------------+
  (swp_entry_t) ------>| swap_cluster_info (ci)  |
                       | +--------------------+  |
                       | | swap_table         |  |
                       | |   PFN / Shadow     |  |
                       | | memcg_table        |  |
                       | | count,flags,order  |  |
                       | | lock, list         |  |
                       | +--------------------+  |
                       |                         |
                       | virtual_table           |
                       | +--------------------+  |
                       | | NONE               |  |
                       | | PHYS               |  |
                       | | ZERO               |  |
                       | | ZSWAP(entry*)      |  |
                       | | FOLIO(folio*)      |  |
                       | +--------------------+  |
                       +-------------------------+
                              |
                              | PHYS resolves to
                              v
                       PHYSICAL CLUSTER (swap_cluster_info)
                       +--------------------------+
                       | swap_table per-slot:     |
                       |   NULL   - free          |
                       |   PFN    - cached folio  |
                       |   Shadow - swapped out   |
                       |   Pointer- vswap rmap    |
                       |   Bad    - unusable      |
                       |                          |
                       | Vswap-backing slot:      |
                       |   Pointer(C|swp_entry_t) |
                       |     rmap back to vswap   |
                       +--------------------------+

  Case 2: direct-mapped physical entry (no vswap)

  PTE                  PHYSICAL CLUSTER (swap_cluster_info)
  phys_entry           +--------------------------+
  (swp_entry_t) ------>| swap_table per-slot:     |
                       |   NULL   - free          |
                       |   PFN    - cached folio  |
                       |   Shadow - swapped out   |
                       |   Bad    - unusable      |
                       +--------------------------+

struct swap_cluster_info_dynamic {
    struct swap_cluster_info ci;       /* swap_table, lock, etc. */
    unsigned int index;                /* position in xarray */
    struct rcu_head rcu;               /* kfree_rcu deferred free */
    atomic_long_t *virtual_table;      /* backend info, 8 B/slot */
};

Each vswap cluster (swap_cluster_info_dynamic) extends the classic
swap_cluster_info struct with a virtual_table array that stores the
backend information for each virtual swap entry in the cluster. Each
entry is tag-encoded in the low 3 bits to indicate backend types:

  NONE:   |----- 0000 ------|000|  free / unbacked
  PHYS:   |-- (type:5,off:N)|001|  on a physical swapfile (shifted)
  ZERO:   |----- 0000 ------|010|  zero-filled page
  ZSWAP:  |--- zswap_entry* |011|  compressed in zswap
  FOLIO:  |--- folio* ------|100|  in-memory folio

We still have room for 3 more future backend types, for e.g. CRAM, i.e
compressed-CXL-as-swap, which is laid out in [10] and [11]. Worst
case scenario, we can add more fields to this extended struct.

Other design points:
- Both vswap entries (Case 1) and directly-mapped physical entries
  (Case 2) coexist as first-class citizens. All the common swap
  code paths — swapout, swapin, swap freeing, swapoff, zswap
  writeback, THP swapin, etc. work for both. When CONFIG_VSWAP=n,
  the vswap branches compile out and behavior should be identical to
  today's swap-table P4 (at least that is my intention).
- Pointer-tagged swap_table on physical clusters for rmap (physical
  -> virtual) lookup.
- Virtual swap slots not backed by physical swap are not charged to
  memcg swap counters — only physical backing is charged (I made the
  case for this in [7]).
- Careful separation of vswap and physical swap allocation paths and
  structures adds a lot of complexity, but is crucial to make sure
  both paths are efficient and do not conflict with each other (for
  correctness and performance). I do re-use a lot of the allocation
  logic wherever possible though.

  An example of this is the per-cpu cluster caching. I have found that
  caching virtual and physical clusters in the same structure is a
  recipe for bugs and performance regressions :) For instance, zswap
  shrinker will invalidate the cached virtual cluster, and cache its
  physical cluster instead, which will be reverted by the next vswap
  allocation.


And a lot more of these random tidbits off the top of my head. See the
patches for a proof-of-concept implementation.


III. Follow-ups:

In no particular order (and most of which can be done as follow-up
patch series rather than shoving everything in the initial landing):

- More thorough stress testing is very much needed.

- Performance benchmarks to make sure I don't accidentally regress
  the vswap-less case, and that the vswap's case performance is
  good. I suspect I will have to port a lot of the
  optimizations I implemented in v6 over here - some of the
  inefficiencies are inherent in any swap virtualization, and
  would require the same fix (for e.g the MRU cluster caching
  for faster cluster lookup - see [8] and [9]).

- Runtime enable/disable of the vswap device. To be honest, I don't
  know if there is a value in this. My preference is vswap can be
  optimized to the point that any overhead is negligible. Failing that,
  maybe we can come up with some simple heuristics that automatically
  decides for users?

  In this RFC, CONFIG_VSWAP=y means the vswap device is always created at
  boot, and CONFIG_VSWAP=n means the vswap device is never created. This
  *might* be enough just on its own.

  Is a runtime knob (sysfs or sysctl) worth the complexity beyond
  these heuristics? I'm not sure yet. Maintaining both cases
  at runtime also has overhead for checking as well, and some of the
  checks are not cheap :)

  Besides, what does swapon/swapoff buy us here? We do not want
  multiple vswap devices - they're identical performance-wise, so we
  will just fragment clusters unnecessarily. We do not care about
  sizing, since the metadata layer is completely dynamic. If we want
  to opt-out of vswap at runtime per-cgroup, maybe swap.tier by
  Youngjun (see [12]) is a better interface than swapon/swapoff?

- Defer per-cluster memcg_table and zeromap allocation on physical
  clusters. A physical swap cluster backing vswap entries only do
  not really need their memcg_table, but the current design forces
  us to allocate it anyway. This is a waste of memory, and is an
  overhead regression compared to my older design on the zswap-only
  case, which Johannes has pointed out multiple times (see [6]),
  and is one of the biggest reasons why I have not been satisfied
  with this approach thus far. It honestly is a bit of a
  deal-breaker...

  That said, I think I might be able to allocate them on demand, i.e
  only when the first direct-mapped slot is allocated on that cluster.
  That will give us the best of BOTH worlds, for both the vswap and
  directly-mapped physical swap cases. No promises, but I will try
  (if this approach is good enough for all parties).

- Widen swap_info_struct->max to unsigned long. The vswap device's
  max is currently clamped to ALIGN_DOWN(UINT_MAX, SWAPFILE_CLUSTER)
  (~16 TiB) to fit in unsigned int. 16 TiB is small for vswap,
  especially when we're getting increasingly big machines memory-wise.

- Supporting 32-bit architectures. I need to do the math carefully.
  But do we want to optimize for these architectures anyway? I think
  the only argument is if somehow virtual swap is so good that we
  can just get rid of the direct-mapped physical swap case entirely,
  so we need to support 32-bit architectures. I'm willing to have my
  mind changed though.

- Add some fat design doc (assuming this approach is acceptable to
  folks).

- Samefilled page handling is still doable BTW, if folks think this
  has value :)


This is an early RFC — I have only done basic functional testing so
far, and still need to run more thorough stress tests and benchmarks.
That said, I figure I should send this out early to get folks's
feedback, before I get myself too deep in this rabbit hole - the
complexity is already mounting...


[1]: https://lore.kernel.org/all/20260505153854.1612033-1-nphamcs@gmail.com/
[2]: https://lore.kernel.org/all/20260517-swap-table-p4-v5-0-88ae43e064c7@tencent.com/
[3]: https://lwn.net/Articles/1072657/
[4]: https://lore.kernel.org/all/20260220-swap-table-p4-v1-15-104795d19815@tencent.com/
[5]: https://lore.kernel.org/all/aerrps94j70MkgdW@gourry-fedora-PF4VCD3F/
[6]: https://lore.kernel.org/all/aZyFxKGXc8J6PIij@cmpxchg.org/
[7]: https://lore.kernel.org/linux-mm/CAKEwX=P4syV38jAVCWq198r2OHXXc=xA-fx1dk6+qYef6yzxWQ@mail.gmail.com/
[8]: https://lore.kernel.org/all/CAKEwX=NrUhUrAFx+8BYJEfaVKpCm-H9JhBzYSrqOQb-NW7QRug@mail.gmail.com/
[9]: https://lore.kernel.org/all/20260505153854.1612033-23-nphamcs@gmail.com/
[10]: https://lore.kernel.org/all/aerrps94j70MkgdW@gourry-fedora-PF4VCD3F/
[11]: https://lore.kernel.org/all/afIKxG5mJZE6QgpR@gourry-fedora-PF4VCD3F/
[12]: https://lore.kernel.org/all/20260527062247.3440692-1-youngjun.park@lge.com/

Nhat Pham (5):
  mm, swap: add virtual swap device infrastructure
  mm, swap: support zswap and zeroswap as vswap backends
  mm, swap: support physical swap as a vswap backend
  mm, swap: only charge physical swap entries
  mm, swap: add debugfs counters for vswap

 MAINTAINERS           |    1 +
 include/linux/swap.h  |   71 +++
 include/linux/zswap.h |    3 +
 mm/Kconfig            |   10 +
 mm/internal.h         |   20 +-
 mm/madvise.c          |    2 +-
 mm/memcontrol.c       |  132 ++++-
 mm/memory.c           |   34 +-
 mm/page_io.c          |  195 ++++++--
 mm/swap.h             |   59 ++-
 mm/swap_state.c       |   51 +-
 mm/swap_table.h       |   56 +++
 mm/swapfile.c         | 1096 +++++++++++++++++++++++++++++++++++++----
 mm/vmscan.c           |    5 +-
 mm/vswap.h            |  445 +++++++++++++++++
 mm/zswap.c            |  167 +++++--
 16 files changed, 2108 insertions(+), 239 deletions(-)
 create mode 100644 mm/vswap.h


base-commit: 401c55d4eacd97ffd24a89829655baa43b2b308e
-- 
2.53.0-Meta


