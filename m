Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C343DB3C6
	for <lists+cgroups@lfdr.de>; Fri, 30 Jul 2021 08:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237517AbhG3GpS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 30 Jul 2021 02:45:18 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41458 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237205AbhG3GpS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 30 Jul 2021 02:45:18 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1187F1FDB1;
        Fri, 30 Jul 2021 06:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627627513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WGSyxiu3mrpSdkjXI3OCcCS7NGg99qcrN67xRlpt+bI=;
        b=IWh87TmkxKW563aoJcyB30+0gBdeVgoR4oJhyn/AYZvZFSpSJXs26QYdLwE5pjm4gdPxBa
        hzHiMc9UMDaYVP718QqWr/dn9w7IizFkFnIHAKFFvOfwzZNUDRrGAKFN8A0EdbAuy5/vSv
        JbSeOr284ji3GsEFA12JxCn9klheDSo=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C9291A3B88;
        Fri, 30 Jul 2021 06:45:12 +0000 (UTC)
Date:   Fri, 30 Jul 2021 08:45:12 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, shakeelb@google.com, guro@fb.com,
        willy@infradead.org, alexs@kernel.org, richard.weiyang@gmail.com,
        songmuchun@bytedance.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH 1/5] mm, memcg: remove unused functions
Message-ID: <YQOf+OAKmGxE6+k/@dhcp22.suse.cz>
References: <20210729125755.16871-1-linmiaohe@huawei.com>
 <20210729125755.16871-2-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729125755.16871-2-linmiaohe@huawei.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 29-07-21 20:57:51, Miaohe Lin wrote:
> Since commit 2d146aa3aa84 ("mm: memcontrol: switch to rstat"), last user
> of memcg_stat_item_in_bytes() is gone. And since commit fa40d1ee9f15 ("mm:
> vmscan: memcontrol: remove mem_cgroup_select_victim_node()"), only the
> declaration of mem_cgroup_select_victim_node() is remained here. Remove
> them.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/memcontrol.h | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 7028d8e4a3d7..04437504444f 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -606,13 +606,6 @@ static inline bool PageMemcgKmem(struct page *page)
>  	return folio_memcg_kmem(page_folio(page));
>  }
>  
> -static __always_inline bool memcg_stat_item_in_bytes(int idx)
> -{
> -	if (idx == MEMCG_PERCPU_B)
> -		return true;
> -	return vmstat_item_in_bytes(idx);
> -}
> -
>  static inline bool mem_cgroup_is_root(struct mem_cgroup *memcg)
>  {
>  	return (memcg == root_mem_cgroup);
> @@ -916,11 +909,6 @@ static inline bool mem_cgroup_online(struct mem_cgroup *memcg)
>  	return !!(memcg->css.flags & CSS_ONLINE);
>  }
>  
> -/*
> - * For memory reclaim.
> - */
> -int mem_cgroup_select_victim_node(struct mem_cgroup *memcg);
> -
>  void mem_cgroup_update_lru_size(struct lruvec *lruvec, enum lru_list lru,
>  		int zid, int nr_pages);
>  
> -- 
> 2.23.0

-- 
Michal Hocko
SUSE Labs
