Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA1A763AEA
	for <lists+cgroups@lfdr.de>; Wed, 26 Jul 2023 17:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbjGZPYL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Jul 2023 11:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234826AbjGZPYJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Jul 2023 11:24:09 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FAF2119
        for <cgroups@vger.kernel.org>; Wed, 26 Jul 2023 08:24:07 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b962c226ceso100940691fa.3
        for <cgroups@vger.kernel.org>; Wed, 26 Jul 2023 08:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690385045; x=1690989845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58XKjPnpcFetGx5j3YOj8ywrrvgND/+/csGew57bsKg=;
        b=OlqpMj+GOS6ZN29CPLOgmWPUTKJLvmKWzkTTSdYpl46AgLMkxw8fOF+mtvOAo6uKGw
         BU1mIXEbmud8kylbCkDkljLAe+cEFLqct3ZmildAwKoGHvviUlWbWr+Y0MvgAvdo0GCm
         IFWkLuTqknhFTwZsZU80GeZNh1HZKFFYudgvxei7dSa6G8pi7JG4cbAdq9DX7RjhOjIS
         8OKqAgPf23lAp6Z9r1I32Xl2sCvNHyxhfmhDHLByuBwju6fPvKtB8zl9D9phh8q/TsPS
         duXmA+dpyypvPqf7Uk44/0skEuLF0fYkSrd0i9D/anETUf4RnkyPK3vyujElRaqdoAaN
         7q2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690385045; x=1690989845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=58XKjPnpcFetGx5j3YOj8ywrrvgND/+/csGew57bsKg=;
        b=ekYPADbSaYvdG1iqAOW9ulx0WZ5g2Pr1nrBpWdI6nh7JrIb93Wqe1dm9n7YJ8izkWd
         ROrTMsyA5zlFcCN6RNJhIwL50ioKCjSx+J/Jaw/RXExK3cKHNfk6SbECVrDbja5t5DUU
         IwKdvfLCQJuRLJn+E7/7f4Q0KT6Q1jykUeBzuvTqx+T83MJkeikPwxv5YwAKRqBi0TA2
         1rMMwreZJP3TofYxtd10tpqTNcLeCVK6yMRuqPowjWwfys+y2jfeNYoydSqpUAmAjd4b
         0LSq4j0vxch5ARjAiUUmN0AkMgAppZjWOvYkWjUJg8mbgDwl+GpvPhIh4PyzAfaOFpH4
         k2fA==
X-Gm-Message-State: ABy/qLbnTV3vMujD9tTgkXunNCMnhqy2ulZNl6p7JYobAakDtM40SybZ
        w5fGvfmRhO5pUOp05r5nqWrnMN1sGj2z4HrN2hpCFA==
X-Google-Smtp-Source: APBJJlH6LRLHMYyUPxbbdYvBigh0lZYZNWQkOWBwTlewLNCo9+ByxiwgI6ui0oTlneWmcU3cOv+tL80ENg/9TN3zB+o=
X-Received: by 2002:a2e:7a19:0:b0:2b9:4841:9652 with SMTP id
 v25-20020a2e7a19000000b002b948419652mr1723353ljc.25.1690385044959; Wed, 26
 Jul 2023 08:24:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230726002904.655377-1-yosryahmed@google.com>
 <20230726002904.655377-2-yosryahmed@google.com> <ZMCBzUH7qIdc3Y2X@P9FQF9L96D>
 <CAJD7tkZDpni+VM61i-jUgvn=TkZ5CySotTmUAFQPwMSjDfOEWQ@mail.gmail.com> <20230726152055.GC1365610@cmpxchg.org>
In-Reply-To: <20230726152055.GC1365610@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 26 Jul 2023 08:23:28 -0700
Message-ID: <CAJD7tkb6SmCDLDSCciPfXGK7Z_zyr4vh_XKvhysL6pci88WjKw@mail.gmail.com>
Subject: Re: [PATCH v2] mm: memcg: use rstat for non-hierarchical stats
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
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

On Wed, Jul 26, 2023 at 8:20=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Tue, Jul 25, 2023 at 07:20:02PM -0700, Yosry Ahmed wrote:
> > On Tue, Jul 25, 2023 at 7:15=E2=80=AFPM Roman Gushchin <roman.gushchin@=
linux.dev> wrote:
> > >
> > > On Wed, Jul 26, 2023 at 12:29:04AM +0000, Yosry Ahmed wrote:
> > > > Currently, memcg uses rstat to maintain hierarchical stats. Counter=
s are
> > > > maintained for hierarchical stats at each memcg. Rstat tracks which
> > > > cgroups have updates on which cpus to keep those counters fresh on =
the
> > > > read-side.
> > > >
> > > > For non-hierarchical stats, we do not maintain counters. Instead, t=
he
> > >                                                 global?
> >
> > Do you mean "we do not maintain global counters"? I think "global" is
> > confusing, because it can be thought of as all cpus or as including
> > the subtree (as opposed to local for non-hierarchical stats).
>
> "global" seems fine to me, I don't think it's ambiguous in the direct
> comparison with per-cpu counts.
>
> Alternatively, rephrase the whole thing? Something like:
>
> "Non-hierarchical stats are currently not covered by rstat. Their
> per-cpu counters are summed up on every read, which is expensive."

Rephrasing sounds good to me.

I will send a v3 with the correct commit log and collected Acks to
make Andrew's life easier.
