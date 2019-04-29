Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0CA6E0B6
	for <lists+cgroups@lfdr.de>; Mon, 29 Apr 2019 12:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbfD2Knk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Apr 2019 06:43:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:37492 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727868AbfD2Kna (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 29 Apr 2019 06:43:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 27A74AB9D;
        Mon, 29 Apr 2019 10:43:29 +0000 (UTC)
Date:   Mon, 29 Apr 2019 12:43:26 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, mm <linux-mm@kvack.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: memcg causes crashes in list_lru_add
Message-ID: <20190429104326.GG21837@dhcp22.suse.cz>
References: <f0cfcfa7-74d0-8738-1061-05d778155462@suse.cz>
 <2cbfb8dc-31f0-7b95-8a93-954edb859cd8@suse.cz>
 <359d98e6-044a-7686-8522-bdd2489e9456@suse.cz>
 <20190429104051.GF21837@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429104051.GF21837@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 29-04-19 12:40:51, Michal Hocko wrote:
> On Mon 29-04-19 12:09:53, Jiri Slaby wrote:
> > On 29. 04. 19, 11:25, Jiri Slaby wrote:> memcg_update_all_list_lrus
> > should take care about resizing the array.
> > 
> > It should, but:
> > [    0.058362] Number of physical nodes 2
> > [    0.058366] Skipping disabled node 0
> > 
> > So this should be the real fix:
> > --- linux-5.0-stable1.orig/mm/list_lru.c
> > +++ linux-5.0-stable1/mm/list_lru.c
> > @@ -37,11 +37,12 @@ static int lru_shrinker_id(struct list_l
> > 
> >  static inline bool list_lru_memcg_aware(struct list_lru *lru)
> >  {
> > -       /*
> > -        * This needs node 0 to be always present, even
> > -        * in the systems supporting sparse numa ids.
> > -        */
> > -       return !!lru->node[0].memcg_lrus;
> > +       int i;
> > +
> > +       for_each_online_node(i)
> > +               return !!lru->node[i].memcg_lrus;
> > +
> > +       return false;
> >  }
> > 
> >  static inline struct list_lru_one *
> > 
> > 
> > 
> > 
> > 
> > Opinions?
> 
> Please report upstream. This code here is there for quite some time.
> I do not really remember why we do have an assumption about node 0
> and why it hasn't been problem until now.

Humm, I blame jet-lag. I was convinced that this is an internal email.
Sorry about the confusion.

Anyway, time to revisit 145949a1387ba. CCed Raghavendra.
-- 
Michal Hocko
SUSE Labs
