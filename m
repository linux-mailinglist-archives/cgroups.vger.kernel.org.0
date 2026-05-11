Return-Path: <cgroups+bounces-15764-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ZoIjKDUJAmqznQEAu9opvQ
	(envelope-from <cgroups+bounces-15764-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 18:52:05 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 325BE512AF0
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 18:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F3999314ADE7
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 16:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8351347276D;
	Mon, 11 May 2026 16:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DofAni5J"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469AF43CEC4
	for <cgroups@vger.kernel.org>; Mon, 11 May 2026 16:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778517257; cv=none; b=lVbs0OBA8KZgjzKhRkCmP3dLrsWEbXQjBsIYUw5hHqXtOBqTvBMkVoF+nEU47cA+ixndEv4ZOsh6qxIRVjciSIaKqcleDmCe1UcpSSFy5fs91kCisps2XPesj/Skzp4h/rVfHXXSzPfyapbuLg78JehsatZJwbUJPUtDfqPCDdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778517257; c=relaxed/simple;
	bh=3nr0vIIFvbfF0sgso3eC8e1RvYRXIeBy5fBg+8Eejk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MzOUVYQHGid6f/GC2OxjGVyguIe47TjtZ4fbsSdWHLDgtfDhqZ7B1rmNga8vXdyGWeZTnvsK4YQN2XxOpbh+UWiBiKsXQiHaKOkhOPAXfS8NF/8z/BZTeXt43sLqz9IDB6MXMrvt59NxmitT4Z6zmqmFKuToHhFLSQQBaZ1Q5zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DofAni5J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B038C4AF10
	for <cgroups@vger.kernel.org>; Mon, 11 May 2026 16:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778517257;
	bh=3nr0vIIFvbfF0sgso3eC8e1RvYRXIeBy5fBg+8Eejk4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DofAni5JHJPiIfUAa0D+nHQ9Hp7yalueX4UqWa7EnlvCZRyn0e2Hbj3C/qkaGt9oY
	 i2AHNrQBSzidcrllKFnby7E+G5ZX01qvRxibc0xcrjiAZtyZf2HCUQxGZsnbRfj4Gq
	 OjgrEPgILHhkOq1smyDO0Uf9j8rSCUQrtoiSf6ncON4iNR7jPR+qXkFus49eaZshkA
	 oWxMeBH/AIoDW73OZt0Em0YRRQtt+0rqHS/X83ErCaQvTk6EePt1bZ3TLYSUok5t37
	 43kQL1vjYOr9VdI1O2UhotkqPWrVXAnDa9MecJg0A8c1IV1fraty2Pue4LW5gV7pf4
	 Y7shLVoim/sEQ==
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7bf0b47d2f1so41084177b3.3
        for <cgroups@vger.kernel.org>; Mon, 11 May 2026 09:34:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8iBKn6cVJk82iy1aJwxr+MXggQMBm1UbPAYbT+HKdroh5Bfb19BjwHMOMQQUN2jFbSgALx7xJf@vger.kernel.org
X-Gm-Message-State: AOJu0YySCpQLvGcEKGzlvpKr7VWTXaYE1HALS/BwB3cAu6VKE6PpeoEg
	40GzpTNAO+KOOAB44IEc+F8hRjfMBqbBt4g1CPw39kUJAO40MpKyISnh5ZMw4FcjL+qW09gMVBs
	Urzzx/YLKYehvD63JDHDnikK1Q/DJXGGbrkwZWaaqBg==
X-Received: by 2002:a05:690e:4087:b0:650:dbb:e79c with SMTP id
 956f58d0204a3-65d94c4c496mr14333914d50.40.1778517256388; Mon, 11 May 2026
 09:34:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421-swap-table-p4-v3-0-2f23759a76bc@tencent.com>
In-Reply-To: <20260421-swap-table-p4-v3-0-2f23759a76bc@tencent.com>
From: Chris Li <chrisl@kernel.org>
Date: Mon, 11 May 2026 18:34:03 +0200
X-Gmail-Original-Message-ID: <CACePvbXGVYtX8hQCRsSO1EkiDhXWpwmTFZJGxCcoF09dbLK0Xw@mail.gmail.com>
X-Gm-Features: AVHnY4LUbtJn8VCJ09yjo5GzGsZ7W7DUQUUlJ4Zgjocidx3KutvjsQwKCnBuG-c
Message-ID: <CACePvbXGVYtX8hQCRsSO1EkiDhXWpwmTFZJGxCcoF09dbLK0Xw@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] mm, swap: swap table phase IV: unify allocation
 and reduce static metadata
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kasong@tencent.com, linux-mm@kvack.org, 
	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>, 
	Hugh Dickins <hughd@google.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Youngjun Park <youngjun.park@lge.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Dev Jain <dev.jain@arm.com>, 
	Lance Yang <lance.yang@linux.dev>, Michal Hocko <mhocko@suse.com>, Michal Hocko <mhocko@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 325BE512AF0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15764-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[tencent.com,kvack.org,kernel.org,nvidia.com,linux.alibaba.com,google.com,huaweicloud.com,gmail.com,redhat.com,cmpxchg.org,lge.com,linux.dev,bytedance.com,vger.kernel.org,arm.com,suse.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chrisl@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, Apr 20, 2026 at 11:16=E2=80=AFPM Kairui Song via B4 Relay
<devnull+kasong.tencent.com@kernel.org> wrote:
>
> This series unifies the allocation and charging of anon and shmem swap
> in folios, provides better synchronization, consolidates the metadata
> management, hence dropping the static array and map, and improves the
> performance. The static metadata overhead is now close to zero, and
> workload performance is slightly improved.
>
> For example, mounting a 1TB swap device saves about 512MB of memory:
>
> Before:
> free -m
>           total   used      free   shared   buff/cache   available
> Mem:       1464    805       346        1          382         658
> Swap:   1048575      0   1048575
>
> After:
> free -m
>           total   used      free   shared   buff/cache   available
> Mem:       1464    277       899         1         356        1187
> Swap:   1048575      0   1048575
>
> Memory usage is ~512M lower, and we now have a close to 0 static
> overhead. It was about 2 bytes per slot before, now roughly 0.09375
> bytes per slot (48 bytes ci info per cluster, which is 512 slots).
>
> Performance test is also looking good, testing Redis in a 1.5G VM using
> 5G ZRAM as swap:
>
> valkey-server --maxmemory 2560M
> redis-benchmark -r 3000000 -n 3000000 -d 1024 -c 12 -P 32 -t get
>
> Before: 3289011.918750 RPS
> After:  3312087.142241 RPS (0.99% better)
>
> Testing with build kernel under global pressure on a 48c96t system,
> limiting the total memory to 8G, using 12G ZRAM, 24 test runs,
> enabling THP:
>
> make -j96, using defconfig
>
> Before: user time 2904.59s system time 4773.99s
> After:  user time 2909.38s system time 4641.55s (2.77% better)
>
> Testing with usemem on a 32c machine using 48G brd ramdisk and 16G
> RAM, 12 test run:
>
> usemem --init-time -O -y -x -n 48 1G
>
> Before: Throughput (Sum): 6482.58 MB/s Free Latency: 371371.67us
> After:  Throughput (Sum): 6539.28 MB/s Free Latency: 363059.88us
>
> Seems similar, or slightly better.
>
> This series also reduces memory thrashing, I no longer see any:
> "Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF", it was
> shown several times during stress testing before this series when under
> great pressure:
>
> Before: grep -Ri VM_FAULT_OOM <test logs> | wc -l =3D> 18
> After:  grep -Ri VM_FAULT_OOM <test logs> | wc -l =3D> 0
>
> Signed-off-by: Kairui Song <kasong@tencent.com>

Hi Andrew,

I have given this swap table phase 4 series the first round of review.
Overall, it looks good with some minor nitpicks.

Can you add this to the mm-unstable for  more exposures?

Thanks

Chris

> ---
> Changes in v3:
> - This is based on mm-unstable, also applies to mm-new, and has no
>   conflict with YoungJun's tier series, and only trivial conflict with
>   Baoquan's swapops due to filename change.
> - Fix zero map build issue on 32 bit archs [ YoungJun Park ]
> - Cleanup memcg table allocation helpers [ YoungJun Park ]
> - Fix WARN for non NUMA build:
>   https://lore.kernel.org/linux-mm/CAMgjq7ANih7u7SJB8uWcQHS8XRJySNRc3ti9V=
-SVey0nGE3gLQ@mail.gmail.com/
> - Improve of commit messages.
> - Re-test several tests, the conclusion is the same as v2.
> - Link to v2: https://patch.msgid.link/20260417-swap-table-p4-v2-0-17f5d1=
015428@tencent.com
>
> Changes in v2:
> - Drop the RFC prefix and also the RFC part.
> - Now there is zero change to cgroup or refault tracking, RFC v1 changed
>   some cgroup behavior. To archive that v2 use a standalone memcg_table
>   for each cluster. It can be dropped or better optimized later if we
>   have a better solution. The performance gain is partly cancelled
>   compared to RFC v1 since we now need an extra allocation for free clust=
er
>   isolation and peak memory usage is 2 bytes higher. But still looking
>   good. That table size is accetable (1024 bytes), no RCU needed, and
>   fits for kmalloc. Even if we keep it as it is in the future,
>   it's still accetable.
> - Link to v1: https://lore.kernel.org/r/20260220-swap-table-p4-v1-0-10479=
5d19815@tencent.com
>
> To: linux-mm@kvack.org
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Chris Li <chrisl@kernel.org>
> Cc: Kairui Song <kasong@tencent.com>
> Cc: Kemeng Shi <shikemeng@huaweicloud.com>
> Cc: Nhat Pham <nphamcs@gmail.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Barry Song <baohua@kernel.org>
> Cc: Youngjun Park <youngjun.park@lge.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Yosry Ahmed <yosry@kernel.org>
> Cc: Chengming Zhou <chengming.zhou@linux.dev>
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Lorenzo Stoakes <ljs@kernel.org>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: Lance Yang <lance.yang@linux.dev>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Shakeel Butt <shakeel.butt@linux.dev>
> Cc: Muchun Song <muchun.song@linux.dev>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Axel Rasmussen <axelrasmussen@google.com>
> Cc: Qi Zheng <zhengqi.arch@bytedance.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: cgroups@vger.kernel.org
>
> ---
> Kairui Song (12):
>       mm, swap: simplify swap cache allocation helper
>       mm, swap: move common swap cache operations into standalone helpers
>       mm/huge_memory: move THP gfp limit helper into header
>       mm, swap: add support for stable large allocation in swap cache dir=
ectly
>       mm, swap: unify large folio allocation
>       mm/memcg, swap: tidy up cgroup v1 memsw swap helpers
>       mm, swap: support flexible batch freeing of slots in different memc=
gs
>       mm, swap: delay and unify memcg lookup and charging for swapin
>       mm, swap: consolidate cluster allocation helpers
>       mm/memcg, swap: store cgroup id in cluster table directly
>       mm/memcg: remove no longer used swap cgroup array
>       mm, swap: merge zeromap into swap table
>
>  MAINTAINERS                 |   1 -
>  include/linux/huge_mm.h     |  30 +++
>  include/linux/memcontrol.h  |  16 +-
>  include/linux/swap.h        |  19 +-
>  include/linux/swap_cgroup.h |  47 ----
>  mm/Makefile                 |   3 -
>  mm/huge_memory.c            |   2 +-
>  mm/internal.h               |  11 +-
>  mm/memcontrol-v1.c          |  66 +++---
>  mm/memcontrol.c             |  32 +--
>  mm/memory.c                 |  88 ++------
>  mm/page_io.c                |  58 ++++-
>  mm/shmem.c                  | 122 +++--------
>  mm/swap.h                   |  91 +++-----
>  mm/swap_cgroup.c            | 172 ---------------
>  mm/swap_state.c             | 516 +++++++++++++++++++++++++-------------=
------
>  mm/swap_table.h             | 169 ++++++++++++---
>  mm/swapfile.c               | 212 +++++++++---------
>  mm/vmscan.c                 |   2 +-
>  mm/zswap.c                  |  25 +--
>  20 files changed, 783 insertions(+), 899 deletions(-)
> ---
> base-commit: f1541b40cd422d7e22273be9b7e9edfc9ea4f0d7
> change-id: 20260111-swap-table-p4-98ee92baa7c4
>
> Best regards,
> --
> Kairui Song <kasong@tencent.com>
>
>

