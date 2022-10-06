Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D742C5F6076
	for <lists+cgroups@lfdr.de>; Thu,  6 Oct 2022 07:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiJFFLR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 6 Oct 2022 01:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiJFFLP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 6 Oct 2022 01:11:15 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FDA89AED
        for <cgroups@vger.kernel.org>; Wed,  5 Oct 2022 22:11:14 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id n186so936785vsc.9
        for <cgroups@vger.kernel.org>; Wed, 05 Oct 2022 22:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=5+UVhZeJoX4E+WLpr6yal2+2CsSWy2udLw4VJRvJT/4=;
        b=L3Xj7CNE0iYbk4Ok4e/ZTGnvZ5gj7ioKBA8XJGpolU3HZEPrufCoVkh86+13rrBvxZ
         bNByukcF4GRti36tqGuYv5xL0zXlNzm6NykB35agHaw52zNNzujhtdfmxowToQbARytP
         T0vjAbod/q5jQCPyIiBYR5FA1agmOjCVDgv8a//KLkhbRRpSpjACEZ6Eqd2//6a/2Xwk
         JxtljFMZ8xTLx+4mTeDoI+5iQQtBCuNkgEHTk2qC6Xu3QH///lykGQiosOyCB31NflMg
         3QAOnUICU3t3RaQb7BUzMrMylpHjeR+ZiUHTyN6bRjvr3n5XYBqVGWSb1RasbglRGjZC
         fgpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=5+UVhZeJoX4E+WLpr6yal2+2CsSWy2udLw4VJRvJT/4=;
        b=nGVBAM9Ex/lVIa92XRGOmNAxL3tjM9ONkh0MvE0MNCu88tEQu6P8tLlHPYuvk0+l0m
         rRCV0MBvqy0TnQa3L/B7Sz4G67OSJDJs/YBz9SkAnHzg+A0uFTrLoyPuGaukS/tEU8WH
         oqMitia/WclGIxzqxWCzLH+Bf1g0v5Mal5wAuxzsX8dU3xl3i7+0XLNR+gLP4VamDhW9
         yPpk31LO3deTHkYNmbfZT4Z6v69PrKnX8Vs7WyYpq1bGNz6zDavYZs7gPEP7O/P+DU4a
         FEHHyrnCVUwHLlHN1Spg4wJanXoj7bMMGjmGsN3ZPBzhr5OfKlKcK1XIH1ilq3qRDu/M
         Roog==
X-Gm-Message-State: ACrzQf0dus6rmezz0O0bCDHnOoFPuW0kS2l042oWucEVK58GnQ29Z0eI
        K1QsKai3ja0W0NzjIaqV21EEbfL7utLkKct8CrCa5w==
X-Google-Smtp-Source: AMsMyM4hOMbC3IJKXlBxwVnc1CGr2wX2+4f6W3gA4myq3Epr7Of7WPyRKyhnZs6io3NEpfzjRKFs28WgVg1flGFiiRs=
X-Received: by 2002:a67:ac08:0:b0:3a5:d34b:ae1 with SMTP id
 v8-20020a67ac08000000b003a5d34b0ae1mr1305964vse.46.1665033073521; Wed, 05 Oct
 2022 22:11:13 -0700 (PDT)
MIME-Version: 1.0
References: <20221005173713.1308832-1-yosryahmed@google.com>
 <CAOUHufaDhmHwY_qd2z26k6vK=eCHudJL1Pp4xALP25iZfbSJWA@mail.gmail.com>
 <CAJD7tkaS4T5dD3CpST2wsie5uP1ruHiaWL5AJv0j8V9=yiOuug@mail.gmail.com>
 <CAOUHufYKvbZTJ_ofD4+DyzY+DuHrRKYChnJVwqD7OKwe6sw-hw@mail.gmail.com> <Yz5XVZfq8abvMYJ8@cmpxchg.org>
In-Reply-To: <Yz5XVZfq8abvMYJ8@cmpxchg.org>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 5 Oct 2022 23:10:37 -0600
Message-ID: <CAOUHufa+f-RB1Lddu3fQPof=eqduyxM3mcCBuk3OR-Tu=+VN+w@mail.gmail.com>
Subject: Re: [PATCH v2] mm/vmscan: check references from all memcgs for
 swapbacked memory
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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

On Wed, Oct 5, 2022 at 10:19 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Wed, Oct 05, 2022 at 03:13:38PM -0600, Yu Zhao wrote:
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
> > > > >
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
>
> This patch changes the behavior of limit-induced reclaim. There is no
> limit reclaim on A after it's been deleted. And parental/global
> reclaim has always recognized outside references.

We use memory.reclaim to scrape memcgs right before rmdir so that they
are unlikely to stick around. Otherwise our job scheduler would see
less available memory and become less eager to increase load. This in
turn reduces the chance of global reclaim, and deleted memcgs would
stick around even longer.
