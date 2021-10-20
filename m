Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB28434725
	for <lists+cgroups@lfdr.de>; Wed, 20 Oct 2021 10:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhJTIp3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 20 Oct 2021 04:45:29 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59336 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhJTIp2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 20 Oct 2021 04:45:28 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5470D1FD9D;
        Wed, 20 Oct 2021 08:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634719393; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U9ANNFhF9o/o+ybyDXRcaxGyWu+m+P0WrCO6fsbyGfU=;
        b=uY6Nxgcj9JvrEu906q2eodXCBQHjLtNTT6g2fU2aC1AVTPGmitU6Q5Wuj8Ke/poJn9cDfx
        RgpiGjvRE05Q/17lHdQCAkfbUu3aNpsMOqiKGT7T7678VtAkJml8vKI0dWPTviJ9hhTLAU
        Q5W6VT/MOGukER12jvgZSq9zCYd9JDM=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B765FA3B8A;
        Wed, 20 Oct 2021 08:43:12 +0000 (UTC)
Date:   Wed, 20 Oct 2021 10:43:12 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@openvz.org
Subject: Re: [PATCH memcg v4] memcg: prohibit unconditional exceeding the
 limit of dying tasks
Message-ID: <YW/WoJDFM3ddHn7Y@dhcp22.suse.cz>
References: <3c76e2d7-e545-ef34-b2c3-a5f63b1eff51@virtuozzo.com>
 <f40cd82c-f03a-4d36-e953-f89399cb8f58@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f40cd82c-f03a-4d36-e953-f89399cb8f58@virtuozzo.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 20-10-21 11:07:02, Vasily Averin wrote:
[...]
I haven't read through the changelog and only focused on the patch this
time.

[...]
> @@ -1810,11 +1810,21 @@ static enum oom_status mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int
>  		mem_cgroup_oom_notify(memcg);
>  
>  	mem_cgroup_unmark_under_oom(memcg);
> -	if (mem_cgroup_out_of_memory(memcg, mask, order))
> +	if (mem_cgroup_out_of_memory(memcg, mask, order)) {
>  		ret = OOM_SUCCESS;
> -	else
> +	} else {
>  		ret = OOM_FAILED;
> -
> +		/*
> +		 * In some rare cases mem_cgroup_out_of_memory() can return false.
> +		 * If it was called from #PF it forces handle_mm_fault()
> +		 * return VM_FAULT_OOM and executes pagefault_out_of_memory().
> +		 * memcg_in_oom is set here to notify pagefault_out_of_memory()
> +		 * that it was a memcg-related failure and not allow to run
> +		 * global OOM.
> +		 */
> +		if (current->in_user_fault)
> +			current->memcg_in_oom = (struct mem_cgroup *)ret;
> +	}
>  	if (locked)
>  		mem_cgroup_oom_unlock(memcg);
>  
> @@ -1848,6 +1858,15 @@ bool mem_cgroup_oom_synchronize(bool handle)
>  	if (!memcg)
>  		return false;
>  
> +	/* OOM is memcg, however out_of_memory() found no victim */
> +	if (memcg == (struct mem_cgroup *)OOM_FAILED) {
> +		/*
> +		 * Should be called from pagefault_out_of_memory() only,
> +		 * where it is used to prevent false global OOM.
> +		 */
> +		current->memcg_in_oom = NULL;
> +		return true;
> +	}
>  	if (!handle)
>  		goto cleanup;

I have to say I am not a great fan of this but this belongs to a
separate patch on top of all the previous ones.

[...]
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 831340e7ad8b..1deef8c7a71b 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -1137,6 +1137,9 @@ void pagefault_out_of_memory(void)
>  	if (mem_cgroup_oom_synchronize(true))
>  		return;
>  
> +	if (fatal_signal_pending(current))
> +		return;
> +

This belongs to its own patch as well.

All that being said I would go with pagefault_out_of_memory as the first
patch because it is necessary to handle charge failures. Then go with a
patch to remove charge forcing when OOM killer succeeds but the retry
still fails and finally go with one that tries to handle oom failures.
-- 
Michal Hocko
SUSE Labs
