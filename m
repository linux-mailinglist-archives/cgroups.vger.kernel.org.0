Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA84478A41
	for <lists+cgroups@lfdr.de>; Fri, 17 Dec 2021 12:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235606AbhLQLmy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 Dec 2021 06:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235474AbhLQLmx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 17 Dec 2021 06:42:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53761C061574;
        Fri, 17 Dec 2021 03:42:53 -0800 (PST)
Date:   Fri, 17 Dec 2021 12:42:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639741371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3/ancgIFgkXeO3NDEPeVGpgn07wkYNrxt0m0tDBAo20=;
        b=r9nEpz+wZp4vfF/Gu2Vs1J8cQGszY5GTzaCwHMLoUcdK3QhP58IZzWaQFpOl+Ez/g+yCDV
        eL/PwjSebD3D9tVO0d90NcbkeO5fuNs7862UwJMTdZAWnjZ8R8qQqHzTkzkKdDp7zqiXIq
        rLLI/ShKnpmtSAlFha/c+luhZDNoXDSsst+e4bBBauovDVvfRAqXQ1F4R6aakFAcvHt7Ow
        EGjtvUzpTu17fPvqlkxE68I18P3FNsJRsu4ZW6Fk7eu90NOJfYi5wnKF+daB8+NXUk/Wvo
        O/f7RsowfsQxUmnbG3+uzA/zWnxCTJcaqyg339qiPsuTRQP1+Ly3bLAMLsY/OQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639741371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3/ancgIFgkXeO3NDEPeVGpgn07wkYNrxt0m0tDBAo20=;
        b=ExKsbpBJPazNTYPG4oRZ2RNYzMs9Rfo2Vd/yrEk6XGqBqAS5LzFrUd0qDG1XzlNZGMUfFQ
        L/wNcK/zVkl+fJAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH-next v3] mm/memcg: Properly handle memcg_stock access for
 PREEMPT_RT
Message-ID: <Ybx3ubNFfGpCqhn0@linutronix.de>
References: <20211214144412.447035-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211214144412.447035-1-longman@redhat.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2021-12-14 09:44:12 [-0500], Waiman Long wrote:
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2096,7 +2096,12 @@ struct obj_stock {
>  #endif
>  };
>  
> +/*
> + * The local_lock protects the whole memcg_stock_pcp structure including
> + * the embedded obj_stock structures.
> + */
>  struct memcg_stock_pcp {
> +	local_lock_t lock;
>  	struct mem_cgroup *cached; /* this never be root cgroup */
>  	unsigned int nr_pages;
>  	struct obj_stock task_obj;
> @@ -2145,7 +2150,7 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
>  	if (nr_pages > MEMCG_CHARGE_BATCH)
>  		return ret;
>  
> -	local_irq_save(flags);
> +	local_lock_irqsave(&memcg_stock.lock, flags);

This still does not explain why the lock is acquired here where it
appears to be unrelated to memcg_stock.lock.

>  
>  	stock = this_cpu_ptr(&memcg_stock);
>  	if (memcg == stock->cached && stock->nr_pages >= nr_pages) {
> @@ -2779,29 +2784,34 @@ static struct mem_cgroup *get_mem_cgroup_from_objcg(struct obj_cgroup *objcg)
>   * which is cheap in non-preempt kernel. The interrupt context object stock
>   * can only be accessed after disabling interrupt. User context code can
>   * access interrupt object stock, but not vice versa.
> + *
> + * This task and interrupt context optimization is disabled for PREEMPT_RT
> + * as there is no performance gain in this case and changes will be made to
> + * irq_obj only.
> + *
> + * For non-PREEMPT_RT, we are not replacing preempt_disable() by local_lock()
> + * as nesting of task_obj and irq_obj are allowed which may cause lockdep
> + * splat if local_lock() is used. Using separate local locks will complicate
> + * the interaction between obj_stock and the broader memcg_stock object.
>   */
>  static inline struct obj_stock *get_obj_stock(unsigned long *pflags)
>  {
> -	struct memcg_stock_pcp *stock;
> -
> -	if (likely(in_task())) {
> +	if (likely(in_task()) && !IS_ENABLED(CONFIG_PREEMPT_RT)) {
>  		*pflags = 0UL;
>  		preempt_disable();
> -		stock = this_cpu_ptr(&memcg_stock);
> -		return &stock->task_obj;
> +		return this_cpu_ptr(&memcg_stock.task_obj);

Do we need to keep the memcg_stock.task_obj for !RT?
I'm not really convinced that disabling either preemption or interrupts
is so much better compared to actual locking locking with lockdep
annotation. Looking at the history, I'm also impressed by that fact that
disabling/ enabling interrupts is *so* expensive that all this is
actually worth it.

>  	}
>  
> -	local_irq_save(*pflags);
> -	stock = this_cpu_ptr(&memcg_stock);
> -	return &stock->irq_obj;
> +	local_lock_irqsave(&memcg_stock.lock, *pflags);
> +	return this_cpu_ptr(&memcg_stock.irq_obj);
>  }
>  

Sebastian
