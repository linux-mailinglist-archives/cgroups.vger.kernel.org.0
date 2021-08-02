Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF2023DD0DB
	for <lists+cgroups@lfdr.de>; Mon,  2 Aug 2021 08:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbhHBG6M (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Aug 2021 02:58:12 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50480 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbhHBG6J (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Aug 2021 02:58:09 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BABD121FC1;
        Mon,  2 Aug 2021 06:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627887479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tUbU3ZzRUqhVzk9x8OM8/LVLgiQh8b75TwEVEjI/pNU=;
        b=u9FnFt7I8zkmPHO6z9sNU8KK593faYfo5bs0tUNTJh16t19zT5bFXpimOXs3mueplDYVkw
        U5DyEemPVD3nA7/YaiJ3vdjc55ZZGbcA9LKNxBcuqOrkay0Qi9XsACNWIL8O3wU9HKL1UU
        RrRiqtqE9aWaxXTMGbj3wpsJj4eW0SM=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8E9FEA3BB2;
        Mon,  2 Aug 2021 06:57:59 +0000 (UTC)
Date:   Mon, 2 Aug 2021 08:57:56 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcg: cleanup racy sum avoidance code
Message-ID: <YQeXdPV8cUNIOUB5@dhcp22.suse.cz>
References: <20210728012243.3369123-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728012243.3369123-1-shakeelb@google.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 27-07-21 18:22:43, Shakeel Butt wrote:
> We used to have per-cpu memcg and lruvec stats and the readers have to
> traverse and sum the stats from each cpu. This summing was racy and may
> expose transient negative values. So, an explicit check was added to
> avoid such scenarios. Now these stats are moved to rstat infrastructure
> and are no more per-cpu, so we can remove the fixup for transient
> negative values.
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/memcontrol.h | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 7028d8e4a3d7..5f2a39a43d47 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -991,30 +991,19 @@ static inline void mod_memcg_state(struct mem_cgroup *memcg,
>  
>  static inline unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx)
>  {
> -	long x = READ_ONCE(memcg->vmstats.state[idx]);
> -#ifdef CONFIG_SMP
> -	if (x < 0)
> -		x = 0;
> -#endif
> -	return x;
> +	return READ_ONCE(memcg->vmstats.state[idx]);
>  }
>  
>  static inline unsigned long lruvec_page_state(struct lruvec *lruvec,
>  					      enum node_stat_item idx)
>  {
>  	struct mem_cgroup_per_node *pn;
> -	long x;
>  
>  	if (mem_cgroup_disabled())
>  		return node_page_state(lruvec_pgdat(lruvec), idx);
>  
>  	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
> -	x = READ_ONCE(pn->lruvec_stats.state[idx]);
> -#ifdef CONFIG_SMP
> -	if (x < 0)
> -		x = 0;
> -#endif
> -	return x;
> +	return READ_ONCE(pn->lruvec_stats.state[idx]);
>  }
>  
>  static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
> -- 
> 2.32.0.432.gabb21c7263-goog

-- 
Michal Hocko
SUSE Labs
