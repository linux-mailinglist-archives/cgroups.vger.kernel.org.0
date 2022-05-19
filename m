Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5D652D786
	for <lists+cgroups@lfdr.de>; Thu, 19 May 2022 17:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237803AbiESP3q (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 May 2022 11:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235437AbiESP3p (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 May 2022 11:29:45 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E731265A0
        for <cgroups@vger.kernel.org>; Thu, 19 May 2022 08:29:43 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id o2so5552536vsd.13
        for <cgroups@vger.kernel.org>; Thu, 19 May 2022 08:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TTppzXqGXGzezJ0VNR/10YUamTL+Jpn/a+OS4nEwUs0=;
        b=aJRufbeVPWWTg6xesgVQ92jTkUBXkj4204NtsTRRuXhSDjPb8Xkpo0bNaK4046hFnv
         mLKgwhvsh9GAmI2LFDkeF6HnSFJOYseaJ+p8tes7OyljSbloK0G+33o31Bpt84fkfCb4
         J38wGhcIGfbVqDVaOHU/qKlZO1PRo09oJVwe8Kq8Gjr8j7VY4qHpf1GeZdyugHi00mzw
         aPj5qp0lnQNuRwPUHk0H544OPn69tIDaGuwVRtFJw5cVWxmIclVYYJ1OVG+xA+X0wkh6
         EFpAbJrZNyvmy90Vgh11onsTrIn9w5C0EYbSgXGfpC4kZqk73crIwyt6vZPv3EiDdghA
         AwgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TTppzXqGXGzezJ0VNR/10YUamTL+Jpn/a+OS4nEwUs0=;
        b=AczcUH2MAXOhJr5OyfXSQYUxjJfWxV9qymA+B+Ao/TVjkXKFwGgC+Zix2q+RtOYjNc
         ajRpP1WKGGYLRPFHAWN3e+PXY4rOyyx7Emtl2+zwGxGicqlUijPMyH/nCdSouqVSz5Ma
         NTQ0PSv54qV1lYnKaDgPLbEAocmTWZdOEdrPhR5HWWwSaGarkoqhI6Ysi8uMwA7j7Gog
         H0Xx3ORzke6siyH6Xsy7X00rOwnuGRY77MetERW05AZJpcdBSYhxQJXjFTKUtdSriCZ6
         XOamX4UtlLgyUPv4LIk5HHgJ5riAqy7jLmqAQGQsdnF9/gKhcMoXBewhmKkyxUSMHkdi
         +cRA==
X-Gm-Message-State: AOAM5327hKQiKUZBUcW2XS0JHE2pYOpsN/blix7EzvQ0e/8QJldaQmOY
        yNyIqsosQSjlq/QTr21MfKG0+ww47eGM38OJK04lZw==
X-Google-Smtp-Source: ABdhPJw+n9H3muNanVvnGzkIcR9olge2SWxTCMxOP9MQ1pcplNiacgRpRo43zTNM6++hw02jtLKmONoAGYelF5/06ZQ=
X-Received: by 2002:a05:6102:3ecf:b0:320:7c27:5539 with SMTP id
 n15-20020a0561023ecf00b003207c275539mr2699219vsv.59.1652974182955; Thu, 19
 May 2022 08:29:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAJD7tkbDpyoODveCsnaqBBMZEkDvshXJmNdbk51yKSNgD7aGdg@mail.gmail.com>
 <YoNHJwyjR7NJ5kG7@dhcp22.suse.cz> <CAJD7tkYnBjuwQDzdeo6irHY=so-E8z=Kc_kZe52anMOmRL+8yA@mail.gmail.com>
 <YoQAVeGj19YpSMDb@cmpxchg.org> <CAAPL-u8pZ_p+SQZnr=8UV37yiQpWRZny7g9p6YES0wa+g_kMJw@mail.gmail.com>
 <YoYFKdqayKRw2npp@dhcp22.suse.cz>
In-Reply-To: <YoYFKdqayKRw2npp@dhcp22.suse.cz>
From:   Wei Xu <weixugc@google.com>
Date:   Thu, 19 May 2022 08:29:32 -0700
Message-ID: <CAAPL-u-e=yZT7_N2oVNhpPnM=1Fg=JhCF-0xoMoFZfq8Kgw3zQ@mail.gmail.com>
Subject: Re: [RFC] Add swappiness argument to memory.reclaim
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Cgroups <cgroups@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Yu Zhao <yuzhao@google.com>,
        Greg Thelen <gthelen@google.com>,
        Chen Wandun <chenwandun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, May 19, 2022 at 1:51 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 18-05-22 22:44:13, Wei Xu wrote:
> > On Tue, May 17, 2022 at 1:06 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> [...]
> > > But I don't think an anon/file bias will capture this coefficient?
> >
> > It essentially provides the userspace proactive reclaimer an ability
> > to define its own reclaim policy by adding an argument to specify
> > which type of pages to reclaim via memory.reclaim.
>
> I am not sure the swappiness is really a proper interface for that.
> Historically this tunable has changed behavior several times and the
> reclaim algorithm is free to ignore it completely in many cases. If you
> want to build a userspace reclaim policy, then it really has to have a
> predictable and stable behavior. That would mean that the semantic would
> have to be much stronger than the global vm_swappiness.

I agree. As what I replied to Roman's comments earlier, it is cleaner
to just specify the type of pages to reclaim.

> --
> Michal Hocko
> SUSE Labs
