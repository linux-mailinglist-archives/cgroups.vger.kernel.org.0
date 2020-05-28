Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0511E644F
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2020 16:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgE1OoR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 May 2020 10:44:17 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38237 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgE1OoP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 May 2020 10:44:15 -0400
Received: by mail-wm1-f68.google.com with SMTP id f185so2341328wmf.3
        for <cgroups@vger.kernel.org>; Thu, 28 May 2020 07:44:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d5CG+dZkizz2gd8XiI325VVyArlyR5Hw+X1ko//Nh1s=;
        b=EQJyJnS9wVW4zV7XF+G0V9XGQ8HOu3T7OC8i4QSbh38QUNyDQ94kQVlsFpNj5XgNCq
         ADsNam9aLovXjUUPzz1O4ns+iVhUo73O2WDJOD4w30dKAsZSATOQ1l0h43YqtvEUJMcQ
         vGPKsNpLcfG3XgUhBbey1wsIMoxOM/febfsJfeGyqADShKbbc+3yBcp7t2ARySlcyTRx
         KcQmevEoASxMAnyjjcs8jvm1UAoJpx/4XAPDyYLcDDeyo0sgOoA9gKvp+r30jkPXLHUc
         QXfKmbvd4v2lNXL7JRfruLWvVmtoRsJVRv/jcq6pxdaC2WhZOCv+gC8bTlacrxomSf+W
         oNJA==
X-Gm-Message-State: AOAM531WYI9pWsVwMXTp8zjHBE8RmU4xG/Bad+ndai/ng3R3GslrwJ3X
        4sVR2mXQQDaPcbJzvzKPpEGVDrwG
X-Google-Smtp-Source: ABdhPJzmRJnwJPbIosz6Q7UNmwC1yBhbcmyboMCn2GR+vzfNInCeARHRg7d/ZCmhsoSoGd7gjwUK/g==
X-Received: by 2002:a1c:2cd7:: with SMTP id s206mr3564565wms.109.1590677053923;
        Thu, 28 May 2020 07:44:13 -0700 (PDT)
Received: from localhost (ip-37-188-185-40.eurotel.cz. [37.188.185.40])
        by smtp.gmail.com with ESMTPSA id a10sm6398675wmf.46.2020.05.28.07.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 07:44:12 -0700 (PDT)
Date:   Thu, 28 May 2020 16:44:10 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Zefan Li <lizefan@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Cgroups <cgroups@vger.kernel.org>, linux-mm@kvack.org,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>
Subject: Re: [PATCH v3] memcg: Fix memcg_kmem_bypass() for remote memcg
 charging
Message-ID: <20200528144410.GE27484@dhcp22.suse.cz>
References: <e6927a82-949c-bdfd-d717-0a14743c6759@huawei.com>
 <20200513090502.GV29153@dhcp22.suse.cz>
 <76f71776-d049-7407-8574-86b6e9d80704@huawei.com>
 <20200513112905.GX29153@dhcp22.suse.cz>
 <1d202a12-26fe-0012-ea14-f025ddcd044a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d202a12-26fe-0012-ea14-f025ddcd044a@huawei.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 26-05-20 09:25:25, Li Zefan wrote:
> While trying to use remote memcg charging in an out-of-tree kernel module
> I found it's not working, because the current thread is a workqueue thread.
> 
> As we will probably encounter this issue in the future as the users of
> memalloc_use_memcg() grow, and it's nothing wrong for this usage, it's
> better we fix it now.
> 
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Zefan Li <lizefan@huawei.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
> 
> v3: bypass __GFP_ACCOUNT allocations in interrupt contexts.
> 
> ---
>  mm/memcontrol.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index a3b97f1..3c7717a 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2802,7 +2802,12 @@ static void memcg_schedule_kmem_cache_create(struct mem_cgroup *memcg,
>  
>  static inline bool memcg_kmem_bypass(void)
>  {
> -	if (in_interrupt() || !current->mm || (current->flags & PF_KTHREAD))
> +	if (in_interrupt())
> +		return true;
> +
> +	/* Allow remote memcg charging in kthread contexts. */
> +	if ((!current->mm || (current->flags & PF_KTHREAD)) &&
> +	     !current->active_memcg)
>  		return true;
>  	return false;
>  }
> -- 
> 2.7.4

-- 
Michal Hocko
SUSE Labs
