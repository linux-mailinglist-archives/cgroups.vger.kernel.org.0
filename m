Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77EA591EAF
	for <lists+cgroups@lfdr.de>; Sun, 14 Aug 2022 08:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbiHNGkp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 14 Aug 2022 02:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiHNGkn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 14 Aug 2022 02:40:43 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732651573D;
        Sat, 13 Aug 2022 23:40:42 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id s9so4763345ljs.6;
        Sat, 13 Aug 2022 23:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=CyJTphL+dowqwNK5AT5s9+PYVQShCGuXR38KvvcrDos=;
        b=hZuibKQ9GQ9lGafTbNrZ/rqY5/f4iR4IcFkTOOnLVcHcUj20yfLbNJHsYggQvhj7lN
         AN8BEd6N+U5YgKf6cFdJ97dpd24jyuDjA5kE3StIoK31ylf8x2kd9H6I9qC0gGk/3D9G
         M20ziGdUbisOzqTRF6AQZ7p+eBB3URegkCa7JH9/dJhIZgWfW9kcdYE21Hd3jxJ8iecH
         VIYzpBpecpV8cxDGrOjhuBcMS35KOhfAsuWqVoeUvdJMGKDNihimNHyjHAcEbgy0apXM
         Xx+nPGAZaepLiZPx23NIZa+eIvjQ/zst9wK+hYTMwqNAFZxAmkH6WjLKU3oDB+aTpgKE
         xU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=CyJTphL+dowqwNK5AT5s9+PYVQShCGuXR38KvvcrDos=;
        b=1hSixnYKFb1nhna4MPkZUQUP0DYr1oHI0RpeIAXf76VKz5CIf2xBUMJxBU7h5Uibeo
         3XQ8OzYKrzvspvKaXp2EIFFK2pVjB4ieYIdhlQ/IkFxK7JlOcnCNGs1T+IXE8/t9Kqjw
         Yp3j2bdDZuMqofWXZ6edvlDni8N6aH7TO7sgI+laSJGabhopuDP8T1U8GBqY2sNSlEQM
         D7Omo5vlo5vNPR4zw+ib5Ny6OK30g6szhYK14mqdIKjuhVGLXwMfe+bZ5uHct/TIuQd+
         7QLCx1W2u8MbBQ2YMCUa6WCHMCW5Jv4HY4UOrBOrgmczL44p6EfL1KQa+deN7Wk0UtWO
         o7NQ==
X-Gm-Message-State: ACgBeo2Rhc3BaECu0AMMDtgsvtIEpmM5U8LwP2a9i9mQmm+Cs61sUu+u
        UjCIxak1QTFzpUP/ZQ0IklWPyzpFi8cyJCa6sw4=
X-Google-Smtp-Source: AA6agR4sIe3yhKo2TACoEX3N1vMlxyH8ULFL/jfEj0EQKw8c44poJ1mssAYPJIN5NL8aiK84U4iSrDx9jg6QNJu4sFA=
X-Received: by 2002:a2e:beaa:0:b0:25e:34d0:4d57 with SMTP id
 a42-20020a2ebeaa000000b0025e34d04d57mr3257817ljr.329.1660459240608; Sat, 13
 Aug 2022 23:40:40 -0700 (PDT)
MIME-Version: 1.0
References: <1660298966-11493-1-git-send-email-zhaoyang.huang@unisoc.com> <YvakpukeF9d35Bc8@slm.duckdns.org>
In-Reply-To: <YvakpukeF9d35Bc8@slm.duckdns.org>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Sun, 14 Aug 2022 14:40:27 +0800
Message-ID: <CAGWkznG6n=+v7hUKR8Rmg8VEF=BTDegk8bh6aHfvOU5TbmeXDw@mail.gmail.com>
Subject: Re: [RFC PATCH] cgroup: use root_mem_cgroup as css when current is
 not enabled
To:     Tejun Heo <tj@kernel.org>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        Ke Wang <ke.wang@unisoc.com>,
        Zefan Li <lizefan.x@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Aug 13, 2022 at 3:06 AM Tejun Heo <tj@kernel.org> wrote:
>
> On Fri, Aug 12, 2022 at 06:09:26PM +0800, zhaoyang.huang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > Memory charged on group B abserved on belowing v2 hierarchy where we just would
> > like to only have group E's memory be controlled and B's descendants compete freely
> > for memory. This should be the consequences of unified hierarchy. Solve this by
> > have the cgroup without valid memory css alloced use root_mem_cgroup instead of
> > its ancestor's.
> >
> >  A(subtree_control = memory) - B(subtree_control = NULL) - C()
> >                                                          \ D()
> >                            - E(subtree_control = memory) - F()
> >                                                          \ G()
> >
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > ---
> >  kernel/cgroup/cgroup.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> > index 1779ccd..b29b3f6 100644
> > --- a/kernel/cgroup/cgroup.c
> > +++ b/kernel/cgroup/cgroup.c
> > @@ -533,6 +533,14 @@ static struct cgroup_subsys_state *cgroup_e_css_by_mask(struct cgroup *cgrp,
> >        * can't test the csses directly.  Test ss_mask.
> >        */
> >       while (!(cgroup_ss_mask(cgrp) & (1 << ss->id))) {
> > +             /*
> > +              * charging to the parent cgroup which hasn't distribute
> > +              * memory control to its descendants doesn't make sense
> > +              * especially on cgroup v2, where the parent could be configured
> > +              * to use memory controller as its sibling want to use it
> > +              */
> > +             if (memory_cgrp_id == ss->id)
> > +                     return &root_mem_cgroup->css;
>
> This is gonna be a hard nack. A given cgroup always encompasses all the
> resources consumed in its self-including subtree.
>
> Thanks.
IMHO, I would like to say if it makes more sense as "A given cgroup
always encompasses all the resources consumed in its ENABLED
self-including subtree." Otherwise, how should I couple with the
scenarios I raised in the commit message which I prefer parts of the
subtrees compete for "memory" while others are free for it. The free
here is not only without "min/low/high watermarks" but also not
charged to their own LRU.
>
> --
> tejun
