Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE612F4D82
	for <lists+cgroups@lfdr.de>; Wed, 13 Jan 2021 15:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbhAMOrn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Jan 2021 09:47:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:58200 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727102AbhAMOrm (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 13 Jan 2021 09:47:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610549215; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nt0P3UB52tUXihhKnY0EGJSOwPIXl2w0VfMCeDXigfg=;
        b=MaYTpfeBCSb+4GfytJrC3yMQ85mJn3wsQrdPMm3X8mJpdVwihUs+pt5UikXfQ4Js75AVXa
        p+88RPnduouIF3z9abzeMfvM3SCYKBhdqRIhhKakryDlNAwM89t/a65OMRWqoBMjPH7Fg8
        YApkvhaPiozFN1PYsTU6iJ2/ww75CGU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 62A00AB92;
        Wed, 13 Jan 2021 14:46:55 +0000 (UTC)
Date:   Wed, 13 Jan 2021 15:46:54 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] mm: memcontrol: prevent starvation when writing
 memory.high
Message-ID: <20210113144654.GD22493@dhcp22.suse.cz>
References: <20210112163011.127833-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112163011.127833-1-hannes@cmpxchg.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 12-01-21 11:30:11, Johannes Weiner wrote:
> When a value is written to a cgroup's memory.high control file, the
> write() context first tries to reclaim the cgroup to size before
> putting the limit in place for the workload. Concurrent charges from
> the workload can keep such a write() looping in reclaim indefinitely.
> 
> In the past, a write to memory.high would first put the limit in place
> for the workload, then do targeted reclaim until the new limit has
> been met - similar to how we do it for memory.max. This wasn't prone
> to the described starvation issue. However, this sequence could cause
> excessive latencies in the workload, when allocating threads could be
> put into long penalty sleeps on the sudden memory.high overage created
> by the write(), before that had a chance to work it off.
> 
> Now that memory_high_write() performs reclaim before enforcing the new
> limit, reflect that the cgroup may well fail to converge due to
> concurrent workload activity. Bail out of the loop after a few tries.

I can see that you have provided some more details in follow up replies
but I do not see any explicit argument why an excessive time for writer
is an actual problem. Could you be more specific?

If the writer is time sensitive then there is a trivial way to
workaround that and kill it by a signal (timeout 30s echo ....).

Btw. this behavior has been considered http://lkml.kernel.org/r/20200710122917.GB3022@dhcp22.suse.cz/
"
With this change
the reclaim here might be just playing never ending catch up. On the
plus side a break out from the reclaim loop would just enforce the limit
so if the operation takes too long then the reclaim burden will move
over to consumers eventually. So I do not see any real danger.
"

> Fixes: 536d3bf261a2 ("mm: memcontrol: avoid workload stalls when lowering memory.high")
> Cc: <stable@vger.kernel.org> # 5.8+

Why is this worth backporting to stable? The behavior is different but I
do not think any of them is harmful.

> Reported-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

I am not against the patch. The existing interface doesn't provide any
meaningful feedback to the userspace anyway. User would have to re check
to see the result of the operation. So how hard we try is really an
implementation detail.

> ---
>  mm/memcontrol.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 605f671203ef..63a8d47c1cd3 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6275,7 +6275,6 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
>  
>  	for (;;) {
>  		unsigned long nr_pages = page_counter_read(&memcg->memory);
> -		unsigned long reclaimed;
>  
>  		if (nr_pages <= high)
>  			break;
> @@ -6289,10 +6288,10 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
>  			continue;
>  		}
>  
> -		reclaimed = try_to_free_mem_cgroup_pages(memcg, nr_pages - high,
> -							 GFP_KERNEL, true);
> +		try_to_free_mem_cgroup_pages(memcg, nr_pages - high,
> +					     GFP_KERNEL, true);
>  
> -		if (!reclaimed && !nr_retries--)
> +		if (!nr_retries--)
>  			break;
>  	}
>  
> -- 
> 2.30.0
> 

-- 
Michal Hocko
SUSE Labs
