Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2B2434B3B
	for <lists+cgroups@lfdr.de>; Wed, 20 Oct 2021 14:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbhJTMgD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 20 Oct 2021 08:36:03 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:32988 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhJTMgD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 20 Oct 2021 08:36:03 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DEDB81F770;
        Wed, 20 Oct 2021 12:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634733227; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3UnTu9zwwf8NSgpDXIex/EQbixB3GG5nxeC27rFUoo4=;
        b=hwW3FoF7Q9xQQ6c9C6pXKQVXDvbM5O97PBXyMbMq/0FtzqbRYEDMmNIeYhYMEUaH3bEmzm
        e2K72qTnlyNHrXAyZr3ANBJ4k6blJ6/7Ec3Cat8TdGd6Dwmgwtco8FNx3KQ/ipePD4qRPB
        QWwPiXvrmlfaVryc15mzcCx4y1j93vs=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 52F47A3C5F;
        Wed, 20 Oct 2021 12:33:47 +0000 (UTC)
Date:   Wed, 20 Oct 2021 14:33:43 +0200
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
Subject: Re: [PATCH memcg 1/3] mm: do not firce global OOM from inside dying
 tasks
Message-ID: <YXAMpxjuV/h2awqG@dhcp22.suse.cz>
References: <YW/WoJDFM3ddHn7Y@dhcp22.suse.cz>
 <cover.1634730787.git.vvs@virtuozzo.com>
 <2c13c739-7282-e6f4-da0a-c0b69e68581e@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c13c739-7282-e6f4-da0a-c0b69e68581e@virtuozzo.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

s@firce@force@

On Wed 20-10-21 15:12:19, Vasily Averin wrote:
> There is no sense to force global OOM if current task is dying.

This really begs for much more information. Feel free to get an
inspiration from my previous attempt to achieve something similar.
In minimum it is important to mention that the OOM killer is already
handled at the page allocator level for the global OOM and at the
charging level for the memcg one. Both have much more information
about the scope of allocation/charge request. This means that either the
OOM killer has been invoked properly and didn't lead to the allocation
success or it has been skipped because it couldn't have been invoked.
In both cases triggering it from here is pointless and even harmful.

Another argument is that it is more reasonable to let killed task die
rather than hit the oom killer and retry the allocation.

> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
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
