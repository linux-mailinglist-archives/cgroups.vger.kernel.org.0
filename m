Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD261F9593
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2020 13:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729729AbgFOLuM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Jun 2020 07:50:12 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40321 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729723AbgFOLuL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 15 Jun 2020 07:50:11 -0400
Received: by mail-ed1-f68.google.com with SMTP id p18so11265351eds.7;
        Mon, 15 Jun 2020 04:50:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+yej3bVZL44K62xgZNububEbDVqfkX9q5JcG1+/l7Jc=;
        b=mE4gMRUauiU6ALW5sFdo/PqYEExvUiUw37vuc8/yVyfCknZhqa0PXUhCMdfVWbybQI
         Pt8NqGbVO+ldhnsZ4KSFD1CeUiqUxGDPe8tu4vdHGJHNlF2Soq6PJTrpQBVHqNoPs6ZR
         uwL7uwyNoCsFdT3CCkGr/JubmO9dDn+46HffJGcqdayIA9oLoMi7N04IhaixJwVrZG66
         0Q5XgXm/z9HwS7aCwDltz7JfzqyOieqZzjGfUE8IgtHg8VUMEK0QKPrJ6uujVGkpu/bJ
         xO/cvch2XD03dB78jVAU8U8/YHCTDIciUcXaUs7pdCI/U/jYXcvTZM4UZGdlmWyFlh/p
         DFCw==
X-Gm-Message-State: AOAM533Iu2Jz/WDL2ZSQXL1KAbMzosNUf99Obq0vCAAY5ts+gy6KmJfw
        ju8WX1JqREptlt5w789hvaj2U1KH
X-Google-Smtp-Source: ABdhPJxTXOAUJWO+cQ1kN5xMafzmrUC0J7b1CqTCSIVBiaG/MZIqi3SY+cCxzo0reetQHnIS+CppLQ==
X-Received: by 2002:a50:9ead:: with SMTP id a42mr22645629edf.129.1592221809349;
        Mon, 15 Jun 2020 04:50:09 -0700 (PDT)
Received: from localhost (ip-37-188-174-201.eurotel.cz. [37.188.174.201])
        by smtp.gmail.com with ESMTPSA id o20sm8733405ejx.102.2020.06.15.04.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 04:50:08 -0700 (PDT)
Date:   Mon, 15 Jun 2020 13:50:07 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, guro@fb.com, cai@lca.pw,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol: Fix do not put the css reference
Message-ID: <20200615115007.GI25296@dhcp22.suse.cz>
References: <20200614122653.98829-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200614122653.98829-1-songmuchun@bytedance.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun 14-06-20 20:26:53, Muchun Song wrote:
> We should put the css reference when memory allocation failed.
> 
> Fixes: f0a3a24b532d ("mm: memcg/slab: rework non-root kmem_cache lifecycle management")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

This looks like a stable tree material to me.

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memcontrol.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 0b38b6ad547d..2323d811ee8e 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2772,8 +2772,10 @@ static void memcg_schedule_kmem_cache_create(struct mem_cgroup *memcg,
>  		return;
>  
>  	cw = kmalloc(sizeof(*cw), GFP_NOWAIT | __GFP_NOWARN);
> -	if (!cw)
> +	if (!cw) {
> +		css_put(&memcg->css);
>  		return;
> +	}
>  
>  	cw->memcg = memcg;
>  	cw->cachep = cachep;
> -- 
> 2.11.0

-- 
Michal Hocko
SUSE Labs
