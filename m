Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A68E331CED2
	for <lists+cgroups@lfdr.de>; Tue, 16 Feb 2021 18:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhBPRRX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 16 Feb 2021 12:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbhBPRRS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 16 Feb 2021 12:17:18 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F5FC06174A
        for <cgroups@vger.kernel.org>; Tue, 16 Feb 2021 09:16:37 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id a22so12779698ljp.10
        for <cgroups@vger.kernel.org>; Tue, 16 Feb 2021 09:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E45USrfwyuPTU85r3q5N9FFFgs4PphB6lqH5aUk4Cag=;
        b=uKAmePCYTggNcKv8e6HwrE/wfBPlHBLs09fukIDn1Ad8eGiyXdq6UVoUHACc5UoJCE
         3zvOhCdBL7paJpiTVqgjW/9Ln+PbRjS+i/9EK2u5XKpZQ8iRUEu1fvlDnBpoENJ61vJV
         xamLT1E0WOt/77sNcTXjJxBpkwIl5RrePfmtw0KFg2DKLqob1a4wdYxNfEB6iY+zZQLh
         T73T2gxzFEIfdIthKZ+fVjxhiCYxIDTziJVgXH7GQiAJOCvGXQZK0xyN017joVbw4A0I
         vLlIr+HnHG9caI+/8IiRynC1jQ7pDqyTTR8CIPFBsuFA8z4k9Hp5BTpdMneZU8Fsi1uF
         2WVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E45USrfwyuPTU85r3q5N9FFFgs4PphB6lqH5aUk4Cag=;
        b=ksQbcy+zZiC/XrC0N+nsaEyaXDFLZgkYt2q0FeScByIDlDvDP/jU1ADBVCWCgq4HOZ
         wtPITPaYv9wS0IphMffs5Zftsyt5VEaNdJejRfxybeordLf0YA0V1kvylSbTNTVcyzbk
         5rgSYKmcB8gWHq2rfRkrW67nYHICnTNC7npZ6tYndbDrv0Ylp4jy8pB6KrHPa7DgKF1c
         qxTtAIZqg0G1FUEkqA/NZXcmgKln824uA1IHTFVgeN3chfBcg7uyJ9lBozzmnbPKnPKk
         PH/UHuhjwzcXtAeeZrzzlo4oZ9RdMc6Fygd/UfRLf9u25JUYtMbnceD4pq8ChMT5b4qR
         mmBw==
X-Gm-Message-State: AOAM532dKvmnTIFTzWJYRfZ3bZzprevT2G+wG1mS0tOKLPxbvNsShIho
        0iuxtHuXXxhTW1pK3piZ7shKyYiwIvRXlXRoc2q4qA==
X-Google-Smtp-Source: ABdhPJwjYb7W4T0wg5Hy1MX2CVcAVbqrij6GPD2ReASzI+sXBNljFD1GbZ8juc2sgDG5QDu7KhRrecY1CRdwaSiFg6E=
X-Received: by 2002:a2e:9806:: with SMTP id a6mr12304184ljj.456.1613495795934;
 Tue, 16 Feb 2021 09:16:35 -0800 (PST)
MIME-Version: 1.0
References: <20210212170159.32153-1-songmuchun@bytedance.com>
 <20210212170159.32153-4-songmuchun@bytedance.com> <CALvZod6tXn9qrRmzyspp+7usB-Xx4ayu6KrzmKvoU7zWajx85g@mail.gmail.com>
 <CAMZfGtUpsbiVW7AtBtfYjFvppv+7MmAcff_x872gbeMuv8zs3Q@mail.gmail.com>
In-Reply-To: <CAMZfGtUpsbiVW7AtBtfYjFvppv+7MmAcff_x872gbeMuv8zs3Q@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 16 Feb 2021 09:16:24 -0800
Message-ID: <CALvZod4mjDPfRvs0EZw3nZW8TuZqvye61ExD98Qfpm9JtsbGtg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 4/4] mm: memcontrol: fix swap uncharge on
 cgroup v2
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Huang Ying <ying.huang@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Feb 12, 2021 at 10:48 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> On Sat, Feb 13, 2021 at 2:57 AM Shakeel Butt <shakeelb@google.com> wrote:
> >
> > CCing more folks.
> >
> > On Fri, Feb 12, 2021 at 9:14 AM Muchun Song <songmuchun@bytedance.com> wrote:
> > >
> > > The swap charges the actual number of swap entries on cgroup v2.
> > > If a swap cache page is charged successful, and then we uncharge
> > > the swap counter. It is wrong on cgroup v2. Because the swap
> > > entry is not freed.
> > >
> > > Fixes: 2d1c498072de ("mm: memcontrol: make swap tracking an integral part of memory control")
> > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> >
> > What's the user visible impact of this change?
>
> IIUC, I think that we cannot limit the swap to memory.swap.max
> on cgroup v2.
>
>   cd /sys/fs/cgroup/
>   mkdir test
>   cd test
>   echo 8192 > memory.max
>   echo 4096 > memory.swap.max
>
> OK. Now we limit swap to 1 page and memory to 2 pages.
> Firstly, we allocate 1 page from this memory cgroup and
> swap this page to swap disk. We can see:
>
>   memory.current: 0
>   memory.swap.current: 1
>
> Then we touch this page, we will swap in and charge
> the swap cache page to the memory counter and uncharge
> the swap counter.
>
>   memory.current: 1
>   memory.swap.current: 0 (but actually we use a swap entry)
>
> Then we allocate another 1 page from this memory cgroup.
>
>   memory.current: 2
>   memory.swap.current: 0 (but actually we use a swap entry)
>
> If we swap those 2 pages to swap disk. We can charge and swap
> those 2 pages successfully. Right? Maybe I am wrong.
>

I was trying to repro this but couldn't and later remembered that swap
on zram skips the swapcache and thus is not impacted by this issue.
This is reproducible on swap on disk and I see Johannes has already
described in good detail.
