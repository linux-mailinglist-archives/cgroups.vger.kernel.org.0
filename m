Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A55031F02C
	for <lists+cgroups@lfdr.de>; Thu, 18 Feb 2021 20:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbhBRTmD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 18 Feb 2021 14:42:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:45144 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233578AbhBRTOX (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 18 Feb 2021 14:14:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613675615; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=coKwHmBVYiHs8qdOkruTnwD9yAp//Y7kxMvu4I7zdqY=;
        b=RrzzDoFBHuoESeKLGhbYtUZ76hX2PS4zXWM0yFtA3ev3pd8bUmOqRWsEsvLz8Mp9+C2vOZ
        xuTMlVt1KK6DqHqEnjE6lgIUxNCAJI/xTnFu/bH3lYcLO5H2mpP9smtIWKCM6xxRS1+HiW
        NVPdOvXpq/zekqTWu5tRnseE0G3iFtE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BF44EAED2;
        Thu, 18 Feb 2021 19:13:35 +0000 (UTC)
Date:   Thu, 18 Feb 2021 20:13:34 +0100
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
Message-ID: <YC68Xo9+R2msn/ul@dhcp22.suse.cz>
References: <cover.1613584277.git.tim.c.chen@linux.intel.com>
 <8d35206601ccf0e1fe021d24405b2a0c2f4e052f.1613584277.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d35206601ccf0e1fe021d24405b2a0c2f4e052f.1613584277.git.tim.c.chen@linux.intel.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 17-02-21 12:41:34, Tim Chen wrote:
> During soft limit memory reclaim, we will temporarily remove the target
> mem cgroup from the cgroup soft limit tree.  We then perform memory
> reclaim, update the memory usage excess count and re-insert the mem
> cgroup back into the mem cgroup soft limit tree according to the new
> memory usage excess count.
> 
> However, when memory reclaim failed for a maximum number of attempts
> and we bail out of the reclaim loop, we forgot to put the target mem
> cgroup chosen for next reclaim back to the soft limit tree. This prevented
> pages in the mem cgroup from being reclaimed in the future even though
> the mem cgroup exceeded its soft limit.  Fix the logic and put the mem
> cgroup back on the tree when page reclaim failed for the mem cgroup.
> 
> Reviewed-by: Ying Huang <ying.huang@intel.com>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>

Fixes: 4e41695356fb ("memory controller: soft limit reclaim on contention")
Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!
> ---
>  mm/memcontrol.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index ed5cc78a8dbf..a51bf90732cb 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3505,8 +3505,12 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
>  			loop > MEM_CGROUP_MAX_SOFT_LIMIT_RECLAIM_LOOPS))
>  			break;
>  	} while (!nr_reclaimed);
> -	if (next_mz)
> +	if (next_mz) {
> +		spin_lock_irq(&mctz->lock);
> +		__mem_cgroup_insert_exceeded(next_mz, mctz, excess);
> +		spin_unlock_irq(&mctz->lock);
>  		css_put(&next_mz->memcg->css);
> +	}
>  	return nr_reclaimed;
>  }
>  
> -- 
> 2.20.1

-- 
Michal Hocko
SUSE Labs
