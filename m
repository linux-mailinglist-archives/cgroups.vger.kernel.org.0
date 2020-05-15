Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 611901D4677
	for <lists+cgroups@lfdr.de>; Fri, 15 May 2020 08:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgEOG4y (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 May 2020 02:56:54 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50888 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbgEOG4v (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 May 2020 02:56:51 -0400
Received: by mail-wm1-f67.google.com with SMTP id m12so1159123wmc.0
        for <cgroups@vger.kernel.org>; Thu, 14 May 2020 23:56:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gv3CAFaRo/QH/SVWR5TaA0G+kc4MrXfRuIx/6zYFIgQ=;
        b=rP2vBVx17O1wIWviNRIcUc7MJGPTfVuFJgSIbSCQ0kSraEbouNMftshSVxrkXDGRnO
         S/bXK5xBj1diKZ31kF5t3+F374RFKBKcjz+9MpIBMmCHh69NbngQd8Ke1pvDRdzzWgXv
         F0KS3haP590kzZIj3nv5SSRGl3zVqAuD1ixRdtACjv1iEYv3/TiE9QmSdD+uOGKVJ2pl
         covpXS1ANi8CS3R9dbzdOtREFeMbzGcoS5ijJXsm48Syc9Q6oiWaJujTCbRcq9n7H9LZ
         B44IX/6JaUajZmJjr+DyseqyoUTYq9p5L0aBXOkWOw1bH0FgQfr073X7c54lGbgpgmf3
         FTBg==
X-Gm-Message-State: AOAM530oEYRcK56JB0IxGIBZzYo2e8EX12v9f2wnJzbQHq6hOQZRhp+r
        0PEI51cxQgkj6EHRJyHYaN8=
X-Google-Smtp-Source: ABdhPJzjCT4vjcl+lkSt/Wi/Vn1pYsK94iWAL5HN1AB4bgaVqT7HiDVpBfZYZ0h9PQLWoMo+SMTjcg==
X-Received: by 2002:a1c:9e51:: with SMTP id h78mr2461655wme.177.1589525808157;
        Thu, 14 May 2020 23:56:48 -0700 (PDT)
Received: from localhost (ip-37-188-249-36.eurotel.cz. [37.188.249.36])
        by smtp.gmail.com with ESMTPSA id x6sm2050690wrv.57.2020.05.14.23.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 23:56:47 -0700 (PDT)
Date:   Fri, 15 May 2020 08:56:45 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Zefan Li <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Cgroups <cgroups@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>
Subject: Re: [PATCH v2] memcg: Fix memcg_kmem_bypass() for remote memcg
 charging
Message-ID: <20200515065645.GD29153@dhcp22.suse.cz>
References: <e6927a82-949c-bdfd-d717-0a14743c6759@huawei.com>
 <20200513090502.GV29153@dhcp22.suse.cz>
 <76f71776-d049-7407-8574-86b6e9d80704@huawei.com>
 <20200513112905.GX29153@dhcp22.suse.cz>
 <3a721f62-5a66-8bc5-247b-5c8b7c51c555@huawei.com>
 <20200513161110.GA70427@carbon.DHCP.thefacebook.com>
 <20e89344-cf00-8b0c-64c3-0ac7efd601e6@huawei.com>
 <20200514225259.GA81563@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514225259.GA81563@carbon.dhcp.thefacebook.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 14-05-20 15:52:59, Roman Gushchin wrote:
> On Thu, May 14, 2020 at 09:16:29AM +0800, Zefan Li wrote:
> > On 2020/5/14 0:11, Roman Gushchin wrote:
> > > On Wed, May 13, 2020 at 07:47:49PM +0800, Zefan Li wrote:
> > >> While trying to use remote memcg charging in an out-of-tree kernel module
> > >> I found it's not working, because the current thread is a workqueue thread.
> > >>
> > >> As we will probably encounter this issue in the future as the users of
> > >> memalloc_use_memcg() grow, it's better we fix it now.
> > >>
> > >> Signed-off-by: Zefan Li <lizefan@huawei.com>
> > >> ---
> > >>
> > >> v2: add a comment as sugguested by Michal. and add changelog to explain why
> > >> upstream kernel needs this fix.
> > >>
> > >> ---
> > >>
> > >>  mm/memcontrol.c | 3 +++
> > >>  1 file changed, 3 insertions(+)
> > >>
> > >> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > >> index a3b97f1..43a12ed 100644
> > >> --- a/mm/memcontrol.c
> > >> +++ b/mm/memcontrol.c
> > >> @@ -2802,6 +2802,9 @@ static void memcg_schedule_kmem_cache_create(struct mem_cgroup *memcg,
> > >>  
> > >>  static inline bool memcg_kmem_bypass(void)
> > >>  {
> > >> +	/* Allow remote memcg charging in kthread contexts. */
> > >> +	if (unlikely(current->active_memcg))
> > >> +		return false;
> > >>  	if (in_interrupt() || !current->mm || (current->flags & PF_KTHREAD))
> > >>  		return true;
> > > 
> > > Shakeel is right about interrupts. How about something like this?
> > > 
> > > static inline bool memcg_kmem_bypass(void)
> > > {
> > > 	if (in_interrupt())
> > > 		return true;
> > > 
> > > 	if ((!current->mm || current->flags & PF_KTHREAD) && !current->active_memcg)
> > > 		return true;
> > > 
> > > 	return false;
> > > }
> > > 
> > 
> > I thought the user should ensure not do this, but now I think it makes sense to just bypass
> > the interrupt case.
> 
> I think now it's mostly a legacy of the opt-out kernel memory accounting.
> Actually we can relax this requirement by forcibly overcommit the memory cgroup
> if the allocation is happening from the irq context, and punish it afterwards.
> Idk how much we wanna this, hopefully nobody is allocating large non-temporarily
> objects from an irq.

I do not think we want to pretend that remote charging from the IRQ
context is supported. Why don't we simply WARN_ON(in_interrupt()) there?

> 
> Will you send a v3?
> 
> Thanks!

-- 
Michal Hocko
SUSE Labs
