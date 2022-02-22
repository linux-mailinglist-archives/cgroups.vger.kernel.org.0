Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE7E4BF533
	for <lists+cgroups@lfdr.de>; Tue, 22 Feb 2022 10:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbiBVJ5M (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Feb 2022 04:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbiBVJ5L (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Feb 2022 04:57:11 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F451A38E
        for <cgroups@vger.kernel.org>; Tue, 22 Feb 2022 01:56:43 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3142F1F39A;
        Tue, 22 Feb 2022 09:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645523802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VGiep3feZi3i71q2uR3AtjKvdwdXMRiWG5Ve1qZIums=;
        b=HH/AA24vtus8H7QzqmXfaHlpyMoTTdIz4y7K1qhVbmoA0oHm70LgWbqT7UD5GdFkWF18uu
        6PWMKoEWPeLobCcxBRmt/+cxE91ngjt3PJR1FWOxIrecN5iuOvg8hafX5lil//rLNxm2tF
        DM5K8wHHX7YrlQpH9ouqeYgQBo/Jx/4=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1B290A3B85;
        Tue, 22 Feb 2022 09:56:42 +0000 (UTC)
Date:   Tue, 22 Feb 2022 10:56:41 +0100
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
Subject: Re: [PATCH v4 6/6] mm/memcg: Disable migration instead of preemption
 in drain_all_stock().
Message-ID: <YhSzWXyPe14vOaGa@dhcp22.suse.cz>
References: <20220221182540.380526-1-bigeasy@linutronix.de>
 <20220221182540.380526-7-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221182540.380526-7-bigeasy@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 21-02-22 19:25:40, Sebastian Andrzej Siewior wrote:
> Before the for-each-CPU loop, preemption is disabled so that so that
> drain_local_stock() can be invoked directly instead of scheduling a
> worker. Ensuring that drain_local_stock() completed on the local CPU is
> not correctness problem. It _could_ be that the charging path will be
> forced to reclaim memory because cached charges are still waiting for
> their draining.
> 
> Disabling preemption before invoking drain_local_stock() is problematic
> on PREEMPT_RT due to the sleeping locks involved. To ensure that no CPU
> migrations happens across the for_each_online_cpu() it is enouhg to use
> migrate_disable() which disables migration and keeps context preemptible
> to a sleeping lock can be acquired.

I would just add that a race with cpu hotplug is not a problem because
pcp data is not going away. In the worst case we just schedule draining
of an empty stock.
> 
> Use migrate_disable() instead of get_cpu() around the
> for_each_online_cpu() loop.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  mm/memcontrol.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 3d7ccb104374c..9c29b1a0e6bec 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2293,7 +2293,8 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
>  	 * as well as workers from this path always operate on the local
>  	 * per-cpu data. CPU up doesn't touch memcg_stock at all.
>  	 */
> -	curcpu = get_cpu();
> +	migrate_disable();
> +	curcpu = smp_processor_id();
>  	for_each_online_cpu(cpu) {
>  		struct memcg_stock_pcp *stock = &per_cpu(memcg_stock, cpu);
>  		struct mem_cgroup *memcg;
> @@ -2316,7 +2317,7 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
>  				schedule_work_on(cpu, &stock->work);
>  		}
>  	}
> -	put_cpu();
> +	migrate_enable();
>  	mutex_unlock(&percpu_charge_mutex);
>  }
>  
> -- 
> 2.35.1

-- 
Michal Hocko
SUSE Labs
