Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C737502B85
	for <lists+cgroups@lfdr.de>; Fri, 15 Apr 2022 16:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354289AbiDOOOJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 Apr 2022 10:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233185AbiDOOOI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 Apr 2022 10:14:08 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B739112082;
        Fri, 15 Apr 2022 07:11:39 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id cp8so2974481qtb.6;
        Fri, 15 Apr 2022 07:11:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8E15QlB3HPuBteXprlcuviW/b5J/6kl81TXCE70Tq7U=;
        b=tnoj8u7oyYwq9p3YP2BrOrSHcn6XyTtnO9OXS7xN1hvEFRr4iJ1hkfw5tL2bokfEbJ
         sIrs4TA2G5vBMnv6K52au7qeGFj6xd27t9hgqJ0pF3gQJPG5oJABKKnbWTig6dJTuwyf
         ZA7P4yXSWBPU+z0XncbH+fJG2hz3PIXC5F9bsDrrpMw+skSX9i6AdWzJwn1+LJiApVpQ
         7OtfMdvCluZETaI9Q+vW37mSX8PqYv9c1aL5Bo+7g+kkCAZTiyiaPf2T3F8u7ypXJFlt
         fE8CBHVu+0QJ1O6x1s1I8b+Qz3BfEJnWLJl6eV4yfVfikpJLeceU0XOUAjAC6OUPjkuW
         Wsnw==
X-Gm-Message-State: AOAM530A9BA/UqRq8SeAC7c7cQmpowhWVLkDoWRB1Vyi81Fv/wGG7Pzz
        GdXTz47bIcv89BeENcMeMFU=
X-Google-Smtp-Source: ABdhPJxo7azJtiSsLHamzFslbaIl+8exU9TumgAO+V+uquYiWqcftzLFrYa3mvdxI7zaYenM9Uvqjw==
X-Received: by 2002:a05:622a:1305:b0:2e1:e697:31e7 with SMTP id v5-20020a05622a130500b002e1e69731e7mr5562459qtk.97.1650031898640;
        Fri, 15 Apr 2022 07:11:38 -0700 (PDT)
Received: from dev0025.ash9.facebook.com (fwdproxy-ash-021.fbsv.net. [2a03:2880:20ff:15::face:b00c])
        by smtp.gmail.com with ESMTPSA id k189-20020a3788c6000000b0069c10860b10sm2576015qkd.107.2022.04.15.07.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 07:11:38 -0700 (PDT)
Date:   Fri, 15 Apr 2022 07:11:35 -0700
From:   David Vernet <void@manifault.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>
Subject: Re: [PATCH 2/4] kselftests: memcg: speed up the memory.high test
Message-ID: <20220415141135.mixe5hin3gvw5kgr@dev0025.ash9.facebook.com>
References: <20220415000133.3955987-1-roman.gushchin@linux.dev>
 <20220415000133.3955987-3-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220415000133.3955987-3-roman.gushchin@linux.dev>
User-Agent: NeoMutt/20211029
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 14, 2022 at 05:01:31PM -0700, Roman Gushchin wrote:
> After commit 0e4b01df8659 ("mm, memcg: throttle allocators when
> failing reclaim over memory.high") allocating memory over memory.high
> became very time consuming. But it's exactly what the memory.high
> test from cgroup kselftests is doing: it tries to allocate 100M with
> 30M memory.high value. It takes forever to complete.
> 
> In order to keep it passing (or failing) in a reasonable amount of
> time let's try to allocate only a little over 30M: 31M to be precise.
> 
> With this change test_memcontrol finishes in a reasonable amount of
> time:
>   $ time ./test_memcontrol
>   ok 1 test_memcg_subtree_control
>   ok 2 test_memcg_current
>   ok 3 test_memcg_min
>   ok 4 test_memcg_low
>   ok 5 test_memcg_high
>   ok 6 test_memcg_max
>   ok 7 test_memcg_oom_events
>   ok 8 test_memcg_swap_max
>   ok 9 test_memcg_sock
>   ok 10 test_memcg_oom_group_leaf_events
>   ok 11 test_memcg_oom_group_parent_events
>   ok 12 test_memcg_oom_group_score_events
> 
>   real	0m2.273s
>   user	0m0.064s
>   sys	0m0.739s
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Chris Down <chris@chrisdown.name>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  tools/testing/selftests/cgroup/test_memcontrol.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
> index 00b430e7f2a2..9c1f19fe2e37 100644
> --- a/tools/testing/selftests/cgroup/test_memcontrol.c
> +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
> @@ -607,7 +607,7 @@ static int test_memcg_high(const char *root)
>  	if (cg_write(memcg, "memory.high", "30M"))
>  		goto cleanup;
>  
> -	if (cg_run(memcg, alloc_anon, (void *)MB(100)))
> +	if (cg_run(memcg, alloc_anon, (void *)MB(31)))
>  		goto cleanup;
>  
>  	if (!cg_run(memcg, alloc_pagecache_50M_check, NULL))
> -- 
> 2.35.1
> 

Thanks for re-sending this. Looks good.

Reviewed-by: David Vernet <void@manifault.com>
