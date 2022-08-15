Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE38592C18
	for <lists+cgroups@lfdr.de>; Mon, 15 Aug 2022 12:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240849AbiHOJRd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Aug 2022 05:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbiHOJRV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 15 Aug 2022 05:17:21 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AF122528;
        Mon, 15 Aug 2022 02:17:17 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id d14so9835379lfl.13;
        Mon, 15 Aug 2022 02:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=eiqkvF+xYiNF2DpRXQeLPgqIYFAmFLS0V8w6NeOkAps=;
        b=nLzwUzH1mFhYYOp7STOZsHfn7f2SW3Gl6xJ8vP+9vPX2YAZB2C6OlzaSKAeYnmAQv1
         1PdjeD/WpfSf7CrTfALpgrSOS4Z5IcOcuc/ZJTLrj+ypqyWlP8AusY08hpNwC6czmjy0
         zc3VJeNGhdWq/xRoIuGB7Kygb2vskfasVGLXx0rbvEwJgKMLskTKjBNlQ388bRI6Mpcf
         RvjU2kUboC2pvVZnkXL00TmNZnpEmLvxb59g9DI9T5v/teeX3DQaOM+ybyPGLI1qOL7l
         Ys5Ddw4/L4rYxBm9Vvmxcq23T86HxaW/lYWcHNVjV0cjAhfpCGgmjCbWXyayuOFE9Om/
         oqWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=eiqkvF+xYiNF2DpRXQeLPgqIYFAmFLS0V8w6NeOkAps=;
        b=nCz0ovPiC8u3aMwwcLR9eiegH+kRAWzmqzTr+zvOppZUqgG0Z4qDNpG8j6ahVJ9d6Q
         Z4itMMY/N1wu0xKxK8Q68t7iVVWwkTxv0pPZokRenzk6eMa8Vjvhdv9FkSK4DPon71SK
         Ydspf3lCeh9Chb91nWxUoK49m/UFER4zdu4Cf8PREJDxbaKnQCFYlL9jV8X3zYPkvjqk
         3mXqR0fL5UAnQLmOHaPxyOWw/RxbhwCJ6StVP00bffkx3dQOXCC/jzE+q0CAY+mN41kJ
         qh9UJ4lhUODH/YQWwSm8vjOXpf9mQM+D0aUgN6nUwUGsy6DUKJ0tsmWafn+UUbGS6uDf
         R8dw==
X-Gm-Message-State: ACgBeo1FcuAdcwZXVKzdgSrPF44ZT0Qp2vsmtz3RVD7/aUBc8U8/FuYr
        Ji/rtghYLE77Hng4G2QKtaqEO0t+W+8XYFJgQAM=
X-Google-Smtp-Source: AA6agR6NRl73OVz82MXGLJl9DCyFw+Kd1gGiZOJDreYij/FP+Eg+bC+4oLHzg/8uCquuCYWlmwyz99uA1rF3z7USpMI=
X-Received: by 2002:ac2:4e4f:0:b0:48c:e6b6:9d7e with SMTP id
 f15-20020ac24e4f000000b0048ce6b69d7emr4850618lfr.128.1660555035731; Mon, 15
 Aug 2022 02:17:15 -0700 (PDT)
MIME-Version: 1.0
References: <1660298966-11493-1-git-send-email-zhaoyang.huang@unisoc.com>
 <YvakpukeF9d35Bc8@slm.duckdns.org> <CAGWkznG6n=+v7hUKR8Rmg8VEF=BTDegk8bh6aHfvOU5TbmeXDw@mail.gmail.com>
 <CAGWkznHa9WTV2oK=HB1OVEdKeMZ1V2omDDiNrRdyBdyYd=q5Fg@mail.gmail.com>
In-Reply-To: <CAGWkznHa9WTV2oK=HB1OVEdKeMZ1V2omDDiNrRdyBdyYd=q5Fg@mail.gmail.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Mon, 15 Aug 2022 17:17:03 +0800
Message-ID: <CAGWkznEQ_njmNt8usr-DyaiYDAHJE-niC2QxoXPQkDqY7v_Mqg@mail.gmail.com>
Subject: Re: [RFC PATCH] cgroup: use root_mem_cgroup as css when current is
 not enabled
To:     Tejun Heo <tj@kernel.org>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        Ke Wang <ke.wang@unisoc.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Suren Baghdasaryan <surenb@google.com>
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

On Mon, Aug 15, 2022 at 9:38 AM Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
>
> On Sun, Aug 14, 2022 at 2:40 PM Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
> >
> > On Sat, Aug 13, 2022 at 3:06 AM Tejun Heo <tj@kernel.org> wrote:
> > >
> > > On Fri, Aug 12, 2022 at 06:09:26PM +0800, zhaoyang.huang wrote:
> > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > >
> > > > Memory charged on group B abserved on belowing v2 hierarchy where we just would
> > > > like to only have group E's memory be controlled and B's descendants compete freely
> > > > for memory. This should be the consequences of unified hierarchy. Solve this by
> > > > have the cgroup without valid memory css alloced use root_mem_cgroup instead of
> > > > its ancestor's.
> > > >
> > > >  A(subtree_control = memory) - B(subtree_control = NULL) - C()
> > > >                                                          \ D()
> > > >                            - E(subtree_control = memory) - F()
> > > >                                                          \ G()
> > > >
> > > > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > > ---
> > > >  kernel/cgroup/cgroup.c | 8 ++++++++
> > > >  1 file changed, 8 insertions(+)
> > > >
> > > > diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> > > > index 1779ccd..b29b3f6 100644
> > > > --- a/kernel/cgroup/cgroup.c
> > > > +++ b/kernel/cgroup/cgroup.c
> > > > @@ -533,6 +533,14 @@ static struct cgroup_subsys_state *cgroup_e_css_by_mask(struct cgroup *cgrp,
> > > >        * can't test the csses directly.  Test ss_mask.
> > > >        */
> > > >       while (!(cgroup_ss_mask(cgrp) & (1 << ss->id))) {
> > > > +             /*
> > > > +              * charging to the parent cgroup which hasn't distribute
> > > > +              * memory control to its descendants doesn't make sense
> > > > +              * especially on cgroup v2, where the parent could be configured
> > > > +              * to use memory controller as its sibling want to use it
> > > > +              */
> > > > +             if (memory_cgrp_id == ss->id)
> > > > +                     return &root_mem_cgroup->css;
> > >
> > > This is gonna be a hard nack. A given cgroup always encompasses all the
> > > resources consumed in its self-including subtree.
> > >
> > > Thanks.
> > IMHO, I would like to say if it makes more sense as "A given cgroup
> > always encompasses all the resources consumed in its ENABLED
> > self-including subtree." Otherwise, how should I couple with the
> > scenarios I raised in the commit message which I prefer parts of the
> > subtrees compete for "memory" while others are free for it. The free
> > here is not only without "min/low/high watermarks" but also not
> > charged to their own LRU.
> I would like to state more why these make sense. Memory cgroup is a
> little bit different to other cgroups, that is, memcg will have real
> physical resources attached, say pages. From perspective of memory
> reclaiming, it is odd to find that pages under free memcgs are charged
> to separate LRUs but without any management(no watermark control) and
> perhaps affect workingset mechanism by LRU reason. Furthermore, v2
> should grant the groups with the right to reject the subsys which
> introduced by sibling enable, which could be deemed as v2's
> inconvenient. The memcg could also apply subtree_control to enroll all
> memory back whenever it want.
As suggested by zefan, raise the practical scenario here to make more
sense. The issue is observed in android system where per-app cgroup is
demanded by freezer subsys and part of them require memory control.
Under this scenario, less efficient memory reclaim is observed when
comparing with no memory control. It is believed that multi LRU
scanning introduces some of the overhead. Furthermore, page thrashing
is also heavier than global LRU which could be the consequences of
partial failure of WORKINGSET mechanism as LRU is too short to protect
the active pages.
> > >
> > > --
> > > tejun
