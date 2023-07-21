Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDFE75D5CF
	for <lists+cgroups@lfdr.de>; Fri, 21 Jul 2023 22:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjGUUid (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 21 Jul 2023 16:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjGUUic (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 21 Jul 2023 16:38:32 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19DA30CD
        for <cgroups@vger.kernel.org>; Fri, 21 Jul 2023 13:38:30 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b741cf99f8so34866351fa.0
        for <cgroups@vger.kernel.org>; Fri, 21 Jul 2023 13:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689971909; x=1690576709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yqqIc7aKNfw1AoPDdLMW6uHAgEFbeLCdE9gekNCu4dY=;
        b=M/PwwIqI59V50uzvt0exFtHh9+yRnpOV1yb2n5IU96sD6sldNtKBmNPYO+aHgO07Sb
         9jxNL6fK/OGgQ+Nh+P56c1euonksbQhgybBOHA7Rplm/n5/IFxA4zLPt1mGySMyBnYwZ
         jlgMgx+dT6k+FMwUybQym0muhy75No4ejRKBBACIufTDrlz6/Wsv5UN0OL4RBdyKJC0z
         XC/pXE+u8YkaDalg91bDHSSiGXSLSLTaXuESKBZz6zRPH3venAKSPcgd4rZzxlvkg3jY
         A8LVQuSoFpwcZGKVXTIZ79wNQBazMi0skVxBTJLXLIiMClvnWpbFykCgt9TT6omOMOCr
         dlqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689971909; x=1690576709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yqqIc7aKNfw1AoPDdLMW6uHAgEFbeLCdE9gekNCu4dY=;
        b=aqF+aSBu9cJ5CQLXp6PSxGsw0kO9MTo9HWg2Xxt97DOg/kRl1wfsribbpcrWjSBsuc
         fzUQ8gdzfUHWhg1fo9urvvxEhdkGhflglfuSLczY+IrK7kBG5e3QSIxW5/yOGYVRi0ij
         PPbwK9z0fg4Ny1G8ugfeZ9slL7qUWR5lSWa+Lbz+kK+hFuXWy+i8zBgzgHqB5HCb7eM4
         0OCT07DxHSXc5P5CwnW6x7axQCraJrqMuYODvz5Ql51Zfyo9FsXQMeNsR+geFRhUsocm
         s0dAO+LM2xE7eKI/7cwqxg95GGou13piMQoU+KQLW0PRw9uQZpl+2qFAAUWuhVQNH343
         +O5A==
X-Gm-Message-State: ABy/qLZecXXoiRrHsUGa8qlArTjwnTcEKv1Vo8MRr9YEz/HoMhiSHfvB
        kjHWwdMMJVu+oISbQLPFy28Io4WLU0NR3wgS404Vrw==
X-Google-Smtp-Source: APBJJlEKAhPfAVWaggCbBnSyJjA2ZL1NgNR2Ang7ODcqkT009b4F67kvSoLTY8HTXJaOoOOSbAvW10RcsU7EJ9N7bFk=
X-Received: by 2002:a2e:9dd3:0:b0:2b6:d8cf:2f44 with SMTP id
 x19-20020a2e9dd3000000b002b6d8cf2f44mr2086475ljj.13.1689971908448; Fri, 21
 Jul 2023 13:38:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230720070825.992023-1-yosryahmed@google.com>
 <20230720153515.GA1003248@cmpxchg.org> <ZLmRlTej8Tm82kXG@slm.duckdns.org>
 <CAJD7tkYhu3g9u7HkUTFBtT3Q4edVZ2g1TWV1FDcyM9srrYCBLg@mail.gmail.com>
 <ZLmxLUNdxMi5s2Kq@slm.duckdns.org> <CAJD7tkZKo_oSZ-mQc-knMELP8kiY1N7taQhdV6tPsqN0tg=gog@mail.gmail.com>
 <ZLm1ptOYH6F8fGHT@slm.duckdns.org> <CAJD7tkbDxw-hqG8i85NhnjxmXFMbR5OaSW5dHDVYfdA=ZnPAEw@mail.gmail.com>
 <ZLrN1BE42Tsybm6j@slm.duckdns.org> <CAJD7tkatz1JhKVj_iP9J0H7fPJnUSurZkCT1iJTJ=+qRen_nLQ@mail.gmail.com>
 <ZLraAD0F-McgdJNv@slm.duckdns.org>
In-Reply-To: <ZLraAD0F-McgdJNv@slm.duckdns.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 21 Jul 2023 13:37:51 -0700
Message-ID: <CAJD7tkZmjVLN0ih3CJFJto8Zvfeb-4+A_9DJpC+iWzVw-Z9yag@mail.gmail.com>
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

On Fri, Jul 21, 2023 at 12:18=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Fri, Jul 21, 2023 at 11:47:49AM -0700, Yosry Ahmed wrote:
> > On Fri, Jul 21, 2023 at 11:26=E2=80=AFAM Tejun Heo <tj@kernel.org> wrot=
e:
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
> That really sounds like the setup is missing cgroup layers tracking
> persistent resources. Most of the problems you describe can be solved by
> adding cgroup layers at the right spots which would usually align with th=
e
> logical structure of the system, right?

It is difficult to track down all persistent/shareable resources and
find the users, especially when both the resources and the users are
dynamically changed. A simple example is text files for a shared
library or sidecar processes that run with different workloads and
need to have their usage charged to the workload, but they may have
memory. For those cases there is no layering that would work. More
practically, sometimes userspace just doesn't even know what exactly
is being shared by whom.

>
> ...
> > I believe recharging is being mis-framed here :)
> >
> > Recharging semantics are not new, it is a shortcut to a process that
> > is already happening that is focused on offline memcgs. Let's take a
> > step back.
>
> Yeah, it does sound better when viewed that way. I'm still not sure what
> extra problems it solves tho. We experienced similar problems but AFAIK a=
ll
> of them came down to needing the appropriate hierarchical structure to
> capture how resources are being used on systems.

It solves the problem of zombie memcgs and unaccounted memory. It is
great that in some cases an appropriate hierarchy structure fixes the
problem by accurately capturing how resources are being shared, but in
some cases it's not as straightforward. Recharging attempts to fix the
problem in a way that is more consistent with current semantics and
more appealing that reparenting in terms of rightful ownership.

Some systems are not rebooted for months. Can you imagine how much
memory can be accumulated at the root (escaping all accounting) over
months of reparenting?

>
> Thanks.
>
> --
> tejun
