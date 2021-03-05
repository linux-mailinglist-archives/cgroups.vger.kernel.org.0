Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5484832E46C
	for <lists+cgroups@lfdr.de>; Fri,  5 Mar 2021 10:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbhCEJMF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 5 Mar 2021 04:12:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:47222 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229469AbhCEJLe (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 5 Mar 2021 04:11:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614935493; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EzbUJaQzdHyWQWYArhmveTTGFRarGR/POWGz43IcYds=;
        b=WRAaCcQBvs+ROf3f9UYV/D5gQd6QjIR+GA8FQRtJa9yLj8pNsiAOX+ib91QiwXx0hYx4RR
        mn/4s+tYkhD/511Jt70xhn81DN9x2VKzKHKpFTYjldQOsPKUbcNBryoZvo3dIj3w0LXlXm
        RMeKmKWNxJzpK7WkhmjVLRsp90kFNSs=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DC864AF24;
        Fri,  5 Mar 2021 09:11:32 +0000 (UTC)
Date:   Fri, 5 Mar 2021 10:11:32 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ying Huang <ying.huang@intel.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mm: Fix dropped memcg from mem cgroup soft limit
 tree
Message-ID: <YEH1xF8xm9MCsQ+q@dhcp22.suse.cz>
References: <cover.1613584277.git.tim.c.chen@linux.intel.com>
 <8d35206601ccf0e1fe021d24405b2a0c2f4e052f.1613584277.git.tim.c.chen@linux.intel.com>
 <YC68Xo9+R2msn/ul@dhcp22.suse.cz>
 <72cb8618-73af-ce08-d5d5-30cab30755a3@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72cb8618-73af-ce08-d5d5-30cab30755a3@linux.intel.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 04-03-21 09:35:08, Tim Chen wrote:
> 
> 
> On 2/18/21 11:13 AM, Michal Hocko wrote:
> 
> > 
> > Fixes: 4e41695356fb ("memory controller: soft limit reclaim on contention")
> > Acked-by: Michal Hocko <mhocko@suse.com>
> > 
> > Thanks!
> >> ---
> >>  mm/memcontrol.c | 6 +++++-
> >>  1 file changed, 5 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> >> index ed5cc78a8dbf..a51bf90732cb 100644
> >> --- a/mm/memcontrol.c
> >> +++ b/mm/memcontrol.c
> >> @@ -3505,8 +3505,12 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
> >>  			loop > MEM_CGROUP_MAX_SOFT_LIMIT_RECLAIM_LOOPS))
> >>  			break;
> >>  	} while (!nr_reclaimed);
> >> -	if (next_mz)
> >> +	if (next_mz) {
> >> +		spin_lock_irq(&mctz->lock);
> >> +		__mem_cgroup_insert_exceeded(next_mz, mctz, excess);
> >> +		spin_unlock_irq(&mctz->lock);
> >>  		css_put(&next_mz->memcg->css);
> >> +	}
> >>  	return nr_reclaimed;
> >>  }
> >>  
> >> -- 
> >> 2.20.1
> > 
> 
> Mel,
> 
> Reviewing this patch a bit more, I realize that there is a chance that the removed
> next_mz could be inserted back to the tree from a memcg_check_events
> that happen in between.  So we need to make sure that the next_mz
> is indeed off the tree and update the excess value before adding it
> back.  Update the patch to the patch below.

This scenario is certainly possible but it shouldn't really matter much
as __mem_cgroup_insert_exceeded bails out when the node is on the tree
already.
-- 
Michal Hocko
SUSE Labs
