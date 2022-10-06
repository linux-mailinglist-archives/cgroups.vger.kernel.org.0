Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29FEC5F61A3
	for <lists+cgroups@lfdr.de>; Thu,  6 Oct 2022 09:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiJFHbZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 6 Oct 2022 03:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiJFHbY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 6 Oct 2022 03:31:24 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787028E453
        for <cgroups@vger.kernel.org>; Thu,  6 Oct 2022 00:31:23 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id bu30so1274429wrb.8
        for <cgroups@vger.kernel.org>; Thu, 06 Oct 2022 00:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=RVWW/BaJYSJb5iFCcmVWgHh8lf5q5nSO5D6+WwfrGO0=;
        b=mBl1Gv36EpxEHwxD8G7c2u80/IL6+9yVxn+9bsflcmtYODk4l9xKEbagkili2v3OxI
         XjdikoyYoP1QyAmW0TZErMbO84gMIB6gcm6OYndYagBwSrqg9Gy4hv7im3obX0sBrq3p
         qG/hjkBWPS6Ku3/fjoIlhVjcF58vx5EDYDbEXQV215CHEO4WTUxZ6janp1qrFyDboI/w
         OOo7kmv3GN2o97SK1InevEG172WD5n92gOjtHgaSDG0nvTAvYaHKUFk1a40joFB5wq9W
         04WeKaJxs/LPaW2NmdgChnXxn6tpuD1tcm9ISfoO9lHunE2GHuEn5rl04s9FhpFGXaMN
         smIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=RVWW/BaJYSJb5iFCcmVWgHh8lf5q5nSO5D6+WwfrGO0=;
        b=cwRyDLBbbBtM6uFOCmI7DnMHnoM54K2xvomJWVTxnS+8NzW7m697ZGx+u999N6bn/n
         /Kp4F7SH/bpK2wlkJni7thQY8btvwltTPl1ZPHbc52SqaGcier/NCJ4u8ByxoKaD43GT
         +fnfXeGFbAHOEtcbvAFg954OTpwvuLgG9MGQTct0YD2RbcrR1vOsYNM4+eJtL/CLHe3R
         ZMbcyUkX9QdUZRp17vrE8Wd+qZYx1G91xHE1xKBXuCv+gnGYdSOyILe2vjY+SEMCUtYl
         F88VgmR77LXq0/3rE1/sPSrCDWNL2n5LEFFDMgxIJqUcUbYs2CYCsgp/artGDb2MHA20
         TuYw==
X-Gm-Message-State: ACrzQf0xIr7pN5z90I5wvnvlhHZnbPMHrj20OWr9m1L8XRpKvVknT67d
        w7eiVPa9b3g4HkZ9Tb90bYcTSPn3ly+vgf0BuDHjaA==
X-Google-Smtp-Source: AMsMyM4F8plDfzsO4L9/zK32C+FXqkAqa2FGfRbFh1YLiFVJeQ15FU4Yvw6zh5fQyrQBEgCP8iE/zP+zKvziVDYpiCU=
X-Received: by 2002:adf:fb05:0:b0:228:6463:b15d with SMTP id
 c5-20020adffb05000000b002286463b15dmr2091087wrr.534.1665041481940; Thu, 06
 Oct 2022 00:31:21 -0700 (PDT)
MIME-Version: 1.0
References: <20221005173713.1308832-1-yosryahmed@google.com>
 <CAOUHufaDhmHwY_qd2z26k6vK=eCHudJL1Pp4xALP25iZfbSJWA@mail.gmail.com>
 <CAJD7tkaS4T5dD3CpST2wsie5uP1ruHiaWL5AJv0j8V9=yiOuug@mail.gmail.com>
 <CAOUHufYKvbZTJ_ofD4+DyzY+DuHrRKYChnJVwqD7OKwe6sw-hw@mail.gmail.com> <Yz5XVZfq8abvMYJ8@cmpxchg.org>
In-Reply-To: <Yz5XVZfq8abvMYJ8@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 6 Oct 2022 00:30:45 -0700
Message-ID: <CAJD7tkao9DU2e_2co_HgOm38PxvLqdRS=kHcOdRfqcqN6MRdaw@mail.gmail.com>
Subject: Re: [PATCH v2] mm/vmscan: check references from all memcgs for
 swapbacked memory
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Yu Zhao <yuzhao@google.com>,
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

On Wed, Oct 5, 2022 at 9:19 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
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

Do you mind elaborating on the parental reclaim part?

I am looking at the code and it looks like memcg reclaim of a parent
(limit-induced or proactive) will only consider references coming from
its subtree, even when reclaiming from its dead children. It looks
like as long as sc->target_mem_cgroup is set, we ignore outside
references (relative to sc->target_mem_cgroup).

If that is true, maybe we want to keep ignoring outside references for
swap-backed pages if the folio is charged to a dead memcg? My
understanding is that in this case we will uncharge the page from the
dead memcg and charge the swapped entry to the parent, reducing the
number of refs on the dead memcg. Without this check, this patch might
prevent the charge from being moved to the parent in this case. WDYT?
