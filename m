Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCC2248A9C3
	for <lists+cgroups@lfdr.de>; Tue, 11 Jan 2022 09:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236083AbiAKIor (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Jan 2022 03:44:47 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:39252 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235048AbiAKIor (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Jan 2022 03:44:47 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0A36C1F3B8;
        Tue, 11 Jan 2022 08:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641890686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mbrh8o5uN1/tgvpBhMqXNUGgxMrcNwDYDBYIA0jYuaY=;
        b=h6Bh2WrfzZxuKm0ypf4OxrSKB5htlBNyF36T2helWv0NY4KsJtc1cBZCaWiDHBdWe7XY2A
        TZDxZ7UvmhbkPRcw6H+RnCVx5xXaXaNQmSh0jU14yD1xbyUK/ADD44SIlBAOkOhTDytzLM
        y9kPJ3t+se/D1A1ozarFY5iBGTAuzFw=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CEA05A3B84;
        Tue, 11 Jan 2022 08:44:45 +0000 (UTC)
Date:   Tue, 11 Jan 2022 09:44:45 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, shakeelb@google.com, guro@fb.com,
        vbabka@suse.cz, willy@infradead.org, songmuchun@bytedance.com,
        shy828301@gmail.com, surenb@google.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 4/4] mm/memcg: refine
 mem_cgroup_threshold_ary->current_threshold calculation
Message-ID: <Yd1DffvquQeNM9V+@dhcp22.suse.cz>
References: <20220111010302.8864-1-richard.weiyang@gmail.com>
 <20220111010302.8864-4-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111010302.8864-4-richard.weiyang@gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 11-01-22 01:03:02, Wei Yang wrote:
> mem_cgroup_threshold_ary->current_threshold points to the last entry
> who's threshold is less or equal to usage.
> 
> Instead of iterating entries to get the correct index, we can leverage
> primary->current_threshold to get it. If the threshold added is less or
> equal to usage, current_threshold should increase by one. Otherwise, it
> doesn't change.

Why do we want/need this change?

> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> ---
>  mm/memcontrol.c | 31 +++++++++++++++++--------------
>  1 file changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index a504616f904a..ce7060907df2 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4161,7 +4161,7 @@ static int __mem_cgroup_usage_register_event(struct mem_cgroup *memcg,
>  	struct mem_cgroup_threshold_ary *new;
>  	unsigned long threshold;
>  	unsigned long usage;
> -	int i, size, ret;
> +	int size, ret;
>  
>  	ret = page_counter_memparse(args, "-1", &threshold);
>  	if (ret)
> @@ -4193,9 +4193,13 @@ static int __mem_cgroup_usage_register_event(struct mem_cgroup *memcg,
>  	new->size = size;
>  
>  	/* Copy thresholds (if any) to new array */
> -	if (thresholds->primary)
> +	if (thresholds->primary) {
>  		memcpy(new->entries, thresholds->primary->entries,
>  		       flex_array_size(new, entries, size - 1));
> +		new->current_threshold = thresholds->primary->current_threshold;
> +	} else {
> +		new->current_threshold = -1;
> +	}
>  
>  	/* Add new threshold */
>  	new->entries[size - 1].eventfd = eventfd;
> @@ -4205,18 +4209,17 @@ static int __mem_cgroup_usage_register_event(struct mem_cgroup *memcg,
>  	sort(new->entries, size, sizeof(*new->entries),
>  			compare_thresholds, NULL);
>  
> -	/* Find current threshold */
> -	new->current_threshold = -1;
> -	for (i = 0; i < size; i++) {
> -		if (new->entries[i].threshold <= usage) {
> -			/*
> -			 * new->current_threshold will not be used until
> -			 * rcu_assign_pointer(), so it's safe to increment
> -			 * it here.
> -			 */
> -			++new->current_threshold;
> -		} else
> -			break;
> +	/*
> +	 * If the threshold added here is less or equal to usage, this means
> +	 * current_threshold need to increase by one.
> +	 */
> +	if (threshold <= usage) {
> +		/*
> +		 * new->current_threshold will not be used until
> +		 * rcu_assign_pointer(), so it's safe to increment
> +		 * it here.
> +		 */
> +		new->current_threshold++;
>  	}
>  
>  	/* Free old spare buffer and save old primary buffer as spare */
> -- 
> 2.33.1

-- 
Michal Hocko
SUSE Labs
