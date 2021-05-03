Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94693371530
	for <lists+cgroups@lfdr.de>; Mon,  3 May 2021 14:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbhECMXY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 May 2021 08:23:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:42624 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230414AbhECMXY (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 3 May 2021 08:23:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A8C04B172;
        Mon,  3 May 2021 12:22:27 +0000 (UTC)
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
References: <20210502180755.445-1-longman@redhat.com>
 <20210502180755.445-2-longman@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 2/2] mm: memcg/slab: Don't create unfreeable slab
Message-ID: <699e5ac8-9044-d664-f73f-778fe72fd09b@suse.cz>
Date:   Mon, 3 May 2021 14:22:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210502180755.445-2-longman@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 5/2/21 8:07 PM, Waiman Long wrote:
> The obj_cgroup array (memcg_data) embedded in the page structure is
> allocated at the first instance an accounted memory allocation happens.
> With the right size object, it is possible that the allocated obj_cgroup
> array comes from the same slab that requires memory accounting. If this
> happens, the slab will never become empty again as there is at least one
> object left (the obj_cgroup array) in the slab.
> 
> With instructmentation code added to detect this situation, I got 76
> hits on the kmalloc-192 slab when booting up a test kernel on a VM.
> So this can really happen.
> 
> To avoid the creation of these unfreeable slabs, a check is added to
> memcg_alloc_page_obj_cgroups() to detect that and double the size
> of the array in case it happens to make sure that it comes from a
> different kmemcache.
> 
> This change, however, does not completely eliminate the presence
> of unfreeable slabs which can still happen if a circular obj_cgroup
> array dependency is formed.

Hm this looks like only a half fix then.
I'm afraid the proper fix is for kmemcg to create own set of caches for the
arrays. It would also solve the recursive kfree() issue.

> Fixes: 286e04b8ed7a ("mm: memcg/slab: allocate obj_cgroups for non-root slab pages")
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  mm/memcontrol.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index b0695d3aa530..44852ac048c3 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2876,12 +2876,24 @@ int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s,
>  	 */
>  	objects = max(objs_per_slab_page(s, page),
>  		      (int)(sizeof(struct rcu_head)/sizeof(void *)));
> -
> +retry:
>  	vec = kcalloc_node(objects, sizeof(struct obj_cgroup *), gfp,
>  			   page_to_nid(page));
>  	if (!vec)
>  		return -ENOMEM;
>  
> +	/*
> +	 * The allocated vector should not come from the same slab.
> +	 * Otherwise, this slab will never become empty. Double the size
> +	 * in this case to make sure that the vector comes from a different
> +	 * kmemcache.
> +	 */
> +	if (unlikely(virt_to_head_page(vec) == page)) {
> +		kfree(vec);
> +		objects *= 2;
> +		goto retry;
> +	}
> +
>  	memcg_data = (unsigned long) vec | MEMCG_DATA_OBJCGS;
>  	if (new_page) {
>  		/*
> 

