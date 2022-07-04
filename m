Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5855756598D
	for <lists+cgroups@lfdr.de>; Mon,  4 Jul 2022 17:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234525AbiGDPM6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 Jul 2022 11:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234043AbiGDPM5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 Jul 2022 11:12:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9556FF0;
        Mon,  4 Jul 2022 08:12:56 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 500211FD39;
        Mon,  4 Jul 2022 15:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1656947575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oVYS4bUOdNSsnRwjamBfXVxY7OYzKvz0dEnKnULT0m0=;
        b=vOdePtXjqkrtYTUiDZM/PSpsWTz3hI/lFsIqeA7Te+9fPmJnmkUo6UsDy3Lw8zQifjAOmj
        jGKhW6fCofSwiJadpjagD0gBDjoctYt6jNKPjCTcaeJaquJzE7jNXSpG/X6hpycqMcSAyZ
        RyYqM5I9fvWSREHqqKaoaAinKDszAvE=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1A7562C141;
        Mon,  4 Jul 2022 15:12:55 +0000 (UTC)
Date:   Mon, 4 Jul 2022 17:12:54 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol: do not miss MEMCG_MAX events for
 enforced allocations
Message-ID: <YsMDdjc5SXMAuV2l@dhcp22.suse.cz>
References: <20220702033521.64630-1-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220702033521.64630-1-roman.gushchin@linux.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 01-07-22 20:35:21, Roman Gushchin wrote:
> Yafang Shao reported an issue related to the accounting of bpf
> memory: if a bpf map is charged indirectly for memory consumed
> from an interrupt context and allocations are enforced, MEMCG_MAX
> events are not raised.

So I guess this will be a GFP_ATOMIC request failing due to the hard
limit, right? I think it would be easier to understand if the specific
allocation request type was mentioned.

> It's not/less of an issue in a generic case because consequent
> allocations from a process context will trigger the reclaim and
> MEMCG_MAX events. However a bpf map can belong to a dying/abandoned
> memory cgroup, so it might never happen. So the cgroup can
> significantly exceed the memory.max limit without even triggering
> MEMCG_MAX events.

More on that in other reply.

> Fix this by making sure that we never enforce allocations without
> raising a MEMCG_MAX event.
> 
> Reported-by: Yafang Shao <laoar.shao@gmail.com>
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Muchun Song <songmuchun@bytedance.com>
> Cc: cgroups@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: bpf@vger.kernel.org

The patch makes sense to me though even without the weird charge to a
dead memcg aspect. It is true that a very calm memcg can trigger the
even much later after a GFP_ATOMIC charge (or __GFP_HIGH in general)
fails.

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memcontrol.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 655c09393ad5..eb383695659a 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2577,6 +2577,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	bool passed_oom = false;
>  	bool may_swap = true;
>  	bool drained = false;
> +	bool raised_max_event = false;
>  	unsigned long pflags;
>  
>  retry:
> @@ -2616,6 +2617,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  		goto nomem;
>  
>  	memcg_memory_event(mem_over_limit, MEMCG_MAX);
> +	raised_max_event = true;
>  
>  	psi_memstall_enter(&pflags);
>  	nr_reclaimed = try_to_free_mem_cgroup_pages(mem_over_limit, nr_pages,
> @@ -2682,6 +2684,13 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	if (!(gfp_mask & (__GFP_NOFAIL | __GFP_HIGH)))
>  		return -ENOMEM;
>  force:
> +	/*
> +	 * If the allocation has to be enforced, don't forget to raise
> +	 * a MEMCG_MAX event.
> +	 */
> +	if (!raised_max_event)
> +		memcg_memory_event(mem_over_limit, MEMCG_MAX);
> +
>  	/*
>  	 * The allocation either can't fail or will lead to more memory
>  	 * being freed very soon.  Allow memory usage go over the limit
> -- 
> 2.36.1

-- 
Michal Hocko
SUSE Labs
