Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B0D3B7DBB
	for <lists+cgroups@lfdr.de>; Wed, 30 Jun 2021 08:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbhF3G7K (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Jun 2021 02:59:10 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60072 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbhF3G7K (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Jun 2021 02:59:10 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2BE9C20456;
        Wed, 30 Jun 2021 06:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625036201; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oV014uPU4nv3+T83Wwazi4Y50Lmy7sh68BTDocX3Q1I=;
        b=UqvYz8pfMANcbqsnefEse7ECNG23Wr5ueVIxCxB71V62AJBkb8v9/vy5SR0D3GdhkO1p8l
        FzA7CQ7eBx7XdeKX5utCbtJ1YEzni9I3hUCKD0Ltzl0aN00ljHqTsXdZtmoty9DSZg/MAd
        Bw1PHVzDhEDv03SipEpEOf96Uyaz7Zs=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EAD60A3B8A;
        Wed, 30 Jun 2021 06:56:40 +0000 (UTC)
Date:   Wed, 30 Jun 2021 08:56:40 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH v3 04/18] mm/memcg: Remove soft_limit_tree_node()
Message-ID: <YNwVqITCS+C9zG79@dhcp22.suse.cz>
References: <20210630040034.1155892-1-willy@infradead.org>
 <20210630040034.1155892-5-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630040034.1155892-5-willy@infradead.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 30-06-21 05:00:20, Matthew Wilcox wrote:
> Opencode this one-line function in its three callers.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memcontrol.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 29b28a050707..29fdb70dca42 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -446,12 +446,6 @@ ino_t page_cgroup_ino(struct page *page)
>  	return ino;
>  }
>  
> -static struct mem_cgroup_tree_per_node *
> -soft_limit_tree_node(int nid)
> -{
> -	return soft_limit_tree.rb_tree_per_node[nid];
> -}
> -
>  static void __mem_cgroup_insert_exceeded(struct mem_cgroup_per_node *mz,
>  					 struct mem_cgroup_tree_per_node *mctz,
>  					 unsigned long new_usage_in_excess)
> @@ -528,7 +522,7 @@ static void mem_cgroup_update_tree(struct mem_cgroup *memcg, int nid)
>  	struct mem_cgroup_per_node *mz;
>  	struct mem_cgroup_tree_per_node *mctz;
>  
> -	mctz = soft_limit_tree_node(nid);
> +	mctz = soft_limit_tree.rb_tree_per_node[nid];
>  	if (!mctz)
>  		return;
>  	/*
> @@ -567,7 +561,7 @@ static void mem_cgroup_remove_from_trees(struct mem_cgroup *memcg)
>  
>  	for_each_node(nid) {
>  		mz = memcg->nodeinfo[nid];
> -		mctz = soft_limit_tree_node(nid);
> +		mctz = soft_limit_tree.rb_tree_per_node[nid];
>  		if (mctz)
>  			mem_cgroup_remove_exceeded(mz, mctz);
>  	}
> @@ -3415,7 +3409,7 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
>  	if (order > 0)
>  		return 0;
>  
> -	mctz = soft_limit_tree_node(pgdat->node_id);
> +	mctz = soft_limit_tree.rb_tree_per_node[pgdat->node_id];
>  
>  	/*
>  	 * Do not even bother to check the largest node if the root
> -- 
> 2.30.2

-- 
Michal Hocko
SUSE Labs
