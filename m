Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C310E590978
	for <lists+cgroups@lfdr.de>; Fri, 12 Aug 2022 02:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235738AbiHLANA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 11 Aug 2022 20:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234978AbiHLAM7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 11 Aug 2022 20:12:59 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E627512D21
        for <cgroups@vger.kernel.org>; Thu, 11 Aug 2022 17:12:57 -0700 (PDT)
Date:   Thu, 11 Aug 2022 17:12:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1660263175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uFp8sxdZCqziEXG2pBLb8/hRTqBA78it3qFFGSkqrcI=;
        b=HzumCH6sIq9pLPq+y0DiDANXUz4otZQI3BmvtlO/AJOEzlyerWa5fsgw5u3nzpa4tMuxAN
        B2qBYAioS1mV+YIxvc1EyuP9WQYkNZ52dKalM14OQy5NYHbYMIn0xRxb6tdfBnNLf54ojK
        +uwJqQT+wLTi05K/FImRS/B8e28U5fs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     liliguang <liliguang@baidu.com>
Cc:     cgroups@vger.kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
        shakeelb@google.com, songmuchun@bytedance.com
Subject: Re: [PATCH] mm: correctly charge compressed memory to its memcg
Message-ID: <YvWa9MOQWBICInjO@P9FQF9L96D.corp.robot.car>
References: <20220811081913.102770-1-liliguang@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811081913.102770-1-liliguang@baidu.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Aug 11, 2022 at 04:19:13PM +0800, liliguang wrote:
> From: Li Liguang <liliguang@baidu.com>
> 
> Kswapd will reclaim memory when memory pressure is high, the
> annonymous memory will be compressed and stored in the zpool
> if zswap is enabled. The memcg_kmem_bypass() in
> get_obj_cgroup_from_page() will bypass the kernel thread and
> cause the compressed memory not charged to its memory cgroup.
> 
> Remove the memcg_kmem_bypass() and properly charge compressed
> memory to its corresponding memory cgroup.
> 
> Signed-off-by: Li Liguang <liliguang@baidu.com>
> ---
>  mm/memcontrol.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index b69979c9ced5..6a95ea7c5ee7 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2971,7 +2971,7 @@ struct obj_cgroup *get_obj_cgroup_from_page(struct page *page)
>  {
>  	struct obj_cgroup *objcg;
>  
> -	if (!memcg_kmem_enabled() || memcg_kmem_bypass())
> +	if (!memcg_kmem_enabled())
>  		return NULL;
>  
>  	if (PageMemcgKmem(page)) {
> -- 
> 2.32.0 (Apple Git-132)
> 

Hi Li!

The fix looks good to me! As we get objcg pointer from a page and not from
the current task, memcg_kmem_bypass() doesn't makes much sense.

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Probably, we need to add
Fixes: f4840ccfca25 ("zswap: memcg accounting")

Thank you!
