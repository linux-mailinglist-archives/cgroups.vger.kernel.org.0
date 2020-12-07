Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3687F2D146F
	for <lists+cgroups@lfdr.de>; Mon,  7 Dec 2020 16:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgLGPJt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 7 Dec 2020 10:09:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:33786 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgLGPJt (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 7 Dec 2020 10:09:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607353743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7RsLkVdlKW2JLj2RfGQG78NhVgvfEuANtMbySI98QQQ=;
        b=FpL5im6xdBPNTwI0VJejyVkNHligc44w05ikwoMOxpq6LgNg3/4lSSlUjejunNBLXOIRIn
        F0HGr8LRMJYqby5qTOJhh9/p3FqCfVQA74WaKBYtiB99a/gVZp53Wd7MMzQkD7NLJ38uNB
        b1W+ClaJOZdhrEoN/UrEnHLAZTf4Kcw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CEB01ABE9;
        Mon,  7 Dec 2020 15:09:02 +0000 (UTC)
Date:   Mon, 7 Dec 2020 16:09:01 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        alexander.h.duyck@linux.intel.com,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>, richard.weiyang@gmail.com,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [External] Re: [PATCH] mm: memcontrol: optimize per-lruvec stats
 counter memory usage
Message-ID: <20201207150847.GM25569@dhcp22.suse.cz>
References: <20201206085639.12627-1-songmuchun@bytedance.com>
 <20201207123605.GH25569@dhcp22.suse.cz>
 <CAMZfGtUhG26cTgbSmg4g+rwOtEFhgbE3QXPR_LUf3FS-s=YbOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtUhG26cTgbSmg4g+rwOtEFhgbE3QXPR_LUf3FS-s=YbOA@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 07-12-20 20:56:58, Muchun Song wrote:
> On Mon, Dec 7, 2020 at 8:36 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Sun 06-12-20 16:56:39, Muchun Song wrote:
> > > The vmstat threshold is 32 (MEMCG_CHARGE_BATCH), so the type of s32
> > > of lruvec_stat_cpu is enough. And introduce struct per_cpu_lruvec_stat
> > > to optimize memory usage.
> >
> > How much savings are we talking about here? I am not deeply familiar
> > with the pcp allocator but can it compact smaller data types much
> > better?
> 
> It is a percpu struct. The size of struct lruvec_stat is 304(tested on the
> linux-5.5). So we can save 304 / 2 * nproc bytes per memcg where nproc
> is the number of the possible CPU. If we have n memory cgroup in the
> system. Finally, we can save (152 * nproc * n) bytes. In some configurations,
> nproc here may be 512. And if we have a lot of dying cgroup. The n can be
> 100, 000 (I once saw it on my server).

This should be part of the changelog. In general, any optimization
should come with some numbers showing the effect of the optimization.

As I've said I am not really familiar with pcp internals and how
efficiently it can organize smaller objects. Maybe it can really half
the memory consumption.

My only concern is that using smaller types for these counters can fire
back later on because we have an inderect dependency between the batch
size and the data type.  In general I do not really object to the patch
as long as savings are non trivial so that we are not creating a
potential trap for something that is practically miniscule
microptimization.
-- 
Michal Hocko
SUSE Labs
