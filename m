Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0439B6FCD93
	for <lists+cgroups@lfdr.de>; Tue,  9 May 2023 20:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjEISR6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 9 May 2023 14:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjEISR5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 9 May 2023 14:17:57 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1518B4C09
        for <cgroups@vger.kernel.org>; Tue,  9 May 2023 11:17:54 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-3f38a9918d1so226051cf.1
        for <cgroups@vger.kernel.org>; Tue, 09 May 2023 11:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683656273; x=1686248273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S2UHCATH3G4CuSJf4Vt2XimiowlnQCvyva4J0Y6pMkg=;
        b=Mli6sJjznQpwgkxl03KMv9Ha9Q0uVZi6usPfIE7bV5rhYWG3rMpH/tXFlJYEQAtrPe
         C8cQFSATIeyaRKBBearzQRWEPXqK4RTh2/pbm/3KotJawrCfoQAMmqG6KHFGv0+LInVD
         xe2zW+twGzSmkzZHHYOFM1isS8rlNC90pLpUbUTUQeMewuWnwYvdzuDokXbe4dHMx/Ft
         QRR4TS0bsiIz2PJzZtMS0BqZJuILhC++3fY+TwB5CHWXhg6KMfPMzKGe55CFAOY+VZT9
         L1AHCrAVtuGUJ+NyEGBiFau844G7zH2uAbHNSHYGDfSFROX3VTT1dBqC6uhn3hbpyNxi
         ZDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683656273; x=1686248273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S2UHCATH3G4CuSJf4Vt2XimiowlnQCvyva4J0Y6pMkg=;
        b=MzhzwZZF0MBzffIBHOes34q0vpUjwg9wKKPUozgjBygDVNlMvBKXR74pq5MPCRVB6m
         fGQ+sxkyNpuuO0Jl2WgGNcsQJaOhbZg22K0EhNdvmMtL7U6JYfToIgDapFZ1h0WQjYQK
         8vnNKArM/8/QKVPVy6lDbIGgNRmtyg6Zbj2npruaq6V+ipicFhaq8LXEYAPYVQzUugFY
         RbyWtOa0vCyHEze3LINiRRJAZFppEfhYuxWrElZwD8DzYVjrYjnMys8ooP0UDfryg4si
         nIOtH+10rZojr38gPX55kRmuWKE7Cip28bbxOSOgZU2dh657i09c1yeVmYaaZ8glINko
         9TdQ==
X-Gm-Message-State: AC+VfDxDpx3r76os5oIioouqHImQLD8xRsvls//+8nfokDbP64/RhZYw
        LmdN1JK97Yc4GqQiN0Xz3F92QwNW1LnsYwLISnehkQ==
X-Google-Smtp-Source: ACHHUZ7G3A1pxETvCDMCgi5l0cfgkN5QkyBZAAL1qT1lH27vzhUsZzS/gxx89nyDdD3eGuZO5abz0LGlDhqNrNGqX24=
X-Received: by 2002:a05:622a:cb:b0:3e0:c2dd:fd29 with SMTP id
 p11-20020a05622a00cb00b003e0c2ddfd29mr42041qtw.4.1683656273106; Tue, 09 May
 2023 11:17:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230508020801.10702-1-cathy.zhang@intel.com> <20230508020801.10702-2-cathy.zhang@intel.com>
 <20230509171910.yka3hucbwfnnq5fq@google.com> <DM6PR11MB41078CDC3B97ED88AF71DEBFDC769@DM6PR11MB4107.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB41078CDC3B97ED88AF71DEBFDC769@DM6PR11MB4107.namprd11.prod.outlook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 9 May 2023 11:17:42 -0700
Message-ID: <CALvZod7njXsc0JDHxxi_+0c=owNwC6m1g_FieRfY4XkfuTmo1A@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] net: Keep sk->sk_forward_alloc as a proper size
To:     "Chen, Tim C" <tim.c.chen@intel.com>
Cc:     "Zhang, Cathy" <cathy.zhang@intel.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "Srinivas, Suresh" <suresh.srinivas@intel.com>,
        "You, Lizhen" <lizhen.you@intel.com>,
        "eric.dumazet@gmail.com" <eric.dumazet@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
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

On Tue, May 9, 2023 at 11:04=E2=80=AFAM Chen, Tim C <tim.c.chen@intel.com> =
wrote:
>
> >>
> >> Run memcached with memtier_benchamrk to verify the optimization fix. 8
> >> server-client pairs are created with bridge network on localhost,
> >> server and client of the same pair share 28 logical CPUs.
> >>
> > >Results (Average for 5 run)
> > >RPS (with/without patch)     +2.07x
> > >
>
> >Do you have regression data from any production workload? Please keep in=
 mind that many times we (MM subsystem) accepts the regressions of microben=
chmarks over complicated optimizations. So, if there is a real production r=
egression, please be very explicit about it.
>
> Though memcached is actually used by people in production. So this isn't =
an unrealistic scenario.
>

Yes, memcached is used in production but I am not sure anyone runs 8
pairs of server and client on the same machine for production
workload. Anyways, we can discuss, if needed, about the practicality
of the benchmark after we have some impactful memcg optimizations.

> Tim
