Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF75F1DE4FD
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2020 13:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbgEVLCA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 May 2020 07:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729114AbgEVLB6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 May 2020 07:01:58 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B43BC061A0E
        for <cgroups@vger.kernel.org>; Fri, 22 May 2020 04:01:55 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id z6so12061618ljm.13
        for <cgroups@vger.kernel.org>; Fri, 22 May 2020 04:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=czSDy5J/yzm8/rG3aCZlotgPLDjzh1xINUDyazRicRc=;
        b=lsRqxTEuzJSaxucY8HsbgWPlIyvr23wVrFXR+UMfh1TV7j/nSCxK7y4CaFdknXCcqy
         tET+ELtbE3bd/GiRSX6LLRgRLP1tqk08mjV/Jyv1dlugYdCKm1Gje0oZfkUlXP0NXbNL
         mpD26HqNlqcQ+rDHbFzXiFTcoiMJueAE5R+D2bHDvTCe8LZ67pn4iDHGbpelHh3AtHWx
         aNADEjtwHpnUalAG8+G8x9YeQxjUmyRjYV+bOBzy7yiRO8yX0+nS+34RpxIeDUiZJEMH
         wcChIIYueLRcSODk5C199nuf9xtWDa1fcKU9RI6wXOtLDldwiU/1C6lGBPXdOVZGRoJY
         OBbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=czSDy5J/yzm8/rG3aCZlotgPLDjzh1xINUDyazRicRc=;
        b=unTtadAneM47SlaacpTPLH/JVKe6wXhh3zAnrHACMrvvJ05ABuw8CbSYztvo9zSmAN
         aC1tWB/SNXr5DZSXzRu9S5D4QYEucLK8JfD6XAi5sOqJnUF1KGH7W4LGKZ7QUYNG2Bu7
         A0utBfQfWMy7T1py2XHpQ5oUFDgXFX3E+gPrUmI4QMfrQZcyY8JWLMahdV19YlNZGjRX
         bG5Yb+DUpRP/zPprgOgovUcK9i1Hx6ZUdA9ssN1nc/iitktV6hVFTh22/Gfm2iK0kKoE
         ETgRlMOINhQ9P9Auwp0vOx7qohSiild8IRC1TK1WJ4+tcwkgZ5W2x+sBsGtPC72vgY6V
         FX5g==
X-Gm-Message-State: AOAM533/vawjo0AMLN7h0/6E70lz3CTd2NHXaqTbDj4qArbDDE7GAfnr
        ++t6OSN/28005CieCYDhAjLSngN2UtJYpQGWB4jxkA==
X-Google-Smtp-Source: ABdhPJyFd7ciVWyjkY3U85WLgxSWal88eNf4wwGCFIzq/mnHIuRzc1Zqf9I8CkyEU7ql7mDFCDOlK7yLAU5CIyrgSj8=
X-Received: by 2002:a2e:574e:: with SMTP id r14mr5406251ljd.411.1590145313074;
 Fri, 22 May 2020 04:01:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200505084127.12923-1-laoar.shao@gmail.com> <20200505084127.12923-3-laoar.shao@gmail.com>
In-Reply-To: <20200505084127.12923-3-laoar.shao@gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 22 May 2020 16:31:40 +0530
Message-ID: <CA+G9fYseWc_7yq0M5Onju_HxbFid6DbuuaEFf-KUpqfxdF-QTg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mm, memcg: Decouple e{low,min} state mutations
 from protection checks
To:     Yafang Shao <laoar.shao@gmail.com>,
        Chris Down <chris@chrisdown.name>,
        Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, linux-mm <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 5 May 2020 at 14:12, Yafang Shao <laoar.shao@gmail.com> wrote:
>
> From: Chris Down <chris@chrisdown.name>
>
> mem_cgroup_protected currently is both used to set effective low and min
> and return a mem_cgroup_protection based on the result.  As a user, this
> can be a little unexpected: it appears to be a simple predicate function,
> if not for the big warning in the comment above about the order in which
> it must be executed.
>
> This change makes it so that we separate the state mutations from the
> actual protection checks, which makes it more obvious where we need to be
> careful mutating internal state, and where we are simply checking and
> don't need to worry about that.

This patch is causing oom-killer while running mkfs -t ext4 on i386 kernel
running on x86_64 machine version linux-next 5.7.0-rc6-next-20200521.

+ mkfs -t ext4 /dev/disk/by-id/ata-TOSHIBA_MG04ACA100N_Y8RQK14KF6XF
mke2fs 1.43.8 (1-Jan-2018)
Creating filesystem with 244190646 4k blocks and 61054976 inodes
Filesystem UUID: 5309a579-5f29-4e9e-959d-0cb1da3490a8
Superblock backups stored on blocks:
32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208,
4096000, 7962624, 11239424, 20480000, 23887872, 71663616, 78675968,
102400000, 214990848
Allocating group tables:    0/7453                           done
Writing inode tables:    0/7453                           done
Creating journal (262144 blocks): [   35.419377] mkfs.ext4 invoked
oom-killer: gfp_mask=0x101cc0(GFP_USER|__GFP_WRITE), order=0,
oom_score_adj=0
[   35.429138] CPU: 2 PID: 391 Comm: mkfs.ext4 Not tainted
5.7.0-rc6-next-20200521 #1
[   35.436707] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.2 05/23/2018
[   35.444099] Call Trace:
[   35.446558]  dump_stack+0x54/0x6e
[   35.449874]  dump_header+0x3d/0x1d2
[   35.453364]  ? oom_badness.part.0+0x11/0x120
[   35.457635]  ? ___ratelimit+0x8f/0xdc
[   35.461301]  oom_kill_process.cold+0x9/0xe
[   35.465390]  out_of_memory+0x1b1/0x260
[   35.469135]  __alloc_pages_nodemask+0xe1d/0xed0
[   35.473658]  ? alloc_page_buffers+0x81/0x130
[   35.477923]  pagecache_get_page+0xae/0x260
[   35.482014]  grab_cache_page_write_begin+0x1c/0x30
[   35.486798]  block_write_begin+0x1e/0x90
[   35.490716]  blkdev_write_begin+0x1e/0x20
[   35.494719]  ? bdev_evict_inode+0xd0/0xd0
[   35.498722]  generic_perform_write+0x97/0x180
[   35.503073]  __generic_file_write_iter+0x140/0x1f0
[   35.507857]  blkdev_write_iter+0xc0/0x190
[   35.511860]  __vfs_write+0x132/0x1e0
[   35.515431]  vfs_write+0xa1/0x1a0
[   35.518742]  ksys_pwrite64+0x50/0x80
[   35.522315]  __ia32_sys_ia32_pwrite64+0x16/0x20
[   35.526845]  do_syscall_32_irqs_on+0x3d/0x250
[   35.531195]  ? do_user_addr_fault+0x1a0/0x3c0
[   35.535548]  ? __prepare_exit_to_usermode+0x50/0x1a0
[   35.540504]  do_fast_syscall_32+0x39/0xb0
[   35.544508]  entry_SYSENTER_32+0xa5/0xf8
[   35.548426] EIP: 0xb7efb549
[   35.551218] Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01
10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f
34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90
8d 76
[   35.569962] EAX: ffffffda EBX: 00000003 ECX: b77ef010 EDX: 00400000
[   35.576217] ESI: 38400000 EDI: 00000074 EBP: 07438400 ESP: bfdff180
[   35.582476] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000246
[   35.589260] Mem-Info:
[   35.591552] active_anon:5403 inactive_anon:2167 isolated_anon:0
[   35.591552]  active_file:4174 inactive_file:212518 isolated_file:0
[   35.591552]  unevictable:0 dirty:16699 writeback:6001 unstable:0
[   35.591552]  slab_reclaimable:5868 slab_unreclaimable:3494
[   35.591552]  mapped:6285 shmem:2236 pagetables:176 bounce:0
[   35.591552]  free:264050 free_pcp:1186 free_cma:0
[   35.625311] Node 0 active_anon:21612kB inactive_anon:8668kB
active_file:16696kB inactive_file:850072kB unevictable:0kB
isolated(anon):0kB isolated(file):0kB mapped:25140kB dirty:62704kB
writeback:22764kB shmem:8944kB writeback_tmp:0kB unstable:0kB
all_unreclaimable? yes
[   35.649169] DMA free:3360kB min:68kB low:84kB high:100kB
reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB
active_file:0kB inactive_file:12012kB unevictable:0kB
writepending:12012kB present:15964kB managed:15876kB mlocked:0kB
kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB
free_cma:0kB
[   35.677015] lowmem_reserve[]: 0 824 1947 824
[   35.681286] Normal free:4300kB min:7732kB low:8640kB high:9548kB
reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB
active_file:1132kB inactive_file:786452kB unevictable:0kB
writepending:64032kB present:884728kB managed:845292kB mlocked:0kB
kernel_stack:1112kB pagetables:0kB bounce:0kB free_pcp:2392kB
local_pcp:456kB free_cma:0kB
[   35.711109] lowmem_reserve[]: 0 0 8980 0
[   35.715051] HighMem free:1048740kB min:512kB low:1748kB high:2984kB
reserved_highatomic:0KB active_anon:21612kB inactive_anon:8668kB
active_file:15564kB inactive_file:51556kB unevictable:0kB
writepending:0kB present:1149540kB managed:1149540kB mlocked:0kB
kernel_stack:0kB pagetables:704kB bounce:0kB free_pcp:2216kB
local_pcp:200kB free_cma:0kB
[   35.745418] lowmem_reserve[]: 0 0 0 0
[   35.749117] DMA: 7*4kB (UE) 1*8kB (U) 2*16kB (UE) 1*32kB (E) 1*64kB
(E) 1*128kB (E) 0*256kB 0*512kB 1*1024kB (E) 1*2048kB (E) 0*4096kB =
3364kB
[   35.762006] Normal: 19*4kB (U) 18*8kB (UE) 18*16kB (UE) 12*32kB
(UE) 6*64kB (U) 2*128kB (U) 2*256kB (UE) 1*512kB (E) 0*1024kB 1*2048kB
(U) 0*4096kB = 4604kB
[   35.776020] HighMem: 1*4kB (U) 0*8kB 0*16kB 1*32kB (M) 0*64kB
1*128kB (M) 0*256kB 0*512kB 0*1024kB 0*2048kB 256*4096kB (M) =
1048740kB
[   35.788093] Node 0 hugepages_total=0 hugepages_free=0
hugepages_surp=0 hugepages_size=4096kB
[   35.796533] 218903 total pagecache pages
[   35.800503] 0 pages in swap cache
[   35.803873] Swap cache stats: add 0, delete 0, find 0/0
[   35.809145] Free swap  = 0kB
[   35.812083] Total swap = 0kB
[   35.815021] 512558 pages RAM
[   35.817957] 287385 pages HighMem/MovableOnly
[   35.822221] 9881 pages reserved
[   35.825368] Tasks state (memory values in pages):
[   35.830124] [  pid  ]   uid  tgid total_vm      rss pgtables_bytes
swapents oom_score_adj name
[   35.838791] [    225]     0   225     3425     1294    24576
0             0 systemd-journal
[   35.847868] [    240]     0   240     3326      868    20480
0         -1000 systemd-udevd
[   35.856785] [    243]   994   243     3929      450    24576
0             0 systemd-timesyn
[   35.865874] [    260]   993   260     1569      786    20480
0             0 systemd-network
[   35.874966] [    278]   992   278     1729      843    20480
0             0 systemd-resolve
[   35.884007] [    282]     0   282      809      428    16384
0             0 crond
[   35.892229] [    283]     0   283     2032     1104    20480
0             0 haveged
[   35.900635] [    284]     0   284      922      194    16384
0             0 klogd
[   35.908820] [    285]     0   285     5638     1481    32768
0             0 thermald
[   35.917304] [    286]   995   286     1182      664    20480
0             0 avahi-daemon
[   35.926133] [    287]   996   287     1174      835    24576
0          -900 dbus-daemon
[   35.934880] [    288]   995   288     1182       58    20480
0             0 avahi-daemon
[   35.943710] [    289]     0   289      921      409    16384
0             0 syslogd
[   35.952108] [    290]     0   290     1468      998    20480
0             0 systemd-logind
[   35.961060] [    303]     0   303      594       15    16384
0             0 acpid
[   35.969275] [    304]     0   304    11786     2635    45056
0             0 NetworkManager
[   35.978282] [    305]     0   305      677      429    16384
0             0 atd
[   35.986280] [    323]     0   323     1347      321    20480
0             0 systemd-hostnam
[   35.995318] [    334] 65534   334      729       32    16384
0             0 dnsmasq
[   36.003708] [    335]     0   335      666      443    16384
0             0 agetty
[   36.012019] [    336]     0   336      947      710    20480
0             0 login
[   36.020246] [    337]     0   337      666      419    16384
0             0 agetty
[   36.028555] [    348]   998   348    19521     2782    65536
0             0 polkitd
[   36.036901] [    356]     0   356     1892     1183    20480
0             0 systemd
[   36.045300] [    357]     0   357     2320      316    20480
0             0 (sd-pam)
[   36.053731] [    361]     0   361      971      721    16384
0             0 sh
[   36.061698] [    365]     0   365      920      610    16384
0             0 su
[   36.069682] [    366]     0   366      971      689    16384
0             0 sh
[   36.077664] [    371]     0   371      903      580    16384
0             0 lava-test-runne
[   36.086761] [    381]     0   381      903      520    16384
0             0 lava-test-shell
[   36.095852] [    382]     0   382      903      581    16384
0             0 sh
[   36.103816] [    391]     0   391     1976     1688    24576
0             0 mkfs.ext4
[   36.112336] oom-kill:constraint=CONSTRAINT_NONE,nodemask=(null),cpuset=/,mems_allowed=0,global_oom,task_memcg=/,task=polkitd,pid=348,uid=998
[   36.125003] Out of memory: Killed process 348 (polkitd)
total-vm:78084kB, anon-rss:2980kB, file-rss:8148kB, shmem-rss:0kB,
UID:998 pgtables:64kB oom_score_adj:0
[   36.139810] oom_reaper: reaped process 348 (polkitd), now
anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
[   36.148879] mkfs.ext4 invoked oom-killer:
gfp_mask=0x101cc0(GFP_USER|__GFP_WRITE), order=0, oom_score_adj=0
[   36.158626] CPU: 1 PID: 391 Comm: mkfs.ext4 Not tainted
5.7.0-rc6-next-20200521 #1
[   36.166220] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.2 05/23/2018
[   36.173604] Call Trace:
[   36.176050]  dump_stack+0x54/0x6e
[   36.179360]  dump_header+0x3d/0x1d2
[   36.182844]  ? oom_badness.part.0+0x11/0x120
[   36.187110]  ? ___ratelimit+0x8f/0xdc
[   36.190773]  oom_kill_process.cold+0x9/0xe
[   36.194863]  out_of_memory+0x1b1/0x260
[   36.198610]  __alloc_pages_nodemask+0xe1d/0xed0
[   36.203141]  ? alloc_page_buffers+0x81/0x130
[   36.207406]  pagecache_get_page+0xae/0x260
[   36.211496]  grab_cache_page_write_begin+0x1c/0x30
[   36.216281]  block_write_begin+0x1e/0x90
[   36.220197]  blkdev_write_begin+0x1e/0x20
[   36.224201]  ? bdev_evict_inode+0xd0/0xd0
[   36.228205]  generic_perform_write+0x97/0x180
[   36.232557]  __generic_file_write_iter+0x140/0x1f0
[   36.237340]  blkdev_write_iter+0xc0/0x190
[   36.241344]  __vfs_write+0x132/0x1e0
[   36.244915]  vfs_write+0xa1/0x1a0
[   36.248225]  ksys_pwrite64+0x50/0x80
[   36.251797]  __ia32_sys_ia32_pwrite64+0x16/0x20
[   36.256319]  do_syscall_32_irqs_on+0x3d/0x250
[   36.260693]  ? do_user_addr_fault+0x1a0/0x3c0
[   36.265045]  ? __prepare_exit_to_usermode+0x50/0x1a0
[   36.270004]  do_fast_syscall_32+0x39/0xb0
[   36.274006]  entry_SYSENTER_32+0xa5/0xf8
[   36.277926] EIP: 0xb7efb549
[   36.280728] Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01
10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f
34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90
8d 76
[   36.299471] EAX: ffffffda EBX: 00000003 ECX: b77ef010 EDX: 00400000
[   36.305728] ESI: 38400000 EDI: 00000074 EBP: 07438400 ESP: bfdff180
[   36.311986] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000246
[   36.318783] Mem-Info:
[   36.321070] active_anon:4659 inactive_anon:2167 isolated_anon:0
[   36.321070]  active_file:4639 inactive_file:212058 isolated_file:0
[   36.321070]  unevictable:0 dirty:14286 writeback:23 unstable:0
[   36.321070]  slab_reclaimable:5883 slab_unreclaimable:3313
[   36.321070]  mapped:5709 shmem:2236 pagetables:176 bounce:0
[   36.321070]  free:264784 free_pcp:1341 free_cma:0
[   36.354669] Node 0 active_anon:18636kB inactive_anon:8668kB
active_file:18556kB inactive_file:848232kB unevictable:0kB
isolated(anon):0kB isolated(file):0kB mapped:22836kB dirty:57144kB
writeback:92kB shmem:8944kB writeback_tmp:0kB unstable:0kB
all_unreclaimable? yes
[   36.378296] DMA free:3364kB min:68kB low:84kB high:100kB
reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB
active_file:0kB inactive_file:12124kB unevictable:0kB
writepending:12132kB present:15964kB managed:15876kB mlocked:0kB
kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB
free_cma:0kB
[   36.406167] lowmem_reserve[]: 0 824 1947 824
[   36.410467] Normal free:4552kB min:7732kB low:8640kB high:9548kB
reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB
active_file:1132kB inactive_file:786524kB unevictable:0kB
writepending:45100kB present:884728kB managed:845292kB mlocked:0kB
kernel_stack:1112kB pagetables:0kB bounce:0kB free_pcp:2548kB
local_pcp:1432kB free_cma:0kB
[   36.440330] lowmem_reserve[]: 0 0 8980 0
[   36.444274] HighMem free:1051220kB min:512kB low:1748kB high:2984kB
reserved_highatomic:0KB active_anon:18636kB inactive_anon:8668kB
active_file:17424kB inactive_file:49696kB unevictable:0kB
writepending:0kB present:1149540kB managed:1149540kB mlocked:0kB
kernel_stack:0kB pagetables:704kB bounce:0kB free_pcp:2812kB
local_pcp:516kB free_cma:0kB
[   36.474680] lowmem_reserve[]: 0 0 0 0
[   36.478401] DMA: 3*4kB (U) 1*8kB (U) 1*16kB (U) 0*32kB 2*64kB (UE)
1*128kB (E) 0*256kB 0*512kB 1*1024kB (E) 1*2048kB (E) 0*4096kB =
3364kB
[   36.490847] Normal: 19*4kB (U) 22*8kB (UE) 19*16kB (UE) 13*32kB
(UE) 6*64kB (U) 2*128kB (U) 2*256kB (UE) 1*512kB (E) 0*1024kB 1*2048kB
(U) 0*4096kB = 4684kB
[   36.504851] HighMem: 119*4kB (UM) 48*8kB (M) 12*16kB (UM) 11*32kB
(M) 8*64kB (UM) 6*128kB (M) 0*256kB 0*512kB 0*1024kB 0*2048kB
256*4096kB (M) = 1051260kB
[   36.518695] Node 0 hugepages_total=0 hugepages_free=0
hugepages_surp=0 hugepages_size=4096kB
[   36.527151] 218965 total pagecache pages
[   36.531095] 0 pages in swap cache
[   36.534430] Swap cache stats: add 0, delete 0, find 0/0
[   36.539697] Free swap  = 0kB
[   36.542602] Total swap = 0kB
[   36.545531] 512558 pages RAM
[   36.548436] 287385 pages HighMem/MovableOnly
[   36.552729] 9881 pages reserved
[   36.555897] Tasks state (memory values in pages):
[   36.560621] [  pid  ]   uid  tgid total_vm      rss pgtables_bytes
swapents oom_score_adj name
[   36.569230] [    225]     0   225     3425     1294    28672
0             0 systemd-journal
[   36.578295] [    240]     0   240     3326      868    20480
0         -1000 systemd-udevd
[   36.587186] [    243]   994   243     3929      450    24576
0             0 systemd-timesyn
[   36.596249] [    260]   993   260     1569      786    20480
0             0 systemd-network
[   36.605307] [    278]   992   278     1729      843    20480
0             0 systemd-resolve
[   36.614363] [    282]     0   282      809      428    16384
0             0 crond
[   36.622551] [    283]     0   283     2032     1104    20480
0             0 haveged
[   36.630918] [    284]     0   284      922      194    16384
0             0 klogd
[   36.639114] [    285]     0   285     5638     1481    32768
0             0 thermald
[   36.647563] [    286]   995   286     1182      664    20480
0             0 avahi-daemon
[   36.656362] [    287]   996   287     1174      835    24576
0          -900 dbus-daemon
[   36.665081] [    288]   995   288     1182       58    20480
0             0 avahi-daemon
[   36.673884] [    289]     0   289      921      409    16384
0             0 syslogd
[   36.682249] [    290]     0   290     1468      998    20480
0             0 systemd-logind
[   36.691228] [    303]     0   303      594       15    16384
0             0 acpid
[   36.699425] [    304]     0   304    11786     2635    45056
0             0 NetworkManager
[   36.708395] [    305]     0   305      677      429    16384
0             0 atd
[   36.716394] [    323]     0   323     1347      321    20480
0             0 systemd-hostnam
[   36.725435] [    334] 65534   334      729       32    16384
0             0 dnsmasq
[   36.733781] [    335]     0   335      666      443    16384
0             0 agetty
[   36.742041] [    336]     0   336      947      710    20480
0             0 login
[   36.750237] [    337]     0   337      666      419    16384
0             0 agetty
[   36.758514] [    356]     0   356     1892     1183    20480
0             0 systemd
[   36.766877] [    357]     0   357     2320      316    20480
0             0 (sd-pam)
[   36.775326] [    361]     0   361      971      721    16384
0             0 sh
[   36.783257] [    365]     0   365      920      610    16384
0             0 su
[   36.791170] [    366]     0   366      971      689    16384
0             0 sh
[   36.799082] [    371]     0   371      903      580    16384
0             0 lava-test-runne
[   36.808122] [    381]     0   381      903      520    16384
0             0 lava-test-shell
[   36.817161] [    382]     0   382      903      581    16384
0             0 sh
[   36.825073] [    391]     0   391     1976     1688    24576
0             0 mkfs.ext4
[   36.833591] oom-kill:constraint=CONSTRAINT_NONE,nodemask=(null),cpuset=/,mems_allowed=0,global_oom,task_memcg=/,task=NetworkManager,pid=304,uid=0
[   36.846621] Out of memory: Killed process 304 (NetworkManager)
total-vm:47144kB, anon-rss:1396kB, file-rss:9144kB, shmem-rss:0kB,
UID:0 pgtables:44kB oom_score_adj:0
[   36.861729] oom_reaper: reaped process 304 (NetworkManager), now
anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
[   36.861738] klogd invoked oom-killer:
gfp_mask=0xc2cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_COMP|__GFP_NOMEMALLOC),
order=0, oom_score_adj=0
[   36.883368] CPU: 2 PID: 284 Comm: klogd Not tainted
5.7.0-rc6-next-20200521 #1
[   36.890607] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.2 05/23/2018
[   36.897992] Call Trace:
[   36.900438]  dump_stack+0x54/0x6e
[   36.903763]  dump_header+0x3d/0x1d2
[   36.907247]  ? oom_badness.part.0+0x11/0x120
[   36.911510]  ? ___ratelimit+0x8f/0xdc
[   36.915167]  oom_kill_process.cold+0x9/0xe
[   36.919258]  out_of_memory+0x1b1/0x260
[   36.923005]  __alloc_pages_nodemask+0xe1d/0xed0
[   36.927537]  alloc_slab_page+0x13d/0x2c0
[   36.931453]  new_slab+0x22e/0x280
[   36.934766]  ? cpumask_next_and+0x18/0x20
[   36.938777]  ___slab_alloc.constprop.0+0x248/0x4a0
[   36.943563]  ? __alloc_skb+0x64/0x1a0
[   36.947228]  ? __alloc_skb+0x41/0x1a0
[   36.950885]  __slab_alloc.constprop.0+0xf/0x20
[   36.955321]  ? __slab_alloc.constprop.0+0xf/0x20
[   36.959932]  __kmalloc_track_caller+0x23e/0x270
[   36.964456]  ? __alloc_skb+0x64/0x1a0
[   36.968114]  ? _cond_resched+0x12/0x30
[   36.971857]  __kmalloc_reserve.isra.0+0x1d/0x70
[   36.976380]  __alloc_skb+0x64/0x1a0
[   36.979866]  ? update_rq_clock.part.0+0x16/0xe0
[   36.984389]  alloc_skb_with_frags+0x3b/0x1a0
[   36.988665]  sock_alloc_send_pskb+0x1c7/0x1f0
[   36.993040]  ? selinux_inet_conn_established+0x40/0x40
[   36.998179]  unix_dgram_sendmsg+0x12a/0x690
[   37.002365]  ? selinux_socket_recvmsg+0x20/0x20
[   37.006897]  ? unix_dgram_connect+0x2f0/0x2f0
[   37.011247]  sock_sendmsg+0x5c/0x60
[   37.014730]  __sys_sendto+0xe1/0x120
[   37.018301]  ? msg_print_text+0x80/0x1c0
[   37.022219]  ? do_syslog+0x19c/0x940
[   37.025788]  ? do_syslog+0x878/0x940
[   37.029358]  ? do_syslog+0x878/0x940
[   37.032931]  ? kunmap_atomic_high+0x4e/0x58
[   37.037109]  ? handle_mm_fault+0x25c/0xc60
[   37.041209]  __ia32_sys_socketcall+0x29f/0x330
[   37.045665]  do_syscall_32_irqs_on+0x3d/0x250
[   37.050038]  ? do_user_addr_fault+0x1a0/0x3c0
[   37.054388]  ? __prepare_exit_to_usermode+0x50/0x1a0
[   37.059346]  do_fast_syscall_32+0x39/0xb0
[   37.063351]  entry_SYSENTER_32+0xa5/0xf8
[   37.067276] EIP: 0xb7f66549

ref:
https://lkft.validation.linaro.org/scheduler/job/1444120#L1220

-- 
Linaro LKFT
https://lkft.linaro.org
