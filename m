Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A17B2D10A3
	for <lists+cgroups@lfdr.de>; Mon,  7 Dec 2020 13:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbgLGMgy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 7 Dec 2020 07:36:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:51428 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725803AbgLGMgy (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 7 Dec 2020 07:36:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607344567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rvs081RAGQPaFquBIFuFiPgtjv7glx+tVrBE85otOnw=;
        b=Eugiw6R2M3d1tGTGOVHNaxSZUo0OJvOH6z4OoBj3eg9W37zRl8JNEYrEQaCdQg7pgiLFRr
        3nm+3Dm6QgbPfpeXJZBLKD6S3UW6dUUENnu9me6G8pZOi6kOP8DXosWxYHw1VwuKdpS+TB
        3MJU7FKpT3t/nNHLNSZjswHItP6saVc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 63CDFAC9A;
        Mon,  7 Dec 2020 12:36:07 +0000 (UTC)
Date:   Mon, 7 Dec 2020 13:36:05 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, shakeelb@google.com, guro@fb.com,
        sfr@canb.auug.org.au, alexander.h.duyck@linux.intel.com,
        chris@chrisdown.name, laoar.shao@gmail.com,
        richard.weiyang@gmail.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: memcontrol: optimize per-lruvec stats counter memory
 usage
Message-ID: <20201207123605.GH25569@dhcp22.suse.cz>
References: <20201206085639.12627-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201206085639.12627-1-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun 06-12-20 16:56:39, Muchun Song wrote:
> The vmstat threshold is 32 (MEMCG_CHARGE_BATCH), so the type of s32
> of lruvec_stat_cpu is enough. And introduce struct per_cpu_lruvec_stat
> to optimize memory usage.

How much savings are we talking about here? I am not deeply familiar
with the pcp allocator but can it compact smaller data types much
better?

> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  include/linux/memcontrol.h | 6 +++++-
>  mm/memcontrol.c            | 2 +-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index f9a496c4eac7..34cf119976b1 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -92,6 +92,10 @@ struct lruvec_stat {
>  	long count[NR_VM_NODE_STAT_ITEMS];
>  };
>  
> +struct per_cpu_lruvec_stat {
> +	s32 count[NR_VM_NODE_STAT_ITEMS];
> +};
> +
>  /*
>   * Bitmap of shrinker::id corresponding to memcg-aware shrinkers,
>   * which have elements charged to this memcg.
> @@ -111,7 +115,7 @@ struct mem_cgroup_per_node {
>  	struct lruvec_stat __percpu *lruvec_stat_local;
>  
>  	/* Subtree VM stats (batched updates) */
> -	struct lruvec_stat __percpu *lruvec_stat_cpu;
> +	struct per_cpu_lruvec_stat __percpu *lruvec_stat_cpu;
>  	atomic_long_t		lruvec_stat[NR_VM_NODE_STAT_ITEMS];
>  
>  	unsigned long		lru_zone_size[MAX_NR_ZONES][NR_LRU_LISTS];
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 49fbcf003bf5..c874ea37b05d 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5184,7 +5184,7 @@ static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
>  		return 1;
>  	}
>  
> -	pn->lruvec_stat_cpu = alloc_percpu_gfp(struct lruvec_stat,
> +	pn->lruvec_stat_cpu = alloc_percpu_gfp(struct per_cpu_lruvec_stat,
>  					       GFP_KERNEL_ACCOUNT);
>  	if (!pn->lruvec_stat_cpu) {
>  		free_percpu(pn->lruvec_stat_local);
> -- 
> 2.11.0

-- 
Michal Hocko
SUSE Labs
