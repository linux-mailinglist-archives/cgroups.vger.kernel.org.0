Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 128853DB3EA
	for <lists+cgroups@lfdr.de>; Fri, 30 Jul 2021 08:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234878AbhG3Gve (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 30 Jul 2021 02:51:34 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59386 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbhG3Gvd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 30 Jul 2021 02:51:33 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6341022349;
        Fri, 30 Jul 2021 06:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627627888; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JU3Y5J8NTdc7M6n9NoKsTCUbYMjkBBca/WKKJGoryDo=;
        b=GksVOKRfYmeR2RUP8XIfL2vg5hb5LIxjAS39cHhBHoJxg0KFftVR4wUpO4WzV5vGdycJ4z
        hG5JPhKddpFhD+SLE24qLZDzQU9riORLVGFrm71HqUSLeY3Dv21rQ4lq2lZXPefXht0JA9
        nFpJIKLuppdSXu0VUNaji7ebeIY7DU0=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2D163A3B87;
        Fri, 30 Jul 2021 06:51:28 +0000 (UTC)
Date:   Fri, 30 Jul 2021 08:51:27 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, shakeelb@google.com, guro@fb.com,
        willy@infradead.org, alexs@kernel.org, richard.weiyang@gmail.com,
        songmuchun@bytedance.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH 3/5] mm, memcg: save some atomic ops when flush is
 already true
Message-ID: <YQOhbwhJWuk5NOro@dhcp22.suse.cz>
References: <20210729125755.16871-1-linmiaohe@huawei.com>
 <20210729125755.16871-4-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729125755.16871-4-linmiaohe@huawei.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 29-07-21 20:57:53, Miaohe Lin wrote:
> Add 'else' to save some atomic ops in obj_stock_flush_required() when
> flush is already true. No functional change intended here.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memcontrol.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index a03e24e57cd9..5b4592d1e0f2 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2231,7 +2231,7 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
>  		if (memcg && stock->nr_pages &&
>  		    mem_cgroup_is_descendant(memcg, root_memcg))
>  			flush = true;
> -		if (obj_stock_flush_required(stock, root_memcg))
> +		else if (obj_stock_flush_required(stock, root_memcg))
>  			flush = true;
>  		rcu_read_unlock();
>  
> -- 
> 2.23.0

-- 
Michal Hocko
SUSE Labs
