Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5128E37581B
	for <lists+cgroups@lfdr.de>; Thu,  6 May 2021 18:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235412AbhEFQDp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 6 May 2021 12:03:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:60230 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235176AbhEFQDp (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 6 May 2021 12:03:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2E60BB1DE;
        Thu,  6 May 2021 16:02:46 +0000 (UTC)
Subject: Re: [PATCH v4 3/3] mm: memcg/slab: Disable cache merging for
 KMALLOC_NORMAL caches
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
 <20210505200610.13943-4-longman@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <83135334-f85e-b587-82fe-1875de602f53@suse.cz>
Date:   Thu, 6 May 2021 18:02:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210505200610.13943-4-longman@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 5/5/21 10:06 PM, Waiman Long wrote:
> The KMALLOC_NORMAL (kmalloc-<n>) caches are for unaccounted objects only
> when CONFIG_MEMCG_KMEM is enabled. To make sure that this condition
> remains true, we will have to prevent KMALOC_NORMAL caches to merge
> with other kmem caches. This is now done by setting its refcount to -1
> right after its creation.
> 
> Suggested-by: Roman Gushchin <guro@fb.com>
> Signed-off-by: Waiman Long <longman@redhat.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

(outside of scope of this patch/series, we should later replace this refcount
ugliness with a proper slab flag)

> ---
>  mm/slab_common.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index bbaf41a7c77e..a0ff8e1d8b67 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -841,6 +841,13 @@ new_kmalloc_cache(int idx, enum kmalloc_cache_type type, slab_flags_t flags)
>  					kmalloc_info[idx].name[type],
>  					kmalloc_info[idx].size, flags, 0,
>  					kmalloc_info[idx].size);
> +
> +	/*
> +	 * If CONFIG_MEMCG_KMEM is enabled, disable cache merging for
> +	 * KMALLOC_NORMAL caches.
> +	 */
> +	if (IS_ENABLED(CONFIG_MEMCG_KMEM) && (type == KMALLOC_NORMAL))
> +		kmalloc_caches[type][idx]->refcount = -1;
>  }
>  
>  /*
> 

