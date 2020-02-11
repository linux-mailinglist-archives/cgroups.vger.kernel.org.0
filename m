Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8AA0158D93
	for <lists+cgroups@lfdr.de>; Tue, 11 Feb 2020 12:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgBKLcb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Feb 2020 06:32:31 -0500
Received: from relay.sw.ru ([185.231.240.75]:54258 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727692AbgBKLcb (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 11 Feb 2020 06:32:31 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1j1Tlz-0007Lf-8u; Tue, 11 Feb 2020 14:32:11 +0300
Subject: Re: [PATCH] memcg: lost css_put in memcg_expand_shrinker_maps()
To:     Vasily Averin <vvs@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org
References: <c98414fb-7e1f-da0f-867a-9340ec4bd30b@virtuozzo.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <995ffe9f-14c6-39ea-31b9-52194fa1da54@virtuozzo.com>
Date:   Tue, 11 Feb 2020 14:32:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <c98414fb-7e1f-da0f-867a-9340ec4bd30b@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 11.02.2020 14:20, Vasily Averin wrote:
> for_each_mem_cgroup() increases css reference counter for memory cgroup
> and requires to use mem_cgroup_iter_break() if the walk is cancelled.
> 
> Cc: stable@vger.kernel.org
> Fixes commit 0a4465d34028("mm, memcg: assign memcg-aware shrinkers bitmap to memcg")
> 
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>

Acked-by: Kirill Tkhai <ktkhai@virtuozzo.com>

Thanks!

> ---
>  mm/memcontrol.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 6c83cf4..e2da615 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -409,8 +409,10 @@ int memcg_expand_shrinker_maps(int new_id)
>  		if (mem_cgroup_is_root(memcg))
>  			continue;
>  		ret = memcg_expand_one_shrinker_map(memcg, size, old_size);
> -		if (ret)
> +		if (ret) {
> +			mem_cgroup_iter_break(NULL, memcg);
>  			goto unlock;
> +		}
>  	}
>  unlock:
>  	if (!ret)
> 

