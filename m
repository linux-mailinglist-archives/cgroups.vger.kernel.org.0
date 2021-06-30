Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE653B7DBA
	for <lists+cgroups@lfdr.de>; Wed, 30 Jun 2021 08:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbhF3G6W (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Jun 2021 02:58:22 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:44710 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbhF3G6W (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Jun 2021 02:58:22 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EA27F21B6B;
        Wed, 30 Jun 2021 06:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625036152; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dfbk9m7pL8P6FATcEjsRSmi7MvZED6EwkmJuuT4idIA=;
        b=kcQ+n1tPGZEARjAErQWjGIE0PbBiHQlQN/5453W0gphAu4xHzlYFzlgc1+yg+0FT0WF0QZ
        9AH7Vex5aTVjTo00/vmWYqCD876qG0t6jAhRscbRdqZ8WWq5fSQPyIt+/ZOMRp5zn0pRdG
        DELDTDANk4rJbPIyLXjSsrPP52ykUHg=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B7D97A3B85;
        Wed, 30 Jun 2021 06:55:52 +0000 (UTC)
Date:   Wed, 30 Jun 2021 08:55:52 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH v3 03/18] mm/memcg: Use the node id in
 mem_cgroup_update_tree()
Message-ID: <YNwVeIDTPJZMfhDO@dhcp22.suse.cz>
References: <20210630040034.1155892-1-willy@infradead.org>
 <20210630040034.1155892-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630040034.1155892-4-willy@infradead.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 30-06-21 05:00:19, Matthew Wilcox wrote:
> By using the node id in mem_cgroup_update_tree(), we can delete
> soft_limit_tree_from_page() and mem_cgroup_page_nodeinfo().  Saves 42
> bytes of kernel text on my config.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  mm/memcontrol.c | 24 ++++--------------------
>  1 file changed, 4 insertions(+), 20 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 25cad0fb7d4e..29b28a050707 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -446,28 +446,12 @@ ino_t page_cgroup_ino(struct page *page)
>  	return ino;
>  }
>  
> -static struct mem_cgroup_per_node *
> -mem_cgroup_page_nodeinfo(struct mem_cgroup *memcg, struct page *page)
> -{
> -	int nid = page_to_nid(page);
> -
> -	return memcg->nodeinfo[nid];
> -}
> -
>  static struct mem_cgroup_tree_per_node *
>  soft_limit_tree_node(int nid)
>  {
>  	return soft_limit_tree.rb_tree_per_node[nid];
>  }
>  
> -static struct mem_cgroup_tree_per_node *
> -soft_limit_tree_from_page(struct page *page)
> -{
> -	int nid = page_to_nid(page);
> -
> -	return soft_limit_tree.rb_tree_per_node[nid];
> -}
> -
>  static void __mem_cgroup_insert_exceeded(struct mem_cgroup_per_node *mz,
>  					 struct mem_cgroup_tree_per_node *mctz,
>  					 unsigned long new_usage_in_excess)
> @@ -538,13 +522,13 @@ static unsigned long soft_limit_excess(struct mem_cgroup *memcg)
>  	return excess;
>  }
>  
> -static void mem_cgroup_update_tree(struct mem_cgroup *memcg, struct page *page)
> +static void mem_cgroup_update_tree(struct mem_cgroup *memcg, int nid)
>  {
>  	unsigned long excess;
>  	struct mem_cgroup_per_node *mz;
>  	struct mem_cgroup_tree_per_node *mctz;
>  
> -	mctz = soft_limit_tree_from_page(page);
> +	mctz = soft_limit_tree_node(nid);
>  	if (!mctz)
>  		return;
>  	/*
> @@ -552,7 +536,7 @@ static void mem_cgroup_update_tree(struct mem_cgroup *memcg, struct page *page)
>  	 * because their event counter is not touched.
>  	 */
>  	for (; memcg; memcg = parent_mem_cgroup(memcg)) {
> -		mz = mem_cgroup_page_nodeinfo(memcg, page);
> +		mz = memcg->nodeinfo[nid];
>  		excess = soft_limit_excess(memcg);
>  		/*
>  		 * We have to update the tree if mz is on RB-tree or
> @@ -879,7 +863,7 @@ static void memcg_check_events(struct mem_cgroup *memcg, struct page *page)
>  						MEM_CGROUP_TARGET_SOFTLIMIT);
>  		mem_cgroup_threshold(memcg);
>  		if (unlikely(do_softlimit))
> -			mem_cgroup_update_tree(memcg, page);
> +			mem_cgroup_update_tree(memcg, page_to_nid(page));
>  	}
>  }
>  
> -- 
> 2.30.2

-- 
Michal Hocko
SUSE Labs
