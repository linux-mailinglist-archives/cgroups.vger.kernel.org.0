Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 087FF29C329
	for <lists+cgroups@lfdr.de>; Tue, 27 Oct 2020 18:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1821435AbgJ0Rnq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Oct 2020 13:43:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:45002 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437229AbgJ0Obs (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 27 Oct 2020 10:31:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603809106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uuw37CmdGgaUF2rTsLXZIxdwBi56keqYJAASysIsH4U=;
        b=QScZCtVJ88Ft10nSiaAM31z9hd30tvg7sm0uLaSV0xvsBBwNiIAiXthx+uw5HdJDHCO2gL
        /LScYs8N/+/Y/g1sEzi3bViteDVWpDr9u5cLVN927E+Y2dug78ERP+RSXwlnzu8X2JnfZ0
        dPK7a+yMSWEJqpmUm9TGElUUj2fhHV4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1F098AC1F;
        Tue, 27 Oct 2020 14:31:46 +0000 (UTC)
Date:   Tue, 27 Oct 2020 15:31:41 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, laoar.shao@gmail.com,
        Chris Down <chris@chrisdown.name>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>, esyr@redhat.com,
        Suren Baghdasaryan <surenb@google.com>, areber@redhat.com,
        Marco Elver <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [External] Re: [PATCH 5/5] mm: memcontrol: Simplify the
 mem_cgroup_page_lruvec
Message-ID: <20201027143141.GX20500@dhcp22.suse.cz>
References: <20201027080256.76497-1-songmuchun@bytedance.com>
 <20201027080256.76497-6-songmuchun@bytedance.com>
 <20201027133639.GT20500@dhcp22.suse.cz>
 <CAMZfGtUDguQkO0nF8Vt5qUVmmu4rCQcXx4nOhqUBSLnMYs2_BA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtUDguQkO0nF8Vt5qUVmmu4rCQcXx4nOhqUBSLnMYs2_BA@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 27-10-20 22:15:16, Muchun Song wrote:
> On Tue, Oct 27, 2020 at 9:36 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Tue 27-10-20 16:02:56, Muchun Song wrote:
> > > We can reuse the code of mem_cgroup_lruvec() to simplify the code
> > > of the mem_cgroup_page_lruvec().
> >
> > yes, removing the code duplication is reasonable. But ...
> >
> > >
> > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > ---
> > >  include/linux/memcontrol.h | 44 +++++++++++++++++++++++++++-----------
> > >  mm/memcontrol.c            | 40 ----------------------------------
> > >  2 files changed, 32 insertions(+), 52 deletions(-)
> > >
> > > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > > index 95807bf6be64..5e8480e54cd8 100644
> > > --- a/include/linux/memcontrol.h
> > > +++ b/include/linux/memcontrol.h
> > > @@ -451,16 +451,9 @@ mem_cgroup_nodeinfo(struct mem_cgroup *memcg, int nid)
> > >       return memcg->nodeinfo[nid];
> > >  }
> > >
> > > -/**
> > > - * mem_cgroup_lruvec - get the lru list vector for a memcg & node
> > > - * @memcg: memcg of the wanted lruvec
> > > - *
> > > - * Returns the lru list vector holding pages for a given @memcg &
> > > - * @node combination. This can be the node lruvec, if the memory
> > > - * controller is disabled.
> > > - */
> > > -static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
> > > -                                            struct pglist_data *pgdat)
> > > +static inline struct lruvec *mem_cgroup_node_lruvec(struct mem_cgroup *memcg,
> > > +                                                 struct pglist_data *pgdat,
> > > +                                                 int nid)
> >
> > This is just wrong interface. Either take nid or pgdat. You do not want
> > both because that just begs for wrong usage.
> 
> If we want to avoid abuse of mem_cgroup_node_lruvec. We can move
> those functions to the memcontrol.c. And add the "static" attribute to the
> mem_cgroup_node_lruvec. Just export mem_cgroup_lruvec and
> mem_cgroup_page_lruvec. Is this OK?

Sorry, I was probably not clear enough. I am not against the function
per se. I just do not think we want to make it trickier to use than
necessary. That means either use pgdat or nid argument. Not both because
they should always be in sync and you can trivially get from one to the
other and vice versa.
-- 
Michal Hocko
SUSE Labs
