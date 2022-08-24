Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29EA559F163
	for <lists+cgroups@lfdr.de>; Wed, 24 Aug 2022 04:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbiHXCXu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 Aug 2022 22:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiHXCXt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 23 Aug 2022 22:23:49 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1842C86B4C;
        Tue, 23 Aug 2022 19:23:44 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id z25so22148397lfr.2;
        Tue, 23 Aug 2022 19:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=zuPw7dTqyiFGf+aANdlA2zpaqeNoNbr+dKLXTuVUbxM=;
        b=YE9TTztfCeLOMQPUNlSlZw4VXHYmG6hYDIYDMAGrUMVCu8/6Dj8VY6NB0OxLXJ64yf
         xOeKgtqWo+k8y9K/QdIbLW02sxThwCpeD9Cz/dxmyqM8BCwbLLzqjGsT0RIy4nQxGz9g
         K8HQKd1lko4Qhd9ZDPYVlU+yqqEdjfvPAZf6D/FnL7JIktcKWpaXUMTMyzGxE9qh9GH6
         Z1Rzok9wOm4LrCwQ5eOR6TdhtVCf8u3KHeoFW71c6JEFAOOATw+fl0imQQBsqxGpg3DT
         I7BoK1rzgVFLhzPRMOkds9yBPdwoqFoMLWnzbPCZGrLeVxTd1VK+vbstm/Gm/bt4CpRx
         i4rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=zuPw7dTqyiFGf+aANdlA2zpaqeNoNbr+dKLXTuVUbxM=;
        b=LpX8D6iMm/64ti8ZJAZKo+dZPXzeBrVsj0BtX0k0W/P0zHkaCYogUyIJBiyLVfvXN7
         84+G21KRASG5xQbh3MbcSubkosaPeoxa0HSI4NtzRyw25cQj6x+Z5AvCt8Y+4Ch6HZOL
         5TfdXvaadKhNxzsT4atGEbSZdizELeZPocYUEIUXYW+BFpVoRZJBng5ts0Q1nUn+w7Ey
         blqBCAVoHPp6LSL8E2p3Kr4hB5bDkQZ2R3haFvMMlutVZbTpMnRpP9fvYBjdx4fbK+kt
         /4Is60yxIX8WxmY5LetvCJxNdiONs1nGUkmUSep4gGQ7UN5aWxYK075yMUfCBfAf/xMH
         fIlw==
X-Gm-Message-State: ACgBeo2Zl+5oR2HpUZ3WnOO7FmGBnol0L0ILu4txhw8q7a0OdqgNkcI+
        VwuWH1tF/DN4/lK7CjGeU3SVCwTjg5x82z6+iCY=
X-Google-Smtp-Source: AA6agR4HTb0hBhxDqdY2t6DaDtqy8EYwp9PJeyFO7bHO7hUUYgxDXGt5ugPao5GpHcjthjAbEg0/VqZOJ9I1ETy5f9k=
X-Received: by 2002:a05:6512:3049:b0:492:f394:11cd with SMTP id
 b9-20020a056512304900b00492f39411cdmr2178884lfb.165.1661307822271; Tue, 23
 Aug 2022 19:23:42 -0700 (PDT)
MIME-Version: 1.0
References: <1660908562-17409-1-git-send-email-zhaoyang.huang@unisoc.com>
 <Yv+6YjaGAv52yvq9@slm.duckdns.org> <CALvZod7QdLSMdBoD2WztL72qS8kJe7F79JuCH6t19rRcw6Pn1w@mail.gmail.com>
 <Yv/EArPDTcCrGqJh@slm.duckdns.org> <YwNpI1ydy0yDnBH0@dhcp22.suse.cz>
 <CAGWkznEB+R0YBaBFBL7dPqs8R=qKC6+ixTWEGCYy2PaczXkaPA@mail.gmail.com>
 <YwRjyx6wFLk8WTDe@dhcp22.suse.cz> <CAGWkznGaYTv4u4kOo-rupfyWzDNJXNKTchwP6dbUK-=UXWm47w@mail.gmail.com>
 <YwSQ4APOu/H7lYGL@dhcp22.suse.cz> <CAGWkznGd6mgareABseMKY5p0f1=5dkfVkj=NS7_B6OkXBYSwyw@mail.gmail.com>
 <YwS/S9Sd1OWnT81Q@dhcp22.suse.cz>
In-Reply-To: <YwS/S9Sd1OWnT81Q@dhcp22.suse.cz>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Wed, 24 Aug 2022 10:23:14 +0800
Message-ID: <CAGWkznGYLyF+njUB0gFF3JVdThnK9JaNsqxXYFhbdSwEQpCxvA@mail.gmail.com>
Subject: Re: [RFC PATCH] memcg: use root_mem_cgroup when css is inherited
To:     Michal Hocko <mhocko@suse.com>
Cc:     Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Ke Wang <ke.wang@unisoc.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>
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

On Tue, Aug 23, 2022 at 7:51 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 23-08-22 17:20:59, Zhaoyang Huang wrote:
> > On Tue, Aug 23, 2022 at 4:33 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Tue 23-08-22 14:03:04, Zhaoyang Huang wrote:
> > > > On Tue, Aug 23, 2022 at 1:21 PM Michal Hocko <mhocko@suse.com> wrote:
> > > > >
> > > > > On Tue 23-08-22 10:31:57, Zhaoyang Huang wrote:
> > > [...]
> > > > > > I would like to quote the comments from google side for more details
> > > > > > which can also be observed from different vendors.
> > > > > > "Also be advised that when you enable memcg v2 you will be using
> > > > > > per-app memcg configuration which implies noticeable overhead because
> > > > > > every app will have its own group. For example pagefault path will
> > > > > > regress by about 15%. And obviously there will be some memory overhead
> > > > > > as well. That's the reason we don't enable them in Android by
> > > > > > default."
> > > > >
> > > > > This should be reported and investigated. Because per-application memcg
> > > > > vs. memcg in general shouldn't make much of a difference from the
> > > > > performance side. I can see a potential performance impact for no-memcg
> > > > > vs. memcg case but even then 15% is quite a lot.
> > > > Less efficiency on memory reclaim caused by multi-LRU should be one of
> > > > the reason, which has been proved by comparing per-app memcg on/off.
> > > > Besides, theoretically workingset could also broken as LRU is too
> > > > short to compose workingset.
> > >
> > > Do you have any data to back these claims? Is this something that could
> > > be handled on the configuration level? E.g. by applying low limit
> > > protection to keep the workingset in the memory?
> > I don't think so. IMO, workingset works when there are pages evicted
> > from LRU and then refault which provide refault distance for pages.
> > Applying memcg's protection will have all LRU out of evicted which
> > make the mechanism fail.
>
> It is really hard to help you out without any actual data. The idea was
> though to use the low limit protection to adaptively configure
> respective memcgs to reduce refaults. You already have data about
> refaults ready so increasing the limit for often refaulting memcgs would
> reduce the trashing.
>
> [...]
> > > A.cgroup.controllers = memory
> > > A.cgroup.subtree_control = memory
> > >
> > > A/B.cgroup.controllers = memory
> > > A/B.cgroup.subtree_control = memory
> > > A/B/B1.cgroup.controllers = memory
> > >
> > > A/C.cgroup.controllers = memory
> > > A/C.cgroup.subtree_control = ""
> > > A/C/C1.cgroup.controllers = ""
> > Yes for above hierarchy and configuration.
> > >
> > > Is your concern that C1 is charged to A/C or that you cannot actually make
> > > A/C.cgroup.controllers = "" because you want to maintain memory in A?
> > > Because that would be breaking the internal node constrain rule AFAICS.
> > No. I just want to keep memory on B.
>
> That would require A to be without controllers which is not possible due
> to hierarchical constrain.
>
> > > Or maybe you just really want a different hierarchy where
> > > A == root_cgroup and want the memory acocunted in B
> > > (root/B.cgroup.controllers = memory) but not in C (root/C.cgroup.controllers = "")?
> > Yes.
> > >
> > > That would mean that C memory would be maintained on the global (root
> > > memcg) LRUs which is the only internal node which is allowed to have
> > > resources because it is special.
> > Exactly. I would like to have all groups like C which have no parent's
> > subtree_control = memory charge memory to root. Under this
> > implementation, memory under enabled group will be protected by
> > min/low while other groups' memory share the same LRU to have
> > workingset things take effect.
>
> One way to achieve that would be shaping the hierarchy the following way
>             root
>         /         \
> no_memcg[1]      memcg[2]
> ||||||||         |||||
> app_cgroups     app_cgroups
>
> with
> no_memcg.subtree_control = ""
> memcg.subtree_control = memory
>
> no?
According to my understanding, No as there will be no no_memcg. All
children groups under root would have its cgroup.controllers = memory
as long as root has memory enabled. Under this circumstance, all
descendants group under 'no_memcg' will charge memory to its parent
group. This is caused by e_css  policy when apply subsys control which
have child group use its first level ancestors css.
>
> You haven't really described why you need per application freezer cgroup
> but I suspect you want to selectively freeze applications. Is there
> any obstacle to have a dedicated frozen cgroup and migrate tasks to be
> frozen there?
> --
> Michal Hocko
> SUSE Labs
