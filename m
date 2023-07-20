Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5062175B6B2
	for <lists+cgroups@lfdr.de>; Thu, 20 Jul 2023 20:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbjGTSZW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Jul 2023 14:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbjGTSZV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Jul 2023 14:25:21 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562F02736
        for <cgroups@vger.kernel.org>; Thu, 20 Jul 2023 11:24:59 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-986d8332f50so184166166b.0
        for <cgroups@vger.kernel.org>; Thu, 20 Jul 2023 11:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689877498; x=1690482298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WGZYDyMNM2urRP5vx8c4QdZu7AgAmPw6pFOTfwzWRZg=;
        b=mt1sBgB8r8M1WCu/khBK23vqsKmLfRnOL6qK7jQNjWuQznHO23Bay2e130cpCoAeEe
         73wl6cIlXIIHsARp6vmsbAgqU8tjbFsub99lKb6wOpa+2M7PaWHciatXeIKNUuKhG8Hq
         gvLVGkhokRJM843fQ4gfqbjq4sybR7Spbv7PsPcpms2MdS2TKW/uGAdo4EF3+79d+WGL
         FR5LA8exsfDUsRso36GvGWEESx7vwxbfo4RVNcEMX5czOJIcjwKxvMamEAV9G2TkUhul
         /2qFpAFCbsvjtw9NnwnnoXvY9OXP5eTbP3aC5STbEiXWIRUNvSN+B28jk9P5SDDLA9AR
         /NTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689877498; x=1690482298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WGZYDyMNM2urRP5vx8c4QdZu7AgAmPw6pFOTfwzWRZg=;
        b=SvIdS562pVUVQZtAQ/P7RU0ysfBGKPXvEHC95HqHazSUHZmWUUnUMunhz1k9y47Ilh
         5tZYDgPfS/KqrVp0Kk+m81lzwe9d+m6F9dDYFa5ak+yQPvTwqvnwKyntVoSG1hOTyDJB
         jNZQ16UvDI/fA3+Dk4N3tNO0tDdm/540yx86j4MG7xFSRGd9TO6jb29Dm1NOOxlauOe6
         bhb8ES9umDLsNnPF4ZyGYTQKwFU6Fu0SyizWJIdeTELAGzEvn1GNpS7Xf2rXmmkMbp94
         lcO5OkvttaAH/vMUib8VbCv+1jJngENGyy21KCAY7un2z897Vn+2+teMq9RfoJFzfNMq
         tqRg==
X-Gm-Message-State: ABy/qLZuCdzjFlAKBSCcBGOcytxnkqJl9Ht+ZFarWeh8psEWpahHN/iY
        0KjrZeFr7vu9LoNJlg0RqyM5cUl5hCOp6BDjR+uQZg==
X-Google-Smtp-Source: APBJJlGZb3WymIaX1uRXdrzpAriwl5oRaFaeofNe1umRFQSKMrse/fgm7TbBbCD9GqEa6VUNJPBZ4YV8vzmdo9H5tic=
X-Received: by 2002:a17:907:2716:b0:99b:499d:4635 with SMTP id
 w22-20020a170907271600b0099b499d4635mr2319758ejk.75.1689877497693; Thu, 20
 Jul 2023 11:24:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230720070825.992023-1-yosryahmed@google.com>
 <20230720070825.992023-8-yosryahmed@google.com> <ZLl5XA25BIlYyngD@bombadil.infradead.org>
In-Reply-To: <ZLl5XA25BIlYyngD@bombadil.infradead.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 20 Jul 2023 11:24:20 -0700
Message-ID: <CAJD7tkbsZ5rAn5nNUvhuN9uUb4qPcsGZ8pcwCHzbqbajXKP9=g@mail.gmail.com>
Subject: Re: [RFC PATCH 7/8] memcg: add sysctl and config option to control
 memory recharging
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Yu Zhao <yuzhao@google.com>, Kees Cook <keescook@chromium.org>,
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

On Thu, Jul 20, 2023 at 11:13=E2=80=AFAM Luis Chamberlain <mcgrof@kernel.or=
g> wrote:
>
> On Thu, Jul 20, 2023 at 07:08:24AM +0000, Yosry Ahmed wrote:
> > Add a sysctl to enable/disable memory recharging for offline memcgs. Ad=
d
> > a config option to control whether or not it is enabled by default.
> >
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > ---
> >  include/linux/memcontrol.h |  2 ++
> >  kernel/sysctl.c            | 11 +++++++++++
> >  mm/Kconfig                 | 12 ++++++++++++
> >  mm/memcontrol.c            |  9 ++++++++-
> >  4 files changed, 33 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 59b653d4a76e..ae9f09ee90cb 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -60,6 +60,8 @@ struct mem_cgroup_reclaim_cookie {
> >
> >  #ifdef CONFIG_MEMCG
> >
> > +extern int sysctl_recharge_offline_memcgs;
> > +
> >  #define MEM_CGROUP_ID_SHIFT  16
> >  #define MEM_CGROUP_ID_MAX    USHRT_MAX
> >
> > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > index 354a2d294f52..1735d1d95652 100644
> > --- a/kernel/sysctl.c
> > +++ b/kernel/sysctl.c
> > @@ -2249,6 +2249,17 @@ static struct ctl_table vm_table[] =3D {
> >               .extra2         =3D (void *)&mmap_rnd_compat_bits_max,
> >       },
> >  #endif
> > +#ifdef CONFIG_MEMCG
> > +     {
> > +             .procname       =3D "recharge_offline_memcgs",
> > +             .data           =3D &sysctl_recharge_offline_memcgs,
> > +             .maxlen         =3D sizeof(sysctl_recharge_offline_memcgs=
),
> > +             .mode           =3D 0644,
> > +             .proc_handler   =3D proc_dointvec_minmax,
> > +             .extra1         =3D SYSCTL_ZERO,
> > +             .extra2         =3D SYSCTL_ONE,
> > +     },
> > +#endif /* CONFIG_MEMCG */
> >       { }
> >  };
>
> Please don't add any more sysctls to kernel/sysctl.c, git log that file
> for a series of cleanups which show how to use your own and why we have
> been doing that cleanup.

Thanks for pointing this out, I definitely missed it. Will do that in
the next version. I guess this will also reduce the reviewer churn if
I won't be touching kernel/sysctl.c?

>
>   Luis
