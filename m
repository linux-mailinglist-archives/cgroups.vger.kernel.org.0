Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A475F5B83
	for <lists+cgroups@lfdr.de>; Wed,  5 Oct 2022 23:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbiJEVOW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Oct 2022 17:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiJEVOV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 Oct 2022 17:14:21 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA21F24BD9
        for <cgroups@vger.kernel.org>; Wed,  5 Oct 2022 14:14:20 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id a129so242525vsc.0
        for <cgroups@vger.kernel.org>; Wed, 05 Oct 2022 14:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=cN737y3rFnqPr5hK14+5V1D+jLG9F1NJvLgYSv/BW3Q=;
        b=m7u9bzZ+v0v4cC+WovU8Rc5TX7yyu3iQY8wm4xQpdfGxClu5PDZJPcsoF1xnpzGqZ4
         tSxxQR5BiHq5xB1bXuS/NaMYPC+OK1FvAT5VNuQhqPGRrP3IpwzhxXjvgkoUqJmKWbVj
         ds0meJVAmA/HT1WymnHW2SdfeuuAWp6p3BB/IONL5/G/s0ZjyMGTps9vCg5cqUTh/79C
         cVyUTeLI2gs7pous/40q2pAs60gmhbGIziAv601fzEC38amdKC3xUWeCaS6IZeObYr8u
         mmmOAjeAXu9QlueCgnC4Bzrs+Ogra4s6RJ2ZmYRxIIApbHytIATg3g1SO1bEAQ8jYyKL
         okkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=cN737y3rFnqPr5hK14+5V1D+jLG9F1NJvLgYSv/BW3Q=;
        b=K3Gc9t/deIGG3ZUWAXIlC+nVuLApjeHjzJqehB2tsXThiE7rbGqAfpyaC7yd7ncJkx
         097OvvmgGqZfZBQxKx1a6M4yhIsrrdyY6LswJ3Zo0yKi4x663OHtYtscJqKQ3SPc10zd
         mYAaGSgmlWxew/QWqB9HFk92g3XZsUKjSRTvtmhv7qLswezYlTxKS6whnQ+fS29eTdrj
         i1dyQpazDd+tgIQQCZdWwxcIa4cnJoARxkICH8cLRyFf0WPOZ1frmI8MoxzPLulxzziz
         G9eoWY+D8qdO4jksa2uUHDn9AwwUo2ATbP5AfTmgBKhy+nC6mJBrfoWguoWD/ZVavXrd
         HOwg==
X-Gm-Message-State: ACrzQf1hwYIO7mWy+JyXeqjTnifCAVmrnYdgMXQbWCn2BUNb0s+EhVgm
        pCgXi3PfVQQJ/0+2tDU8zrssj3nbPQAExM6XvlAieQ==
X-Google-Smtp-Source: AMsMyM5g0dHid+ksefS25KT9kew8SpkqJGuIferob/ufa0Xm55Rk+vs6rLWj9e2MiCZyPr0GKvsLsZoKEg5YPZiOX84=
X-Received: by 2002:a67:d50c:0:b0:3a6:8ed7:3f00 with SMTP id
 l12-20020a67d50c000000b003a68ed73f00mr747101vsj.15.1665004455202; Wed, 05 Oct
 2022 14:14:15 -0700 (PDT)
MIME-Version: 1.0
References: <20221005173713.1308832-1-yosryahmed@google.com>
 <CAOUHufaDhmHwY_qd2z26k6vK=eCHudJL1Pp4xALP25iZfbSJWA@mail.gmail.com> <CAJD7tkaS4T5dD3CpST2wsie5uP1ruHiaWL5AJv0j8V9=yiOuug@mail.gmail.com>
In-Reply-To: <CAJD7tkaS4T5dD3CpST2wsie5uP1ruHiaWL5AJv0j8V9=yiOuug@mail.gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 5 Oct 2022 15:13:38 -0600
Message-ID: <CAOUHufYKvbZTJ_ofD4+DyzY+DuHrRKYChnJVwqD7OKwe6sw-hw@mail.gmail.com>
Subject: Re: [PATCH v2] mm/vmscan: check references from all memcgs for
 swapbacked memory
To:     Yosry Ahmed <yosryahmed@google.com>
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

On Wed, Oct 5, 2022 at 3:02 PM Yosry Ahmed <yosryahmed@google.com> wrote:
>
> On Wed, Oct 5, 2022 at 1:48 PM Yu Zhao <yuzhao@google.com> wrote:
> >
> > On Wed, Oct 5, 2022 at 11:37 AM Yosry Ahmed <yosryahmed@google.com> wrote:
> > >
> > > During page/folio reclaim, we check if a folio is referenced using
> > > folio_referenced() to avoid reclaiming folios that have been recently
> > > accessed (hot memory). The rationale is that this memory is likely to be
> > > accessed soon, and hence reclaiming it will cause a refault.
> > >
> > > For memcg reclaim, we currently only check accesses to the folio from
> > > processes in the subtree of the target memcg. This behavior was
> > > originally introduced by commit bed7161a519a ("Memory controller: make
> > > page_referenced() cgroup aware") a long time ago. Back then, refaulted
> > > pages would get charged to the memcg of the process that was faulting them
> > > in. It made sense to only consider accesses coming from processes in the
> > > subtree of target_mem_cgroup. If a page was charged to memcg A but only
> > > being accessed by a sibling memcg B, we would reclaim it if memcg A is
> > > is the reclaim target. memcg B can then fault it back in and get charged
> > > for it appropriately.
> > >
> > > Today, this behavior still makes sense for file pages. However, unlike
> > > file pages, when swapbacked pages are refaulted they are charged to the
> > > memcg that was originally charged for them during swapping out. Which
> > > means that if a swapbacked page is charged to memcg A but only used by
> > > memcg B, and we reclaim it from memcg A, it would simply be faulted back
> > > in and charged again to memcg A once memcg B accesses it. In that sense,
> > > accesses from all memcgs matter equally when considering if a swapbacked
> > > page/folio is a viable reclaim target.
> > >
> > > Modify folio_referenced() to always consider accesses from all memcgs if
> > > the folio is swapbacked.
> >
> > It seems to me this change can potentially increase the number of
> > zombie memcgs. Any risk assessment done on this?
>
> Do you mind elaborating the case(s) where this could happen? Is this
> the cgroup v1 case in mem_cgroup_swapout() where we are reclaiming
> from a zombie memcg and swapping out would let us move the charge to
> the parent?

The scenario is quite straightforward: for a page charged to memcg A
and also actively used by memcg B, if we don't ignore the access from
memcg B, we won't be able to reclaim it after memcg A is deleted.
