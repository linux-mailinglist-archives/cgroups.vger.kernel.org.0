Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87BDE3611CB
	for <lists+cgroups@lfdr.de>; Thu, 15 Apr 2021 20:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234447AbhDOSOL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 15 Apr 2021 14:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233610AbhDOSOG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 15 Apr 2021 14:14:06 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53B2C061756
        for <cgroups@vger.kernel.org>; Thu, 15 Apr 2021 11:13:40 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id u8so18842297qtq.12
        for <cgroups@vger.kernel.org>; Thu, 15 Apr 2021 11:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EO1ZRnRE5AIix1KmwKUfdGLcr4z4RBOaJpoQ33nEJcU=;
        b=jcmAT3HPYBCrHP6jHCPcphUzr0fG91bIyePgBoblxnUY+uM+e0eGmbicEIUky5JdS0
         3f+T18xTekj77ibaghPcyaYdxNQRjMPbL4Ntyc63OCy/SDczT2i+WSCRxh/sJc/Sb+jL
         zTGvaa45VbkcKTNF0+kZ/awf98n0XtQGdqXy5xnTcX+StcRGfboJyIAFPchfBTtSF5A9
         VROXd7+VJIJA1jLng07E/m4Vx1z4MfGAhl74Z/6Z251sfegah5pmMek7SH5p2gLdC140
         PPSH1qvSRmRMyxmzaa54BMa3AEJO4ukZlCVGoQ8YJmEH+HRKNHBmnXMdiv8fuv7DifI4
         oqvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EO1ZRnRE5AIix1KmwKUfdGLcr4z4RBOaJpoQ33nEJcU=;
        b=S7BAJnIySyRLw1gW3vVSZg/x8YEm31q6/Y/3f8RjpMo7zcy6udNSJ3KWSBPzp3h5gu
         w4SgHztipch/FbgLv+Wvm4Dm3sACA4/sLFb2cEqAdVtsQlPoW69oWAg1Sh6OoaW0+glB
         rsTUVHRsxakYzKJ2UQbLkhA0LmpWH/LqLQASHAWunS5FO6N7yBwVkT8KIthf7ua7FufP
         CbCrS365Kc05KrFBvFw9bZYxt/uizNy63gKvIYRmUWb4k86t2HF6ZlSvBf2b4jmMYu2m
         zveSZ27i4iXBQo69YlddDC/ztF6t/+mi4lnEjIRe8YFFM3LTUzSl8QDyTDCtETBV5SYr
         89VA==
X-Gm-Message-State: AOAM533Af3NZMm/6zRDrUf6bxRRDUdb+AoRTnbEf6LWcZQF2Ia+ufqmf
        D26KuR4gv5b01iXx7UYwU2a0tQ==
X-Google-Smtp-Source: ABdhPJwZeV1EKidTKUJjnDui70hmgN5zSMh0mrr3zrj2n5DFwYlqRj8w5iOpw/kIBIcCxxRbU4cpSA==
X-Received: by 2002:a05:622a:3c8:: with SMTP id k8mr4248564qtx.101.1618510419998;
        Thu, 15 Apr 2021 11:13:39 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id 71sm2559708qkm.40.2021.04.15.11.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 11:13:39 -0700 (PDT)
Date:   Thu, 15 Apr 2021 14:13:38 -0400
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
Subject: Re: [PATCH v3 3/5] mm/memcg: Cache vmstat data in percpu
 memcg_stock_pcp
Message-ID: <YHiCUnqaVkIwGzUT@cmpxchg.org>
References: <20210414012027.5352-1-longman@redhat.com>
 <20210414012027.5352-4-longman@redhat.com>
 <YHhu1BOMj1Ip+sb3@cmpxchg.org>
 <5abe499a-b1ad-fa22-3487-1a6e00e30e17@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5abe499a-b1ad-fa22-3487-1a6e00e30e17@redhat.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 15, 2021 at 01:08:29PM -0400, Waiman Long wrote:
> On 4/15/21 12:50 PM, Johannes Weiner wrote:
> > On Tue, Apr 13, 2021 at 09:20:25PM -0400, Waiman Long wrote:
> > > Before the new slab memory controller with per object byte charging,
> > > charging and vmstat data update happen only when new slab pages are
> > > allocated or freed. Now they are done with every kmem_cache_alloc()
> > > and kmem_cache_free(). This causes additional overhead for workloads
> > > that generate a lot of alloc and free calls.
> > > 
> > > The memcg_stock_pcp is used to cache byte charge for a specific
> > > obj_cgroup to reduce that overhead. To further reducing it, this patch
> > > makes the vmstat data cached in the memcg_stock_pcp structure as well
> > > until it accumulates a page size worth of update or when other cached
> > > data change.
> > > 
> > > On a 2-socket Cascade Lake server with instrumentation enabled and this
> > > patch applied, it was found that about 17% (946796 out of 5515184) of the
> > > time when __mod_obj_stock_state() is called leads to an actual call to
> > > mod_objcg_state() after initial boot. When doing parallel kernel build,
> > > the figure was about 16% (21894614 out of 139780628). So caching the
> > > vmstat data reduces the number of calls to mod_objcg_state() by more
> > > than 80%.
> > Right, but mod_objcg_state() is itself already percpu-cached. What's
> > the benefit of avoiding calls to it with another percpu cache?
> > 
> There are actually 2 set of vmstat data that have to be updated. One is
> associated with the memcg and other one is for each lruvec within the
> cgroup. Caching it in obj_stock, we replace 2 writes to two colder
> cachelines with one write to a hot cacheline. If you look at patch 5, I
> break obj_stock into two - one for task context and one for irq context.
> Interrupt disable is no longer needed in task context, but that is not
> possible when writing to the actual vmstat data arrays.

Ah, thanks for the explanation. Both of these points are worth
mentioning in the changelog of this patch.
