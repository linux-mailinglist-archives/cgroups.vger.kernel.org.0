Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD983106DC
	for <lists+cgroups@lfdr.de>; Fri,  5 Feb 2021 09:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbhBEIhe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 5 Feb 2021 03:37:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:40138 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229508AbhBEIhc (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 5 Feb 2021 03:37:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612514205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TPEtPSJTJFr+uqHAFw8+/pwPBdso+nWGktyWxW/+4Bk=;
        b=RyIyP8hptBgLl6GItYcCzNcgE23w04gkI+vhzyGupcf+vAkfOBL3NGDJoMkbwLULc7ZOIn
        KgXw1u/bFSbp2L2QMKEeMyfURJzyEQieaBdVVcZe5DvlRVdsYV0BXNd/oZSCCN5ElKdFKQ
        SsPnoVS4Z5uDTEN2uywLQ/P8ZTj2OaA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1D250ACBA;
        Fri,  5 Feb 2021 08:36:45 +0000 (UTC)
Date:   Fri, 5 Feb 2021 09:36:44 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol: remove rcu_read_lock from
 get_mem_cgroup_from_page
Message-ID: <YB0DnAlCaQza4Uf9@dhcp22.suse.cz>
References: <20210205062719.74431-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205062719.74431-1-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 05-02-21 14:27:19, Muchun Song wrote:
> The get_mem_cgroup_from_page() is called under page lock, so the page
> memcg cannot be changed under us.

Where is the page lock enforced?

> Also, css_get is enough because page
> has a reference to the memcg.

tryget used to be there to guard against offlined memcg but we have
concluded this is impossible in this path. tryget stayed there to catch
some unexpected cases IIRC.

> If we really want to make the get_mem_cgroup_from_page() suitable for
> arbitrary page, we should use page_memcg_rcu() instead of page_memcg()
> and call it after rcu_read_lock().

What is the primary motivation to change this code? is the overhead of
tryget/RCU something that needs optimizing?
 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/memcontrol.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 87f01bc05d1f..6c7f1ea3955e 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1063,16 +1063,15 @@ EXPORT_SYMBOL(get_mem_cgroup_from_mm);
>   */
>  struct mem_cgroup *get_mem_cgroup_from_page(struct page *page)
>  {
> -	struct mem_cgroup *memcg = page_memcg(page);
> +	struct mem_cgroup *memcg;
>  
>  	if (mem_cgroup_disabled())
>  		return NULL;
>  
> -	rcu_read_lock();
>  	/* Page should not get uncharged and freed memcg under us. */
> -	if (!memcg || WARN_ON_ONCE(!css_tryget(&memcg->css)))
> -		memcg = root_mem_cgroup;
> -	rcu_read_unlock();
> +	memcg = page_memcg(page) ? : root_mem_cgroup;
> +	css_get(&memcg->css);
> +
>  	return memcg;
>  }
>  EXPORT_SYMBOL(get_mem_cgroup_from_page);
> -- 
> 2.11.0

-- 
Michal Hocko
SUSE Labs
