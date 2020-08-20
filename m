Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E90E324C4A3
	for <lists+cgroups@lfdr.de>; Thu, 20 Aug 2020 19:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730585AbgHTRhL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Aug 2020 13:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730514AbgHTRhE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Aug 2020 13:37:04 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA14C061386
        for <cgroups@vger.kernel.org>; Thu, 20 Aug 2020 10:37:03 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id 6so1799980qtt.0
        for <cgroups@vger.kernel.org>; Thu, 20 Aug 2020 10:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LoboofYleSqsx6Po76z6KtFKykk6O4/M/law9ADONhQ=;
        b=bqapqgbGxSqIpTZ9lqM1OdRQ4ld0i+GkD+9Nmxa1GUtaiBn/O9VbQypsMHolHj0z6R
         O5BVPWUTxs1lPqRKqLIHUGDCBJLiJ4iTA7HIC6qB9jSaJjvKbm8SI/1kvGieeG0doLWJ
         OCDi+LYKIfxOKRk0/y7qOPc8DpMwu+WU3vD+l8KIvb21LNwGFGLgzaQthypuZUWvs+rs
         oJCpu+HfrIXROzi0WhrBWx4WpDDfRvE0lUwTcbI+9/X0czS0xt7v14LrRI0jg5MRRTp/
         LBDfwgBeTz7UfF8zOvwgvyF3yu6ue4PzybmMEWhEHmy34YliUAVBRRucg//JTWS0mIdc
         WDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LoboofYleSqsx6Po76z6KtFKykk6O4/M/law9ADONhQ=;
        b=sk5PQUh0ny1cQfsmRT4Xqt4BCgaRcTy4EtQFGZO6UvZvOE8KwXghIBBq1jUjZVsWO2
         QPCFPFd1QwJwcA26N89GEpy2MxilPc2htTAuFu1QlXy2ylRiyIcM/YFdktaEH1IYOpsK
         W4HlAiaNX2tc7ojDGDD0CiEEPCnoBpm4MUK14gI4l2TdXEzuq+U/K94+HhE73bG5a+Yw
         SFDQx8yzCyjVnmLpzRpLEyf24iI0jbClhWQRE1PzSydtqLXkAEVKkgWF7WK5g5Zo6bVi
         KIScyKPpPGi2CFfgvvBe98WX1IsrTkdZEiWV1EJ8Q7Kh2OHcT1SJyoSGkYvq/hGL6tKg
         WmPQ==
X-Gm-Message-State: AOAM5327ArhQ0TPufWmutnkc5WjqCvSb0RSMNYucWCMeFqqOks4BaFRT
        +d26ZFOdWC5hmGfd8UjkT0m3sQ==
X-Google-Smtp-Source: ABdhPJy0N3AzU+bC9wgIjMRXMwdsW3NNSoeyvr6MWRhCLnEfbQNcRW8bcmUt5YL0OIu+rlUywXSVzA==
X-Received: by 2002:ac8:c0e:: with SMTP id k14mr3885478qti.364.1597945021939;
        Thu, 20 Aug 2020 10:37:01 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:3cdd])
        by smtp.gmail.com with ESMTPSA id k11sm2653665qkk.93.2020.08.20.10.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 10:37:01 -0700 (PDT)
Date:   Thu, 20 Aug 2020 13:35:46 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Roman Gushchin <guro@fb.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH 2/3] mm/memcg: Simplify mem_cgroup_get_max()
Message-ID: <20200820173546.GB912520@cmpxchg.org>
References: <20200820130350.3211-1-longman@redhat.com>
 <20200820130350.3211-3-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820130350.3211-3-longman@redhat.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Aug 20, 2020 at 09:03:49AM -0400, Waiman Long wrote:
> The mem_cgroup_get_max() function used to get memory+swap max from
> both the v1 memsw and v2 memory+swap page counters & return the maximum
> of these 2 values. This is redundant and it is more efficient to just
> get either the v1 or the v2 values depending on which one is currently
> in use.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  mm/memcontrol.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 26b7a48d3afb..d219dca5239f 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1633,17 +1633,13 @@ void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
>   */
>  unsigned long mem_cgroup_get_max(struct mem_cgroup *memcg)
>  {
> -	unsigned long max;
> +	unsigned long max = READ_ONCE(memcg->memory.max);
>  
> -	max = READ_ONCE(memcg->memory.max);
>  	if (mem_cgroup_swappiness(memcg)) {
> -		unsigned long memsw_max;
> -		unsigned long swap_max;
> -
> -		memsw_max = memcg->memsw.max;
> -		swap_max = READ_ONCE(memcg->swap.max);
> -		swap_max = min(swap_max, (unsigned long)total_swap_pages);
> -		max = min(max + swap_max, memsw_max);
> +		if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
> +			max += READ_ONCE(memcg->swap.max);
> +		else
> +			max = memcg->memsw.max;

I agree with the premise of the patch, but v1 and v2 have sufficiently
different logic, and the way v1 overrides max from the innermost
branch again also doesn't help in understanding what's going on.

Can you please split out the v1 and v2 code?

	if (cgroup_subsys_on_dfl(memory_cgrp_subsys)) {
		max = READ_ONCE(memcg->memory.max);
		if (mem_cgroup_swappiness(memcg))
			max += READ_ONCE(memcg->swap.max);
	} else {
		if (mem_cgroup_swappiness(memcg))
			max = memcg->memsw.max;
		else
			max = READ_ONCE(memcg->memory.max);
	}

It's slightly repetitive, but IMO much more readable.
