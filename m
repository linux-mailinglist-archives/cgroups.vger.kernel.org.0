Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5D46A0E88
	for <lists+cgroups@lfdr.de>; Thu, 23 Feb 2023 18:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjBWRSi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Feb 2023 12:18:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjBWRSh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Feb 2023 12:18:37 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6099415542
        for <cgroups@vger.kernel.org>; Thu, 23 Feb 2023 09:18:35 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-536c2a1cc07so197356467b3.5
        for <cgroups@vger.kernel.org>; Thu, 23 Feb 2023 09:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fXkdUZpJKaU09VaQ11AXT4xG/p6acp3mSex2EZ+R/lU=;
        b=amR2wqzsiprwfbFfrHgh/xz4XLutJ3c00Gafi0Ekj78VHQ5IN4mpuEdlqhd28ZVClG
         NDVIiG3v9u7xZUsI/c1zW8Op2nY4ImR5hHrbVIXKjbh3AhUWJjKBUun5hc4jk5M6whAH
         XohUicGhtRUkFJX5+lGP5KjRtM8AK0HfOk/5JreQGUPbXNDo0IaxOHgDftk2gatqvc28
         MxifB1DnuNVrochCNXSxYqoarvF5v0iZSGIiWU+RZF4ZkxVkv8H0uZaA3FArkHB2wh1N
         zNo5avGuoaprTtskjyY7JRz9BnJ+04L8/3li4c2c3ASaRx0txg3+0DmfnIF4Nu+Xx/QI
         7nfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fXkdUZpJKaU09VaQ11AXT4xG/p6acp3mSex2EZ+R/lU=;
        b=YtUVJGA8zZvrjMAJPaHpvN7K153ccV08nQCXos0b5aUtRkXMBcF87nTTpiDUf3k4gV
         2X8jk6ydL5SXHIRmGIntX94tkVIWZplu7WJMbiF7Ta55sd1FejtIISdnYotGRdvOpm6e
         IqrdgJ9o6tAYsw10mtAIyybEMq0sHCWaS1bVInIUbaqc79ciLqQ1MKiq54qU7iiVKi09
         lNHtKo1B1eYWy3pfIJjq9EgEzufzWUmzYHe+ZmvzOESFNMMsoRkaZurliBATABmrq2jK
         6Si26Ukn9ukmtItXStFi1kT5GNtuzgH1ZW9PGDh8aRBZURaZ2emImrjRZR3qgZ9bRFvB
         dAcw==
X-Gm-Message-State: AO0yUKXfSndm9BMi9budy8SilOhh4Gt58wdRXwM4yy5m79nLWWer6rph
        uBtg9h/hdDbKjZtcw69Je7yNkRgidNIIo8LYYKRFug==
X-Google-Smtp-Source: AK7set/109onC8O9mQ+fgqczof5Q1xgM8SjIoBSgBRTTXUGTsjg8B6X/1jkPbZEf5JSZ6RXqt3UYWPqhdy2n76KUnM0=
X-Received: by 2002:a5b:c41:0:b0:8f2:9e6:47a4 with SMTP id d1-20020a5b0c41000000b008f209e647a4mr2382178ybr.7.1677172714363;
 Thu, 23 Feb 2023 09:18:34 -0800 (PST)
MIME-Version: 1.0
References: <Y/T+pw25oGmKqz1k@nvidia.com> <Y/T/bkcYc9Krw4rE@slm.duckdns.org>
 <Y/UEkNn0O65Pfi4e@nvidia.com> <Y/UIURDjR9pv+gzx@slm.duckdns.org>
 <Y/Ua6VcNe/DFh7X4@nvidia.com> <Y/UfS8TDIXhUlJ/I@slm.duckdns.org>
 <Y/UiQmuVwh2eqrfA@nvidia.com> <87o7pmnd0p.fsf@nvidia.com> <Y/YRJNwwvqp7nKKt@nvidia.com>
 <87k009nvnr.fsf@nvidia.com> <Y/bHNO7A8T3QQ5T+@nvidia.com>
In-Reply-To: <Y/bHNO7A8T3QQ5T+@nvidia.com>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Thu, 23 Feb 2023 09:18:23 -0800
Message-ID: <CABdmKX18MY19bnsxN5W38Z9zmoaZx+S4+zzN_5XCYDBruwPrLg@mail.gmail.com>
Subject: Re: [PATCH 14/19] mm: Introduce a cgroup for pinned memory
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Alistair Popple <apopple@nvidia.com>, Tejun Heo <tj@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        jhubbard@nvidia.com, hannes@cmpxchg.org, surenb@google.com,
        mkoutny@suse.com, daniel@ffwll.ch,
        "Daniel P . Berrange" <berrange@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
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

On Wed, Feb 22, 2023 at 5:54 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Thu, Feb 23, 2023 at 09:59:35AM +1100, Alistair Popple wrote:
> >
> > Jason Gunthorpe <jgg@nvidia.com> writes:
> >
> > > On Wed, Feb 22, 2023 at 10:38:25PM +1100, Alistair Popple wrote:
> > >> When a driver unpins a page we scan the pinners list and assign
> > >> ownership to the next driver pinning the page by updating memcg_data and
> > >> removing the vm_account from the list.
> > >
> > > I don't see how this works with just the data structure you outlined??
> > > Every unique page needs its own list_head in the vm_account, it is
> > > doable just incredibly costly.
> >
> > The idea was every driver already needs to allocate a pages array to
> > pass to pin_user_pages(), and by necessity drivers have to keep a
> > reference to the contents of that in one form or another. So
> > conceptually the equivalent of:
> >
> > struct vm_account {
> >        struct list_head possible_pinners;
> >        struct mem_cgroup *memcg;
> >        struct pages **pages;
> >        [...]
> > };
> >
> > Unpinnig involves finding a new owner by traversing the list of
> > page->memcg_data->possible_pinners and iterating over *pages[] to figure
> > out if that vm_account actually has this page pinned or not and could
> > own it.
>
> Oh, you are focusing on Tejun's DOS scenario.
>
> The DOS problem is to prevent a pin users in cgroup A from keeping
> memory charged to cgroup B that it isn't using any more.
>
> cgroup B doesn't need to be pinning the memory, it could just be
> normal VMAs and "isn't using anymore" means it has unmapped all the
> VMAs.
>
> Solving that problem means figuring out when every cgroup stops using
> the memory - pinning or not. That seems to be very costly.
>
This is the current behavior of accounting for memfds, and I suspect
any kind of shared memory.

If cgroup A creates a memfd, maps and faults in pages, shares the
memfd with cgroup B and then A unmaps and closes the memfd, then
cgroup A is still charged for the pages it faulted in.

FWIW this is also the behavior I was trying to use to attribute
dma-buffers to their original allocators. Whoever touches it first
gets charged as long as the memory is alive somewhere.

Can't we do the same thing for pins?

> AFAIK this problem also already exists today as the memcg of a page
> doesn't change while it is pinned. So maybe we don't need to address
> it.
>
> Arguably the pins are not the problem. If we want to treat the pin
> like allocation then we simply charge the non-owning memcg's for the
> pin as though it was an allocation. Eg go over every page and if the
> owning memcg is not the current memcg then charge the current memcg
> for an allocation of the MAP_SHARED memory. Undoing this is trivial
> enoug.
>
> This doesn't fix the DOS problem but it does sort of harmonize the pin
> accounting with the memcg by multi-accounting every pin of a
> MAP_SHARED page.
>
> The other drawback is that this isn't the same thing as the current
> rlimit. The rlimit is largely restricting the creation of unmovable
> memory.
>
> Though, AFAICT memcg seems to bundle unmovable memory (eg GFP_KERNEL)
> along with movable user pages so it would be self-consistent.
>
> I'm unclear if this is OK for libvirt..
>
> > Agree this is costly though. And I don't think all drivers keep the
> > array around so "iterating over *pages[]" may need to be a callback.
>
> I think searching lists of pages is not reasonable. Things like VFIO &
> KVM use cases effectively pin 90% of all system memory, that is
> potentially TB of page lists that might need linear searching!
>
> Jason
