Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B5C75BA8E
	for <lists+cgroups@lfdr.de>; Fri, 21 Jul 2023 00:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjGTWYm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Jul 2023 18:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjGTWYk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Jul 2023 18:24:40 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B3BE44
        for <cgroups@vger.kernel.org>; Thu, 20 Jul 2023 15:24:38 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-991da766865so206427066b.0
        for <cgroups@vger.kernel.org>; Thu, 20 Jul 2023 15:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689891877; x=1690496677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G0owsP3MW0e32jBov7KLN+DK+7a5lEoZ//WqOCREwlQ=;
        b=jd6zJsXD5mYj6yvKRyJH5NBquT74jAAnKJcxJxjtVugZ74xdKdKUA/Xqh2qycTBeFg
         vPln7NlfYVWD/ksCNMT/BFt0LQbv78OLE46EKPak+6l1I1wQxZ8TsalyBCa4/uy2UGfP
         4bQUMBpcGL0kubjXSaUgnImEDhLu8s2ELtZbAO8Vj9SBPIax+YSn04fWP2IBG5Yylr5X
         8aFVUOFXvi3d0ege/03nCH4/jH9luNjJE8Hnq5/xwKNoEVplwnFF+7KsZF2+GABq1CH7
         V2lajH7+XWj4nEhKf6uxSpT0wIJZS55VBvNUUqvbp2iLZnQ3ETD0dgV6lA42DVvyjOE4
         /+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689891877; x=1690496677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G0owsP3MW0e32jBov7KLN+DK+7a5lEoZ//WqOCREwlQ=;
        b=f4PTCVR+0uC/4VqqJahd6wz/wUL4IiAyu5LtFD7U3DQYwIjHjtwX7i2tgm0k/9+szD
         kT5ChmhzH3pj7TH18GF/5kpvois07k6wr/QPZkBVoAS2Dq/FApoWMn8vDVBllyk14yIj
         BWTfZTFoOqeF3upm1gxcJs+LrL2IFJAxjHMkz8WKoIuqywRGYeFN9AFFaYvbrAoSdCCV
         f61BeR6IHeB4CnaNVr2kXft+4YUSPsUxU3SmD67xFcI4YjZvMugtlEKUa8X09R6QcB5F
         DZswg9A2Gmg24onNu++rm/y3LSozvB7S9VQ0Rsy9/4ZPGvpyBfnJLY6XJZtDP2bq54T4
         yo7g==
X-Gm-Message-State: ABy/qLZuDX1fRUi3b+ZRpBL2h6P4x/lL7FKEdUwM3mQbM/zTn6pYLsu8
        jZSKkNbrxB5eI+2zxFg4QsiWbO6NXP67cVC9a1Av8A==
X-Google-Smtp-Source: APBJJlGt5Dh/Vk/Hz8mmwcC6oq1uWZMyrPxtTI1+hvyrsTrR/mlI9dY1NvhlUCmg8KdNdNHw1ubChfd1KYDcCxGTRH4=
X-Received: by 2002:a17:907:7810:b0:993:f2b4:13c9 with SMTP id
 la16-20020a170907781000b00993f2b413c9mr78921ejc.21.1689891876705; Thu, 20 Jul
 2023 15:24:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230720070825.992023-1-yosryahmed@google.com>
 <20230720153515.GA1003248@cmpxchg.org> <ZLmRlTej8Tm82kXG@slm.duckdns.org>
 <CAJD7tkYhu3g9u7HkUTFBtT3Q4edVZ2g1TWV1FDcyM9srrYCBLg@mail.gmail.com> <ZLmxLUNdxMi5s2Kq@slm.duckdns.org>
In-Reply-To: <ZLmxLUNdxMi5s2Kq@slm.duckdns.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 20 Jul 2023 15:23:59 -0700
Message-ID: <CAJD7tkZKo_oSZ-mQc-knMELP8kiY1N7taQhdV6tPsqN0tg=gog@mail.gmail.com>
Subject: Re: [RFC PATCH 0/8] memory recharging for offline memcgs
To:     Tejun Heo <tj@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Yu Zhao <yuzhao@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "T.J. Mercier" <tjmercier@google.com>,
        Greg Thelen <gthelen@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jul 20, 2023 at 3:12=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Thu, Jul 20, 2023 at 02:34:16PM -0700, Yosry Ahmed wrote:
> > > Or just create a nesting layer so that there's a cgroup which represe=
nts the
> > > persistent resources and a nested cgroup instance inside representing=
 the
> > > current instance.
> >
> > In practice it is not easy to know exactly which resources are shared
> > and used by which cgroups, especially in a large dynamic environment.
>
> Yeah, that only covers when resource persistence is confined in a known
> scope. That said, I have a hard time seeing how recharding once after cgr=
oup
> destruction can be a solution for the situations you describe. What if A
> touches it once first, B constantly uses it but C only very occasionally =
and
> after A dies C ends up owning it due to timing. This is very much possibl=
e
> in a large dynamic environment but neither the initial or final situation=
 is
> satisfactory.

That is indeed possible, but it would be more likely that the charge
is moved to B. As I said, it's not perfect, but it is an improvement
over what we have today. Even if C ends up owning it, it's better than
staying with the dead A.

>
> To solve the problems you're describing, you actually would have to
> guarantee that memory pages are charged to the current majority user (or
> maybe even spread across current active users). Maybe it can be argued th=
at
> this is a step towards that but it's a very partial step and at least wou=
ld
> need a technically viable direction that this development can follow.

Right, that would be a much larger effort (arguably memcg v3 ;) ).
This proposal is focused on the painful artifact of the sharing/sticky
resources problem: zombie memcgs. We can extend the automatic charge
movement semantics later to cover more cases or be smarter, or ditch
the existing charging semantics completely and start over with
sharing/stickiness in mind. Either way, that would be a long-term
effort. There is a problem that exists today though that ideally can
be fixed/improved by this proposal.

>
> On its own, AFAICS, I'm not sure the scope of problems it can actually so=
lve
> is justifiably greater than what can be achieved with simple nesting.

In our use case nesting is not a viable option. As I said, in a large
fleet where a lot of different workloads are dynamically being
scheduled on different machines, and where there is no way of knowing
what resources are being shared among what workloads, and even if we
do, it wouldn't be constant, it's very difficult to construct the
hierarchy with nesting to keep the resources confined.

Keep in mind that the environment is dynamic, workloads are constantly
coming and going. Even if find the perfect nesting to appropriately
scope resources, some rescheduling may render the hierarchy obsolete
and require us to start over.

>
> Thanks.
>
> --
> tejun
