Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2EB75D182
	for <lists+cgroups@lfdr.de>; Fri, 21 Jul 2023 20:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjGUSsa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 21 Jul 2023 14:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGUSs3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 21 Jul 2023 14:48:29 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9A830CF
        for <cgroups@vger.kernel.org>; Fri, 21 Jul 2023 11:48:27 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-992acf67388so328636966b.1
        for <cgroups@vger.kernel.org>; Fri, 21 Jul 2023 11:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689965306; x=1690570106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tdq/W+QGmbFYjBwzec6GU8stgr9jLA3Mk5O05X2GOvY=;
        b=muASEYnZmQZKBYoEZ0S4+U/aJoPH1HHib/qcQHHw3GxE+05UEBQofzyZMM6Atdd0Yg
         iVLuraXsAfHkF8ldSyV7GfVUX31oAUm34s0teCQepYf7rLqtpiA01nCnVOn2tnrj5CMm
         DUDokWhrZG8N240U4zghZjjxw/sQCIjjLknPmfGDFbpXzSUo2nvgHzuSyz/ChM3q8GBV
         wN+s0L2B2DYK5k8ZNnOaM244w71qa8p2Y2ok7OcD0cAHzY4tiZj8X4C/GvGWN+udQars
         ksS0fIcBPzTY8ecxgk9/+GpHK3lU5nZ1X/ZDddKSqb0cEmI0D8W+SPo2QIKCxHMQwhot
         bxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689965306; x=1690570106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tdq/W+QGmbFYjBwzec6GU8stgr9jLA3Mk5O05X2GOvY=;
        b=hZ+XHvjatWMQgtLhnHk6n2/wWCUgkJXluN6NKyiwFipuTpQYkDa5Wh2Q9dFu8/J8Ur
         Fnv9Q1YSf9vKXiyerHXM0QQvnekyIu6rTozRbvi+mSRL0DQNenfePrDXW7fAzISp5X8N
         xG8FBQrUr7clAP0cObeTx45QlFW3YS3tslUNm1Q/gEoKrHuDzoT7Nyn8sSJEdPhnxE8+
         jJKpD5ximi+kKSKTA2rpbxl9uzhMq0BukSo91mwNYupugvmVr344ZuHeiq7tWRXRJgxV
         cb+awQ1Ee+0UqlmUhMUe7oDKRYyeRa0+hQjkg4kYAQQzpIOqeiFKjXmcWjB2+Xn4o9Ij
         Tdiw==
X-Gm-Message-State: ABy/qLbIZgPhDboQJNwuqooPr4rpNXvZ3+H2RVw6zIB+dN7sCJ2wuE8B
        cBGwTr3GWTbqWMPghexPowP586pxtKJrb14WDMYf8A==
X-Google-Smtp-Source: APBJJlGonDSO5Pgyd78wlklAx5E2nmQGEM/OjC4MyYifHtkvMGDRyiZyaRq3AzCZntGuE6DWdJYmCOroguJM1d7muI4=
X-Received: by 2002:a17:906:5190:b0:991:37d2:c9ea with SMTP id
 y16-20020a170906519000b0099137d2c9eamr2384811ejk.6.1689965306141; Fri, 21 Jul
 2023 11:48:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230720070825.992023-1-yosryahmed@google.com>
 <20230720153515.GA1003248@cmpxchg.org> <ZLmRlTej8Tm82kXG@slm.duckdns.org>
 <CAJD7tkYhu3g9u7HkUTFBtT3Q4edVZ2g1TWV1FDcyM9srrYCBLg@mail.gmail.com>
 <ZLmxLUNdxMi5s2Kq@slm.duckdns.org> <CAJD7tkZKo_oSZ-mQc-knMELP8kiY1N7taQhdV6tPsqN0tg=gog@mail.gmail.com>
 <ZLm1ptOYH6F8fGHT@slm.duckdns.org> <CAJD7tkbDxw-hqG8i85NhnjxmXFMbR5OaSW5dHDVYfdA=ZnPAEw@mail.gmail.com>
 <ZLrN1BE42Tsybm6j@slm.duckdns.org>
In-Reply-To: <ZLrN1BE42Tsybm6j@slm.duckdns.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 21 Jul 2023 11:47:49 -0700
Message-ID: <CAJD7tkatz1JhKVj_iP9J0H7fPJnUSurZkCT1iJTJ=+qRen_nLQ@mail.gmail.com>
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jul 21, 2023 at 11:26=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Fri, Jul 21, 2023 at 11:15:21AM -0700, Yosry Ahmed wrote:
> > On Thu, Jul 20, 2023 at 3:31=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote=
:
> > > memory at least in our case. The sharing across them comes down to th=
ings
> > > like some common library pages which don't really account for much th=
ese
> > > days.
> >
> > Keep in mind that even a single page charged to a memcg and used by
> > another memcg is sufficient to result in a zombie memcg.
>
> I mean, yeah, that's a separate issue or rather a subset which isn't all
> that controversial. That can be deterministically solved by reparenting t=
o
> the parent like how slab is handled. I think the "deterministic" part is
> important here. As you said, even a single page can pin a dying cgroup.

There are serious flaws with reparenting that I mentioned above. We do
it for kernel memory, but that's because we really have no other
choice. Oftentimes the memory is not reclaimable and we cannot find an
owner for it. This doesn't mean it's the right answer for user memory.

The semantics are new compared to normal charging (as opposed to
recharging, as I explain below). There is an extra layer of
indirection that we did not (as far as I know) measure the impact of.
Parents end up with pages that they never used and we have no
observability into where it came from. Most importantly, over time
user memory will keep accumulating at the root, reducing the accuracy
and usefulness of accounting, effectively an accounting leak and
reduction of capacity. Memory that is not attributed to any user, aka
system overhead.

>
> > > > Keep in mind that the environment is dynamic, workloads are constan=
tly
> > > > coming and going. Even if find the perfect nesting to appropriately
> > > > scope resources, some rescheduling may render the hierarchy obsolet=
e
> > > > and require us to start over.
> > >
> > > Can you please go into more details on how much memory is shared for =
what
> > > across unrelated dynamic workloads? That sounds different from other =
use
> > > cases.
> >
> > I am trying to collect more information from our fleet, but the
> > application restarting in a different cgroup is not what is happening
> > in our case. It is not easy to find out exactly what is going on on
>
> This is the point that Johannes raised but I don't think the current
> proposal would make things more deterministic. From what I can see, it
> actually pushes it towards even less predictability. Currently, yeah, som=
e
> pages may end up in cgroups which aren't the majority user but it at leas=
t
> is clear how that would happen. The proposed change adds layers of
> indeterministic behaviors on top. I don't think that's the direction we w=
ant
> to go.

I believe recharging is being mis-framed here :)

Recharging semantics are not new, it is a shortcut to a process that
is already happening that is focused on offline memcgs. Let's take a
step back.

It is common practice (at least in my knowledge) to try to reclaim
memory from a cgroup before deleting it (by lowering the limit or
using memory.reclaim). Reclaim heuristics are biased towards
reclaiming memory from offline cgroups. After the memory is reclaimed,
if it is used again by a different process, it will be refaulted and
charged again (aka recharged) to the new

What recharging is doing is *not* anything new. It is effectively
doing what reclaim + refault would do above, with an efficient
shortcut. It avoids the unnecessary fault, avoids disrupting the
workload that will access the memory after it is reclaimed, and cleans
up zombie memcgs memory faster than reclaim would. Moreover, it works
for memory that may not be reclaimable (e.g. because of lack of swap).

All the indeterministic behaviors in recharging are exactly the
indeterministic behaviors in reclaim. It is very similar. We iterate
the lrus, try to isolate and lock folios, etc. This is what reclaim
does. Recharging is basically lightweight reclaim + charging again (as
opposed to fully reclaiming the memory then refaulting it).

We are not introducing new indeterminism or charging semantics.
Recharging does exactly what would happen when we reclaim zombie
memory. It is just more efficient and accelerated.

>
> > machines and where the memory is coming from due to the
> > indeterministic nature of charging. The goal of this proposal is to
> > let the kernel handle leftover memory in zombie memcgs because it is
> > not always obvious to userspace what's going on (like it's not obvious
> > to me now where exactly is the sharing happening :) ).
> >
> > One thing to note is that in some cases, maybe a userspace bug or
> > failed cleanup is a reason for the zombie memcgs. Ideally, this
> > wouldn't happen, but it would be nice to have a fallback mechanism in
> > the kernel if it does.
>
> I'm not disagreeing on that. Our handling of pages owned by dying cgroups
> isn't great but I don't think the proposed change is an acceptable soluti=
on.

 I hope the above arguments change your mind :)

>
> Thanks.
>
> --
> tejun
