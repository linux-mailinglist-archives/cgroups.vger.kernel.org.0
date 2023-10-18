Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81427CE662
	for <lists+cgroups@lfdr.de>; Wed, 18 Oct 2023 20:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjJRS1O (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 Oct 2023 14:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbjJRS1N (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 Oct 2023 14:27:13 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3542DB8
        for <cgroups@vger.kernel.org>; Wed, 18 Oct 2023 11:27:12 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c9b70b9671so23925ad.1
        for <cgroups@vger.kernel.org>; Wed, 18 Oct 2023 11:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697653631; x=1698258431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hlieo0CTFrM7Na+ZxI5QTbegm2CDw0kaZO/6xR1apSU=;
        b=xmB6dLpm0MgQpZ23pZsYeRPqGkKu+2OfpCLrhxIebqwTMtZq4cUqdJfJDZIzYguy0N
         p6HqDk5Z+S9FQplhWKhOFfRrVqUVk7iSE8IwlNZ8A0MGQWAr4c79efmg+onMGuliGU8c
         5wH7pF2robHCkDdjU199vhLBIsImIi4dCZAs8VvVLXvCsdkPhBvWpAsIg8rLcvbbveA0
         I9yvquP7yntk0VrC8kPJb+zdVnga62z3wlNPN+N3Vc0K/83kIsscYtTVLtsqT36pnzLi
         GQaCfNeUD1WSt6Cn9wIFFyVdeLL88HhuNjogyBhmmHHplWG4ezTbuFYssUC52HT5Cd6f
         74aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697653631; x=1698258431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hlieo0CTFrM7Na+ZxI5QTbegm2CDw0kaZO/6xR1apSU=;
        b=TnodAtGp3ydNT4h4kBYJ7LmVhUIFnmhl6kxYLNHWe9qQw8MfvY6Gic+sITdEQRcXNN
         vl5euxtUZKtcD7pwc+aVrFI5wQeVQ86/al2havud0ZmQ6yJjLZehkLA8lys1reQ8OjSp
         tVv8mC+YBABgKmehfDvURqnch7W2v6yimfVLW1e9nm6NlO8fUI89Sc1HyB18YZCK5e7z
         294/kWQjKo57oqI7qG8Ll80Bqzc4xM9Fe9tiTc55U6MwkMZDSG0xcYv0MmYE9ezxahRX
         xwOQhZ1lb2oG6A4Q0A2xW2mDFQaGaQEfIHF0S2zzDWb9YRCC7PJH3eHHMOXuZUgYUs5b
         8bgw==
X-Gm-Message-State: AOJu0YyTgu/Zp6aoGXkmVyvdLSsHMKclL0Zm0RlbjywOMJ1WQ7GW56Mv
        dogkhf7ICPIqses06md6HTm8E1xGFT/aW+dQ2P2mCw==
X-Google-Smtp-Source: AGHT+IGr+BupUybpCw/OV6q+gABdroNjrSy7V7BpYDzIqP5xfyWOuRD8pQE0EwqCeUvkwLgaB+qu7nPt0CSfo/0irdE=
X-Received: by 2002:a17:902:ebc4:b0:1ca:887f:b257 with SMTP id
 p4-20020a170902ebc400b001ca887fb257mr35972plg.22.1697653631150; Wed, 18 Oct
 2023 11:27:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231016221900.4031141-1-roman.gushchin@linux.dev>
 <20231016221900.4031141-3-roman.gushchin@linux.dev> <d698b8d0-1697-e336-bccb-592e633e8b98@suse.cz>
 <ZTAUTWO2UfI0VoPL@P9FQF9L96D.corp.robot.car>
In-Reply-To: <ZTAUTWO2UfI0VoPL@P9FQF9L96D.corp.robot.car>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 18 Oct 2023 11:26:59 -0700
Message-ID: <CALvZod6mb91o9pW57suovtW1UQ8G8j=2S3Tjoqzjh6L+jqz-EQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] mm: kmem: add direct objcg pointer to task_struct
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Dennis Zhou <dennis@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Oct 18, 2023 at 10:22=E2=80=AFAM Roman Gushchin
<roman.gushchin@linux.dev> wrote:
>
[...]
> > >     struct mem_cgroup *memcg;
> > > @@ -3008,19 +3054,26 @@ __always_inline struct obj_cgroup *get_obj_cg=
roup_from_current(void)
> > >
> > >     if (in_task()) {
> > >             memcg =3D current->active_memcg;
> > > +           if (unlikely(memcg))
> > > +                   goto from_memcg;
> > >
> > > -           /* Memcg to charge can't be determined. */
> > > -           if (likely(!memcg) && (!current->mm || (current->flags & =
PF_KTHREAD)))
> >
> > The checks for current->mm and PF_KTHREAD seem to be gone completely af=
ter
> > the patch, was that intended and why?
>
> There is no need for those anymore because it's as cheap or cheaper
> to check task->objcg for being NULL. Those were primarily used to rule ou=
t
> kernel threads allocations early.
>

I have the same understanding but please correct my suspicions here.
We can echo the kernel thread's pid to cgroup.procs which have
PF_NO_SETAFFINITY and thus this will cause the lower bit of the kernel
thread's task->objcg to be set. Please correct me if I am missing
something.
