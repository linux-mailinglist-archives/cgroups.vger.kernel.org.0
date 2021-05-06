Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 204E43757A1
	for <lists+cgroups@lfdr.de>; Thu,  6 May 2021 17:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235705AbhEFPjx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 6 May 2021 11:39:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:41890 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236172AbhEFPiY (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 6 May 2021 11:38:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 45852B207;
        Thu,  6 May 2021 15:37:25 +0000 (UTC)
Subject: Re: [PATCH v4 1/3] mm: memcg/slab: Properly set up gfp flags for
 objcg pointer array
To:     Waiman Long <longman@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
References: <20210505200610.13943-1-longman@redhat.com>
 <20210505200610.13943-2-longman@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <46fb83c8-d875-9f85-da2c-ac2ba4847c07@suse.cz>
Date:   Thu, 6 May 2021 17:37:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210505200610.13943-2-longman@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 5/5/21 10:06 PM, Waiman Long wrote:
> Since the merging of the new slab memory controller in v5.9, the page
> structure may store a pointer to obj_cgroup pointer array for slab pages.
> Currently, only the __GFP_ACCOUNT bit is masked off. However, the array
> is not readily reclaimable and doesn't need to come from the DMA buffer.
> So those GFP bits should be masked off as well.
> 
> Do the flag bit clearing at memcg_alloc_page_obj_cgroups() to make sure
> that it is consistently applied no matter where it is called.
> 
> Fixes: 286e04b8ed7a ("mm: memcg/slab: allocate obj_cgroups for non-root slab pages")
> Signed-off-by: Waiman Long <longman@redhat.com>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/memcontrol.c | 8 ++++++++
>  mm/slab.h       | 1 -
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index c100265dc393..5e3b4f23b830 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2863,6 +2863,13 @@ static struct mem_cgroup *get_mem_cgroup_from_objcg(struct obj_cgroup *objcg)
>  }
>  
>  #ifdef CONFIG_MEMCG_KMEM
> +/*
> + * The allocated objcg pointers array is not accounted directly.
> + * Moreover, it should not come from DMA buffer and is not readily
> + * reclaimable. So those GFP bits should be masked off.
> + */
> +#define OBJCGS_CLEAR_MASK	(__GFP_DMA | __GFP_RECLAIMABLE | __GFP_ACCOUNT)
> +
>  int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s,
>  				 gfp_t gfp, bool new_page)
>  {
> @@ -2870,6 +2877,7 @@ int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s,
>  	unsigned long memcg_data;
>  	void *vec;
>  
> +	gfp &= ~OBJCGS_CLEAR_MASK;
>  	vec = kcalloc_node(objects, sizeof(struct obj_cgroup *), gfp,
>  			   page_to_nid(page));
>  	if (!vec)
> diff --git a/mm/slab.h b/mm/slab.h
> index 18c1927cd196..b3294712a686 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -309,7 +309,6 @@ static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
>  	if (!memcg_kmem_enabled() || !objcg)
>  		return;
>  
> -	flags &= ~__GFP_ACCOUNT;
>  	for (i = 0; i < size; i++) {
>  		if (likely(p[i])) {
>  			page = virt_to_head_page(p[i]);
> 

