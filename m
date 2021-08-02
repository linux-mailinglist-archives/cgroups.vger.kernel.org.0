Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF363DD07B
	for <lists+cgroups@lfdr.de>; Mon,  2 Aug 2021 08:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbhHBG23 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Aug 2021 02:28:29 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60272 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbhHBG23 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Aug 2021 02:28:29 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E07CA1FF2C;
        Mon,  2 Aug 2021 06:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627885694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6O4ovfEUNzace1WQB0NeGLBJmSbRWBaTfA/jz5eGKhU=;
        b=iekKpJ/FslvYsDvvZ82fpdm2vUtlLGMkBtK78wzaekb+Qk7ht7qwOi8jim1KAZlT5MBqOw
        /D4TEqIau7O5ebh+Rxwe4sF7sa2tsnufabuAG+xPb3GZ28ayU+B4ptzFRqQfydNDQqp4BV
        e5bwJxE3QHXGF43kpWrhdtZDLtlByAo=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BC5BBA3BBE;
        Mon,  2 Aug 2021 06:28:13 +0000 (UTC)
Date:   Mon, 2 Aug 2021 08:28:13 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] mm/memcg: Fix incorrect flushing of lruvec data in
 obj_stock
Message-ID: <YQeQfX3t8k+U3MIL@dhcp22.suse.cz>
References: <20210802022827.10192-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802022827.10192-1-longman@redhat.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun 01-08-21 22:28:27, Waiman Long wrote:
> When mod_objcg_state() is called with a pgdat that is different from
> that in the obj_stock, the old lruvec data cached in obj_stock are
> flushed out. Unfortunately, they were flushed to the new pgdat and
> hence the wrong node, not the one cached in obj_stock.

It would be great to explicitly mention user observable problems here. I
do assume this will make slab stats skewed but the effect wouldn't be
very big, right?

> Fix that by flushing the data to the cached pgdat instead.
> 
> Fixes: 68ac5b3c8db2 ("mm/memcg: cache vmstat data in percpu memcg_stock_pcp")
> Signed-off-by: Waiman Long <longman@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memcontrol.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index ae1f5d0cb581..881ec4ddddcd 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3106,17 +3106,19 @@ void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
>  		stock->cached_pgdat = pgdat;
>  	} else if (stock->cached_pgdat != pgdat) {
>  		/* Flush the existing cached vmstat data */
> +		struct pglist_data *oldpg = stock->cached_pgdat;
> +
> +		stock->cached_pgdat = pgdat;
>  		if (stock->nr_slab_reclaimable_b) {
> -			mod_objcg_mlstate(objcg, pgdat, NR_SLAB_RECLAIMABLE_B,
> +			mod_objcg_mlstate(objcg, oldpg, NR_SLAB_RECLAIMABLE_B,
>  					  stock->nr_slab_reclaimable_b);
>  			stock->nr_slab_reclaimable_b = 0;
>  		}
>  		if (stock->nr_slab_unreclaimable_b) {
> -			mod_objcg_mlstate(objcg, pgdat, NR_SLAB_UNRECLAIMABLE_B,
> +			mod_objcg_mlstate(objcg, oldpg, NR_SLAB_UNRECLAIMABLE_B,
>  					  stock->nr_slab_unreclaimable_b);
>  			stock->nr_slab_unreclaimable_b = 0;
>  		}
> -		stock->cached_pgdat = pgdat;

Minor nit. Is there any reason to move the cached_pgdat? TBH I found the
original way better from the readability POV.

>  	}
>  
>  	bytes = (idx == NR_SLAB_RECLAIMABLE_B) ? &stock->nr_slab_reclaimable_b
> -- 
> 2.18.1

-- 
Michal Hocko
SUSE Labs
