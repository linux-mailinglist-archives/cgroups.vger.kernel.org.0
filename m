Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4263B20E71
	for <lists+cgroups@lfdr.de>; Thu, 16 May 2019 20:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbfEPSKq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 May 2019 14:10:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:54484 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726314AbfEPSKq (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 16 May 2019 14:10:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DE7ABAF26;
        Thu, 16 May 2019 18:10:43 +0000 (UTC)
Date:   Thu, 16 May 2019 20:10:42 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     akpm@linux-foundation.org, mm-commits@vger.kernel.org,
        tj@kernel.org, guro@fb.com, dennis@kernel.org,
        chris@chrisdown.name,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        linux-mm@kvack.org
Subject: Re: + mm-consider-subtrees-in-memoryevents.patch added to -mm tree
Message-ID: <20190516180932.GA13208@dhcp22.suse.cz>
References: <20190212224542.ZW63a%akpm@linux-foundation.org>
 <20190213124729.GI4525@dhcp22.suse.cz>
 <20190516175655.GA25818@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516175655.GA25818@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 16-05-19 13:56:55, Johannes Weiner wrote:
> On Wed, Feb 13, 2019 at 01:47:29PM +0100, Michal Hocko wrote:
> > On Tue 12-02-19 14:45:42, Andrew Morton wrote:
> > [...]
> > > From: Chris Down <chris@chrisdown.name>
> > > Subject: mm, memcg: consider subtrees in memory.events
> > > 
> > > memory.stat and other files already consider subtrees in their output, and
> > > we should too in order to not present an inconsistent interface.
> > > 
> > > The current situation is fairly confusing, because people interacting with
> > > cgroups expect hierarchical behaviour in the vein of memory.stat,
> > > cgroup.events, and other files.  For example, this causes confusion when
> > > debugging reclaim events under low, as currently these always read "0" at
> > > non-leaf memcg nodes, which frequently causes people to misdiagnose breach
> > > behaviour.  The same confusion applies to other counters in this file when
> > > debugging issues.
> > > 
> > > Aggregation is done at write time instead of at read-time since these
> > > counters aren't hot (unlike memory.stat which is per-page, so it does it
> > > at read time), and it makes sense to bundle this with the file
> > > notifications.
> > > 
> > > After this patch, events are propagated up the hierarchy:
> > > 
> > >     [root@ktst ~]# cat /sys/fs/cgroup/system.slice/memory.events
> > >     low 0
> > >     high 0
> > >     max 0
> > >     oom 0
> > >     oom_kill 0
> > >     [root@ktst ~]# systemd-run -p MemoryMax=1 true
> > >     Running as unit: run-r251162a189fb4562b9dabfdc9b0422f5.service
> > >     [root@ktst ~]# cat /sys/fs/cgroup/system.slice/memory.events
> > >     low 0
> > >     high 0
> > >     max 7
> > >     oom 1
> > >     oom_kill 1
> > > 
> > > As this is a change in behaviour, this can be reverted to the old
> > > behaviour by mounting with the `memory_localevents' flag set.  However, we
> > > use the new behaviour by default as there's a lack of evidence that there
> > > are any current users of memory.events that would find this change
> > > undesirable.
> > > 
> > > Link: http://lkml.kernel.org/r/20190208224419.GA24772@chrisdown.name
> > > Signed-off-by: Chris Down <chris@chrisdown.name>
> > > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > > Cc: Michal Hocko <mhocko@kernel.org>
> > > Cc: Tejun Heo <tj@kernel.org>
> > > Cc: Roman Gushchin <guro@fb.com>
> > > Cc: Dennis Zhou <dennis@kernel.org>
> > > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > 
> > FTR: As I've already said here [1] I can live with this change as long
> > as there is a larger consensus among cgroup v2 users. So let's give this
> > some more time before merging to see whether there is such a consensus.
> > 
> > [1] http://lkml.kernel.org/r/20190201102515.GK11599@dhcp22.suse.cz
> 
> It's been three months without any objections.

It's been three months without any _feedback_ from anybody. It might
very well be true that people just do not read these emails or do not
care one way or another.

> Can we merge this for
> v5.2 please? We still have users complaining about this inconsistent
> behavior (the last one was yesterday) and we'd rather not carry any
> out of tree patches.

Could you point me to those complains or is this something internal?
-- 
Michal Hocko
SUSE Labs
