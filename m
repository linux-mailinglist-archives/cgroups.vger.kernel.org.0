Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 611EA35A378
	for <lists+cgroups@lfdr.de>; Fri,  9 Apr 2021 18:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbhDIQf4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 9 Apr 2021 12:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbhDIQfz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 9 Apr 2021 12:35:55 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EA3C061760
        for <cgroups@vger.kernel.org>; Fri,  9 Apr 2021 09:35:42 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id z10so6384165qkz.13
        for <cgroups@vger.kernel.org>; Fri, 09 Apr 2021 09:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SwI9dKNHih0HBykn7XRhBQf79N/hp0URWoW1yNfnjE4=;
        b=DE/mc8yNoAgpMpKewHbtPdEY8ARocDvubcZmUOwitmZr2vnXvYJNoi9x3vNJ0pTJWe
         0oGx3cblI3UJjauam8ZAXKSTpIObJZyHY89b61/7T03rsZzzwIYTffYwaOmp9/lPmIZ9
         VZT1tnOyi4MPbfVGPyBTEkqY2MaQ++pvmgfWaPPwtqhdAtZS8ChfTP8evEz+UaQ9zO/d
         lg4FDs5KrB11z3lPP8kwqVhnqAIbqC3YITLJ+OseurBcK4K6y8LQrYNy+EOnZlZc8igQ
         o+YdG2wsh+74lvNKESPo0KkSLQ2dLWYEN3N66USB9cxjniHHlZ3njS1rgZC+FziT3ps1
         1DMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SwI9dKNHih0HBykn7XRhBQf79N/hp0URWoW1yNfnjE4=;
        b=HCCteqIbcC1PEs1cCuT3RNSSXcwdWzDMPHBOy33gaIaUzQFp7TL0/OCA5G0S77Mo1d
         H0mvV6OP6ICYwF2VSnEx1FZdzxD/JI+QVj1Cs934Y3axqHsxggpz+mzvV0JchHk/NG5k
         j3GvavusZZZ/DEhVa2CVb+t6vuU4ikbnmqCAAXbTsFYyVJxjgukavr8L4oAiB87hpgL6
         VVZNrcJsHrXTHp53BhrUwqsqznF3nw7RKytuzOUYS1Rx1Al7cI0rBs7Z2S53rkNKxxWQ
         64qE2iCta5NvQVmQfxPTUQMog4CrUvaYRDqQi9uyXblc99fA6Y7WS3dCkVjKYWAN3P22
         bAqw==
X-Gm-Message-State: AOAM533I7Tfv1jzO4i0r14KGIss24EKv9/t9JGjijA2Ukzz6MtxPT4Gh
        toTR+ghtnmWCmObC3EYGDQ==
X-Google-Smtp-Source: ABdhPJwhzp9QT0Cfo7UnR0Dw5K11HqByuVcvmUKzXHT78fAUlpeit0vsXdbi8IKRzVt1EYZdLDsaRQ==
X-Received: by 2002:ae9:eb57:: with SMTP id b84mr14445736qkg.271.1617986141716;
        Fri, 09 Apr 2021 09:35:41 -0700 (PDT)
Received: from gabell (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id v128sm2095356qkc.127.2021.04.09.09.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 09:35:41 -0700 (PDT)
Date:   Fri, 9 Apr 2021 12:35:39 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Subject: Re: memcg: performance degradation since v5.9
Message-ID: <20210409163539.5374pde3u6gkbg4a@gabell>
References: <20210408193948.vfktg3azh2wrt56t@gabell>
 <YG9tW1h9VSJcir+Y@carbon.dhcp.thefacebook.com>
 <CALvZod58NBQLvk2m7Mb=_0oGCApcNeisxVuE1b+qh1OKDSy0Ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod58NBQLvk2m7Mb=_0oGCApcNeisxVuE1b+qh1OKDSy0Ag@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 08, 2021 at 02:08:13PM -0700, Shakeel Butt wrote:
> On Thu, Apr 8, 2021 at 1:54 PM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Thu, Apr 08, 2021 at 03:39:48PM -0400, Masayoshi Mizuma wrote:
> > > Hello,
> > >
> > > I detected a performance degradation issue for a benchmark of PostgresSQL [1],
> > > and the issue seems to be related to object level memory cgroup [2].
> > > I would appreciate it if you could give me some ideas to solve it.
> > >
> > > The benchmark shows the transaction per second (tps) and the tps for v5.9
> > > and later kernel get about 10%-20% smaller than v5.8.
> > >
> > > The benchmark does sendto() and recvfrom() system calls repeatedly,
> > > and the duration of the system calls get longer than v5.8.
> > > The result of perf trace of the benchmark is as follows:
> > >
> > >   - v5.8
> > >
> > >    syscall            calls  errors  total       min       avg       max       stddev
> > >                                      (msec)    (msec)    (msec)    (msec)        (%)
> > >    --------------- --------  ------ -------- --------- --------- ---------     ------
> > >    sendto            699574      0  2595.220     0.001     0.004     0.462      0.03%
> > >    recvfrom         1391089 694427  2163.458     0.001     0.002     0.442      0.04%
> > >
> > >   - v5.9
> > >
> > >    syscall            calls  errors  total       min       avg       max       stddev
> > >                                      (msec)    (msec)    (msec)    (msec)        (%)
> > >    --------------- --------  ------ -------- --------- --------- ---------     ------
> > >    sendto            699187      0  3316.948     0.002     0.005     0.044      0.02%
> > >    recvfrom         1397042 698828  2464.995     0.001     0.002     0.025      0.04%
> > >
> > >   - v5.12-rc6
> > >
> > >    syscall            calls  errors  total       min       avg       max       stddev
> > >                                      (msec)    (msec)    (msec)    (msec)        (%)
> > >    --------------- --------  ------ -------- --------- --------- ---------     ------
> > >    sendto            699445      0  3015.642     0.002     0.004     0.027      0.02%
> > >    recvfrom         1395929 697909  2338.783     0.001     0.002     0.024      0.03%
> > >
> 
> Can you please explain how to read these numbers? Or at least put a %
> regression.

Let me summarize them here.
The total duration ('total' column above) of each system call is as follows
if v5.8 is assumed as 100%:

- sendto:
  - v5.8         100%
  - v5.9         128%
  - v5.12-rc6    116%

- revfrom:
  - v5.8         100%
  - v5.9         114%
  - v5.12-rc6    108%

> 
> > > I bisected the kernel patches, then I found the patch series, which add
> > > object level memory cgroup support, causes the degradation.
> > >
> > > I confirmed the delay with a kernel module which just runs
> > > kmem_cache_alloc/kmem_cache_free as follows. The duration is about
> > > 2-3 times than v5.8.
> > >
> > >    dummy_cache = KMEM_CACHE(dummy, SLAB_ACCOUNT);
> > >    for (i = 0; i < 100000000; i++)
> > >    {
> > >            p = kmem_cache_alloc(dummy_cache, GFP_KERNEL);
> > >            kmem_cache_free(dummy_cache, p);
> > >    }
> > >
> > > It seems that the object accounting work in slab_pre_alloc_hook() and
> > > slab_post_alloc_hook() is the overhead.
> > >
> > > cgroup.nokmem kernel parameter doesn't work for my case because it disables
> > > all of kmem accounting.
> 
> The patch is somewhat doing that i.e. disabling memcg accounting for slab.
> 
> > >
> > > The degradation is gone when I apply a patch (at the bottom of this email)
> > > that adds a kernel parameter that expects to fallback to the page level
> > > accounting, however, I'm not sure it's a good approach though...
> >
> > Hello Masayoshi!
> >
> > Thank you for the report!
> >
> > It's not a secret that per-object accounting is more expensive than a per-page
> > allocation. I had micro-benchmark results similar to yours: accounted
> > allocations are about 2x slower. But in general it tends to not affect real
> > workloads, because the cost of allocations is still low and tends to be only
> > a small fraction of the whole cpu load. And because it brings up significant
> > benefits: 40%+ slab memory savings, less fragmentation, more stable workingset,
> > etc, real workloads tend to perform on pair or better.
> >
> > So my first question is if you see the regression in any real workload
> > or it's only about the benchmark?
> >
> > Second, I'll try to take a look into the benchmark to figure out why it's
> > affected so badly, but I'm not sure we can easily fix it. If you have any
> > ideas what kind of objects the benchmark is allocating in big numbers,
> > please let me know.
> >
> 
> One idea would be to increase MEMCG_CHARGE_BATCH.

Thank you for the idea! It's hard-corded as 32 now, so I'm wondering it may be
a good idea to make MEMCG_CHARGE_BATCH tunable from a kernel parameter or something.

Thanks!
Masa
