Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D31E634394
	for <lists+cgroups@lfdr.de>; Tue, 22 Nov 2022 19:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbiKVSYC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Nov 2022 13:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234371AbiKVSYB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Nov 2022 13:24:01 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89EE2F3BB
        for <cgroups@vger.kernel.org>; Tue, 22 Nov 2022 10:24:00 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-39e61d2087dso77188667b3.5
        for <cgroups@vger.kernel.org>; Tue, 22 Nov 2022 10:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WQLDoQzOOOLSeL4BW8P5dyKRJbU6yXunhkxiL7lS7JY=;
        b=CDJdz0q15FCrFgZ2RgOE7aoOkCnIE0qqjNfpiyaFukahYrSsxZ4fDxJsk+IKeVDOLo
         fTIZ884+FEiiSCjX4m/RkJvUVv/DQEsLzT8tR6MQJj/DZLHa5vYBkFxjl3a61gRXpZoj
         rpC2JE+T9pLyf+7khG2HYb3MmtiSv8Hc+Sqy3T0KWu28zVIJIVLhqo1hgYEx0lvQmB8o
         hBW6p4z3/wlIQ2VX6+WDew8PHl2O8jidBSbLv71s0dt5scFC2DINgLvjBDp/1D7ww7a/
         HrKpH89edAqH8LukVTkAMdhBlxmVVkYaKernLE5kg3YAKjOaPWyPaIo0MEZmOcq1MqXj
         Jk+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WQLDoQzOOOLSeL4BW8P5dyKRJbU6yXunhkxiL7lS7JY=;
        b=ILNfBqy3g7uUxJSpiy134Vmt3K/xVYCZGu3UGoiJel85oNNLvotSmi20uT1kKgO1on
         f/c1mD6r9WSD8pA2TEhuJ0VxalXyupQeSP25PWc8c1WlVbHcwh5qBRyypLsTwhsIQW9b
         Be9f+L9ZWVzysvsCLV4FRBChWZN56nIhMfZrnvX/PFFbj7TyEG4FhndD1RoGePzJPtBh
         hb0lwdByoMWi/Z5EBJFV6yaJdJ20eMUDxL5ytD5CbM1GdcJx3M/sowrlHPLIvKtb97kw
         9utBR8Sw8eMDqlT+bWzub1IiDxwIvIKKMYheSq+9XIYk0RX4de8vvkzZfY2LXDJvh/w5
         fuwA==
X-Gm-Message-State: ANoB5pmg5Y59wir2XONcya6CLFgPMFWzzCI5v9XnBYzUVik46Q3oOUNN
        tFxm5Poszqmu+HHZwG63k3rboUpNSqIti0PavJq8sQ==
X-Google-Smtp-Source: AA0mqf6LXCkwUEsGG9yFNI5WKVis3+ohpo5D3S2bFziOk7I40KkoxIKh/CgI5DYlRVN1wovpZt5CgwqvQjG2/bPGkQI=
X-Received: by 2002:a81:7cd6:0:b0:357:6958:372a with SMTP id
 x205-20020a817cd6000000b003576958372amr5414093ywc.255.1669141439602; Tue, 22
 Nov 2022 10:23:59 -0800 (PST)
MIME-Version: 1.0
References: <CABWYdi0G7cyNFbndM-ELTDAR3x4Ngm0AehEp5aP0tfNkXUE+Uw@mail.gmail.com>
 <CANn89iLzARPp6jW1xS0rf+-wS_RnwK-Kfgs9uQFYan2AHPRQFA@mail.gmail.com> <CABWYdi2TWJej806yif9hi7cxD9P9-EpMB9EU_72wWw9fFqtt4g@mail.gmail.com>
In-Reply-To: <CABWYdi2TWJej806yif9hi7cxD9P9-EpMB9EU_72wWw9fFqtt4g@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 22 Nov 2022 10:23:48 -0800
Message-ID: <CANn89iK97nkVxchN4-20LxfKd3Bq1bQeY7hsZA6Q=zT+Zd0GOQ@mail.gmail.com>
Subject: Re: Low TCP throughput due to vmpressure with swap enabled
To:     Ivan Babrou <ivan@cloudflare.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, cgroups@vger.kernel.org,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Nov 22, 2022 at 10:11 AM Ivan Babrou <ivan@cloudflare.com> wrote:
>
> On Tue, Nov 22, 2022 at 10:01 AM Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Mon, Nov 21, 2022 at 4:53 PM Ivan Babrou <ivan@cloudflare.com> wrote:
> > >
> > > Hello,
> > >
> > > We have observed a negative TCP throughput behavior from the following commit:
> > >
> > > * 8e8ae645249b mm: memcontrol: hook up vmpressure to socket pressure
> > >
> > > It landed back in 2016 in v4.5, so it's not exactly a new issue.
> > >
> > > The crux of the issue is that in some cases with swap present the
> > > workload can be unfairly throttled in terms of TCP throughput.
> >
> > I guess defining 'fairness' in such a scenario is nearly impossible.
> >
> > Have you tried changing /proc/sys/net/ipv4/tcp_rmem  (and/or tcp_wmem) ?
> > Defaults are quite conservative.
>
> Yes, our max sizes are much higher than the defaults. I don't see how
> it matters though. The issue is that the kernel clamps rcv_sshtrehsh
> at 4 x advmss.

There are some places (eg tcp_clamp_window) where we have this
additional condition :

sk_memory_allocated(sk) < sk_prot_mem_limits(sk, 0)

So I was suggesting maybe to add a similar condition to tcp_try_rmem_schedule()

Then adjust tcp_rmem for your needs.

 No matter how much TCP memory you end up using, the
> kernel will clamp based on responsiveness to memory reclaim, which in
> turn depends on swap presence. We're seeing it in production with tens
> of thousands of sockets and high max tcp_rmem and I'm able to
> replicate the same issue in my vm with the default sysctl values.
>
> > If for your workload you want to ensure a minimum amount of memory per
> > TCP socket,
> > that might be good enough.
>
> That's not my goal at all. We don't have a problem with TCP memory
> consumption. Our issue is low throughput because vmpressure() thinks
> that the cgroup is memory constrained when it most definitely is not.

OK, then I will stop commenting I guess :)
