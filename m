Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E37B31E0DA
	for <lists+cgroups@lfdr.de>; Wed, 17 Feb 2021 21:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbhBQUxu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 17 Feb 2021 15:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbhBQUxm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 17 Feb 2021 15:53:42 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2014C061574
        for <cgroups@vger.kernel.org>; Wed, 17 Feb 2021 12:53:01 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id c25so6967591qvb.4
        for <cgroups@vger.kernel.org>; Wed, 17 Feb 2021 12:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/nI5rj9bvE6w+kmHwM58CvDkIfatHnQ+1wEcvE6t0qM=;
        b=LRegk7bSkLpAy9xvp3N/hncxZhzP8Xrlr1UaRRu2N5qWlQWPo52bjTvGA8VIv4kbEF
         lShAhk2O99mAa5clhSXPVAdxFkq1AKCbtlnxLGkUORLjGHudJIhkQeT0LGFRVqc5czce
         olwaIu6YmleDNMi6Guf87kfg0jryOdIC22S8AdK8aVVunaMZgAICA1OTr0M2XS8qZzcJ
         HJ/Ene0AyDh2JrCED8TVxmid8NiihzpDXbpRyzZXTsibJGK4tUGn/lpepfII6xFrarI0
         OrxhWiNJ0YIv4ARellkRePr3xqNExRIieZ/h2vVX/HYHYfLPkwImW+FqC2dlsRHhIy7W
         UcUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/nI5rj9bvE6w+kmHwM58CvDkIfatHnQ+1wEcvE6t0qM=;
        b=eikivqo7YKCoaGbJdHMiKB+4AkHar1EMH2+QQBfFq28V2EF6E2TfD3X5kYfic+TEy3
         pM4/pkZM3kOgG12cpPTRC1l0WwR8KGzAaRGCbRW6XdQuQVLN8N8DJSCjD3vo+rwblXm0
         GWx7zpX5RMJJZF/PjLLesyP8lUHlLbKOI3/fFZhzZe3iImK26dDhqfJCu7MzWbVEPWuv
         /5CEuoGfIgJ2Mzft783bqnZCnNLTJcHpz2JNYl1yQrmN74LAnW+x82FjwsGwYlCXxofI
         JqedmfZ5d9Or1IWMTf+ZCpYF5tVrx3Uzu7TAnkL0qy/XfLKSj1E/qteIgjUgR7UOw8Ml
         hPuA==
X-Gm-Message-State: AOAM533o1UT3Qw6Azt5y+UdmPgUq08Y9d3TJcLQmeeaIJfmDBPZlkkhB
        z1YTbqMRv24ZtQpvOgQ5751LHw==
X-Google-Smtp-Source: ABdhPJyHeJThS2CGZr+cqb3k6241+1z9NseEWmeB1Bv/4KPcEilqB4W9QFeL5x2OlasWZh2soeTT9Q==
X-Received: by 2002:a0c:c345:: with SMTP id j5mr957810qvi.13.1613595181073;
        Wed, 17 Feb 2021 12:53:01 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id n82sm2478957qkn.114.2021.02.17.12.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 12:53:00 -0800 (PST)
Date:   Wed, 17 Feb 2021 15:52:59 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v3 4/8] cgroup: rstat: support cgroup1
Message-ID: <YC2CKyaeF2bqvpMk@cmpxchg.org>
References: <20210209163304.77088-1-hannes@cmpxchg.org>
 <20210209163304.77088-5-hannes@cmpxchg.org>
 <20210217174232.GA19239@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210217174232.GA19239@blackbody.suse.cz>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Feb 17, 2021 at 06:42:32PM +0100, Michal Koutný wrote:
> Hello.
> 
> On Tue, Feb 09, 2021 at 11:33:00AM -0500, Johannes Weiner <hannes@cmpxchg.org> wrote:
> > @@ -1971,10 +1978,14 @@ int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask)
> >  	if (ret)
> >  		goto destroy_root;
> >  
> > -	ret = rebind_subsystems(root, ss_mask);
> > +	ret = cgroup_rstat_init(root_cgrp);
> Would it make sense to do cgroup_rstat_init() only if there's a subsys
> in ss_mask that makes use of rstat?
> (On legacy systems there could be individual hierarchy for each
> controller so the rstat space can be saved.)

It's possible, but I don't think worth the trouble.

It would have to be done from rebind_subsystems(), as remount can add
more subsystems to an existing cgroup1 root. That in turn means we'd
have to have separate init paths for cgroup1 and cgroup2.

While we split cgroup1 and cgroup2 paths where necessary in the code,
it's a significant maintenance burden and a not unlikely source of
subtle errors (see the recent 'fix swap undercounting in cgroup2').

In this case, we're talking about a relatively small data structure
and the overhead is per mountpoint. Comparatively, we're allocating
the full vmstats structures for cgroup1 groups which barely use them,
and cgroup1 softlimit tree structures for each cgroup2 group.

So I don't think it's a good tradeoff. Subtle bugs that require kernel
patches are more disruptive to the user experience than the amount of
memory in question here.

> > @@ -285,8 +285,6 @@ void __init cgroup_rstat_boot(void)
> >  
> >  	for_each_possible_cpu(cpu)
> >  		raw_spin_lock_init(per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu));
> > -
> > -	BUG_ON(cgroup_rstat_init(&cgrp_dfl_root.cgrp));
> >  }
> Regardless of the suggestion above, this removal obsoletes the comment
> cgroup_rstat_init:
> 
>          int cpu;
>  
> -        /* the root cgrp has rstat_cpu preallocated */
>          if (!cgrp->rstat_cpu) {
>                  cgrp->rstat_cpu = alloc_percpu(struct cgroup_rstat_cpu);

Oh, I'm not removing the init call, I'm merely moving it from
cgroup_rstat_boot() to cgroup_setup_root().

The default root group has statically preallocated percpu data before
and after this patch. See cgroup.c:

  static DEFINE_PER_CPU(struct cgroup_rstat_cpu, cgrp_dfl_root_rstat_cpu);

  /* the default hierarchy */
  struct cgroup_root cgrp_dfl_root = { .cgrp.rstat_cpu = &cgrp_dfl_root_rstat_cpu };
  EXPORT_SYMBOL_GPL(cgrp_dfl_root);
