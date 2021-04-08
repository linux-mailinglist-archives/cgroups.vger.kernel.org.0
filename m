Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1A6358EF6
	for <lists+cgroups@lfdr.de>; Thu,  8 Apr 2021 23:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbhDHVIj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 8 Apr 2021 17:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbhDHVIi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 8 Apr 2021 17:08:38 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BEFC061760
        for <cgroups@vger.kernel.org>; Thu,  8 Apr 2021 14:08:26 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id h19so6273235lfu.9
        for <cgroups@vger.kernel.org>; Thu, 08 Apr 2021 14:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mHTf5ssdkIiRDssyNc9X1VWJob3DAQAHF/gT3LBrwK4=;
        b=K/2mj2WZnop4FMfN5auFI3pSXePveJpdMuXsG94EKe79lp0ntZCo4nrOpfAe3cD7zZ
         EAOCOhkQPiteudf67bLl1Xb5omVMKb0zTVI091C70TA+rMYlc/5Z+JlE/pap0Pun/ZvU
         OkHlTT9LSMp2KCTY5isvFeg9T4xFaTdXDH6Ip4whYUQsSPvCotnTg6JTG0mwR6eARGV9
         W/UdSM+Zaxqx7oom4CcfDZpI8lsM0MEFo6eQkuu8SE3Vnhw6LtLXb1q1VWaDh+CyXUeH
         pbs9Irk0M9erAhjswUFKHAvQJT0Ya4Nwfd+2LK5qoGY+oX7xDjD2DuIVYBmoa/XEWmW/
         Plqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mHTf5ssdkIiRDssyNc9X1VWJob3DAQAHF/gT3LBrwK4=;
        b=VVCpEjzgweGyoAEFIVis83fmaI44zlHGtwzZT3zUBstfPri/aNKvnlkQxzEwJrPtwK
         L3vHuZE8ZzrTUaAIpwZ7q2Xuhh2pWoeXzDHRR4iCZRnVk6AgBP0mT0FhrPQAVpDeWY0a
         L6bZMT+3w94+TuB4nW7tL9fSFAZtyJUK4f+qGxKl0EOexqAxMDki2J0PJEzg8Laz3htO
         VWlx+0U6XXvApjxIj85oeWW9Ez7qaQ7WHJi3jnMiTjoe2G0TXWgYypMGuDTnMsKHIcKt
         nFAb4xf1gL6mjsslOm5qO0kvaGjZZ8ZLeEa5/E5M7PyTZN6WOCHkh4q59rOC+FPsUntF
         n+sw==
X-Gm-Message-State: AOAM531D3Oe4nnBY9G/U7sIf+pE8hgKjLOusvkOLvyoXyPnJ/RKsUbX5
        LT0FXtkTpoNipidwg7qcngPC3Qic+qFfDbgZiPNcRKi3FWlGvQ==
X-Google-Smtp-Source: ABdhPJyvolIigLxCDZRZlYFjolv6wvU8kltQD0URGdOZg186bPPwq8th2JOzr7NDip7h6wQXMX1mecS1D41flyHh8Eo=
X-Received: by 2002:a19:3804:: with SMTP id f4mr8369747lfa.117.1617916104718;
 Thu, 08 Apr 2021 14:08:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210408193948.vfktg3azh2wrt56t@gabell> <YG9tW1h9VSJcir+Y@carbon.dhcp.thefacebook.com>
In-Reply-To: <YG9tW1h9VSJcir+Y@carbon.dhcp.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 8 Apr 2021 14:08:13 -0700
Message-ID: <CALvZod58NBQLvk2m7Mb=_0oGCApcNeisxVuE1b+qh1OKDSy0Ag@mail.gmail.com>
Subject: Re: memcg: performance degradation since v5.9
To:     Roman Gushchin <guro@fb.com>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 8, 2021 at 1:54 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Thu, Apr 08, 2021 at 03:39:48PM -0400, Masayoshi Mizuma wrote:
> > Hello,
> >
> > I detected a performance degradation issue for a benchmark of PostgresSQL [1],
> > and the issue seems to be related to object level memory cgroup [2].
> > I would appreciate it if you could give me some ideas to solve it.
> >
> > The benchmark shows the transaction per second (tps) and the tps for v5.9
> > and later kernel get about 10%-20% smaller than v5.8.
> >
> > The benchmark does sendto() and recvfrom() system calls repeatedly,
> > and the duration of the system calls get longer than v5.8.
> > The result of perf trace of the benchmark is as follows:
> >
> >   - v5.8
> >
> >    syscall            calls  errors  total       min       avg       max       stddev
> >                                      (msec)    (msec)    (msec)    (msec)        (%)
> >    --------------- --------  ------ -------- --------- --------- ---------     ------
> >    sendto            699574      0  2595.220     0.001     0.004     0.462      0.03%
> >    recvfrom         1391089 694427  2163.458     0.001     0.002     0.442      0.04%
> >
> >   - v5.9
> >
> >    syscall            calls  errors  total       min       avg       max       stddev
> >                                      (msec)    (msec)    (msec)    (msec)        (%)
> >    --------------- --------  ------ -------- --------- --------- ---------     ------
> >    sendto            699187      0  3316.948     0.002     0.005     0.044      0.02%
> >    recvfrom         1397042 698828  2464.995     0.001     0.002     0.025      0.04%
> >
> >   - v5.12-rc6
> >
> >    syscall            calls  errors  total       min       avg       max       stddev
> >                                      (msec)    (msec)    (msec)    (msec)        (%)
> >    --------------- --------  ------ -------- --------- --------- ---------     ------
> >    sendto            699445      0  3015.642     0.002     0.004     0.027      0.02%
> >    recvfrom         1395929 697909  2338.783     0.001     0.002     0.024      0.03%
> >

Can you please explain how to read these numbers? Or at least put a %
regression.

> > I bisected the kernel patches, then I found the patch series, which add
> > object level memory cgroup support, causes the degradation.
> >
> > I confirmed the delay with a kernel module which just runs
> > kmem_cache_alloc/kmem_cache_free as follows. The duration is about
> > 2-3 times than v5.8.
> >
> >    dummy_cache = KMEM_CACHE(dummy, SLAB_ACCOUNT);
> >    for (i = 0; i < 100000000; i++)
> >    {
> >            p = kmem_cache_alloc(dummy_cache, GFP_KERNEL);
> >            kmem_cache_free(dummy_cache, p);
> >    }
> >
> > It seems that the object accounting work in slab_pre_alloc_hook() and
> > slab_post_alloc_hook() is the overhead.
> >
> > cgroup.nokmem kernel parameter doesn't work for my case because it disables
> > all of kmem accounting.

The patch is somewhat doing that i.e. disabling memcg accounting for slab.

> >
> > The degradation is gone when I apply a patch (at the bottom of this email)
> > that adds a kernel parameter that expects to fallback to the page level
> > accounting, however, I'm not sure it's a good approach though...
>
> Hello Masayoshi!
>
> Thank you for the report!
>
> It's not a secret that per-object accounting is more expensive than a per-page
> allocation. I had micro-benchmark results similar to yours: accounted
> allocations are about 2x slower. But in general it tends to not affect real
> workloads, because the cost of allocations is still low and tends to be only
> a small fraction of the whole cpu load. And because it brings up significant
> benefits: 40%+ slab memory savings, less fragmentation, more stable workingset,
> etc, real workloads tend to perform on pair or better.
>
> So my first question is if you see the regression in any real workload
> or it's only about the benchmark?
>
> Second, I'll try to take a look into the benchmark to figure out why it's
> affected so badly, but I'm not sure we can easily fix it. If you have any
> ideas what kind of objects the benchmark is allocating in big numbers,
> please let me know.
>

One idea would be to increase MEMCG_CHARGE_BATCH.
