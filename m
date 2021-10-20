Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B936B434B66
	for <lists+cgroups@lfdr.de>; Wed, 20 Oct 2021 14:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhJTMoG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 20 Oct 2021 08:44:06 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:44572 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhJTMoF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 20 Oct 2021 08:44:05 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7765321A87;
        Wed, 20 Oct 2021 12:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634733710; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sFOP+dXf4qmtNkZTV2k2qUHOsofKbRuJJn1maDYI9oM=;
        b=UyA4wEqa/V+upXfbz6kZdRsrMWrhneLtYsx4sBI86AeeX2S3ehCZ4BDkFEnycu5zd2sJl3
        LnV5NPVglpzp6+B09XkTkngMgzrn3L+mqavxH1k4wy/sMfEI197G2RHcdR3wlgqLZKwwMc
        pcVa15Jctosy5pc5u8tsB+BMAhY3abU=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 343FEA3B8B;
        Wed, 20 Oct 2021 12:41:50 +0000 (UTC)
Date:   Wed, 20 Oct 2021 14:41:49 +0200
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
Subject: Re: [PATCH memcg 2/3] memcg: remove charge forcinig for dying tasks
Message-ID: <YXAOjQO5r1g/WKmn@dhcp22.suse.cz>
References: <YW/WoJDFM3ddHn7Y@dhcp22.suse.cz>
 <cover.1634730787.git.vvs@virtuozzo.com>
 <56180e53-b705-b1be-9b60-75e141c8560c@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56180e53-b705-b1be-9b60-75e141c8560c@virtuozzo.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 20-10-21 15:13:46, Vasily Averin wrote:
> ToDo: should we keep task_is_dying() in mem_cgroup_out_of_memory() ?
> 
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> ---
>  mm/memcontrol.c | 20 +++++++-------------
>  1 file changed, 7 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 6da5020a8656..74a7379dbac1 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -239,7 +239,7 @@ enum res_type {
>  	     iter != NULL;				\
>  	     iter = mem_cgroup_iter(NULL, iter, NULL))
>  
> -static inline bool should_force_charge(void)
> +static inline bool task_is_dying(void)
>  {
>  	return tsk_is_oom_victim(current) || fatal_signal_pending(current) ||
>  		(current->flags & PF_EXITING);
> @@ -1575,7 +1575,7 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	 * A few threads which were not waiting at mutex_lock_killable() can
>  	 * fail to bail out. Therefore, check again after holding oom_lock.
>  	 */
> -	ret = should_force_charge() || out_of_memory(&oc);
> +	ret = task_is_dying() || out_of_memory(&oc);

Why are you keeping the task_is_dying check here? IIRC I have already
pointed out that out_of_memory already has some means to do a bypass
when needed.
-- 
Michal Hocko
SUSE Labs
