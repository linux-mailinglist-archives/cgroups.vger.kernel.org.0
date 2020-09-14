Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B73AB2697B4
	for <lists+cgroups@lfdr.de>; Mon, 14 Sep 2020 23:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725986AbgINVaa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Sep 2020 17:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgINVa2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Sep 2020 17:30:28 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98EDC06174A
        for <cgroups@vger.kernel.org>; Mon, 14 Sep 2020 14:30:27 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id g72so1931529qke.8
        for <cgroups@vger.kernel.org>; Mon, 14 Sep 2020 14:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=yrT8gC4TTWet6cZ9YwSESn7cnuC6utKAOdmSGQgzcPU=;
        b=W3aKslhundhu3B/Fi871b2e1Fj2OCJtvs3SQyw2QoDeAfHiT1b1gbC21cgtxcN50dv
         Cl4JMtBfvUJmy9RKwjSs56Q31TGv1HgO7nxpzUNGD2+pg4uDX6AE4R5Ma8mwZ3Erc/YK
         lW+50k3WsMh8OoaNKn4SxKilIjiwgWYIclfyPq2DbbLw6Xei5uUMHF4p0ObonXrxcZhT
         TmmRrdD/VsUAEtTbbTdj4+IQ0mvQ2mXthq0yJpFmfnrEohvPyxMISwsI7I1wjKJQ1F6Z
         ERw5AsyT/pD/oIHNusD7gJKQH56XMtLUL5i7yaHDmTZx8Se9E5lzKJn9MmkGYrnKmxGU
         6FZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yrT8gC4TTWet6cZ9YwSESn7cnuC6utKAOdmSGQgzcPU=;
        b=FwtHKJWf495Zbr/rfsEGNbCQlU9n2dZiMItzEGSx/YPWswAfD77dEXIogMDryxWG6E
         yG70YomxGe0kqicH7KPBOWLSN5hSkoi8h2JmFfyb9uPsdyWYj2aE00OhIg+/0IVzEICK
         VMSq9gpey5fhSIdmUJEMWyGArQv0/hD2KgvW3OZd5Qdr/6h9MwWpmva5ehbiwhNBuvei
         fnsXRUUb6gm//ZQgBb/viLrtMSaqDStV26pqUl7kRB/3L6lcva1caP2hRFCGjvPb1wIB
         DTalwguCVMu9YwSDjJMJTByr+bhdH3Rfq+A0VTdfSALU/ye783hsZm7xzZ9tH9FvGTMs
         s2zQ==
X-Gm-Message-State: AOAM533wEMzIYnJAgLw1soBjsHrUqkvxhYlIjUbKk/GErYrJC+I2mGha
        X5kSLOLePFTrYfaoW50X1GMY7w==
X-Google-Smtp-Source: ABdhPJwMuP07J26GGphmCo+u7UAeSFqN5H7Ty4LWtqDD81qpUgIvxOKrdjMXQKWssUo+sQzJki5LYA==
X-Received: by 2002:a37:a84a:: with SMTP id r71mr14209038qke.481.1600119026836;
        Mon, 14 Sep 2020 14:30:26 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:3700])
        by smtp.gmail.com with ESMTPSA id z74sm15698299qkb.11.2020.09.14.14.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 14:30:26 -0700 (PDT)
Date:   Mon, 14 Sep 2020 17:29:04 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Roman Gushchin <guro@fb.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH v2 2/3] mm/memcg: Simplify mem_cgroup_get_max()
Message-ID: <20200914212904.GB175618@cmpxchg.org>
References: <20200914024452.19167-1-longman@redhat.com>
 <20200914024452.19167-3-longman@redhat.com>
 <20200914114825.GM16999@dhcp22.suse.cz>
 <e8ddc443-b56a-1dd6-6d41-ad217e9aea80@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e8ddc443-b56a-1dd6-6d41-ad217e9aea80@redhat.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Sep 14, 2020 at 09:51:26AM -0400, Waiman Long wrote:
> On 9/14/20 7:48 AM, Michal Hocko wrote:
> > On Sun 13-09-20 22:44:51, Waiman Long wrote:
> > > The mem_cgroup_get_max() function used to get memory+swap max from
> > > both the v1 memsw and v2 memory+swap page counters & return the maximum
> > > of these 2 values. This is redundant and it is more efficient to just
> > > get either the v1 or the v2 values depending on which one is currently
> > > in use.
> > > 
> > > Signed-off-by: Waiman Long <longman@redhat.com>
> > > ---
> > >   mm/memcontrol.c | 20 +++++++++-----------
> > >   1 file changed, 9 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index 8c74f1200261..ca36bed588d1 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -1633,17 +1633,15 @@ void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
> > >    */
> > >   unsigned long mem_cgroup_get_max(struct mem_cgroup *memcg)
> > >   {
> > > -	unsigned long max;
> > > -
> > > -	max = READ_ONCE(memcg->memory.max);
> > > -	if (mem_cgroup_swappiness(memcg)) {
> > > -		unsigned long memsw_max;
> > > -		unsigned long swap_max;
> > > -
> > > -		memsw_max = memcg->memsw.max;
> > > -		swap_max = READ_ONCE(memcg->swap.max);
> > > -		swap_max = min(swap_max, (unsigned long)total_swap_pages);
> > > -		max = min(max + swap_max, memsw_max);
> > > +	unsigned long max = READ_ONCE(memcg->memory.max);
> > > +
> > > +	if (cgroup_subsys_on_dfl(memory_cgrp_subsys)) {
> > > +		if (mem_cgroup_swappiness(memcg))
> > > +			max += min(READ_ONCE(memcg->swap.max),
> > > +				   (unsigned long)total_swap_pages);
> > > +	} else { /* v1 */
> > > +		if (mem_cgroup_swappiness(memcg))
> > > +			max = memcg->memsw.max;
> > I agree that making v1 vs. v2 distinction here makes the code more
> > obvious. But I do not think your code is correct for v1. In a default
> > state it would lead to max = PAGE_COUNTER_MAX which is not something
> > we want, right?
> > 
> > instead you want
> > 		max += min(READ_ONCE(memcg->memsw.max), total_swap_pages);
> > 
> You are right, it is a bit tricky for v1.
> 
> I will change it to
> 
>     max += min(READ_ONCE(memcg->memsw.max) - max, total_swap_pages):

memsw.max can be smaller than max.

max = min3(max, READ_ONCE(memcg->memsw.max), total_swap_pages)?
