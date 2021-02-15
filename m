Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCA731B72A
	for <lists+cgroups@lfdr.de>; Mon, 15 Feb 2021 11:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhBOK2r (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Feb 2021 05:28:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:36324 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230171AbhBOK2f (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 15 Feb 2021 05:28:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613384868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=73NkWy0SYucsJms5v/JqP31gNuHokmiIPgdC8knJweg=;
        b=Tmnax6sJaIBzZXp3R9sNYEAdnpn1Ugf0Kem4uhGfk88hDPKs3PUvyOkp27ScBspmABWtSQ
        x1mqyWFbV/M8ApNz3GFqshMqfOREiaOw22s46pasXI8stgyvG/yWdbk5dqb+Zpje2rMnM/
        1s+WpacNOOfge1Mf709dhpF/q0ixbAE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C5CFFAC32;
        Mon, 15 Feb 2021 10:27:48 +0000 (UTC)
Date:   Mon, 15 Feb 2021 11:27:47 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [External] Re: [PATCH 3/4] mm: memcontrol: bail out early when
 id is zero
Message-ID: <YCpMo6gLFyqANsgd@dhcp22.suse.cz>
References: <20210212170159.32153-1-songmuchun@bytedance.com>
 <20210212170159.32153-3-songmuchun@bytedance.com>
 <YCpBUm2N4Bqm5PM5@dhcp22.suse.cz>
 <CAMZfGtVkh-DeYLLo8Nn7kHMCq055RSvL03eON1iqmhydYiQ-iQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtVkh-DeYLLo8Nn7kHMCq055RSvL03eON1iqmhydYiQ-iQ@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 15-02-21 18:09:44, Muchun Song wrote:
> On Mon, Feb 15, 2021 at 5:39 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Sat 13-02-21 01:01:58, Muchun Song wrote:
> > > The memcg ID cannot be zero, but we can pass zero to mem_cgroup_from_id,
> > > so idr_find() is pointless and wastes CPU cycles.
> >
> > Is this possible at all to happen? If not why should we add a test for
> > _all_ invocations?
> 
> Yeah, this indeed can happen. If we allocate a new swap cache page
> and charge it via mem_cgroup_charge, then the page will uncharge
> the swap counter via mem_cgroup_uncharge_swap. When the swap
> entry is indeed freed, we will call mem_cgroup_uncharge_swap again,
> In this routine, we can pass zero to mem_cgroup_from_id. Right?

If the above claim is correct, which I would need to double check then
it should have been part of the changelog! Please think of your poor
reviewers and the time they have to invest into the review.

I would also like to see your waste of CPU cycles argument to be backed
by something. Are we talking about cycles due to an additional function
call? Is this really something we should even care about?

> > >
> > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > ---
> > >  mm/memcontrol.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index a3f26522765a..68ed4b297c13 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -5173,6 +5173,9 @@ static inline void mem_cgroup_id_put(struct mem_cgroup *memcg)
> > >  struct mem_cgroup *mem_cgroup_from_id(unsigned short id)
> > >  {
> > >       WARN_ON_ONCE(!rcu_read_lock_held());
> > > +     /* The memcg ID cannot be zero. */
> > > +     if (id == 0)
> > > +             return NULL;
> > >       return idr_find(&mem_cgroup_idr, id);
> > >  }
> > >
> > > --
> > > 2.11.0
> >
> > --
> > Michal Hocko
> > SUSE Labs

-- 
Michal Hocko
SUSE Labs
