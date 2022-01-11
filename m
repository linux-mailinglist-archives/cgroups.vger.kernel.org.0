Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62CC048A9B8
	for <lists+cgroups@lfdr.de>; Tue, 11 Jan 2022 09:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236620AbiAKIle (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Jan 2022 03:41:34 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:38394 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236639AbiAKIld (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Jan 2022 03:41:33 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BFA131F3B8;
        Tue, 11 Jan 2022 08:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641890492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qrf8PNeNEVsS9AToHTl2fRoEbnuL360momcCs7MV/Sg=;
        b=ecugM7jQuj/2S3JHjsuidBQqPtwwEX4TGWpLLZt+mGtoKTsyv7KiL/V8T3ykq5QhPyepzb
        avM3gfZF8eubZ8zI8PtyljwP4pGNP2V5BBtD/C/V2DMnKk0HmkHhlMqJ0pODA7hATwq7RX
        +ZE+8TsvtCdZWhxr/eNU6TbpGutY1UQ=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8C68DA3B8E;
        Tue, 11 Jan 2022 08:41:32 +0000 (UTC)
Date:   Tue, 11 Jan 2022 09:41:32 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, shakeelb@google.com, guro@fb.com,
        vbabka@suse.cz, willy@infradead.org, songmuchun@bytedance.com,
        shy828301@gmail.com, surenb@google.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 2/4] mm/memcg: mem_cgroup_per_node is already set to 0 on
 allocation
Message-ID: <Yd1CvBVpCj5y0qZU@dhcp22.suse.cz>
References: <20220111010302.8864-1-richard.weiyang@gmail.com>
 <20220111010302.8864-2-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111010302.8864-2-richard.weiyang@gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 11-01-22 01:03:00, Wei Yang wrote:
> kzalloc_node() would set data to 0, so it's not necessary to set it
> again.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memcontrol.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 11715f7323c0..a504616f904a 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5067,8 +5067,6 @@ static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
>  	}
>  
>  	lruvec_init(&pn->lruvec);
> -	pn->usage_in_excess = 0;
> -	pn->on_tree = false;
>  	pn->memcg = memcg;
>  
>  	memcg->nodeinfo[node] = pn;
> -- 
> 2.33.1

-- 
Michal Hocko
SUSE Labs
