Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3843D4D7EDC
	for <lists+cgroups@lfdr.de>; Mon, 14 Mar 2022 10:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238068AbiCNJma (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Mar 2022 05:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237970AbiCNJmY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Mar 2022 05:42:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DA34552A
        for <cgroups@vger.kernel.org>; Mon, 14 Mar 2022 02:41:14 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8385B1F388;
        Mon, 14 Mar 2022 09:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1647250873; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vjCAmfOeIAmJsBLZGTQdftIhcJ0qr7uynuuuQ3TesCo=;
        b=NzzajjqEfhDUN2nmysnf+Itb4aFQe8SNtcbcddDI3ZQKOLMqLXLomuKFhQbSjmDeW6Lekw
        7b5Hl1XvWv8QXxMRHPR6mBKZIsXYiF69jyNsz+nsuhsZ2iZB/auOvRvq5e22Q+WIs2Hc3R
        DfgIu7LRtH+3wSJn0pEhnJzOMIKDtUE=
Received: from suse.cz (unknown [10.163.30.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 624B9A3B92;
        Mon, 14 Mar 2022 09:41:13 +0000 (UTC)
Date:   Mon, 14 Mar 2022 10:41:13 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [Patch v2 3/3] mm/memcg: add next_mz back to soft limit tree if
 not reclaimed yet
Message-ID: <Yi8NudEX/sZsO2nO@dhcp22.suse.cz>
References: <20220312071623.19050-1-richard.weiyang@gmail.com>
 <20220312071623.19050-3-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220312071623.19050-3-richard.weiyang@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat 12-03-22 07:16:23, Wei Yang wrote:
> When memory reclaim failed for a maximum number of attempts and we bail
> out of the reclaim loop, we forgot to put the target mem_cgroup chosen
> for next reclaim back to the soft limit tree. This prevented pages in
> the mem_cgroup from being reclaimed in the future even though the
> mem_cgroup exceeded its soft limit.
> 
> Let's say there are two mem_cgroup and both of them exceed the soft
> limit, while the first one is more active then the second. Since we add
> a mem_cgroup to soft limit tree every 1024 event, the second one just
> get a rare chance to be put on soft limit tree even it exceeds the
> limit.

yes, 1024 could be just 4MB of memory or 2GB if all the charged pages
are THPs. So the excess can build up considerably.

> As time goes on, the first mem_cgroup was kept close to its soft limit
> due to reclaim activities, while the memory usage of the second
> mem_cgroup keeps growing over the soft limit for a long time due to its
> relatively rare occurrence.
> 
> This patch adds next_mz back to prevent this sceanrio.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>

Even though your changelog is different the change itself is identical to
https://lore.kernel.org/linux-mm/8d35206601ccf0e1fe021d24405b2a0c2f4e052f.1613584277.git.tim.c.chen@linux.intel.com/
In those cases I would preserve the the original authorship by
From: Tim Chen <tim.c.chen@linux.intel.com>
and add his s-o-b before yours.

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  mm/memcontrol.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 344a7e891bc5..e803ff02aae2 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3493,8 +3493,13 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
>  			loop > MEM_CGROUP_MAX_SOFT_LIMIT_RECLAIM_LOOPS))
>  			break;
>  	} while (!nr_reclaimed);
> -	if (next_mz)
> +	if (next_mz) {
> +		spin_lock_irq(&mctz->lock);
> +		excess = soft_limit_excess(next_mz->memcg);
> +		__mem_cgroup_insert_exceeded(next_mz, mctz, excess);
> +		spin_unlock_irq(&mctz->lock);
>  		css_put(&next_mz->memcg->css);
> +	}
>  	return nr_reclaimed;
>  }
>  
> -- 
> 2.33.1

-- 
Michal Hocko
SUSE Labs
