Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE339362468
	for <lists+cgroups@lfdr.de>; Fri, 16 Apr 2021 17:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235045AbhDPPsl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 16 Apr 2021 11:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235183AbhDPPsk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 16 Apr 2021 11:48:40 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068F3C061756
        for <cgroups@vger.kernel.org>; Fri, 16 Apr 2021 08:48:16 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id 18so12424852qkl.3
        for <cgroups@vger.kernel.org>; Fri, 16 Apr 2021 08:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jEiyTnsJBz+3LM/AEUTcCopsniGZUGJiJXoqEYpAchc=;
        b=GsMQU312d3+bjYcyvWaGgihp/toAeub1wsouXLWaXNwHYTQaB7LwP4IBLj9mu2lQLa
         8h8x0rgNlRDCog9rTth+hGVzB34zfq9Hn3qbM0yWNpIEM+M4VgKrqe3l4Muu07uoa450
         Pn4cQBsp2krJTlXaDZUKJfDdrEsDatYx/bikcvg3T99IY65JF9VI2D9rfDuL/hSo/kpH
         179UmXP0GzkfbtHB8zlDMj+pyZUnUxNL5Y3alLTVYdvXhGgYCirxlTJNb5x0VUwDDlKA
         7A4xLUEhJ4m5eLGA0Fe9TfGq4nMexHI/lTIoYQjFJctKJWRPCGh0kF0Kg7Yl5t5wxF40
         681g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jEiyTnsJBz+3LM/AEUTcCopsniGZUGJiJXoqEYpAchc=;
        b=Zew6INHI5rCVV8sxin3jBOhG+JrT1FkGo/JTYjdQI3gSSu6O6HtycURKoh4SAvlmem
         cDo36h+feVjrJUxgc7MulfOfiZ04ypekru9gTvqxE+R/AYUVUKBmCgFXvQfeIPnjss5k
         xCfeODko9EBOBl5l2dyVm6xhae0Xq7yYR9e3PlijJvwGcabbTjKjEtU/ZC43n3Jr3Vvi
         8jPjg48nTjmBTEyLhzhtQPuMQmJtHa5ms8cCAfcUXTeh9bdjZe9NRko8YRYm5as8MkIB
         SS1/EaC/66RyABIWdwR31z8ijA6FvtbffcbnFjU8KXr2rRQ8eSJGUZVOF7MCJKx6NXrg
         /LHA==
X-Gm-Message-State: AOAM532wZQo/OvDonDZdCvqwGlXkEtSRWK2YOU7J7Ck+xC15aTMU7xBM
        zHpFCpjUy3NkhrgbSQXIwaFuRg==
X-Google-Smtp-Source: ABdhPJx8OHfpY+zeHutioHIMaFCsw6/lrznUI43UQbq4vAQuxuNUNahlfp72uTPIFNmy8blO6S7sZw==
X-Received: by 2002:a37:6f87:: with SMTP id k129mr9461373qkc.470.1618588095311;
        Fri, 16 Apr 2021 08:48:15 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id 26sm4153612qtd.73.2021.04.16.08.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 08:48:14 -0700 (PDT)
Date:   Fri, 16 Apr 2021 11:48:14 -0400
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
Subject: Re: [PATCH v3 1/5] mm/memcg: Pass both memcg and lruvec to
 mod_memcg_lruvec_state()
Message-ID: <YHmxvlkBBlUUYKPG@cmpxchg.org>
References: <20210414012027.5352-1-longman@redhat.com>
 <20210414012027.5352-2-longman@redhat.com>
 <YHhsapGx3vTlyZvF@cmpxchg.org>
 <59a85df9-3e77-1d43-8673-2ff50a741130@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59a85df9-3e77-1d43-8673-2ff50a741130@redhat.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 15, 2021 at 12:59:21PM -0400, Waiman Long wrote:
> On 4/15/21 12:40 PM, Johannes Weiner wrote:
> > On Tue, Apr 13, 2021 at 09:20:23PM -0400, Waiman Long wrote:
> > > The caller of mod_memcg_lruvec_state() has both memcg and lruvec readily
> > > available. So both of them are now passed to mod_memcg_lruvec_state()
> > > and __mod_memcg_lruvec_state(). The __mod_memcg_lruvec_state() is
> > > updated to allow either of the two parameters to be set to null. This
> > > makes mod_memcg_lruvec_state() equivalent to mod_memcg_state() if lruvec
> > > is null.
> > > 
> > > The new __mod_memcg_lruvec_state() function will be used in the next
> > > patch as a replacement of mod_memcg_state() in mm/percpu.c for the
> > > consolidation of the memory uncharge and vmstat update functions in
> > > the kmem_cache_free() path.
> > This requires users who want both to pass a pgdat that can be derived
> > from the lruvec. This is error prone, and we just acked a patch that
> > removes this very thing from mem_cgroup_page_lruvec().
> > 
> > With the suggestion for patch 2, this shouldn't be necessary anymore,
> > though. And sort of underlines my point around that combined function
> > creating akwward code above and below it.
> > 
> The reason of passing in the pgdat is because of the caching of vmstat data.
> lruvec may be gone if the corresponding memory cgroup is removed, but pgdat
> should stay put. That is why I put pgdat in the obj_stock for caching. I
> could also put the node id instead of pgdat.

Internally storing the pgdat is fine.

I was talking about the interface requiring the user to pass redundant
information (pgdat, can be derived from lruvec) because the parameter
is overloaded to modify the function's behavior, which is unintuitive.
