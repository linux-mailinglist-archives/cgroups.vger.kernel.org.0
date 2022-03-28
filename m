Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F264E9620
	for <lists+cgroups@lfdr.de>; Mon, 28 Mar 2022 14:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbiC1MDQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Mar 2022 08:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242154AbiC1MDP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Mar 2022 08:03:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAB1767C;
        Mon, 28 Mar 2022 05:01:34 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7A2AD210EB;
        Mon, 28 Mar 2022 12:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1648468893; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c6Z5kgi2wB4asWItH9cY1KuHpvBDFVgytOlK7MLeiuA=;
        b=Gog9U0tdKPz+Wl+YHWZ8KNw1A2fwCjwtYp9Q+XJJJNcvkWmFWqyrbmiUHjSlgjYzBI9y0J
        R6gzG0GJ2Tj4tUSrSMqZkjJvpYL2NKDYqOXZGRaD8Eiof5wjPpJUf7xPAYYbI/9EWoEXpI
        4Y/n/ZiTuszwootYfN1QRb8I1uNjI4s=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 18364A3B82;
        Mon, 28 Mar 2022 12:01:33 +0000 (UTC)
Date:   Mon, 28 Mar 2022 14:01:32 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     hannes@cmpxchg.org, roman.gushchin@linux.dev, shakeelb@google.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memcg: remove unneeded nr_scanned
Message-ID: <YkGjnAOidFD8bA3a@dhcp22.suse.cz>
References: <20220328114144.53389-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328114144.53389-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 28-03-22 19:41:44, Miaohe Lin wrote:
> The local variable nr_scanned is unneeded as mem_cgroup_soft_reclaim always
> does *total_scanned += nr_scanned. So we can pass total_scanned directly to
> the mem_cgroup_soft_reclaim to simplify the code and save some cpu cycles
> of adding nr_scanned to total_scanned.

Maybe the compiler could be clever enough to generate a good code.
mem_cgroup_soft_reclaim doesn't have other caller so it could be
inlined. But I do agree that the change makes sense because it makes the
code more consistent as mem_cgroup_soft_limit_reclaim already uses
total_scanned this way.

> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks

> ---
>  mm/memcontrol.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index b686ec4f42c6..79341365ec90 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3384,7 +3384,6 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
>  	int loop = 0;
>  	struct mem_cgroup_tree_per_node *mctz;
>  	unsigned long excess;
> -	unsigned long nr_scanned;
>  
>  	if (order > 0)
>  		return 0;
> @@ -3412,11 +3411,9 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
>  		if (!mz)
>  			break;
>  
> -		nr_scanned = 0;
>  		reclaimed = mem_cgroup_soft_reclaim(mz->memcg, pgdat,
> -						    gfp_mask, &nr_scanned);
> +						    gfp_mask, total_scanned);
>  		nr_reclaimed += reclaimed;
> -		*total_scanned += nr_scanned;
>  		spin_lock_irq(&mctz->lock);
>  		__mem_cgroup_remove_exceeded(mz, mctz);
>  
> -- 
> 2.23.0

-- 
Michal Hocko
SUSE Labs
