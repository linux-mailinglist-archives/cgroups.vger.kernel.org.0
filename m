Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 475E233096E
	for <lists+cgroups@lfdr.de>; Mon,  8 Mar 2021 09:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhCHIed (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 8 Mar 2021 03:34:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:44356 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230095AbhCHIe2 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 8 Mar 2021 03:34:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615192466; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TxNbQKNdS8Bk5nTMx7iGX1d+YD0DAigE/GiZ5gzAA50=;
        b=ZZ1a1HjC/nl8Om4mducww6VRiweUKlyk0AOG02UpuuhFQ9flgmUuu2fbSXN5LH08nRxxKO
        tTHr2mRvYFWxQJldGJ07bAPb+pWXp2p1YhZHxCaZL+bFbOl4c9jdprGg3zF6hzEoILQDqN
        Hcn1CbQo/4NBBgG4C9KubCoKFiBQVo0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 47679AC0C;
        Mon,  8 Mar 2021 08:34:26 +0000 (UTC)
Date:   Mon, 8 Mar 2021 09:34:17 +0100
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
Message-ID: <YEXhfJhmXrLuxGWB@dhcp22.suse.cz>
References: <cover.1613584277.git.tim.c.chen@linux.intel.com>
 <8d35206601ccf0e1fe021d24405b2a0c2f4e052f.1613584277.git.tim.c.chen@linux.intel.com>
 <YC68Xo9+R2msn/ul@dhcp22.suse.cz>
 <72cb8618-73af-ce08-d5d5-30cab30755a3@linux.intel.com>
 <YEH1xF8xm9MCsQ+q@dhcp22.suse.cz>
 <087bed0e-5b5f-0e25-c247-7fcb34de1513@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <087bed0e-5b5f-0e25-c247-7fcb34de1513@linux.intel.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 05-03-21 11:07:59, Tim Chen wrote:
> 
> 
> On 3/5/21 1:11 AM, Michal Hocko wrote:
> > On Thu 04-03-21 09:35:08, Tim Chen wrote:
> >>
> >>
> >> On 2/18/21 11:13 AM, Michal Hocko wrote:
> >>
> >>>
> >>> Fixes: 4e41695356fb ("memory controller: soft limit reclaim on contention")
> >>> Acked-by: Michal Hocko <mhocko@suse.com>
> >>>
> >>> Thanks!
> >>>> ---
> >>>>  mm/memcontrol.c | 6 +++++-
> >>>>  1 file changed, 5 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> >>>> index ed5cc78a8dbf..a51bf90732cb 100644
> >>>> --- a/mm/memcontrol.c
> >>>> +++ b/mm/memcontrol.c
> >>>> @@ -3505,8 +3505,12 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
> >>>>  			loop > MEM_CGROUP_MAX_SOFT_LIMIT_RECLAIM_LOOPS))
> >>>>  			break;
> >>>>  	} while (!nr_reclaimed);
> >>>> -	if (next_mz)
> >>>> +	if (next_mz) {
> >>>> +		spin_lock_irq(&mctz->lock);
> >>>> +		__mem_cgroup_insert_exceeded(next_mz, mctz, excess);
> >>>> +		spin_unlock_irq(&mctz->lock);
> >>>>  		css_put(&next_mz->memcg->css);
> >>>> +	}
> >>>>  	return nr_reclaimed;
> >>>>  }
> >>>>  
> >>>> -- 
> >>>> 2.20.1
> >>>
> >>
> >> Mel,
> >>
> >> Reviewing this patch a bit more, I realize that there is a chance that the removed
> >> next_mz could be inserted back to the tree from a memcg_check_events
> >> that happen in between.  So we need to make sure that the next_mz
> >> is indeed off the tree and update the excess value before adding it
> >> back.  Update the patch to the patch below.
> > 
> > This scenario is certainly possible but it shouldn't really matter much
> > as __mem_cgroup_insert_exceeded bails out when the node is on the tree
> > already.
> > 
> 
> Makes sense. We should still update the excess value with
> 
> +		excess = soft_limit_excess(next_mz->memcg);
> +		__mem_cgroup_insert_exceeded(next_mz, mctz, excess);
> 
> before doing insertion.  The excess value was recorded from previous
> mz in the loop and needs to be updated to that of next_mz.

Yes. Sorry, I have missed that part previously.
-- 
Michal Hocko
SUSE Labs
