Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A44231B694
	for <lists+cgroups@lfdr.de>; Mon, 15 Feb 2021 10:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbhBOJkZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Feb 2021 04:40:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:33728 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230100AbhBOJkT (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 15 Feb 2021 04:40:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613381971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AfxkVXqAHAm17EFwPtPwrVPHnFGJsC0+h+W+8Wzcudk=;
        b=QpHe7YRtB8RNMZWfhyKrDekJEH7y6gOUpQo21orpdf1GlGcYRJBY+zW+QzA+lirhVWw++K
        yOBrSPMoA3XkI+nhEojgostgEWblMww2qAUgFjp7I/jp588fiPOdtY07CLFsUCYeMLvlfa
        ggFU0zuPhY/fGiRMc63SIu0fWrZAOKs=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DC7DFAC32;
        Mon, 15 Feb 2021 09:39:30 +0000 (UTC)
Date:   Mon, 15 Feb 2021 10:39:30 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] mm: memcontrol: bail out early when id is zero
Message-ID: <YCpBUm2N4Bqm5PM5@dhcp22.suse.cz>
References: <20210212170159.32153-1-songmuchun@bytedance.com>
 <20210212170159.32153-3-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212170159.32153-3-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat 13-02-21 01:01:58, Muchun Song wrote:
> The memcg ID cannot be zero, but we can pass zero to mem_cgroup_from_id,
> so idr_find() is pointless and wastes CPU cycles.

Is this possible at all to happen? If not why should we add a test for
_all_ invocations?

> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/memcontrol.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index a3f26522765a..68ed4b297c13 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5173,6 +5173,9 @@ static inline void mem_cgroup_id_put(struct mem_cgroup *memcg)
>  struct mem_cgroup *mem_cgroup_from_id(unsigned short id)
>  {
>  	WARN_ON_ONCE(!rcu_read_lock_held());
> +	/* The memcg ID cannot be zero. */
> +	if (id == 0)
> +		return NULL;
>  	return idr_find(&mem_cgroup_idr, id);
>  }
>  
> -- 
> 2.11.0

-- 
Michal Hocko
SUSE Labs
