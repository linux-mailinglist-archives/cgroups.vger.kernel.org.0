Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC16361302
	for <lists+cgroups@lfdr.de>; Thu, 15 Apr 2021 21:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234659AbhDOTkh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 15 Apr 2021 15:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234506AbhDOTkg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 15 Apr 2021 15:40:36 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E800C061756
        for <cgroups@vger.kernel.org>; Thu, 15 Apr 2021 12:40:12 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id j3so12304168qvs.1
        for <cgroups@vger.kernel.org>; Thu, 15 Apr 2021 12:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ysi6RRTEAiRn+Yy07GZnMkjfObnhYqIw2YgVv+JxE44=;
        b=b2A9c+lKNHFTx5ujWSTaeS9zFMdER+ifE7Xz5osy5K6xiMiaNTgWAyMly/+6qpp5tr
         yRDuZ5mJe1PTVPp/InRtMLkJ2BKi3Xrj/3nluHM7i/iDx0Z/WAVtnMtXAhool/Zs4r7m
         MUxwDVravbfwueke0nUfYYeStLFeTvTViS1GxMog6kDrxc/NFZFZzZ4kgx5klve3OqdD
         HLxq6x2jHTz9MI5/1MxdV9MrSJD1djMSnf/MVVy0BF66/E70xCrsL6bmt8FAkFKHifSw
         /0xvlNjX1zlQ8+imEOXDURfi+m9K0n7A8o9OsU4NvY8QWkqZWIg9TZz3/AtU2wj1nmIs
         glTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ysi6RRTEAiRn+Yy07GZnMkjfObnhYqIw2YgVv+JxE44=;
        b=e18RCC9Atc/O8BBdEYgyuZsUBRvXbrJ+oqg057IYfbZQbmtdZWOZktSdFeKnL0mAzf
         ZjcfcLa4dyxxuRmLcv0def/KDJQ39ebsziPdPULwGiBhlOt+haDaZQP0xb2O2abSYGSl
         zXqvGABkZpVCovfarpBVZM+Hv9Zp3zmI8LyapJz+QjzUG1Abf8MMWSLLhPollf53iws1
         bjZljDVwUTo0Mp+WYHMQr75js8lrWqAK5nA8zOJ9VdsKrBUTc+bWXFf0ufmVg931Vf39
         NHrLtuqSScP9kD/FEpZVWffGHmqKV+oVqSekEMkuugpOB59MoP+WjT9gPnTbqeiyG/pV
         NfIw==
X-Gm-Message-State: AOAM533Ob/MeELmKPb1KbSos/GltuNGpOGtYCHNBDf/KrMmhuaapZYMA
        SAPDTpayAaOyNQDVw+QFL8MVqw==
X-Google-Smtp-Source: ABdhPJyuYjLPcmUlKK6SIRy68Qi0woumXcj2z/Cl1pUb56vpFCK/iZjog2Ajb5zWSOa3zOfXnn/u8w==
X-Received: by 2002:a0c:c488:: with SMTP id u8mr4868194qvi.47.1618515611398;
        Thu, 15 Apr 2021 12:40:11 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id f17sm2529353qtp.39.2021.04.15.12.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 12:40:10 -0700 (PDT)
Date:   Thu, 15 Apr 2021 15:40:10 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Waiman Long <llong@redhat.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Subject: Re: [PATCH v3 2/5] mm/memcg: Introduce
 obj_cgroup_uncharge_mod_state()
Message-ID: <YHiWmsQVQPGSm2El@cmpxchg.org>
References: <20210414012027.5352-1-longman@redhat.com>
 <20210414012027.5352-3-longman@redhat.com>
 <YHhqPYcajI9JgXk/@cmpxchg.org>
 <1c85e8f6-e8b9-33e1-e29b-81fbadff959f@redhat.com>
 <YHiBlhUWoCKqQgM7@cmpxchg.org>
 <8a104fd5-64c7-3f41-981c-9cfa977c78a6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a104fd5-64c7-3f41-981c-9cfa977c78a6@redhat.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 15, 2021 at 02:47:31PM -0400, Waiman Long wrote:
> On 4/15/21 2:10 PM, Johannes Weiner wrote:
> > On Thu, Apr 15, 2021 at 12:35:45PM -0400, Waiman Long wrote:
> > > On 4/15/21 12:30 PM, Johannes Weiner wrote:
> > > > On Tue, Apr 13, 2021 at 09:20:24PM -0400, Waiman Long wrote:
> > > > > In memcg_slab_free_hook()/pcpu_memcg_free_hook(), obj_cgroup_uncharge()
> > > > > is followed by mod_objcg_state()/mod_memcg_state(). Each of these
> > > > > function call goes through a separate irq_save/irq_restore cycle. That
> > > > > is inefficient.  Introduce a new function obj_cgroup_uncharge_mod_state()
> > > > > that combines them with a single irq_save/irq_restore cycle.
> > > > > 
> > > > > @@ -3292,6 +3296,25 @@ void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size)
> > > > >    	refill_obj_stock(objcg, size);
> > > > >    }
> > > > > +void obj_cgroup_uncharge_mod_state(struct obj_cgroup *objcg, size_t size,
> > > > > +				   struct pglist_data *pgdat, int idx)
> > > > The optimization makes sense.
> > > > 
> > > > But please don't combine independent operations like this into a
> > > > single function. It makes for an unclear parameter list, it's a pain
> > > > in the behind to change the constituent operations later on, and it
> > > > has a habit of attracting more random bools over time. E.g. what if
> > > > the caller already has irqs disabled? What if it KNOWS that irqs are
> > > > enabled and it could use local_irq_disable() instead of save?
> > > > 
> > > > Just provide an __obj_cgroup_uncharge() that assumes irqs are
> > > > disabled, combine with the existing __mod_memcg_lruvec_state(), and
> > > > bubble the irq handling up to those callsites which know better.
> > > > 
> > > That will also work. However, the reason I did that was because of patch 5
> > > in the series. I could put the get_obj_stock() and put_obj_stock() code in
> > > slab.h and allowed them to be used directly in various places, but hiding in
> > > one function is easier.
> > Yeah it's more obvious after getting to patch 5.
> > 
> > But with the irq disabling gone entirely, is there still an incentive
> > to combine the atomic section at all? Disabling preemption is pretty
> > cheap, so it wouldn't matter to just do it twice.
> > 
> > I.e. couldn't the final sequence in slab code simply be
> > 
> > 	objcg_uncharge()
> > 	mod_objcg_state()
> > 
> > again and each function disables preemption (and in the rare case
> > irqs) as it sees fit?
> > 
> > You lose the irqsoff batching in the cold path, but as you say, hit
> > rates are pretty good, and it doesn't seem worth complicating the code
> > for the cold path.
> > 
> That does make sense, though a little bit of performance may be lost. I will
> try that out to see how it work out performance wise.

Thanks.

Even if we still end up doing it, it's great to have that cost
isolated, so we know how much extra code complexity corresponds to how
much performance gain. It seems the task/irq split could otherwise be
a pretty localized change with no API implications.
