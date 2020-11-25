Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E05E32C4235
	for <lists+cgroups@lfdr.de>; Wed, 25 Nov 2020 15:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729340AbgKYOdw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+cgroups@lfdr.de>); Wed, 25 Nov 2020 09:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbgKYOdw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 Nov 2020 09:33:52 -0500
Received: from smtprelay.restena.lu (smtprelay.restena.lu [IPv6:2001:a18:1::62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F9CC0613D4
        for <cgroups@vger.kernel.org>; Wed, 25 Nov 2020 06:33:52 -0800 (PST)
Received: from hemera (unknown [IPv6:2001:a18:1:10:fa75:a4ff:fe28:fe3a])
        by smtprelay.restena.lu (Postfix) with ESMTPS id D26F442C1E;
        Wed, 25 Nov 2020 15:33:50 +0100 (CET)
Date:   Wed, 25 Nov 2020 15:33:50 +0100
From:   Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Yafang Shao <laoar.shao@gmail.com>,
        Chris Down <chris@chrisdown.name>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: Regression from 5.7.17 to 5.9.9 with memory.low cgroup
 constraints
Message-ID: <20201125153350.0af98d93@hemera>
In-Reply-To: <20201125133740.GE31550@dhcp22.suse.cz>
References: <20201125123956.61d9e16a@hemera>
        <20201125133740.GE31550@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Michal,

On Wed, 25 Nov 2020 14:37:40 +0100 Michal Hocko <mhocko@suse.com> wrote:
> Hi,
> thanks for the detailed report.
> 
> On Wed 25-11-20 12:39:56, Bruno Prémont wrote:
> [...]
> > Did memory.low meaning change between 5.7 and 5.9?  
> 
> The latest semantic change in the low limit protection semantic was
> introduced in 5.7 (recursive protection) but it requires an explicit
> enablinig.

No specific mount options set for v2 cgroup, so not active.

> > From behavior it
> > feels as if inodes are not accounted to cgroup at all and kernel pushes
> > cgroups down to their memory.low by killing file cache if there is not
> > enough free memory to hold all promises (and not only when a cgroup
> > tries to use up to its promised amount of memory).  
> 
> Your counters indeed show that the low protection has been breached,
> most likely because the reclaim couldn't make any progress. Considering
> that this is the case for all/most of your cgroups it suggests that the
> memory pressure was global rather than limit imposed. In fact even top
> level cgroups got reclaimed below the low limit.

Note that the "original" counters we partially triggered by a first
event where I had one cgroup (websrv) of the with a rather very high
memory.low (16G or even 32G) which caused counters everywhere to
increase.


So before the last trashing during which the values were collected the
event counters and `current` looked as follows:

system/memory.pressure
  some avg10=0.04 avg60=0.28 avg300=0.12 total=5844917510
  full avg10=0.04 avg60=0.26 avg300=0.11 total=2439353404
system/memory.current
  96432128
system/memory.events.local
  low      5399469   (unchanged)
  high     0
  max      112303    (unchanged)
  oom      0
  oom_kill 0

system/base/memory.pressure
  some avg10=0.04 avg60=0.28 avg300=0.12 total=4589562039
  full avg10=0.04 avg60=0.28 avg300=0.12 total=1926984197
system/base/memory.current
  59305984
system/base/memory.events.local
  low      0   (unchanged)
  high     0
  max      0   (unchanged)
  oom      0
  oom_kill 0

system/backup/memory.pressure
  some avg10=0.00 avg60=0.00 avg300=0.00 total=2123293649
  full avg10=0.00 avg60=0.00 avg300=0.00 total=815450446
system/backup/memory.current
  32444416
system/backup/memory.events.local
  low      5446   (unchanged)
  high     0
  max      0
  oom      0
  oom_kill 0

system/shell/memory.pressure
  some avg10=0.00 avg60=0.00 avg300=0.00 total=1345965660
  full avg10=0.00 avg60=0.00 avg300=0.00 total=492812915
system/shell/memory.current
  4571136
system/shell/memory.events.local
  low      0
  high     0
  max      0
  oom      0
  oom_kill 0

website/memory.pressure
  some avg10=0.00 avg60=0.00 avg300=0.00 total=415008878
  full avg10=0.00 avg60=0.00 avg300=0.00 total=201868483
website/memory.current
  12104380416
website/memory.events.local
  low      11264569  (during trashing: 11372142 then 11377350)
  high     0
  max      0
  oom      0
  oom_kill 0

remote/memory.pressure
  some avg10=0.00 avg60=0.00 avg300=0.00 total=2005130126
  full avg10=0.00 avg60=0.00 avg300=0.00 total=735366752
remote/memory.current
  116330496
remote/memory.events.local
  low      11264569  (during trashing: 11372142 then 11377350)
  high     0
  max      0
  oom      0
  oom_kill 0

websrv/memory.pressure
  some avg10=0.02 avg60=0.11 avg300=0.03 total=6650355162
  full avg10=0.02 avg60=0.11 avg300=0.03 total=2034584579
websrv/memory.current
  18483359744
websrv/memory.events.local
  low      0
  high     0
  max      0
  oom      0
  oom_kill 0


> This suggests that this is not likely to be memcg specific. It is
> more likely that this is a general memory reclaim regression for your
> workload. There were larger changes in that area. Be it lru balancing
> based on cost model by Johannes or working set tracking for anonymous
> pages by Joonsoo. Maybe even more. Both of them can influence page cache
> reclaim but you are suggesting that slab accounted memory is not
> reclaimed properly.

That is my impression, yes. No idea though if memcg can influence the
way reclaim tries to perform its work or if slab_reclaimable not
associated to any (child) cg would somehow be excluded from reclaim.

> I am not sure sure there were considerable changes
> there. Would it be possible to collect /prov/vmstat as well?

I will have a look at gathering memory.stat and /proc/vmstat at next
opportunity.
Will first try with a test system with not too much memory and lots of
files to reproduce about 50% of memory usage by slab_reclaimable and
see how far I get.

Thanks,
Bruno
