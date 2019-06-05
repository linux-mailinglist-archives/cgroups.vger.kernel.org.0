Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C67335D47
	for <lists+cgroups@lfdr.de>; Wed,  5 Jun 2019 14:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbfFEMzV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Jun 2019 08:55:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:46990 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727601AbfFEMzV (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 5 Jun 2019 08:55:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A415BAEE6;
        Wed,  5 Jun 2019 12:55:20 +0000 (UTC)
Date:   Wed, 5 Jun 2019 14:55:20 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH for-5.2-fixes] memcg: Don't loop on css_tryget_online()
 failure
Message-ID: <20190605125520.GF15685@dhcp22.suse.cz>
References: <20190529210617.GP374014@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529210617.GP374014@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 29-05-19 14:06:17, Tejun Heo wrote:
> A PF_EXITING task may stay associated with an offline css.
> get_mem_cgroup_from_mm() may deadlock if mm->owner is in such state.
> All similar logics in memcg are falling back to root memcg on
> tryget_online failure and get_mem_cgroup_from_mm() can do the same.
>
> A similar failure existed for task_get_css() and could be triggered
> through BSD process accounting racing against memcg offlining.  See
> 18fa84a2db0e ("cgroup: Use css_tryget() instead of css_tryget_online()
> in task_get_css()") for details.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Do we need to mark this patch for stable or this is too unlikely to
happen?

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!
> ---
>  mm/memcontrol.c |   24 ++++++++++--------------
>  1 file changed, 10 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index e50a2db5b4ff..be1fa89db198 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -918,23 +918,19 @@ struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
>  
>  	if (mem_cgroup_disabled())
>  		return NULL;
> +	/*
> +	 * Page cache insertions can happen without an actual mm context,
> +	 * e.g. during disk probing on boot, loopback IO, acct() writes.
> +	 */
> +	if (unlikely(!mm))
> +		return root_mem_cgroup;
>  
>  	rcu_read_lock();
> -	do {
> -		/*
> -		 * Page cache insertions can happen withou an
> -		 * actual mm context, e.g. during disk probing
> -		 * on boot, loopback IO, acct() writes etc.
> -		 */
> -		if (unlikely(!mm))
> -			memcg = root_mem_cgroup;
> -		else {
> -			memcg = mem_cgroup_from_task(rcu_dereference(mm->owner));
> -			if (unlikely(!memcg))
> -				memcg = root_mem_cgroup;
> -		}
> -	} while (!css_tryget_online(&memcg->css));
> +	memcg = mem_cgroup_from_task(rcu_dereference(mm->owner));
> +	if (!css_tryget_online(&memcg->css))
> +		memcg = root_mem_cgroup;
>  	rcu_read_unlock();
> +
>  	return memcg;
>  }
>  EXPORT_SYMBOL(get_mem_cgroup_from_mm);

-- 
Michal Hocko
SUSE Labs
