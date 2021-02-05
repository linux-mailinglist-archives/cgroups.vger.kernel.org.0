Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 465BC31150E
	for <lists+cgroups@lfdr.de>; Fri,  5 Feb 2021 23:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbhBEWW5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 5 Feb 2021 17:22:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:50472 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232625AbhBEO2U (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 5 Feb 2021 09:28:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612541179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X0eNZnPZ2yvNSsohyfO18yi1he4bt+Z9BswCbs9pY3o=;
        b=YTiJoqhqHI2WHfc/9NOnQxXomFQnQCUwdI5oE5KBAXc1O9bZPxV2+A/3GrVxmdvJKCbIc8
        9ChcfYP2M7iEcMltkcdxKxBeP+1W6fktGOqgAaFVj4vBCU4AuFA1sVBIwma+QHOIqOGPkd
        HlvyEvn0XK+Z44oQX8eZCi+9KntjaFw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 560A9B0BF;
        Fri,  5 Feb 2021 16:06:19 +0000 (UTC)
Date:   Fri, 5 Feb 2021 17:06:18 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Roman Gushchin <guro@fb.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [External] Re: [PATCH] mm: memcontrol: remove rcu_read_lock from
 get_mem_cgroup_from_page
Message-ID: <YB1s+puR+zPnkIFe@dhcp22.suse.cz>
References: <20210205062719.74431-1-songmuchun@bytedance.com>
 <YB0DnAlCaQza4Uf9@dhcp22.suse.cz>
 <CAMZfGtVhBrwgkJVwiah6eDsppSf8fYp+uZ=tZmHBLDFeTmQX3w@mail.gmail.com>
 <YB0euLiMU+T/9bMK@dhcp22.suse.cz>
 <CALvZod65SY3yVXSwxO02VCZeEg9KsBqq9_Ph3pq2gfQ0eH=kFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod65SY3yVXSwxO02VCZeEg9KsBqq9_Ph3pq2gfQ0eH=kFw@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 05-02-21 07:59:06, Shakeel Butt wrote:
> +Cc Roman
> 
> On Fri, Feb 5, 2021 at 2:49 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> [snip]
> > > > > Also, css_get is enough because page
> > > > > has a reference to the memcg.
> > > >
> > > > tryget used to be there to guard against offlined memcg but we have
> > > > concluded this is impossible in this path. tryget stayed there to catch
> > > > some unexpected cases IIRC.
> > >
> > > Yeah, it can catch some unexpected cases. But why is this path
> > > special so that we need a tryget?
> >
> > I do not remember details and the changelog of that change is not
> > explicit but I suspect it was just because this one could trigger as
> > there are external callers to memcg. Is this protection needed? I am not
> > sure, this is for you to justify if you want to remove it.
> >
> 
> It used to be css_tryget_online() which was changed to css_tryget()
> and from the discussion at [1], it seemed css_get() would be enough
> but we took a safer route.
> 
> Anyways, I think we can either take the page_memcg_rcu() route or put
> explicit restrictions with page lock or lock_page_memcg() to guarantee
> page and memcg binding. I don't have a strong opinion either way but I
> think removing restrictions in future for new use-cases will be much
> harder, so, page_memcg_rcu() approach seems more appropriate at least
> for now.

Yeah, I would like to not have very special locking requirements here.
Definitely not page_lock as that one is too overloaded already.

> 
> [1] https://lore.kernel.org/linux-mm/CALvZod5pAv=u8L2Tgk0hDY7XAiiF2dvjC1omQ5BSfzFu_2zSXA@mail.gmail.com/

-- 
Michal Hocko
SUSE Labs
