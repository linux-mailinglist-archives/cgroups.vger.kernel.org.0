Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD4B035A2A1
	for <lists+cgroups@lfdr.de>; Fri,  9 Apr 2021 18:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbhDIQF5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 9 Apr 2021 12:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233395AbhDIQF5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 9 Apr 2021 12:05:57 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2BBC061760
        for <cgroups@vger.kernel.org>; Fri,  9 Apr 2021 09:05:44 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id c6so4554572qtc.1
        for <cgroups@vger.kernel.org>; Fri, 09 Apr 2021 09:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=QhmfWW84CRFKzl562/MmBkeBA4j+Ef4ragxrzhUeTuU=;
        b=Eylqsk546yTCAujbrrggfp0ZBcs7wNmlHZprEboYUeU4SNxe13tkPD/ozr3mcVvdtf
         xq9EMd0BUPtqwL8hQthmumMKKE78alM8pxypx8//Z5UrZURGeuifdT+9+ypNxhyJFDI8
         4sQq8XG6Fdz6n2pJnnrSAwn9ouG4XYPyqM8IJliaYfI5IMHGKH3xIUGuKz66g3fWavhS
         /A0OUXxWNoOT2vHUlcFV8uVMC07mjuwEhq+jbqsOGz9PmWMgpzEQ4lvqdejeduYziD9+
         XKNncvhp800wz1YKboRfWKrccd1FGKGe1OfBsHPQyE69W9jUemqPY2UzHKm3v5kl5uVB
         YONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=QhmfWW84CRFKzl562/MmBkeBA4j+Ef4ragxrzhUeTuU=;
        b=cEOMtIEIcf1Fh4/q0p72U7IkmHOQ6qHaNYyu9AeJ9H5dotWzvCvGXFmk/8Q6LGVGlK
         RFcuRrMffqtrtbtWowdr1x6VlAT9nuyq8To5V16+msX0QmiHKYttmbNKDvylUT9FduUS
         jDpqcUnI6oXe2PCL8LxU3kOGe/J+bjSaNwzy1/VspglNXPHy83EOY5x54eUjyp36a2wI
         SuySGRiGpRruQt23tVGKbGUxK30skadTvk7JcsCDS70yXQbBInkWOXPEWdvzuoOTdWup
         xBU/c7RBwPQn9BHe/66f435nzHbnlQvl9rWj3fcRoI3uZwdfgjjWuKhfersaAtVTGJVG
         C0cQ==
X-Gm-Message-State: AOAM531sUp5HYRo2ZSROvzJ6SLYYRkUZnCTsFqnHQEp4bjqVXrzutcPN
        iN1ws1rpVlCDqBJvFL6c6Q==
X-Google-Smtp-Source: ABdhPJxR0su+DdChNtYtBZ5bgNRPqB9H+CItgpGfbbmilbFcuPTMR+/JhLNerXXF4ZqZ3NlmPI13Lg==
X-Received: by 2002:a05:622a:14d4:: with SMTP id u20mr13365630qtx.185.1617984343829;
        Fri, 09 Apr 2021 09:05:43 -0700 (PDT)
Received: from gabell (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id e2sm2038656qto.50.2021.04.09.09.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 09:05:43 -0700 (PDT)
Date:   Fri, 9 Apr 2021 12:05:41 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: memcg: performance degradation since v5.9
Message-ID: <20210409160541.4tfkeex7mcfrwras@gabell>
References: <20210408193948.vfktg3azh2wrt56t@gabell>
 <YG9tW1h9VSJcir+Y@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YG9tW1h9VSJcir+Y@carbon.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 08, 2021 at 01:53:47PM -0700, Roman Gushchin wrote:
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
> >   - v5.8
> > 
> >    syscall            calls  errors  total       min       avg       max       stddev
> >                                      (msec)    (msec)    (msec)    (msec)        (%)
> >    --------------- --------  ------ -------- --------- --------- ---------     ------
> >    sendto            699574      0  2595.220     0.001     0.004     0.462      0.03%
> >    recvfrom         1391089 694427  2163.458     0.001     0.002     0.442      0.04%
> > 
> >   - v5.9
> > 
> >    syscall            calls  errors  total       min       avg       max       stddev
> >                                      (msec)    (msec)    (msec)    (msec)        (%)
> >    --------------- --------  ------ -------- --------- --------- ---------     ------
> >    sendto            699187      0  3316.948     0.002     0.005     0.044      0.02%
> >    recvfrom         1397042 698828  2464.995     0.001     0.002     0.025      0.04%
> > 
> >   - v5.12-rc6
> > 
> >    syscall            calls  errors  total       min       avg       max       stddev
> >                                      (msec)    (msec)    (msec)    (msec)        (%)
> >    --------------- --------  ------ -------- --------- --------- ---------     ------
> >    sendto            699445      0  3015.642     0.002     0.004     0.027      0.02%
> >    recvfrom         1395929 697909  2338.783     0.001     0.002     0.024      0.03%
> > 
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
> > 
> > The degradation is gone when I apply a patch (at the bottom of this email)
> > that adds a kernel parameter that expects to fallback to the page level
> > accounting, however, I'm not sure it's a good approach though...
> 
> Hello Masayoshi!
> 
> Thank you for the report!

Hi!

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

It's only about the benchmark so far. I'll let you know if I get the issue with
real workload.

> 
> Second, I'll try to take a look into the benchmark to figure out why it's
> affected so badly, but I'm not sure we can easily fix it. If you have any
> ideas what kind of objects the benchmark is allocating in big numbers,
> please let me know.

The benchmark does sendto() and recvfrom() to the unix domain socket
repeatedly, and kmem_cache_alloc_node()/kmem_cache_free() is called
to allocate/free the socket buffers.
The call graph to allocate the object is as flllows.

  do_syscall_64
    __x64_sys_sendto
      __sys_sendto
        sock_sendmsg
          unix_stream_sendmsg
            sock_alloc_send_pskb
              alloc_skb_with_frags
                __alloc_skb
                  kmem_cache_alloc_node

kmem_cache_alloc_node()/kmem_cache_free() is called about 1,400,000 times
during the benchmark and the object size is 216 byte, the GFP flag is 0x400cc0:
 ___GFP_ACCOUNT | ___GFP_KSWAPD_RECLAIM | ___GFP_DIRECT_RECLAIM | ___GFP_FS | ___GFP_IO

I got the data by following bpftrace script.

  # cat kmem.bt 
  #!/usr/bin/env bpftrace

  tracepoint:kmem:kmem_cache_alloc_node /comm == "pgbench"/
  {
	@alloc[comm, args->bytes_req, args->bytes_alloc, args->gfp_flags] = count();
  }

  tracepoint:kmem:kmem_cache_free /comm == "pgbench"/
  {
	@free[comm] = count();
  }
  # ./kmem.bt 
  Attaching 2 probes...
  ^C

  @alloc[pgbench, 11784, 11840, 3264]: 1
  @alloc[pgbench, 216, 256, 3264]: 23
  @alloc[pgbench, 216, 256, 4197568]: 1400046

  @free[pgbench]: 1400560

  # 

I hope this helps...

Thanks!
Masa
