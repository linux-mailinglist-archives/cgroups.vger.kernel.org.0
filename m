Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57EBA36128A
	for <lists+cgroups@lfdr.de>; Thu, 15 Apr 2021 20:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234583AbhDOSxn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 15 Apr 2021 14:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234481AbhDOSxm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 15 Apr 2021 14:53:42 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1331FC061756
        for <cgroups@vger.kernel.org>; Thu, 15 Apr 2021 11:53:18 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id i11so6709141qvu.10
        for <cgroups@vger.kernel.org>; Thu, 15 Apr 2021 11:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=96tuU81fXCkin4WB3Y1v64uEdVONNHvsDjpceLw3bM0=;
        b=KucSbo71ppmRAwrtk+zE9FdgB87Qc+tda3KCUaEMRGH1MZkW8VY/3PWwvP2IP4pxau
         FziHIC410OdYUCirJSscKoC+x30M84iaj9fFwF4aQIBMaWpf7Zu1rlM8jArzkSlTXJYg
         v9hKVGygzsc8f2nO+sHjIiFVZADBkBHZyg2L4d9eH2oz7jdgsdctVIKvxYtts3ZAPy6j
         GcDaOUmPffy9jfWGe9Nf+xYXMmIuL99ftu/DtIhGM5qj41NGcEgcMGQ+2FF1btH+3Y9A
         CI6hqs7zAosirfWv49F8TFvyk8deLlV+oIGcFUgxmO7meeRc85l79LRS6BSU6zMn8gP7
         9RlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=96tuU81fXCkin4WB3Y1v64uEdVONNHvsDjpceLw3bM0=;
        b=gkIiFSOdDtHgSnSwUgpSuNd7flJCEwmowQFifXgdXCTk5CGzOJqXoCh5CFW+BNqrT5
         sPc45rUadHxMI+c05axC9cyVSYupMFk3WjIahWp73kjBMNThQtDNBTVMK4ORtaGKQHJq
         9Sk7lkCXnn3F9mW4Q2Z6y9NIiNxzikXwAX6SVw0f2+bQvj9GZHApbeyDy7UCMbx7dImo
         4VxlhHhjs1bk0I7eZ6fA5PUD8dU8COLtzFFW9AwyQODMD7fcpqtNDR1FhC1GeOAqFMFz
         gw+c2qZITT29MrTOce49jjn82HANO3wLCcWlNBy9eAlK8XqVtjZBS869xQIT+dM5NFMN
         8a4w==
X-Gm-Message-State: AOAM531LMbKXMDfCM1EpQGoFgrkWcgQINYex9eOkcaO+cdZaLpaOCnZD
        BKC99uSYsp62DMY0TMQ8ShBpfg==
X-Google-Smtp-Source: ABdhPJw9P8Kpim/vGmjqJwgzAVFTO6UGfsnHmGwxmbB9cfF9fe6Gb8lgaZAMGEoWhGSQ1UF3KctUyw==
X-Received: by 2002:ad4:4c4a:: with SMTP id cs10mr4836974qvb.14.1618512797099;
        Thu, 15 Apr 2021 11:53:17 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id z18sm2638060qkg.42.2021.04.15.11.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 11:53:16 -0700 (PDT)
Date:   Thu, 15 Apr 2021 14:53:15 -0400
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
Subject: Re: [PATCH v3 5/5] mm/memcg: Optimize user context object stock
 access
Message-ID: <YHiLmxE9oCOfmbS3@cmpxchg.org>
References: <20210414012027.5352-1-longman@redhat.com>
 <20210414012027.5352-6-longman@redhat.com>
 <YHh9l1+TUIzzFBtO@cmpxchg.org>
 <8dbd3505-9c51-362f-82d8-5efa5773e020@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8dbd3505-9c51-362f-82d8-5efa5773e020@redhat.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 15, 2021 at 02:16:17PM -0400, Waiman Long wrote:
> On 4/15/21 1:53 PM, Johannes Weiner wrote:
> > On Tue, Apr 13, 2021 at 09:20:27PM -0400, Waiman Long wrote:
> > > Most kmem_cache_alloc() calls are from user context. With instrumentation
> > > enabled, the measured amount of kmem_cache_alloc() calls from non-task
> > > context was about 0.01% of the total.
> > > 
> > > The irq disable/enable sequence used in this case to access content
> > > from object stock is slow.  To optimize for user context access, there
> > > are now two object stocks for task context and interrupt context access
> > > respectively.
> > > 
> > > The task context object stock can be accessed after disabling preemption
> > > which is cheap in non-preempt kernel. The interrupt context object stock
> > > can only be accessed after disabling interrupt. User context code can
> > > access interrupt object stock, but not vice versa.
> > > 
> > > The mod_objcg_state() function is also modified to make sure that memcg
> > > and lruvec stat updates are done with interrupted disabled.
> > > 
> > > The downside of this change is that there are more data stored in local
> > > object stocks and not reflected in the charge counter and the vmstat
> > > arrays.  However, this is a small price to pay for better performance.
> > > 
> > > Signed-off-by: Waiman Long <longman@redhat.com>
> > > Acked-by: Roman Gushchin <guro@fb.com>
> > > Reviewed-by: Shakeel Butt <shakeelb@google.com>
> > This makes sense, and also explains the previous patch a bit
> > better. But please merge those two.
> The reason I broke it into two is so that the patches are individually
> easier to review. I prefer to update the commit log of patch 4 to explain
> why the obj_stock structure is introduced instead of merging the two.

Well I did not find them easier to review separately.

> > > @@ -2327,7 +2365,9 @@ static void drain_local_stock(struct work_struct *dummy)
> > >   	local_irq_save(flags);
> > >   	stock = this_cpu_ptr(&memcg_stock);
> > > -	drain_obj_stock(&stock->obj);
> > > +	drain_obj_stock(&stock->irq_obj);
> > > +	if (in_task())
> > > +		drain_obj_stock(&stock->task_obj);
> > >   	drain_stock(stock);
> > >   	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
> > > @@ -3183,7 +3223,7 @@ static inline void mod_objcg_state(struct obj_cgroup *objcg,
> > >   	memcg = obj_cgroup_memcg(objcg);
> > >   	if (pgdat)
> > >   		lruvec = mem_cgroup_lruvec(memcg, pgdat);
> > > -	__mod_memcg_lruvec_state(memcg, lruvec, idx, nr);
> > > +	mod_memcg_lruvec_state(memcg, lruvec, idx, nr);
> > >   	rcu_read_unlock();
> > This is actually a bug introduced in the earlier patch, isn't it?
> > Calling __mod_memcg_lruvec_state() without irqs disabled...
> > 
> Not really, in patch 3, mod_objcg_state() is called only in the stock update
> context where interrupt had already been disabled. But now, that is no
> longer the case, that is why i need to update mod_objcg_state() to make sure
> irq is disabled before updating vmstat data array.

Oh, I see it now. Man, that's subtle. We've had several very hard to
track down preemption bugs in those stats, because they manifest as
counter imbalances and you have no idea if there is a leak somewhere.

The convention for these functions is that the __ prefix indicates
that preemption has been suitably disabled. Please always follow this
convention, even if the semantic change is temporary.

Btw, is there a reason why the stock caching isn't just part of
mod_objcg_state()? Why does the user need to choose if they want the
caching or not? It's not like we ask for this when charging, either.
