Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9C8303639
	for <lists+cgroups@lfdr.de>; Tue, 26 Jan 2021 07:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbhAZGFB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 26 Jan 2021 01:05:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:36322 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbhAYJQK (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 25 Jan 2021 04:16:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611565115; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PW+ga58q4T1GO4Kq1Fd0BmEznrnJ+b7jHg2LKuh/ZIk=;
        b=LZzn+FFrwFdD8mekB41YvBeP54Xq1CDTztG27hogvGB8nNrLZq82n6Ra9f+LSpfvXZQvxW
        Bj461hJ6OsIt+XIMNoRfgq4r6xf93o7vCw3TC8by8FREEMWG9iowwlBXIMziJxrcHNr6Sr
        jsEDbHZBEXSYM7fzVZE49EaVHk4Zd0A=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 240ABADD6;
        Mon, 25 Jan 2021 08:58:35 +0000 (UTC)
Date:   Mon, 25 Jan 2021 09:58:33 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] Revert "mm: memcontrol: avoid workload stalls when
 lowering memory.high"
Message-ID: <20210125085833.GA827@dhcp22.suse.cz>
References: <20210122184341.292461-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122184341.292461-1-hannes@cmpxchg.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 22-01-21 13:43:41, Johannes Weiner wrote:
> This reverts commit 536d3bf261a2fc3b05b3e91e7eef7383443015cf, as it
> can cause writers to memory.high to get stuck in the kernel forever,
> performing page reclaim and consuming excessive amounts of CPU cycles.
> 
> Before the patch, a write to memory.high would first put the new limit
> in place for the workload, and then reclaim the requested delta. After
> the patch, the kernel tries to reclaim the delta before putting the
> new limit into place, in order to not overwhelm the workload with a
> sudden, large excess over the limit. However, if reclaim is actively
> racing with new allocations from the uncurbed workload, it can keep
> the write() working inside the kernel indefinitely.
> 
> This is causing problems in Facebook production. A privileged
> system-level daemon that adjusts memory.high for various workloads
> running on a host can get unexpectedly stuck in the kernel and
> essentially turn into a sort of involuntary kswapd for one of the
> workloads. We've observed that daemon busy-spin in a write() for
> minutes at a time, neglecting its other duties on the system, and
> expending privileged system resources on behalf of a workload.
> 
> To remedy this, we have first considered changing the reclaim logic to
> break out after a couple of loops - whether the workload has converged
> to the new limit or not - and bound the write() call this way.
> However, the root cause that inspired the sequence change in the first
> place has been fixed through other means, and so a revert back to the
> proven limit-setting sequence, also used by memory.max, is preferable.
> 
> The sequence was changed to avoid extreme latencies in the workload
> when the limit was lowered: the sudden, large excess created by the
> limit lowering would erroneously trigger the penalty sleeping code
> that is meant to throttle excessive growth from below. Allocating
> threads could end up sleeping long after the write() had already
> reclaimed the delta for which they were being punished.
> 
> However, erroneous throttling also caused problems in other scenarios
> at around the same time. This resulted in commit b3ff92916af3 ("mm,
> memcg: reclaim more aggressively before high allocator throttling"),
> included in the same release as the offending commit. When allocating
> threads now encounter large excess caused by a racing write() to
> memory.high, instead of entering punitive sleeps, they will simply be
> tasked with helping reclaim down the excess, and will be held no
> longer than it takes to accomplish that. This is in line with regular
> limit enforcement - i.e. if the workload allocates up against or over
> an otherwise unchanged limit from below.
> 
> With the patch breaking userspace, and the root cause addressed by
> other means already, revert it again.
> 
> Fixes: 536d3bf261a2 ("mm: memcontrol: avoid workload stalls when lowering memory.high")
> Cc: <stable@vger.kernel.org> # 5.8+
> Reported-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks for extending the changelog to describe the scenario in a more
detail.

> ---
>  mm/memcontrol.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> Andrew, this is a replacement for
> mm-memcontrol-prevent-starvation-when-writing-memoryhigh.patch
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 605f671203ef..a8611a62bafd 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6273,6 +6273,8 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
>  	if (err)
>  		return err;
>  
> +	page_counter_set_high(&memcg->memory, high);
> +
>  	for (;;) {
>  		unsigned long nr_pages = page_counter_read(&memcg->memory);
>  		unsigned long reclaimed;
> @@ -6296,10 +6298,7 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
>  			break;
>  	}
>  
> -	page_counter_set_high(&memcg->memory, high);
> -
>  	memcg_wb_domain_size_changed(memcg);
> -
>  	return nbytes;
>  }
>  
> -- 
> 2.30.0
> 

-- 
Michal Hocko
SUSE Labs
