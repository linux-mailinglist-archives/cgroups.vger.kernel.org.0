Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB2F75D127
	for <lists+cgroups@lfdr.de>; Fri, 21 Jul 2023 20:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjGUSQC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 21 Jul 2023 14:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjGUSQB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 21 Jul 2023 14:16:01 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3595F2D46
        for <cgroups@vger.kernel.org>; Fri, 21 Jul 2023 11:16:00 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51e5d9e20ecso2945973a12.1
        for <cgroups@vger.kernel.org>; Fri, 21 Jul 2023 11:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689963358; x=1690568158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DbiSd66ZEYldEsKq2+kLG6VPo4CXuGCRaRM8MBpM8Ys=;
        b=7lthhZbiCbAg+8o7AWikQQeL7kc0nK7f0kSWrhFn+Uk3O4d+QHm5apyHLvYunpj5Pr
         RT6vE4go1HnVactpi+4QeK+kPu/SMjinRiATW2sJCLQzw5Nwog0ZWpAgYDsAy33HI/m9
         t8lsH3NVAvbwFbHzm6HFxPs52tx2wFKqLNgkmafOp2a7eZT2yceiH2jhPAM0TSj3al2E
         Xa4Md8rmmxAqFLCkAuEX+fMciv6rc+BqzH11Z7U2nMhd/9rS0t+SWXuURLmd+OpIdDKK
         LSGcvacvyOvoBQE9AWYKNfbH6guORoZCjXpkjdSVZfrrJnkNbVk+9912cpmwvziVB108
         EKmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689963358; x=1690568158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DbiSd66ZEYldEsKq2+kLG6VPo4CXuGCRaRM8MBpM8Ys=;
        b=kgzdm+/ywDNfCAbBo47Lvw9MPabrO/6ghFjnj3QGyiFA6St4pkRUMxSr1MJ1hwpDLp
         QlUCRU3l8z0XaVzS59OnO+5A329wqV0L9pMn5YdayH+X4FjRWKRHO2oclK1Q9sTyyVQc
         y16gz+OXPX83l86NsUnNjcPUXFWCCh8Pk3oPQq0zFn/582XA5sWTnHLVsP/P0cNzBRWB
         gUrhgb+fauAE8LPuRwObRQaFP4gCev+0rSSpN49RewRGBhvhMyNATb8lJz1RiOGyygC3
         u2EbVdg1Nc4o4X06l+3p0n+cK0VkeB5azVfiyRPvh1kJJq6VclpwTd61ooKif/LNFZTQ
         EfmQ==
X-Gm-Message-State: ABy/qLZXrxExzPmZmV+TegAcPZeIcUZ6zWbJSul+VuvpXpDf7oWHs9WD
        m3Cbhy8nF59o4s+y7ZS14ILW0iLkN1wLOMdPQwSguQ==
X-Google-Smtp-Source: APBJJlE0YQWV35vpnIjqp/yJezDDDTyo/tIBAhKWV7DXpD1A7PlLzFQVWIKwKl+Vbx/NFz6sHgYWxGgtvf2ju/G8KmI=
X-Received: by 2002:a17:907:7858:b0:98e:2097:f23e with SMTP id
 lb24-20020a170907785800b0098e2097f23emr1822114ejc.77.1689963358445; Fri, 21
 Jul 2023 11:15:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230720070825.992023-1-yosryahmed@google.com>
 <20230720153515.GA1003248@cmpxchg.org> <ZLmRlTej8Tm82kXG@slm.duckdns.org>
 <CAJD7tkYhu3g9u7HkUTFBtT3Q4edVZ2g1TWV1FDcyM9srrYCBLg@mail.gmail.com>
 <ZLmxLUNdxMi5s2Kq@slm.duckdns.org> <CAJD7tkZKo_oSZ-mQc-knMELP8kiY1N7taQhdV6tPsqN0tg=gog@mail.gmail.com>
 <ZLm1ptOYH6F8fGHT@slm.duckdns.org>
In-Reply-To: <ZLm1ptOYH6F8fGHT@slm.duckdns.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 21 Jul 2023 11:15:21 -0700
Message-ID: <CAJD7tkbDxw-hqG8i85NhnjxmXFMbR5OaSW5dHDVYfdA=ZnPAEw@mail.gmail.com>
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

On Thu, Jul 20, 2023 at 3:31=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Thu, Jul 20, 2023 at 03:23:59PM -0700, Yosry Ahmed wrote:
> > > On its own, AFAICS, I'm not sure the scope of problems it can actuall=
y solve
> > > is justifiably greater than what can be achieved with simple nesting.
> >
> > In our use case nesting is not a viable option. As I said, in a large
> > fleet where a lot of different workloads are dynamically being
> > scheduled on different machines, and where there is no way of knowing
> > what resources are being shared among what workloads, and even if we
> > do, it wouldn't be constant, it's very difficult to construct the
> > hierarchy with nesting to keep the resources confined.
>
> Hmm... so, usually, the problems we see are resources that are persistent
> across different instances of the same application as they may want to sh=
are
> large chunks of memory like on-memory cache. I get that machines get
> different dynamic jobs but unrelated jobs usually don't share huge amount=
 of

I am digging deeper to get more information for you. One thing I know
now is that different instances of the same job are contained within a
common parent, and we even use our previously proposed memcg=3D mount
option for tmpfs to charge their shared resources to a common parent.
So restarting tasks is not the problem we are seeing.

> memory at least in our case. The sharing across them comes down to things
> like some common library pages which don't really account for much these
> days.

Keep in mind that even a single page charged to a memcg and used by
another memcg is sufficient to result in a zombie memcg.

>
> > Keep in mind that the environment is dynamic, workloads are constantly
> > coming and going. Even if find the perfect nesting to appropriately
> > scope resources, some rescheduling may render the hierarchy obsolete
> > and require us to start over.
>
> Can you please go into more details on how much memory is shared for what
> across unrelated dynamic workloads? That sounds different from other use
> cases.

I am trying to collect more information from our fleet, but the
application restarting in a different cgroup is not what is happening
in our case. It is not easy to find out exactly what is going on on
machines and where the memory is coming from due to the
indeterministic nature of charging. The goal of this proposal is to
let the kernel handle leftover memory in zombie memcgs because it is
not always obvious to userspace what's going on (like it's not obvious
to me now where exactly is the sharing happening :) ).

One thing to note is that in some cases, maybe a userspace bug or
failed cleanup is a reason for the zombie memcgs. Ideally, this
wouldn't happen, but it would be nice to have a fallback mechanism in
the kernel if it does.

>
> Thanks.
>
> --
> tejun
