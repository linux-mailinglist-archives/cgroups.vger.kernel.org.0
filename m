Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9DB4BDB91
	for <lists+cgroups@lfdr.de>; Mon, 21 Feb 2022 18:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377813AbiBUOan (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 21 Feb 2022 09:30:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377804AbiBUOaj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 21 Feb 2022 09:30:39 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197691EC5E
        for <cgroups@vger.kernel.org>; Mon, 21 Feb 2022 06:30:16 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CD65A2111A;
        Mon, 21 Feb 2022 14:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645453814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xm5m5YiRWNUhvkICSeUY+DU1RylDk3jyPhrK51qcDfU=;
        b=RI+5ECT2uxILC9RTBymw2xV51hIRlXaYMtIXbM3ktUPQUicUDNCR7d1vERywSgHfdUd7n0
        AgTDm8Lc6+1ZeJhJV2fPialDUPlHZB8eyDXBj1QUcnHZ55bTgR/fFlDb4lZ4oMWZTnlyWq
        545ns6J9/mvk9C8peXnTcNCen1lZz90=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9D011A3B87;
        Mon, 21 Feb 2022 14:30:14 +0000 (UTC)
Date:   Mon, 21 Feb 2022 15:30:14 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v3 4/5] mm/memcg: Opencode the inner part of
 obj_cgroup_uncharge_pages() in drain_obj_stock()
Message-ID: <YhOh9jr9mBpMFmSn@dhcp22.suse.cz>
References: <20220217094802.3644569-1-bigeasy@linutronix.de>
 <20220217094802.3644569-5-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217094802.3644569-5-bigeasy@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 17-02-22 10:48:01, Sebastian Andrzej Siewior wrote:
> From: Johannes Weiner <hannes@cmpxchg.org>
> 
> Provide the inner part of refill_stock() as __refill_stock() without
> disabling interrupts. This eases the integration of local_lock_t where
> recursive locking must be avoided.
> Open code obj_cgroup_uncharge_pages() in drain_obj_stock() and use
> __refill_stock(). The caller of drain_obj_stock() already disables
> interrupts.
> 
> [bigeasy: Patch body around Johannes' diff ]
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  mm/memcontrol.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 36ab3660f2c6d..a3225501cce36 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2224,12 +2224,9 @@ static void drain_local_stock(struct work_struct *dummy)
>   * Cache charges(val) to local per_cpu area.
>   * This will be consumed by consume_stock() function, later.
>   */
> -static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
> +static void __refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
>  {
>  	struct memcg_stock_pcp *stock;
> -	unsigned long flags;
> -
> -	local_irq_save(flags);
>  
>  	stock = this_cpu_ptr(&memcg_stock);
>  	if (stock->cached != memcg) { /* reset if necessary */
> @@ -2241,7 +2238,14 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
>  
>  	if (stock->nr_pages > MEMCG_CHARGE_BATCH)
>  		drain_stock(stock);
> +}
>  
> +static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
> +{
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	__refill_stock(memcg, nr_pages);
>  	local_irq_restore(flags);
>  }
>  
> @@ -3158,8 +3162,16 @@ static void drain_obj_stock(struct memcg_stock_pcp *stock)
>  		unsigned int nr_pages = stock->nr_bytes >> PAGE_SHIFT;
>  		unsigned int nr_bytes = stock->nr_bytes & (PAGE_SIZE - 1);
>  
> -		if (nr_pages)
> -			obj_cgroup_uncharge_pages(old, nr_pages);
> +		if (nr_pages) {
> +			struct mem_cgroup *memcg;
> +
> +			memcg = get_mem_cgroup_from_objcg(old);
> +
> +			memcg_account_kmem(memcg, -nr_pages);
> +			__refill_stock(memcg, nr_pages);
> +
> +			css_put(&memcg->css);
> +		}
>  
>  		/*
>  		 * The leftover is flushed to the centralized per-memcg value.
> -- 
> 2.34.1

-- 
Michal Hocko
SUSE Labs
