Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F8631B6AA
	for <lists+cgroups@lfdr.de>; Mon, 15 Feb 2021 10:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhBOJso (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Feb 2021 04:48:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:40432 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230244AbhBOJsn (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 15 Feb 2021 04:48:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613382475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tgPT5P13ZnYUMYX9KeVnDKoSxuQbU0v+VMfCnnxCsVA=;
        b=pg9Nrs5pHfRxhWPI6aAQKx/oWV5710KNxAtTwHE+ZVl/TEwLWu3Sxz0P9TfOgZbEKp2vKt
        HcvlbL5NcNjfrfuAAk5VPnz78+HRCbulwyYvRxNx/Q6VYiKVorHekf3UrdIYjl+pmfVKrO
        M8Fwru0ZPhg8/k5TlqQUm9ez5taN6QM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 88EA2AC69;
        Mon, 15 Feb 2021 09:47:55 +0000 (UTC)
Date:   Mon, 15 Feb 2021 10:47:54 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] mm: memcontrol: fix swap uncharge on cgroup v2
Message-ID: <YCpDSnLSDoE/FHK5@dhcp22.suse.cz>
References: <20210212170159.32153-1-songmuchun@bytedance.com>
 <20210212170159.32153-4-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212170159.32153-4-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat 13-02-21 01:01:59, Muchun Song wrote:
> The swap charges the actual number of swap entries on cgroup v2.
> If a swap cache page is charged successful, and then we uncharge
> the swap counter. It is wrong on cgroup v2. Because the swap
> entry is not freed.

Is there any actual problem though? Can you describe the specific
scenario please? Swap cache charge life time is a bit tricky and I have
to confess I have to relearn it every time I need to understand it. The
patch would be much more easier to review if the changelog was much more
specific.

> Fixes: 2d1c498072de ("mm: memcontrol: make swap tracking an integral part of memory control")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/memcontrol.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index c737c8f05992..be6bc5044150 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6753,7 +6753,7 @@ int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask)
>  	memcg_check_events(memcg, page);
>  	local_irq_enable();
>  
> -	if (PageSwapCache(page)) {
> +	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && PageSwapCache(page)) {
>  		swp_entry_t entry = { .val = page_private(page) };
>  		/*
>  		 * The swap entry might not get freed for a long time,
> -- 
> 2.11.0

-- 
Michal Hocko
SUSE Labs
