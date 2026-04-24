Return-Path: <cgroups+bounces-15504-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOKSMqyy62kJQgAAu9opvQ
	(envelope-from <cgroups+bounces-15504-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2026 20:13:00 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB014624BD
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2026 20:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 703CF301F5D0
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2026 18:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CFC3EDAD1;
	Fri, 24 Apr 2026 18:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvLt798O"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F6A3E8C4F
	for <cgroups@vger.kernel.org>; Fri, 24 Apr 2026 18:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777054349; cv=pass; b=KLxRR5MgL97GADHSpSekjbXRO4j2zwoQIVnn+8+yUfaJfqIkX8Hlcrt685gtQHzguTxiToSJpeEWP7OCsE/2H89FZjZ3pArwHOTZcrOxmh/HM7dpF8rQbjuGlKq+Ix/vqgp44trtUWNfSVHIjjCYZtKRqvoF3iUj87GVofEAQCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777054349; c=relaxed/simple;
	bh=oWvudX/YWuxrcb3vwIcLRuKcyktVwBEcaT0GVpHeh+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dXPk2B5G7IXAxgkB/+89c6exGFS/aGHMV8WHVmZMMpOVPbHfhbfwavRdiRyzpzoc0PlAmQij7lWw3TQdJRoOb+1Fb/WUkDhJloX2Tu3kng1KQoFBPvgE+uCt+RW6PF2vnQXeYwKD9dCRR7M+lvodEEG/AChZ2NIL9SBRfq+XRvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GvLt798O; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ba60d78aff3so980776766b.2
        for <cgroups@vger.kernel.org>; Fri, 24 Apr 2026 11:12:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777054345; cv=none;
        d=google.com; s=arc-20240605;
        b=YMMppBIxkkkmYisIJrGUW0Kq0IAgQ3h+VK1OvrNLY5gxjxPuE+pWitL73Y+bwdvyAZ
         xBNPdOUg3UlXOl4HiGfuW+RsU+Tpm136ZdCBeJezK/P8eFdQ86zdjTcK1SCqJJtBKeZ8
         NS2trk6pTtmGSKbAuSgsO6O0KSZxU/Pjm5eZwAe3w2jW5YnoRvb5SvmnZE/B4Q3f9IrX
         In8ZPAHBK6BPofHuJV4t2CKpYc0rswXLL9gnSjNlajrxgJoGR122rLSDlK2Z0myCiqJe
         svEYez+6+sMB2D9YhSAprUwgXACLxAOIsrkNbMKpkifPD5MyFKeeHzrgDiHSNhHa41fd
         d0fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RnhjUMS+7vRGMqxTPSDvZGQVsqKK9m9gvsqnQgN63xg=;
        fh=OsvLNx7JXZYBYgSmGS106kUazQQq6bMzeYq8Mm//iko=;
        b=f05azEMfTZhsViksraKYO3V3bFs766ObeWrZ77WmFvSKs/2x0U8ekuZzXEswkqOIiy
         i6nNABOclyu03lirFWnRM1lnRKBWXdaUJnMhrPIa9+izao+Bd+8ClSll9AjDWVjmwL78
         x0lIYlmth6YUMjwkwLFq4vrixF3Sjl8spaeWvjC63Z1u7Ek5jQ/XK7LK5aBUtvU7QudC
         B2CI7cy6u+B4P1p+BWjfWURTJCrynlzSbB4KS6WKLyauiSzddr0jzhhDv246cYmZ99La
         PnbLdPiyzgjvfA4WILklQW5pEChSX1iBM+zpqJ1ww8QBazbTxXdmHwpho3NDGVxO5csT
         8R7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777054345; x=1777659145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RnhjUMS+7vRGMqxTPSDvZGQVsqKK9m9gvsqnQgN63xg=;
        b=GvLt798OVASDpoV1IPMzgrOkcuD22H28F2Y2h9RSdNKtZbyHHR9ytMgxmcnyjNjYMV
         F1xpaIw3TbUcPY/9MbRm7doTyJdZ4gPrie4sOrUTx6gmXduI0D5PKtEoiTuJ4VCW/G6N
         UZC/CmCTYGHdHn3J4GMMcjb9UaPa2p/OxWzVovr3ObpKyDusO76SmOIPrvbwcbL3op0j
         XBBOEwa2+DbBj1f1iZGpnzHAWvDofG63uw9IYMM0fW3miJY7A3am+nqdjbT5mA7jxUif
         iWqbFSbDGeRiAwE+elgGuwiZMWX/hiJvXGPgUPVlK/2V5RIYTZ5hOHQkCsiiBDbn/5J9
         aARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777054345; x=1777659145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RnhjUMS+7vRGMqxTPSDvZGQVsqKK9m9gvsqnQgN63xg=;
        b=o0nygDxesFZYs1L2bUEoe8XgMGRvGnASsixzf+jcWvRcCZoelfB+xXac+wtmCj0Rcx
         PPyxHgsElAmfWetrO+dp/FefVtIccKXzln0rdJRcSRMQSTchMu03WwBWJrCGP10iBpq7
         VR15b3FoubhMDjBCJOspkutbN6mJgru7tv+hqfBrKWicQ79F9djAoLpNrLIJAQwPOA15
         L+ovZ6fd7NucFKPcgUyBfzvx7im6K4ykFe0/ZCYminCYH4xD5OWGTg+hQ4ufu9RNBZXd
         eJ4GynCJzfae9jW6ynU11e9pzYvmicbt3vmnS3ve00PtVxZ5gWLTy+NBdr2PLolPA8gK
         emGA==
X-Forwarded-Encrypted: i=1; AFNElJ+iqEEq0MTUQYp0l/HXzjHDy0o+ph4Do8CLHGOssgpWbiAnV+kC1REGvxMaMCNv2dVIqUfiPGF7@vger.kernel.org
X-Gm-Message-State: AOJu0YzBtyAfoCx/b5/qSwpBBjqNj6EdRpYY7+AU2/HKpKXn38IAk2qz
	wDUMyNewNcanoe3DsRyzGH0Muy87pt+ApT3AUgRGKjzQ+02JNtPfw+lAAoRobu+OsXUplFm3HZ2
	pIBaL8GXXi1/WZ6bcaPqrEH86+jocLP4=
X-Gm-Gg: AeBDieuBOAkZczJESNXY+AfeCEg+3AqldqtXxSu4Fbbzj9+ly3bCXOSGvBKqEgyUfmS
	cC7Eg4pLEgj5kjVZ1isw+TpChraWHvgZSZ7ZIkFBemCwzbDhf/aFXc9TChdBv7KSvz2kiRW390q
	4RxnlRM0W3e/0uEyYQWjNv2W8rajDRLtF/t0la3OacXsd3rzOlFAjtjZWPlbMfuVUC0GvLC7QDU
	xRLt3knnoGmLTH/RxhHkB33L5Y0rrPE823ftsDYLM/OuJas/m19YszyvbnRnh+Cyg5HqIPDQb0R
	Nqig37CHODoWr/MsBfRpTZEHVbAicbNN2nrrDBKv9GvK3OOO4VsNcdFFo9S8Tg==
X-Received: by 2002:a17:907:7213:b0:bae:5939:e5c8 with SMTP id
 a640c23a62f3a-bae5939e60cmr130631466b.36.1777054344590; Fri, 24 Apr 2026
 11:12:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421-swap-table-p4-v3-0-2f23759a76bc@tencent.com>
In-Reply-To: <20260421-swap-table-p4-v3-0-2f23759a76bc@tencent.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Sat, 25 Apr 2026 02:11:47 +0800
X-Gm-Features: AQROBzCwwQUz70l1uZVIPaiDZja0dRtNfD-VSwBzxKUwowi_lCo6xqP0LRdDB3k
Message-ID: <CAMgjq7CJ8Are6m7X2UxUoJ=77c_oSpdG8-bzkmdRzwey2Cp1gQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] mm, swap: swap table phase IV: unify allocation
 and reduce static metadata
To: kasong@tencent.com
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>, 
	Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <bhe@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Youngjun Park <youngjun.park@lge.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Dev Jain <dev.jain@arm.com>, 
	Lance Yang <lance.yang@linux.dev>, Michal Hocko <mhocko@suse.com>, Michal Hocko <mhocko@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 6FB014624BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15504-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,kernel.org,nvidia.com,linux.alibaba.com,google.com,huaweicloud.com,gmail.com,redhat.com,cmpxchg.org,lge.com,linux.dev,bytedance.com,vger.kernel.org,arm.com,suse.com];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryncsn@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[]

On Tue, Apr 21, 2026 at 2:17=E2=80=AFPM Kairui Song via B4 Relay
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

I checked sashiko's review, it seems sashiko itself is bugged or
something wrong, Most patched end up with:
Tool error: Review tool timed out (active time exceeded)

The rest of the results are all false positives, maybe I can add a few
more comments in the code or commit so it can understand the code
better.

And checking V2's review:
https://sashiko.dev/#/patchset/20260417-swap-table-p4-v2-0-17f5d1015428%40t=
encent.com

Which are mostly false positives and I've fixed the two real but
trivial issues already. Things should be fine.

