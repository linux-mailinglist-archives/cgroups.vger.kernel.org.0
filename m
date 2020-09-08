Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4637D262176
	for <lists+cgroups@lfdr.de>; Tue,  8 Sep 2020 22:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbgIHUxO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Sep 2020 16:53:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:33328 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729912AbgIHUxN (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 8 Sep 2020 16:53:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 02C86ADC5;
        Tue,  8 Sep 2020 20:53:12 +0000 (UTC)
Date:   Tue, 8 Sep 2020 22:53:10 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Julius Hemanth Pitti <jpitti@cisco.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        xe-linux-external@cisco.com
Subject: Re: [PATCH v2] mm: memcg: yield cpu when we fail to charge pages
Message-ID: <20200908205310.GF26850@dhcp22.suse.cz>
References: <20200908201426.14837-1-jpitti@cisco.com>
 <CAHbLzkqYrkA6=RSBpwEQJ5WaLUWwdP=05BPE2F4pRgk98NuVTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkqYrkA6=RSBpwEQJ5WaLUWwdP=05BPE2F4pRgk98NuVTg@mail.gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 08-09-20 13:31:51, Yang Shi wrote:
> On Tue, Sep 8, 2020 at 1:14 PM Julius Hemanth Pitti <jpitti@cisco.com> wrote:
> >
> > For non root CG, in try_charge(), we keep trying
> > to charge until we succeed. On non-preemptive
> > kernel, when we are OOM, this results in holding
> > CPU forever.
> >
> > On SMP systems, this doesn't create a big problem
> > because oom_reaper get a change to kill victim
> > and make some free pages. However on a single-core
> > CPU (or cases where oom_reaper pinned to same CPU
> > where try_charge is executing), oom_reaper shall
> > never get scheduled and we stay in try_charge forever.
> >
> > Steps to repo this on non-smp:
> > 1. mount -t tmpfs none /sys/fs/cgroup
> > 2. mkdir /sys/fs/cgroup/memory
> > 3. mount -t cgroup none /sys/fs/cgroup/memory -o memory
> > 4. mkdir /sys/fs/cgroup/memory/0
> > 5. echo 40M > /sys/fs/cgroup/memory/0/memory.limit_in_bytes
> > 6. echo $$ > /sys/fs/cgroup/memory/0/tasks
> > 7. stress -m 5 --vm-bytes 10M --vm-hang 0
> 
> Isn't it the same problem solved by e3336cab2579 ("mm: memcg: fix
> memcg reclaim soft lockup")? It has been in Linus's tree.

Yes it should because it adds a scheduling point regardless
of reclaimability.
 
> > Signed-off-by: Julius Hemanth Pitti <jpitti@cisco.com>
> > Acked-by: Roman Gushchin <guro@fb.com>
> > ---
> >
> > Changes in v2:
> >  - Added comments.
> >  - Added "Acked-by: Roman Gushchin <guro@fb.com>".
> > ---
> >  mm/memcontrol.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index cfa6cbad21d5..4f293bf8c7ed 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -2745,6 +2745,15 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
> >         if (fatal_signal_pending(current))
> >                 goto force;
> >
> > +       /*
> > +        * We failed to charge even after retries, give oom_reaper or
> > +        * other process a change to make some free pages.
> > +        *
> > +        * On non-preemptive, Non-SMP system, this is critical, else
> > +        * we keep retrying with no success, forever.
> > +        */
> > +       cond_resched();
> > +
> >         /*
> >          * keep retrying as long as the memcg oom killer is able to make
> >          * a forward progress or bypass the charge if the oom killer
> > --
> > 2.17.1
> >
> >

-- 
Michal Hocko
SUSE Labs
