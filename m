Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B2E5F5B5A
	for <lists+cgroups@lfdr.de>; Wed,  5 Oct 2022 23:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiJEVCi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Oct 2022 17:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiJEVCh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 Oct 2022 17:02:37 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F64E80F65
        for <cgroups@vger.kernel.org>; Wed,  5 Oct 2022 14:02:33 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so1705800wmb.0
        for <cgroups@vger.kernel.org>; Wed, 05 Oct 2022 14:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=HPUxNB9MAwfSiCjJ5k2ShYT0pkIe+fckBsowNt59HiU=;
        b=To/UngnwRjZ1zcui5/7edHRckWOASAvX1nCD7uw4oP6oQB9gj9fItEb7R7KXB0Uh+Z
         ofyHGd/dLIhhiBIsPxk1k271j6xdnEwHe7sx4QmCS359PSa57zhos0T12EA+u6n4e0Md
         rtML6PrISEHmQ9NzfX8vzYQPvHJzV6bcEesiiKbQGitIkz5QQ3TPShpYZkdqBlLytQ4m
         OP2jhY1Qhl09NdGxwRX/0EiW91btEJ0UEQycHayJZbHr5uI8xm+PZYTnz1koZmKQf4Tf
         cSYuiD7bBV4AkcLip+/MmfL4aRUnsBJqtkrPIi4W2n4TqdIvUAOuV1pEBGpEQxmEtqXC
         Lngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=HPUxNB9MAwfSiCjJ5k2ShYT0pkIe+fckBsowNt59HiU=;
        b=EyMyA9KtrXUIXveBzEfGQG0njpKybiBi8d2oZewnz+xcuHPIlAYPXtOlO8EVXzvTZv
         dsp19B2OmXbFsPfyUKo5Gf3fd2tGcXFms54HVc34XDp81Bws++SCrdVQOOYAKFiwito7
         mTDfsQ1qvWvm+B26qUMxWxceiG1o4+G5grLQgwUbAXS0hAfF3AF81/kndZjFxbWoc/d2
         F/Q5CZ36rqf59aHf+rX9JWSdhlriCrSJRxoqTdyLjTHzGpia4QtyeGzEs2adJdwBDQN6
         2dP0wXUEr4dpP8ZjOEX21X/t5uPSOMFSS+K3QKNy3BbUxVFpSkv6iMj+3Ky5BUhlJdS9
         9eBw==
X-Gm-Message-State: ACrzQf3sJlCowdqk+vWHSIXdx5jfdun2J0qylirSSxDroXXcfvpID5de
        TB0nVHMnUU8tN3snMC83ECfOsg58aq8JPbg4/c6MLA==
X-Google-Smtp-Source: AMsMyM4ACAfhfS/1Q2rA7ojoHPLdE/131c25wYDYscUAeNx8muyZVqunA3B4lxaKuytp4PAVk9pK5Zzng775yRTAehA=
X-Received: by 2002:a05:600c:46c6:b0:3b4:d069:913f with SMTP id
 q6-20020a05600c46c600b003b4d069913fmr885727wmo.27.1665003751707; Wed, 05 Oct
 2022 14:02:31 -0700 (PDT)
MIME-Version: 1.0
References: <20221005173713.1308832-1-yosryahmed@google.com> <CAOUHufaDhmHwY_qd2z26k6vK=eCHudJL1Pp4xALP25iZfbSJWA@mail.gmail.com>
In-Reply-To: <CAOUHufaDhmHwY_qd2z26k6vK=eCHudJL1Pp4xALP25iZfbSJWA@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 5 Oct 2022 14:01:55 -0700
Message-ID: <CAJD7tkaS4T5dD3CpST2wsie5uP1ruHiaWL5AJv0j8V9=yiOuug@mail.gmail.com>
Subject: Re: [PATCH v2] mm/vmscan: check references from all memcgs for
 swapbacked memory
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Greg Thelen <gthelen@google.com>,
        David Rientjes <rientjes@google.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Oct 5, 2022 at 1:48 PM Yu Zhao <yuzhao@google.com> wrote:
>
> On Wed, Oct 5, 2022 at 11:37 AM Yosry Ahmed <yosryahmed@google.com> wrote:
> >
> > During page/folio reclaim, we check if a folio is referenced using
> > folio_referenced() to avoid reclaiming folios that have been recently
> > accessed (hot memory). The rationale is that this memory is likely to be
> > accessed soon, and hence reclaiming it will cause a refault.
> >
> > For memcg reclaim, we currently only check accesses to the folio from
> > processes in the subtree of the target memcg. This behavior was
> > originally introduced by commit bed7161a519a ("Memory controller: make
> > page_referenced() cgroup aware") a long time ago. Back then, refaulted
> > pages would get charged to the memcg of the process that was faulting them
> > in. It made sense to only consider accesses coming from processes in the
> > subtree of target_mem_cgroup. If a page was charged to memcg A but only
> > being accessed by a sibling memcg B, we would reclaim it if memcg A is
> > is the reclaim target. memcg B can then fault it back in and get charged
> > for it appropriately.
> >
> > Today, this behavior still makes sense for file pages. However, unlike
> > file pages, when swapbacked pages are refaulted they are charged to the
> > memcg that was originally charged for them during swapping out. Which
> > means that if a swapbacked page is charged to memcg A but only used by
> > memcg B, and we reclaim it from memcg A, it would simply be faulted back
> > in and charged again to memcg A once memcg B accesses it. In that sense,
> > accesses from all memcgs matter equally when considering if a swapbacked
> > page/folio is a viable reclaim target.
> >
> > Modify folio_referenced() to always consider accesses from all memcgs if
> > the folio is swapbacked.
>
> It seems to me this change can potentially increase the number of
> zombie memcgs. Any risk assessment done on this?

Do you mind elaborating the case(s) where this could happen? Is this
the cgroup v1 case in mem_cgroup_swapout() where we are reclaiming
from a zombie memcg and swapping out would let us move the charge to
the parent?
