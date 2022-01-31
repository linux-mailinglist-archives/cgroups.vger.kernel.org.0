Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4404A505F
	for <lists+cgroups@lfdr.de>; Mon, 31 Jan 2022 21:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbiAaUn0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 31 Jan 2022 15:43:26 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:45754 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239860AbiAaUn0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 31 Jan 2022 15:43:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6AEBDCE1281;
        Mon, 31 Jan 2022 20:43:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A37EC340E8;
        Mon, 31 Jan 2022 20:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643661802;
        bh=JFWeeOeX6cMALtKM2vqlyIArFqrtqdWgyAlR/K0BiiM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DsVbUZNgXSXX7Vp5kx/hp3fv7i7TnEaNCHHSpAWfjrnPft8jTlVvpAtPufljeq1NE
         eWe1mBdkC1Z4+gVowCiXW4qrWXlG2iwlJHSclBz0Ux7V/VbeAhwYNo3LAWkId15GsC
         iCXP+yboTKXgO/3Z8VOFu4eqSFjgRzQmv4DcT9MBx5gdlm+b2EN5teo5zHx3JIxVZW
         ABTIfiVdi1r3KpasmC4hvjLckFnXafw1C+MWr8F09FOv59/iWA+Ce4rtL4NU7Snm4h
         e0K5GjuDAMQ0xiipMEOk4LXXyCYRoCMw8mcsE+MEGhucgc+MlcVcKkyCmS7Afh08PT
         gcVkJDy3o3j/w==
Date:   Mon, 31 Jan 2022 22:43:09 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Ira Weiny <ira.weiny@intel.com>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <guro@fb.com>, Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH v3 2/4] mm/page_owner: Use scnprintf() to avoid excessive
 buffer overrun check
Message-ID: <YfhJ3VT8KCjd3iGR@kernel.org>
References: <20220131192308.608837-1-longman@redhat.com>
 <20220131192308.608837-3-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131192308.608837-3-longman@redhat.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jan 31, 2022 at 02:23:06PM -0500, Waiman Long wrote:
> The snprintf() function can return a length greater than the given
> input size. That will require a check for buffer overrun after each
> invocation of snprintf(). scnprintf(), on the other hand, will never
> return a greater length. By using scnprintf() in selected places, we
> can avoid some buffer overrun checks except after stack_depot_snprint()
> and after the last snprintf().
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> Acked-by: David Rientjes <rientjes@google.com>
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  mm/page_owner.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index 99e360df9465..28dac73e0542 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -338,19 +338,16 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
>  	if (!kbuf)
>  		return -ENOMEM;
>  
> -	ret = snprintf(kbuf, count,
> +	ret = scnprintf(kbuf, count,
>  			"Page allocated via order %u, mask %#x(%pGg), pid %d, ts %llu ns, free_ts %llu ns\n",
>  			page_owner->order, page_owner->gfp_mask,
>  			&page_owner->gfp_mask, page_owner->pid,
>  			page_owner->ts_nsec, page_owner->free_ts_nsec);
>  
> -	if (ret >= count)
> -		goto err;
> -
>  	/* Print information relevant to grouping pages by mobility */
>  	pageblock_mt = get_pageblock_migratetype(page);
>  	page_mt  = gfp_migratetype(page_owner->gfp_mask);
> -	ret += snprintf(kbuf + ret, count - ret,
> +	ret += scnprintf(kbuf + ret, count - ret,
>  			"PFN %lu type %s Block %lu type %s Flags %pGp\n",
>  			pfn,
>  			migratetype_names[page_mt],
> @@ -358,19 +355,14 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
>  			migratetype_names[pageblock_mt],
>  			&page->flags);
>  
> -	if (ret >= count)
> -		goto err;
> -
>  	ret += stack_depot_snprint(handle, kbuf + ret, count - ret, 0);
>  	if (ret >= count)
>  		goto err;
>  
>  	if (page_owner->last_migrate_reason != -1) {
> -		ret += snprintf(kbuf + ret, count - ret,
> +		ret += scnprintf(kbuf + ret, count - ret,
>  			"Page has been migrated, last migrate reason: %s\n",
>  			migrate_reason_names[page_owner->last_migrate_reason]);
> -		if (ret >= count)
> -			goto err;
>  	}
>  
>  	ret += snprintf(kbuf + ret, count - ret, "\n");
> -- 
> 2.27.0
> 
> 

-- 
Sincerely yours,
Mike.
