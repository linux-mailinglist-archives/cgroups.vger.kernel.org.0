Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4CD439252
	for <lists+cgroups@lfdr.de>; Mon, 25 Oct 2021 11:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbhJYJaH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 25 Oct 2021 05:30:07 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:33686 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhJYJ3y (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 25 Oct 2021 05:29:54 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A9534218ED;
        Mon, 25 Oct 2021 09:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635154051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Uc2tQ+I68yRAtsGtLKbNQYmcC3g72eF4Y8qXrabBvYo=;
        b=eL5EqEnM+gAD4smvMpKMOiv+9odl76GXnxfkil69LbP7b1QC9qpwTW6FHm/g1HnWBxGlXP
        +aq9ws7dNQAdoxjXGbA2bhTwZgo4fsRHxZeaS6iWMTFi7DgOJRdHUzwUbVQFldcMyVLE+o
        GmwN4oeHMlbbFtANsg21Juo3XmHpVL4=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7546EA3B83;
        Mon, 25 Oct 2021 09:27:30 +0000 (UTC)
Date:   Mon, 25 Oct 2021 11:27:29 +0200
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
Subject: Re: [PATCH memcg v3 1/3] mm, oom: pagefault_out_of_memory: don't
 force global OOM for dying tasks
Message-ID: <YXZ4gV0ks3H9DWxo@dhcp22.suse.cz>
References: <YXJ/63kIpTq8AOlD@dhcp22.suse.cz>
 <cover.1634994605.git.vvs@virtuozzo.com>
 <0828a149-786e-7c06-b70a-52d086818ea3@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0828a149-786e-7c06-b70a-52d086818ea3@virtuozzo.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat 23-10-21 16:19:28, Vasily Averin wrote:
> Any allocation failure during the #PF path will return with VM_FAULT_OOM
> which in turn results in pagefault_out_of_memory which in own turn
> executes out_out_memory() and can kill a random task.
> 
> An allocation might fail when the current task is the oom victim
> and there are no memory reserves left. The OOM killer is already
> handled at the page allocator level for the global OOM and at the
> charging level for the memcg one. Both have much more information
> about the scope of allocation/charge request. This means that
> either the OOM killer has been invoked properly and didn't lead
> to the allocation success or it has been skipped because it couldn't
> have been invoked. In both cases triggering it from here is pointless
> and even harmful.
> 
> It makes much more sense to let the killed task die rather than to
> wake up an eternally hungry oom-killer and send him to choose a fatter
> victim for breakfast.
> 
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  mm/oom_kill.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
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
>  	if (!mutex_trylock(&oom_lock))
>  		return;
>  	out_of_memory(&oc);
> -- 
> 2.32.0

-- 
Michal Hocko
SUSE Labs
