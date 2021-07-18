Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97EA83CCAD1
	for <lists+cgroups@lfdr.de>; Sun, 18 Jul 2021 23:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhGRV3A (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 18 Jul 2021 17:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbhGRV3A (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 18 Jul 2021 17:29:00 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06976C061764
        for <cgroups@vger.kernel.org>; Sun, 18 Jul 2021 14:26:01 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id x192so24521941ybe.6
        for <cgroups@vger.kernel.org>; Sun, 18 Jul 2021 14:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eGxqoewCd9mhFWgt/ehslfj46aucbxn1D+/d7qW9O88=;
        b=df57gXl4ZzkvkZyhsxlQQF7U9VmDfcRkVljcTPIjcrGf37NyTgxTFZj+G8Ml/mTcxY
         RWsy0tqZSs/6kHR/mBrtERPFADvucC9akxtOwz0tT6148Jcd17t8RO8z3HO2oq2tjUov
         +9vXOGMPkWXu7QOoq0jdSSZarSP4I+AKB6NbEwcpIo/Qz1hRh/qFwfp1UqcXA4ZlxZ+H
         HHRjqBSPiDlOVEWVdDP5CqreuQEUyppyddaR640otpripVPHT/1+VYieLA5Ojndsc22c
         xUN/nyK8EMwWKZbpOpXdrjfIYiAqT3jgGe/MyQ4uxM2svHfA5luxO3V/y1NbB0Ri9JRJ
         /yYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eGxqoewCd9mhFWgt/ehslfj46aucbxn1D+/d7qW9O88=;
        b=kzzrRQlSrGfwaHVim6XDzXW1fUGkxK/9aPgv2aAZCb95QkXADMSsDrARQC8Peq39kV
         HIeSfjf8T0U2Iaoylufz8hGuU75wWN0m1ZD9GZA4TM4TpaNvJuuUN0nUrksWFUsdkbK7
         r2vRcH1FAFrJgEoV2H3Harqv+50dWRHWWC9TZ7fDyPQ3XcZ8Gt3OrED/UWp1InYHnQGg
         xVg2VsUOXGC5fn0CVxH/Ia7wU1MmgeODMcqFHHD2TgCl8+nHkv3RfKxY6cHKnEQ2yt/M
         Nr4DrOOIvbcLbx3bkoZwS8mNfmrB132fLAQjRk9ZnTS55grAZMMMQ7iihWstnM4Ucp3m
         5B3Q==
X-Gm-Message-State: AOAM532jxHkIs6gy3P4NkzLy+2pGJPbVPUaT+SLscTLvblDrcK2pQvZl
        zYtcl63uoJQbwTlJ+UgsbfAcf24d6Dwi1jNoNkbhGw==
X-Google-Smtp-Source: ABdhPJzG/WkV228ZnkTQT7/9F5qD3UkoOrEL3ZDcaj1Q5ZR1yH1Ha91RDJq+ac4aRtYMNYmL0XXBbhg3846E9AuIQPo=
X-Received: by 2002:a25:83ca:: with SMTP id v10mr27596137ybm.84.1626643560918;
 Sun, 18 Jul 2021 14:26:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210710003626.3549282-1-surenb@google.com> <20210710003626.3549282-2-surenb@google.com>
 <YPRdH56+dOFs/Ypu@casper.infradead.org>
In-Reply-To: <YPRdH56+dOFs/Ypu@casper.infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Sun, 18 Jul 2021 14:25:50 -0700
Message-ID: <CAJuCfpFNXmH3gQ51c-+3U_0HPG401dE9Mp9_hwMP67Tyg-zWGg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] mm, memcg: inline mem_cgroup_{charge/uncharge} to
 improve disabled memcg config
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Yang Shi <shy828301@gmail.com>, Alex Shi <alexs@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Hildenbrand <david@redhat.com>, apopple@nvidia.com,
        Minchan Kim <minchan@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Jul 18, 2021 at 9:56 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Jul 09, 2021 at 05:36:25PM -0700, Suren Baghdasaryan wrote:
> > @@ -6723,7 +6722,7 @@ static int __mem_cgroup_charge(struct page *page, struct mem_cgroup *memcg,
> >  }
> >
> >  /**
> > - * mem_cgroup_charge - charge a newly allocated page to a cgroup
> > + * __mem_cgroup_charge - charge a newly allocated page to a cgroup
> >   * @page: page to charge
> >   * @mm: mm context of the victim
> >   * @gfp_mask: reclaim mode
>
> This patch conflicts with the folio work, so I'm just rebasing the
> folio patches on top of this, and I think this part of the patch is a
> mistake.  We don't want to document the __mem_cgroup_charge() function.
> That's an implementation detail.  This patch should instead have moved the
> kernel-doc to memcontrol.h and continued to document mem_cgroup_charge().

Ack.
There was a v4 version of this patch:
https://lore.kernel.org/patchwork/patch/1458907 which was picked up by
Andrew already. If others agree that documentation should be moved
into the header file then I'll gladly post another version. Or I can
post a separate patch moving the documentation only. Whatever works
best. Andrew, Michal, Johannes, WDYT?
