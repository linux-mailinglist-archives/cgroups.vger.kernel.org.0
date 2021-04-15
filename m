Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D90EE3611C1
	for <lists+cgroups@lfdr.de>; Thu, 15 Apr 2021 20:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbhDOSK4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 15 Apr 2021 14:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233595AbhDOSK4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 15 Apr 2021 14:10:56 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCCAC061756
        for <cgroups@vger.kernel.org>; Thu, 15 Apr 2021 11:10:32 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id i6so9264863qti.10
        for <cgroups@vger.kernel.org>; Thu, 15 Apr 2021 11:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0BLFn8+sPdB8VIxTPCUa0jMJG0oUhmRim/8smTI9xvY=;
        b=tGeopoVpJDMNEO8IkqF3ObY96XlRxdzEQbmT9ebDYCAN4ET4ZXVB5BRc1gdegOLnak
         R8ziD48IV5FhyKUzjU/965vBnK3955PsmO/8G6vqpc6FGij3sKbVDMJ0k15g75yhqXwv
         Obm+pY4Y+EGZNhKxOR/m//LoLYgQb/8andXi1lEzejlWt68oznT+oVYvFzgAFGADEsvO
         D/oUUST0NO20OhtluWsk4eLbpqrQ9NiAfrHk5abtOTRRxlcNByjSosE1MWQfOpXAZY46
         AWkz6NuwLa7NgR4h667WlfYY7biLEF+jWhwCyrOSthB7+/SIix5qEZZdP6NsirMSVje6
         oAig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0BLFn8+sPdB8VIxTPCUa0jMJG0oUhmRim/8smTI9xvY=;
        b=TPO+Qlnkko4WjamaTykMtAV8QqPGEr9y06eM9ASzg2x1gYgskdDXKEUS515Kf8BRlT
         /MSVsGranQ8CcasJz7XFBE2Gkr4kv/6sbuiS/LDKL430ySgAkgc7JGNzn5fcmn9vBqkt
         ri0E8xiQjfQelc3lu6t3rqIEqkvR3cX4f5vqjgWk6XXOhMrpm/R7DFv9rFs4sI25N14V
         moc/M5tRDXEqiFgKQ4UaSOpVuXaHK7uEvOLAFlm++Q5dxtYlf5WX1t5m+2vnoerDA0v/
         tPMhAi82Cuyv4vqH9NjGaPP/+tbqSrbw//XuDh3B9Me8UxBTd0TpY4oWwvULuaennXAL
         IqiQ==
X-Gm-Message-State: AOAM531Lj3+EaObcOiyJs4WBOjfsoXlqNyVDmGJh+XsoaAGHImtBc1qg
        6mxZvay/lqzf2KYyg21lVY+67w==
X-Google-Smtp-Source: ABdhPJw6PHuhjW/tD1vcjOhY1V1iCeSWzEI3KrO9oZ5Knuwf7DACMiVKlt/E/e57U6gUYzF+4Ftuxw==
X-Received: by 2002:ac8:4b7b:: with SMTP id g27mr4048708qts.220.1618510232013;
        Thu, 15 Apr 2021 11:10:32 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id 23sm850142qkk.51.2021.04.15.11.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 11:10:31 -0700 (PDT)
Date:   Thu, 15 Apr 2021 14:10:30 -0400
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
Message-ID: <YHiBlhUWoCKqQgM7@cmpxchg.org>
References: <20210414012027.5352-1-longman@redhat.com>
 <20210414012027.5352-3-longman@redhat.com>
 <YHhqPYcajI9JgXk/@cmpxchg.org>
 <1c85e8f6-e8b9-33e1-e29b-81fbadff959f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c85e8f6-e8b9-33e1-e29b-81fbadff959f@redhat.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 15, 2021 at 12:35:45PM -0400, Waiman Long wrote:
> On 4/15/21 12:30 PM, Johannes Weiner wrote:
> > On Tue, Apr 13, 2021 at 09:20:24PM -0400, Waiman Long wrote:
> > > In memcg_slab_free_hook()/pcpu_memcg_free_hook(), obj_cgroup_uncharge()
> > > is followed by mod_objcg_state()/mod_memcg_state(). Each of these
> > > function call goes through a separate irq_save/irq_restore cycle. That
> > > is inefficient.  Introduce a new function obj_cgroup_uncharge_mod_state()
> > > that combines them with a single irq_save/irq_restore cycle.
> > > 
> > > @@ -3292,6 +3296,25 @@ void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size)
> > >   	refill_obj_stock(objcg, size);
> > >   }
> > > +void obj_cgroup_uncharge_mod_state(struct obj_cgroup *objcg, size_t size,
> > > +				   struct pglist_data *pgdat, int idx)
> > The optimization makes sense.
> > 
> > But please don't combine independent operations like this into a
> > single function. It makes for an unclear parameter list, it's a pain
> > in the behind to change the constituent operations later on, and it
> > has a habit of attracting more random bools over time. E.g. what if
> > the caller already has irqs disabled? What if it KNOWS that irqs are
> > enabled and it could use local_irq_disable() instead of save?
> > 
> > Just provide an __obj_cgroup_uncharge() that assumes irqs are
> > disabled, combine with the existing __mod_memcg_lruvec_state(), and
> > bubble the irq handling up to those callsites which know better.
> > 
> That will also work. However, the reason I did that was because of patch 5
> in the series. I could put the get_obj_stock() and put_obj_stock() code in
> slab.h and allowed them to be used directly in various places, but hiding in
> one function is easier.

Yeah it's more obvious after getting to patch 5.

But with the irq disabling gone entirely, is there still an incentive
to combine the atomic section at all? Disabling preemption is pretty
cheap, so it wouldn't matter to just do it twice.

I.e. couldn't the final sequence in slab code simply be

	objcg_uncharge()
	mod_objcg_state()

again and each function disables preemption (and in the rare case
irqs) as it sees fit?

You lose the irqsoff batching in the cold path, but as you say, hit
rates are pretty good, and it doesn't seem worth complicating the code
for the cold path.
