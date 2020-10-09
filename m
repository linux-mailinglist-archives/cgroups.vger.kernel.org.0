Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB64288C4C
	for <lists+cgroups@lfdr.de>; Fri,  9 Oct 2020 17:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388811AbgJIPMe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 9 Oct 2020 11:12:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:42306 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388696AbgJIPMe (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 9 Oct 2020 11:12:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1602256352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BSD1kYo1TCGseCG0CMo0C9XsPcUqaOsDq8A7C+bHfAc=;
        b=H9vZZHdqeJILfnwmhQEIFVlV29sQ5i/dofyz5kArPDdfu1Dl+uoOE0Y+YJku6zahrYl3R8
        R/CyAR+M+8h6Z/GdvxRvvFvdlvT3x/HxRWyaaesz1u2dqzvfRhAsNXJcGvmv0RJzWUK37C
        N8LATr1C4lgtsO/P/i/6e2kwNWMVDNU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 592C3B251;
        Fri,  9 Oct 2020 15:12:32 +0000 (UTC)
Date:   Fri, 9 Oct 2020 17:12:27 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol: eliminate redundant check in
 __mem_cgroup_insert_exceeded()
Message-ID: <20201009151227.GP4967@dhcp22.suse.cz>
References: <20201009135104.39048-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009135104.39048-1-linmiaohe@huawei.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 09-10-20 09:51:04, Miaohe Lin wrote:
> The mz->usage_in_excess >= mz_node->usage_in_excess check is exactly the
> else case of mz->usage_in_excess < mz_node->usage_in_excess. So we could
> replace else if (mz->usage_in_excess >= mz_node->usage_in_excess) with else
> equally.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Acked-by: Michal Hocko <mhocko@suse.com>

I believe this is a result of a very unreadable code. Resp. the comment
makes it hard to follow. It would be slightly better to simply drop the
comment which doesn't really explain much IMHO.

> ---
>  mm/memcontrol.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 2636f8bad908..f607afd0fcbf 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -629,7 +629,7 @@ static void __mem_cgroup_insert_exceeded(struct mem_cgroup_per_node *mz,
>  		 * We can't avoid mem cgroups that are over their soft
>  		 * limit by the same amount
>  		 */
> -		else if (mz->usage_in_excess >= mz_node->usage_in_excess)
> +		else
>  			p = &(*p)->rb_right;
>  	}
>  
> -- 
> 2.19.1

-- 
Michal Hocko
SUSE Labs
