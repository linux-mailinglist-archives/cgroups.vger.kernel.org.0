Return-Path: <cgroups+bounces-250-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B317E5ED6
	for <lists+cgroups@lfdr.de>; Wed,  8 Nov 2023 20:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DAE6B20CA9
	for <lists+cgroups@lfdr.de>; Wed,  8 Nov 2023 19:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48B837152;
	Wed,  8 Nov 2023 19:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jScmJUFa"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F773714D
	for <cgroups@vger.kernel.org>; Wed,  8 Nov 2023 19:46:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AFC3C433AD
	for <cgroups@vger.kernel.org>; Wed,  8 Nov 2023 19:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699472793;
	bh=YINR+xn2kpfl6uzkjS9RJbv6oX776g7fQYmfKSYDiKQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jScmJUFauJ90F24mz5IExJRJYcceWrAzg85YbZCIOjA1APtE9w1T73H/BqkPeKOE8
	 JGHfhYWtf2/hFv1cVRiGRlw4ETNcDN+NOsdt6z31SdrF5hQu+UJJ1i8grwzAgcduS+
	 Cex7bisT55EAOhIggke5dNA/DQa5NgvnCd0jN4cBkiQSzEUPoeWTAMEZ9WBpNP6RLC
	 QEc6iqkNkKevLVqRwqtKoq+KBdBxOThrIQb+q8UHYHWNNrwkHsOTZABguFL1ukmSRg
	 BtGQKhWSok+zVcwfVImU+bilOTo5YxU2F1GzRUguwuNLyTdpMxrcOqF6mY6GvLKQ3l
	 XnhEo1Dc/ccfA==
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-28035cf6a30so23829a91.3
        for <cgroups@vger.kernel.org>; Wed, 08 Nov 2023 11:46:33 -0800 (PST)
X-Gm-Message-State: AOJu0YxW9+BvEFZPtfZgnZ6GBE2Se2cZzve8x4sKH7fexjRQZhYh8zea
	fhd1lE7e7hy4QhuTLkjLRXtqxZcS+VK6XzWUsX5T2w==
X-Google-Smtp-Source: AGHT+IFM+aRvsYeowp3+mfT2sb8EaWBpV+G26oNb9+NL57CiC2qZwMd08rgn/3taWt8x9hi+rhSfSDQvjz9bUAm6qjM=
X-Received: by 2002:a17:90b:38c1:b0:280:48d4:1eb3 with SMTP id
 nn1-20020a17090b38c100b0028048d41eb3mr2919828pjb.8.1699472791978; Wed, 08 Nov
 2023 11:46:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231106183159.3562879-1-nphamcs@gmail.com>
In-Reply-To: <20231106183159.3562879-1-nphamcs@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 8 Nov 2023 11:46:20 -0800
X-Gmail-Original-Message-ID: <CAF8kJuMsXUm9=kiL8qPNVfYPzfyq-JWYSH3KraZadjF+myW-2A@mail.gmail.com>
Message-ID: <CAF8kJuMsXUm9=kiL8qPNVfYPzfyq-JWYSH3KraZadjF+myW-2A@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] workload-specific and memory pressure-driven zswap writeback
To: Nhat Pham <nphamcs@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Seth Jennings <sjenning@redhat.com>, Dan Streetman <ddstreet@ieee.org>, 
	Vitaly Wool <vitaly.wool@konsulko.com>, mhocko@kernel.org, roman.gushchin@linux.dev, 
	Shakeel Butt <shakeelb@google.com>, muchun.song@linux.dev, linux-mm <linux-mm@kvack.org>, 
	kernel-team@meta.com, LKML <linux-kernel@vger.kernel.org>, 
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Nhat,

Sorry for being late to the party. I want to take a look at your patches se=
ries.
However I wasn't able to "git am" your patches series cleanly on current
mm-stable, mm-unstable or linux tip.

$ git am patches/v5_20231106_nphamcs_workload_specific_and_memory_pressure_=
driven_zswap_writeback.mbx
Applying: list_lru: allows explicit memcg and NUMA node selection
Applying: memcontrol: allows mem_cgroup_iter() to check for onlineness
Applying: zswap: make shrinking memcg-aware (fix)
error: patch failed: mm/zswap.c:174
error: mm/zswap.c: patch does not apply
Patch failed at 0003 zswap: make shrinking memcg-aware (fix)

What is the base of your patches? A git hash or a branch I can pull
from would be
nice.

Thanks

Chris

On Mon, Nov 6, 2023 at 10:32=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> Changelog:
> v5:
>    * Replace reference getting with an rcu_read_lock() section for
>      zswap lru modifications (suggested by Yosry)
>    * Add a new prep patch that allows mem_cgroup_iter() to return
>      online cgroup.
>    * Add a callback that updates pool->next_shrink when the cgroup is
>      offlined (suggested by Yosry Ahmed, Johannes Weiner)
> v4:
>    * Rename list_lru_add to list_lru_add_obj and __list_lru_add to
>      list_lru_add (patch 1) (suggested by Johannes Weiner and
>          Yosry Ahmed)
>    * Some cleanups on the memcg aware LRU patch (patch 2)
>      (suggested by Yosry Ahmed)
>    * Use event interface for the new per-cgroup writeback counters.
>      (patch 3) (suggested by Yosry Ahmed)
>    * Abstract zswap's lruvec states and handling into
>      zswap_lruvec_state (patch 5) (suggested by Yosry Ahmed)
> v3:
>    * Add a patch to export per-cgroup zswap writeback counters
>    * Add a patch to update zswap's kselftest
>    * Separate the new list_lru functions into its own prep patch
>    * Do not start from the top of the hierarchy when encounter a memcg
>      that is not online for the global limit zswap writeback (patch 2)
>      (suggested by Yosry Ahmed)
>    * Do not remove the swap entry from list_lru in
>      __read_swapcache_async() (patch 2) (suggested by Yosry Ahmed)
>    * Removed a redundant zswap pool getting (patch 2)
>      (reported by Ryan Roberts)
>    * Use atomic for the nr_zswap_protected (instead of lruvec's lock)
>      (patch 5) (suggested by Yosry Ahmed)
>    * Remove the per-cgroup zswap shrinker knob (patch 5)
>      (suggested by Yosry Ahmed)
> v2:
>    * Fix loongarch compiler errors
>    * Use pool stats instead of memcg stats when !CONFIG_MEMCG_KEM
>
> There are currently several issues with zswap writeback:
>
> 1. There is only a single global LRU for zswap, making it impossible to
>    perform worload-specific shrinking - an memcg under memory pressure
>    cannot determine which pages in the pool it owns, and often ends up
>    writing pages from other memcgs. This issue has been previously
>    observed in practice and mitigated by simply disabling
>    memcg-initiated shrinking:
>
>    https://lore.kernel.org/all/20230530232435.3097106-1-nphamcs@gmail.com=
/T/#u
>
>    But this solution leaves a lot to be desired, as we still do not
>    have an avenue for an memcg to free up its own memory locked up in
>    the zswap pool.
>
> 2. We only shrink the zswap pool when the user-defined limit is hit.
>    This means that if we set the limit too high, cold data that are
>    unlikely to be used again will reside in the pool, wasting precious
>    memory. It is hard to predict how much zswap space will be needed
>    ahead of time, as this depends on the workload (specifically, on
>    factors such as memory access patterns and compressibility of the
>    memory pages).
>
> This patch series solves these issues by separating the global zswap
> LRU into per-memcg and per-NUMA LRUs, and performs workload-specific
> (i.e memcg- and NUMA-aware) zswap writeback under memory pressure. The
> new shrinker does not have any parameter that must be tuned by the
> user, and can be opted in or out on a per-memcg basis.
>
> As a proof of concept, we ran the following synthetic benchmark:
> build the linux kernel in a memory-limited cgroup, and allocate some
> cold data in tmpfs to see if the shrinker could write them out and
> improved the overall performance. Depending on the amount of cold data
> generated, we observe from 14% to 35% reduction in kernel CPU time used
> in the kernel builds.
>
> Domenico Cerasuolo (3):
>   zswap: make shrinking memcg-aware
>   mm: memcg: add per-memcg zswap writeback stat
>   selftests: cgroup: update per-memcg zswap writeback selftest
>
> Nhat Pham (3):
>   list_lru: allows explicit memcg and NUMA node selection
>   memcontrol: allows mem_cgroup_iter() to check for onlineness
>   zswap: shrinks zswap pool based on memory pressure
>
>  Documentation/admin-guide/mm/zswap.rst      |   7 +
>  drivers/android/binder_alloc.c              |   5 +-
>  fs/dcache.c                                 |   8 +-
>  fs/gfs2/quota.c                             |   6 +-
>  fs/inode.c                                  |   4 +-
>  fs/nfs/nfs42xattr.c                         |   8 +-
>  fs/nfsd/filecache.c                         |   4 +-
>  fs/xfs/xfs_buf.c                            |   6 +-
>  fs/xfs/xfs_dquot.c                          |   2 +-
>  fs/xfs/xfs_qm.c                             |   2 +-
>  include/linux/list_lru.h                    |  46 ++-
>  include/linux/memcontrol.h                  |   9 +-
>  include/linux/mmzone.h                      |   2 +
>  include/linux/vm_event_item.h               |   1 +
>  include/linux/zswap.h                       |  27 +-
>  mm/list_lru.c                               |  48 ++-
>  mm/memcontrol.c                             |  20 +-
>  mm/mmzone.c                                 |   1 +
>  mm/shrinker.c                               |   4 +-
>  mm/swap.h                                   |   3 +-
>  mm/swap_state.c                             |  26 +-
>  mm/vmscan.c                                 |  26 +-
>  mm/vmstat.c                                 |   1 +
>  mm/workingset.c                             |   4 +-
>  mm/zswap.c                                  | 430 +++++++++++++++++---
>  tools/testing/selftests/cgroup/test_zswap.c |  74 ++--
>  26 files changed, 625 insertions(+), 149 deletions(-)
>
> --
> 2.34.1
>

