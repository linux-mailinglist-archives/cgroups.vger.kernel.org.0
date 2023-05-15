Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40BA703DD6
	for <lists+cgroups@lfdr.de>; Mon, 15 May 2023 21:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240909AbjEOTuq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 May 2023 15:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236744AbjEOTup (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 15 May 2023 15:50:45 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F135D04B
        for <cgroups@vger.kernel.org>; Mon, 15 May 2023 12:50:43 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-3f38a9918d1so1541161cf.1
        for <cgroups@vger.kernel.org>; Mon, 15 May 2023 12:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684180242; x=1686772242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9rBJ3Z6bMHq4Ea+F9E390Qio2yO4hD5BQLQUaMJTwA=;
        b=zuGmhQqWoc00Zv+gSniT0ih5yLMGbWSeEIuQWzHekcnhvcSP3KRGL9187CcmxOPax+
         MtLWl4dMw6+fJkaOFeH/pb6g8aCL788Q5ZZGDWgqcMRScbxYfgV/MyGdvNzRfE8+31f1
         nD2iSIsiwu4VYaNTTBv35fZqIEC2HvSxslyNnPR+trOvrP/gt6qnD8VQaqzf8VrVJmwg
         y0ds0jsLE2nvp5xBk9c9AGFPD1mhBoCLZEtzLWpFD8Q5hCJvGHjz1E9xXVphXw1eCiQQ
         rVpBywpzQX9RwqIMhWYO9rCR4/kJ///SolL7aMR4r8Xqev9LMV6pO/WIocrN3XFUtjjU
         aOWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684180242; x=1686772242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R9rBJ3Z6bMHq4Ea+F9E390Qio2yO4hD5BQLQUaMJTwA=;
        b=S5ahtHz7SIo9r/xa/re9gbzlnIFFNoSrZVvEeckXZQEb/v0QMxjqeJEaLQMnotF/4F
         iRgdt0KtTPJczAnSia+ZQCxdttlgQDJd5rbeqmEPd62pxKM+MfA2a/dAWmCY5JYanx2G
         zeVWPLhgpVPYLJy6VJi0E32mqzCJMKFCl8T2cUdmq5BhqOkzd7Ow1wN+ZQvF37aCWqPm
         p0wkAVZW7A1FhMU9TScLq/fRz2caRdH8DWmzylAmnMV1Pu3OwXiOz7ld2ilIqWuQmy4G
         N8U+OmnJ0083j5qhyF0KP+cXxmxegD3JSm89Ey50waR+V1sGKECcYcYH+RGB2TnZkrBG
         lLfQ==
X-Gm-Message-State: AC+VfDxn9ND5K01T25KLUfQAe0cLiH2eSXHdLouvcyM45shuooD2j1wq
        ltPzI1QFGawL2OyP7ZWTKnCrYHrMVv1jplDQYDpbYA==
X-Google-Smtp-Source: ACHHUZ7XVTjje4a4teCP0LdhFit4xaugXUIJ68JcFbfxEOfJ5reZF2OVJCCDEM9N2UqtbUc4EJnvx4PSN18tj2biYFo=
X-Received: by 2002:a05:622a:178a:b0:3ef:31a5:13c with SMTP id
 s10-20020a05622a178a00b003ef31a5013cmr29129qtk.3.1684180242180; Mon, 15 May
 2023 12:50:42 -0700 (PDT)
MIME-Version: 1.0
References: <CH3PR11MB7345DBA6F79282169AAFE9E0FC759@CH3PR11MB7345.namprd11.prod.outlook.com>
 <20230512171702.923725-1-shakeelb@google.com> <CH3PR11MB7345035086C1661BF5352E6EFC789@CH3PR11MB7345.namprd11.prod.outlook.com>
 <CALvZod7n2yHU8PMn5b39w6E+NhLtBynDKfo1GEfXaa64_tqMWQ@mail.gmail.com> <CH3PR11MB7345E9EAC5917338F1C357C0FC789@CH3PR11MB7345.namprd11.prod.outlook.com>
In-Reply-To: <CH3PR11MB7345E9EAC5917338F1C357C0FC789@CH3PR11MB7345.namprd11.prod.outlook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 15 May 2023 12:50:31 -0700
Message-ID: <CALvZod6txDQ9kOHrNFL64XiKxmbVHqMtWNiptUdGt9UuhQVLOQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] net: Keep sk->sk_forward_alloc as a proper size
To:     "Zhang, Cathy" <cathy.zhang@intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        kernel test robot <oliver.sang@intel.com>,
        Feng Tang <feng.tang@intel.com>
Cc:     Eric Dumazet <edumazet@google.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "Srinivas, Suresh" <suresh.srinivas@intel.com>,
        "Chen, Tim C" <tim.c.chen@intel.com>,
        "You, Lizhen" <lizhen.you@intel.com>,
        "eric.dumazet@gmail.com" <eric.dumazet@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
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

+Feng, Yin and Oliver

On Sun, May 14, 2023 at 11:27=E2=80=AFPM Zhang, Cathy <cathy.zhang@intel.co=
m> wrote:
>
>
>
> > -----Original Message-----
> > From: Shakeel Butt <shakeelb@google.com>
> > Sent: Monday, May 15, 2023 12:13 PM
> > To: Zhang, Cathy <cathy.zhang@intel.com>
> > Cc: Eric Dumazet <edumazet@google.com>; Linux MM <linux-
> > mm@kvack.org>; Cgroups <cgroups@vger.kernel.org>; Paolo Abeni
> > <pabeni@redhat.com>; davem@davemloft.net; kuba@kernel.org;
> > Brandeburg, Jesse <jesse.brandeburg@intel.com>; Srinivas, Suresh
> > <suresh.srinivas@intel.com>; Chen, Tim C <tim.c.chen@intel.com>; You,
> > Lizhen <lizhen.you@intel.com>; eric.dumazet@gmail.com;
> > netdev@vger.kernel.org
> > Subject: Re: [PATCH net-next 1/2] net: Keep sk->sk_forward_alloc as a p=
roper
> > size
> >
> > On Sun, May 14, 2023 at 8:46=E2=80=AFPM Zhang, Cathy <cathy.zhang@intel=
.com>
> > wrote:
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Shakeel Butt <shakeelb@google.com>
> > > > Sent: Saturday, May 13, 2023 1:17 AM
> > > > To: Zhang, Cathy <cathy.zhang@intel.com>
> > > > Cc: Shakeel Butt <shakeelb@google.com>; Eric Dumazet
> > > > <edumazet@google.com>; Linux MM <linux-mm@kvack.org>; Cgroups
> > > > <cgroups@vger.kernel.org>; Paolo Abeni <pabeni@redhat.com>;
> > > > davem@davemloft.net; kuba@kernel.org; Brandeburg@google.com;
> > > > Brandeburg, Jesse <jesse.brandeburg@intel.com>; Srinivas, Suresh
> > > > <suresh.srinivas@intel.com>; Chen, Tim C <tim.c.chen@intel.com>;
> > > > You, Lizhen <lizhen.you@intel.com>; eric.dumazet@gmail.com;
> > > > netdev@vger.kernel.org
> > > > Subject: Re: [PATCH net-next 1/2] net: Keep sk->sk_forward_alloc as
> > > > a proper size
> > > >
> > > > On Fri, May 12, 2023 at 05:51:40AM +0000, Zhang, Cathy wrote:
> > > > >
> > > > >
> > > > [...]
> > > > > >
> > > > > > Thanks a lot. This tells us that one or both of following
> > > > > > scenarios are
> > > > > > happening:
> > > > > >
> > > > > > 1. In the softirq recv path, the kernel is processing packets
> > > > > > from multiple memcgs.
> > > > > >
> > > > > > 2. The process running on the CPU belongs to memcg which is
> > > > > > different from the memcgs whose packets are being received on t=
hat
> > CPU.
> > > > >
> > > > > Thanks for sharing the points, Shakeel! Is there any trace record=
s
> > > > > you want to collect?
> > > > >
> > > >
> > > > Can you please try the following patch and see if there is any
> > improvement?
> > >
> > > Hi Shakeel,
> > >
> > > Try the following patch, the data of 'perf top' from system wide
> > > indicates that the overhead of page_counter_cancel is dropped from 15=
.52%
> > to 4.82%.
> > >
> > > Without patch:
> > >     15.52%  [kernel]            [k] page_counter_cancel
> > >     12.30%  [kernel]            [k] page_counter_try_charge
> > >     11.97%  [kernel]            [k] try_charge_memcg
> > >
> > > With patch:
> > >     10.63%  [kernel]            [k] page_counter_try_charge
> > >      9.49%  [kernel]            [k] try_charge_memcg
> > >      4.82%  [kernel]            [k] page_counter_cancel
> > >
> > > The patch is applied on the latest net-next/main:
> > > befcc1fce564 ("sfc: fix use-after-free in
> > > efx_tc_flower_record_encap_match()")
> > >
> >
> > Thanks a lot Cathy for testing. Do you see any performance improvement =
for
> > the memcached benchmark with the patch?
>
> Yep, absolutely :- ) RPS (with/without patch) =3D +1.74

Thanks a lot Cathy.

Feng/Yin/Oliver, can you please test the patch at [1] with other
workloads used by the test robot? Basically I wanted to know if it has
any positive or negative impact on other perf benchmarks.

[1] https://lore.kernel.org/all/20230512171702.923725-1-shakeelb@google.com=
/

Thanks in advance.
