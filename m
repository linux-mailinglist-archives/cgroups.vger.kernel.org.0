Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1571C3108FA
	for <lists+cgroups@lfdr.de>; Fri,  5 Feb 2021 11:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbhBEKYT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 5 Feb 2021 05:24:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:38156 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231341AbhBEKWf (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 5 Feb 2021 05:22:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612520509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=441WHve7NP2TxAMx0OJ30INfKQWqrKfmb5j39ihe/DY=;
        b=vD+GXDhlMi+q+LG9eTNBL8QlKKkp0Yk2YsIRnv1U0jtK12zgNa84A5lVmwU25sEhOXR1g3
        r/tOBtkZeacMgrU3FSrlbpsoUpc6zQv2UU0Pk7EeQE2dfk4jtBkU3TZXUhKrL67tRGs+5K
        iR6YLPQo02cieBvDO2ytc1YLsSVnVWI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 181A3ACF4;
        Fri,  5 Feb 2021 10:21:49 +0000 (UTC)
Date:   Fri, 5 Feb 2021 11:21:47 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [External] Re: [PATCH] mm: memcontrol: fix missing wakeup oom
 task
Message-ID: <YB0cO7R1WtJgAxI2@dhcp22.suse.cz>
References: <20210205062310.74268-1-songmuchun@bytedance.com>
 <YB0Ay+epP/hnFmDS@dhcp22.suse.cz>
 <CAMZfGtWKNNhc1Jy1jzp2uZU_PM6GNWup7d=yUVk9AehKFo_CRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtWKNNhc1Jy1jzp2uZU_PM6GNWup7d=yUVk9AehKFo_CRw@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 05-02-21 17:55:10, Muchun Song wrote:
> On Fri, Feb 5, 2021 at 4:24 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Fri 05-02-21 14:23:10, Muchun Song wrote:
> > > We call memcg_oom_recover() in the uncharge_batch() to wakeup OOM task
> > > when page uncharged, but for the slab pages, we do not do this when page
> > > uncharged.
> >
> > How does the patch deal with this?
> 
> When we uncharge a slab page via __memcg_kmem_uncharge,
> actually, this path forgets to do this for us compared to
> uncharge_batch(). Right?

Yes this was more more or less clear (still would have been nicer to be
explicit). But you still haven't replied to my question I believe. I
assume you rely on refill_stock doing draining but how does this address
the problem? Is it sufficient to do wakeups in the batched way?

> > > When we drain per cpu stock, we also should do this.
> >
> > Can we have anything the per-cpu stock while entering the OOM path. IIRC
> > we do drain all cpus before entering oom path.
> 
> You are right. I did not notice this. Thank you.
> 
> >
> > > The memcg_oom_recover() is small, so make it inline.
> >
> > Does this lead to any code generation improvements? I would expect
> > compiler to be clever enough to inline static functions if that pays
> > off. If yes make this a patch on its own.
> 
> I have disassembled the code, I see memcg_oom_recover is not
> inline. Maybe because memcg_oom_recover has a lot of callers.
> Just guess.
> 
> (gdb) disassemble uncharge_batch
>  [...]
>  0xffffffff81341c73 <+227>: callq  0xffffffff8133c420 <page_counter_uncharge>
>  0xffffffff81341c78 <+232>: jmpq   0xffffffff81341bc0 <uncharge_batch+48>
>  0xffffffff81341c7d <+237>: callq  0xffffffff8133e2c0 <memcg_oom_recover>

So does it really help to do the inlining?
-- 
Michal Hocko
SUSE Labs
