Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1441D31B68F
	for <lists+cgroups@lfdr.de>; Mon, 15 Feb 2021 10:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhBOJio (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Feb 2021 04:38:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:32834 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229948AbhBOJig (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 15 Feb 2021 04:38:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613381870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XuaD4qfV4mnOvBqozHEgf1LOzpJnPhnAAtC97LcZGCk=;
        b=CtjGqMQAdl3bX8gk24RXRcfb1vzr7ejVovQ5dy3zYQPS92ojUHyx58gd/mPqesbnhYBhRI
        Nl0YE7gjJflJWnHS420wujgmc+H1PDNYKh7T0dk1k0HioJZaZqBEmg69kH/C9v/q3jU/Ng
        yTFf3dXJ15zn2BZEeCSxlVayWoauMcw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 08165AD3E;
        Mon, 15 Feb 2021 09:37:50 +0000 (UTC)
Date:   Mon, 15 Feb 2021 10:37:49 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] mm: memcontrol: add missing memcg_oom_recover() when
 uncharge slab page
Message-ID: <YCpA7XMV6oIQkcUs@dhcp22.suse.cz>
References: <20210212170159.32153-1-songmuchun@bytedance.com>
 <20210212170159.32153-2-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212170159.32153-2-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat 13-02-21 01:01:57, Muchun Song wrote:
> When we uncharge a page, we wake up oom victims when the memcg oom
> handling is outsourced to the userspace. The uncharge_batch do that
> for normal and kmem pages but not slab pages. It is likely an
> omission. So add the missing memcg_oom_recover() to
> __memcg_kmem_uncharge(). And the function of memory.oom_control
> is only suitable for cgroup v1. So guard this test (memcg->under_oom)
> by the cgroup_subsys_on_dfl(memory_cgrp_subsys).

User visible effects please? I believe there are unlikely any. I do not
have any data at hands but I would expect that slab pages freeing
wouldn't really contribute much to help a memcg out of oom without an
external intervention for oom_disabled case. If that is the case then
make it explicit to the changelog. If you have workloads which do see a
suboptimal behavior then please mention that as well. This is important
for future readers to understand the code and motivation behind it.

Also, now I guess I can see why you have decided to not do cgroup v2
check directly in memcg_oom_recover. You do not want to repeat the check
in paths which already do do check for you. That is fine. Appart from
the uncharging path, none of the others is really a hot path so this is
likely a reasonable decision.

I have a minor comment below.

> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/memcontrol.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 7afca9677693..a3f26522765a 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3126,8 +3126,10 @@ static int __memcg_kmem_charge(struct mem_cgroup *memcg, gfp_t gfp,
>   */
>  static void __memcg_kmem_uncharge(struct mem_cgroup *memcg, unsigned int nr_pages)
>  {
> -	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
> +	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys)) {
>  		page_counter_uncharge(&memcg->kmem, nr_pages);
> +		memcg_oom_recover(memcg);
> +	}
>  
>  	refill_stock(memcg, nr_pages);
>  }
> @@ -6806,11 +6808,15 @@ static void uncharge_batch(const struct uncharge_gather *ug)
>  
>  	if (!mem_cgroup_is_root(ug->memcg)) {
>  		page_counter_uncharge(&ug->memcg->memory, ug->nr_pages);
> -		if (do_memsw_account())
> -			page_counter_uncharge(&ug->memcg->memsw, ug->nr_pages);
> -		if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && ug->nr_kmem)
> -			page_counter_uncharge(&ug->memcg->kmem, ug->nr_kmem);
> -		memcg_oom_recover(ug->memcg);
> +		if (!cgroup_subsys_on_dfl(memory_cgrp_subsys)) {
> +			if (!cgroup_memory_noswap)
> +				page_counter_uncharge(&ug->memcg->memsw,
> +						      ug->nr_pages);

This is functionally equivalent but I am not sure this will make a
further maintainability easier. do_memsw_account check is used at many
other places and it is a general helper which you have split into its
current implementation. This makes any future changes more tricky. Is
this miro-optimization worth it?

> +			if (ug->nr_kmem)
> +				page_counter_uncharge(&ug->memcg->kmem,
> +						      ug->nr_kmem);
> +			memcg_oom_recover(ug->memcg);
> +		}
>  	}
>  
>  	local_irq_save(flags);
> -- 
> 2.11.0

-- 
Michal Hocko
SUSE Labs
