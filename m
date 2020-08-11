Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB2C4241BDB
	for <lists+cgroups@lfdr.de>; Tue, 11 Aug 2020 15:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbgHKN4a (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Aug 2020 09:56:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:49072 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728532AbgHKN43 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 11 Aug 2020 09:56:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BA8F6B0A5;
        Tue, 11 Aug 2020 13:56:48 +0000 (UTC)
Date:   Tue, 11 Aug 2020 15:56:26 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Resend PATCH 2/6] mm/memcg: remove useless check on
 page->mem_cgroup
Message-ID: <20200811135626.GL4793@dhcp22.suse.cz>
References: <1597144232-11370-1-git-send-email-alex.shi@linux.alibaba.com>
 <1597144232-11370-2-git-send-email-alex.shi@linux.alibaba.com>
 <20200811113008.GK4793@dhcp22.suse.cz>
 <776b0e6f-4129-9fb9-0f66-47757cf320d5@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <776b0e6f-4129-9fb9-0f66-47757cf320d5@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 11-08-20 20:54:18, Alex Shi wrote:
> >From beeac61119ab39b1869c520c0f272fb8bab93765 Mon Sep 17 00:00:00 2001
> From: Alex Shi <alex.shi@linux.alibaba.com>
> Date: Wed, 5 Aug 2020 21:02:30 +0800
> Subject: [PATCH 2/6] memcg: bail out early from swap accounting when memcg is
>  disabled
> 
> If we disabled memcg by cgroup_disable=memory, the swap charges are
> still called. Let's return from the funcs earlier.

They are not, are they? page->memcg will be NULL and so the charge is
skipped and that will trigger a warning with your current ordering.

Let me repeat again. Either you put it first in the series and argue
that we can bail out early or keep the ordering then this makes sure the
warning doesn't trigger.

> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Reviewed-by: Roman Gushchin <guro@fb.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: cgroups@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  mm/memcontrol.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 299382fc55a9..419cf565f40b 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -7098,6 +7098,9 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
>  	VM_BUG_ON_PAGE(PageLRU(page), page);
>  	VM_BUG_ON_PAGE(page_count(page), page);
>  
> +	if (mem_cgroup_disabled())
> +		return;
> +
>  	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
>  		return;
>  
> @@ -7163,6 +7166,9 @@ int mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry)
>  	struct mem_cgroup *memcg;
>  	unsigned short oldid;
>  
> +	if (mem_cgroup_disabled())
> +		return 0;
> +
>  	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
>  		return 0;
>  
> -- 
> 1.8.3.1

-- 
Michal Hocko
SUSE Labs
