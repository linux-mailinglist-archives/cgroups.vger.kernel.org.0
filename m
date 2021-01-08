Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9760B2EF2FB
	for <lists+cgroups@lfdr.de>; Fri,  8 Jan 2021 14:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbhAHNZC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 8 Jan 2021 08:25:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:53596 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbhAHNZC (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 8 Jan 2021 08:25:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610112255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kWajWUazhZoEFj2YC1/JZm5JagKSGgfHEeGYCRfJurE=;
        b=gs/586IHJv6CfKBEQW6uznolaSjSS7pyS5nCShXJcGLVgCkBmUTYiKM35HqVN6LdBhjcdl
        GSiu4KPjhiEhosFZ+Q5uNSk690PF1Oee5aOvtgSFQcJW6Ls9/9qCRSvcUHoRLguIVpVh2C
        Na5hi5eVTTxjyqSzml7eMuDkWWNgBtc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 45D47AD11;
        Fri,  8 Jan 2021 13:24:15 +0000 (UTC)
Date:   Fri, 8 Jan 2021 14:24:14 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: memcg: add swapcache stat for memcg v2
Message-ID: <20210108132414.GD13207@dhcp22.suse.cz>
References: <20210101023955.250965-1-shakeelb@google.com>
 <20210106145349.GN13207@dhcp22.suse.cz>
 <CALvZod6Lv3gWmWRPP7jAaw4YCQPyPXcxqXTO3Vp6YVZ6AcEH4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod6Lv3gWmWRPP7jAaw4YCQPyPXcxqXTO3Vp6YVZ6AcEH4w@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 06-01-21 08:42:39, Shakeel Butt wrote:
> On Wed, Jan 6, 2021 at 6:53 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Thu 31-12-20 18:39:55, Shakeel Butt wrote:
> > > This patch adds swapcache stat for the cgroup v2. The swapcache
> > > represents the memory that is accounted against both the memory and the
> > > swap limit of the cgroup. The main motivation behind exposing the
> > > swapcache stat is for enabling users to gracefully migrate from cgroup
> > > v1's memsw counter to cgroup v2's memory and swap counters.
> > >
> > > Cgroup v1's memsw limit allows users to limit the memory+swap usage of a
> > > workload but without control on the exact proportion of memory and swap.
> > > Cgroup v2 provides separate limits for memory and swap which enables
> > > more control on the exact usage of memory and swap individually for the
> > > workload.
> > >
> > > With some little subtleties, the v1's memsw limit can be switched with
> > > the sum of the v2's memory and swap limits. However the alternative for
> > > memsw usage is not yet available in cgroup v2. Exposing per-cgroup
> > > swapcache stat enables that alternative. Adding the memory usage and
> > > swap usage and subtracting the swapcache will approximate the memsw
> > > usage. This will help in the transparent migration of the workloads
> > > depending on memsw usage and limit to v2' memory and swap counters.
> >
> > Could you expand a bit more on why memsw usage is important even in
> > cgroup v2 land? How are you going to use the approximated value?
> >
> 
> Two main benefits. First, it hides the underlying system's swap setup
> from the applications. Applications with multiple instances running in
> a datacenter with heterogeneous systems (some have swap and some
> don't) will keep seeing a consistent view of their usage.
> 
> Second, most of the applications (at least in our prod) are not really
> interested in two separate memory and swap usage metrics. A single
> usage metric is more simple to use and reason about for these
> applications.

OK fair enough. Thanks for the clarification.

As I've said I do not see any problem with exporting the counter.

Acked-by: Michal Hocko <mhocko@suse.com>

-- 
Michal Hocko
SUSE Labs
