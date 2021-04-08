Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9813587DC
	for <lists+cgroups@lfdr.de>; Thu,  8 Apr 2021 17:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbhDHPIa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 8 Apr 2021 11:08:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:46496 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231843AbhDHPI3 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 8 Apr 2021 11:08:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617894497; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TBg+itYPsPJsb2/umgmP6I2xkGrOVNCioeyRXHmIdOY=;
        b=O8W4MqEeWnmVa6Kg1nm/gJoBcA8QGilvgWn3bIGb4Q8L9/7qESs2dy/HF4iHN1xRtN0Xc4
        2KrxwgdvGq16B5PafIB2k9geb3RyU3yf/5vzQKKLeMJLsZ/NIHhL8jdDS734ufodBRGDyj
        wwDgqmyTdmbfa0pCQHgkG49cK7Ruf9I=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4519AB148;
        Thu,  8 Apr 2021 15:08:17 +0000 (UTC)
Date:   Thu, 8 Apr 2021 17:08:16 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm: page_counter: mitigate consequences of a
 page_counter underflow
Message-ID: <YG8cYCsxwNwszhji@dhcp22.suse.cz>
References: <20210408143155.2679744-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408143155.2679744-1-hannes@cmpxchg.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 08-04-21 10:31:55, Johannes Weiner wrote:
> When the unsigned page_counter underflows, even just by a few pages, a
> cgroup will not be able to run anything afterwards and trigger the OOM
> killer in a loop.
> 
> Underflows shouldn't happen, but when they do in practice, we may just
> be off by a small amount that doesn't interfere with the normal
> operation - consequences don't need to be that dire.

Yes, I do agree.

> Reset the page_counter to 0 upon underflow. We'll issue a warning that
> the accounting will be off and then try to keep limping along.

I do not remember any reports about the existing WARN_ON but it is not
really hard to imagine a charging imbalance to be introduced easily.

> [ We used to do this with the original res_counter, where it was a
>   more straight-forward correction inside the spinlock section. I
>   didn't carry it forward into the lockless page counters for
>   simplicity, but it turns out this is quite useful in practice. ]

The lack of external synchronization makes it more tricky because
certain charges might get just lost depending on the ordering. This
sucks but considering that the system is already botched and counters
cannot be trusted this is definitely better than a potentially
completely unusable memcg. It would be nice to mention that in the above
paragraph as a caveat.

> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/page_counter.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/page_counter.c b/mm/page_counter.c
> index c6860f51b6c6..7d83641eb86b 100644
> --- a/mm/page_counter.c
> +++ b/mm/page_counter.c
> @@ -52,9 +52,13 @@ void page_counter_cancel(struct page_counter *counter, unsigned long nr_pages)
>  	long new;
>  
>  	new = atomic_long_sub_return(nr_pages, &counter->usage);
> -	propagate_protected_usage(counter, new);
>  	/* More uncharges than charges? */
> -	WARN_ON_ONCE(new < 0);
> +	if (WARN_ONCE(new < 0, "page_counter underflow: %ld nr_pages=%lu\n",
> +		      new, nr_pages)) {
> +		new = 0;
> +		atomic_long_set(&counter->usage, new);
> +	}
> +	propagate_protected_usage(counter, new);
>  }
>  
>  /**
> -- 
> 2.31.1

-- 
Michal Hocko
SUSE Labs
