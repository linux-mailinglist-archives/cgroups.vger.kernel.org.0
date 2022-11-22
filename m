Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9B763444A
	for <lists+cgroups@lfdr.de>; Tue, 22 Nov 2022 20:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbiKVTGe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Nov 2022 14:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234717AbiKVTGQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Nov 2022 14:06:16 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBA08D487
        for <cgroups@vger.kernel.org>; Tue, 22 Nov 2022 11:05:57 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id p81so10720895yba.4
        for <cgroups@vger.kernel.org>; Tue, 22 Nov 2022 11:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UH8CULqws8EURCcGLdD3MqO4szk6ZDfTwbWJ1BRasAg=;
        b=aHU/4rTLIP2Roaj3oaDqTP6BsSgt/v+o233yVnztvkFamUnTqO8lqNGVxX/atHUwpT
         0pwGoQ2WKh6tm6+rl6WR91tXJ/1tcpEPv3HIXZCPN6kJbNQzq6rIT91BX3dv+tQCuXjy
         BMucSc5zV6VYfU/4Qe5UZ0aJpEz7PT7LlfCmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UH8CULqws8EURCcGLdD3MqO4szk6ZDfTwbWJ1BRasAg=;
        b=2syORjjegAJ6fUeCFQ2GNqoPQOdWI5zOOmNFIHdjULXu0OLV75mDI6V40ShmY+Unsi
         +wWEVs3JQa0RpeGhYn2m5CGf/uDxo5WHMUVe+pY6SQxK422FDFrgHf4nXVKEalYJenkT
         +TGjWxGdw43WlEdAhYWhijZoBZkk3aU9e9/Fcffv4cb3Juc1ctJjj3Zwziq2zUzOaf9j
         bhryZhiHycBMpGF5YDAYJgAtOZoyg/bOVyk23f+pIvWu6y7jb2u1z1JrRwTiufqLkmbY
         Kd6lxk5mRnE8ohWoocLKME7X2UipDx2bsjalVq2HwZtep31AJy005L/iQPoYPT1tkEuL
         RoXg==
X-Gm-Message-State: ANoB5plzoj+NEY69O/kVzMuoXtVwnoTdpPTHmSQypP2Q1x5KSXCNb5Ew
        VBnkHT9X8Ml76pa2rSjRxHwXz41G0tOpr2/cACtBZA==
X-Google-Smtp-Source: AA0mqf7/yUBMx4gWYxYMHUbZsapsTGO89vB5gRJDkAiIq8XymkZLdq2rSWqnQyXHdKsRkb9Mz4W6p0JLVWhoWo9hIQk=
X-Received: by 2002:a25:1a57:0:b0:6ca:468d:18fe with SMTP id
 a84-20020a251a57000000b006ca468d18femr5482863yba.224.1669143956921; Tue, 22
 Nov 2022 11:05:56 -0800 (PST)
MIME-Version: 1.0
References: <CABWYdi0G7cyNFbndM-ELTDAR3x4Ngm0AehEp5aP0tfNkXUE+Uw@mail.gmail.com>
 <CAOUHufbQ_JjW=zXEi10+=LQOREOPHrK66Rqayr=sFUH_tQbW1w@mail.gmail.com>
In-Reply-To: <CAOUHufbQ_JjW=zXEi10+=LQOREOPHrK66Rqayr=sFUH_tQbW1w@mail.gmail.com>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Tue, 22 Nov 2022 11:05:46 -0800
Message-ID: <CABWYdi3aOtJuMe4Z=FFzBb3iR6Cc9k8G2swSuZ_GDnaESuE_EQ@mail.gmail.com>
Subject: Re: Low TCP throughput due to vmpressure with swap enabled
To:     Yu Zhao <yuzhao@google.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Nov 22, 2022 at 10:59 AM Yu Zhao <yuzhao@google.com> wrote:
>
> On Mon, Nov 21, 2022 at 5:53 PM Ivan Babrou <ivan@cloudflare.com> wrote:
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
> >
> > I am able to reproduce this issue in a VM locally on v6.1-rc6 with 8
> > GiB of RAM with zram enabled.
>
> Hi Ivan,
>
> If it's not too much trouble, could you try again with the following?
>   CONFIG_LRU_GEN=y
>   CONFIG_LRU_GEN_ENABLED=y
>
> I haven't tried it myself. But I'll fix whatever doesn't work for you,
> since your team is on the top of my customer list :)

We don't have it in production, since there we have 5.15 LTS (our
kernel team is testing v6.1).

I do have it enabled in my VM running v6.1-rc6 where I was able to
replicate this, so it doesn't seem to help.
