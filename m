Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1555B592791
	for <lists+cgroups@lfdr.de>; Mon, 15 Aug 2022 03:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiHOBis (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 14 Aug 2022 21:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiHOBir (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 14 Aug 2022 21:38:47 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53489FD32;
        Sun, 14 Aug 2022 18:38:46 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id x19so8830412lfq.7;
        Sun, 14 Aug 2022 18:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=9aHT3s6PlkBrj5LRNetpZGsGEba9IDfVY1EAjlwcsW8=;
        b=pHO53OmNqii0/moX83i0+1sWFE6GT8/ScD9wvNikftUHCiM8G3IJbxKfBuT8ijqPDQ
         mjapnViqPOQI6PEe57J5EnZGFqSIChf0AW9v4hruwkBUvLm6kUgRTgWzDo6PFDiR48Lc
         h79XsbgD6ShEbfi0eszwno9VRLJPwk/CfwIuz6v4Ob76M/L4SW+am00vNGp/G6i1Mcu4
         Kdqsiemvzf7jpHYQofFMJX6ACxnrEK7xN1pfU8EGUqgonHB3GXJURJdvd/L6/ZB2c5sp
         raj2jPJjKtyttOVlQDgQ7joBVbhEFCIE0xoUW4xuujRLAeZHxT8ikYd9iTEM95dheU+X
         mrvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=9aHT3s6PlkBrj5LRNetpZGsGEba9IDfVY1EAjlwcsW8=;
        b=Xh9mcj5NCY6kQPtAZshSXetIVcjUE1Uxjek4mZfRSj99Jv1yKvEwnsgquNy5qZB94Y
         G3nc//bRcwLPieMViZZw+1WA10OE4KF11nw8A2ZX6erPO5xhawRTok1Lig3Ns0d0I2U4
         ngvIb6D/R3XbWKVTUWU+QfedVy4lZMv8GkEBl236ouRi8ZwkSTK9E5c6IRDOOcit2WMe
         5ebo+PvJb3CJPRd/d+9fjvhzVwM1zY22Et3lhHv7wa/tBGR1QIXKpBkEonO1XPcrvX7g
         ZPlZuJtyV4XEEyoxmcVOjNBEf2KWQcBkmzD5in7JVtseoXVOPfNNgJ8kBZ3KtPjJSn6m
         RwTA==
X-Gm-Message-State: ACgBeo1K1fqtr55DHIbTgytH4NvVqyWPKSexbzGiEsxOQTfx5BvRm0qw
        /kWTkmQ4QWw1LghOxaYfpn3W+WHRutkeYM6Ej3o=
X-Google-Smtp-Source: AA6agR6pa/CKYWt8ZlZQf7cDXkxCm9idEIJ0k5RpU9qpVFmxuSq43WznAy37NltXJ6uEpfMv8hR53oJAaAbVOAhfjcc=
X-Received: by 2002:a05:6512:12c5:b0:48c:df54:a41a with SMTP id
 p5-20020a05651212c500b0048cdf54a41amr4395517lfg.464.1660527524587; Sun, 14
 Aug 2022 18:38:44 -0700 (PDT)
MIME-Version: 1.0
References: <1660298966-11493-1-git-send-email-zhaoyang.huang@unisoc.com>
 <YvakpukeF9d35Bc8@slm.duckdns.org> <CAGWkznG6n=+v7hUKR8Rmg8VEF=BTDegk8bh6aHfvOU5TbmeXDw@mail.gmail.com>
In-Reply-To: <CAGWkznG6n=+v7hUKR8Rmg8VEF=BTDegk8bh6aHfvOU5TbmeXDw@mail.gmail.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Mon, 15 Aug 2022 09:38:31 +0800
Message-ID: <CAGWkznHa9WTV2oK=HB1OVEdKeMZ1V2omDDiNrRdyBdyYd=q5Fg@mail.gmail.com>
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

On Sun, Aug 14, 2022 at 2:40 PM Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
>
> On Sat, Aug 13, 2022 at 3:06 AM Tejun Heo <tj@kernel.org> wrote:
> >
> > On Fri, Aug 12, 2022 at 06:09:26PM +0800, zhaoyang.huang wrote:
> > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > >
> > > Memory charged on group B abserved on belowing v2 hierarchy where we just would
> > > like to only have group E's memory be controlled and B's descendants compete freely
> > > for memory. This should be the consequences of unified hierarchy. Solve this by
> > > have the cgroup without valid memory css alloced use root_mem_cgroup instead of
> > > its ancestor's.
> > >
> > >  A(subtree_control = memory) - B(subtree_control = NULL) - C()
> > >                                                          \ D()
> > >                            - E(subtree_control = memory) - F()
> > >                                                          \ G()
> > >
> > > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > ---
> > >  kernel/cgroup/cgroup.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> > > index 1779ccd..b29b3f6 100644
> > > --- a/kernel/cgroup/cgroup.c
> > > +++ b/kernel/cgroup/cgroup.c
> > > @@ -533,6 +533,14 @@ static struct cgroup_subsys_state *cgroup_e_css_by_mask(struct cgroup *cgrp,
> > >        * can't test the csses directly.  Test ss_mask.
> > >        */
> > >       while (!(cgroup_ss_mask(cgrp) & (1 << ss->id))) {
> > > +             /*
> > > +              * charging to the parent cgroup which hasn't distribute
> > > +              * memory control to its descendants doesn't make sense
> > > +              * especially on cgroup v2, where the parent could be configured
> > > +              * to use memory controller as its sibling want to use it
> > > +              */
> > > +             if (memory_cgrp_id == ss->id)
> > > +                     return &root_mem_cgroup->css;
> >
> > This is gonna be a hard nack. A given cgroup always encompasses all the
> > resources consumed in its self-including subtree.
> >
> > Thanks.
> IMHO, I would like to say if it makes more sense as "A given cgroup
> always encompasses all the resources consumed in its ENABLED
> self-including subtree." Otherwise, how should I couple with the
> scenarios I raised in the commit message which I prefer parts of the
> subtrees compete for "memory" while others are free for it. The free
> here is not only without "min/low/high watermarks" but also not
> charged to their own LRU.
I would like to state more why these make sense. Memory cgroup is a
little bit different to other cgroups, that is, memcg will have real
physical resources attached, say pages. From perspective of memory
reclaiming, it is odd to find that pages under free memcgs are charged
to separate LRUs but without any management(no watermark control) and
perhaps affect workingset mechanism by LRU reason. Furthermore, v2
should grant the groups with the right to reject the subsys which
introduced by sibling enable, which could be deemed as v2's
inconvenient. The memcg could also apply subtree_control to enroll all
memory back whenever it want.
> >
> > --
> > tejun
