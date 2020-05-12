Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9821CEDA4
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2020 09:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgELHJD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 12 May 2020 03:09:03 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42059 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgELHJD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 12 May 2020 03:09:03 -0400
Received: by mail-wr1-f67.google.com with SMTP id s8so13951362wrt.9
        for <cgroups@vger.kernel.org>; Tue, 12 May 2020 00:09:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dRnUzXLD6KqSFkh5VLcziMQu43t7sdMvMhBiJjACIJM=;
        b=rlmLsG0qn+ud2SItehgAlNrg/2/gazZoEpA5UayoyQF9NieaPiGqy59hm1z8wH713W
         MQJEGo5HY1ch7sSKmjVJbyGRheDq8elY8dezvr7YBkWmfl1hQhJvLTq/gBgU3N/W9fgN
         01ip5AQ2cRaaMDJFad4paWOLB/UfNzBLHW+nDKjoQmFc9qghsWqO8yEycUXvcvuwgG6E
         d8xo2RbjLEwRt3R5aQrgSIsShGye/Quk4StZESpGIk6hGe7KAvxWedY0EO2MCYAiGXGp
         FMetiZGLar8sjVMT0q0k95fVc60pVfkBsHiAAo98f7kta0o3Zr1am9DlaYn5bKlP8zDL
         yXfg==
X-Gm-Message-State: AGi0PuYD2aeKirWkXNhlgobPB1FHvSuVfqqkutFWKaba0y+eqpcJnMPw
        HyiIWeOL5csbvK5xctwNTIM=
X-Google-Smtp-Source: APiQypJzmmAWWIBGY4e5+MWuu5PgSkCCTf8PhqIrJmwVfZQWl6TtkG5tXcObxV4pwZvwuMWACoHFCQ==
X-Received: by 2002:a5d:4c86:: with SMTP id z6mr22180971wrs.279.1589267341173;
        Tue, 12 May 2020 00:09:01 -0700 (PDT)
Received: from localhost (ip-37-188-140-86.eurotel.cz. [37.188.140.86])
        by smtp.gmail.com with ESMTPSA id c7sm7636641wro.80.2020.05.12.00.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 00:09:00 -0700 (PDT)
Date:   Tue, 12 May 2020 09:08:58 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org, kernel-team@fb.com,
        tj@kernel.org, hannes@cmpxchg.org, chris@chrisdown.name,
        cgroups@vger.kernel.org, shakeelb@google.com
Subject: Re: [PATCH mm v2 1/3] mm: prepare for swap over-high accounting and
 penalty calculation
Message-ID: <20200512070858.GO29153@dhcp22.suse.cz>
References: <20200511225516.2431921-1-kuba@kernel.org>
 <20200511225516.2431921-2-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511225516.2431921-2-kuba@kernel.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 11-05-20 15:55:14, Jakub Kicinski wrote:
> Slice the memory overage calculation logic a little bit so we can
> reuse it to apply a similar penalty to the swap. The logic which
> accesses the memory-specific fields (use and high values) has to
> be taken out of calculate_high_delay().
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Michal Hocko <mhocko@suse.com>

some recommendations below.

> ---
>  mm/memcontrol.c | 62 ++++++++++++++++++++++++++++---------------------
>  1 file changed, 35 insertions(+), 27 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 05dcb72314b5..8a9b671c3249 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2321,41 +2321,48 @@ static void high_work_func(struct work_struct *work)
>   #define MEMCG_DELAY_PRECISION_SHIFT 20
>   #define MEMCG_DELAY_SCALING_SHIFT 14
>  
> -/*
> - * Get the number of jiffies that we should penalise a mischievous cgroup which
> - * is exceeding its memory.high by checking both it and its ancestors.
> - */
> -static unsigned long calculate_high_delay(struct mem_cgroup *memcg,
> -					  unsigned int nr_pages)
> +static u64 calculate_overage(unsigned long usage, unsigned long high)

the naming is slightly confusing. I would concider the return value
to be in memory units rather than time because I would read it as
overrage of high. calculate_throttle_penalty would be more clear to me.

>  {
> -	unsigned long penalty_jiffies;
> -	u64 max_overage = 0;
> -
> -	do {
> -		unsigned long usage, high;
> -		u64 overage;
> +	u64 overage;
>  
> -		usage = page_counter_read(&memcg->memory);
> -		high = READ_ONCE(memcg->high);
> +	if (usage <= high)
> +		return 0;
>  
> -		if (usage <= high)
> -			continue;
> +	/*
> +	 * Prevent division by 0 in overage calculation by acting as if
> +	 * it was a threshold of 1 page
> +	 */
> +	high = max(high, 1UL);
>  
> -		/*
> -		 * Prevent division by 0 in overage calculation by acting as if
> -		 * it was a threshold of 1 page
> -		 */
> -		high = max(high, 1UL);
> +	overage = usage - high;
> +	overage <<= MEMCG_DELAY_PRECISION_SHIFT;
> +	return div64_u64(overage, high);
> +}
>  
> -		overage = usage - high;
> -		overage <<= MEMCG_DELAY_PRECISION_SHIFT;
> -		overage = div64_u64(overage, high);
> +static u64 mem_find_max_overage(struct mem_cgroup *memcg)

This would then become find_high_throttle_penalty

> +{
> +	u64 overage, max_overage = 0;
>  
> -		if (overage > max_overage)
> -			max_overage = overage;
> +	do {
> +		overage = calculate_overage(page_counter_read(&memcg->memory),
> +					    READ_ONCE(memcg->high));
> +		max_overage = max(overage, max_overage);
>  	} while ((memcg = parent_mem_cgroup(memcg)) &&
>  		 !mem_cgroup_is_root(memcg));
>  
> +	return max_overage;
> +}
> +
> +/*
> + * Get the number of jiffies that we should penalise a mischievous cgroup which
> + * is exceeding its memory.high by checking both it and its ancestors.
> + */
> +static unsigned long calculate_high_delay(struct mem_cgroup *memcg,
> +					  unsigned int nr_pages,
> +					  u64 max_overage)
> +{
> +	unsigned long penalty_jiffies;
> +
>  	if (!max_overage)
>  		return 0;
>  
> @@ -2411,7 +2418,8 @@ void mem_cgroup_handle_over_high(void)
>  	 * memory.high is breached and reclaim is unable to keep up. Throttle
>  	 * allocators proactively to slow down excessive growth.
>  	 */
> -	penalty_jiffies = calculate_high_delay(memcg, nr_pages);
> +	penalty_jiffies = calculate_high_delay(memcg, nr_pages,
> +					       mem_find_max_overage(memcg));
>  
>  	/*
>  	 * Don't sleep if the amount of jiffies this memcg owes us is so low
> -- 
> 2.25.4

-- 
Michal Hocko
SUSE Labs
