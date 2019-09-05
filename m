Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98B20AA8F9
	for <lists+cgroups@lfdr.de>; Thu,  5 Sep 2019 18:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbfIEQ2e (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Sep 2019 12:28:34 -0400
Received: from mail-qk1-f180.google.com ([209.85.222.180]:39804 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730777AbfIEQ2e (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Sep 2019 12:28:34 -0400
Received: by mail-qk1-f180.google.com with SMTP id 4so2701217qki.6
        for <cgroups@vger.kernel.org>; Thu, 05 Sep 2019 09:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2NaxZNu1YxZErYavkR2giBnU9Li+XumZs4iFsZmWsEQ=;
        b=EO/FLgEwd+YjJuvnHHdOgGfYyqfIay9CZClyHkLaXBQD8MCsNNO8lYxGy1sOSSWImo
         T0Mkvez/+eQ/1fvtJh9Qhw46dBLCKOaqYbrd1M9AUuzVAZjUyUWxGpGM2C79gzSixKZQ
         EIAMV9JeczJlIzVKXt7oqrwuJahYpCQeh3QF6+AFpMTkJ3kWDexNd4kjfnUVDhs5YOn/
         5s/1TyV78kxs5GFcfBQL0MxvWdL4sMTSM3OJESW28jFq9K4io08b1DUkeDZDj+vid3iC
         t0/cL6Z6ud+iOLUnA3mUh3/Z72P+9f36H59K99CMdmpN/UUyu2zTl9n6UH3LY6T06F45
         TiAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2NaxZNu1YxZErYavkR2giBnU9Li+XumZs4iFsZmWsEQ=;
        b=LYvVesmjab8Y/gNzi+590FRwOSbeVyum+TIXzDjxNyZGxL+yd1leq759AneXxztsLx
         XkftB6RvDVu127jnz2HZpJMa2Hp7YHHYpcP+aehUyIfNHxAWysjGJrrXv61LFqJPBLPm
         hPmLX1QlV4o0Og4kBF1pzks4UBh4MhZrpgwXzWwC0OLbQnKnl6rKH2z5nPKCmaBAbhLh
         4ZYhKzBnQxF7uInAJekGg4V0tV0JxqA2adGlmNSM8KKnIGBDfBLuA6lyCPTPxZxw/abT
         /vZPuJwteEiIqOnIf2nHF5MXBud0jBu4nT2a1Kie+Bx/PZqQ9PBqZMO52im/NDVutYXM
         j2Ew==
X-Gm-Message-State: APjAAAUjruTV4Vs8AN8AUCJmuzYZTduoiSz80ae1WsJEw6qpUWN57ULO
        RkjRdQPQJq+6jy9rSFtVX57u2qcueQtne/gwm6U=
X-Google-Smtp-Source: APXvYqyo1VOxIxK6HxYsxGZp+pyxqP8Go/6Jf7kmQIGYy/HaPncsAVnM1pS2/srcjMsYczu/iyMrm5UfvkKBQZavI2Q=
X-Received: by 2002:a37:8c84:: with SMTP id o126mr3782836qkd.467.1567700913416;
 Thu, 05 Sep 2019 09:28:33 -0700 (PDT)
MIME-Version: 1.0
References: <4b4ba042-3741-7b16-2292-198c569da2aa@profihost.ag>
 <20190905114022.GH3838@dhcp22.suse.cz> <7a3d23f2-b5fe-b4c0-41cd-e79070637bd9@profihost.ag>
In-Reply-To: <7a3d23f2-b5fe-b4c0-41cd-e79070637bd9@profihost.ag>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 5 Sep 2019 09:28:21 -0700
Message-ID: <CAHbLzkqb1W+8Bzc1L6+5vuaREZ6e2SWZpzM59PNYm6qRQPmm2Q@mail.gmail.com>
Subject: Re: lot of MemAvailable but falling cache and raising PSI
To:     Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc:     Michal Hocko <mhocko@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>, l.roehrs@profihost.ag,
        cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Sep 5, 2019 at 4:56 AM Stefan Priebe - Profihost AG
<s.priebe@profihost.ag> wrote:
>
>
> Am 05.09.19 um 13:40 schrieb Michal Hocko:
> > On Thu 05-09-19 13:27:10, Stefan Priebe - Profihost AG wrote:
> >> Hello all,
> >>
> >> i hope you can help me again to understand the current MemAvailable
> >> value in the linux kernel. I'm running a 4.19.52 kernel + psi patches in
> >> this case.
> >>
> >> I'm seeing the following behaviour i don't understand and ask for help.
> >>
> >> While MemAvailable shows 5G the kernel starts to drop cache from 4G down
> >> to 1G while the apache spawns some PHP processes. After that the PSI
> >> mem.some value rises and the kernel tries to reclaim memory but
> >> MemAvailable stays at 5G.
> >>
> >> Any ideas?
> >
> > Can you collect /proc/vmstat (every second or so) and post it while this
> > is the case please?
>
> Yes sure.
>
> But i don't know which event you mean exactly. Current situation is PSI
> / memory pressure is > 20 but:
>
> This is the current status where MemAvailable show 5G but Cached is
> already dropped to 1G coming from 4G:

I don't get what problem you are running into. MemAvailable is *not*
the indication for triggering memory reclaim.

Basically MemAvailable = MemFree + page cache (active file + inactive
file) / 2 + SReclaimable / 2, which means that much memory could be
reclaimed if memory pressure is hit.

But, memory pressure (tracked by PSI) is triggered by how much memory
(aka watermark) is consumed.

So, it looks page reclaim logic just reclaimed file cache (it looks
sane since your VM doesn't have swap partition), so I'm supposed you
would see MemFree increased along with dropping "Cached", but
MemAvailable basically is not changed. It looks sane to me. Am I
missing something else?

>
>
> meminfo:
> MemTotal:       16423116 kB
> MemFree:         5280736 kB
> MemAvailable:    5332752 kB
> Buffers:            2572 kB
> Cached:          1225112 kB
> SwapCached:            0 kB
> Active:          8934976 kB
> Inactive:        1026900 kB
> Active(anon):    8740396 kB
> Inactive(anon):   873448 kB
> Active(file):     194580 kB
> Inactive(file):   153452 kB
> Unevictable:       19900 kB
> Mlocked:           19900 kB
> SwapTotal:             0 kB
> SwapFree:              0 kB
> Dirty:              1980 kB
> Writeback:             0 kB
> AnonPages:       8423480 kB
> Mapped:           978212 kB
> Shmem:            875680 kB
> Slab:             839868 kB
> SReclaimable:     383396 kB
> SUnreclaim:       456472 kB
> KernelStack:       22576 kB
> PageTables:        49824 kB
> NFS_Unstable:          0 kB
> Bounce:                0 kB
> WritebackTmp:          0 kB
> CommitLimit:     8211556 kB
> Committed_AS:   32060624 kB
> VmallocTotal:   34359738367 kB
> VmallocUsed:           0 kB
> VmallocChunk:          0 kB
> Percpu:           118048 kB
> HardwareCorrupted:     0 kB
> AnonHugePages:   6406144 kB
> ShmemHugePages:        0 kB
> ShmemPmdMapped:        0 kB
> HugePages_Total:       0
> HugePages_Free:        0
> HugePages_Rsvd:        0
> HugePages_Surp:        0
> Hugepagesize:       2048 kB
> Hugetlb:               0 kB
> DirectMap4k:     2580336 kB
> DirectMap2M:    14196736 kB
> DirectMap1G:     2097152 kB
>
>
> vmstat shows:
> nr_free_pages 1320053
> nr_zone_inactive_anon 218362
> nr_zone_active_anon 2185108
> nr_zone_inactive_file 38363
> nr_zone_active_file 48645
> nr_zone_unevictable 4975
> nr_zone_write_pending 495
> nr_mlock 4975
> nr_page_table_pages 12553
> nr_kernel_stack 22576
> nr_bounce 0
> nr_zspages 0
> nr_free_cma 0
> numa_hit 13916119899
> numa_miss 0
> numa_foreign 0
> numa_interleave 15629
> numa_local 13916119899
> numa_other 0
> nr_inactive_anon 218362
> nr_active_anon 2185164
> nr_inactive_file 38363
> nr_active_file 48645
> nr_unevictable 4975
> nr_slab_reclaimable 95849
> nr_slab_unreclaimable 114118
> nr_isolated_anon 0
> nr_isolated_file 0
> workingset_refault 71365357
> workingset_activate 20281670
> workingset_restore 8995665
> workingset_nodereclaim 326085
> nr_anon_pages 2105903
> nr_mapped 244553
> nr_file_pages 306921
> nr_dirty 495
> nr_writeback 0
> nr_writeback_temp 0
> nr_shmem 218920
> nr_shmem_hugepages 0
> nr_shmem_pmdmapped 0
> nr_anon_transparent_hugepages 3128
> nr_unstable 0
> nr_vmscan_write 0
> nr_vmscan_immediate_reclaim 1833104
> nr_dirtied 386544087
> nr_written 259220036
> nr_dirty_threshold 265636
> nr_dirty_background_threshold 132656
> pgpgin 1817628997
> pgpgout 3730818029
> pswpin 0
> pswpout 0
> pgalloc_dma 0
> pgalloc_dma32 5790777997
> pgalloc_normal 20003662520
> pgalloc_movable 0
> allocstall_dma 0
> allocstall_dma32 0
> allocstall_normal 39
> allocstall_movable 1980089
> pgskip_dma 0
> pgskip_dma32 0
> pgskip_normal 0
> pgskip_movable 0
> pgfree 26637215947
> pgactivate 316722654
> pgdeactivate 261039211
> pglazyfree 0
> pgfault 17719356599
> pgmajfault 30985544
> pglazyfreed 0
> pgrefill 286826568
> pgsteal_kswapd 36740923
> pgsteal_direct 349291470
> pgscan_kswapd 36878966
> pgscan_direct 395327492
> pgscan_direct_throttle 0
> zone_reclaim_failed 0
> pginodesteal 49817087
> slabs_scanned 597956834
> kswapd_inodesteal 1412447
> kswapd_low_wmark_hit_quickly 39
> kswapd_high_wmark_hit_quickly 319
> pageoutrun 3585
> pgrotated 2873743
> drop_pagecache 0
> drop_slab 0
> oom_kill 0
> pgmigrate_success 839062285
> pgmigrate_fail 507313
> compact_migrate_scanned 9619077010
> compact_free_scanned 67985619651
> compact_isolated 1684537704
> compact_stall 205761
> compact_fail 182420
> compact_success 23341
> compact_daemon_wake 2
> compact_daemon_migrate_scanned 811
> compact_daemon_free_scanned 490241
> htlb_buddy_alloc_success 0
> htlb_buddy_alloc_fail 0
> unevictable_pgs_culled 1006521
> unevictable_pgs_scanned 0
> unevictable_pgs_rescued 997077
> unevictable_pgs_mlocked 1319203
> unevictable_pgs_munlocked 842471
> unevictable_pgs_cleared 470531
> unevictable_pgs_stranded 459613
> thp_fault_alloc 20263113
> thp_fault_fallback 3368635
> thp_collapse_alloc 226476
> thp_collapse_alloc_failed 17594
> thp_file_alloc 0
> thp_file_mapped 0
> thp_split_page 1159
> thp_split_page_failed 3927
> thp_deferred_split_page 20348941
> thp_split_pmd 53361
> thp_split_pud 0
> thp_zero_page_alloc 1
> thp_zero_page_alloc_failed 0
> thp_swpout 0
> thp_swpout_fallback 0
> balloon_inflate 0
> balloon_deflate 0
> balloon_migrate 0
> swap_ra 0
> swap_ra_hit 0
>
> Greets,
> Stefan
>
>
