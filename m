Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC0E421824
	for <lists+cgroups@lfdr.de>; Fri, 17 May 2019 14:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbfEQM1H (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 May 2019 08:27:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:59000 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728365AbfEQM1H (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 17 May 2019 08:27:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9D97DAEF5;
        Fri, 17 May 2019 12:27:05 +0000 (UTC)
Date:   Fri, 17 May 2019 14:27:05 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org,
        Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] memcg: make it work on sparse non-0-node systems
Message-ID: <20190517122705.GH6836@dhcp22.suse.cz>
References: <20190517080044.tnwhbeyxcccsymgf@esperanza>
 <20190517114204.6330-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517114204.6330-1-jslaby@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 17-05-19 13:42:04, Jiri Slaby wrote:
> We have a single node system with node 0 disabled:
>   Scanning NUMA topology in Northbridge 24
>   Number of physical nodes 2
>   Skipping disabled node 0
>   Node 1 MemBase 0000000000000000 Limit 00000000fbff0000
>   NODE_DATA(1) allocated [mem 0xfbfda000-0xfbfeffff]
> 
> This causes crashes in memcg when system boots:
>   BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
>   #PF error: [normal kernel read fault]
> ...
>   RIP: 0010:list_lru_add+0x94/0x170
> ...
>   Call Trace:
>    d_lru_add+0x44/0x50
>    dput.part.34+0xfc/0x110
>    __fput+0x108/0x230
>    task_work_run+0x9f/0xc0
>    exit_to_usermode_loop+0xf5/0x100
> 
> It is reproducible as far as 4.12. I did not try older kernels. You have
> to have a new enough systemd, e.g. 241 (the reason is unknown -- was not
> investigated). Cannot be reproduced with systemd 234.
> 
> The system crashes because the size of lru array is never updated in
> memcg_update_all_list_lrus and the reads are past the zero-sized array,
> causing dereferences of random memory.
> 
> The root cause are list_lru_memcg_aware checks in the list_lru code.
> The test in list_lru_memcg_aware is broken: it assumes node 0 is always
> present, but it is not true on some systems as can be seen above.
> 
> So fix this by avoiding checks on node 0. Remember the memcg-awareness
> by a bool flag in struct list_lru.
> 
> [v2] use the idea proposed by Vladimir -- the bool flag.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Suggested-by: Vladimir Davydov <vdavydov.dev@gmail.com>
> Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: <cgroups@vger.kernel.org>
> Cc: <linux-mm@kvack.org>
> Cc: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>

Fixes: 60d3fd32a7a9 ("list_lru: introduce per-memcg lists")
unless I have missed something

Cc: stable sounds like a good idea to me as well, although nobody has
noticed this yet but Node0 machines are quite rare.

I haven't checked all users of list_lru but the structure size increase
shouldn't be a big problem. There tend to be only limited number of
those and the number shouldn't be huge.

So this looks good to me.
Acked-by: Michal Hocko <mhocko@suse.com>

Thanks a lot Jiri!

> ---
>  include/linux/list_lru.h | 1 +
>  mm/list_lru.c            | 8 +++-----
>  2 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
> index aa5efd9351eb..d5ceb2839a2d 100644
> --- a/include/linux/list_lru.h
> +++ b/include/linux/list_lru.h
> @@ -54,6 +54,7 @@ struct list_lru {
>  #ifdef CONFIG_MEMCG_KMEM
>  	struct list_head	list;
>  	int			shrinker_id;
> +	bool			memcg_aware;
>  #endif
>  };
>  
> diff --git a/mm/list_lru.c b/mm/list_lru.c
> index 0730bf8ff39f..d3b538146efd 100644
> --- a/mm/list_lru.c
> +++ b/mm/list_lru.c
> @@ -37,11 +37,7 @@ static int lru_shrinker_id(struct list_lru *lru)
>  
>  static inline bool list_lru_memcg_aware(struct list_lru *lru)
>  {
> -	/*
> -	 * This needs node 0 to be always present, even
> -	 * in the systems supporting sparse numa ids.
> -	 */
> -	return !!lru->node[0].memcg_lrus;
> +	return lru->memcg_aware;
>  }
>  
>  static inline struct list_lru_one *
> @@ -451,6 +447,8 @@ static int memcg_init_list_lru(struct list_lru *lru, bool memcg_aware)
>  {
>  	int i;
>  
> +	lru->memcg_aware = memcg_aware;
> +
>  	if (!memcg_aware)
>  		return 0;
>  
> -- 
> 2.21.0

-- 
Michal Hocko
SUSE Labs
