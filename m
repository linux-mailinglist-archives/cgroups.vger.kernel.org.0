Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A73ED789A4
	for <lists+cgroups@lfdr.de>; Mon, 29 Jul 2019 12:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbfG2KdJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Jul 2019 06:33:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:54816 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726358AbfG2KdJ (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 29 Jul 2019 06:33:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BFE98AE1C;
        Mon, 29 Jul 2019 10:33:07 +0000 (UTC)
Date:   Mon, 29 Jul 2019 12:33:07 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH RFC] mm/memcontrol: reclaim severe usage over high limit
 in get_user_pages loop
Message-ID: <20190729103307.GG9330@dhcp22.suse.cz>
References: <156431697805.3170.6377599347542228221.stgit@buzz>
 <20190729091738.GF9330@dhcp22.suse.cz>
 <3d6fc779-2081-ba4b-22cf-be701d617bb4@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d6fc779-2081-ba4b-22cf-be701d617bb4@yandex-team.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 29-07-19 12:40:29, Konstantin Khlebnikov wrote:
> On 29.07.2019 12:17, Michal Hocko wrote:
> > On Sun 28-07-19 15:29:38, Konstantin Khlebnikov wrote:
> > > High memory limit in memory cgroup allows to batch memory reclaiming and
> > > defer it until returning into userland. This moves it out of any locks.
> > > 
> > > Fixed gap between high and max limit works pretty well (we are using
> > > 64 * NR_CPUS pages) except cases when one syscall allocates tons of
> > > memory. This affects all other tasks in cgroup because they might hit
> > > max memory limit in unhandy places and\or under hot locks.
> > > 
> > > For example mmap with MAP_POPULATE or MAP_LOCKED might allocate a lot
> > > of pages and push memory cgroup usage far ahead high memory limit.
> > > 
> > > This patch uses halfway between high and max limits as threshold and
> > > in this case starts memory reclaiming if mem_cgroup_handle_over_high()
> > > called with argument only_severe = true, otherwise reclaim is deferred
> > > till returning into userland. If high limits isn't set nothing changes.
> > > 
> > > Now long running get_user_pages will periodically reclaim cgroup memory.
> > > Other possible targets are generic file read/write iter loops.
> > 
> > I do see how gup can lead to a large high limit excess, but could you be
> > more specific why is that a problem? We should be reclaiming the similar
> > number of pages cumulatively.
> > 
> 
> Large gup might push usage close to limit and keep it here for a some time.
> As a result concurrent allocations will enter direct reclaim right at
> charging much more frequently.

Yes, this is indeed prossible. On the other hand even the reclaim from
the charge path doesn't really prevent from that happening because the
context might get preempted or blocked on locks. So I guess we need a
more detailed information of an actual world visible problem here.
 
> Right now deferred recalaim after passing high limit works like distributed
> memcg kswapd which reclaims memory in "background" and prevents completely
> synchronous direct reclaim.
> 
> Maybe somebody have any plans for real kswapd for memcg?

I am not aware of that. The primary problem back then was that we simply
cannot have a kernel thread per each memcg because that doesn't scale.
Using kthreads and a dynamic pool of threads tends to be quite tricky -
e.g. a proper accounting, scaling again.
 
> I've put mem_cgroup_handle_over_high in gup next to cond_resched() and
> later that gave me idea that this is good place for running any
> deferred works, like bottom half for tasks. Right now this happens
> only at switching into userspace.

I am not against pushing high memory reclaim into the charge path in
principle. I just want to hear how big of a problem this really is in
practice. If this is mostly a theoretical problem that might hit then I
would rather stick with the existing code though.

-- 
Michal Hocko
SUSE Labs
