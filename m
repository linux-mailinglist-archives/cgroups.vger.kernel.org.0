Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59BD9E1291
	for <lists+cgroups@lfdr.de>; Wed, 23 Oct 2019 08:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbfJWG7w (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Oct 2019 02:59:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:44714 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727194AbfJWG7w (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 23 Oct 2019 02:59:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2CC14B5D8;
        Wed, 23 Oct 2019 06:59:50 +0000 (UTC)
Date:   Wed, 23 Oct 2019 08:59:49 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 2/2] mm: memcontrol: try harder to set a new memory.high
Message-ID: <20191023065949.GD754@dhcp22.suse.cz>
References: <20191022201518.341216-1-hannes@cmpxchg.org>
 <20191022201518.341216-2-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022201518.341216-2-hannes@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 22-10-19 16:15:18, Johannes Weiner wrote:
> Setting a memory.high limit below the usage makes almost no effort to
> shrink the cgroup to the new target size.
> 
> While memory.high is a "soft" limit that isn't supposed to cause OOM
> situations, we should still try harder to meet a user request through
> persistent reclaim.
> 
> For example, after setting a 10M memory.high on an 800M cgroup full of
> file cache, the usage shrinks to about 350M:
> 
> + cat /cgroup/workingset/memory.current
> 841568256
> + echo 10M
> + cat /cgroup/workingset/memory.current
> 355729408
> 
> This isn't exactly what the user would expect to happen. Setting the
> value a few more times eventually whittles the usage down to what we
> are asking for:
> 
> + echo 10M
> + cat /cgroup/workingset/memory.current
> 104181760
> + echo 10M
> + cat /cgroup/workingset/memory.current
> 31801344
> + echo 10M
> + cat /cgroup/workingset/memory.current
> 10440704
> 
> To improve this, add reclaim retry loops to the memory.high write()
> callback, similar to what we do for memory.max, to make a reasonable
> effort that the usage meets the requested size after the call returns.

That suggests that the reclaim couldn't meet the given reclaim target
but later attempts just made it through. Is this due to amount of dirty
pages or what prevented the reclaim to do its job?

While I am not against the reclaim retry loop I would like to understand
the underlying issue. Because if this is really about dirty memory then
we should probably be more pro-active in flushing it. Otherwise the
retry might not be of any help.

> Afterwards, a single write() to memory.high is enough in all but
> extreme cases:
> 
> + cat /cgroup/workingset/memory.current
> 841609216
> + echo 10M
> + cat /cgroup/workingset/memory.current
> 10182656
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/memcontrol.c | 30 ++++++++++++++++++++++++------
>  1 file changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index ff90d4e7df37..8090b4c99ac7 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6074,7 +6074,8 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
>  				 char *buf, size_t nbytes, loff_t off)
>  {
>  	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
> -	unsigned long nr_pages;
> +	unsigned int nr_retries = MEM_CGROUP_RECLAIM_RETRIES;
> +	bool drained = false;
>  	unsigned long high;
>  	int err;
>  
> @@ -6085,12 +6086,29 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
>  
>  	memcg->high = high;
>  
> -	nr_pages = page_counter_read(&memcg->memory);
> -	if (nr_pages > high)
> -		try_to_free_mem_cgroup_pages(memcg, nr_pages - high,
> -					     GFP_KERNEL, true);
> +	for (;;) {
> +		unsigned long nr_pages = page_counter_read(&memcg->memory);
> +		unsigned long reclaimed;
> +
> +		if (nr_pages <= high)
> +			break;
> +
> +		if (signal_pending(current))
> +			break;
> +
> +		if (!drained) {
> +			drain_all_stock(memcg);
> +			drained = true;
> +			continue;
> +		}
> +
> +		reclaimed = try_to_free_mem_cgroup_pages(memcg, nr_pages - high,
> +							 GFP_KERNEL, true);
> +
> +		if (!reclaimed && !nr_retries--)
> +			break;
> +	}
>  
> -	memcg_wb_domain_size_changed(memcg);
>  	return nbytes;
>  }
>  
> -- 
> 2.23.0

-- 
Michal Hocko
SUSE Labs
