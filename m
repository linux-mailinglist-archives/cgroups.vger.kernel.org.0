Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23859785DA
	for <lists+cgroups@lfdr.de>; Mon, 29 Jul 2019 09:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfG2HID (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Jul 2019 03:08:03 -0400
Received: from cloud1-vm154.de-nserver.de ([178.250.10.56]:49107 "EHLO
        cloud1-vm154.de-nserver.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725957AbfG2HID (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 29 Jul 2019 03:08:03 -0400
Received: (qmail 2318 invoked from network); 29 Jul 2019 09:08:00 +0200
X-Fcrdns: No
Received: from phoffice.de-nserver.de (HELO [10.11.11.165]) (185.39.223.5)
  (smtp-auth username hostmaster@profihost.com, mechanism plain)
  by cloud1-vm154.de-nserver.de (qpsmtpd/0.92) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) ESMTPSA; Mon, 29 Jul 2019 09:08:00 +0200
Subject: Re: No memory reclaim while reaching MemoryHigh
From:   Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     cgroups@vger.kernel.org, "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "n.fahldieck@profihost.ag" <n.fahldieck@profihost.ag>,
        Daniel Aberger - Profihost AG <d.aberger@profihost.ag>,
        p.kramme@profihost.ag
References: <496dd106-abdd-3fca-06ad-ff7abaf41475@profihost.ag>
 <20190725140117.GC3582@dhcp22.suse.cz>
 <028ff462-b547-b9a5-bdb0-e0de3a884afd@profihost.ag>
 <20190726074557.GF6142@dhcp22.suse.cz>
 <d205c7a1-30c4-e26c-7e9c-debc431b5ada@profihost.ag>
 <9eb7d70a-40b1-b452-a0cf-24418fa6254c@profihost.ag>
Message-ID: <57de9aed-2eab-b842-4ca9-a5ec8fbf358a@profihost.ag>
Date:   Mon, 29 Jul 2019 09:07:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9eb7d70a-40b1-b452-a0cf-24418fa6254c@profihost.ag>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-User-Auth: Auth by hostmaster@profihost.com through 185.39.223.5
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi all,

it might be that i just missunderstood how it works.

This test works absolutely fine without any penalty:

test.sh:
#####
#!/bin/bash

sync
echo 3 >/proc/sys/vm/drop_caches
sync
time find / -xdev -type f -exec cat "{}" \; >/dev/null 2>/dev/null
#####

started with:
systemd-run -pRemainAfterExit=True -- /root/spriebe/test.sh

or

systemd-run --property=MemoryHigh=300M -pRemainAfterExit=True --
/root/spriebe/test.sh

In both cases it takes ~ 1m 45s even though it consumes about 2G of mem
in the first case.

So it seems even though it can only consume a max of 300M in the 2nd
case. It is as fast as the first one without any limit.

I thought until today that the same would happen for varnish. Where's
the difference?

I also tried stuff like:
sysctl -w vm.vfs_cache_pressure=1000000

but the cgroup memory usage of varnish still raises slowly about 100M
per hour. The varnish process itself stays constant at ~5.6G

Greets,
Stefan

Am 28.07.19 um 23:11 schrieb Stefan Priebe - Profihost AG:
> here is a memory.stat output of the cgroup:
> # cat /sys/fs/cgroup/system.slice/varnish.service/memory.stat
> anon 8113229824
> file 39735296
> kernel_stack 26345472
> slab 24985600
> sock 339968
> shmem 0
> file_mapped 38793216
> file_dirty 946176
> file_writeback 0
> inactive_anon 0
> active_anon 8113119232
> inactive_file 40198144
> active_file 102400
> unevictable 0
> slab_reclaimable 2859008
> slab_unreclaimable 22126592
> pgfault 178231449
> pgmajfault 22011
> pgrefill 393038
> pgscan 4218254
> pgsteal 430005
> pgactivate 295416
> pgdeactivate 351487
> pglazyfree 0
> pglazyfreed 0
> workingset_refault 401874
> workingset_activate 62535
> workingset_nodereclaim 0
> 
> Greets,
> Stefan
> 
> Am 26.07.19 um 20:30 schrieb Stefan Priebe - Profihost AG:
>> Am 26.07.19 um 09:45 schrieb Michal Hocko:
>>> On Thu 25-07-19 23:37:14, Stefan Priebe - Profihost AG wrote:
>>>> Hi Michal,
>>>>
>>>> Am 25.07.19 um 16:01 schrieb Michal Hocko:
>>>>> On Thu 25-07-19 15:17:17, Stefan Priebe - Profihost AG wrote:
>>>>>> Hello all,
>>>>>>
>>>>>> i hope i added the right list and people - if i missed someone i would
>>>>>> be happy to know.
>>>>>>
>>>>>> While using kernel 4.19.55 and cgroupv2 i set a MemoryHigh value for a
>>>>>> varnish service.
>>>>>>
>>>>>> It happens that the varnish.service cgroup reaches it's MemoryHigh value
>>>>>> and stops working due to throttling.
>>>>>
>>>>> What do you mean by "stops working"? Does it mean that the process is
>>>>> stuck in the kernel doing the reclaim? /proc/<pid>/stack would tell you
>>>>> what the kernel executing for the process.
>>>>
>>>> The service no longer responses to HTTP requests.
>>>>
>>>> stack switches in this case between:
>>>> [<0>] io_schedule+0x12/0x40
>>>> [<0>] __lock_page_or_retry+0x1e7/0x4e0
>>>> [<0>] filemap_fault+0x42f/0x830
>>>> [<0>] __xfs_filemap_fault.constprop.11+0x49/0x120
>>>> [<0>] __do_fault+0x57/0x108
>>>> [<0>] __handle_mm_fault+0x949/0xef0
>>>> [<0>] handle_mm_fault+0xfc/0x1f0
>>>> [<0>] __do_page_fault+0x24a/0x450
>>>> [<0>] do_page_fault+0x32/0x110
>>>> [<0>] async_page_fault+0x1e/0x30
>>>> [<0>] 0xffffffffffffffff
>>>>
>>>> and
>>>>
>>>> [<0>] poll_schedule_timeout.constprop.13+0x42/0x70
>>>> [<0>] do_sys_poll+0x51e/0x5f0
>>>> [<0>] __x64_sys_poll+0xe7/0x130
>>>> [<0>] do_syscall_64+0x5b/0x170
>>>> [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>>> [<0>] 0xffffffffffffffff
>>>
>>> Neither of the two seem to be memcg related.
>>
>> Yes but at least the xfs one is a page fault - isn't this related?
>>
>>> Have you tried to get
>>> several snapshots and see if the backtrace is stable?
>> No it's not it switches most of the time between these both. But as long
>> as the xfs one with the page fault is seen it does not serve requests
>> and that one is seen for at least 1-5s than the poill one is visible and
>> than the xfs one again for 1-5s.
>>
>> This happens if i do:
>> systemctl set-property --runtime varnish.service MemoryHigh=6.5G
>>
>> if i set:
>> systemctl set-property --runtime varnish.service MemoryHigh=14G
>>
>> i never get the xfs handle_mm fault one. This is reproducable.
>>
>>> tell you whether your application is stuck in a single syscall or they
>>> are just progressing very slowly (-ttt parameter should give you timing)
>>
>> Yes it's still going forward but really really slow due to memory
>> pressure. memory.pressure of varnish cgroup shows high values above 100
>> or 200.
>>
>> I can reproduce the same with rsync or other tasks using memory for
>> inodes and dentries. What i don't unterstand is that the kernel does not
>> reclaim memory for the userspace process and drops the cache. I can't
>> believe those entries are hot - as they must be at least some days old
>> as a fresh process running a day only consumes about 200MB of indoe /
>> dentries / page cache.
>>
>> Greets,
>> Stefan
>>
