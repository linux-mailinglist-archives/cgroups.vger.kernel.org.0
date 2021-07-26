Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B696C3D682A
	for <lists+cgroups@lfdr.de>; Mon, 26 Jul 2021 22:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbhGZTvq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Jul 2021 15:51:46 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:37170 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbhGZTvq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 26 Jul 2021 15:51:46 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D063A1FED5;
        Mon, 26 Jul 2021 20:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627331533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h1InytiqltbBeRvMKPBphtrY6Ob9lOFDHLgd355e0lw=;
        b=Y+mHHknOk99m7yJUgdSM5w83k9ExylQF2+4ZNqL1wg3DESl5c2D3s+qV5VQAzOWb8Md9mS
        5RJYWYlrNfSKhXKmU7ZS4nvOqkc1/I3hd8+qup/HI3EtM9M7IYrzDcZ9Ku39xsETH9wyi5
        U7y6K9kU6Wu9CYIAOUQQROR33Rvg7SY=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A291DA3B81;
        Mon, 26 Jul 2021 20:32:13 +0000 (UTC)
Date:   Mon, 26 Jul 2021 22:32:13 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm: memcontrol: fix blocking rstat function called from
 atomic cgroup1 thresholding code
Message-ID: <YP8bzZJjbpEvi4lM@dhcp22.suse.cz>
References: <20210726150019.251820-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726150019.251820-1-hannes@cmpxchg.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 26-07-21 11:00:19, Johannes Weiner wrote:
> Dan Carpenter reports:
> 
>     The patch 2d146aa3aa84: "mm: memcontrol: switch to rstat" from Apr
>     29, 2021, leads to the following static checker warning:
> 
> 	    kernel/cgroup/rstat.c:200 cgroup_rstat_flush()
> 	    warn: sleeping in atomic context
> 
>     mm/memcontrol.c
>       3572  static unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap)
>       3573  {
>       3574          unsigned long val;
>       3575
>       3576          if (mem_cgroup_is_root(memcg)) {
>       3577                  cgroup_rstat_flush(memcg->css.cgroup);
> 			    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
>     This is from static analysis and potentially a false positive.  The
>     problem is that mem_cgroup_usage() is called from __mem_cgroup_threshold()
>     which holds an rcu_read_lock().  And the cgroup_rstat_flush() function
>     can sleep.
> 
>       3578                  val = memcg_page_state(memcg, NR_FILE_PAGES) +
>       3579                          memcg_page_state(memcg, NR_ANON_MAPPED);
>       3580                  if (swap)
>       3581                          val += memcg_page_state(memcg, MEMCG_SWAP);
>       3582          } else {
>       3583                  if (!swap)
>       3584                          val = page_counter_read(&memcg->memory);
>       3585                  else
>       3586                          val = page_counter_read(&memcg->memsw);
>       3587          }
>       3588          return val;
>       3589  }
> 
> __mem_cgroup_threshold() indeed holds the rcu lock. In addition, the
> thresholding code is invoked during stat changes, and those contexts
> have irqs disabled as well. If the lock breaking occurs inside the
> flush function, it will result in a sleep from an atomic context.
> 
> Use the irsafe flushing variant in mem_cgroup_usage() to fix this.
> 
> Fixes: 2d146aa3aa84 ("mm: memcontrol: switch to rstat")
> Cc: <stable@vger.kernel.org>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  mm/memcontrol.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index ae1f5d0cb581..eb8e87c4833f 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3574,7 +3574,8 @@ static unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap)
>  	unsigned long val;
>  
>  	if (mem_cgroup_is_root(memcg)) {
> -		cgroup_rstat_flush(memcg->css.cgroup);
> +		/* mem_cgroup_threshold() calls here from irqsafe context */
> +		cgroup_rstat_flush_irqsafe(memcg->css.cgroup);
>  		val = memcg_page_state(memcg, NR_FILE_PAGES) +
>  			memcg_page_state(memcg, NR_ANON_MAPPED);
>  		if (swap)
> -- 
> 2.32.0

-- 
Michal Hocko
SUSE Labs
