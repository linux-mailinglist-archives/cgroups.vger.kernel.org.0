Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC105A0B9C
	for <lists+cgroups@lfdr.de>; Thu, 25 Aug 2022 10:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiHYIet (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Aug 2022 04:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234415AbiHYIef (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 Aug 2022 04:34:35 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411CEA599B;
        Thu, 25 Aug 2022 01:34:34 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id n24so16684685ljc.13;
        Thu, 25 Aug 2022 01:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=H+0hvgnQryLyRGTLY2PSvbtKINzM1C3o/madftxyfvU=;
        b=hUs2zEarOFOjldcG3/iN1PjdwMaKcwDVlAxhiVE1FNpVdYCy9CBiFFc0u4vGdOhtTJ
         Zjf7OoJfwwqcqxxmkppcrILJB9/dXeYYO4zQnglsljh9LY6b31UWtcvuyN2xpMf5+91r
         pgv+hOaa4lZvxqNvi0bAfaF/LNas8FXjjBy68uXz5htwDQqKbfvUl0XMYV7OiDZ03ZCn
         kakLDuYy35p7tQLQr19m2+/EHNOYoK521heqvB/5pGDWO0PBTrkmq95thaBW04NEYDOp
         f6QFGMSBJepxO1H2h7tEoGwlalN8ez1DlEJF24r4AXehRuV/Dwkl0LsnKM+ZSeK+ROZ/
         lVIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=H+0hvgnQryLyRGTLY2PSvbtKINzM1C3o/madftxyfvU=;
        b=WnSZHB1fuCuneXEbaaYtMHuNnT0YX4beAJLKRbxYVqsaj3kvqwXZJ0LMYtNdlCG15X
         iqNsPOex6MEFP5x5UPYr1I2TwdJaF6OQPfdsOOVxBYOeIT+X473bd1ucYroA9cMpo4r4
         hgsWMz8C3GUeGuH3Yxz8XqYEqxIc8G5+4Q/o77ipxpGVkcvvxXUhKEg1q7Cj1gvuQ9LO
         y8IPGHsT/mVxXeiVkcDKf5ta1yPe1V0lyH6JX9q06/Fyw94HvzP2kIxZnZnrUcrxXPML
         SFQyEEEi/ktO7W9YAkbAAxh4aDdzJ8lkF12ffPGyy/14AbE53Qa36WDwxYhVD5o2HPpz
         3Oaw==
X-Gm-Message-State: ACgBeo3M/OPwX5a+MP5ZMFHjdqEVzqC6zAdWRWlkUpxEqwSPVfbEUswR
        wq2wXfis15HemiUy1MTP7j2STS58FsLiGj05GbI=
X-Google-Smtp-Source: AA6agR6W86PKJOKHWZb0C5IbJSjh1Hz+Isg368Kgq9FRsMX5RsH85N8hSo46BIPNsGyMnJDj1JDAQU/Q7kmv9R4AhjA=
X-Received: by 2002:a2e:3817:0:b0:261:cfba:ee4c with SMTP id
 f23-20020a2e3817000000b00261cfbaee4cmr732301lja.443.1661416472267; Thu, 25
 Aug 2022 01:34:32 -0700 (PDT)
MIME-Version: 1.0
References: <YwRjyx6wFLk8WTDe@dhcp22.suse.cz> <CAGWkznGaYTv4u4kOo-rupfyWzDNJXNKTchwP6dbUK-=UXWm47w@mail.gmail.com>
 <YwSQ4APOu/H7lYGL@dhcp22.suse.cz> <CAGWkznGd6mgareABseMKY5p0f1=5dkfVkj=NS7_B6OkXBYSwyw@mail.gmail.com>
 <YwS/S9Sd1OWnT81Q@dhcp22.suse.cz> <CAGWkznGYLyF+njUB0gFF3JVdThnK9JaNsqxXYFhbdSwEQpCxvA@mail.gmail.com>
 <YwXYVjRpXQjQMsxr@dhcp22.suse.cz> <CAGWkznEqX3DwHW_owiK+HuuQ-HsUYK4vKmLhSxgzGn20Vzid2A@mail.gmail.com>
 <YwX89JCQCKMMYdG9@dhcp22.suse.cz> <CAGWkznF+dBjLzAxMMXWYSZ_5q3KA-ou0P7XM7jSYN7JSRp8N0w@mail.gmail.com>
 <YwcZctA2S3Sd0LBN@dhcp22.suse.cz>
In-Reply-To: <YwcZctA2S3Sd0LBN@dhcp22.suse.cz>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Thu, 25 Aug 2022 16:34:04 +0800
Message-ID: <CAGWkznH5gQXigdLx=fwdL0uqdGx4WE9QP8b8cbWFxr=Rdg-CZQ@mail.gmail.com>
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

On Thu, Aug 25, 2022 at 2:40 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Thu 25-08-22 08:43:52, Zhaoyang Huang wrote:
> > On Wed, Aug 24, 2022 at 6:27 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Wed 24-08-22 17:34:42, Zhaoyang Huang wrote:
> [...]
> > > > IMHO, charging the pages which out of explicitly memory
> > > > enabled group to root could solve all of the above constraints with no
> > > > harm.
> > >
> > > This would break the hierarchical property of the controller. So a
> > > strong no no. Consider the following example
> > >
> > >        root
> > >         |
> > >         A
> > > controllers="memory"
> > > memory.max = 1G
> > > subtree_control=""
> > > |      |      |
> > > A1     A2     A3
> > >
> > > althought A1,2,3 do not have their memory controller enabled explicitly
> > > they are still constrained by the A memcg limit. If you just charge to
> > > the root because it doesn't have memory controller enabled explicitly
> > > then you just evade that constrain. I hope you understand why that is a
> > > problem.
> > IMO, A1-A3 should be explicitly enabled via echo "+memory" >
> > A/subtree_control since memory.max has been set.
>
> You seem to be missing the point I've triedy to make here. It is not
> about how the respective subtree should or shouldn't be configured. It
> is about the hierarchical behavior. Configuration at a higher level should be
> enforced under subtree no matter how that subtree decides to
> enabled/disable controllers. Such subtree might have beeb delegated
> and configured differently yet the constrain should be still applied.
> See the point?
>
> What you seem to be proposing is similar to cgroup v1 use_hierarchy
> configuration. It has been decided that this is undesirable very early
> in the cgroup v2 development because it make delegation impossible
> (among other reasons).
Ok, I would like to know how AA3 achieve the goal of competing with A1
and A2 for cpu but keep memory out of control under current policy?
        root
         |
         A
 controllers="memory,cpu"
 memory.max = 1G
 subtree_control="memory,cpu"
 |      |            |
 A1     A2     A3 subtree_control="cpu"
                      |      |
                    AA3   AA4 controllers="cpu"
>
> --
> Michal Hocko
> SUSE Labs
