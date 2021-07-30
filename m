Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33EDF3DB3DF
	for <lists+cgroups@lfdr.de>; Fri, 30 Jul 2021 08:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237573AbhG3GuJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 30 Jul 2021 02:50:09 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41742 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237278AbhG3GuI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 30 Jul 2021 02:50:08 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4A6841FDB2;
        Fri, 30 Jul 2021 06:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627627803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xojnLgK/32nxOjCn8ZrhjIhAgNUPqzZVxeCUL5Yhwn8=;
        b=hAr/6b2qqY+vI9OuPMkGd1wYvnwVpqYOzmgAWJVVfz/cuy4qh4vYDL8ENtabW+YJ+NeJuV
        S+MgrWHeMKCcm8MUeT3IoYVeA5003ijTHbYjXne5Fz+LyJAh2BJittkpTk5+5blrGinP4y
        b0qhbxN2wMXENaebAmqI7+QsEl98acY=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0D53EA3B87;
        Fri, 30 Jul 2021 06:50:02 +0000 (UTC)
Date:   Fri, 30 Jul 2021 08:50:02 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, akpm@linux-foundation.org,
        shakeelb@google.com, willy@infradead.org, alexs@kernel.org,
        richard.weiyang@gmail.com, songmuchun@bytedance.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH 2/5] mm, memcg: narrow the scope of percpu_charge_mutex
Message-ID: <YQOhGs3k9rHx3mmT@dhcp22.suse.cz>
References: <20210729125755.16871-1-linmiaohe@huawei.com>
 <20210729125755.16871-3-linmiaohe@huawei.com>
 <YQNsxVPsRSBZcfGG@carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQNsxVPsRSBZcfGG@carbon.lan>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 29-07-21 20:06:45, Roman Gushchin wrote:
> On Thu, Jul 29, 2021 at 08:57:52PM +0800, Miaohe Lin wrote:
> > Since percpu_charge_mutex is only used inside drain_all_stock(), we can
> > narrow the scope of percpu_charge_mutex by moving it here.
> > 
> > Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> > ---
> >  mm/memcontrol.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 6580c2381a3e..a03e24e57cd9 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -2050,7 +2050,6 @@ struct memcg_stock_pcp {
> >  #define FLUSHING_CACHED_CHARGE	0
> >  };
> >  static DEFINE_PER_CPU(struct memcg_stock_pcp, memcg_stock);
> > -static DEFINE_MUTEX(percpu_charge_mutex);
> >  
> >  #ifdef CONFIG_MEMCG_KMEM
> >  static void drain_obj_stock(struct obj_stock *stock);
> > @@ -2209,6 +2208,7 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
> >   */
> >  static void drain_all_stock(struct mem_cgroup *root_memcg)
> >  {
> > +	static DEFINE_MUTEX(percpu_charge_mutex);
> >  	int cpu, curcpu;
> 
> It's considered a good practice to protect data instead of code paths. After
> the proposed change it becomes obvious that the opposite is done here: the mutex
> is used to prevent a simultaneous execution of the code of the drain_all_stock()
> function.

The purpose of the lock was indeed to orchestrate callers more than any
data structure consistency.
 
> Actually we don't need a mutex here: nobody ever sleeps on it. So I'd replace
> it with a simple atomic variable or even a single bitfield. Then the change will
> be better justified, IMO.

Yes, mutex can be replaced by an atomic in a follow up patch.
-- 
Michal Hocko
SUSE Labs
