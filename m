Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9DD7634453
	for <lists+cgroups@lfdr.de>; Tue, 22 Nov 2022 20:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234698AbiKVTIs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Nov 2022 14:08:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbiKVTIq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Nov 2022 14:08:46 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1C27ECBB
        for <cgroups@vger.kernel.org>; Tue, 22 Nov 2022 11:08:44 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id v128so843902vsb.13
        for <cgroups@vger.kernel.org>; Tue, 22 Nov 2022 11:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fKEisOcCxxrkfHjW9WxsM8SkyONoJunCQr/mSNvg18w=;
        b=mv1vO6EVJFQHmOOPSto15ifvc0zcEe34ioOnM5MyYbCpS7QbKucnzT6UaTsnTf5CxU
         tWRPFwXHVHphMm1FODx/9niRsHYLf71qs0kMmREw/jSZ6idKI06kHWAGrIxinqsXv0c7
         6p23QtcPBpkHBgWP+kblIIB3gaaUln2L40fy6NnWeLTTK9iMYhP730afCEVnW5dP6rcg
         jKUKEeHB78cVPoapdl1gSBPnSH2y/w2z+T4lmWO2jzVbFI0goi6foKF+0O/2xAypEKek
         +P4aw8o6DBuP73QHlRXdpjMD9Un3Va0nJmSBL44jF6Z7qOHnZPtkhTH8oK0ZIfGrkNni
         OASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fKEisOcCxxrkfHjW9WxsM8SkyONoJunCQr/mSNvg18w=;
        b=N2ACJvOWGOvZ2SV/Rpiv+gXkDbmCCj8noT0MkBeKYvZKGci01qUY3t6suLWTbdZtX5
         MyVmyLZy3cEnsMI6PE83AdQyWGe9Rv4/v3Btb0wF0gyDBGbHxVeryLOlPe7y6JqAxa2D
         f5n3YRJbB1DerBDP0Y1df0DYMnZHRGmFu6enfe0HCYxSynVGkMxN/T8/uXHAN+mw5ykE
         Ryv18IaBt7VCwBDxDYgdq2Ez4BOLHlQiN+XBl3+K8qSwVUDZCX4pH4/BS9N6f1z4uCmB
         n84keTaYmLBhaQVvseR+Xw9JAfIgn5KrciFI8A0iRM0hq3N6ZHaSBgbqwkEXs2tZvV0H
         Dq7Q==
X-Gm-Message-State: ANoB5pl0I3jaN/skL/L4nw+Ky9i8H3ggvy2BomPOnmkILqvMgSmLxq3G
        oFCaSHl5F3YmsW1SDXzHDqxPX6xhZSKIPIEx6u9MXQ==
X-Google-Smtp-Source: AA0mqf7s3ZLwIADGrmZbS5EhOy/cXfvuc6KPbinmWOjq5dzTh0s+Gs8Q8RUfUPw9LF8wsXqWnglSj8+M2Vn9ZD9H6iw=
X-Received: by 2002:a67:fbd6:0:b0:3ac:38c7:1bdd with SMTP id
 o22-20020a67fbd6000000b003ac38c71bddmr4789726vsr.9.1669144123684; Tue, 22 Nov
 2022 11:08:43 -0800 (PST)
MIME-Version: 1.0
References: <CABWYdi0G7cyNFbndM-ELTDAR3x4Ngm0AehEp5aP0tfNkXUE+Uw@mail.gmail.com>
 <CAOUHufbQ_JjW=zXEi10+=LQOREOPHrK66Rqayr=sFUH_tQbW1w@mail.gmail.com> <CABWYdi3aOtJuMe4Z=FFzBb3iR6Cc9k8G2swSuZ_GDnaESuE_EQ@mail.gmail.com>
In-Reply-To: <CABWYdi3aOtJuMe4Z=FFzBb3iR6Cc9k8G2swSuZ_GDnaESuE_EQ@mail.gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Tue, 22 Nov 2022 12:08:07 -0700
Message-ID: <CAOUHufbm6dLxgZ5=cbz1ogHGXrOfbF=wimpJySDpMRGJ=QPV4w@mail.gmail.com>
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
        Eric Dumazet <edumazet@google.com>,
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

On Tue, Nov 22, 2022 at 12:05 PM Ivan Babrou <ivan@cloudflare.com> wrote:
>
> On Tue, Nov 22, 2022 at 10:59 AM Yu Zhao <yuzhao@google.com> wrote:
> >
> > On Mon, Nov 21, 2022 at 5:53 PM Ivan Babrou <ivan@cloudflare.com> wrote:
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
> > >
> > > I am able to reproduce this issue in a VM locally on v6.1-rc6 with 8
> > > GiB of RAM with zram enabled.
> >
> > Hi Ivan,
> >
> > If it's not too much trouble, could you try again with the following?
> >   CONFIG_LRU_GEN=y
> >   CONFIG_LRU_GEN_ENABLED=y
> >
> > I haven't tried it myself. But I'll fix whatever doesn't work for you,
> > since your team is on the top of my customer list :)
>
> We don't have it in production, since there we have 5.15 LTS (our
> kernel team is testing v6.1).
>
> I do have it enabled in my VM running v6.1-rc6 where I was able to
> replicate this, so it doesn't seem to help.

Thanks. I'll look into this and get back to you.
