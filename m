Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC932AC523
	for <lists+cgroups@lfdr.de>; Sat,  7 Sep 2019 09:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391560AbfIGHcT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 7 Sep 2019 03:32:19 -0400
Received: from cloud1-vm154.de-nserver.de ([178.250.10.56]:49371 "EHLO
        cloud1-vm154.de-nserver.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727670AbfIGHcT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 7 Sep 2019 03:32:19 -0400
Received: (qmail 10153 invoked from network); 7 Sep 2019 09:32:15 +0200
X-Fcrdns: No
Received: from phoffice.de-nserver.de (HELO [10.242.2.4]) (185.39.223.5)
  (smtp-auth username hostmaster@profihost.com, mechanism plain)
  by cloud1-vm154.de-nserver.de (qpsmtpd/0.92) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) ESMTPSA; Sat, 07 Sep 2019 09:32:15 +0200
Subject: Re: lot of MemAvailable but falling cache and raising PSI
To:     Yang Shi <shy828301@gmail.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>, l.roehrs@profihost.ag,
        cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>
References: <4b4ba042-3741-7b16-2292-198c569da2aa@profihost.ag>
 <20190905114022.GH3838@dhcp22.suse.cz>
 <7a3d23f2-b5fe-b4c0-41cd-e79070637bd9@profihost.ag>
 <e866c481-04f2-fdb4-4d99-e7be2414591e@profihost.ag>
 <CAHbLzkrfzWS+epQif4ck9dv8f9sEQyJq7vcW55Zav7m_vYY96w@mail.gmail.com>
From:   Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Message-ID: <4cf93888-2f12-a749-cc5d-7e05782d0422@profihost.ag>
Date:   Sat, 7 Sep 2019 09:32:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAHbLzkrfzWS+epQif4ck9dv8f9sEQyJq7vcW55Zav7m_vYY96w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-User-Auth: Auth by hostmaster@profihost.com through 185.39.223.5
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


Am 06.09.19 um 20:52 schrieb Yang Shi:
> On Fri, Sep 6, 2019 at 3:08 AM Stefan Priebe - Profihost AG
> <s.priebe@profihost.ag> wrote:
>>
>> These are the biggest differences in meminfo before and after cached
>> starts to drop. I didn't expect cached end up in MemFree.
>>
>> Before:
>> MemTotal:       16423116 kB
>> MemFree:          374572 kB
> 
> Here MemFree is only ~300MB? It is quite low comparing with the amount
> of total memory. It may trigger water mark to launch kswapd.

mhm yes that might be possible but i don't see kswapd running in the
process list at least not using cpu.

Also does it really free all cache? i thought it would only free up to
vm.min_free_kbytes but this is 160MB on this machine.

>> MemAvailable:    5633816 kB
>> Cached:          5550972 kB
>> Inactive:        4696580 kB
>> Inactive(file):  3624776 kB
>>
>>
>> After:
>> MemTotal:       16423116 kB
>> MemFree:         3477168 kB
> 
> Here MemFree is ~3GB and file cache was shrunk from ~5G down to ~2G.

yes - bu i thought if file cache gets shrunk another process has
requested tis memory and would use it. So it does not end up in free.

I'm sure this all is explainable - but i really would like to know how.

Greets,
Stefan

>> MemAvailable:    6066916 kB
>> Cached:          2724504 kB
>> Inactive:        1854740 kB
>> Inactive(file):   950680 kB
>>
>> Any explanation?
>>
>> Greets,
>> Stefan
>> Am 05.09.19 um 13:56 schrieb Stefan Priebe - Profihost AG:
>>>
>>> Am 05.09.19 um 13:40 schrieb Michal Hocko:
>>>> On Thu 05-09-19 13:27:10, Stefan Priebe - Profihost AG wrote:
>>>>> Hello all,
>>>>>
>>>>> i hope you can help me again to understand the current MemAvailable
>>>>> value in the linux kernel. I'm running a 4.19.52 kernel + psi patches in
>>>>> this case.
>>>>>
>>>>> I'm seeing the following behaviour i don't understand and ask for help.
>>>>>
>>>>> While MemAvailable shows 5G the kernel starts to drop cache from 4G down
>>>>> to 1G while the apache spawns some PHP processes. After that the PSI
>>>>> mem.some value rises and the kernel tries to reclaim memory but
>>>>> MemAvailable stays at 5G.
>>>>>
>>>>> Any ideas?
>>>>
>>>> Can you collect /proc/vmstat (every second or so) and post it while this
>>>> is the case please?
>>>
>>> Yes sure.
>>>
>>> But i don't know which event you mean exactly. Current situation is PSI
>>> / memory pressure is > 20 but:
>>>
>>> This is the current status where MemAvailable show 5G but Cached is
>>> already dropped to 1G coming from 4G:
>>>
>>>
>>> meminfo:
>>> MemTotal:       16423116 kB
>>> MemFree:         5280736 kB
>>> MemAvailable:    5332752 kB
>>> Buffers:            2572 kB
>>> Cached:          1225112 kB
>>> SwapCached:            0 kB
>>> Active:          8934976 kB
>>> Inactive:        1026900 kB
>>> Active(anon):    8740396 kB
>>> Inactive(anon):   873448 kB
>>> Active(file):     194580 kB
>>> Inactive(file):   153452 kB
>>> Unevictable:       19900 kB
>>> Mlocked:           19900 kB
>>> SwapTotal:             0 kB
>>> SwapFree:              0 kB
>>> Dirty:              1980 kB
>>> Writeback:             0 kB
>>> AnonPages:       8423480 kB
>>> Mapped:           978212 kB
>>> Shmem:            875680 kB
>>> Slab:             839868 kB
>>> SReclaimable:     383396 kB
>>> SUnreclaim:       456472 kB
>>> KernelStack:       22576 kB
>>> PageTables:        49824 kB
>>> NFS_Unstable:          0 kB
>>> Bounce:                0 kB
>>> WritebackTmp:          0 kB
>>> CommitLimit:     8211556 kB
>>> Committed_AS:   32060624 kB
>>> VmallocTotal:   34359738367 kB
>>> VmallocUsed:           0 kB
>>> VmallocChunk:          0 kB
>>> Percpu:           118048 kB
>>> HardwareCorrupted:     0 kB
>>> AnonHugePages:   6406144 kB
>>> ShmemHugePages:        0 kB
>>> ShmemPmdMapped:        0 kB
>>> HugePages_Total:       0
>>> HugePages_Free:        0
>>> HugePages_Rsvd:        0
>>> HugePages_Surp:        0
>>> Hugepagesize:       2048 kB
>>> Hugetlb:               0 kB
>>> DirectMap4k:     2580336 kB
>>> DirectMap2M:    14196736 kB
>>> DirectMap1G:     2097152 kB
>>>
>>>
>>> vmstat shows:
>>> nr_free_pages 1320053
>>> nr_zone_inactive_anon 218362
>>> nr_zone_active_anon 2185108
>>> nr_zone_inactive_file 38363
>>> nr_zone_active_file 48645
>>> nr_zone_unevictable 4975
>>> nr_zone_write_pending 495
>>> nr_mlock 4975
>>> nr_page_table_pages 12553
>>> nr_kernel_stack 22576
>>> nr_bounce 0
>>> nr_zspages 0
>>> nr_free_cma 0
>>> numa_hit 13916119899
>>> numa_miss 0
>>> numa_foreign 0
>>> numa_interleave 15629
>>> numa_local 13916119899
>>> numa_other 0
>>> nr_inactive_anon 218362
>>> nr_active_anon 2185164
>>> nr_inactive_file 38363
>>> nr_active_file 48645
>>> nr_unevictable 4975
>>> nr_slab_reclaimable 95849
>>> nr_slab_unreclaimable 114118
>>> nr_isolated_anon 0
>>> nr_isolated_file 0
>>> workingset_refault 71365357
>>> workingset_activate 20281670
>>> workingset_restore 8995665
>>> workingset_nodereclaim 326085
>>> nr_anon_pages 2105903
>>> nr_mapped 244553
>>> nr_file_pages 306921
>>> nr_dirty 495
>>> nr_writeback 0
>>> nr_writeback_temp 0
>>> nr_shmem 218920
>>> nr_shmem_hugepages 0
>>> nr_shmem_pmdmapped 0
>>> nr_anon_transparent_hugepages 3128
>>> nr_unstable 0
>>> nr_vmscan_write 0
>>> nr_vmscan_immediate_reclaim 1833104
>>> nr_dirtied 386544087
>>> nr_written 259220036
>>> nr_dirty_threshold 265636
>>> nr_dirty_background_threshold 132656
>>> pgpgin 1817628997
>>> pgpgout 3730818029
>>> pswpin 0
>>> pswpout 0
>>> pgalloc_dma 0
>>> pgalloc_dma32 5790777997
>>> pgalloc_normal 20003662520
>>> pgalloc_movable 0
>>> allocstall_dma 0
>>> allocstall_dma32 0
>>> allocstall_normal 39
>>> allocstall_movable 1980089
>>> pgskip_dma 0
>>> pgskip_dma32 0
>>> pgskip_normal 0
>>> pgskip_movable 0
>>> pgfree 26637215947
>>> pgactivate 316722654
>>> pgdeactivate 261039211
>>> pglazyfree 0
>>> pgfault 17719356599
>>> pgmajfault 30985544
>>> pglazyfreed 0
>>> pgrefill 286826568
>>> pgsteal_kswapd 36740923
>>> pgsteal_direct 349291470
>>> pgscan_kswapd 36878966
>>> pgscan_direct 395327492
>>> pgscan_direct_throttle 0
>>> zone_reclaim_failed 0
>>> pginodesteal 49817087
>>> slabs_scanned 597956834
>>> kswapd_inodesteal 1412447
>>> kswapd_low_wmark_hit_quickly 39
>>> kswapd_high_wmark_hit_quickly 319
>>> pageoutrun 3585
>>> pgrotated 2873743
>>> drop_pagecache 0
>>> drop_slab 0
>>> oom_kill 0
>>> pgmigrate_success 839062285
>>> pgmigrate_fail 507313
>>> compact_migrate_scanned 9619077010
>>> compact_free_scanned 67985619651
>>> compact_isolated 1684537704
>>> compact_stall 205761
>>> compact_fail 182420
>>> compact_success 23341
>>> compact_daemon_wake 2
>>> compact_daemon_migrate_scanned 811
>>> compact_daemon_free_scanned 490241
>>> htlb_buddy_alloc_success 0
>>> htlb_buddy_alloc_fail 0
>>> unevictable_pgs_culled 1006521
>>> unevictable_pgs_scanned 0
>>> unevictable_pgs_rescued 997077
>>> unevictable_pgs_mlocked 1319203
>>> unevictable_pgs_munlocked 842471
>>> unevictable_pgs_cleared 470531
>>> unevictable_pgs_stranded 459613
>>> thp_fault_alloc 20263113
>>> thp_fault_fallback 3368635
>>> thp_collapse_alloc 226476
>>> thp_collapse_alloc_failed 17594
>>> thp_file_alloc 0
>>> thp_file_mapped 0
>>> thp_split_page 1159
>>> thp_split_page_failed 3927
>>> thp_deferred_split_page 20348941
>>> thp_split_pmd 53361
>>> thp_split_pud 0
>>> thp_zero_page_alloc 1
>>> thp_zero_page_alloc_failed 0
>>> thp_swpout 0
>>> thp_swpout_fallback 0
>>> balloon_inflate 0
>>> balloon_deflate 0
>>> balloon_migrate 0
>>> swap_ra 0
>>> swap_ra_hit 0
>>>
>>> Greets,
>>> Stefan
>>>
>>
