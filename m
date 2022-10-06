Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4D45F6AC6
	for <lists+cgroups@lfdr.de>; Thu,  6 Oct 2022 17:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbiJFPi3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 6 Oct 2022 11:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbiJFPi2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 6 Oct 2022 11:38:28 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40007BD072
        for <cgroups@vger.kernel.org>; Thu,  6 Oct 2022 08:38:26 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id z18so1402631qvn.6
        for <cgroups@vger.kernel.org>; Thu, 06 Oct 2022 08:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7iXEKlC7ORkC5fIeVI8VUWR9YmQGA/IC0j91wyTvOo=;
        b=Ibn8EfDwMvxYMsRoVhxKHuyL+MtidtjMV4enUQTaLRlqQyD9+02pjXr458YQB1HQd0
         itgKq2OGEHMvH8G0c/aJnF755R4oOgYSTbIrMs6P7zNYjTln/UbfVtKP5BAeSQIhSHEY
         jeKIyeR596uaOwAewNRxVngJWDmOoZ2m2KOlTpfLgO82ozmEI2HyrqFkTHq9AL6CyPK+
         7q35D7vTKhHa28c1NamTL5YqEt1t4lUZShD/uV2M4KI9BRWIdjifaNzHqqK2u8TThMk1
         dGEKx51g0cQYI1/Os5WIQw8ntMgg4o2S9GCyqu4xQd4ho2GTPYT0TTzH6gY+LgR6xMYA
         zJsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7iXEKlC7ORkC5fIeVI8VUWR9YmQGA/IC0j91wyTvOo=;
        b=DWZtfvgnt5o8L2x/KbllFJtLwNIh51Jk+mR/LZ1Kss1eotZW/EMKrKmhcLeCsVTAU4
         TvdQzRhfk8UMHE+R01cQlj8LX9lrsJ6nFWpBzGS65DFxRg4bNrIEqUMuOs9ditHjS3+y
         9CiK7PHtR2d741FSYkv7KCHNlsi94XRoBx1d7ouV+S+fMkaRq57au8MwagoYP349QYCW
         Np+tttUWsU1ts7K02oyqK9bkbN/yHp1Y7S8XT7ikR/bRc0b5wiFs943wlmULvXx07nyJ
         Im5koQxWCjkYUgOQBa9i7oOwJzDu8akdJ7frsnSZ/m6HJJxdnWX/lcGDrZv6T314ckB2
         5avA==
X-Gm-Message-State: ACrzQf022sSRJjhA8+XCGY1BokBZKqTuIRrCG8xukEzlMLDEHLiRyiA0
        qE/EUDvhwRg0+H/+ulq095C8/Q==
X-Google-Smtp-Source: AMsMyM56LtWrM8IQa7LsdUejJGh7UboSwXWgtDOhbFWVuzHshqi7IZcwV2wzUzdG+TJCfmusPg42nw==
X-Received: by 2002:a0c:e552:0:b0:4b1:86f0:89d5 with SMTP id n18-20020a0ce552000000b004b186f089d5mr217218qvm.97.1665070705379;
        Thu, 06 Oct 2022 08:38:25 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::8a16])
        by smtp.gmail.com with ESMTPSA id v19-20020a05622a131300b0031e9ab4e4cesm18027419qtk.26.2022.10.06.08.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 08:38:24 -0700 (PDT)
Date:   Thu, 6 Oct 2022 11:38:23 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Greg Thelen <gthelen@google.com>,
        David Rientjes <rientjes@google.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH v2] mm/vmscan: check references from all memcgs for
 swapbacked memory
Message-ID: <Yz72b1IjZkzk8CTl@cmpxchg.org>
References: <20221005173713.1308832-1-yosryahmed@google.com>
 <CAOUHufaDhmHwY_qd2z26k6vK=eCHudJL1Pp4xALP25iZfbSJWA@mail.gmail.com>
 <CAJD7tkaS4T5dD3CpST2wsie5uP1ruHiaWL5AJv0j8V9=yiOuug@mail.gmail.com>
 <CAOUHufYKvbZTJ_ofD4+DyzY+DuHrRKYChnJVwqD7OKwe6sw-hw@mail.gmail.com>
 <Yz5XVZfq8abvMYJ8@cmpxchg.org>
 <CAOUHufa+f-RB1Lddu3fQPof=eqduyxM3mcCBuk3OR-Tu=+VN+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOUHufa+f-RB1Lddu3fQPof=eqduyxM3mcCBuk3OR-Tu=+VN+w@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Oct 05, 2022 at 11:10:37PM -0600, Yu Zhao wrote:
> On Wed, Oct 5, 2022 at 10:19 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Wed, Oct 05, 2022 at 03:13:38PM -0600, Yu Zhao wrote:
> > > On Wed, Oct 5, 2022 at 3:02 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> > > >
> > > > On Wed, Oct 5, 2022 at 1:48 PM Yu Zhao <yuzhao@google.com> wrote:
> > > > >
> > > > > On Wed, Oct 5, 2022 at 11:37 AM Yosry Ahmed <yosryahmed@google.com> wrote:
> > > > > >
> > > > > > During page/folio reclaim, we check if a folio is referenced using
> > > > > > folio_referenced() to avoid reclaiming folios that have been recently
> > > > > > accessed (hot memory). The rationale is that this memory is likely to be
> > > > > > accessed soon, and hence reclaiming it will cause a refault.
> > > > > >
> > > > > > For memcg reclaim, we currently only check accesses to the folio from
> > > > > > processes in the subtree of the target memcg. This behavior was
> > > > > > originally introduced by commit bed7161a519a ("Memory controller: make
> > > > > > page_referenced() cgroup aware") a long time ago. Back then, refaulted
> > > > > > pages would get charged to the memcg of the process that was faulting them
> > > > > > in. It made sense to only consider accesses coming from processes in the
> > > > > > subtree of target_mem_cgroup. If a page was charged to memcg A but only
> > > > > > being accessed by a sibling memcg B, we would reclaim it if memcg A is
> > > > > > is the reclaim target. memcg B can then fault it back in and get charged
> > > > > > for it appropriately.
> > > > > >
> > > > > > Today, this behavior still makes sense for file pages. However, unlike
> > > > > > file pages, when swapbacked pages are refaulted they are charged to the
> > > > > > memcg that was originally charged for them during swapping out. Which
> > > > > > means that if a swapbacked page is charged to memcg A but only used by
> > > > > > memcg B, and we reclaim it from memcg A, it would simply be faulted back
> > > > > > in and charged again to memcg A once memcg B accesses it. In that sense,
> > > > > > accesses from all memcgs matter equally when considering if a swapbacked
> > > > > > page/folio is a viable reclaim target.
> > > > > >
> > > > > > Modify folio_referenced() to always consider accesses from all memcgs if
> > > > > > the folio is swapbacked.
> > > > >
> > > > > It seems to me this change can potentially increase the number of
> > > > > zombie memcgs. Any risk assessment done on this?
> > > >
> > > > Do you mind elaborating the case(s) where this could happen? Is this
> > > > the cgroup v1 case in mem_cgroup_swapout() where we are reclaiming
> > > > from a zombie memcg and swapping out would let us move the charge to
> > > > the parent?
> > >
> > > The scenario is quite straightforward: for a page charged to memcg A
> > > and also actively used by memcg B, if we don't ignore the access from
> > > memcg B, we won't be able to reclaim it after memcg A is deleted.
> >
> > This patch changes the behavior of limit-induced reclaim. There is no
> > limit reclaim on A after it's been deleted. And parental/global
> > reclaim has always recognized outside references.
> 
> We use memory.reclaim to scrape memcgs right before rmdir so that they
> are unlikely to stick around. Otherwise our job scheduler would see
> less available memory and become less eager to increase load. This in
> turn reduces the chance of global reclaim, and deleted memcgs would
> stick around even longer.

Thanks for the context.

It's not great that we have to design reclaim policy around this
implementation detail of past-EOF-pins. But such is life until we get
rid of them.
