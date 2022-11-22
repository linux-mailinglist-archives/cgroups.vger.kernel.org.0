Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095B263435C
	for <lists+cgroups@lfdr.de>; Tue, 22 Nov 2022 19:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbiKVSMB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Nov 2022 13:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234489AbiKVSLy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Nov 2022 13:11:54 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94F08432D
        for <cgroups@vger.kernel.org>; Tue, 22 Nov 2022 10:11:52 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-3ae8df81a2bso3172357b3.0
        for <cgroups@vger.kernel.org>; Tue, 22 Nov 2022 10:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uTQ93Z87A52MpnvZoEIsory772cnGzPzKryozV7ZFMk=;
        b=eXRoXvJRiBCc4ufq2quAPTpY36052Qmg9ynJmmqrrDvdULqV2GyhSyyCXRtHLfReA0
         UZ4uYA3R18WWgJQym+RjkpAA9QLjlQe9RkctGzZLf2CLo2m5Yjei/K0Gw+4PLUG7YH+C
         SieK0NVoP0S46kpu/NZHdkdeARBmklooxECdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uTQ93Z87A52MpnvZoEIsory772cnGzPzKryozV7ZFMk=;
        b=KiSRYfwqTlyYXYN0KDJ/fvwnlP+/K0eDqY7CinN0ttQwphl0KtB++/vAKQ1+rrwvO6
         tmBYw5KR6MnSE232GMY0kSDtcvWDtokSmvAsAm2lQS6YiKNdQZ4xqxJwHP7/rbBjQ2RV
         bBXwJloX5yQ/m/A2ojhCosy29CgLOme3jayxoApLIZNHBGRDNH3WekJ4LoRZCSUafsdv
         E7N6LtPWUy7DAIPgix5wOLXJknaycGRnpJ/xNseb1FtixNfbR0PNTQfXaRA95rBePzSl
         7FxBk/EYLSCr8FluAMKjXiM8LKucxKQ/WrsYS99F7UnDtiqwmOtU+XMA7Kt5boLg/D6y
         +p7w==
X-Gm-Message-State: ANoB5pn8/rx5DetrWWmDIq0YKb5G3ihSIZ514XfUgdQ8kCawElL0AFrq
        VLeo6eHaOuhaxkbM9hMwYL1XtbuZ61JTF1gUVpAegg==
X-Google-Smtp-Source: AA0mqf7emZOlCYdxjFv9OlOdAqA06u5zBljIwZe85CqwbyKVNWtXVkm08rhOWF/8TeguFv0utvqucfYZxFMqw4g11WY=
X-Received: by 2002:a81:9957:0:b0:394:c5de:d29c with SMTP id
 q84-20020a819957000000b00394c5ded29cmr19799527ywg.224.1669140711955; Tue, 22
 Nov 2022 10:11:51 -0800 (PST)
MIME-Version: 1.0
References: <CABWYdi0G7cyNFbndM-ELTDAR3x4Ngm0AehEp5aP0tfNkXUE+Uw@mail.gmail.com>
 <CANn89iLzARPp6jW1xS0rf+-wS_RnwK-Kfgs9uQFYan2AHPRQFA@mail.gmail.com>
In-Reply-To: <CANn89iLzARPp6jW1xS0rf+-wS_RnwK-Kfgs9uQFYan2AHPRQFA@mail.gmail.com>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Tue, 22 Nov 2022 10:11:41 -0800
Message-ID: <CABWYdi2TWJej806yif9hi7cxD9P9-EpMB9EU_72wWw9fFqtt4g@mail.gmail.com>
Subject: Re: Low TCP throughput due to vmpressure with swap enabled
To:     Eric Dumazet <edumazet@google.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Nov 22, 2022 at 10:01 AM Eric Dumazet <edumazet@google.com> wrote:
>
> On Mon, Nov 21, 2022 at 4:53 PM Ivan Babrou <ivan@cloudflare.com> wrote:
> >
> > Hello,
> >
> > We have observed a negative TCP throughput behavior from the following commit:
> >
> > * 8e8ae645249b mm: memcontrol: hook up vmpressure to socket pressure
> >
> > It landed back in 2016 in v4.5, so it's not exactly a new issue.
> >
> > The crux of the issue is that in some cases with swap present the
> > workload can be unfairly throttled in terms of TCP throughput.
>
> I guess defining 'fairness' in such a scenario is nearly impossible.
>
> Have you tried changing /proc/sys/net/ipv4/tcp_rmem  (and/or tcp_wmem) ?
> Defaults are quite conservative.

Yes, our max sizes are much higher than the defaults. I don't see how
it matters though. The issue is that the kernel clamps rcv_sshtrehsh
at 4 x advmss. No matter how much TCP memory you end up using, the
kernel will clamp based on responsiveness to memory reclaim, which in
turn depends on swap presence. We're seeing it in production with tens
of thousands of sockets and high max tcp_rmem and I'm able to
replicate the same issue in my vm with the default sysctl values.

> If for your workload you want to ensure a minimum amount of memory per
> TCP socket,
> that might be good enough.

That's not my goal at all. We don't have a problem with TCP memory
consumption. Our issue is low throughput because vmpressure() thinks
that the cgroup is memory constrained when it most definitely is not.
