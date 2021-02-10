Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D79C93162CD
	for <lists+cgroups@lfdr.de>; Wed, 10 Feb 2021 10:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbhBJJyH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 10 Feb 2021 04:54:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:48674 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229985AbhBJJvy (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 10 Feb 2021 04:51:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612950667; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CAFzAyZy/KFZTsu+ARXaCj+Xnf0VYpa/fyIfFuwi9+E=;
        b=YUq56y6mtYH/Zv/QM5JMteooatovb8ZVwTA95QkzipN8TrrweOCA2kd/E4vxFBA8rRv/TC
        KacdaHK0HaJxMz0S1v9EbDcIGgfr77mN3pQpz3D4aIvttYIWmFZX86ZrhHqQzGuaRftQz/
        +rE8Is9r5TMyPepqPzAgq8PzSP3lPw0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9C0F3AF7F;
        Wed, 10 Feb 2021 09:51:06 +0000 (UTC)
Date:   Wed, 10 Feb 2021 10:51:04 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ying Huang <ying.huang@intel.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm: Force update of mem cgroup soft limit tree on
 usage excess
Message-ID: <YCOsiM5towVQwmjy@dhcp22.suse.cz>
References: <cover.1612902157.git.tim.c.chen@linux.intel.com>
 <90ef1dbc8ba6112794a3d09ecfed73f385f08eb7.1612902157.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90ef1dbc8ba6112794a3d09ecfed73f385f08eb7.1612902157.git.tim.c.chen@linux.intel.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 09-02-21 12:29:46, Tim Chen wrote:
> To rate limit updates to the mem cgroup soft limit tree, we only perform
> updates every SOFTLIMIT_EVENTS_TARGET (defined as 1024) memory events.
> 
> However, this sampling based updates may miss a critical update: i.e. when
> the mem cgroup first exceeded its limit but it was not on the soft limit tree.
> It should be on the tree at that point so it could be subjected to soft
> limit page reclaim. If the mem cgroup had few memory events compared with
> other mem cgroups, we may not update it and place in on the mem cgroup
> soft limit tree for many memory events.  And this mem cgroup excess
> usage could creep up and the mem cgroup could be hidden from the soft
> limit page reclaim for a long time.

Have you observed this happening in the real life? I do agree that the
threshold based updates of the tree is not ideal but the whole soft
reclaim code is far from optimal. So why do we care only now? The
feature is essentially dead and fine tuning it sounds like a step back
to me.

> Fix this issue by forcing an update to the mem cgroup soft limit tree if a
> mem cgroup has exceeded its memory soft limit but it is not on the mem
> cgroup soft limit tree.
> 
> Reviewed-by: Ying Huang <ying.huang@intel.com>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
>  mm/memcontrol.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index a51bf90732cb..d72449eeb85a 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -985,15 +985,22 @@ static bool mem_cgroup_event_ratelimit(struct mem_cgroup *memcg,
>   */
>  static void memcg_check_events(struct mem_cgroup *memcg, struct page *page)
>  {
> +	struct mem_cgroup_per_node *mz;
> +	bool force_update = false;
> +
> +	mz = mem_cgroup_nodeinfo(memcg, page_to_nid(page));
> +	if (mz && !mz->on_tree && soft_limit_excess(mz->memcg) > 0)
> +		force_update = true;
> +
>  	/* threshold event is triggered in finer grain than soft limit */
> -	if (unlikely(mem_cgroup_event_ratelimit(memcg,
> +	if (unlikely((force_update) || mem_cgroup_event_ratelimit(memcg,
>  						MEM_CGROUP_TARGET_THRESH))) {
>  		bool do_softlimit;
>  
>  		do_softlimit = mem_cgroup_event_ratelimit(memcg,
>  						MEM_CGROUP_TARGET_SOFTLIMIT);
>  		mem_cgroup_threshold(memcg);
> -		if (unlikely(do_softlimit))
> +		if (unlikely((force_update) || do_softlimit))
>  			mem_cgroup_update_tree(memcg, page);
>  	}
>  }
> -- 
> 2.20.1

-- 
Michal Hocko
SUSE Labs
