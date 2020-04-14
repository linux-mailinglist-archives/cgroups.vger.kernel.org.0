Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011341A817B
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2020 17:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436991AbgDNPJQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+cgroups@lfdr.de>); Tue, 14 Apr 2020 11:09:16 -0400
Received: from smtprelay.restena.lu ([158.64.1.62]:56656 "EHLO
        smtprelay.restena.lu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440325AbgDNPJM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Apr 2020 11:09:12 -0400
Received: from hemera.lan.sysophe.eu (unknown [IPv6:2001:a18:1:12::4])
        by smtprelay.restena.lu (Postfix) with ESMTPS id 761CF41185;
        Tue, 14 Apr 2020 17:09:03 +0200 (CEST)
Date:   Tue, 14 Apr 2020 17:09:03 +0200
From:   Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Chris Down <chris@chrisdown.name>
Subject: Re: Memory CG and 5.1 to 5.6 uprade slows backup
Message-ID: <20200414170903.4f28c29f@hemera.lan.sysophe.eu>
In-Reply-To: <20200409152540.GP18386@dhcp22.suse.cz>
References: <20200409112505.2e1fc150@hemera.lan.sysophe.eu>
        <20200409094615.GE18386@dhcp22.suse.cz>
        <20200409121733.1a5ba17c@hemera.lan.sysophe.eu>
        <20200409103400.GF18386@dhcp22.suse.cz>
        <20200409170926.182354c3@hemera.lan.sysophe.eu>
        <20200409152540.GP18386@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Michal, Chris,

I can reproduce very easily with basic commands on a idle system with
just a reasonably filled partition and lots of (free) RAM and running:
  bash -c 'echo $$ > $path/to/cgroup/cgroup.procs; tar -zc -C /export . > /dev/null'
where tar is running all alone in its cgroup with
  memory.high = 1024M
  memory.max  = 1152M   (high + 128M)

At the start
  memory.stat:pgscan 0
  memory.stat:pgsteal 0
once pressure is "high" and tar gets throttled both values increase
concurrently by 64 once every 2 seconds.

Cgroup's memory.current starts 0 and grows up to memory.high and then
pressure starts.
  memory.stat:inactive_file 910192640
  memory.stat:active_file 61501440
active_file remains low (64M) while inactive_file is high (most of the
1024M allowed)

Somehow reclaim does not consider the inactive_file or tries to reclaim
in too small pieces compared to memory turnover in the cgroup.


Event having memory.max being just a single page (4096 bytes) larger
than memory.high brings the same throttling behavior.
Changing memory.max to match memory.high gets reclaim to work without
throttling.


Bruno


On Thu, 9 Apr 2020 17:25:40 Michal Hocko wrote:
> On Thu 09-04-20 17:09:26, Bruno Prémont wrote:
> > On Thu, 9 Apr 2020 12:34:00 +0200Michal Hocko wrote:
> >   
> > > On Thu 09-04-20 12:17:33, Bruno Prémont wrote:  
> > > > On Thu, 9 Apr 2020 11:46:15 Michal Hocko wrote:    
> > > > > [Cc Chris]
> > > > > 
> > > > > On Thu 09-04-20 11:25:05, Bruno Prémont wrote:    
> > > > > > Hi,
> > > > > > 
> > > > > > Upgrading from 5.1 kernel to 5.6 kernel on a production system using
> > > > > > cgroups (v2) and having backup process in a memory.high=2G cgroup
> > > > > > sees backup being highly throttled (there are about 1.5T to be
> > > > > > backuped).      
> > > > > 
> > > > > What does /proc/sys/vm/dirty_* say?    
> > > > 
> > > > /proc/sys/vm/dirty_background_bytes:0
> > > > /proc/sys/vm/dirty_background_ratio:10
> > > > /proc/sys/vm/dirty_bytes:0
> > > > /proc/sys/vm/dirty_expire_centisecs:3000
> > > > /proc/sys/vm/dirty_ratio:20
> > > > /proc/sys/vm/dirty_writeback_centisecs:500    
> > > 
> > > Sorry, but I forgot ask for the total amount of memory. But it seems
> > > this is 64GB and 10% dirty ration might mean a lot of dirty memory.
> > > Does the same happen if you reduce those knobs to something smaller than
> > > 2G? _bytes alternatives should be useful for that purpose.  
> > 
> > Well, tuning it to /proc/sys/vm/dirty_background_bytes:268435456
> > /proc/sys/vm/dirty_background_ratio:0
> > /proc/sys/vm/dirty_bytes:536870912
> > /proc/sys/vm/dirty_expire_centisecs:3000
> > /proc/sys/vm/dirty_ratio:0
> > /proc/sys/vm/dirty_writeback_centisecs:500
> > does not make any difference.  
> 
> OK, it was a wild guess because cgroup v2 should be able to throttle
> heavy writers and be memcg aware AFAIR. But good to have it confirmed.
> 
> [...]
> 
> > > > > Is it possible that the reclaim is not making progress on too many
> > > > > dirty pages and that triggers the back off mechanism that has been
> > > > > implemented recently in  5.4 (have a look at 0e4b01df8659 ("mm,
> > > > > memcg: throttle allocators when failing reclaim over memory.high")
> > > > > and e26733e0d0ec ("mm, memcg: throttle allocators based on
> > > > > ancestral memory.high").    
> > > > 
> > > > Could be though in that case it's throttling the wrong task/cgroup
> > > > as far as I can see (at least from cgroup's memory stats) or being
> > > > blocked by state external to the cgroup.
> > > > Will have a look at those patches so get a better idea at what they
> > > > change.    
> > > 
> > > Could you check where is the task of your interest throttled?
> > > /proc/<pid>/stack should give you a clue.  
> > 
> > As guessed by Chris, it's
> > [<0>] mem_cgroup_handle_over_high+0x121/0x170
> > [<0>] exit_to_usermode_loop+0x67/0xa0
> > [<0>] do_syscall_64+0x149/0x170
> > [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > 
> > 
> > And I know no way to tell kernel "drop all caches" for a specific cgroup
> > nor how to list the inactive files assigned to a given cgroup (knowing
> > which ones they are and their idle state could help understanding why
> > they aren't being reclaimed).
> > 
> > 
> > 
> > Could it be that cache is being prevented from being reclaimed by a task
> > in another cgroup?
> > 
> > e.g.
> >   cgroup/system/backup
> >     first reads $files (reads each once)
> >   cgroup/workload/bla
> >     second&more reads $files
> > 
> > Would $files remain associated to cgroup/system/backup and not
> > reclaimed there instead of being reassigned to cgroup/workload/bla?  
> 
> No, page cache is first-touch-gets-charged. But there is certainly a
> interference possible if the memory is somehow pinned - e.g. mlock - by
> a task from another cgroup or internally by FS.
> 
> Your earlier stat snapshot doesn't indicate a big problem with the
> reclaim though:
> 
> memory.stat:pgscan 47519855
> memory.stat:pgsteal 44933838
> 
> This tells the overall reclaim effectiveness was 94%. Could you try to
> gather snapshots with a 1s granularity starting before your run your
> backup to see how those numbers evolve? Ideally with timestamps to
> compare with the actual stall information.
> 
> Another option would be to enable vmscan tracepoints but let's try with
> stats first.

