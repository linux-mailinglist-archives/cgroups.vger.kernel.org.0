Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF1B0186DFC
	for <lists+cgroups@lfdr.de>; Mon, 16 Mar 2020 15:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731676AbgCPO7C (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 16 Mar 2020 10:59:02 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32824 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731673AbgCPO7C (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 16 Mar 2020 10:59:02 -0400
Received: by mail-wr1-f65.google.com with SMTP id a25so21641960wrd.0;
        Mon, 16 Mar 2020 07:59:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pRHZ/81/kzUik27LyIjeUOcKEhttC2wz2iMI5IMU5Lc=;
        b=D2Py+30p/XjRCj2aQLR65Uxb6hLEF6CVjL65nTfbB8Y7BqXBJcSTLathTnfThpF/kE
         UZJeHSLKhCjms3CiK88LZJJ5VA0F43A8Bs6Qk7iiXumarkhqYvI6davKI7B+4NxJnZVU
         3TAMhErkU4hlRuORpQBhq3wj8qjxcYA/dIN6z9J+ovqEvcpr85EkpgGhkXdkyLBE4VRI
         z9TUKg39mkuWOA9HlwqQ+RB1S8ujp8mmSdTPmfL9UFUnNk/zb6ejnOIELo1MLRIO/Wju
         WEn2hc5o327RxY1R3Mao8yvxiio7X/d2irf1Bx7sIY/IN30OTmVs8DLQApyexDM+W/Nj
         DYhQ==
X-Gm-Message-State: ANhLgQ2OM7F4656b8qcWSwkEutvuKW5KMGG6fuYT60dGyXuYCekgrYoD
        I7IQsFLkuG8ADQD3dKJThs8=
X-Google-Smtp-Source: ADFU+vupN5bWVeVlVahplDj5UFn5L9wamTUU+oZUW+uE+t3SV11JzAtqbznmWnsTdoMiIlJiBl/ItQ==
X-Received: by 2002:a5d:5444:: with SMTP id w4mr4679831wrv.387.1584370740577;
        Mon, 16 Mar 2020 07:59:00 -0700 (PDT)
Received: from localhost ([37.188.132.163])
        by smtp.gmail.com with ESMTPSA id s127sm31023841wmf.28.2020.03.16.07.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 07:58:59 -0700 (PDT)
Date:   Mon, 16 Mar 2020 15:58:59 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 5/6] mm, memcg: Prevent memory.swap.max load tearing
Message-ID: <20200316145859.GQ11482@dhcp22.suse.cz>
References: <cover.1584034301.git.chris@chrisdown.name>
 <bbec2c3d822217334855c8877a9d28b2a6d395fb.1584034301.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbec2c3d822217334855c8877a9d28b2a6d395fb.1584034301.git.chris@chrisdown.name>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 12-03-20 17:33:11, Chris Down wrote:
> The write side of this is xchg()/smp_mb(), so that's all good. Just a
> few sites missing a READ_ONCE.
> 
> Signed-off-by: Chris Down <chris@chrisdown.name>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: linux-mm@kvack.org
> Cc: cgroups@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: kernel-team@fb.com

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memcontrol.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index e0ed790a2a8c..57048a38c75d 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1511,7 +1511,7 @@ void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
>  	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
>  		pr_info("swap: usage %llukB, limit %llukB, failcnt %lu\n",
>  			K((u64)page_counter_read(&memcg->swap)),
> -			K((u64)memcg->swap.max), memcg->swap.failcnt);
> +			K((u64)READ_ONCE(memcg->swap.max)), memcg->swap.failcnt);
>  	else {
>  		pr_info("memory+swap: usage %llukB, limit %llukB, failcnt %lu\n",
>  			K((u64)page_counter_read(&memcg->memsw)),
> @@ -1544,7 +1544,7 @@ unsigned long mem_cgroup_get_max(struct mem_cgroup *memcg)
>  		unsigned long swap_max;
>  
>  		memsw_max = memcg->memsw.max;
> -		swap_max = memcg->swap.max;
> +		swap_max = READ_ONCE(memcg->swap.max);
>  		swap_max = min(swap_max, (unsigned long)total_swap_pages);
>  		max = min(max + swap_max, memsw_max);
>  	}
> @@ -7025,7 +7025,8 @@ bool mem_cgroup_swap_full(struct page *page)
>  		return false;
>  
>  	for (; memcg != root_mem_cgroup; memcg = parent_mem_cgroup(memcg))
> -		if (page_counter_read(&memcg->swap) * 2 >= memcg->swap.max)
> +		if (page_counter_read(&memcg->swap) * 2 >=
> +		    READ_ONCE(memcg->swap.max))
>  			return true;
>  
>  	return false;
> -- 
> 2.25.1
> 

-- 
Michal Hocko
SUSE Labs
