Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8156E556F4F
	for <lists+cgroups@lfdr.de>; Thu, 23 Jun 2022 02:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbiFWAQy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Jun 2022 20:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiFWAQx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Jun 2022 20:16:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CE23DDE5;
        Wed, 22 Jun 2022 17:16:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 57788B82049;
        Thu, 23 Jun 2022 00:16:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F72EC34114;
        Thu, 23 Jun 2022 00:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1655943408;
        bh=0HHOSMhVBBKa0mo1Ox4swwAng7m4PNBNQ15WTnWPLgs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uffvUBvnICh3cunCqu0zSZ1OAiv7ZIIt1RMEKeKs8/4hNLKU03og4Wofr+bZS4Sm1
         d74wVtvf2ahSh8kTJYA5ooQeLQUProiI6/f9Us2iMab2lApNEOpHbnhAY3MmfamYb5
         EIf6KaSw1DitFZCIrHU3wrQ897oXGvxQPVC783OU=
Date:   Wed, 22 Jun 2022 17:16:24 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>, NeilBrown <neilb@suse.de>,
        Alistair Popple <apopple@nvidia.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: vmpressure: don't count userspace-induced reclaim
 as memory pressure
Message-Id: <20220622171624.fc7de8d0ab18a5cf663f8ab8@linux-foundation.org>
In-Reply-To: <20220623000530.1194226-1-yosryahmed@google.com>
References: <20220623000530.1194226-1-yosryahmed@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, 23 Jun 2022 00:05:30 +0000 Yosry Ahmed <yosryahmed@google.com> wrote:

> Commit e22c6ed90aa9 ("mm: memcontrol: don't count limit-setting reclaim
> as memory pressure") made sure that memory reclaim that is induced by
> userspace (limit-setting, proactive reclaim, ..) is not counted as
> memory pressure for the purposes of psi.
> 
> Instead of counting psi inside try_to_free_mem_cgroup_pages(), callers
> from try_charge() and reclaim_high() wrap the call to
> try_to_free_mem_cgroup_pages() with psi handlers.
> 
> However, vmpressure is still counted in these cases where reclaim is
> directly induced by userspace. This patch makes sure vmpressure is not
> counted in those operations, in the same way as psi. Since vmpressure
> calls need to happen deeper within the reclaim path, the same approach
> could not be followed. Hence, a new "controlled" flag is added to struct
> scan_control to flag a reclaim operation that is controlled by
> userspace. This flag is set by limit-setting and proactive reclaim
> operations, and is used to count vmpressure correctly.
> 
> To prevent future divergence of psi and vmpressure, commit e22c6ed90aa9
> ("mm: memcontrol: don't count limit-setting reclaim as memory pressure")
> is effectively reverted and the same flag is used to control psi as
> well.

I'll await reviewer input on this, but I can always do trivia!

> @@ -3502,6 +3497,8 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
>  static int mem_cgroup_force_empty(struct mem_cgroup *memcg)
>  {
>  	int nr_retries = MAX_RECLAIM_RETRIES;
> +	unsigned int reclaim_options = MEMCG_RECLAIM_CONTROLLED |
> +		MEMCG_RECLAIM_MAY_SWAP;

If it doesn't fit, it's nicer to do

	unsigned int reclaim_options;
	...

	reclaim_options = MEMCG_RECLAIM_CONTROLLED | MEMCG_RECLAIM_MAY_SWAP;

(several places)

> @@ -3751,6 +3757,7 @@ unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
>  		.may_writepage = !laptop_mode,
>  		.may_unmap = 1,
>  		.may_swap = 1,
> +		.controlled = 0,
>  	};

Let's just skip all these initializations to zero, let the compiler take
care of it.

> @@ -4095,6 +4112,7 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
>  		.gfp_mask = GFP_KERNEL,
>  		.order = order,
>  		.may_unmap = 1,
> +		.controlled = 0,
>  	};
>  
>  	set_task_reclaim_state(current, &sc.reclaim_state);
> @@ -4555,6 +4573,7 @@ unsigned long shrink_all_memory(unsigned long nr_to_reclaim)
>  		.may_unmap = 1,
>  		.may_swap = 1,
>  		.hibernation_mode = 1,
> +		.controlled = 0,
>  	};
>  	struct zonelist *zonelist = node_zonelist(numa_node_id(), sc.gfp_mask);
>  	unsigned long nr_reclaimed;
> @@ -4707,6 +4726,7 @@ static int __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned in
>  		.may_unmap = !!(node_reclaim_mode & RECLAIM_UNMAP),
>  		.may_swap = 1,
>  		.reclaim_idx = gfp_zone(gfp_mask),
> +		.controlled = 0,
>  	};
>  	unsigned long pflags;


