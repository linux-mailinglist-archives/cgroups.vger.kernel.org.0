Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 657BC1A3264
	for <lists+cgroups@lfdr.de>; Thu,  9 Apr 2020 12:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbgDIKRf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+cgroups@lfdr.de>); Thu, 9 Apr 2020 06:17:35 -0400
Received: from smtprelay.restena.lu ([158.64.1.62]:43868 "EHLO
        smtprelay.restena.lu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbgDIKRf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 9 Apr 2020 06:17:35 -0400
Received: from hemera.lan.sysophe.eu (unknown [IPv6:2001:a18:1:12::4])
        by smtprelay.restena.lu (Postfix) with ESMTPS id 8933F40FB0;
        Thu,  9 Apr 2020 12:17:33 +0200 (CEST)
Date:   Thu, 9 Apr 2020 12:17:33 +0200
From:   Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Chris Down <chris@chrisdown.name>
Subject: Re: Memory CG and 5.1 to 5.6 uprade slows backup
Message-ID: <20200409121733.1a5ba17c@hemera.lan.sysophe.eu>
In-Reply-To: <20200409094615.GE18386@dhcp22.suse.cz>
References: <20200409112505.2e1fc150@hemera.lan.sysophe.eu>
        <20200409094615.GE18386@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, 9 Apr 2020 11:46:15 Michal Hocko <mhocko@kernel.org> wrote:
> [Cc Chris]
> 
> On Thu 09-04-20 11:25:05, Bruno Prémont wrote:
> > Hi,
> > 
> > Upgrading from 5.1 kernel to 5.6 kernel on a production system using
> > cgroups (v2) and having backup process in a memory.high=2G cgroup
> > sees backup being highly throttled (there are about 1.5T to be
> > backuped).  
> 
> What does /proc/sys/vm/dirty_* say?

/proc/sys/vm/dirty_background_bytes:0
/proc/sys/vm/dirty_background_ratio:10
/proc/sys/vm/dirty_bytes:0
/proc/sys/vm/dirty_expire_centisecs:3000
/proc/sys/vm/dirty_ratio:20
/proc/sys/vm/dirty_writeback_centisecs:500

Captured after having restarted the backup task.
After backup process restart the cgroup again has more free memory and
things run at a normal speed (until cgroup memory gets "full" again).
Current cgroup stats when things run fluently:

anon 176128
file 633012224
kernel_stack 73728
slab 47173632
sock 364544
shmem 0
file_mapped 10678272
file_dirty 811008
file_writeback 405504
anon_thp 0
inactive_anon 0
active_anon 0
inactive_file 552849408
active_file 79360000
unevictable 0
slab_reclaimable 46411776
slab_unreclaimable 761856
pgfault 8656857
pgmajfault 2145
workingset_refault 8672334
workingset_activate 410586
workingset_nodereclaim 92895
pgrefill 1516540
pgscan 48241750
pgsteal 45655752
pgactivate 7986
pgdeactivate 1483626
pglazyfree 0
pglazyfreed 0
thp_fault_alloc 0
thp_collapse_alloc 0


> Is it possible that the reclaim is not making progress on too many
> dirty pages and that triggers the back off mechanism that has been
> implemented recently in  5.4 (have a look at 0e4b01df8659 ("mm,
> memcg: throttle allocators when failing reclaim over memory.high")
> and e26733e0d0ec ("mm, memcg: throttle allocators based on
> ancestral memory.high").

Could be though in that case it's throttling the wrong task/cgroup
as far as I can see (at least from cgroup's memory stats) or being
blocked by state external to the cgroup.
Will have a look at those patches so get a better idea at what they
change.

System-wide memory is at least 10G/64G completely free (varies between
10G and 20G free - ~18G file cache, ~10G reclaimable slabs, ~5G
unreclaimable slabs and 7G otherwise in use).

> Keeping the rest of the email for reference.
> 
> > Most memory usage in that cgroup is for file cache.
> > 
> > Here are the memory details for the cgroup:
> > memory.current:2147225600
> > memory.events:low 0
> > memory.events:high 423774
> > memory.events:max 31131
> > memory.events:oom 0
> > memory.events:oom_kill 0
> > memory.events.local:low 0
> > memory.events.local:high 423774
> > memory.events.local:max 31131
> > memory.events.local:oom 0
> > memory.events.local:oom_kill 0
> > memory.high:2147483648
> > memory.low:33554432
> > memory.max:2415919104
> > memory.min:0
> > memory.oom.group:0
> > memory.pressure:some avg10=90.42 avg60=72.59 avg300=78.30 total=298252577711
> > memory.pressure:full avg10=90.32 avg60=72.53 avg300=78.24 total=295658626500
> > memory.stat:anon 10887168
> > memory.stat:file 2062102528
> > memory.stat:kernel_stack 73728
> > memory.stat:slab 76148736
> > memory.stat:sock 360448
> > memory.stat:shmem 0
> > memory.stat:file_mapped 12029952
> > memory.stat:file_dirty 946176
> > memory.stat:file_writeback 405504
> > memory.stat:anon_thp 0
> > memory.stat:inactive_anon 0
> > memory.stat:active_anon 10121216
> > memory.stat:inactive_file 1954959360
> > memory.stat:active_file 106418176
> > memory.stat:unevictable 0
> > memory.stat:slab_reclaimable 75247616
> > memory.stat:slab_unreclaimable 901120
> > memory.stat:pgfault 8651676
> > memory.stat:pgmajfault 2013
> > memory.stat:workingset_refault 8670651
> > memory.stat:workingset_activate 409200
> > memory.stat:workingset_nodereclaim 62040
> > memory.stat:pgrefill 1513537
> > memory.stat:pgscan 47519855
> > memory.stat:pgsteal 44933838
> > memory.stat:pgactivate 7986
> > memory.stat:pgdeactivate 1480623
> > memory.stat:pglazyfree 0
> > memory.stat:pglazyfreed 0
> > memory.stat:thp_fault_alloc 0
> > memory.stat:thp_collapse_alloc 0
> > 
> > Numbers that change most are pgscan/pgsteal
> > Regularly the backup process seems to be blocked for about 2s, but not
> > within a syscall according to strace.
> > 
> > Is there a way to tell kernel that this cgroup should not be throttled
> > and its inactive file cache given up (rather quickly).
> > 
> > The aim here is to avoid backup from killing production task file cache
> > but not starving it.
> > 
> > 
> > If there is some useful info missing, please tell (eventually adding how
> > I can obtain it).
> > 
> > 
> > On a side note, I liked v1's mode of soft/hard memory limit where the
> > memory amount between soft and hard could be used if system has enough
> > free memory. For v2 the difference between high and max seems almost of
> > no use.
> > 
> > A cgroup parameter for impacting RO file cache differently than
> > anonymous memory or otherwise dirty memory would be great too.
> > 
> > 
> > Thanks,
> > Bruno
