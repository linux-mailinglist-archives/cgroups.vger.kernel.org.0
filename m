Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6265F5CE1
	for <lists+cgroups@lfdr.de>; Thu,  6 Oct 2022 00:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiJEWqM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Oct 2022 18:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiJEWqH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 Oct 2022 18:46:07 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0C285586
        for <cgroups@vger.kernel.org>; Wed,  5 Oct 2022 15:46:06 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id bu30so27408wrb.8
        for <cgroups@vger.kernel.org>; Wed, 05 Oct 2022 15:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Y7PkXIPyCPKXPJY3Ag9S0P6ozhe5/SZxhnvrYGS6zk0=;
        b=nUygVbNLVgpRMz29ZL4Mo17ZVVjjwdGeIkO7HpFOcNVyaB775Ph7JC/TsuUPmYPACt
         /D2ghtiPdFZbQhyfp9kc4QAkLToFjD2DieiCBPP8O8BoBbLZ9tZa78XrVhoXmURLbDSj
         VpSACO+pn6tWMrd36Fj12V6Ek3xVfptlHjPBg6gYq6fQ2LwQEQidqNMK2QmIKzNuSw4c
         cuJD8d+fRPAW0+y5+7yny7MZOX+cumwKPbh06JlKguMuRDyycfGua2RVDcgSMwrOHoPc
         m7tLpC0DbIMBEJPD3UVYIjTovNjwdwHvukM3L7XHT2ABtwXVVr+XlRlojzVJwLqYdGI7
         Zgzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Y7PkXIPyCPKXPJY3Ag9S0P6ozhe5/SZxhnvrYGS6zk0=;
        b=hueNIKZ8O0aysqjYMV4K944Z8QXdoNwe5T8BfKCoLulYhsbAYU4Xv2Yb9b7NV9GFzA
         OqTiU9B94Qs0GBUi0cD2itL6WExVWeIHjH3IU8+TCEE+i01qwGa9DZ4AbD0JVtpTa1S3
         +PtpXEjwO9rAMAo7ZznaQuSbAPPMku8kLSauLXBxb3271nXJDzM9MjnM6oeDRGOm/iJz
         ixcyr9+/JaaRPgyAOWxL3Mr0btqT8R/wDAA5c3oUXwq2Z9InTUL46nuH0EIXKNJ8OWBB
         RXwi7vd4Tnnv9upn0cPgnM1oUPc6X+7lKW8yru9qUtWORgrtoVnq/+7PlspPUDUxwU+X
         Djig==
X-Gm-Message-State: ACrzQf05Tqc/bkc2sZI+SjoJJEflACyXwfmG7qOLijw0ZAP3QoxEl0yW
        D10XxCPP5lyJ4+G/NjQU+TG4WeS/9JoKzBDh4roF8Q==
X-Google-Smtp-Source: AMsMyM57TKXhFZ/LaoU/QYTDmGDJL5ZNbcAqwVkPauC4XmxZ8mWMNy6CFIKcSpgGv4ylnqDNj4GyLJpLL6r/xWpocWE=
X-Received: by 2002:a5d:64e8:0:b0:22a:bbb0:fa with SMTP id g8-20020a5d64e8000000b0022abbb000famr1149395wri.372.1665009964490;
 Wed, 05 Oct 2022 15:46:04 -0700 (PDT)
MIME-Version: 1.0
References: <20221005173713.1308832-1-yosryahmed@google.com>
 <CAOUHufaDhmHwY_qd2z26k6vK=eCHudJL1Pp4xALP25iZfbSJWA@mail.gmail.com>
 <CAJD7tkaS4T5dD3CpST2wsie5uP1ruHiaWL5AJv0j8V9=yiOuug@mail.gmail.com>
 <CAOUHufYKvbZTJ_ofD4+DyzY+DuHrRKYChnJVwqD7OKwe6sw-hw@mail.gmail.com> <CAOUHufaMFySiybW7drbPg_+w1xvk_Xh0bkCbPWw3aGaSnEFdTQ@mail.gmail.com>
In-Reply-To: <CAOUHufaMFySiybW7drbPg_+w1xvk_Xh0bkCbPWw3aGaSnEFdTQ@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 5 Oct 2022 15:45:27 -0700
Message-ID: <CAJD7tkbvZF=_1Zq-WA1pLgn4X+tHmqwV2erFLp3ZbDOKdZWKAw@mail.gmail.com>
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

On Wed, Oct 5, 2022 at 3:23 PM Yu Zhao <yuzhao@google.com> wrote:
>
> On Wed, Oct 5, 2022 at 3:13 PM Yu Zhao <yuzhao@google.com> wrote:
> >
> > On Wed, Oct 5, 2022 at 3:02 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> > >
> > > On Wed, Oct 5, 2022 at 1:48 PM Yu Zhao <yuzhao@google.com> wrote:
> > > >
> > > > On Wed, Oct 5, 2022 at 11:37 AM Yosry Ahmed <yosryahmed@google.com> wrote:
> > > > >
> > > > > During page/folio reclaim, we check if a folio is referenced using
> > > > > folio_referenced() to avoid reclaiming folios that have been recently
> > > > > accessed (hot memory). The rationale is that this memory is likely to be
> > > > > accessed soon, and hence reclaiming it will cause a refault.
> > > > >
> > > > > For memcg reclaim, we currently only check accesses to the folio from
> > > > > processes in the subtree of the target memcg. This behavior was
> > > > > originally introduced by commit bed7161a519a ("Memory controller: make
> > > > > page_referenced() cgroup aware") a long time ago. Back then, refaulted
> > > > > pages would get charged to the memcg of the process that was faulting them
> > > > > in. It made sense to only consider accesses coming from processes in the
> > > > > subtree of target_mem_cgroup. If a page was charged to memcg A but only
> > > > > being accessed by a sibling memcg B, we would reclaim it if memcg A is
> > > > > is the reclaim target. memcg B can then fault it back in and get charged
> > > > > for it appropriately.
> > > > >
> > > > > Today, this behavior still makes sense for file pages. However, unlike
> > > > > file pages, when swapbacked pages are refaulted they are charged to the
> > > > > memcg that was originally charged for them during swapping out. Which
> > > > > means that if a swapbacked page is charged to memcg A but only used by
> > > > > memcg B, and we reclaim it from memcg A, it would simply be faulted back
> > > > > in and charged again to memcg A once memcg B accesses it. In that sense,
> > > > > accesses from all memcgs matter equally when considering if a swapbacked
> > > > > page/folio is a viable reclaim target.
>
> I just read the entire commit message (sorry for not doing so
> previously) to figure out where the confusion came from: the above
> claim is wrong for two cases. I'll let you figure out why :)

I missed the cases with dead memcgs. I think the two cases are:

1)  If a memcg is dead during swap out it looks like the swap charge
is moved to the parent. So reclaim is effectively recharging to the
parent. This can be handled by only checking access from all memcgs if
the charged memcg is alive, something like this:

if (target_memcg && (!folio_test_swapback(folio) ||
!mem_cgroup_online(folio_memcg(folio))))
...

2) If a memcg dies after a page is already swapped out. During swap in
it looks like we charge the page to the process of the page fault if
that's the case.

Now in this case this patch might actually increase zombie memcgs, but
only temporarily. Next time we try to reclaim the page we will go back
to case (1) and reclaim it. Also, one might argue that given that the
page is relatively hot (accessed by a different memcg), and therefore
likely to be faulted in soon, the chances of the memcg dying between
the time where the page is reclaimed and faulted back in are slim. One
might also argue that having swapbacked pages charged to one memcg and
accessed by another is generally less common compared to file page
cache.

So I *think* with an added check for offline memcgs there shouldn't be
any concerns, unless I got the two cases wrong :)

>
> > > > > Modify folio_referenced() to always consider accesses from all memcgs if
> > > > > the folio is swapbacked.
> > > >
> > > > It seems to me this change can potentially increase the number of
> > > > zombie memcgs. Any risk assessment done on this?
> > >
> > > Do you mind elaborating the case(s) where this could happen? Is this
> > > the cgroup v1 case in mem_cgroup_swapout() where we are reclaiming
> > > from a zombie memcg and swapping out would let us move the charge to
> > > the parent?
> >
> > The scenario is quite straightforward: for a page charged to memcg A
> > and also actively used by memcg B, if we don't ignore the access from
> > memcg B, we won't be able to reclaim it after memcg A is deleted.
