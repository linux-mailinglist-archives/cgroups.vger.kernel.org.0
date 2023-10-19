Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915587CFFB3
	for <lists+cgroups@lfdr.de>; Thu, 19 Oct 2023 18:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbjJSQhA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 Oct 2023 12:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbjJSQhA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 Oct 2023 12:37:00 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84F811D
        for <cgroups@vger.kernel.org>; Thu, 19 Oct 2023 09:36:56 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c9b70b9671so190585ad.1
        for <cgroups@vger.kernel.org>; Thu, 19 Oct 2023 09:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697733416; x=1698338216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqqnclXhs4cCCpvokt/fb4m7AIKZQCSfSgxNcK5aM1A=;
        b=LHu0fzukgKPo24/oc0yX2NCiExJAPYBy6/lFDfsEEsjpIStwwqa04pe05GWXwXx8/H
         cWpGo3+DMI4uwG77/biwTDw/JujFNihdv3BRgE/NulE5fL/xfAL9UYCWQBdklCxWmliF
         W2cqOp2Eu6kjZc5fG/VEsS5jk4ghZlScE1u+j+pE56eYR7bvpOWXUaDjRllmWUyTG4+r
         jpBQXRINEN/uCSxN/qNmqZ71WHx1UcaWviHJbucof3TbmY7mnweXkpGQ+TcbMYF5H1tz
         eslpulBHVDPL802dtaQgdXpmvqgBBbPct1484nNZyI3PdcUJZJqjWl99VzSqTinmzqFZ
         Q10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697733416; x=1698338216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GqqnclXhs4cCCpvokt/fb4m7AIKZQCSfSgxNcK5aM1A=;
        b=Y1dl3WSGJAg3ILeVHBDXtUbaipS7IAoZb9C/8NqHzbcLA5rB/9tBkU58S/neq0M+DS
         XdVrVuIqFdQy6jDdBlH2UMpj3YnthDLtbGKowzfh6Y/y1FeAxloLGhPw3Xm1wht3GBIt
         ZdwX4BvEqYVeIOH1xw0FTygV3P45CXwkQazPKcJAyC/FYHzNVjTa+qBa5Fe7jUxtEBpA
         2Gle8PDYSEfTAKMw/IcCiIULn9n2Bs8shkiG3ky+vrQaxFhPgsseUsl6/BO/tj7BfS1e
         PrXmaKjyGQFQOwJPvAv6rWsdRsBIo6f9IVj1zmLUDGaADPH1vJMu4fQn5NE+62VEuOQY
         9mYg==
X-Gm-Message-State: AOJu0YxUahMeu0bxQoVkHbFgrW/JljOpRzHHn599rRXwIu637dnlqEfw
        JKiByyE4uzw668dmZWbl4yoa+PWtwyFNv79qmH5EMQ==
X-Google-Smtp-Source: AGHT+IF/FmgwwkFbueug0gQ/QNGZWgBxC0LpJY/aTW6J9U5PxSjbKAZRbNoGEm/tgIvlcnrLa8B3geAueo0mvnPzK2k=
X-Received: by 2002:a17:903:2410:b0:1c1:efe5:cce5 with SMTP id
 e16-20020a170903241000b001c1efe5cce5mr222146plo.3.1697733415932; Thu, 19 Oct
 2023 09:36:55 -0700 (PDT)
MIME-Version: 1.0
References: <20231016221900.4031141-1-roman.gushchin@linux.dev>
 <20231016221900.4031141-3-roman.gushchin@linux.dev> <d698b8d0-1697-e336-bccb-592e633e8b98@suse.cz>
 <ZTAUTWO2UfI0VoPL@P9FQF9L96D.corp.robot.car> <CALvZod6mb91o9pW57suovtW1UQ8G8j=2S3Tjoqzjh6L+jqz-EQ@mail.gmail.com>
 <ZTBeRu3iDu7nnPV8@P9FQF9L96D.corp.robot.car>
In-Reply-To: <ZTBeRu3iDu7nnPV8@P9FQF9L96D.corp.robot.car>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 19 Oct 2023 09:36:44 -0700
Message-ID: <CALvZod5kXRY0LV6VOnctTYVhdHu+=yqzsQzKYa2_6_Jg+cOWfQ@mail.gmail.com>
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

On Wed, Oct 18, 2023 at 3:38=E2=80=AFPM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> On Wed, Oct 18, 2023 at 11:26:59AM -0700, Shakeel Butt wrote:
> > On Wed, Oct 18, 2023 at 10:22=E2=80=AFAM Roman Gushchin
> > <roman.gushchin@linux.dev> wrote:
> > >
> > [...]
> > > > >     struct mem_cgroup *memcg;
> > > > > @@ -3008,19 +3054,26 @@ __always_inline struct obj_cgroup *get_ob=
j_cgroup_from_current(void)
> > > > >
> > > > >     if (in_task()) {
> > > > >             memcg =3D current->active_memcg;
> > > > > +           if (unlikely(memcg))
> > > > > +                   goto from_memcg;
> > > > >
> > > > > -           /* Memcg to charge can't be determined. */
> > > > > -           if (likely(!memcg) && (!current->mm || (current->flag=
s & PF_KTHREAD)))
> > > >
> > > > The checks for current->mm and PF_KTHREAD seem to be gone completel=
y after
> > > > the patch, was that intended and why?
> > >
> > > There is no need for those anymore because it's as cheap or cheaper
> > > to check task->objcg for being NULL. Those were primarily used to rul=
e out
> > > kernel threads allocations early.
> > >
> >
> > I have the same understanding but please correct my suspicions here.
> > We can echo the kernel thread's pid to cgroup.procs which have
> > PF_NO_SETAFFINITY and thus this will cause the lower bit of the kernel
> > thread's task->objcg to be set. Please correct me if I am missing
> > something.
>
> Yes, you seem to be right. It's a gray zone because moving kernel threads=
 out of
> the root cgroup doesn't sound like a good idea, but I agree it's better t=
o keep
> the old behavior in place.
>
> Does this fixlet look good to you?
>

This looks fine. Another option is not to set the bit for such
task_structs in fork/attach.

> Thanks!
>
> --
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 1a2835448028..0b0d2dc7a7d4 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3021,6 +3021,10 @@ static struct obj_cgroup *current_objcg_update(voi=
d)
>                         old =3D NULL;
>                 }
>
> +               /* If new objcg is NULL, no reason for the second atomic =
update. */
> +               if (!current->mm || (current->flags & PF_KTHREAD))
> +                       return NULL;
> +
>                 /*
>                  * Release the objcg pointer from the previous iteration,
>                  * if try_cmpxcg() below fails.
