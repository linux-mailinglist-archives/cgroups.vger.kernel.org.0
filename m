Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23FF9268A30
	for <lists+cgroups@lfdr.de>; Mon, 14 Sep 2020 13:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgINLhj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Sep 2020 07:37:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:50982 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbgINLhY (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 14 Sep 2020 07:37:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A9154AD0F;
        Mon, 14 Sep 2020 11:37:38 +0000 (UTC)
Date:   Mon, 14 Sep 2020 13:37:22 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Roman Gushchin <guro@fb.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH v2 1/3] mm/memcg: Clean up obsolete enum charge_type
Message-ID: <20200914113722.GL16999@dhcp22.suse.cz>
References: <20200914024452.19167-1-longman@redhat.com>
 <20200914024452.19167-2-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914024452.19167-2-longman@redhat.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun 13-09-20 22:44:50, Waiman Long wrote:
> Since commit 0a31bc97c80c ("mm: memcontrol: rewrite uncharge API") and
> commit 00501b531c47 ("mm: memcontrol: rewrite charge API") in v3.17, the
> enum charge_type was no longer used anywhere. However, the enum itself
> was not removed at that time. Remove the obsolete enum charge_type now.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memcontrol.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index cfa6cbad21d5..8c74f1200261 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -197,14 +197,6 @@ static struct move_charge_struct {
>  #define	MEM_CGROUP_MAX_RECLAIM_LOOPS		100
>  #define	MEM_CGROUP_MAX_SOFT_LIMIT_RECLAIM_LOOPS	2
>  
> -enum charge_type {
> -	MEM_CGROUP_CHARGE_TYPE_CACHE = 0,
> -	MEM_CGROUP_CHARGE_TYPE_ANON,
> -	MEM_CGROUP_CHARGE_TYPE_SWAPOUT,	/* for accounting swapcache */
> -	MEM_CGROUP_CHARGE_TYPE_DROP,	/* a page was unused swap cache */
> -	NR_CHARGE_TYPE,
> -};
> -
>  /* for encoding cft->private value on file */
>  enum res_type {
>  	_MEM,
> -- 
> 2.18.1
> 

-- 
Michal Hocko
SUSE Labs
