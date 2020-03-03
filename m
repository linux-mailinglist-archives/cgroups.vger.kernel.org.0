Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5127517726D
	for <lists+cgroups@lfdr.de>; Tue,  3 Mar 2020 10:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgCCJcy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Mar 2020 04:32:54 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43598 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727644AbgCCJcy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Mar 2020 04:32:54 -0500
Received: by mail-wr1-f67.google.com with SMTP id h9so2449125wrr.10;
        Tue, 03 Mar 2020 01:32:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XYpfou3pNPf/l+cdS9KAFxciOnURpc9US/Ck720UZHw=;
        b=aqzLeWQfRDVvrZa298Hwxwy6HOoMmC3nQqu87aPqpd4t7Py35ZgwNoAgLQoxE9FCaM
         qgw51japeUWQn+BYQLbDhcq21A98ki0WViEdYDI2gDnrm/ryTwoFvpyiy/ofuprUB7lE
         6e+7QX1JE8j2aErOcWfb0YYNlid5n+U6vdXE3/AVDTEvHTMRpjAlgGM1Ke2q4MqH112Z
         YvK4RAyKqF19iIs2ME4K4yshAFCzdEgIOfliIxX4MIVziY2DEyEaviU2O/sFBOSLyAyD
         yftjwRDMrXWpLUpdKE0BjF2MWHhQsln22h/j4GTqJMVxadFzAo07ObRVBj3JF2SxqU1E
         NSjA==
X-Gm-Message-State: ANhLgQ1W269+2rpTNpBQ1yfAQCXEncVrMMPk0PyXMeeqlkxfMpIn57T3
        dFy78rMMZtSZZDqa1QJQVCg=
X-Google-Smtp-Source: ADFU+vtF+RbwIjqore5UHIM7atEL0jn316nOITsQv4Z2OqwFH4XPXNTPD5ODK8h9prUeZDx1qzGkkA==
X-Received: by 2002:a5d:4088:: with SMTP id o8mr4722346wrp.144.1583227972535;
        Tue, 03 Mar 2020 01:32:52 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id f17sm12224197wrm.3.2020.03.03.01.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 01:32:51 -0800 (PST)
Date:   Tue, 3 Mar 2020 10:32:51 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] memcg: css_tryget_online cleanups
Message-ID: <20200303093251.GD4380@dhcp22.suse.cz>
References: <20200302203109.179417-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302203109.179417-1-shakeelb@google.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 02-03-20 12:31:09, Shakeel Butt wrote:
> Currently multiple locations in memcg code, css_tryget_online() is being
> used. However it doesn't matter whether the cgroup is online for the
> callers. Online used to matter when we had reparenting on offlining and
> we needed a way to prevent new ones from showing up.
> 
> The failure case for couple of these css_tryget_online usage is to
> fallback to root_mem_cgroup which kind of make bypassing the memcg
> limits possible for some workloads. For example creating an inotify
> group in a subcontainer and then deleting that container after moving the
> process to a different container will make all the event objects
> allocated for that group to the root_mem_cgroup. So, using
> css_tryget_online() is dangerous for such cases.
> 
> Two locations still use the online version. The swapin of offlined
> memcg's pages and the memcg kmem cache creation. The kmem cache indeed
> needs the online version as the kernel does the reparenting of memcg
> kmem caches. For the swapin case, it has been left for later as the
> fallback is not really that concerning.

Could you be more specific about the swap in case please?

> Signed-off-by: Shakeel Butt <shakeelb@google.com>

Other than that nothing really jumped at me although I have to confess
that I am far from deeply familiar with the sk_buff charging path.

Acked-by: Michal Hocko <mhocko@suse.com>
> ---
> 
> Changes since v1:
> - replaced WARN_ON with WARN_ON_ONCE
> 
>  mm/memcontrol.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 62b574d0cd3c..75d8883bf975 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -656,7 +656,7 @@ __mem_cgroup_largest_soft_limit_node(struct mem_cgroup_tree_per_node *mctz)
>  	 */
>  	__mem_cgroup_remove_exceeded(mz, mctz);
>  	if (!soft_limit_excess(mz->memcg) ||
> -	    !css_tryget_online(&mz->memcg->css))
> +	    !css_tryget(&mz->memcg->css))
>  		goto retry;
>  done:
>  	return mz;
> @@ -961,7 +961,8 @@ struct mem_cgroup *get_mem_cgroup_from_page(struct page *page)
>  		return NULL;
>  
>  	rcu_read_lock();
> -	if (!memcg || !css_tryget_online(&memcg->css))
> +	/* Page should not get uncharged and freed memcg under us. */
> +	if (!memcg || WARN_ON_ONCE(!css_tryget(&memcg->css)))
>  		memcg = root_mem_cgroup;
>  	rcu_read_unlock();
>  	return memcg;
> @@ -974,10 +975,13 @@ EXPORT_SYMBOL(get_mem_cgroup_from_page);
>  static __always_inline struct mem_cgroup *get_mem_cgroup_from_current(void)
>  {
>  	if (unlikely(current->active_memcg)) {
> -		struct mem_cgroup *memcg = root_mem_cgroup;
> +		struct mem_cgroup *memcg;
>  
>  		rcu_read_lock();
> -		if (css_tryget_online(&current->active_memcg->css))
> +		/* current->active_memcg must hold a ref. */
> +		if (WARN_ON_ONCE(!css_tryget(&current->active_memcg->css)))
> +			memcg = root_mem_cgroup;
> +		else
>  			memcg = current->active_memcg;
>  		rcu_read_unlock();
>  		return memcg;
> @@ -6732,7 +6736,7 @@ void mem_cgroup_sk_alloc(struct sock *sk)
>  		goto out;
>  	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && !memcg->tcpmem_active)
>  		goto out;
> -	if (css_tryget_online(&memcg->css))
> +	if (css_tryget(&memcg->css))
>  		sk->sk_memcg = memcg;
>  out:
>  	rcu_read_unlock();
> -- 
> 2.25.0.265.gbab2e86ba0-goog

-- 
Michal Hocko
SUSE Labs
