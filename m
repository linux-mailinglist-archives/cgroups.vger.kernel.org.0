Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E4675B6CA
	for <lists+cgroups@lfdr.de>; Thu, 20 Jul 2023 20:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjGTSbA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Jul 2023 14:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjGTSbA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Jul 2023 14:31:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3831E135;
        Thu, 20 Jul 2023 11:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=TVc0DH5y5ZMGm3BerZTpK/u+XD4hMTin0vDBzxNt6yk=; b=k0wUa4Bc0gX81i186z/h55eQuL
        vN2ed/onpM28iKxC4yEvpheHnOUG0NwZNNTD58Efa5NxWnv8JEi+GPkO0rBNzcOVbiOC0JDx4vExy
        62BA0UYuhCnDDXCUAcHUFoby7XFd5M9jWSdS9lfREMafDc3OHhgbMYx7lejYTutJ2gFH9OAkhkD2q
        Iex0W2rl79yFoa2zJp4tUDJuQY6KkxOA+6Q/NVHpzYBA8oL3jzUcj/YbCkwN9ejIWCcVMrHZOMy/e
        oILegG1jfTpeFUg80y2sMHbIdrvmHw5WpoMbIiyPvoeDu0hQru9bMv/Xx+SN3p+prtgLGa3MNUuJw
        4iYrGLKQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qMYQL-00Bu7e-1E;
        Thu, 20 Jul 2023 18:30:49 +0000
Date:   Thu, 20 Jul 2023 11:30:49 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Yosry Ahmed <yosryahmed@google.com>
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
Subject: Re: [RFC PATCH 7/8] memcg: add sysctl and config option to control
 memory recharging
Message-ID: <ZLl9WfMgZSeKtyX7@bombadil.infradead.org>
References: <20230720070825.992023-1-yosryahmed@google.com>
 <20230720070825.992023-8-yosryahmed@google.com>
 <ZLl5XA25BIlYyngD@bombadil.infradead.org>
 <CAJD7tkbsZ5rAn5nNUvhuN9uUb4qPcsGZ8pcwCHzbqbajXKP9=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkbsZ5rAn5nNUvhuN9uUb4qPcsGZ8pcwCHzbqbajXKP9=g@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jul 20, 2023 at 11:24:20AM -0700, Yosry Ahmed wrote:
> On Thu, Jul 20, 2023 at 11:13 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On Thu, Jul 20, 2023 at 07:08:24AM +0000, Yosry Ahmed wrote:
> > > Add a sysctl to enable/disable memory recharging for offline memcgs. Add
> > > a config option to control whether or not it is enabled by default.
> > >
> > > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > > ---
> > >  include/linux/memcontrol.h |  2 ++
> > >  kernel/sysctl.c            | 11 +++++++++++
> > >  mm/Kconfig                 | 12 ++++++++++++
> > >  mm/memcontrol.c            |  9 ++++++++-
> > >  4 files changed, 33 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > > index 59b653d4a76e..ae9f09ee90cb 100644
> > > --- a/include/linux/memcontrol.h
> > > +++ b/include/linux/memcontrol.h
> > > @@ -60,6 +60,8 @@ struct mem_cgroup_reclaim_cookie {
> > >
> > >  #ifdef CONFIG_MEMCG
> > >
> > > +extern int sysctl_recharge_offline_memcgs;
> > > +
> > >  #define MEM_CGROUP_ID_SHIFT  16
> > >  #define MEM_CGROUP_ID_MAX    USHRT_MAX
> > >
> > > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > > index 354a2d294f52..1735d1d95652 100644
> > > --- a/kernel/sysctl.c
> > > +++ b/kernel/sysctl.c
> > > @@ -2249,6 +2249,17 @@ static struct ctl_table vm_table[] = {
> > >               .extra2         = (void *)&mmap_rnd_compat_bits_max,
> > >       },
> > >  #endif
> > > +#ifdef CONFIG_MEMCG
> > > +     {
> > > +             .procname       = "recharge_offline_memcgs",
> > > +             .data           = &sysctl_recharge_offline_memcgs,
> > > +             .maxlen         = sizeof(sysctl_recharge_offline_memcgs),
> > > +             .mode           = 0644,
> > > +             .proc_handler   = proc_dointvec_minmax,
> > > +             .extra1         = SYSCTL_ZERO,
> > > +             .extra2         = SYSCTL_ONE,
> > > +     },
> > > +#endif /* CONFIG_MEMCG */
> > >       { }
> > >  };
> >
> > Please don't add any more sysctls to kernel/sysctl.c, git log that file
> > for a series of cleanups which show how to use your own and why we have
> > been doing that cleanup.
> 
> Thanks for pointing this out, I definitely missed it. Will do that in
> the next version. I guess this will also reduce the reviewer churn if
> I won't be touching kernel/sysctl.c?

Right, it means I don't have to care anymore about random sysctl knobs.
Let people knob it all up.

  Luis
