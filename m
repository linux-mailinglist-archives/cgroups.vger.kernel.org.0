Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1D5231154E
	for <lists+cgroups@lfdr.de>; Fri,  5 Feb 2021 23:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbhBEW2H (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 5 Feb 2021 17:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbhBEOVT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 5 Feb 2021 09:21:19 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3437C061794
        for <cgroups@vger.kernel.org>; Fri,  5 Feb 2021 07:58:52 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id y17so6189695ili.12
        for <cgroups@vger.kernel.org>; Fri, 05 Feb 2021 07:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k4OJLV6TXS1KdESPsSN5ElFkZKiwedSKAnd29KVc8KM=;
        b=1aw6G8+TFmecyaEdtijZI3sTpYEbc4iqst6CcMnq1bl2fPTIIjZ71I95liyMaaTEdM
         njh8wvV/aPJZI3cAQlg8pI9VCAHNZHuKLMhrGZmIjboD1TagcPOdprngYyDCsor7ncGs
         09+hFnX+T6ilxBP80u7+mkj2cilveG/6G+QwnlTtFDjDdpovBSaSLZ5qNqIrefNiphby
         VSTGt1n3cYWec6DxUohkn8BjxwrXVLyOVle+kB8wOWx2v7YAVSkSqbzliKdWClAuWPGV
         kqYy8HcxH7eYR3EvDfoIV5Amdw10sOwcttGJzzYnP2+3KWpVN8cAZGNfh6fikwGVHRSY
         VcsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k4OJLV6TXS1KdESPsSN5ElFkZKiwedSKAnd29KVc8KM=;
        b=ol/JA1lUB8b/RjBftEOFTbpBE6irSYwOQlCOlzNkLvo4xJJW06bwYyzXDl3v+BPXjG
         7xB6/VTMyEKWl8wlJ8zCkfLoyASTKzn+DwFMj84ZBLm6yHFp5HxxvKHrY7PNJFvNvhLs
         Ncnhf4Xz/QeoEIYvIi5T5WGzoaSoA9xdIvNfY1bWAFe2SMIuX4V8Zbr7WYdphBJmTX0t
         rI8xodIjmvXJUlCzWq4s5m9iTt9zc0g8VKATUcWNNIzFFi1f37ASHLGwvJcNwUHdaoFX
         mYeewU2Od2d/iM//VDUDMFik0ThMZjDyif0oEJdmwUVX1zxO4rVOAW8Et1zV2oVW4/6o
         T/Yw==
X-Gm-Message-State: AOAM533cgTWxLAsayqmNiW3I0qkClwOiXGvRSISEZsHg7Habmwmh9Lgz
        SjwVohgwpABfIsLMiIPmk29WI8fPgzfr/Y8jWY07Hlz/IsPnCQ==
X-Google-Smtp-Source: ABdhPJwhULqIS5l4qL1BjXkv2y/zKC3UJe21U6D62vItTdYaESCfEqvoP5XrUuqj+ZBAH5RcV/hzjTced12oZpPUHhQ=
X-Received: by 2002:a63:de0e:: with SMTP id f14mr4752501pgg.273.1612539072639;
 Fri, 05 Feb 2021 07:31:12 -0800 (PST)
MIME-Version: 1.0
References: <20210205062310.74268-1-songmuchun@bytedance.com>
 <YB0Ay+epP/hnFmDS@dhcp22.suse.cz> <CAMZfGtWKNNhc1Jy1jzp2uZU_PM6GNWup7d=yUVk9AehKFo_CRw@mail.gmail.com>
 <YB0cO7R1WtJgAxI2@dhcp22.suse.cz> <CAMZfGtXXjXKoxbOSB9h6JvgZKEGBh2sCf34usJXcBXxGjU6k0w@mail.gmail.com>
 <YB04B1gMdE/B3G9c@dhcp22.suse.cz>
In-Reply-To: <YB04B1gMdE/B3G9c@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 5 Feb 2021 23:30:36 +0800
Message-ID: <CAMZfGtVBPdWUG6MuGcFt7A_Xr1zCJj-gnE0pKyhyJAy6bSSgnw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: memcontrol: fix missing wakeup oom task
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Feb 5, 2021 at 8:20 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Fri 05-02-21 19:04:19, Muchun Song wrote:
> > On Fri, Feb 5, 2021 at 6:21 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Fri 05-02-21 17:55:10, Muchun Song wrote:
> > > > On Fri, Feb 5, 2021 at 4:24 PM Michal Hocko <mhocko@suse.com> wrote:
> > > > >
> > > > > On Fri 05-02-21 14:23:10, Muchun Song wrote:
> > > > > > We call memcg_oom_recover() in the uncharge_batch() to wakeup OOM task
> > > > > > when page uncharged, but for the slab pages, we do not do this when page
> > > > > > uncharged.
> > > > >
> > > > > How does the patch deal with this?
> > > >
> > > > When we uncharge a slab page via __memcg_kmem_uncharge,
> > > > actually, this path forgets to do this for us compared to
> > > > uncharge_batch(). Right?
> > >
> > > Yes this was more more or less clear (still would have been nicer to be
> > > explicit). But you still haven't replied to my question I believe. I
> > > assume you rely on refill_stock doing draining but how does this address
> > > the problem? Is it sufficient to do wakeups in the batched way?
> >
> > Sorry, the subject title may not be suitable. IIUC, memcg_oom_recover
> > aims to wake up the OOM task when we uncharge the page.
>
> Yes, your understanding is correct. This is a way to pro-actively wake
> up oom victims when the memcg oom handling is outsourced to the
> userspace. Please note that I haven't objected to the problem statement.
>
> I was questioning the fix for the problem.
>
> > I see uncharge_batch always do this. I am confused why
> > __memcg_kmem_uncharge does not.
>
> Very likely an omission. I haven't checked closely but I suspect this
> has been introduced by the recent kmem accounting changes.
>
> Why didn't you simply do the same thing and call memcg_oom_recover
> unconditionally and instead depend on the draining? I suspect this was
> because you wanted to recover also when draining which is not necessary
> as pointed out in other email.

Thanks for your explanations. You are right. It is my fault to depend
on the draining. I should call memcg_oom_recover directly in the
__memcg_kmem_uncharge. Right?

>
> [...]
> > > > > Does this lead to any code generation improvements? I would expect
> > > > > compiler to be clever enough to inline static functions if that pays
> > > > > off. If yes make this a patch on its own.
> > > >
> > > > I have disassembled the code, I see memcg_oom_recover is not
> > > > inline. Maybe because memcg_oom_recover has a lot of callers.
> > > > Just guess.
> > > >
> > > > (gdb) disassemble uncharge_batch
> > > >  [...]
> > > >  0xffffffff81341c73 <+227>: callq  0xffffffff8133c420 <page_counter_uncharge>
> > > >  0xffffffff81341c78 <+232>: jmpq   0xffffffff81341bc0 <uncharge_batch+48>
> > > >  0xffffffff81341c7d <+237>: callq  0xffffffff8133e2c0 <memcg_oom_recover>
> > >
> > > So does it really help to do the inlining?
> >
> > I just think memcg_oom_recover is very small, inline maybe
> > a good choice. Maybe I am wrong.
>
> In general I am not overly keen on changes without a proper
> justification. In this particular case I would understand that a
> function call that will almost never do anything but the test (because
> oom_disabled is a rarely used) is just waste of cycles in some hot
> paths (e.g. kmem uncharge). Maybe this even has some visible performance
> benefit. If this is really the case then would it make sense to guard
> this test by the existing cgroup_subsys_on_dfl(memory_cgrp_subsys)?

Agree. I think it can improve performance when this
function is inline. Guarding the test should be also
an improvement on cgroup v2.


> --
> Michal Hocko
> SUSE Labs
