Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1684575BB1D
	for <lists+cgroups@lfdr.de>; Fri, 21 Jul 2023 01:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjGTXY5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Jul 2023 19:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGTXY4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Jul 2023 19:24:56 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C9930CF
        for <cgroups@vger.kernel.org>; Thu, 20 Jul 2023 16:24:28 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5838881e30bso6903887b3.2
        for <cgroups@vger.kernel.org>; Thu, 20 Jul 2023 16:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689895454; x=1690500254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wla3efE6JyGPdqvNC8P15XtJgOh6q0zRuJGb6WkYFkU=;
        b=ZyqL/pfs56dYsjzgW1sC88OX6ea1yYxnkLNnDI3qkpD1FfBIuqlzveXINQdKsv5k/L
         b2hWGu0BSe43eg7hgztFXLBLiWGR5sElL2WlIU8IWQba5lCaD4QHi2h585ZS79ells+d
         EyYJPYuffXS94IYaIaFx2HapRRKi7Fq8ooPOzLLb2POx0evTUdrmNqgOETvS6AbjTz7Z
         c7qnuP55qbCcv2pgvn6TUwH+46rb4fwqMSdQUAgZYHLo13hDnxfK38H5hjC2TMZl6ldF
         /QRVPbyCjd+D1wZv8SxRGevdUw+z00sMJyXtuRO414Fp54C7WEsXKxMEiB2sLuiW18fE
         uFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689895454; x=1690500254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wla3efE6JyGPdqvNC8P15XtJgOh6q0zRuJGb6WkYFkU=;
        b=fHLRzrMB7hrsZxXXRZxrL6Fq8V9tGH4CDRp+iLGWqrOuZ6W6l6B+A1AkFYEVYenJ8/
         sBBet/kWUyMBRlj+pXIOi3XWfKTbebPk+UEAYUXnhLQC4WJTqoPP5u7Un/FL8grvcZoJ
         9AYGBZ4VSCGYNWoCFrLyvs8cWtQAGp5ttIMVEl5EXX+TE6fDmCQtVCiL8aQRlXMaWzqW
         f05bj4gQ7ErR8T2hBhzdJKIO3cH5Yza8v2EHmGkb7gjNeyYZGDE/MEPZHjPDFXbmeWZ/
         VsuH+0wVngIO+oCMbr1WxIrbOeSWAufYYoYUuNmMk2WmHELvYHAAV+ihteWndmM4sXiU
         1pXQ==
X-Gm-Message-State: ABy/qLakcGBsva1lneAZA1RWOO5rXKtADnRpvHeVtsIuVvxGSaHCSxVR
        Xyq06g3TFDnJiwaAi5yREJnQVWxqdq5L/b+Pwej6+g==
X-Google-Smtp-Source: APBJJlGnGQ0f1m/FIydRTzO3jhn9Rx7MtlEgLX6UdsXfRcxJ/oxbgTesXn/E/6PLQeCPvA1stBZ+aWU7XnVi8GNA2B0=
X-Received: by 2002:a0d:d646:0:b0:565:9fc7:9330 with SMTP id
 y67-20020a0dd646000000b005659fc79330mr530144ywd.17.1689895454153; Thu, 20 Jul
 2023 16:24:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230720070825.992023-1-yosryahmed@google.com>
 <20230720153515.GA1003248@cmpxchg.org> <ZLmRlTej8Tm82kXG@slm.duckdns.org>
 <CAJD7tkYhu3g9u7HkUTFBtT3Q4edVZ2g1TWV1FDcyM9srrYCBLg@mail.gmail.com>
 <ZLmxLUNdxMi5s2Kq@slm.duckdns.org> <CAJD7tkZKo_oSZ-mQc-knMELP8kiY1N7taQhdV6tPsqN0tg=gog@mail.gmail.com>
 <ZLm1ptOYH6F8fGHT@slm.duckdns.org>
In-Reply-To: <ZLm1ptOYH6F8fGHT@slm.duckdns.org>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Thu, 20 Jul 2023 16:24:02 -0700
Message-ID: <CABdmKX0JETkXpOSfCUZ3jaZv1JxRzbTP+Se4i3HMKjP3PNZ8Qg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/8] memory recharging for offline memcgs
To:     Tejun Heo <tj@kernel.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
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
        Greg Thelen <gthelen@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
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
> memory at least in our case. The sharing across them comes down to things
> like some common library pages which don't really account for much these
> days.
>
This has also been my experience in terms of bytes of memory that are
incorrectly charged (because they're charged to a zombie), but that is
because memcg doesn't currently track the large shared allocations in
my case (primarily dma-buf). The greater issue I've seen so far is the
number of zombie cgroups that can accumulate over time. But my
understanding is that both of these two problems are currently
significant for Yosry's case.
