Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05AE875D61C
	for <lists+cgroups@lfdr.de>; Fri, 21 Jul 2023 23:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjGUVAg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 21 Jul 2023 17:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjGUVAf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 21 Jul 2023 17:00:35 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B11D30E1
        for <cgroups@vger.kernel.org>; Fri, 21 Jul 2023 14:00:33 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-993d1f899d7so374081566b.2
        for <cgroups@vger.kernel.org>; Fri, 21 Jul 2023 14:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689973232; x=1690578032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JOgbHJec+Tti6Wru7OdTqH4+oMnk38DLOG9c4qJJzP8=;
        b=hkZ+D5g5lDrDl4A690EnFIQrEBWzd57RPaM7SaKw8Y1xk7u1cAMRN4ld2mJkGcGqTY
         /owNQyHKnflgKZIMZHrBc4AfSR3tYOaMOz+dYxvCdQz1ey2+U9QmjTviN0Qum0KxXOdw
         8SFQWbBe/mtcxHqLJFyQClCzU3YhFgrJb03GP0qsdY0KqtaR9x7Hx4Kq9tfA6JVlHuMC
         ypntCYhcJXE3lxIkq+N9LeOkrGyUDm31Kih652QMPZI12bzYmDTEAxVdi1OIoHwEX4uX
         mQtgA1yxQCz6Ur0+IYN0S57Jk3wDnFBAsv0rrUdhewR+YipnqPXBqEiLqMAQS7fN91mG
         kzeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689973232; x=1690578032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JOgbHJec+Tti6Wru7OdTqH4+oMnk38DLOG9c4qJJzP8=;
        b=hvJQqdtg8FihN0Cq+TqeIJBHlVatyDZN6AkJBg5ZFs5zRSNamhNEEpqZ1/IQ9OBse1
         yeQtrde+rA6jHeYQopXteKiGCcYXtCLPTK0fvRMdIqz9l904DO7QBO42FP+GIndELpVh
         cxSM/p3WSqcFR7bfU2wLoIGHp5TopUOXs9zkMXnDsX2kKU8twV8tEFhkHDL2zgiZ41WX
         PuwQuI74YLFkBxTEIFxPB1D9ZBcTeGaHlLd4n3JVit++5XKQJkpEIicA4FhTCYShawmQ
         VCHs1q5t4bz95ofGmwtwc8P6/iT39r7enPwT4XyInYWIFPhcxXhJ+vsGrKmwIbqcwqIZ
         oXEw==
X-Gm-Message-State: ABy/qLYqKbJXklrcSKFR1IHOU8cB+3NXcSLBV/uPEW1NNXxrId1JF5Rf
        Gr2VVOq6VcD3zmuguB7/tHS8HbzUyMwe+Dk65igcXQ==
X-Google-Smtp-Source: APBJJlF4w7IolAQjvFt45KYghjPLjVomuKrZ2Ype4QjwYKABfJu98+K6+QIzMGKxUWt/Is9nh3WdSTiYhrlnIY4617k=
X-Received: by 2002:a17:906:101a:b0:98d:cd3e:c193 with SMTP id
 26-20020a170906101a00b0098dcd3ec193mr2203336ejm.46.1689973231695; Fri, 21 Jul
 2023 14:00:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230720070825.992023-1-yosryahmed@google.com>
 <20230720153515.GA1003248@cmpxchg.org> <ZLmRlTej8Tm82kXG@slm.duckdns.org>
 <CAJD7tkYhu3g9u7HkUTFBtT3Q4edVZ2g1TWV1FDcyM9srrYCBLg@mail.gmail.com>
 <ZLmxLUNdxMi5s2Kq@slm.duckdns.org> <CAJD7tkZKo_oSZ-mQc-knMELP8kiY1N7taQhdV6tPsqN0tg=gog@mail.gmail.com>
 <ZLm1ptOYH6F8fGHT@slm.duckdns.org> <CAJD7tkbDxw-hqG8i85NhnjxmXFMbR5OaSW5dHDVYfdA=ZnPAEw@mail.gmail.com>
 <ZLrN1BE42Tsybm6j@slm.duckdns.org> <CAJD7tkatz1JhKVj_iP9J0H7fPJnUSurZkCT1iJTJ=+qRen_nLQ@mail.gmail.com>
 <20230721204408.GA1033322@cmpxchg.org>
In-Reply-To: <20230721204408.GA1033322@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 21 Jul 2023 13:59:55 -0700
Message-ID: <CAJD7tkaro0opThQaMTFr_8sAjiFFEsaZK9YzEjBaSiDJ93DOBg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/8] memory recharging for offline memcgs
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Tejun Heo <tj@kernel.org>,
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

On Fri, Jul 21, 2023 at 1:44=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Fri, Jul 21, 2023 at 11:47:49AM -0700, Yosry Ahmed wrote:
> > On Fri, Jul 21, 2023 at 11:26=E2=80=AFAM Tejun Heo <tj@kernel.org> wrot=
e:
> > >
> > > Hello,
> > >
> > > On Fri, Jul 21, 2023 at 11:15:21AM -0700, Yosry Ahmed wrote:
> > > > On Thu, Jul 20, 2023 at 3:31=E2=80=AFPM Tejun Heo <tj@kernel.org> w=
rote:
> > > > > memory at least in our case. The sharing across them comes down t=
o things
> > > > > like some common library pages which don't really account for muc=
h these
> > > > > days.
> > > >
> > > > Keep in mind that even a single page charged to a memcg and used by
> > > > another memcg is sufficient to result in a zombie memcg.
> > >
> > > I mean, yeah, that's a separate issue or rather a subset which isn't =
all
> > > that controversial. That can be deterministically solved by reparenti=
ng to
> > > the parent like how slab is handled. I think the "deterministic" part=
 is
> > > important here. As you said, even a single page can pin a dying cgrou=
p.
> >
> > There are serious flaws with reparenting that I mentioned above. We do
> > it for kernel memory, but that's because we really have no other
> > choice. Oftentimes the memory is not reclaimable and we cannot find an
> > owner for it. This doesn't mean it's the right answer for user memory.
> >
> > The semantics are new compared to normal charging (as opposed to
> > recharging, as I explain below). There is an extra layer of
> > indirection that we did not (as far as I know) measure the impact of.
> > Parents end up with pages that they never used and we have no
> > observability into where it came from. Most importantly, over time
> > user memory will keep accumulating at the root, reducing the accuracy
> > and usefulness of accounting, effectively an accounting leak and
> > reduction of capacity. Memory that is not attributed to any user, aka
> > system overhead.
>
> Reparenting has been the behavior since the first iteration of cgroups
> in the kernel. The initial implementation would loop over the LRUs and
> reparent pages synchronously during rmdir. This had some locking
> issues, so we switched to the current implementation of just leaving
> the zombie memcg behind but neutralizing its controls.

Thanks for the context.

>
> Thanks to Roman's objcg abstraction, we can now go back to the old
> implementation of directly moving pages up to avoid the zombies.
>
> However, these were pure implementation changes. The user-visible
> semantics never varied: when you delete a cgroup, any leftover
> resources are subject to control by the remaining parent cgroups.
> Don't remove control domains if you still need to control resources.
> But none of this is new or would change in any way!

The problem is that you cannot fully monitor or control all the
resources charged to a control domain. The example of common shared
libraries stands, the pages are charged on first touch basis. You
can't easily control it or monitor who is charged for what exactly.
Even if you can find out, is the answer to leave the cgroup alive
forever because it is charged for a shared resource?

> Neutralizing
> controls of a zombie cgroup results in the same behavior and
> accounting as linking the pages to the parent cgroup's LRU!
>
> The only thing that's new is the zombie cgroups. We can fix that by
> effectively going back to the earlier implementation, but thanks to
> objcg without the locking problems.
>
> I just wanted to address this, because your description/framing of
> reparenting strikes me as quite wrong.

Thanks for the context, and sorry if my framing was inaccurate. I was
more focused on the in-kernel semantics rather than user-visible
semantics. Nonetheless, with today's status or with reparenting, once
the memory is at the root level (whether reparented to the root level,
or in a zombie memcg whose parent is root), the memory has effectively
escaped accounting. This is not a new problem that reparenting would
introduce, but it's a problem that recharging is trying to fix that
reparenting won't.

As I outlined above, the semantics of recharging are not new, they are
equivalent to reclaiming and refaulting the memory in a more
accelerated/efficient manner. The indeterminism in recharging is very
similar to reclaiming and refaulting.

What do you think?
