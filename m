Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14BF8719145
	for <lists+cgroups@lfdr.de>; Thu,  1 Jun 2023 05:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjFADWH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 31 May 2023 23:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjFADWG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 31 May 2023 23:22:06 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B70124
        for <cgroups@vger.kernel.org>; Wed, 31 May 2023 20:22:05 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f6a6b9bebdso43665e9.0
        for <cgroups@vger.kernel.org>; Wed, 31 May 2023 20:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685589723; x=1688181723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qStCg7KeACsi2KVI6FrJ4HwOilw06iHPCAkOe/uQA0Q=;
        b=F+a3gWbqc5yvzXtyB3N2bGHooXmHV7Le8S7sW/yVCLU1xCJkFBNuoEDREeMI6S9a/u
         lEROE+8+MoRFn4wAK/rstppBHdPTTqAgNqGrFvTfpI9msilONOo3t8TLTVwLryJfLfPR
         ZIP4335XuiBknLIzEDoiQkYlG1esppjFJCpnROVgTEvdgS1jX0CBispLOZR21JAYON0+
         yZL9aEcdajnFvUdH8HjETBefVAUJ3Osp5WDLyoJOYd9jkttb/DB7HSDDnxoxexiFXXOd
         4DL2z1hWQ6cii5dD8B6ar/6dErmSUvHLdtgMEUIsXjyEaXPpt0mzvHis8tbBNdpUNcqy
         E0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685589723; x=1688181723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qStCg7KeACsi2KVI6FrJ4HwOilw06iHPCAkOe/uQA0Q=;
        b=g7VovwIJvMfs6szLStWFlKvY81m3PT27UGTHu0nOCOwVXi/LON+dfyefwYgKlHrdg+
         y1xB4ZicMl5PxQZtVPZmmdOH/PaIfVgBLeNCL2kLVY18MCfhbGvHSq0p/c7JXWnY0oiZ
         9SqgZwYRg77FBb4xET10zT+mLjM+kP7XvUqueB+JINpWjq4PSQGE/cale2cDLfU8F9tC
         e2OcnrYeDpBeq4B/8N7U4hKPS1NG+h/xWq21TIKziPSfGC7TWL7p8udZD50tiX3RjHbm
         666+hFUGrX66QXZUoASU4uERccvOW6Bqr9czPoiY5OtYkLYqfqpPHTfNMhHoPiEOWaaN
         olqw==
X-Gm-Message-State: AC+VfDx1RMNqFEVxEGCQS4k0gCgir97wzEGgSr4qQPKckOjhPZhauu1F
        q2l8sz8oO7COVDH0Qo5xGJkQhXYaot2dLPfXxYARBw==
X-Google-Smtp-Source: ACHHUZ736YceZpdtvfKwWNDiZOp/Z6AYQZvPcY7aL4/Vy7gmo6ngT95goGJUW1bqEWgF9nWI2MOKi5lNmdon2p3yUaU=
X-Received: by 2002:a05:600c:82c9:b0:3f4:df95:17e0 with SMTP id
 eo9-20020a05600c82c900b003f4df9517e0mr62557wmb.5.1685589723336; Wed, 31 May
 2023 20:22:03 -0700 (PDT)
MIME-Version: 1.0
References: <CH3PR11MB7345DBA6F79282169AAFE9E0FC759@CH3PR11MB7345.namprd11.prod.outlook.com>
 <20230512171702.923725-1-shakeelb@google.com> <CH3PR11MB7345035086C1661BF5352E6EFC789@CH3PR11MB7345.namprd11.prod.outlook.com>
 <CALvZod7n2yHU8PMn5b39w6E+NhLtBynDKfo1GEfXaa64_tqMWQ@mail.gmail.com>
 <CH3PR11MB7345E9EAC5917338F1C357C0FC789@CH3PR11MB7345.namprd11.prod.outlook.com>
 <CALvZod6txDQ9kOHrNFL64XiKxmbVHqMtWNiptUdGt9UuhQVLOQ@mail.gmail.com>
 <ZGMYz+08I62u+Yeu@xsang-OptiPlex-9020> <20230517162447.dztfzmx3hhetfs2q@google.com>
 <ZHcJUF4f9VcnyGVt@xsang-OptiPlex-9020> <20230531194520.qhvibyyaqg7vwi6s@google.com>
 <CH3PR11MB73454186CA28AE6ACCEA9674FC499@CH3PR11MB7345.namprd11.prod.outlook.com>
In-Reply-To: <CH3PR11MB73454186CA28AE6ACCEA9674FC499@CH3PR11MB7345.namprd11.prod.outlook.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 1 Jun 2023 05:21:51 +0200
Message-ID: <CANn89iLPbd3JDvFCgvZO_1sppCyFDFQ_fqJy3kKBAucJrbm_vw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] net: Keep sk->sk_forward_alloc as a proper size
To:     "Zhang, Cathy" <cathy.zhang@intel.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        "Sang, Oliver" <oliver.sang@intel.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        "Tang, Feng" <feng.tang@intel.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "Srinivas, Suresh" <suresh.srinivas@intel.com>,
        "Chen, Tim C" <tim.c.chen@intel.com>,
        "You, Lizhen" <lizhen.you@intel.com>,
        "eric.dumazet@gmail.com" <eric.dumazet@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "Li, Philip" <philip.li@intel.com>,
        "Liu, Yujie" <yujie.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jun 1, 2023 at 4:48=E2=80=AFAM Zhang, Cathy <cathy.zhang@intel.com>=
 wrote:
>
>
>
> > -----Original Message-----
> > From: Shakeel Butt <shakeelb@google.com>
> > Sent: Thursday, June 1, 2023 3:45 AM
> > To: Sang, Oliver <oliver.sang@intel.com>
> > Cc: Zhang, Cathy <cathy.zhang@intel.com>; Yin, Fengwei
> > <fengwei.yin@intel.com>; Tang, Feng <feng.tang@intel.com>; Eric Dumazet
> > <edumazet@google.com>; Linux MM <linux-mm@kvack.org>; Cgroups
> > <cgroups@vger.kernel.org>; Paolo Abeni <pabeni@redhat.com>;
> > davem@davemloft.net; kuba@kernel.org; Brandeburg, Jesse
> > <jesse.brandeburg@intel.com>; Srinivas, Suresh
> > <suresh.srinivas@intel.com>; Chen, Tim C <tim.c.chen@intel.com>; You,
> > Lizhen <lizhen.you@intel.com>; eric.dumazet@gmail.com;
> > netdev@vger.kernel.org; Li, Philip <philip.li@intel.com>; Liu, Yujie
> > <yujie.liu@intel.com>
> > Subject: Re: [PATCH net-next 1/2] net: Keep sk->sk_forward_alloc as a p=
roper
> > size
> >
> > Hi Oliver,
> >
> > On Wed, May 31, 2023 at 04:46:08PM +0800, Oliver Sang wrote:
> > [...]
> > >
> > > we applied below patch upon v6.4-rc2, so far, we didn't spot out
> > > performance impacts of it to other tests.
> > >
> > > but we found -7.6% regression of netperf.Throughput_Mbps
> > >
> >
> > Thanks, this is what I was looking for. I will dig deeper and decide ho=
w to
> > proceed (i.e. improve this patch or work on long term approach).
>
> Hi Shakeel,
> If I understand correctly, I think the long-term goal you mentioned is to
> implement a per-memcg per-cpu cache or a percpu_counter solution, right?
> A per-memcg per-cpu cache solution can avoid the uncharge overhead and
> reduce charge overhead, while the percpu_counter solution can help avoid
> the charge overhead ultimately. It seems both are necessary and complex.
>
> The above is from memory side, regarding to our original proposal that is=
 to
> tune the reclaim threshold from network side, Eric and you worry about th=
at
> it might re-introduce the OOM issue. I see the following two interfaces i=
n
> network stack, which indicate the memory usage status, so is it possible =
to
> tune the reclaim threshold to smaller when enter memory pressure and set
> it to 64K when leave memory pressure? How do you think?
>         void                    (*enter_memory_pressure)(struct sock *sk)=
;
>         void                    (*leave_memory_pressure)(struct sock *sk)=
;
>

No it is not possible to reclaim 'the threshold' when 10,000,000
sockets are alive and kept
a budget around 64KB.
We do not have a shrinker and we do not want one.
The only sensible solution is per-cpu cache.
This was done in core TCP stack, a similar solution is needed in
memcg, if memcg has to be used.
