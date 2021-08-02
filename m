Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E25F3DD0C5
	for <lists+cgroups@lfdr.de>; Mon,  2 Aug 2021 08:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbhHBGtb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Aug 2021 02:49:31 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:36690 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhHBGta (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Aug 2021 02:49:30 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A13871FF2C;
        Mon,  2 Aug 2021 06:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627886960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q7PGCIa5dKr+zd9QXo1w6BYL7jP8T2ubQzOp7fxIYBo=;
        b=HU962FsCvbDVraAaI8paM+qVfe5IewCn44+dP/CX81ZlPfpNkBA8DsBLvPSoYPFZoqjIiN
        xNW7R0UwCkOFg8/qZuytNpEVqMkSnSw/rnXR4hQuuwbd3VXQhH/3XeLGwPZFQH5L/4+NIz
        E1gqlLeGGJ84o7CSyorpMjlhAUSJQC0=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 73312A3B85;
        Mon,  2 Aug 2021 06:49:20 +0000 (UTC)
Date:   Mon, 2 Aug 2021 08:49:04 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Roman Gushchin <guro@fb.com>, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, akpm@linux-foundation.org,
        shakeelb@google.com, willy@infradead.org, alexs@kernel.org,
        richard.weiyang@gmail.com, songmuchun@bytedance.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH 2/5] mm, memcg: narrow the scope of percpu_charge_mutex
Message-ID: <YQeVYLP6M9tMw0P0@dhcp22.suse.cz>
References: <20210729125755.16871-1-linmiaohe@huawei.com>
 <20210729125755.16871-3-linmiaohe@huawei.com>
 <YQNsxVPsRSBZcfGG@carbon.lan>
 <YQOhGs3k9rHx3mmT@dhcp22.suse.cz>
 <4a3c23c4-054c-2896-29c5-8cf9a4deee98@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4a3c23c4-054c-2896-29c5-8cf9a4deee98@huawei.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat 31-07-21 10:29:52, Miaohe Lin wrote:
> On 2021/7/30 14:50, Michal Hocko wrote:
> > On Thu 29-07-21 20:06:45, Roman Gushchin wrote:
> >> On Thu, Jul 29, 2021 at 08:57:52PM +0800, Miaohe Lin wrote:
> >>> Since percpu_charge_mutex is only used inside drain_all_stock(), we can
> >>> narrow the scope of percpu_charge_mutex by moving it here.
> >>>
> >>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> >>> ---
> >>>  mm/memcontrol.c | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> >>> index 6580c2381a3e..a03e24e57cd9 100644
> >>> --- a/mm/memcontrol.c
> >>> +++ b/mm/memcontrol.c
> >>> @@ -2050,7 +2050,6 @@ struct memcg_stock_pcp {
> >>>  #define FLUSHING_CACHED_CHARGE	0
> >>>  };
> >>>  static DEFINE_PER_CPU(struct memcg_stock_pcp, memcg_stock);
> >>> -static DEFINE_MUTEX(percpu_charge_mutex);
> >>>  
> >>>  #ifdef CONFIG_MEMCG_KMEM
> >>>  static void drain_obj_stock(struct obj_stock *stock);
> >>> @@ -2209,6 +2208,7 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
> >>>   */
> >>>  static void drain_all_stock(struct mem_cgroup *root_memcg)
> >>>  {
> >>> +	static DEFINE_MUTEX(percpu_charge_mutex);
> >>>  	int cpu, curcpu;
> >>
> >> It's considered a good practice to protect data instead of code paths. After
> >> the proposed change it becomes obvious that the opposite is done here: the mutex
> >> is used to prevent a simultaneous execution of the code of the drain_all_stock()
> >> function.
> > 
> > The purpose of the lock was indeed to orchestrate callers more than any
> > data structure consistency.
> >  
> >> Actually we don't need a mutex here: nobody ever sleeps on it. So I'd replace
> >> it with a simple atomic variable or even a single bitfield. Then the change will
> >> be better justified, IMO.
> > 
> > Yes, mutex can be replaced by an atomic in a follow up patch.
> > 
> 
> Thanks for both of you. It's a really good suggestion. What do you mean is something like below？
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 616d1a72ece3..508a96e80980 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2208,11 +2208,11 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
>   */
>  static void drain_all_stock(struct mem_cgroup *root_memcg)
>  {
> -       static DEFINE_MUTEX(percpu_charge_mutex);
>         int cpu, curcpu;
> +       static atomic_t drain_all_stocks = ATOMIC_INIT(-1);
>         /* If someone's already draining, avoid adding running more workers. */
> -       if (!mutex_trylock(&percpu_charge_mutex))
> +       if (!atomic_inc_not_zero(&drain_all_stocks))
>                 return;
>         /*
>          * Notify other cpus that system-wide "drain" is running
> @@ -2244,7 +2244,7 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
>                 }
>         }
>         put_cpu();
> -       mutex_unlock(&percpu_charge_mutex);
> +       atomic_dec(&drain_all_stocks);

Yes this would work. I would just s@drain_all_stocks@drainers@ or
something similar to better express the intention.

>  }
> 
>  static int memcg_hotplug_cpu_dead(unsigned int cpu)

-- 
Michal Hocko
SUSE Labs
