Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C86131069A
	for <lists+cgroups@lfdr.de>; Fri,  5 Feb 2021 09:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbhBEIZg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 5 Feb 2021 03:25:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:60396 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229466AbhBEIZb (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 5 Feb 2021 03:25:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612513484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SUs0oFDd/E1bOdAXdbbVbAD1+nLxACMkGmS9iKg9WAk=;
        b=mYo7dKgPs68rijoKaJCFctzUwf0uAHx+85FPPOwF+ebXspxPeNxvYFF/pdHRvSmQuSPHNT
        jz99FRwyKrE7IcQZDfN2cw5zZhEPMD/STL2B/2Lno6831+b8yqHp65WWiH9E65SESmId5f
        YD8L1gk+FOq6rrOBa1L9V1k/BWICpwM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A8BD4AE3F;
        Fri,  5 Feb 2021 08:24:44 +0000 (UTC)
Date:   Fri, 5 Feb 2021 09:24:43 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol: fix missing wakeup oom task
Message-ID: <YB0Ay+epP/hnFmDS@dhcp22.suse.cz>
References: <20210205062310.74268-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205062310.74268-1-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 05-02-21 14:23:10, Muchun Song wrote:
> We call memcg_oom_recover() in the uncharge_batch() to wakeup OOM task
> when page uncharged, but for the slab pages, we do not do this when page
> uncharged.

How does the patch deal with this?

> When we drain per cpu stock, we also should do this.

Can we have anything the per-cpu stock while entering the OOM path. IIRC
we do drain all cpus before entering oom path.

> The memcg_oom_recover() is small, so make it inline.

Does this lead to any code generation improvements? I would expect
compiler to be clever enough to inline static functions if that pays
off. If yes make this a patch on its own.

> And the parameter
> of memcg cannot be NULL, so remove the check.

2bd9bb206b338 has introduced the check without any explanation
whatsoever. I indeed do not see any potential path to provide a NULL
memcg here. This is an internal function so the check is unnecessary
indeed. Please make it a patch on its own.

> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/memcontrol.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 8c035846c7a4..8569f4dbea2a 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1925,7 +1925,7 @@ static int memcg_oom_wake_function(wait_queue_entry_t *wait,
>  	return autoremove_wake_function(wait, mode, sync, arg);
>  }
>  
> -static void memcg_oom_recover(struct mem_cgroup *memcg)
> +static inline void memcg_oom_recover(struct mem_cgroup *memcg)
>  {
>  	/*
>  	 * For the following lockless ->under_oom test, the only required
> @@ -1935,7 +1935,7 @@ static void memcg_oom_recover(struct mem_cgroup *memcg)
>  	 * achieved by invoking mem_cgroup_mark_under_oom() before
>  	 * triggering notification.
>  	 */
> -	if (memcg && memcg->under_oom)
> +	if (memcg->under_oom)
>  		__wake_up(&memcg_oom_waitq, TASK_NORMAL, 0, memcg);
>  }
>  
> @@ -2313,6 +2313,7 @@ static void drain_stock(struct memcg_stock_pcp *stock)
>  		page_counter_uncharge(&old->memory, stock->nr_pages);
>  		if (do_memsw_account())
>  			page_counter_uncharge(&old->memsw, stock->nr_pages);
> +		memcg_oom_recover(old);
>  		stock->nr_pages = 0;
>  	}
>  
> -- 
> 2.11.0

-- 
Michal Hocko
SUSE Labs
