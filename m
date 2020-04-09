Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD03F1A369D
	for <lists+cgroups@lfdr.de>; Thu,  9 Apr 2020 17:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgDIPJc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+cgroups@lfdr.de>); Thu, 9 Apr 2020 11:09:32 -0400
Received: from smtprelay.restena.lu ([158.64.1.62]:44530 "EHLO
        smtprelay.restena.lu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbgDIPJc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 9 Apr 2020 11:09:32 -0400
Received: from hemera.lan.sysophe.eu (unknown [IPv6:2001:a18:1:12::4])
        by smtprelay.restena.lu (Postfix) with ESMTPS id 6A52340CD5;
        Thu,  9 Apr 2020 17:09:27 +0200 (CEST)
Date:   Thu, 9 Apr 2020 17:09:26 +0200
From:   Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Chris Down <chris@chrisdown.name>
Subject: Re: Memory CG and 5.1 to 5.6 uprade slows backup
Message-ID: <20200409170926.182354c3@hemera.lan.sysophe.eu>
In-Reply-To: <20200409103400.GF18386@dhcp22.suse.cz>
References: <20200409112505.2e1fc150@hemera.lan.sysophe.eu>
        <20200409094615.GE18386@dhcp22.suse.cz>
        <20200409121733.1a5ba17c@hemera.lan.sysophe.eu>
        <20200409103400.GF18386@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, 9 Apr 2020 12:34:00 +0200Michal Hocko wrote:

> On Thu 09-04-20 12:17:33, Bruno Prémont wrote:
> > On Thu, 9 Apr 2020 11:46:15 Michal Hocko wrote:  
> > > [Cc Chris]
> > > 
> > > On Thu 09-04-20 11:25:05, Bruno Prémont wrote:  
> > > > Hi,
> > > > 
> > > > Upgrading from 5.1 kernel to 5.6 kernel on a production system using
> > > > cgroups (v2) and having backup process in a memory.high=2G cgroup
> > > > sees backup being highly throttled (there are about 1.5T to be
> > > > backuped).    
> > > 
> > > What does /proc/sys/vm/dirty_* say?  
> > 
> > /proc/sys/vm/dirty_background_bytes:0
> > /proc/sys/vm/dirty_background_ratio:10
> > /proc/sys/vm/dirty_bytes:0
> > /proc/sys/vm/dirty_expire_centisecs:3000
> > /proc/sys/vm/dirty_ratio:20
> > /proc/sys/vm/dirty_writeback_centisecs:500  
> 
> Sorry, but I forgot ask for the total amount of memory. But it seems
> this is 64GB and 10% dirty ration might mean a lot of dirty memory.
> Does the same happen if you reduce those knobs to something smaller than
> 2G? _bytes alternatives should be useful for that purpose.

Well, tuning it to /proc/sys/vm/dirty_background_bytes:268435456
/proc/sys/vm/dirty_background_ratio:0
/proc/sys/vm/dirty_bytes:536870912
/proc/sys/vm/dirty_expire_centisecs:3000
/proc/sys/vm/dirty_ratio:0
/proc/sys/vm/dirty_writeback_centisecs:500
does not make any difference.


From /proc/meminfo there is no indication on high amounts of dirty
memory either:
MemTotal:       65930032 kB
MemFree:        21237240 kB
MemAvailable:   51646528 kB
Buffers:          202692 kB
Cached:         21493120 kB
SwapCached:            0 kB
Active:         12875888 kB
Inactive:       11361852 kB
Active(anon):    2879072 kB
Inactive(anon):    20600 kB
Active(file):    9996816 kB
Inactive(file): 11341252 kB
Unevictable:        9396 kB
Mlocked:            9396 kB
SwapTotal:             0 kB
SwapFree:              0 kB
Dirty:              3880 kB
Writeback:             0 kB
AnonPages:       2551776 kB
Mapped:           461816 kB
Shmem:            351144 kB
KReclaimable:   10012140 kB
Slab:           15673816 kB
SReclaimable:   10012140 kB
SUnreclaim:      5661676 kB
KernelStack:        7888 kB
PageTables:        24192 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:    32965016 kB
Committed_AS:    4792440 kB
VmallocTotal:   34359738367 kB
VmallocUsed:      126408 kB
VmallocChunk:          0 kB
Percpu:           136448 kB
HardwareCorrupted:     0 kB
AnonHugePages:    825344 kB
ShmemHugePages:        0 kB
ShmemPmdMapped:        0 kB
FileHugePages:         0 kB
FilePmdMapped:         0 kB
CmaTotal:              0 kB
CmaFree:               0 kB
DirectMap4k:       27240 kB
DirectMap2M:     4132864 kB
DirectMap1G:    65011712 kB


> [...]
> 
> > > Is it possible that the reclaim is not making progress on too many
> > > dirty pages and that triggers the back off mechanism that has been
> > > implemented recently in  5.4 (have a look at 0e4b01df8659 ("mm,
> > > memcg: throttle allocators when failing reclaim over memory.high")
> > > and e26733e0d0ec ("mm, memcg: throttle allocators based on
> > > ancestral memory.high").  
> > 
> > Could be though in that case it's throttling the wrong task/cgroup
> > as far as I can see (at least from cgroup's memory stats) or being
> > blocked by state external to the cgroup.
> > Will have a look at those patches so get a better idea at what they
> > change.  
> 
> Could you check where is the task of your interest throttled?
> /proc/<pid>/stack should give you a clue.

As guessed by Chris, it's
[<0>] mem_cgroup_handle_over_high+0x121/0x170
[<0>] exit_to_usermode_loop+0x67/0xa0
[<0>] do_syscall_64+0x149/0x170
[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9


And I know no way to tell kernel "drop all caches" for a specific cgroup
nor how to list the inactive files assigned to a given cgroup (knowing
which ones they are and their idle state could help understanding why
they aren't being reclaimed).



Could it be that cache is being prevented from being reclaimed by a task
in another cgroup?

e.g.
  cgroup/system/backup
    first reads $files (reads each once)
  cgroup/workload/bla
    second&more reads $files

Would $files remain associated to cgroup/system/backup and not
reclaimed there instead of being reassigned to cgroup/workload/bla?



Bruno
