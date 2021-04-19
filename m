Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D366E3648DE
	for <lists+cgroups@lfdr.de>; Mon, 19 Apr 2021 19:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239962AbhDSROQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 19 Apr 2021 13:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239884AbhDSROP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 19 Apr 2021 13:14:15 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90203C06174A
        for <cgroups@vger.kernel.org>; Mon, 19 Apr 2021 10:13:44 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id s5so27753186qkj.5
        for <cgroups@vger.kernel.org>; Mon, 19 Apr 2021 10:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Pte6gDNJh8xhmbfylrLlVHUNlTRi/dJM7p92ChkQdLw=;
        b=MwMmN19pYgiiPxO22E5Bn0qD6lq60MgWWDGEz0TubxyILZCMzhCPfXDVCVEDSTtYDg
         1nfmtoD4j9390fHkbbIVqjJxO8le3005eLFTk4YOGXlpwcUu8NeucgF56hni/Z4/4H96
         hjZPsaC4TB/U1cY+mFAGTYw9VUOfWgIzXBlndKEF1cuIJIKuz+BNR3QbWRJj+VR1vjrQ
         LBm94K2doToMiYJK/LvFAcquSUTPiiWtGJno+re8gnauJslto4r/DCHPKPLMt9DNYGfy
         kOK08NDrLO1kA3L9zeTWIADkRO9VM9Vr32AIuNWKbeIvtecS9RTcBNSfmIcMR3ngEUAx
         F19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Pte6gDNJh8xhmbfylrLlVHUNlTRi/dJM7p92ChkQdLw=;
        b=Hm5QsYcYrZlDxro9o505oWt8YI6gaPuMga4WpCpcpl916+5vFpTGs1UQds6VUkxWek
         SEPqt2cPvFbYy1O8+M2LXgD4dqFFBUH83FVKryVW6JHMj5eZwzsGXKlPGAzfwaE1+YUj
         VdGbTBWM0ZXFYZRcFtt8mYcACSYQAf2zturZSgBP5avjGqp27e4f6G8pnZmh6XiNM9Pz
         xn8wrpdOkURtZ7m3BXjiFN1pllteESlsr3Z27G1y9Oxog8SwmenAZl+FpSMdyl37zEar
         506qdVQYBRs+t8Shz2mZZVPodl1fyimNmCWKohvj2bKkVaqCFPs4j5Y4froqkLg2s6VS
         xOuw==
X-Gm-Message-State: AOAM531Z69fC0h9w4/gPy675df3xIOc0kvUKIjzrKl5pV/7pyg75ysiW
        zoYtPqVZjnSjTqwFzTDJ5mXJTw==
X-Google-Smtp-Source: ABdhPJyi49qEE45YgaeZaLpdT1WgxROrFQlIUehK6VBcvbjRvvvoLxQcgvF0XZzvYnmoC9RRKaw1mQ==
X-Received: by 2002:a37:8bc5:: with SMTP id n188mr12448087qkd.441.1618852423846;
        Mon, 19 Apr 2021 10:13:43 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id i23sm123882qtp.61.2021.04.19.10.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 10:13:43 -0700 (PDT)
Date:   Mon, 19 Apr 2021 13:13:42 -0400
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
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v4 1/5] mm/memcg: Move mod_objcg_state() to memcontrol.c
Message-ID: <YH26RrMBOxLaMg4l@cmpxchg.org>
References: <20210419000032.5432-1-longman@redhat.com>
 <20210419000032.5432-2-longman@redhat.com>
 <YH2eT+JCII48hX80@cmpxchg.org>
 <ffb5705e-8629-808d-9d09-0c9c7f509326@redhat.com>
 <140444ea-14e7-b305-910f-f23fafe45488@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <140444ea-14e7-b305-910f-f23fafe45488@redhat.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Apr 19, 2021 at 12:18:29PM -0400, Waiman Long wrote:
> On 4/19/21 11:21 AM, Waiman Long wrote:
> > On 4/19/21 11:14 AM, Johannes Weiner wrote:
> > > On Sun, Apr 18, 2021 at 08:00:28PM -0400, Waiman Long wrote:
> > > > The mod_objcg_state() function is moved from mm/slab.h to
> > > > mm/memcontrol.c
> > > > so that further optimization can be done to it in later patches without
> > > > exposing unnecessary details to other mm components.
> > > > 
> > > > Signed-off-by: Waiman Long <longman@redhat.com>
> > > > ---
> > > >   mm/memcontrol.c | 13 +++++++++++++
> > > >   mm/slab.h       | 16 ++--------------
> > > >   2 files changed, 15 insertions(+), 14 deletions(-)
> > > > 
> > > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > > index e064ac0d850a..dc9032f28f2e 100644
> > > > --- a/mm/memcontrol.c
> > > > +++ b/mm/memcontrol.c
> > > > @@ -3150,6 +3150,19 @@ void __memcg_kmem_uncharge_page(struct
> > > > page *page, int order)
> > > >       css_put(&memcg->css);
> > > >   }
> > > >   +void mod_objcg_state(struct obj_cgroup *objcg, struct
> > > > pglist_data *pgdat,
> > > > +             enum node_stat_item idx, int nr)
> > > > +{
> > > > +    struct mem_cgroup *memcg;
> > > > +    struct lruvec *lruvec = NULL;
> > > > +
> > > > +    rcu_read_lock();
> > > > +    memcg = obj_cgroup_memcg(objcg);
> > > > +    lruvec = mem_cgroup_lruvec(memcg, pgdat);
> > > > +    mod_memcg_lruvec_state(lruvec, idx, nr);
> > > > +    rcu_read_unlock();
> > > > +}
> > > It would be more naturally placed next to the others, e.g. below
> > > __mod_lruvec_kmem_state().
> > > 
> > > But no deal breaker if there isn't another revision.
> > > 
> > > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > > 
> > Yes, there will be another revision by rebasing patch series on the
> > linux-next. I will move the function then.
> 
> OK, it turns out that mod_objcg_state() is only defined if
> CONFIG_MEMCG_KMEM. That was why I put it in the CONFIG_MEMCG_KMEM block with
> the other obj_stock functions. I think I will keep it there.

The CONFIG_MEMCG_KMEM has become sort of useless now. It used to be
configurable, but now it just means CONFIG_MEMCG && !CONFIG_SLOB. And
even that doesn't make sense because while slob doesn't support slab
object tracking, we can still do all the other stuff we do under
KMEM. I have a patch in the works to remove the symbol and ifdefs.

With that in mind, it's better to group the functions based on what
they do rather than based on CONFIG_MEMCG_KMEM. It's easier to just
remove another ifdef later than it is to reorder the functions.
