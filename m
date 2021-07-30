Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E84003DB3D0
	for <lists+cgroups@lfdr.de>; Fri, 30 Jul 2021 08:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237632AbhG3Gqx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 30 Jul 2021 02:46:53 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41512 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237616AbhG3Gqx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 30 Jul 2021 02:46:53 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D83C11FDB2;
        Fri, 30 Jul 2021 06:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627627607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9qUmfJ205mXFr7otIjDg3EOb6cwhRcnR91bxEVSEz+8=;
        b=CJHgYMs1CvZagyfxxxI3oeb8NfQGKjLgWO/PUNDHKEgTVynQASUGA8s6blb1AWsd2frYz2
        sq1XsTCNSHlmJ3uSMeG9rQFwB7/EqyORaLPfg6BFw0nYMgKy8CG6RTKkqYsdspUVMww3GR
        C4dS7HVczMazNbEDpVhfBz2IHr8Eu48=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id ADEB1A3B88;
        Fri, 30 Jul 2021 06:46:47 +0000 (UTC)
Date:   Fri, 30 Jul 2021 08:46:45 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, shakeelb@google.com, guro@fb.com,
        willy@infradead.org, alexs@kernel.org, richard.weiyang@gmail.com,
        songmuchun@bytedance.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH 2/5] mm, memcg: narrow the scope of percpu_charge_mutex
Message-ID: <YQOgVfSrQRWdfiJH@dhcp22.suse.cz>
References: <20210729125755.16871-1-linmiaohe@huawei.com>
 <20210729125755.16871-3-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729125755.16871-3-linmiaohe@huawei.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 29-07-21 20:57:52, Miaohe Lin wrote:
> Since percpu_charge_mutex is only used inside drain_all_stock(), we can
> narrow the scope of percpu_charge_mutex by moving it here.

Makes sense and this is usually my preference as well. We used to have
other caller back then so I couldn't.

> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  mm/memcontrol.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 6580c2381a3e..a03e24e57cd9 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2050,7 +2050,6 @@ struct memcg_stock_pcp {
>  #define FLUSHING_CACHED_CHARGE	0
>  };
>  static DEFINE_PER_CPU(struct memcg_stock_pcp, memcg_stock);
> -static DEFINE_MUTEX(percpu_charge_mutex);
>  
>  #ifdef CONFIG_MEMCG_KMEM
>  static void drain_obj_stock(struct obj_stock *stock);
> @@ -2209,6 +2208,7 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
>   */
>  static void drain_all_stock(struct mem_cgroup *root_memcg)
>  {
> +	static DEFINE_MUTEX(percpu_charge_mutex);
>  	int cpu, curcpu;
>  
>  	/* If someone's already draining, avoid adding running more workers. */
> -- 
> 2.23.0

-- 
Michal Hocko
SUSE Labs
