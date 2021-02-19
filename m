Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71D0131F66C
	for <lists+cgroups@lfdr.de>; Fri, 19 Feb 2021 10:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbhBSJSC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 19 Feb 2021 04:18:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:49700 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229527AbhBSJQ5 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 19 Feb 2021 04:16:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613726169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yYsAIWuqG5g0PtLS3vC3gPQPYDZPxGBMvNHr6Q07to4=;
        b=nlWS+saaxoksajbabAIYBwVBt+uZsQwz6nCOYG34Y1s6kCiPBQcqrzCDyycIUsjJ5+4hfk
        bDqBQs0nNzI8lq6UX+lrfdDaZdW5D4rc2SO5ABAN/7CpJ6Y6Y5+yItAIevIcXgkXRqIUHP
        lPdZSsse/w5ZJPF/PUShm0iC9ip8ODI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4A49EACF6;
        Fri, 19 Feb 2021 09:16:09 +0000 (UTC)
Date:   Fri, 19 Feb 2021 10:16:08 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ying Huang <ying.huang@intel.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] mm: Fix missing mem cgroup soft limit tree updates
Message-ID: <YC+B2KvJVSgfVDTe@dhcp22.suse.cz>
References: <cover.1613584277.git.tim.c.chen@linux.intel.com>
 <e269f5df3af1157232b01a9b0dae3edf4880d786.1613584277.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e269f5df3af1157232b01a9b0dae3edf4880d786.1613584277.git.tim.c.chen@linux.intel.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 17-02-21 12:41:36, Tim Chen wrote:
> On a per node basis, the mem cgroup soft limit tree on each node tracks
> how much a cgroup has exceeded its soft limit memory limit and sorts
> the cgroup by its excess usage.  On page release, the trees are not
> updated right away, until we have gathered a batch of pages belonging to
> the same cgroup. This reduces the frequency of updating the soft limit tree
> and locking of the tree and associated cgroup.
> 
> However, the batch of pages could contain pages from multiple nodes but
> only the soft limit tree from one node would get updated.  Change the
> logic so that we update the tree in batch of pages, with each batch of
> pages all in the same mem cgroup and memory node.  An update is issued for
> the batch of pages of a node collected till now whenever we encounter
> a page belonging to a different node.  Note that this batching for
> the same node logic is only relevant for v1 cgroup that has a memory
> soft limit.

Let me paste the discussion related to this patch from other reply:
> >> For patch 3 regarding the uncharge_batch, it
> >> is more of an observation that we should uncharge in batch of same node
> >> and not prompted by actual workload.
> >> Thinking more about this, the worst that could happen
> >> is we could have some entries in the soft limit tree that overestimate
> >> the memory used.  The worst that could happen is a soft page reclaim
> >> on that cgroup.  The overhead from extra memcg event update could
> >> be more than a soft page reclaim pass.  So let's drop patch 3
> >> for now.
> >
> > I would still prefer to handle that in the soft limit reclaim path and
> > check each memcg for the soft limit reclaim excess before the reclaim.
> >
> 
> Something like this?
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 8bddee75f5cb..b50cae3b2a1a 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3472,6 +3472,14 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
>                 if (!mz)
>                         break;
> 
> +               /*
> +                * Soft limit tree is updated based on memcg events sampling.
> +                * We could have missed some updates on page uncharge and
> +                * the cgroup is below soft limit.  Skip useless soft reclaim.
> +                */
> +               if (!soft_limit_excess(mz->memcg))
> +                       continue;
> +
>                 nr_scanned = 0;
>                 reclaimed = mem_cgroup_soft_reclaim(mz->memcg, pgdat,

Yes I meant something like this but then I have looked more closely and
this shouldn't be needed afterall. __mem_cgroup_largest_soft_limit_node
already does all the work
        if (!soft_limit_excess(mz->memcg) ||
            !css_tryget(&mz->memcg->css))
                goto retry;
so this shouldn't really happen.
-- 
Michal Hocko
SUSE Labs
