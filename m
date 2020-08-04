Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3DA23BB25
	for <lists+cgroups@lfdr.de>; Tue,  4 Aug 2020 15:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbgHDNZy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 Aug 2020 09:25:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:47376 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728287AbgHDNZu (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 4 Aug 2020 09:25:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 71531B5FB;
        Tue,  4 Aug 2020 13:26:04 +0000 (UTC)
Date:   Tue, 4 Aug 2020 15:25:47 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/2][next] mm: memcontrol: Use the preferred form for
 passing the size of a structure type
Message-ID: <20200804132547.GD7306@dhcp22.suse.cz>
References: <cover.1596214831.git.gustavoars@kernel.org>
 <773e013ff2f07fe2a0b47153f14dea054c0c04f1.1596214831.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <773e013ff2f07fe2a0b47153f14dea054c0c04f1.1596214831.git.gustavoars@kernel.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 31-07-20 12:13:14, Gustavo A. R. Silva wrote:
> Use the preferred form for passing the size of a structure type. The
> alternative form where the structure type is spelled out hurts
> readability and introduces an opportunity for a bug when the object
> type is changed but the corresponding object identifier to which the
> sizeof operator is applied is not.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memcontrol.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index bd7f972ceea4..bd0f56785841 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4255,7 +4255,7 @@ static int __mem_cgroup_usage_register_event(struct mem_cgroup *memcg,
>  	new->entries[size - 1].threshold = threshold;
>  
>  	/* Sort thresholds. Registering of new threshold isn't time-critical */
> -	sort(new->entries, size, sizeof(struct mem_cgroup_threshold),
> +	sort(new->entries, size, sizeof(*new->entries),
>  			compare_thresholds, NULL);
>  
>  	/* Find current threshold */
> -- 
> 2.27.0

-- 
Michal Hocko
SUSE Labs
