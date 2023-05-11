Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9746FF827
	for <lists+cgroups@lfdr.de>; Thu, 11 May 2023 19:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238839AbjEKRKs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 11 May 2023 13:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjEKRKs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 11 May 2023 13:10:48 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586916E8C
        for <cgroups@vger.kernel.org>; Thu, 11 May 2023 10:10:40 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-3f396606ab0so834501cf.0
        for <cgroups@vger.kernel.org>; Thu, 11 May 2023 10:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683825039; x=1686417039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DKdPt1RaUkWe8+eoJAPYnUVWfgFKro3FnMuByj1EFEU=;
        b=nMaXyqypHxPLcxqTJyoCXYG5PeO32ubse8ArHPkY7RDeIj41LN5gMmyL7Ac6dVzFZ7
         ZYsaygJet/Hh0cPTxWS+w/TorbpHNOudoOCWWvZYZnP7YjntjqS2vG64aKUfM9l7X+FF
         szXnzl+jFkr+JYMupJ3DNTQHVvGEygGe/nzzvC3TnnfYnfbGVzKYI+ZYmr6YtCTY7dv/
         xP2Nkwrzf9OcT4F1SVRzG9y5DNHc+Ym1rdaz3WmyeOF+N68nDo8FWm5t2BEEgjwBEkqw
         BfyFN6ArnSBxwav+9BJ9XVHl2wCN5uN9vTchbBWjiZdITpYpyhiYpvWcAnK75GYRAy6A
         t6sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683825039; x=1686417039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DKdPt1RaUkWe8+eoJAPYnUVWfgFKro3FnMuByj1EFEU=;
        b=OHvgU/bhFfFDEtm4q1jHwARFV31d7MM7f8C6TqklTZgGG4Ae8gMkjwsq9m30HvzEOi
         x9+WcqG9GeDEpNgL+v+fcQoczkDelZyX5odfgpuIGp3SvtNXSiWvuKnJ4vyPECjR5EkZ
         gNjL445JgnESKZhYei6760zFI8e6DmyAimhxt2Zt6hC/laJQmxfzPun7ZI0BFbfCytGe
         V7adc3YmA9G7+Yu5Y02LxzKv3e7nwcMhFQAxy9zQmZbPhMPw8+MQNELCat0kWHuMrMkJ
         n39qDd6ZzK/wzBNimdlOs6yPMOTWB1Bn3mgO/4UM73sgl6MbMNw2sh0Tp6GGvcXbf9au
         ysMg==
X-Gm-Message-State: AC+VfDxxdd7jYRzRU45vtJnx0Rvrkv7rPF/bZ98DsQGIWXzZLw1J41eG
        YJPW2E6wVOGyLNftR1LDmQ00hHzs8bFNSC8YPFTsnw==
X-Google-Smtp-Source: ACHHUZ72Zw3GmxCRU2ZaY86LgkadjB4mn+Ucm1AlZWq3wRc03x5tQHjXd5p53hpYmdX5ou16duANvsOJUXYCZ5d/6Is=
X-Received: by 2002:a05:622a:19a0:b0:3ef:31a5:13c with SMTP id
 u32-20020a05622a19a000b003ef31a5013cmr76533qtc.3.1683825039339; Thu, 11 May
 2023 10:10:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230508020801.10702-1-cathy.zhang@intel.com> <20230508020801.10702-2-cathy.zhang@intel.com>
 <3887b08ac0e55e27a24d2f66afcfff1961ed9b13.camel@redhat.com>
 <CH3PR11MB73459006FCE3887E1EA3B82FFC769@CH3PR11MB7345.namprd11.prod.outlook.com>
 <CH3PR11MB73456D792EC6E7614E2EF14DFC769@CH3PR11MB7345.namprd11.prod.outlook.com>
 <CANn89iL6Ckuu9vOEvc7A9CBLGuh-EpbwFRxRAchV-6VFyhTUpg@mail.gmail.com>
 <CH3PR11MB73458BB403D537CFA96FD8DDFC769@CH3PR11MB7345.namprd11.prod.outlook.com>
 <CANn89iJvpgXTwGEiXAkFwY3j3RqVhNzJ_6_zmuRb4w7rUA_8Ug@mail.gmail.com>
 <CALvZod6JRuWHftDcH0uw00v=yi_6BKspGCkDA4AbmzLHaLi2Fg@mail.gmail.com>
 <CH3PR11MB7345ABB947E183AFB7C18322FC779@CH3PR11MB7345.namprd11.prod.outlook.com>
 <CANn89i+9rQcGey+AJyhR02pTTBNhWN+P78e4a8knfC9F5sx0hQ@mail.gmail.com>
 <CH3PR11MB73455A98A232920B322C3976FC779@CH3PR11MB7345.namprd11.prod.outlook.com>
 <CANn89i+J+ciJGPkWAFKDwhzJERFJr9_2Or=ehpwSTYO14qzHmA@mail.gmail.com>
 <CH3PR11MB734502756F495CB9C520494FFC779@CH3PR11MB7345.namprd11.prod.outlook.com>
 <CALvZod4n+Kwa1sOV9jxiEMTUoO7MaCGWz=wT3MHOuj4t-+9S6Q@mail.gmail.com>
 <CH3PR11MB73454C44EC8BCD43685BCB58FC749@CH3PR11MB7345.namprd11.prod.outlook.com>
 <IA0PR11MB7355E486112E922AA6095CCCFC749@IA0PR11MB7355.namprd11.prod.outlook.com>
 <CANn89iJbAGnZd42SVZEYWFLYVbmHM3p2UDawUKxUBhVDH5A2=A@mail.gmail.com>
 <IA0PR11MB73557DEAB912737FD61D2873FC749@IA0PR11MB7355.namprd11.prod.outlook.com>
 <CALvZod7Y+SxiopRBXOf1HoDKO=Xh8CNPfgz3Etd4XOq5BPc5Ag@mail.gmail.com> <CANn89iKoB2hn8QKBw+8faL4MWZ1ByDW8T9UHyS9G-8c11mWdOw@mail.gmail.com>
In-Reply-To: <CANn89iKoB2hn8QKBw+8faL4MWZ1ByDW8T9UHyS9G-8c11mWdOw@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 11 May 2023 10:10:28 -0700
Message-ID: <CALvZod5sbwXYqPZavojs1cvspxZv1iFHBG8=LQGNodinLXVL=w@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] net: Keep sk->sk_forward_alloc as a proper size
To:     Eric Dumazet <edumazet@google.com>
Cc:     "Zhang, Cathy" <cathy.zhang@intel.com>,
        Linux MM <linux-mm@kvack.org>,
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

On Thu, May 11, 2023 at 9:35=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
[...]
>
> The suspect part is really:
>
> >      8.98%  mc-worker        [kernel.vmlinux]          [k] page_counter=
_cancel
> >             |
> >              --8.97%--page_counter_cancel
> >                        |
> >                         --8.97%--page_counter_uncharge
> >                                   drain_stock
> >                                   __refill_stock
> >                                   refill_stock
> >                                   |
> >                                    --8.91%--try_charge_memcg
> >                                              mem_cgroup_charge_skmem
> >                                              |
> >                                               --8.91%--__sk_mem_raise_a=
llocated
> >                                                         __sk_mem_schedu=
le
>
> Shakeel, networking has a per-cpu cache, of +/- 1MB.
>
> Even with asymmetric alloc/free, this would mean that a 100Gbit NIC
> would require something like 25,000
> operations on the shared cache line per second.
>
> Hardly an issue I think.
>
> memcg does not seem to have an equivalent strategy ?

memcg has +256KiB per-cpu cache (note the absence of '-'). However it
seems like Cathy already tested with 4MiB (1024 page batch) which is
comparable to networking per-cpu cache (i.e. 2MiB window) and still
see the issue. Additionally this is a single machine test (no NIC),
so, I am kind of contemplating between (1) this is not real world
workload and thus ignore or (2) implement asymmetric charge/uncharge
strategy for memcg.
