Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEEA1E7813
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2020 10:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725355AbgE2ITO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 29 May 2020 04:19:14 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38332 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgE2ITN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 29 May 2020 04:19:13 -0400
Received: by mail-wr1-f66.google.com with SMTP id e1so2445976wrt.5;
        Fri, 29 May 2020 01:19:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G1DHa95zQ0abeyOJd2kcqi3BLBnsdfZBM/mDmW1g3Eg=;
        b=naRDOAuaBK7/U5thIpgYueMieMWtNXTQemh0pMpuRBY8UXKcGSob0nGVk4tEaxW20k
         CwDeBS9hyLZKojCFmJewv4QRqTDxP3j/02u4JyUQxygE3hfef8olndJFvP1BwxK2+mKx
         z6STk3dObzPjhV223T1MNG/PB15szF3gEuw+s/lX7GfB5qPF3/J54QztYtG34QHJrbQ2
         pcmewp1+tF4E/hPihxDMv9pOhiMYaEygQEV2aGjHTLACuLFKMFt2y0+1vj230jJo+NGk
         dnkKM/eMRsCT2c0iFDe3NNy+cJgsXFHyafzK3xdxviMd41cFw3eWV8RjEMlUmRtYgD4h
         oQNQ==
X-Gm-Message-State: AOAM532NwcHwyqf6myJ5JA3Ddd0GNMRGo8Frv8zQdX98PJIqw+UpccWW
        PgxvPkzwtTYZgCCAKxTQzyM=
X-Google-Smtp-Source: ABdhPJy2lltktDx3yZpzMUTqglOo2k7IPNMZmSEVKGS7oa0sLsL8qEDzCDuGKYYBzTmO8CsZpcFRyw==
X-Received: by 2002:a5d:6586:: with SMTP id q6mr6115612wru.319.1590740351536;
        Fri, 29 May 2020 01:19:11 -0700 (PDT)
Received: from localhost (ip-37-188-185-40.eurotel.cz. [37.188.185.40])
        by smtp.gmail.com with ESMTPSA id a6sm8957998wrn.38.2020.05.29.01.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 01:19:10 -0700 (PDT)
Date:   Fri, 29 May 2020 10:19:09 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>, Tejun Heo <tj@kernel.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol: fix an unused-function warning
Message-ID: <20200529081909.GG4406@dhcp22.suse.cz>
References: <20200528095640.151454-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528095640.151454-1-arnd@arndb.de>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 28-05-20 11:56:26, Arnd Bergmann wrote:
> On NOMMU kernels without CONFIG_MEMCG_KMEM, we now get a harmless
> warning about an unused function:
> 
> mm/memcontrol.c:2595:13: error: unused function 'cancel_charge' [-Werror,-Wunused-function]
> 
> Hide this function in a matching #ifdef.
> 
> Fixes: 5bd144bf764c ("mm: memcontrol: drop unused try/commit/cancel charge API")

This is a linux-next sha1 which is not valid anymore. I would just drop
the tag.

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!
> ---
>  mm/memcontrol.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index f14da7a7348b..7bfca0abb8e1 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2592,6 +2592,7 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	return 0;
>  }
>  
> +#if defined(CONFIG_MEMCG_KMEM) || defined(CONFIG_MMU)
>  static void cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)
>  {
>  	if (mem_cgroup_is_root(memcg))
> @@ -2603,6 +2604,7 @@ static void cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)
>  
>  	css_put_many(&memcg->css, nr_pages);
>  }
> +#endif
>  
>  static void commit_charge(struct page *page, struct mem_cgroup *memcg)
>  {
> -- 
> 2.26.2
> 

-- 
Michal Hocko
SUSE Labs
