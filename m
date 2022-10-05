Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F45E5F5C9F
	for <lists+cgroups@lfdr.de>; Thu,  6 Oct 2022 00:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiJEWXX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Oct 2022 18:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiJEWXW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 Oct 2022 18:23:22 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45AD82D3B
        for <cgroups@vger.kernel.org>; Wed,  5 Oct 2022 15:23:04 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id q9so353583vsp.1
        for <cgroups@vger.kernel.org>; Wed, 05 Oct 2022 15:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=qjOoV1BuCZlDNT880tsS+ACqXycyaEU+WkvcH9H3iVg=;
        b=efPc+1V6qps/BS2IsspFCmbyt+2ihM6UIQFCUQUHLWmGtJYDm/gGA/eJCqEbxj8tc2
         hq+JAziY7WJJevbUklScJ24dfO/gCsI0XqmLcZrwesLk77tIoZoivOR3s0+C/IIfQ/di
         PyWfP+e4UTEJfOzk4enx5S/2i5xYZAzxGpwl4hrBgiM1nD/Nj2AziVT5k8au3RYAMieT
         u2s/OhaaH0Wa9NTK/bxkFPqKgAG5e+vM7gn9fUzXuK9nbc3iGvF32bB9l4A+VaYfOorg
         pUySG2V+KFURYlHOD5ExGHdQ9PGEl16+sJYofJ0RQ9KG9Fd+DU5YiVgtiveu1fHzrqCX
         idSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=qjOoV1BuCZlDNT880tsS+ACqXycyaEU+WkvcH9H3iVg=;
        b=UGwZjX/60GucpdhN/dXlJ0DZEjPXnN1gRt4V/QCQSkPNMwcI/Nwp4/kpqUQoWzZdZx
         mYC7LnuYR4Lj8nM2IUZ1WAOOKbMsIcV5xXZd59OwrzAcJwaiEUjpX2XOpecs5IhuHtdq
         ywhu2M8Yv0Y8j1EHrFgueFle/mMjbZ0NM8+34F7I9Cn0YNx0TjoGo8AwuIMwEcS9ZjBY
         t8LdwY3gY1zQUXHaB748BT6eL4V9MlcHDkZUIrdLlH72BWi8Q2X1fkoQnD0x5D8A0rVU
         m7EsRK8bSY96CBVFh1dnLlDdc75cCfj++iYKaiBLzWpI2e5djt66rfbuOh8Kt+8An+pM
         /6sA==
X-Gm-Message-State: ACrzQf2t33qnYbU8qXtpRHwlr3780pSSj1WrptBOUvHQFZ9bp2OpnZfX
        gZ0oklcA4eWZa81Apkr2+nHiHtTelsOMR8A61/00mA==
X-Google-Smtp-Source: AMsMyM64o3Bi9oH+ZUWlPhu3LWy4szXIdlU0RmsZX1ceuE9dAWGETm+SYUBuhU4X4qkEZ1sorcRQMpcVL8gOdXgeHzQ=
X-Received: by 2002:a67:ac09:0:b0:39a:eab8:a3a6 with SMTP id
 v9-20020a67ac09000000b0039aeab8a3a6mr901838vse.9.1665008583168; Wed, 05 Oct
 2022 15:23:03 -0700 (PDT)
MIME-Version: 1.0
References: <20221005173713.1308832-1-yosryahmed@google.com>
 <CAOUHufaDhmHwY_qd2z26k6vK=eCHudJL1Pp4xALP25iZfbSJWA@mail.gmail.com>
 <CAJD7tkaS4T5dD3CpST2wsie5uP1ruHiaWL5AJv0j8V9=yiOuug@mail.gmail.com> <CAOUHufYKvbZTJ_ofD4+DyzY+DuHrRKYChnJVwqD7OKwe6sw-hw@mail.gmail.com>
In-Reply-To: <CAOUHufYKvbZTJ_ofD4+DyzY+DuHrRKYChnJVwqD7OKwe6sw-hw@mail.gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 5 Oct 2022 16:22:26 -0600
Message-ID: <CAOUHufaMFySiybW7drbPg_+w1xvk_Xh0bkCbPWw3aGaSnEFdTQ@mail.gmail.com>
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

On Wed, Oct 5, 2022 at 3:13 PM Yu Zhao <yuzhao@google.com> wrote:
>
> On Wed, Oct 5, 2022 at 3:02 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> >
> > On Wed, Oct 5, 2022 at 1:48 PM Yu Zhao <yuzhao@google.com> wrote:
> > >
> > > On Wed, Oct 5, 2022 at 11:37 AM Yosry Ahmed <yosryahmed@google.com> wrote:
> > > >
> > > > During page/folio reclaim, we check if a folio is referenced using
> > > > folio_referenced() to avoid reclaiming folios that have been recently
> > > > accessed (hot memory). The rationale is that this memory is likely to be
> > > > accessed soon, and hence reclaiming it will cause a refault.
> > > >
> > > > For memcg reclaim, we currently only check accesses to the folio from
> > > > processes in the subtree of the target memcg. This behavior was
> > > > originally introduced by commit bed7161a519a ("Memory controller: make
> > > > page_referenced() cgroup aware") a long time ago. Back then, refaulted
> > > > pages would get charged to the memcg of the process that was faulting them
> > > > in. It made sense to only consider accesses coming from processes in the
> > > > subtree of target_mem_cgroup. If a page was charged to memcg A but only
> > > > being accessed by a sibling memcg B, we would reclaim it if memcg A is
> > > > is the reclaim target. memcg B can then fault it back in and get charged
> > > > for it appropriately.
> > > >
> > > > Today, this behavior still makes sense for file pages. However, unlike
> > > > file pages, when swapbacked pages are refaulted they are charged to the
> > > > memcg that was originally charged for them during swapping out. Which
> > > > means that if a swapbacked page is charged to memcg A but only used by
> > > > memcg B, and we reclaim it from memcg A, it would simply be faulted back
> > > > in and charged again to memcg A once memcg B accesses it. In that sense,
> > > > accesses from all memcgs matter equally when considering if a swapbacked
> > > > page/folio is a viable reclaim target.

I just read the entire commit message (sorry for not doing so
previously) to figure out where the confusion came from: the above
claim is wrong for two cases. I'll let you figure out why :)

> > > > Modify folio_referenced() to always consider accesses from all memcgs if
> > > > the folio is swapbacked.
> > >
> > > It seems to me this change can potentially increase the number of
> > > zombie memcgs. Any risk assessment done on this?
> >
> > Do you mind elaborating the case(s) where this could happen? Is this
> > the cgroup v1 case in mem_cgroup_swapout() where we are reclaiming
> > from a zombie memcg and swapping out would let us move the charge to
> > the parent?
>
> The scenario is quite straightforward: for a page charged to memcg A
> and also actively used by memcg B, if we don't ignore the access from
> memcg B, we won't be able to reclaim it after memcg A is deleted.
