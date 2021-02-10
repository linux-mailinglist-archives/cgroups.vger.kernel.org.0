Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6E823162A8
	for <lists+cgroups@lfdr.de>; Wed, 10 Feb 2021 10:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbhBJJtp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 10 Feb 2021 04:49:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:46478 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229610AbhBJJsh (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 10 Feb 2021 04:48:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612950468; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fdOKlGdBQ+hhHPE98TkFop+2UQxW0u+WMNNhnyafX9Q=;
        b=TH4zS6eBWoevbm4jAsK0+oZMMY2MFI6CHMoLEJY2Jj0ho1cPXvNBVdNcmpQz+y80cOz2pb
        lT5RtH88wV0Q+o3pZSJjNtoCvVw7QPP5KzSk4hyJZqBNGWhjiGGgqEoySHGkUceUMYIZal
        b3CKioh8b9ixkAWkmkaSPdNs/EKGI9A=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3FC32AD57;
        Wed, 10 Feb 2021 09:47:48 +0000 (UTC)
Date:   Wed, 10 Feb 2021 10:47:44 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ying Huang <ying.huang@intel.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm: Fix dropped memcg from mem cgroup soft limit tree
Message-ID: <YCOrwHvktsN5Kuc+@dhcp22.suse.cz>
References: <cover.1612902157.git.tim.c.chen@linux.intel.com>
 <d50e3bb513845d1f7816b94733576ce6f798682a.1612902157.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d50e3bb513845d1f7816b94733576ce6f798682a.1612902157.git.tim.c.chen@linux.intel.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 09-02-21 12:29:45, Tim Chen wrote:
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

It seems this goes all the way to when it has been introduced by 
4e41695356fb ("memory controller: soft limit reclaim on contention").
Please add a Fixes tag pointing to the above one. While this looks like
a rare event to happen because there should be some reclaimable memory
usually.

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
