Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1AE29F0E2
	for <lists+cgroups@lfdr.de>; Thu, 29 Oct 2020 17:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725841AbgJ2QNk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Oct 2020 12:13:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:34896 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725847AbgJ2QNk (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 29 Oct 2020 12:13:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603988018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nxefRSiqTvIh1X46sbXjSTVE8f5f0KcaWYrFYUA7Jvk=;
        b=meEFnLQtGDhNNwqDYFrHnB4+mqNmRj2I7FO4urV6zIV7LYoCbnCHFJ76yXFcBa9g2LWkNA
        EflhUj/SfziFb7HAMiGgGDdPY0faX/PtGSXJgLDIM2HCXOQqHDqIXh0NMPDIqga+yNG8f6
        znuNzjtPxaHM3+YbSVwN0rQLszgJtqs=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3EE88ACA0;
        Thu, 29 Oct 2020 16:13:38 +0000 (UTC)
Date:   Thu, 29 Oct 2020 17:13:36 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Chris Down <chris@chrisdown.name>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>, esyr@redhat.com,
        Suren Baghdasaryan <surenb@google.com>, areber@redhat.com,
        Marco Elver <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Subject: Re: [PATCH v2] mm: memcontrol: Simplify the mem_cgroup_page_lruvec
Message-ID: <20201029161336.GH17500@dhcp22.suse.cz>
References: <20201028035013.99711-1-songmuchun@bytedance.com>
 <20201028035013.99711-4-songmuchun@bytedance.com>
 <20201029090806.GD17500@dhcp22.suse.cz>
 <CALvZod68-f-_1pevYbegzXk_b0L=XbCJkM5KqcRF9TuLiz3_ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod68-f-_1pevYbegzXk_b0L=XbCJkM5KqcRF9TuLiz3_ww@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 29-10-20 09:01:37, Shakeel Butt wrote:
> On Thu, Oct 29, 2020 at 2:08 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Wed 28-10-20 11:50:13, Muchun Song wrote:
> > [...]
> > > -struct lruvec *mem_cgroup_page_lruvec(struct page *page, struct pglist_data *pgdat)
> > > +static struct lruvec *
> > > +__mem_cgroup_node_lruvec(struct mem_cgroup *memcg, struct pglist_data *pgdat,
> > > +                      int nid)
> >
> > I thought I have made it clear that this is not a good approach. Please
> > do not repost new version without that being addressed. If there are any
> > questions then feel free to ask for details.
> 
> You can get nid from pgdat (pgdat->node_id) and also pgdat from nid
> (NODE_DATA(nid)), so, __mem_cgroup_node_lruvec() only need one of them
> as parameter.

Exactly what I've said in the previous version review. I suspect that
the issue is that mem_cgroup_page_nodeinfo (based on page's node_id)
and the given pgdat can mismatch in the existing code but that shouldn't
be a real problem because the mismatch can only happen for lruvec->pgdat
== NULL unless I am missing something.

-- 
Michal Hocko
SUSE Labs
